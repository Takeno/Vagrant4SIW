 #!/usr/bin/env bash
sudo apt-get install -y curl

su vagrant <<'EOF'
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -L https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm requirements

    rvm install ruby
    rvm use ruby --default
    rvm rubygems current

    gem install rails
EOF