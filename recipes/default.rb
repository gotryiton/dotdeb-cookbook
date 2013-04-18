#
# Cookbook Name:: dotdeb
# Recipe:: default
#
# Copyright 2012, Go Try It On, Inc.
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

# adds the dotdeb apt repository to sources
apt_repository "dotdeb" do
  uri "http://packages.dotdeb.org"
  components ["stable", "all"]
  keyserver "keys.gnupg.net"
  key "89DF5277"
  deb_src true
  action :add
end
