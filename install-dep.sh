#!/bin/bash

# downloadCookbook <name> <repo>
function downloadCookbook {
    rm -rf ./cookbooks/$1
    git clone $2 ./cookbooks/$1
    rm -rf ./cookbooks/$1/.git
}

mkdir -p ./cookbooks

downloadCookbook apt "git@github.com:opscode-cookbooks/apt.git"
downloadCookbook openssl "git@github.com:opscode-cookbooks/openssl.git"
# sed -i "s/use_inline_resources/#use_inline_resources/g" ./cookbooks/openssl/providers/x509.rb
downloadCookbook java "git@github.com:agileorbit-cookbooks/java.git"
downloadCookbook postgresql "git@github.com:hw-cookbooks/postgresql.git"
downloadCookbook build-essential "git@github.com:opscode-cookbooks/build-essential.git"
# downloadCookbook tomee "git@github.com:freedev/chef-tomee.git"
downloadCookbook rvm "git@github.com:martinisoft/chef-rvm.git"
# downloadCookbook rbenv "git@github.com:fnichol/chef-rbenv.git"
# downloadCookbook ruby_build "git@github.com:fnichol/chef-ruby_build.git"
