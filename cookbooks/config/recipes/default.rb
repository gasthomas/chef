#
# Cookbook Name:: config
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Configure .bashrc and .vimrc"
bash "Clone config" do
  cwd "/root"
  code <<-EOH
    git clone https://github.com/gasthomas/config.git
  EOH
  not_if { ::File.exists?("/root/config") }
end

bash "Delete current files" do
  cwd "/root"
  code <<-EOH
    rm -f .bashrc
    rm -f .vimrc
  EOH
end

log "Create symbolic links"
link '/root/.bashrc' do
  to '/root/config/.bashrc'
end

link '/root/.vimrc' do
  to '/root/config/.vimrc'
end

bash "Load .bashrc" do
  cwd "/root"
  code <<-EOH
    source .bashrc
  EOH
end
