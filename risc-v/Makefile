

main: dummy
	riscv64-linux-gnu-gcc -o main main.S -static
	qemu-riscv64 ./main

examples: dummy
	riscv64-linux-gnu-gcc -o ./examples/basic ./examples/basic.S -static
	qemu-riscv64 ./examples/basic
	riscv64-linux-gnu-gcc -o ./examples/misc ./examples/misc.S -static
	qemu-riscv64 ./examples/misc
	riscv64-linux-gnu-gcc -o ./examples/gol ./examples/gol.S -static
	qemu-riscv64 ./examples/gol


dummy:

clean:
	rm -rf main.o
	rm -rf main