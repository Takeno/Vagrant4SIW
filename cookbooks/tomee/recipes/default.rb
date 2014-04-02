package "build-essential" do
  action :install
end

directory node[:tomee][:dir] do
  owner "vagrant"
  mode "0755"
  action :create_if_missing
end

remote_file "#{Chef::Config[:file_cache_path]}/tomee.tar.gz" do
  source node[:tomee][:src_link]
  action :create_if_missing
end


bash "extract_tomee" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xzf tomee.tar.gz -C #{node[:tomee][:dir]} --strip-components=1
    cp -R #{node[:tomee][:dir]}/webapps/* #{node[:tomee][:working_dir]}
    chown -R vagrant #{node[:tomee][:dir]}
    chgrp -R vagrant #{node[:tomee][:dir]}
  EOH
  creates "#{node[:tomee][:dir]}/bin"
end

remote_file "#{node[:tomee][:dir]}/lib/postgresql-jdbc4.jar" do
  source "http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc4.jar"
  action :create_if_missing
end

service "tomee" do
  # start_command "#{node[:tomee][:dir]}/bin/startup.sh"
  # stop_command "#{node[:tomee][:dir]}/bin/shutdown.sh"
  provider Chef::Provider::Service::Upstart
  subscribes :restart, resources(:bash => "extract_tomee")
  supports :restart => false, :status => false, :reload => false
  # action [:enable, :start]
end

template "tomee.xml" do
  path "#{node[:tomee][:dir]}/conf/server.xml"
  source "server.xml.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  notifies :restart, resources(:service => "tomee")
end

# template "tomee.rc" do
#   path "/etc/init.d/tomee"
#   source "tomee.rc.erb"
#   owner "root"
#   group "root"
#   mode "0755"
#   notifies :restart, resources(:service => "tomee")
# end

template "tomee.upstart.conf" do
  path "/etc/init/tomee.conf"
  source "tomee.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "tomee")
end

service "tomee" do
  action [:enable, :start]
end
