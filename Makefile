CFLAGS := -Wall -g
LIBS := -lm
SRC := fpc.c main.c
OBJS := $(patsubst %.c, %.o, $(SRC))
CONVERT_LIBS := -lm
CONVERT_SRC := convert.c
CONVERT_OBJS := $(patsubst %.c, %.o, $(CONVERT_SRC))

.PHONY: all
all: test

fpc: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $@

convert: $(CONVERT_OBJS)
	$(CC) $(CONVERT_OBJS) $(LIBS) -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $*.c

.PHONY: test_output
test_output:
	./tests.sh &> test_output.txt

.PHONY: test
test: fpc
	./tests.sh 2>&1 | diff -U 3 test_output.txt -

.PHONY: clean
clean:
	rm -f fpc
	rm -f $(OBJS)
	rm -f convert
	rm -f $(CONVERT_SRC)
	rm -f $(CONVERT_OBJS)
