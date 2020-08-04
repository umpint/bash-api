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
#
# This is an example bash script that takes 3 parameters:
# 1. The URL of the domain that is signing the files.
# 2. The path to the private key that coresponds to the URL in (1)
# 3. A path to a directory that contains a list of files to be signed
# 
# It will then upload all the hashes and signature to the umpint.com 
# servers.
#
# It will finally print out a JSON result detailing status of each file 
# it tried to sign and upload.

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
  echo "This script gets the results of an async batch upload"
  echo "Please pass 1 or 2 arguments:"
  echo "uuid [batchId]"
  echo ""
  echo "uuid is the id returned when the initial upload was done"
  echo "batchid is optional and is between 1 and the number of batches"
  exit 1
fi

uuid=$1
if [ "$#" -eq 2 ];then
	batchid="/$2"
fi

echo "Result:"
curl "https://umpint.com/api/v1/resultasync/$uuid$batchid"
echo ""
