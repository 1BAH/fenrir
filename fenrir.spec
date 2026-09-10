%undefine __brp_mangle_shebangs

Name:           fenrir
Version:        2026.1.2
Release:        7
Summary:        Testing system 'fenrir'

License:        Apache License 2.0
URL:            https://github.com/1bah/fenrir

Source0:        fenrir-%{version}.tar.gz

Requires:       bash >= 5.0.0, curl
Requires(pre):  shadow-utils
AutoReq: no

BuildArch:      noarch

%description
A lightweight general purpose testing tool


%prep
%setup -q


%install
mkdir -p "%{buildroot}%{_sysconfdir}" "%{buildroot}%{_bindir}" "%{buildroot}%{_datadir}"

cp -r etc/* "%{buildroot}%{_sysconfdir}"
cp -r usr/bin/* "%{buildroot}%{_bindir}"
cp -r usr/share/* "%{buildroot}%{_datadir}"

sed -i "s|^echo \".*\"$|echo \"%{_sysconfdir}/fenrir\"|" "%{buildroot}%{_bindir}/fenrir-get-confdir"
sed -i "s|^echo \".*\"$|echo \"%{_bindir}\"|" "%{buildroot}%{_bindir}/fenrir-get-bindir"


%post
echo "packaged=rpm" >> "%{_sysconfdir}/fenrir/main.hel"

cuser=$(
  pid=$$
  while [ -n "$pid" ] && [ "$pid" -gt 1 ] 2>/dev/null; do
    read -r ppid user < <(ps -o ppid=,user= -p "$pid" 2>/dev/null)

    if [ -n "$user" ] && [ "$user" != "root" ]; then
      echo "$user"
      break
    fi

    pid="$ppid"
  done
)
cuser=${cuser:-$(id -un)}
cgrp=$(id -gn "$cuser")

if [ "$cuser" = "root" ]; then
    FENRIR_HOME="/$cuser/.fenrir"
else
    FENRIR_HOME="/home/$cuser/.fenrir"
fi

if [ -d "${FENRIR_HOME}" ]; then # Upgrade
    rm -fr "$FENRIR_HOME"
fi

cp -r "%{_sysconfdir}/fenrir/fenrir_home" "$FENRIR_HOME"

chown -R "$cuser:$cgrp" "%{_sysconfdir}/fenrir"
chown -R "$cuser:$cgrp" "$FENRIR_HOME"
echo "Created local repository for <$cuser:$cgrp>.."


%preun
cuser=$(
  pid=$$
  while [ -n "$pid" ] && [ "$pid" -gt 1 ] 2>/dev/null; do
    read -r ppid user < <(ps -o ppid=,user= -p "$pid" 2>/dev/null)

    if [ -n "$user" ] && [ "$user" != "root" ]; then
      echo "$user"
      break
    fi

    pid="$ppid"
  done
)
cuser=${cuser:-$(id -un)}
if [ "$cuser" = "root" ]; then
    FENRIR_HOME="/$cuser/.fenrir"
else
    FENRIR_HOME="/home/$cuser/.fenrir"
fi

if [ $1 == 0 ]; then # Remove (ignore update)
    echo "Uninstall fenrir work directories.."
    rm -fr "$FENRIR_HOME"
    rm -f "/home/$cuser/.oh-my-zsh/completions/_fenrir"
    rm -f "/etc/bash_completion.d/fenrir-autocomplete"
fi


%files
%dir %{_sysconfdir}/fenrir
%dir %{_datadir}/doc/fenrir

%license %{_datadir}/doc/fenrir/LICENSE

%doc %{_datadir}/man/man1/loki.1.gz
%doc %{_datadir}/man/man1/fenrir*.1.gz

%{_sysconfdir}/fenrir/*

%{_bindir}/fenrir*
%{_bindir}/update-fenrir
%{_bindir}/loki


%changelog
* Thu Jul 23 2026 1bah <koefic.cien@gmail.com>
- 
