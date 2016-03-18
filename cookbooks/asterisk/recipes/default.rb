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
%w{ gcc-c++ ncurses-devel sqlite-devel libxml2-devel}.each do |pkg|
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

template "/etc/sysconfig/selinux" do
  source "selinux.erb"
  owner "root"
  mode 0644
end
