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

require 'uri'
require 'tempfile'
require 'chef/file_content_management/content_base'
require 'chef/mixin/uris'

class Chef
  class Provider
    class RemoteFile
      class Content
        class SFTPContent < Chef::Provider::RemoteFile::Content
          private

          include Chef::Mixin::Uris

          # Given an array of source uris, iterate through them until one does not fail
          def try_multiple_sources(sources)
            sources = sources.dup
            source = sources.shift
            begin
              uri = if Chef::Provider::RemoteFile::Fetcher.network_share?(source)
                source
              else
                as_uri(source)
              end
              raw_file = grab_file_from_uri(uri)
            rescue SocketError, Errno::ECONNREFUSED, Errno::ENOENT, Errno::EACCES, Timeout::Error, Net::HTTPServerException, Net::HTTPFatalError, Net::FTPError => e
              Chef::Log.warn("#{@new_resource} cannot be downloaded from #{source}: #{e.to_s}")
              if source = sources.shift
                Chef::Log.info("#{@new_resource} trying to download from another mirror")
                retry
              else
                raise e
              end
            end
            raw_file
          end

          # Given a source uri, return a Tempfile, or a File that acts like a Tempfile (close! method)
          def grab_file_from_uri(uri)
            Chef::Provider::RemoteFile::SFTPFetcher.for_resource(uri, @new_resource, @current_resource).fetch
          end
        end
      end
    end
  end
end
