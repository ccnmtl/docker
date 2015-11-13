# docker

Utility dockerfiles for building and running our other
applications. These support a separated build + run workflow. Roughly
based on what Glyph describes
[here](https://glyph.twistedmatrix.com/2015/03/docker-deploy-double-dutch.html),
but modified to suit some of our existing conventions and needs.

## ccnmtl/django.base

General, all-purpose django base image. Based on Ubuntu 14.04. Both
the `django.build` and any run containers use it as a base.

## ccnmtl/django.build

Wheel building image. To use it, cd into a django project directory
that has a `requirements.txt` and something like the following:

    $ mkdir -p wheelhouse
    $ docker run --rm \
	    -v $(pwd):/app \
        -v $(pwd):/wheelhouse:/wheelhouse \
        ccnmtl/django.build

The result should be that you have a `wheelhouse` directory populated
with linux x64 wheels of every package specified in your
`requirements.txt`. This is suitable to then install into a run
container which has no development tools installed (other than
pip/virtualenv).

I also recommend just having a `Makefile` in your project with the
following contents:

    ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
    
    # use wheelhouse/requirements.txt as the sentinal so make
    # knows whether it needs to rebuild the wheel directory or not
    # has the added advantage that it can just pip install
    # from that later on as well
    wheelhouse/requirements.txt: requirements.txt
    	mkdir -p wheelhouse
    	docker run --rm \
    	-v $(ROOT_DIR):/app \
    	-v $(ROOT_DIR)/wheelhouse:/wheelhouse \
    	ccnmtl/django.build
    	cp requirements.txt wheelhouse/requirements.txt
    	touch wheelhouse/requirements.txt
    
    build: wheelhouse/requirements.txt
    	docker build -t ccnmtl/sample .

Then you can just do `make build` and it will be smart enough to not
re-run that step if your requirements haven't changed since the last
time it was run.

## ccnmtl/django.sample

Finally, you'll want to build the run image for your application from
a Dockerfile something like this sample one. It pulls in the
`wheelhouse` directory with all the wheels that the builder built and
installs them into a virtualenv (requiring no network access). Then it
brings in the rest of the application, runs the tests inside the
container, exposes ports, etc.
