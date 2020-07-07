# Copyright 2020 rowit Ltd.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################
# This is an example bash script that takes 3 parameters:
# 1. The URL of the domain that is signing the files.
# 2. The path to the private key that coresponds to the URL in (1).
# 3. A path to a single file to be signed.
# 
# Once the file is signed it will upload the hash and signature to the
# umpint.com servers to allow users to authenticate at a later date.
#
# It will finally print out the result detailing status of the file it 
# signed.


if [ "$#" -ne 3 ]; then
  echo "Please pass 3 arguments:"
  echo "url certificatePrivateKeyPath filename"
  exit 1
fi

url=$1
privateKey=$2
file=$3

if [ ! -r $privateKey ]; then
  echo "could not read cerfiticate Private Key : [$privateKey]"
  exit 2
fi

grep "\-\-\-\-\-BEGIN PRIVATE KEY\-\-\-\-\-" $privateKey 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "key did on contain -----BEGIN PRIVATE KEY----- as expected - check format"
  exit 3
fi
grep "\-\-\-\-\-END PRIVATE KEY\-\-\-\-\-" $privateKey 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "key did on contain -----END PRIVATE KEY----- as expected - check format"
  exit 4
fi

if [ ! -r $file ]; then
  echo "could not read file to sign : [$file]"
  exit 5
fi

# Compute has of file and store as Hex String (will no \n at the end in a file).
sha256sum $file | awk '{print $1}' | tr -d '\n' > /tmp/hash.$$.txt
# Sign the digest of the file containing the hash.
openssl dgst -sha256 -sign $privateKey -out /tmp/sign.$$.bin /tmp/hash.$$.txt
# Convert the binary signature into a base64 encoded string
openssl base64 -in /tmp/sign.$$.bin -out /tmp/sign.$$.txt
# read hash into variable
hash=`cat /tmp/hash.$$.txt`
# url encode the base64 string
sig=`cat /tmp/sign.$$.txt | tr -d '\n' | tr -- '+=/' '-_~'| sed -e 's/ //g'`

echo "sending - hash [$hash] sig [$sig]"
echo ""
echo "Result:"
# Send the hash and signature to the umping.com servers.
curl "https://umpint.com/api/v1/sign/${url}?hash=${hash}&sig=${sig}"
echo ""
rm /tmp/hash.$$.txt /tmp/sign.$$.txt /tmp/sign.$$.bin
