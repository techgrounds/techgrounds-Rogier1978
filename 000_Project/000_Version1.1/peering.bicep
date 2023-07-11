@description('vnet params for management and web server')
param vNet1id string
param vNet1Name string
param vNet2id string
param vNet2Name string

  
@description('peering resources')  
resource peering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
  name: '${vNet1Name}/peeringName1'
  properties: {
    remoteVirtualNetwork: {
      id: vNet2id
    }
    allowForwardedTraffic: false
    allowGatewayTransit: true
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: false
  }
}

resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
  name: '${vNet2Name}/peeringName2'
  properties: {
    remoteVirtualNetwork: {
      id: vNet1id
    }
    allowForwardedTraffic: false
    allowGatewayTransit: true
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: false
  }
}

