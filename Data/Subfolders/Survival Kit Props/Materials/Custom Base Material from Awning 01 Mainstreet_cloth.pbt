Assets {
  Id: 14341539702205842672
  Name: "Custom Base Material from Awning 01 Mainstreet_cloth"
  PlatformAssetType: 13
  SerializationVersion: 108
  CustomMaterialAsset {
    BaseMaterialId: 14698361118776676393
    ParameterOverrides {
      Overrides {
        Name: "wind_intensity"
        Float: 10
      }
      Overrides {
        Name: "wind_speed"
        Float: 1
      }
    }
    Assets {
      Id: 14698361118776676393
      Name: "Striped Awning"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_striped_awning_001_uv_ref"
      }
    }
  }
}
