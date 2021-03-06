#
# Copyright:: 2014-2019, Chef Software, Inc.
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

property :package_name, String, name_property: true
property :base_url, String, default: 'ftp://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc'

action :install do
  package_url = url_for(new_resource.package_name, new_resource.base_url)
  unless package_url.nil?
    remote_file "#{Chef::Config[:file_cache_path]}/#{::File.basename(package_url)}" do
      source package_url
      action :create
    end

    rpm_package new_resource.package_name do
      source "#{Chef::Config[:file_cache_path]}/#{::File.basename(package_url)}"
      action :install
    end
  end
end

action :remove do
  rpm_package new_resource.package_name do
    action :remove
  end
end

action_class do
  include Opscode::Aix::Helpers
end
