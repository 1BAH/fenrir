Name:           fenrir
Version:        2026.0+1
Release:        1
Summary:        Testing system

License:        Apache License 2.0
URL:            https://github.com/1bah/fenrir

Source0:        fenrir-%{version}.tar.gz

Requires:       bash
BuildArch:      noarch

%description
Testing system (Description tbd..)

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_sysconfdir} %{buildroot}%{_bindir} %{buildroot}%{_datadir}

cp -r etc/* %{buildroot}%{_sysconfdir}
cp -r usr/bin/* %{buildroot}%{_bindir}
cp -r usr/share/* %{buildroot}%{_datadir}

%files
%dir /etc/fenrir
%dir /usr/share/doc/fenrir

%license /usr/share/doc/fenrir/LICENSE

%doc /usr/share/man/man1/loki.1.gz
%doc /usr/share/man/man1/fenrir*.1.gz

/etc/fenrir/*
/usr/share/doc/fenrir/*

/usr/bin/fenrir*
/usr/bin/uninstall-fenrir
/usr/bin/update-fenrir
/usr/bin/loki

%changelog
* Thu Jul 23 2026 1bah <koefic.cien@gmail.com>
- 
