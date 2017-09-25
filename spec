# $Id: 5ba798a634daaae1bd14a89b91b216cef23ff5d5 $
# $Date: $
# Author: Rich O'Hare  <rohare2@gmail.com>
#
# Hight Performance Computer Demand (hpcd)
#
%define Name hpcd
%define Version (version)
%define Release (release)
%define Source (source)

Name: %{Name}
Version: %{Version}
Release: %{Release}
Source: %{Source}
License: GPLv2
Group: Applications/System
BuildArch: noarch
URL: https://www.ohares.us/
Distribution: RedHat/Centos 6
Vendor: Rich O'Hare
Packager: Rich O'Hare <rohare2@gmail.com>
Provides: hpcd 
Requires: DBI
Requires: Getopt::Std
Requires: perl-Date-Manip
Summary: Tool for managing future HPC node demand
%define _unpackaged_files_terminate_build 0

%description
The hpcd package is a database application which can be
used to help end users manage their anticipated HPC computing
needs. By registering their future computing needs, users can
help to ensure that adequate resources are available.

%prep
%setup -q -n %{Name}

%build
exit 0

%install
#rm -rf %RPM_BUILD_ROOT/*
make install
exit 0

%clean
#rm -fR %RPM_BUILD_ROOT/*
exit 0

%files
%attr(755, root, root) /usr/local/bin/hpcd
