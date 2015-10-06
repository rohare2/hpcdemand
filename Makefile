#$Id: Makefile 1116 2011-08-25 03:53:15Z rohare $
#$HeadURL: https://restless/svn/scripts/trunk/Makefile $
#
BIN_DIR= /usr/local/bin

SBIN_DIR= /usr/local/sbin

BIN_FILES= hpcd

SBIN_FILES= hpcdd

FILES= ${BIN_FILES} ${SBIN_FILES}

all: $(FILES)

INST= /usr/bin/install

install: uid_chk all
	@for file in ${BIN_FILES}; do \
		${INST} -p $$file ${BIN_DIR} -o root -g root -m 755; \
	done
	@for file in ${SBIN_FILES}; do \
		${INST} -p $$file ${SBIN_DIR} -o root -g root -m 744; \
	done

uid_chk:
	@if [ `id -u` != 0 ]; then echo You must become root first; exit 1; fi

