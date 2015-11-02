sftp_provider Cookbook
======================
This cookbook supplies a provider for the remote_file resource that uses SFTP (driven by the net-sftp gem).

Requirements
------------
include the default recipe to handle the gem dependencies or include the following in your recipe"

chef_gem 'net-sftp' do
  action :install
  compile_time true
end

#### packages
- `net-sftp` - sftp_provider is driven by the net-sftp gem.

Attributes
----------
None necessary

Usage
-----
#### sftp_provider::default
Include this cookbook as a dependency and utilize the provider.

e.g.

```ruby
include_recipe 'sftp_provider::default'

remote_file "c:/tmp.txt" do
  source "sftp://username:password@host/path/from/root/to/file/on/sftp/server"
  provider  Chef::Provider::File::SFTPRemoteFile
end
```
Contributing
------------
Pull requests are accepted. This plugin is currently under initial development and any help is appreciated.

License and Authors
-------------------
Authors:
* John Kerry

Apache 2.0 License
