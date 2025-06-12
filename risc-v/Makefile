
build: clean
	riscv64-linux-gnu-gcc -o main main.S -static

run:
	qemu-riscv64 ./main

clean:
	rm -rf main.o
	rm -rf main