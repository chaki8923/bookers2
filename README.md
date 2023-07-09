# Bookers2Ver2

自分が見た本を投稿してみんなと共有できるサービス。
その投稿に対していいねしたりできる。
ユーザー同士フォローもできて、相互フォローになるとチャットができたり
自分でグループも作れる。


# Features

課題に加えて、leteropnerを実装。実際にメールがletteopnerに届く

# Requirement


* bootstarp 4.6.2

# Installation
EC2を立てたら行うこと

- ImageMagic
```bash
sudo yum -y install libpng-devel libjpeg-devel libtiff-devel gcc-c++ git
git clone -b 7.1.1-5 --depth 1 https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.1.1-5
cd ImageMagick-7.1.1-5
./configure
make
sudo make install
```

- oldversion ruby uninstall
```bash
sudo yum remove -y ruby*
sudo yum -y install openssl-devel readline-devel
```

- rbenv install

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
```

- newversion ruby & bundle install
```bash
rbenv install 3.1.2
rbenv global 3.1.2
rbenv rehash
rbenv exec gem install bundler
```
- require package install
```bash
sudo yum -y install patch libyaml-devel zlib zlib-devel libffi-devel make autoconf automake libcurl-devel sqlite-devel mysql-devel
```
- node.js install
```bash
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs
```
- yarn install
```bash
sudo npm install -g yarn
```
- rails install
```bash
gem install rails -v 6.1.4
```
- ec2
```bash
scp -i ~/.ssh/pemファイル ~/.ssh/id_rsa ec2-user@IPアドレス:.ssh/id_rsa
git clone GitHubのリポジトリのURL
```

- cloud9
```bash
# master.keyをec2へ
scp -i ~/.ssh/pemファイル config/master.key ec2-user@IPアドレス:GitHubのリポジトリ名/config
# .envをec2へ
scp -i ~/.ssh/pemファイル .env ec2-user@IPアドレス:GitHubのリポジトリ名/
```

- ec2
```bash
bundle install --path vendor/bundle --without test development
bundle exec rails assets:precompile RAILS_ENV=production
bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production
```

migrationエラーの場合はエラーを見てどこまで成功してるか、どのファイルでこけたか確認して
適宜対応する。
master.keyがない場合
credentials.yml.encを削除して以下コマンド
EDITOR="vi" bin/rails credentials:edit

# Note

本番ではbootstarpが読み込まれなかったのでCDNにて対応

# Author

作成情報を列挙する

* RYOUcHAKI
* ibj
* chaki@com

# License


"DMM WEB CAMP" is Confidential.