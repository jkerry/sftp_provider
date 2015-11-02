#
# Author:: John Kerry (<John@kerryhouse.net>)
# Copyright:: Copyright (c)
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  class Provider
    class RemoteFile
      class SFTPFetcher

        def self.for_resource(uri, new_resource, current_resource)
          case uri.scheme
          when "sftp"
            Chef::Provider::RemoteFile::SFTP.new(uri, new_resource, current_resource)
          else
            raise ArgumentError, "Invalid uri, sftp supported"
          end
        end

        # Windows network share: \\computername\share\file
        def self.network_share?(source)
            false
        end

      end
    end
  end
end
