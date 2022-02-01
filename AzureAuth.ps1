#Azure PowerShell
#Login and select subscription
Connect-AzAccount -DeviceCode -Subscription "bd0b675c-02c7-49b2-8e49-ae963925fa6c"

#Azure CLI
#Login and select subscription
az login --use-device-code
az account set --subscription "bd0b675c-02c7-49b2-8e49-ae963925fa6c"