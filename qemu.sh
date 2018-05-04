pushd .
cd kernel
make curiosity.bin
qemu-system-i386 -kernel curiosity.bin
make clean
popd