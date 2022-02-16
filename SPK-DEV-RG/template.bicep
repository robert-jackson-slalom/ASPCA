@secure()
param vulnerabilityAssessments_Default_storageContainerPath string
param servers_spkrjdevmssql01_name string = 'spkrjdevmssql01'
param virtualNetworks_SPK_DEV_RG_vnet_name string = 'SPK-DEV-RG-vnet'
param vaults_defaultVault815_name string = 'defaultVault815'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'
param routeTables_e41f87a2_AZBST_RT_41d07691_2d2e_4c16_abef_6d252ef22282_externalid string = '/subscriptions/fd8ea382-65ba-4762-b92b-0bcf7f50f797/resourceGroups/RG-MGMT-DEV-01/providers/Microsoft.Network/routeTables/_e41f87a2_AZBST_RT_41d07691-2d2e-4c16-abef-6d252ef22282'

resource privateDnsZones_privatelink_blob_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_privatelink_blob_core_windows_net_name
  location: 'global'
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 1
    numberOfVirtualNetworkLinks: 1
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource virtualNetworks_SPK_DEV_RG_vnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_SPK_DEV_RG_vnet_name
  location: 'eastus2'
  tags: {
    CREATOR: 'Ilya Koyfman'
    'DATA PROFILE': 'INTERNAL'
    ENVIRONMENT: 'DEV'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
              locations: [
                'eastus2'
                'centralus'
              ]
            }
            {
              service: 'Microsoft.Sql'
              locations: [
                'eastus2'
              ]
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.1.0/27'
          routeTable: {
            id: routeTables_e41f87a2_AZBST_RT_41d07691_2d2e_4c16_abef_6d252ef22282_externalid
          }
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
              locations: [
                'eastus2'
                'centralus'
              ]
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vaults_defaultVault815_name_resource 'Microsoft.RecoveryServices/vaults@2021-08-01' = {
  name: vaults_defaultVault815_name
  location: 'eastus2'
  tags: {
    CREATOR: 'Ilya Koyfman'
    'DATA PROFILE': 'INTERNAL'
    ENVIRONMENT: 'DEV'
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource servers_spkrjdevmssql01_name_resource 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: servers_spkrjdevmssql01_name
  location: 'eastus2'
  tags: {
    CREATOR: 'Ilya Koyfman'
    'DATA PROFILE': 'INTERNAL'
    ENVIRONMENT: 'DEV'
  }
  kind: 'v12.0'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    administratorLogin: 'spk-rj-dev-mssql-admin'
    version: '12.0'
    publicNetworkAccess: 'Enabled'
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'Group'
      login: 'Ilya Koyfman'
      sid: 'ac05ac47-c193-4228-a813-60718148434d'
      tenantId: 'fcf2ac97-6f3c-48da-912a-7a446e6b4f54'
    }
    restrictOutboundNetworkAccess: 'Disabled'
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_blob_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_SPK_DEV_RG_vnet_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_SPK_DEV_RG_vnet_name_resource
  name: 'AzureBastionSubnet'
  properties: {
    addressPrefix: '10.0.1.0/27'
    routeTable: {
      id: routeTables_e41f87a2_AZBST_RT_41d07691_2d2e_4c16_abef_6d252ef22282_externalid
    }
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
        locations: [
          'eastus2'
          'centralus'
        ]
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_SPK_DEV_RG_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_SPK_DEV_RG_vnet_name_resource
  name: 'default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
        locations: [
          'eastus2'
          'centralus'
        ]
      }
      {
        service: 'Microsoft.Sql'
        locations: [
          'eastus2'
        ]
      }
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource vaults_defaultVault815_name_DailyPolicy_kp2wg1ve 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_defaultVault815_name_resource
  name: 'DailyPolicy-kp2wg1ve'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2021-05-24T09:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2021-05-24T09:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault815_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_defaultVault815_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2021-05-25T03:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2021-05-25T03:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault815_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-08-01' = {
  parent: vaults_defaultVault815_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2021-05-25T03:30:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2021-05-25T03:30:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault815_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2021-08-01' = {
  parent: vaults_defaultVault815_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_defaultVault815_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2021-08-01' = {
  parent: vaults_defaultVault815_name_resource
  name: 'default'
  properties: {}
}

resource servers_spkrjdevmssql01_name_ActiveDirectory 'Microsoft.Sql/servers/administrators@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ActiveDirectory'
  properties: {
    administratorType: 'ActiveDirectory'
    login: 'Ilya Koyfman'
    sid: 'ac05ac47-c193-4228-a813-60718148434d'
    tenantId: 'fcf2ac97-6f3c-48da-912a-7a446e6b4f54'
  }
}

resource servers_spkrjdevmssql01_name_CreateIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_spkrjdevmssql01_name_DbParameterization 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_spkrjdevmssql01_name_DefragmentIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_spkrjdevmssql01_name_DropIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_spkrjdevmssql01_name_ForceLastGoodPlan 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
}

resource servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/auditingPolicies@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'default'
  location: 'East US 2'
  properties: {
    auditingState: 'Disabled'
  }
}

resource Microsoft_Sql_servers_auditingSettings_servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/auditingSettings@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Sql_servers_azureADOnlyAuthentications_servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/azureADOnlyAuthentications@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Default'
  properties: {
    azureADOnlyAuthentication: false
  }
}

resource Microsoft_Sql_servers_connectionPolicies_servers_spkrjdevmssql01_name_default 'Microsoft.Sql/servers/connectionPolicies@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'default'
  location: 'eastus2'
  properties: {
    connectionType: 'Default'
  }
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01 'Microsoft.Sql/servers/databases@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'SPK-RJ-DEV-MSSQL-01'
  location: 'eastus2'
  tags: {
    CREATOR: 'Ilya Koyfman'
    ENVIRONMENT: 'DEV'
    'DATA PROFILE': 'INTERNAL'
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 800
  }
  kind: 'v12.0,user'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 268435456000
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Zone'
    maintenanceConfigurationId: '/subscriptions/fd8ea382-65ba-4762-b92b-0bcf7f50f797/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
  }
}

resource servers_spkrjdevmssql01_name_master_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  name: '${servers_spkrjdevmssql01_name}/master/Default'
  location: 'East US 2'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_spkrjdevmssql01_name_master_Default 'Microsoft.Sql/servers/databases/auditingSettings@2021-05-01-preview' = {
  name: '${servers_spkrjdevmssql01_name}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_spkrjdevmssql01_name_master_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2021-05-01-preview' = {
  name: '${servers_spkrjdevmssql01_name}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_spkrjdevmssql01_name_master_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2014-04-01' = {
  name: '${servers_spkrjdevmssql01_name}/master/Default'
  location: 'East US 2'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_master_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2021-05-01-preview' = {
  name: '${servers_spkrjdevmssql01_name}/master/Current'
  properties: {}
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_spkrjdevmssql01_name_master_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2021-05-01-preview' = {
  name: '${servers_spkrjdevmssql01_name}/master/Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_spkrjdevmssql01_name_master_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2021-05-01-preview' = {
  name: '${servers_spkrjdevmssql01_name}/master/Current'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_spkrjdevmssql01_name_master_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2021-05-01-preview' = {
  name: '${servers_spkrjdevmssql01_name}/master/Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_devOpsAuditingSettings_servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/devOpsAuditingSettings@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_spkrjdevmssql01_name_current 'Microsoft.Sql/servers/encryptionProtector@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'current'
  kind: 'servicemanaged'
  properties: {
    serverKeyName: 'ServiceManaged'
    serverKeyType: 'ServiceManaged'
    autoRotationEnabled: false
  }
}

resource Microsoft_Sql_servers_extendedAuditingSettings_servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/extendedAuditingSettings@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_spkrjdevmssql01_name_8th_Workstations 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: '8th-Workstations'
  properties: {
    startIpAddress: '38.104.67.178'
    endIpAddress: '38.104.67.178'
  }
}

resource servers_spkrjdevmssql01_name_92nd_Workstations 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: '92nd-Workstations'
  properties: {
    startIpAddress: '65.206.80.41'
    endIpAddress: '65.206.80.41'
  }
}

resource servers_spkrjdevmssql01_name_AllowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource servers_spkrjdevmssql01_name_Christine_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Christine-Home'
  properties: {
    startIpAddress: '104.9.35.35'
    endIpAddress: '104.9.35.35'
  }
}

resource servers_spkrjdevmssql01_name_ClientIPAddress_2021_06_16_08_52_49 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ClientIPAddress_2021-06-16_08:52:49'
  properties: {
    startIpAddress: '173.70.227.228'
    endIpAddress: '173.70.227.228'
  }
}

resource servers_spkrjdevmssql01_name_ClientIPAddress_2021_07_07_03_28_29 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ClientIPAddress_2021-07-07_03:28:29'
  properties: {
    startIpAddress: '207.38.247.43'
    endIpAddress: '207.38.247.43'
  }
}

resource servers_spkrjdevmssql01_name_ClientIPAddress_2021_07_08_03_39_21 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ClientIPAddress_2021-07-08_03:39:21'
  properties: {
    startIpAddress: '12.182.246.98'
    endIpAddress: '12.182.246.98'
  }
}

resource servers_spkrjdevmssql01_name_ClientIPAddress_2021_12_17_9_29_6 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ClientIPAddress_2021-12-17_9-29-6'
  properties: {
    startIpAddress: '174.198.196.51'
    endIpAddress: '174.198.196.51'
  }
}

resource servers_spkrjdevmssql01_name_Ilya_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Ilya-Home'
  properties: {
    startIpAddress: '24.228.81.222'
    endIpAddress: '24.228.81.222'
  }
}

resource servers_spkrjdevmssql01_name_Jay_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Jay Home'
  properties: {
    startIpAddress: '71.104.23.3'
    endIpAddress: '71.104.23.3'
  }
}

resource servers_spkrjdevmssql01_name_Jay_Home_2 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Jay Home 2'
  properties: {
    startIpAddress: '47.184.111.184'
    endIpAddress: '47.184.111.184'
  }
}

resource servers_spkrjdevmssql01_name_JonathanF_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'JonathanF-Home'
  properties: {
    startIpAddress: '66.44.115.11'
    endIpAddress: '66.44.115.11'
  }
}

resource servers_spkrjdevmssql01_name_Lucia_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Lucia-Home'
  properties: {
    startIpAddress: '108.14.4.105'
    endIpAddress: '108.14.4.105'
  }
}

resource servers_spkrjdevmssql01_name_Prannoy_s_Laptop 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Prannoy\'s Laptop'
  properties: {
    startIpAddress: '173.70.67.159'
    endIpAddress: '173.70.67.159'
  }
}

resource servers_spkrjdevmssql01_name_Priyanka_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Priyanka-Home'
  properties: {
    startIpAddress: '73.193.238.159'
    endIpAddress: '73.193.238.159'
  }
}

resource servers_spkrjdevmssql01_name_Priyanka_Home1 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Priyanka-Home1'
  properties: {
    startIpAddress: '98.110.112.66'
    endIpAddress: '98.110.112.66'
  }
}

resource servers_spkrjdevmssql01_name_query_editor_b15b06 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'query-editor-b15b06'
  properties: {
    startIpAddress: '96.232.199.214'
    endIpAddress: '96.232.199.214'
  }
}

resource servers_spkrjdevmssql01_name_query_editor_f01609 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'query-editor-f01609'
  properties: {
    startIpAddress: '96.248.87.118'
    endIpAddress: '96.248.87.118'
  }
}

resource servers_spkrjdevmssql01_name_Suruchi_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Suruchi Home'
  properties: {
    startIpAddress: '24.228.254.104'
    endIpAddress: '24.228.254.104'
  }
}

resource servers_spkrjdevmssql01_name_Suruchi_Home_2 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Suruchi Home 2'
  properties: {
    startIpAddress: '173.72.1.181'
    endIpAddress: '173.72.1.181'
  }
}

resource servers_spkrjdevmssql01_name_Thomas_Home 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Thomas Home'
  properties: {
    startIpAddress: '72.229.109.179'
    endIpAddress: '72.229.109.179'
  }
}

resource servers_spkrjdevmssql01_name_ServiceManaged 'Microsoft.Sql/servers/keys@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'ServiceManaged'
  kind: 'servicemanaged'
  properties: {
    serverKeyType: 'ServiceManaged'
  }
}

resource Microsoft_Sql_servers_securityAlertPolicies_servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/securityAlertPolicies@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource Microsoft_Sql_servers_vulnerabilityAssessments_servers_spkrjdevmssql01_name_Default 'Microsoft.Sql/servers/vulnerabilityAssessments@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_resource
  name: 'default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_rvfjnnidc3jfu 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'rvfjnnidc3jfu'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_SPK_DEV_RG_vnet_name_resource.id
    }
  }
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_CreateIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_DbParameterization 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_DefragmentIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_DropIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_ForceLastGoodPlan 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  location: 'East US 2'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Default 'Microsoft.Sql/servers/databases/auditingSettings@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  properties: {
    weeklyRetention: 'PT0S'
    monthlyRetention: 'PT0S'
    yearlyRetention: 'PT0S'
    weekOfYear: 0
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  properties: {
    retentionDays: 7
    diffBackupIntervalInHours: 24
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2014-04-01' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'Default'
  location: 'East US 2'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'current'
  properties: {}
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'current'
  properties: {
    state: 'Enabled'
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2021-05-01-preview' = {
  parent: servers_spkrjdevmssql01_name_SPK_RJ_DEV_MSSQL_01
  name: 'default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    servers_spkrjdevmssql01_name_resource
  ]
}