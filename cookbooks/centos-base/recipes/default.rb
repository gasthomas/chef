#
# Cookbook Name:: centos-base
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{git vim}.each do |pkg|
  package "#{pkg}" do
    action :install
  end
end
