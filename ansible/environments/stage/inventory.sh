#!/bin/bash
SCRIPT_PATH=`dirname $0`
cd ~/otus/valmanmsk_infra/terraform/stage
app_ip=$(terraform output app_external_ip)
db_ip=$(terraform output db_external_ip)
cd ~/otus/valmanmsk_infra/ansible
echo "{
    "app": {
        "hosts": [\"$app_ip\"]
    },
    "db": {
        "hosts": [\"$db_ip\"]
    }
}
" > $SCRIPT_PATH/inventory.json
if [ "$1" == "--list" ];
then
    cat $SCRIPT_PATH/inventory.json
else
    echo ""
fi

