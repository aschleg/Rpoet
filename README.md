# Rpoet - R wrapper for the PoetryDB API

[![Build Status](https://travis-ci.org/aschleg/Rpoet.svg?branch=master)](https://travis-ci.org/aschleg/Rpoet)
[![Build status](https://ci.appveyor.com/api/projects/status/7tydn9veo15s77a1?svg=true)](https://ci.appveyor.com/project/aschleg/rpoet)
[![codecov](https://codecov.io/gh/aschleg/Rpoet/branch/master/graph/badge.svg)](https://codecov.io/gh/aschleg/Rpoet)

`Rpoet` is a wrapper of the [PoetryDB API](http://poetrydb.org) that enables users to access the PoetryDB through an R interface. 

## Installation

`Rpoet` is most easily installed through `install.packages`.

~~~ r
install.packages('Rpoet')
~~~

The package can also be installed through the `devtools` function `install_github`:

~~~ r
devtools::install_github('aschleg/Rpoet')
~~~

## Documentation

* Rpoet Reference Manual
  - The API manual as a PDF available on CRAN.
* Introduction to Rpoet
  - A short vignette that introduces the primary functionality of the package.
* [PoetryDB API Documentation](https://github.com/thundercomb/poetrydb/blob/master/README.md) 
  - Includes further information on the design and implementation of the PoetryDB database with MongoDB.

## About PoetryDB

[PoetryDB](http://poetrydb.org) was created and is currently maintained by [@thundercomb](https://twitter.com/thundercomb). They blog about poetry and related technology and other topics at [thecombedthunderclap.blogspot.com](http://thecombedthunderclap.blogspot.com/). 

Please note, I am in no way affiliated with the creator of PoetryDB. My intention with `Rpoet` is to help spread the word and hopefully increase interest in poetry and related projects that attempt to create a comprehensive databases of publicly available knowledge.
