#!/bin/sh



NS_PHP="/usr/local/php54/bin/php"
NS_DOMAIN="mytest.com"
NS_ARCHIVE="archives"
NS_MAGENTO_VERSION="1.9.0.1"
NS_MAGENTO_FILE="magento-$NS_MAGENTO_VERSION.tar.gz"


#Magento Install Settings
# The options below were setup for the localization in New York
# with a default currency of the USD
#
MAGENTO_LOCALE="en_US"
MAGENTO_TIMEZONE="America/New_York"
MAGENTO_CURRENCY="USD"
MAGENTO_DBHOST="db hostname"
MAGENTO_DBNAME="magento database name"
MAGENTO_DBUSER="magento database username"
MAGENTO_DBPASS="magento database password"
MAGENTO_PREFIX=""
MAGENTO_USE_REWRITES="yes"
MAGENTO_USE_SECURE="no"
MAGENTO_USE_SECURE_ADMIN="no"
MAGENTO_SECURE_BASE_URL=""
MAGENTO_ADMIN_FRONTNAME="admin"
MAGENTO_ADMIN_FIRSTNAME="Neo"
MAGENTO_ADMIN_LASTNAmE="Anderson"
MAGENTO_ADMIN_EMAIL="magento admin email address"
MAGENTO_ADMIN_USERNAME="magento admin username"
MAGENTO_ADMIN_PASSWORD="magento admin password"
MAGENTO_URL="http://mydomain.com/store"

extractMagento(){
    if [[ -d ~/$NS_ARCHIVE  && -f ~/$NS_ARCHIVE/$NS_MAGENTO_FILE ]]; then
        echo "Archive directory exists, magento file exists..."
        cp ~/$NS_ARCHIVE/$NS_MAGENTO_FILE ~/$NS_DOMAIN 
        cd ~/$NS_DOMAIN
        if [[ ! -d "store" ]]; then
            mkdir store
        fi 
        cd store
        echo "Beginning untar process..."
        tar -zxvf ~/$NS_ARCHIVE/$NS_MAGENTO_FILE
        mv magento/* magento/.htaccess . &> /dev/null
    
        applyPermissions
        cleanUp

        # installMagento
    fi 
}

applyPermissions(){

  chmod -R o+w media var
  chmod o+w app/etc 
}

cleanUp(){

    rm -rf magento
    rm -r ../$NS_MAGENTO_FILE
}

installMagento(){
    $NS_PHP -f install.php -- \ 
    --license_agreement_accepted "yes" \
    --locale "$MAGENTO_LOCALE" \
    --timezone "$MAGENTO_TIMEZONE" \
    --default_currency "$MAGENTO_CURRENCY" \
    --db_host "$MAGENTO_DBHOST" \
    --db_name "$MAGENTO_DBNAME" \
    --db_user "$MAGENTO_DBUSER" \
    --db_pass "$MAGENTO_DBPASS" \
    --db_prefix "$MAGENTO_PREFIX" \
    --admin_frontname "$MAGENTO_ADMIN_FRONTNAME" \
    --url "$MAGENTO_URL" \
    --use_rewrites "$MAGENTO_USE_REWRITES" \
    --use_secure "$MAGENTO_USE_SECURE" \
    --secure_base_url "$MAGENTO_SECURE_BASE_URL" \
    --use_secure_admin "$MAGENTO_USE_SECURE_ADMIN" \
    --admin_firstname "$MAGENTO_ADMIN_FIRSTNAME" \
    --admin_lastname "$MAGENTO_ADMIN_LASTNAME" \
    --admin_email "$MAGENTO_ADMIN_EMAIL" \
    --admin_username "$MAGENTO_ADMIN_USERNAME" \
    --admin_password "$MAGENTO_ADMIN_PASSWORD"

}

if [ -d ~/$NS_DOMAIN ]; then
    echo "Domain $NS_DOMAIN exists"
    extractMagento
else
    echo "Domain $NS_DOMAIN does not exist, aborting magento install"
    exit
fi
