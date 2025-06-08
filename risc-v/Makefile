
build:
	riscv64-unknown-elf-as -o main.o main.S
	riscv64-unknown-elf-ld -o main main.o

run:
	qemu-riscv64 ./main