FROM python:3.8-alpine

RUN apk add --no-cache bash
CMD ["/bin/bash"]

RUN apk add --no-cache git

ARG VER=10
ARG BRANCH=release/10.x

RUN /bin/sh -c set -x \
    && apk add --no-cache --virtual build-deps git cmake ninja g++\
    && git clone --depth 1 --branch $BRANCH https://github.com/llvm/llvm-project.git /src \
    && test $VER -eq $(fgrep -m1 'set(LLVM_VERSION_MAJOR' /src/llvm/CMakeLists.txt | tr -dc '0-9') \
    && ln -s ../../clang /src/llvm/tools/ \
    && mkdir /src/llvm/_build \
    && cd /src/llvm/_build \
    && cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-static-libgcc" -DCMAKE_CXX_FLAGS="-static-libgcc -static-libstdc++" \
    && ninja clang-format \
    && strip bin/clang-format \
    && cp bin/clang-format /usr/bin/ \
    && rm -rf /src \
    && apk del build-deps
	

ENTRYPOINT [""]