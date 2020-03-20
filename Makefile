CFLAGS += -g -O0 -Wall -Wstrict-prototypes

# snapcraft will copy anything from here
INSTALL_DIR := $(SNAPCRAFT_PART_INSTALL)

.PHONY: env-check clean

all: sem-open-preload.so sem-open-preload-launch

sem-open-preload.so: sem-open-preload.c
	${CC} \
		${CFLAGS} -fPIC -shared \
		${LDFLAGS} sem-open-preload.c \
		-o $@ -ldl

install: sem-open-preload.so sem-open-preload-launch
	mkdir -p ${INSTALL_DIR}
	install -D sem-open-preload.so ${INSTALL_DIR}/sem-open-preload.so
	install -D sem-open-preload-launch ${INSTALL_DIR}/sem-open-preload-launch

clean:
	rm -f \
		./sem-open-preload.so
