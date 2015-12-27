#$Id: Makefile 1116 2011-08-25 03:53:15Z rohare $
#$Date: $
#
# High Performance Computer Demand (HPCD)
#
Name= hpcd
Version= 2.1
Release= 1
Source= ${Name}-${Version}-${Release}.tgz
BASE= $(shell pwd)

RPMBUILD= ${HOME}/rpmbuild
RPM_BUILD_ROOT= ${RPMBUILD}/BUILDROOT
RPM_DIR= ${RPMBUILD}/RPMS/noarch

BIN_DIR= /usr/bin

BIN_FILES= hpcd

REPOS= /var/www/html/software/jwics/redhat/5/noarch \
	/var/www/html/software/jwics/redhat/6/noarch \
	/var/www/html/software/jwics/redhat/7/noarch \
	/var/www/html/software/gs/redhat/5/noarch \
	/var/www/html/software/gs/redhat/6/noarch \
	/var/www/html/software/gs/redhat/7/noarch \
	/var/www/html/software/hal/redhat/5/noarch \
	/var/www/html/software/hal/redhat/6/noarch \
	/var/www/html/software/hal/redhat/7/noarch \
	/var/www/html/software/jwics/centos/5/noarch \
	/var/www/html/software/jwics/centos/6/noarch \
	/var/www/html/software/jwics/centos/7/noarch \
	/var/www/html/software/gs/centos/5/noarch \
	/var/www/html/software/gs/centos/6/noarch \
	/var/www/html/software/gs/centos/7/noarch \
	/var/www/html/software/hal/centos/5/noarch \
	/var/www/html/software/hal/centos/6/noarch \
	/var/www/html/software/hal/centos/7/noarch

RPM_FILE= "${RPM_DIR}/${Name}-${Version}-${Release}.noarch.rpm" 

INST= /usr/bin/install

rpmbuild: specfile source
	rpmbuild -bb --buildroot ${RPM_BUILD_ROOT} ${RPMBUILD}/SPECS/${Name}-${Version}-${Release}.spec

specfile: spec
	@cat ./spec | sed "s/(release)/${Release}/" \
		| sed "s?(version)?${Version}?" \
		| sed "s?(source)?${Source}?" \
		> ${RPMBUILD}/SPECS/${Name}-${Version}-${Release}.spec

source:
	if [ ! -d ${RPMBUILD}/SOURCES/${Name} ]; then \
		mkdir ${RPMBUILD}/SOURCES/${Name}; \
	fi
	rsync -av * ${RPMBUILD}/SOURCES/${Name}
	tar czvf ${RPMBUILD}/SOURCES/${Source} --exclude=.git -C ${RPMBUILD}/SOURCES ${Name}
	rm -fr ${RPMBUILD}/SOURCES/${Name}

install: make_path bin

localinstall: uid_chk
	@for file in ${BIN_FILES}; do \
		${INST} -p $$file ${BIN_DIR} -o root -g root -m 755; \
	done
	
make_path:
	@if [ ! -d ${RPM_BUILD_ROOT}/${BIN_DIR} ]; then \
		mkdir -m 0755 -p ${RPM_BUILD_ROOT}/${BIN_DIR}; \
	fi;

bin:
	@for file in ${BIN_FILES}; do \
		${INST} -p $$file ${RPM_BUILD_ROOT}/${BIN_DIR}; \
	done;

webLoad:
	@for dest in ${REPOS}; do \
		${INST} -p ${RPM_FILE} $$dest/ -m 644; \
	done
	

uid_chk:
	@if [ `id -u` != 0 ]; then echo You must become root first; exit 1; fi

clean:
	@rm -f ${RPMBUILD}/SPECS/${Name}-${Version}-${Release}.spec
	@rm -fR ${RPMBUILD}/SOURCES/${Source}
	@rm -fR ${RPMBUILD}/BUILD/${Name}
	@rm -fR ${RPMBUILD}/BUILDROOT/*

