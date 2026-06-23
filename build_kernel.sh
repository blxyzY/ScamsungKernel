#!/bin/bash

        export TC=$HOME/clang-11
        export GCC=$HOME/gcc

        # Setup Compiler & Toolchain Path
        export CROSS_COMPILE=$GCC/bin/aarch64-linux-android-
        export CROSS_COMPILE_ARM32=$GCC/bin/arm-linux-androideabi-
        export LD=$TC/bin/ld.lld
        export OBJCOPY=$TC/bin/llvm-objcopy
        export AS=$TC/bin/llvm-as
        export NM=$TC/bin/llvm-nm
        export STRIP=$TC/bin/llvm-strip
        export OBJDUMP=$TC/bin/llvm-objdump
        export READELF=$TC/bin/llvm-readelf
        export CC=$TC/bin/clang
        export CLANG_TRIPLE=aarch64-linux-gnu-
        export ARCH=arm64

        export KCFLAGS=-w
        export CONFIG_SECTION_MISMATCH_WARN_ONLY=y

        # Clean up
        make -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y clean && make -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y mrproper
        clear

        # Configure & Build
        make -s -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y vendor/a23_open_eur_defconfig
        make -s -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc)

        # Copy Output
        cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
