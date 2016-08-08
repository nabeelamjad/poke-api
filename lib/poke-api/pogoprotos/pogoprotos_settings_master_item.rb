# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: POGOProtos.Settings.Master.Item.proto

require 'google/protobuf'

require_relative 'pogoprotos_enums'
require_relative 'pogoprotos_inventory'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "POGOProtos.Settings.Master.Item.PokeballAttributes" do
    optional :item_effect, :enum, 1, "POGOProtos.Enums.ItemEffect"
    optional :capture_multi, :float, 2
    optional :capture_multi_effect, :float, 3
    optional :item_effect_mod, :float, 4
  end
  add_message "POGOProtos.Settings.Master.Item.IncenseAttributes" do
    optional :incense_lifetime_seconds, :int32, 1
    repeated :pokemon_type, :enum, 2, "POGOProtos.Enums.PokemonType"
    optional :pokemon_incense_type_probability, :float, 3
    optional :standing_time_between_encounters_seconds, :int32, 4
    optional :moving_time_between_encounter_seconds, :int32, 5
    optional :distance_required_for_shorter_interval_meters, :int32, 6
    optional :pokemon_attracted_length_sec, :int32, 7
  end
  add_message "POGOProtos.Settings.Master.Item.PotionAttributes" do
    optional :sta_percent, :float, 1
    optional :sta_amount, :int32, 2
  end
  add_message "POGOProtos.Settings.Master.Item.BattleAttributes" do
    optional :sta_percent, :float, 1
  end
  add_message "POGOProtos.Settings.Master.Item.ReviveAttributes" do
    optional :sta_percent, :float, 1
  end
  add_message "POGOProtos.Settings.Master.Item.InventoryUpgradeAttributes" do
    optional :additional_storage, :int32, 1
    optional :upgrade_type, :enum, 2, "POGOProtos.Inventory.InventoryUpgradeType"
  end
  add_message "POGOProtos.Settings.Master.Item.EggIncubatorAttributes" do
    optional :incubator_type, :enum, 1, "POGOProtos.Inventory.EggIncubatorType"
    optional :uses, :int32, 2
    optional :distance_multiplier, :float, 3
  end
  add_message "POGOProtos.Settings.Master.Item.FortModifierAttributes" do
    optional :modifier_lifetime_seconds, :int32, 1
    optional :troy_disk_num_pokemon_spawned, :int32, 2
  end
  add_message "POGOProtos.Settings.Master.Item.ExperienceBoostAttributes" do
    optional :xp_multiplier, :float, 1
    optional :boost_duration_ms, :int32, 2
  end
  add_message "POGOProtos.Settings.Master.Item.FoodAttributes" do
    repeated :item_effect, :enum, 1, "POGOProtos.Enums.ItemEffect"
    repeated :item_effect_percent, :float, 2
    optional :growth_percent, :float, 3
  end
end

module POGOProtos
  module Settings
    module Master
      module Item
        PokeballAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.PokeballAttributes").msgclass
        IncenseAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.IncenseAttributes").msgclass
        PotionAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.PotionAttributes").msgclass
        BattleAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.BattleAttributes").msgclass
        ReviveAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.ReviveAttributes").msgclass
        InventoryUpgradeAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.InventoryUpgradeAttributes").msgclass
        EggIncubatorAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.EggIncubatorAttributes").msgclass
        FortModifierAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.FortModifierAttributes").msgclass
        ExperienceBoostAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.ExperienceBoostAttributes").msgclass
        FoodAttributes = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Settings.Master.Item.FoodAttributes").msgclass
      end
    end
  end
end
