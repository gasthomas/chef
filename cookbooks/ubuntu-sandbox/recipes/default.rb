#
# Cookbook Name:: ubuntu-sandbox
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/hostname" do
  source "hostname.erb"
  owner "root"
  mode 0644
  variables({
    :hostname => node["sandbox"][:hostname],
  })
end

template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  mode 0644
  variables({
    :hostname => node["sandbox"][:hostname],
  })
end

template "/etc/network/interfaces" do
  source "interfaces.erb"
  owner "root"
  mode 0644
  variables({
    :ip_address => node["sandbox"][:ip_address],
  })
end

bash "Change timezon" do
  code <<-EOH
    timedatectl set-timezone UTC
  EOH
end
