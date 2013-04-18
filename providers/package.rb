#
# Cookbook Name:: apt
# Provider:: repository
#
# Copyright 2010-2011, Opscode, Inc.
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


# Puts the policy-rc.d file in place
# so postinst scripts are not run
def policy
  cookbook_file "/usr/sbin/policy-rc.d" do
    cookbook "dotdeb"
    source "policy-rc.d"
    owner "root"
    group "root"
    mode "755"
    action :create
  end

  yield

  cookbook_file "/usr/sbin/policy-rc.d" do
    cookbook "dotdeb"
    action :delete
  end
end

# Lets bash completion work for upstart jobs properly
# and gives an error if called from /etc/init.d
def override_init(name)
  cookbook_file "/etc/init.d/#{name}" do
    source "upstart.init"
    cookbook "dotdeb"
    owner "root"
    group "root"
    mode "755"
    action :create
  end
end

action :install do
  policy do
    package new_resource.name do
      action :install
      options "-o Dpkg::Options::='--force-confnew'"
    end

    override_init(new_resource.name)
  end
end

action :upgrade do
  policy do
    package new_resource.name do
      action :upgrade
      options "-o Dpkg::Options::='--force-confnew'"
    end

    override_init(new_resource.name)
  end
end
