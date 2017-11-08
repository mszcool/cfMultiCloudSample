#
# First read all required parameters
#
trafficMgrDomain=$1
azureCfPublicIp=$2
pivotalOrg=$3
pivotalSpace=$4
azureOrg=$5
azureSpace=$6

$azureCfApiEndpoint="api.$azureCfPublicIp.xip.io"
$pivotalApiEndpoint="api.run.pivotal.io"

echo "############################################################"
echo "            Setting up apps on Azure and Pivotal            "
echo "!! Press CTRL+C within 30 sec if the below is not correct !!"
echo "############################################################"
echo "- Traffic Manager Domain: $trafficMgrDomain"
echo "- Azure API endpoint: $azureCfApiEndpoint"
echo "  - Azure CF organization: $azureOrg"
echo "  - Azure CF space: $azureSpace"
echo "- Pivotal API endpoint: $pivotalApiEndpoint"
echo "  - Pivotal CF organization: $pivotalOrg"
echo "  - Pivotal CF space: $pivotalSpace"
sleep 30

echo ""
echo "### Pivotal setup ###"
cf login -a $pivotalApiEndpoint
cf target -o $pivotalOrg -s $pivotalSpace
cf push -f ./sampleapp/manifest.yml -p ./sampleapp
cf create-domain $pivotalOrg $trafficMgrDomain
cf create-route $pivotalSpace $trafficMgrDomain
cf map-route multicloudapp $trafficMgrDomain
cf set-env multicloudapp REGION "Pivotal Cloud"
cf restage multicloudapp

echo ""
echo "### Azure setup ###"
cf login -a $azureCfApiEndpoint
cf target -o $azureOrg -s $azureSpace
cf push -f ./sampleapp/manifest.yml -p ./sampleapp
cf create-domain $azureOrg $trafficMgrDomain
cf create-route $azureSpace $trafficMgrDomain
cf map-route multicloudapp $trafficMgrDomain
cf set-env multicloudapp REGION "Microsoft Azure"
cf restage multicloudapp

echo ""
echo "### Finished ###"
echo "Navigate to $trafficMgrDomain to test your app."
echo "Try cf stop on one app, wait a while (300s max. DNS TTL), and try again"
