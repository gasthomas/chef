#
# Cookbook Name:: asterisk
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Install Asterisk"

log "Install Required Packages"

%w{ automake gcc gcc-c++ openssl-devel libcurl-devel libogg-devel libvorbis-devel speex-devel net-snmp-devel corosynclib-devel newt-devel popt-devel libtool-ltdl-devel lua-devel postgresql-devel neon-devel libical-devel openldap-devel bluez-libs-devel gsm-devel libedit-devel libuuid-devel mysql-devel.x86_64 unixODBC-devel.x86_64 mysql-connector-odbc.x86_64 ncurses-devel.x86_64 libxml2-devel.x86_64 sqlite-devel.x86_64 libtool-ltdl libtool-ltdl-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

bash "Download Asterisk" do
  cwd "/tmp"
  user "root"
  group "root"

  code <<-EOH
    curl -OL http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-11.3.0.tar.gz
  EOH
  not_if { ::File.exists?("/tmp/asterisk-11.3.0.tar.gz") }
end

bash "Extract Asterisk" do
  cwd "/tmp"
  user "root"
  group "root"

  code <<-EOH
    tar xvzf asterisk-11.3.0.tar.gz
  EOH
  not_if { ::File.exists?("/tmp/asterisk-11.3.0") }
end

bash "Install Asterisk" do
  cwd "/tmp/asterisk-11.3.0"
  user "root"
  group "root"

  code <<-EOH
    ./configure --libdir=/usr/lib64
    make
    make install
    make config
    make samples
  EOH
  not_if { ::File.exists?("/etc/init.d/asterisk") }
end
