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
  cwd "/home/user"
  code <<-EOH
    git clone https://github.com/gasthomas/config.git
  EOH
  not_if { ::File.exists?("/home/user/config") }
end

bash "Delete current files" do
  cwd "/home/user"
  code <<-EOH
    rm -f .bashrc
    rm -f .vimrc
  EOH
end

log "Create symbolic links"
link '/home/user/.bashrc' do
  to '/home/user/config/.bashrc'
end

link '/home/user/.vimrc' do
  to '/home/user/config/.vimrc'
end

bash "Load .bashrc" do
  cwd "/home/user"
  code <<-EOH
    source .bashrc
  EOH
end
