#
# Cookbook Name:: sftp_provider
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


remote_file "c:\\tmp2.txt" do
  source "sftp://username:password@host/path/from/root/to/file/on/sftp/server"
  provider  Chef::Provider::File::SFTPRemoteFile
end
