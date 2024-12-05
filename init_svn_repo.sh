#!/bin/sh

cd ~ ; # cd /home/walter.chen
mkdir -p svn/repo
svnadmin create .

if [ -d conf ]
then
    echo "-- svn repo init failed"
fi

cd svn/repo
cp ./conf/svnserve.conf conf/svnserve.conf.00
cp ./conf/passwd ./conf/passwd.00
cp ./conf/authz ./conf/authz.00


# authz-db = authz
# hooks-env = hooks-env
# password-db = passwd
TAR=./conf/svnserve.conf
sed -i.b00 '/# authz-db = authz/     s/^# //' $TAR
sed -i.b00 '/# hooks-env = hooks-en/ s/^# //' $TAR
sed -i.b00 '/# password-db = passw/  s/^# //' $TAR

# [users]
# walter.chen = mps
TAR=./conf/passwd
sed -i.b00 '/^\[users\]/ a \
walter.chen = mps
' $TAR

# add to file bottom
TAR=./conf/authz
sed -i.b00 '$a \
[/]\
* = rw
' $TAR

svnserve -d -r /home/walter.chen/svn/repo
