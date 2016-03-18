#
# Cookbook Name:: ubuntu-sandbox
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysconfig/network" do
  source "network.erb"
  owner "root"
  mode 0644
  variables({
    :hostname => node["sandbox"][:hostname],
  })
end

template "/etc/sysconfig/network-scripts/ifcfg-eth1" do
  source "ifcfg-eth1.erb"
  owner "root"
  mode 0644
  variables({
    :ip_address => node["sandbox"][:ip_address],
  })
end

bash "Change timezone" do
  code <<-EOH
    mv /etc/localtime /etc/localtime.bak
    ln -s /usr/share/zoneinfo/#{node["sandbox"][:timezone]} /etc/localtime
  EOH
end
