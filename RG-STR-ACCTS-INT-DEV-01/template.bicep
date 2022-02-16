param storageAccounts_spkgensa01_name string = 'spkgensa01'
param storageAccounts_sainternaldev01_name string = 'sainternaldev01'

resource storageAccounts_sainternaldev01_name_resource 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccounts_sainternaldev01_name
  location: 'eastus2'
  tags: {
    CREATOR: 'Ilya Koyfman'
    ENVIRONMENT: 'DEV'
    'DATA PROFILE': 'INTERNAL'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_spkgensa01_name_resource 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccounts_spkgensa01_name
  location: 'eastus2'
  tags: {
    CREATOR: 'Ilya Koyfman'
    ENVIRONMENT: 'DEV'
    'DATA PROFILE': 'INTERNAL'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      resourceAccessRules: []
      bypass: 'Metrics, AzureServices'
      virtualNetworkRules: []
      ipRules: [
        {
          value: '173.70.227.228'
          action: 'Allow'
        }
        {
          value: '24.228.254.104'
          action: 'Allow'
        }
        {
          value: '40.84.22.15'
          action: 'Allow'
        }
      ]
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_sainternaldev01_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
    isVersioningEnabled: true
  }
}

resource storageAccounts_spkgensa01_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: true
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_sainternaldev01_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_spkgensa01_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_sainternaldev01_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_spkgensa01_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_sainternaldev01_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_spkgensa01_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_sainternaldev01_name_default_243b2742_4da3_4eff_a066_8ad9ced00aa7 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '243b2742-4da3-4eff-a066-8ad9ced00aa7'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_3c782826_8281_4a30_860a_94cabfc447cc 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '3c782826-8281-4a30-860a-94cabfc447cc'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_50a3b75d_9ea6_4955_a154_36c8786703a3 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '50a3b75d-9ea6-4955-a154-36c8786703a3'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_52b4b545_91ed_4c00_9f20_946781e7ab86 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '52b4b545-91ed-4c00-9f20-946781e7ab86'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_5bf5f528_6a1b_4235_9081_f9b3b73b8f03 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '5bf5f528-6a1b-4235-9081-f9b3b73b8f03'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_71486295_9fc9_4813_aa8f_8ce428dc0e87 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '71486295-9fc9-4813-aa8f-8ce428dc0e87'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_728c631b_4773_45bf_b745_9804c2fd73ad 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '728c631b-4773-45bf-b745-9804c2fd73ad'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_9dfb39c2_2d2e_451c_90d0_482441f63e2d 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '9dfb39c2-2d2e-451c-90d0-482441f63e2d'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_9fd1d401_a291_447a_896e_c9b07591ec75 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: '9fd1d401-a291-447a-896e-c9b07591ec75'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_a07c1468_f20d_4b05_a99a_f5d1193d224a 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'a07c1468-f20d-4b05-a99a-f5d1193d224a'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_a764d3db_5590_4297_9ec0_87201c48c634 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'a764d3db-5590-4297-9ec0-87201c48c634'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_spkgensa01_name_default_aws_transfer_blc01 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_default
  name: 'aws-transfer-blc01'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_spkgensa01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_bc565ac1_0837_4b3c_ace9_e218a7e4ecc9 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'bc565ac1-0837-4b3c-ace9-e218a7e4ecc9'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_c78bb268_4bf0_4d53_a309_ac5a8b154730 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'c78bb268-4bf0-4d53-a309-ac5a8b154730'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_datavault 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'datavault'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_eb1cd606_d555_4866_b9ed_4048d1a1fe6f 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'eb1cd606-d555-4866-b9ed-4048d1a1fe6f'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_infamdmextract 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'infamdmextract'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_inhouse 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'inhouse'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_spkgensa01_name_default_insights_logs_mysqlauditlogs 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_default
  name: 'insights-logs-mysqlauditlogs'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_spkgensa01_name_resource
  ]
}

resource storageAccounts_spkgensa01_name_default_insights_logs_mysqlslowlogs 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_default
  name: 'insights-logs-mysqlslowlogs'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_spkgensa01_name_resource
  ]
}

resource storageAccounts_spkgensa01_name_default_insights_metrics_pt1m 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_spkgensa01_name_default
  name: 'insights-metrics-pt1m'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_spkgensa01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_internalfile 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'internalfile'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_psi 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'psi'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_rjlogs 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'rjlogs'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_seeddata 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'seeddata'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_springboard 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'springboard'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_telemarketing 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  parent: storageAccounts_sainternaldev01_name_default
  name: 'telemarketing'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}

resource Microsoft_Storage_storageAccounts_fileServices_shares_storageAccounts_spkgensa01_name_default_aws_transfer_blc01 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-06-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_spkgensa01_name_default
  name: 'aws-transfer-blc01'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 20
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_spkgensa01_name_resource
  ]
}

resource storageAccounts_sainternaldev01_name_default_rj_log_fileshare_01 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-06-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_sainternaldev01_name_default
  name: 'rj-log-fileshare-01'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_sainternaldev01_name_resource
  ]
}