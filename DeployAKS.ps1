#Welcome to the "Deploy AKS PowerShell script. Use the instructions below to deploy a new Azure environment to try out the gMSA on AKS feature."

#You will need to login to Azure to deploy the resources. Log-in with both Azure PowerShell and Azure CLI
#Azure PowerShell
#Login and select subscription
$Az_Sub = Read-Host -Prompt 'Please provide the Azure subscription ID to be used'
Connect-AzAccount -DeviceCode -Subscription $Az_Sub

#Azure CLI
#Login and select subscription
az login --use-device-code
az account set --subscription $Az_Sub

$RG_Name = Read-Host -Prompt "Resource Group Name"
$RG_Location = Read-Host -Prompt "Resource Group Loation"
New-AzResourceGroup -Name $RG_Name -Location $RG_Location

#Creates Azure vNet
$vNet_Name = Read-Host -Prompt "vNet Name"
$vnet = @{
    Name = $vNet_Name
    ResourceGroupName = $RG_Name
    Location = $RG_Location
    AddressPrefix = '10.0.0.0/16'    
}
$virtualNetwork = New-AzVirtualNetwork @vnet

#Creates Subnet under the Azure vNet
$subnet = @{
    Name = 'default'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.0.0.0/16'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet

#Associate the subnet to the virtual network
$virtualNetwork | Set-AzVirtualNetwork

#Creates AKS Cluster
$AKSCluster_Name = Read-Host -Prompt 'Please provide the name for the AKS cluster'
$Username = Read-Host -Prompt 'Please create a username for the administrator credentials on your Windows Server containers: '
$Password = Read-Host -Prompt 'Please create a password for the administrator credentials on your Windows Server containers: ' -AsSecureString
New-AzAksCluster -ResourceGroupName $RG_Name -Name $AKSCluster_Name -NodeCount 2 -NetworkPlugin azure -NodeVnetSubnetID '/subscriptions/bd0b675c-02c7-49b2-8e49-ae963925fa6c/resourceGroups/gMSAAKSDemo/providers/Microsoft.Network/virtualNetworks/gMSAvNet/subnets/default' -ServiceCidr '10.240.0.0/16' -DnsServiceIP '10.240.0.10' -NodeVmSetType VirtualMachineScaleSets -GenerateSshKey -WindowsProfileAdminUserName $Username -WindowsProfileAdminUserPassword $Password

