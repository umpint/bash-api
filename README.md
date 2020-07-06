# umpint.com - Bash Example API

Bash API example to umpint.com document signing service.
This could be used in production as is reasonable fast.
But also great way to understand the API if you want to connect from a programming language that is not currently supported.

## Getting Started

Just clone this project. Then can run the sign.sh to sign just one document. Or use the batch-sign.sh to sign every document in a directory. The batch-sign.sh is much faster as will only send one request to our server with all the request contained in it.

### Prerequisites

These scripts should work on any standard UNIX/Linux host. Only relies on:
1) sha256sum
2) openssl
3) curl

As long as these are installed on your host and in the path these scripts should work.

Only other requirements are that you need access to umpint.com over the internet to send the data. And you need access to the private key of the certificate of the domain you want to sign for.

### Installing

```
git clone https://github.com/umpint/bash-api.git
cd bash-api
```

### Running

We have at dummybank.rowit.co.uk a dummy site you can use for testing. Since we only use if for testing we allow you to download the Certificate Private Key. Nobody should normally every allow this - as makes https pointless.

You can download from: dummybank.rowit.co.uk/key.pem 

Note this file changes every few months so you may have to download again if you start getting certificate errors.

Place this file in the bash-api directory.

To sign an individual file run:
```
# 1st edit the file testfile.sh and make random change to it so it is unique
./single.sh dummybank.rowit.co.uk ./key.pem testfile.sh
```

you should then see output like this:

```
sending - hash [2804fbcd69ab84e985955431a5dcdb20b0d999be2bf9e90280cdf030e94c15dc] sig [eJjT99Tm52IDe8s~K9agRvTz2t7EmJYWjV5pOGyUEaAg4m8XZXmyg5fPbN7hFK64SHKIcdLheovr4-svsqx6USlr0rsaZODAAZ8Nv4habUIw~cZgVQ1adKjeF4lEqVUBlcepYbukkiI1dLs2dOgBunVBaLXY8POrTCKrFNEcw5udwGC~hUUTvKKxGYwFU3sn3mCCZQIReQ57UjFBJ7rScJaRAqJdfQSzEbqs9Zz-byUEYLEfqYdXLePzrryDqT3~SmxmhnsLKBHzBpYXY630D92ZETqTj1yuGy57LIk0SbC9OXetYWKzDI4JeWk0TSh77aPUc2UPT5ncQzlNeYlrWg__]
signed OK dummybank.rowit.co.uk 2804fbcd69ab84e985955431a5dcdb20b0d999be2bf9e90280cdf030e94c15dc eJjT99Tm52IDe8s/K9agRvTz2t7EmJYWjV5pOGyUEaAg4m8XZXmyg5fPbN7hFK64SHKIcdLheovr4+svsqx6USlr0rsaZODAAZ8Nv4habUIw/cZgVQ1adKjeF4lEqVUBlcepYbukkiI1dLs2dOgBunVBaLXY8POrTCKrFNEcw5udwGC/hUUTvKKxGYwFU3sn3mCCZQIReQ57UjFBJ7rScJaRAqJdfQSzEbqs9Zz+byUEYLEfqYdXLePzrryDqT3/SmxmhnsLKBHzBpYXY630D92ZETqTj1yuGy57LIk0SbC9OXetYWKzDI4JeWk0TSh77a 
```

The "signed OK" signifies that the signature was correct and it was a new file.

If instead you see "duplicate already in db" this just means that you probably did not change the "testfile.sh" or have upload the file twice and so we already had a signature in the database. To fix this issue just change the file in some way.

The batch_sign.sh is used in exactly the same way. Only difference is that the last perameter is the path to a directory. And all the files will be signed in one call to the umpint.com API.

## Contributing

TODO

## Authors

* **Robin Owens** - *Initial work* - [Umpint](https://github.com/Umpint)

## License

This project is licensed under the Apache License, Version 2.0 - see the [LICENSE-2.0.txt](LICENSE-2.0.txt) file for details

## Acknowledgments

* People who wrote OpenSSL!
