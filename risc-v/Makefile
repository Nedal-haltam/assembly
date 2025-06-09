
build: clean
	riscv64-linux-gnu-as -o main.o main.S
	riscv64-linux-gnu-ld -o main main.o

run:
	qemu-riscv64 ./main

clean:
	rm -rf main.o
	rm -rf main