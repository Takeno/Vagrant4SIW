package "build-essential" do
  action :install
end

directory node[:tomee][:dir] do
  owner "root"
  mode "0755"
  action :create
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
  EOH
  creates "#{node[:tomee][:dir]}/bin"
end

remote_file "#{node[:tomee][:dir]}/lib/postgresql-jdbc4.jar" do
  source "http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc4.jar"
  action :create_if_missing
end

service "tomee" do
  provider Chef::Provider::Service::Upstart
  start_command "#{node[:tomee][:dir]}/bin/startup.sh"
  stop_command "#{node[:tomee][:dir]}/bin/shutdown.sh"
  subscribes :restart, resources(:bash => "extract_tomee")
  supports :restart => false, :start => true, :stop => true
end

template "tomee.xml" do
  path "#{node[:tomee][:dir]}/conf/server.xml"
  source "server.xml.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "tomee")
end

# template "tomee.upstart.conf" do
#   path "/etc/init/tomee.conf"
#   source "tomee.upstart.conf.erb"
#   owner "root"
#   group "root"
#   mode "0644"
#   notifies :restart, resources(:service => "tomee")
# end

service "tomee" do
  action [:start]
end
