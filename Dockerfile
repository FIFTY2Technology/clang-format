FROM ubuntu:18.10

RUN  apt-get update && \
     apt-get install -y --no-install-recommends wget gnupg software-properties-common && \
     wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
     apt-add-repository "deb http://apt.llvm.org/cosmic/ llvm-toolchain-cosmic-7 main" && \
     apt-get update && \
     apt-get install -y --no-install-recommends clang-format-7 && \
     apt-get -y --purge remove wget gnupg software-properties-common && \
     apt autoremove -y && \
     rm -rf /var/lib/apt/lists/*