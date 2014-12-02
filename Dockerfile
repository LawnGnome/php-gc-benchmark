FROM ubuntu:trusty

# Get a sane build environment.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && apt-get -y install curl build-essential git && apt-get -y build-dep php5
RUN mkdir /source && cd /source && curl http://ftp.gnu.org/gnu/bison/bison-2.7.tar.xz | tar Jxv && cd bison-2.7 && ./configure --program-suffix=-2.7 && make -j4 install
ENV YACC /usr/local/bin/bison-2.7

# Set up PHP.
RUN cd /source && git clone https://github.com/php/php-src.git master
RUN cd /source/master && git remote add beberlei https://github.com/beberlei/php-src.git && git remote add LawnGnome https://github.com/LawnGnome/php-src.git && git fetch beberlei && git fetch LawnGnome
RUN cd /source && bash /usr/share/doc/git/contrib/workdir/git-new-workdir master gc-timing && cd gc-timing && git checkout GCTiming
RUN cd /source && bash /usr/share/doc/git/contrib/workdir/git-new-workdir master gc-fn-pointer && cd gc-fn-pointer && git checkout gc-fn-pointer

# Build it.
RUN cd /source/master && ./buildconf && ./configure --prefix=/opt/php/master --disable-all && make -j4 install
RUN cd /source/gc-timing && ./buildconf && ./configure --prefix=/opt/php/gc-timing --disable-all && make -j4 install
RUN cd /source/gc-fn-pointer && ./buildconf && ./configure --prefix=/opt/php/gc-fn-pointer --disable-all && make -j4 install

# Build an extension that can report on the total time from the gc-timing
# branch (this provides a sanity check on whether GC runs occurred at all).
ADD timing /source/ext/timing
RUN cd /source/ext/timing && PATH=/opt/php/gc-timing/bin:$PATH /opt/php/gc-timing/bin/phpize && PATH=/opt/php/gc-timing/bin:$PATH ./configure && make -j4 install

# Add the test cases.
ADD tests /source/tests
ADD bin /source/bin

CMD /opt/php/master/bin/php /source/bin/run-tests.php
