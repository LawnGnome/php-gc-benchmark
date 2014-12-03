# php-gc-benchmark

Benchmarking different approaches to PHP GC instrumentation.

## Contents

* `bin`: wrapper script for the Docker container that runs any tests and averages run times.
* `tests`: PHP scripts that (hopefully) exercise the GC.
* `timing`: a small extension that can be built against the `beberlei:GCTiming` php-src branch and will dump out some GC statistics on `RSHUTDOWN`. (This is similar to compiling PHP with `-DGC_BENCH`, but easier to handle at runtime.)

## Building with Docker

I've included a Dockerfile that will build a container that includes each PHP version we want to test, then run all the tests. You can build it thusly:

    docker build -t gc-benchmark .
    # Wait a while.
    docker run --rm gc-benchmark
    
You can also run the tests by hand, of course.
