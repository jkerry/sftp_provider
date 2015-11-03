#
# Cookbook Name:: sftp_provider
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
chef_gem 'net-sftp' do
  action :install
  compile_time true
end
