# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: POGOProtos.Networking.Responses.proto

require 'google/protobuf'

require_relative 'pogoprotos_data'
require_relative 'pogoprotos_inventory'
require_relative 'pogoprotos_data_capture'
require_relative 'pogoprotos_map_pokemon'
require_relative 'pogoprotos_data_logs'
require_relative 'pogoprotos_settings'
require_relative 'pogoprotos_inventory_item'
require_relative 'pogoprotos_data_battle'
require_relative 'pogoprotos_data_gym'
require_relative 'pogoprotos_data_player'
require_relative 'pogoprotos_enums'
require_relative 'pogoprotos_settings_master'
require_relative 'pogoprotos_map_fort'
require_relative 'pogoprotos_map'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "POGOProtos.Networking.Responses.SetContactSettingsResponse" do
    optional :status, :enum, 1, "POGOProtos.Networking.Responses.SetContactSettingsResponse.Status"
    optional :player_data, :message, 2, "POGOProtos.Data.PlayerData"
  end
  add_enum "POGOProtos.Networking.Responses.SetContactSettingsResponse.Status" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :FAILURE, 2
  end
  add_message "POGOProtos.Networking.Responses.SetPlayerTeamResponse" do
    optional :status, :enum, 1, "POGOProtos.Networking.Responses.SetPlayerTeamResponse.Status"
    optional :player_data, :message, 2, "POGOProtos.Data.PlayerData"
  end
  add_enum "POGOProtos.Networking.Responses.SetPlayerTeamResponse.Status" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :TEAM_ALREADY_SET, 2
    value :FAILURE, 3
  end
  add_message "POGOProtos.Networking.Responses.UpgradePokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UpgradePokemonResponse.Result"
    optional :upgraded_pokemon, :message, 2, "POGOProtos.Data.PokemonData"
  end
  add_enum "POGOProtos.Networking.Responses.UpgradePokemonResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_POKEMON_NOT_FOUND, 2
    value :ERROR_INSUFFICIENT_RESOURCES, 3
    value :ERROR_UPGRADE_NOT_AVAILABLE, 4
    value :ERROR_POKEMON_IS_DEPLOYED, 5
  end
  add_message "POGOProtos.Networking.Responses.UseItemEggIncubatorResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UseItemEggIncubatorResponse.Result"
    optional :egg_incubator, :message, 2, "POGOProtos.Inventory.EggIncubator"
  end
  add_enum "POGOProtos.Networking.Responses.UseItemEggIncubatorResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_INCUBATOR_NOT_FOUND, 2
    value :ERROR_POKEMON_EGG_NOT_FOUND, 3
    value :ERROR_POKEMON_ID_NOT_EGG, 4
    value :ERROR_INCUBATOR_ALREADY_IN_USE, 5
    value :ERROR_POKEMON_ALREADY_INCUBATING, 6
    value :ERROR_INCUBATOR_NO_USES_REMAINING, 7
  end
  add_message "POGOProtos.Networking.Responses.EncounterResponse" do
    optional :wild_pokemon, :message, 1, "POGOProtos.Map.Pokemon.WildPokemon"
    optional :background, :enum, 2, "POGOProtos.Networking.Responses.EncounterResponse.Background"
    optional :status, :enum, 3, "POGOProtos.Networking.Responses.EncounterResponse.Status"
    optional :capture_probability, :message, 4, "POGOProtos.Data.Capture.CaptureProbability"
  end
  add_enum "POGOProtos.Networking.Responses.EncounterResponse.Background" do
    value :PARK, 0
    value :DESERT, 1
  end
  add_enum "POGOProtos.Networking.Responses.EncounterResponse.Status" do
    value :ENCOUNTER_ERROR, 0
    value :ENCOUNTER_SUCCESS, 1
    value :ENCOUNTER_NOT_FOUND, 2
    value :ENCOUNTER_CLOSED, 3
    value :ENCOUNTER_POKEMON_FLED, 4
    value :ENCOUNTER_NOT_IN_RANGE, 5
    value :ENCOUNTER_ALREADY_HAPPENED, 6
    value :POKEMON_INVENTORY_FULL, 7
  end
  add_message "POGOProtos.Networking.Responses.FortRecallPokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.FortRecallPokemonResponse.Result"
    optional :fort_details, :message, 2, "POGOProtos.Networking.Responses.FortDetailsResponse"
  end
  add_enum "POGOProtos.Networking.Responses.FortRecallPokemonResponse.Result" do
    value :NO_RESULT_SET, 0
    value :SUCCESS, 1
    value :ERROR_NOT_IN_RANGE, 2
    value :ERROR_POKEMON_NOT_ON_FORT, 3
    value :ERROR_NO_PLAYER, 4
  end
  add_message "POGOProtos.Networking.Responses.UseItemPotionResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UseItemPotionResponse.Result"
    optional :stamina, :int32, 2
  end
  add_enum "POGOProtos.Networking.Responses.UseItemPotionResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_NO_POKEMON, 2
    value :ERROR_CANNOT_USE, 3
    value :ERROR_DEPLOYED_TO_FORT, 4
  end
  add_message "POGOProtos.Networking.Responses.GetSuggestedCodenamesResponse" do
    repeated :codenames, :string, 1
    optional :success, :bool, 2
  end
  add_message "POGOProtos.Networking.Responses.DownloadRemoteConfigVersionResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.DownloadRemoteConfigVersionResponse.Result"
    optional :item_templates_timestamp_ms, :uint64, 2
    optional :asset_digest_timestamp_ms, :uint64, 3
  end
  add_enum "POGOProtos.Networking.Responses.DownloadRemoteConfigVersionResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
  end
  add_message "POGOProtos.Networking.Responses.SfidaActionLogResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.SfidaActionLogResponse.Result"
    repeated :log_entries, :message, 2, "POGOProtos.Data.Logs.ActionLogEntry"
  end
  add_enum "POGOProtos.Networking.Responses.SfidaActionLogResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
  end
  add_message "POGOProtos.Networking.Responses.DownloadSettingsResponse" do
    optional :error, :string, 1
    optional :hash, :string, 2
    optional :settings, :message, 3, "POGOProtos.Settings.GlobalSettings"
  end
  add_message "POGOProtos.Networking.Responses.GetDownloadUrlsResponse" do
    repeated :download_urls, :message, 1, "POGOProtos.Data.DownloadUrlEntry"
  end
  add_message "POGOProtos.Networking.Responses.EchoResponse" do
    optional :context, :string, 1
  end
  add_message "POGOProtos.Networking.Responses.GetAssetDigestResponse" do
    repeated :digest, :message, 1, "POGOProtos.Data.AssetDigestEntry"
    optional :timestamp_ms, :uint64, 2
  end
  add_message "POGOProtos.Networking.Responses.GetPlayerProfileResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.GetPlayerProfileResponse.Result"
    optional :start_time, :int64, 2
    repeated :badges, :message, 3, "POGOProtos.Data.PlayerBadge"
  end
  add_enum "POGOProtos.Networking.Responses.GetPlayerProfileResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
  end
  add_message "POGOProtos.Networking.Responses.UseItemGymResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UseItemGymResponse.Result"
    optional :updated_gp, :int64, 2
  end
  add_enum "POGOProtos.Networking.Responses.UseItemGymResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_CANNOT_USE, 2
    value :ERROR_NOT_IN_RANGE, 3
  end
  add_message "POGOProtos.Networking.Responses.FortSearchResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.FortSearchResponse.Result"
    repeated :items_awarded, :message, 2, "POGOProtos.Inventory.Item.ItemAward"
    optional :gems_awarded, :int32, 3
    optional :pokemon_data_egg, :message, 4, "POGOProtos.Data.PokemonData"
    optional :experience_awarded, :int32, 5
    optional :cooldown_complete_timestamp_ms, :int64, 6
    optional :chain_hack_sequence_number, :int32, 7
  end
  add_enum "POGOProtos.Networking.Responses.FortSearchResponse.Result" do
    value :NO_RESULT_SET, 0
    value :SUCCESS, 1
    value :OUT_OF_RANGE, 2
    value :IN_COOLDOWN_PERIOD, 3
    value :INVENTORY_FULL, 4
  end
  add_message "POGOProtos.Networking.Responses.GetHatchedEggsResponse" do
    optional :success, :bool, 1
    repeated :pokemon_id, :fixed64, 2
    repeated :experience_awarded, :int32, 3
    repeated :candy_awarded, :int32, 4
    repeated :stardust_awarded, :int32, 5
  end
  add_message "POGOProtos.Networking.Responses.UseItemXpBoostResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UseItemXpBoostResponse.Result"
    optional :applied_items, :message, 2, "POGOProtos.Inventory.AppliedItems"
  end
  add_enum "POGOProtos.Networking.Responses.UseItemXpBoostResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_INVALID_ITEM_TYPE, 2
    value :ERROR_XP_BOOST_ALREADY_ACTIVE, 3
    value :ERROR_NO_ITEMS_REMAINING, 4
    value :ERROR_LOCATION_UNSET, 5
  end
  add_message "POGOProtos.Networking.Responses.StartGymBattleResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.StartGymBattleResponse.Result"
    optional :battle_start_timestamp_ms, :int64, 2
    optional :battle_end_timestamp_ms, :int64, 3
    optional :battle_id, :string, 4
    optional :defender, :message, 5, "POGOProtos.Data.Battle.BattleParticipant"
    optional :battle_log, :message, 6, "POGOProtos.Data.Battle.BattleLog"
  end
  add_enum "POGOProtos.Networking.Responses.StartGymBattleResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_GYM_NOT_FOUND, 2
    value :ERROR_GYM_NEUTRAL, 3
    value :ERROR_GYM_WRONG_TEAM, 4
    value :ERROR_GYM_EMPTY, 5
    value :ERROR_INVALID_DEFENDER, 6
    value :ERROR_TRAINING_INVALID_ATTACKER_COUNT, 7
    value :ERROR_ALL_POKEMON_FAINTED, 8
    value :ERROR_TOO_MANY_BATTLES, 9
    value :ERROR_TOO_MANY_PLAYERS, 10
    value :ERROR_GYM_BATTLE_LOCKOUT, 11
    value :ERROR_PLAYER_BELOW_MINIMUM_LEVEL, 12
    value :ERROR_NOT_IN_RANGE, 13
  end
  add_message "POGOProtos.Networking.Responses.IncenseEncounterResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.IncenseEncounterResponse.Result"
    optional :pokemon_data, :message, 2, "POGOProtos.Data.PokemonData"
    optional :capture_probability, :message, 3, "POGOProtos.Data.Capture.CaptureProbability"
  end
  add_enum "POGOProtos.Networking.Responses.IncenseEncounterResponse.Result" do
    value :INCENSE_ENCOUNTER_UNKNOWN, 0
    value :INCENSE_ENCOUNTER_SUCCESS, 1
    value :INCENSE_ENCOUNTER_NOT_AVAILABLE, 2
    value :POKEMON_INVENTORY_FULL, 3
  end
  add_message "POGOProtos.Networking.Responses.GetGymDetailsResponse" do
    optional :gym_state, :message, 1, "POGOProtos.Data.Gym.GymState"
    optional :name, :string, 2
    repeated :urls, :string, 3
    optional :result, :enum, 4, "POGOProtos.Networking.Responses.GetGymDetailsResponse.Result"
    optional :description, :string, 5
  end
  add_enum "POGOProtos.Networking.Responses.GetGymDetailsResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_NOT_IN_RANGE, 2
  end
  add_message "POGOProtos.Networking.Responses.SetFavoritePokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.SetFavoritePokemonResponse.Result"
  end
  add_enum "POGOProtos.Networking.Responses.SetFavoritePokemonResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_POKEMON_NOT_FOUND, 2
    value :ERROR_POKEMON_IS_EGG, 3
  end
  add_message "POGOProtos.Networking.Responses.EvolvePokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.EvolvePokemonResponse.Result"
    optional :evolved_pokemon_data, :message, 2, "POGOProtos.Data.PokemonData"
    optional :experience_awarded, :int32, 3
    optional :candy_awarded, :int32, 4
  end
  add_enum "POGOProtos.Networking.Responses.EvolvePokemonResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :FAILED_POKEMON_MISSING, 2
    value :FAILED_INSUFFICIENT_RESOURCES, 3
    value :FAILED_POKEMON_CANNOT_EVOLVE, 4
    value :FAILED_POKEMON_IS_DEPLOYED, 5
  end
  add_message "POGOProtos.Networking.Responses.GetInventoryResponse" do
    optional :success, :bool, 1
    optional :inventory_delta, :message, 2, "POGOProtos.Inventory.InventoryDelta"
  end
  add_message "POGOProtos.Networking.Responses.EquipBadgeResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.EquipBadgeResponse.Result"
    optional :equipped, :message, 2, "POGOProtos.Data.Player.EquippedBadge"
  end
  add_enum "POGOProtos.Networking.Responses.EquipBadgeResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :COOLDOWN_ACTIVE, 2
    value :NOT_QUALIFIED, 3
  end
  add_message "POGOProtos.Networking.Responses.CheckAwardedBadgesResponse" do
    optional :success, :bool, 1
    repeated :awarded_badges, :enum, 2, "POGOProtos.Enums.BadgeType"
    repeated :awarded_badge_levels, :int32, 3
  end
  add_message "POGOProtos.Networking.Responses.NicknamePokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.NicknamePokemonResponse.Result"
  end
  add_enum "POGOProtos.Networking.Responses.NicknamePokemonResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_INVALID_NICKNAME, 2
    value :ERROR_POKEMON_NOT_FOUND, 3
    value :ERROR_POKEMON_IS_EGG, 4
  end
  add_message "POGOProtos.Networking.Responses.DownloadItemTemplatesResponse" do
    optional :success, :bool, 1
    repeated :item_templates, :message, 2, "POGOProtos.Networking.Responses.DownloadItemTemplatesResponse.ItemTemplate"
    optional :timestamp_ms, :uint64, 3
  end
  add_message "POGOProtos.Networking.Responses.DownloadItemTemplatesResponse.ItemTemplate" do
    optional :template_id, :string, 1
    optional :pokemon_settings, :message, 2, "POGOProtos.Settings.Master.PokemonSettings"
    optional :item_settings, :message, 3, "POGOProtos.Settings.Master.ItemSettings"
    optional :move_settings, :message, 4, "POGOProtos.Settings.Master.MoveSettings"
    optional :move_sequence_settings, :message, 5, "POGOProtos.Settings.Master.MoveSequenceSettings"
    optional :type_effective, :message, 8, "POGOProtos.Settings.Master.TypeEffectiveSettings"
    optional :badge_settings, :message, 10, "POGOProtos.Settings.Master.BadgeSettings"
    optional :camera, :message, 11, "POGOProtos.Settings.Master.CameraSettings"
    optional :player_level, :message, 12, "POGOProtos.Settings.Master.PlayerLevelSettings"
    optional :gym_level, :message, 13, "POGOProtos.Settings.Master.GymLevelSettings"
    optional :battle_settings, :message, 14, "POGOProtos.Settings.Master.GymBattleSettings"
    optional :encounter_settings, :message, 15, "POGOProtos.Settings.Master.EncounterSettings"
    optional :iap_item_display, :message, 16, "POGOProtos.Settings.Master.IapItemDisplay"
    optional :iap_settings, :message, 17, "POGOProtos.Settings.Master.IapSettings"
    optional :pokemon_upgrades, :message, 18, "POGOProtos.Settings.Master.PokemonUpgradeSettings"
    optional :equipped_badges, :message, 19, "POGOProtos.Settings.Master.EquippedBadgeSettings"
  end
  add_message "POGOProtos.Networking.Responses.UseItemCaptureResponse" do
    optional :success, :bool, 1
    optional :item_capture_mult, :double, 2
    optional :item_flee_mult, :double, 3
    optional :stop_movement, :bool, 4
    optional :stop_attack, :bool, 5
    optional :target_max, :bool, 6
    optional :target_slow, :bool, 7
  end
  add_message "POGOProtos.Networking.Responses.DiskEncounterResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.DiskEncounterResponse.Result"
    optional :pokemon_data, :message, 2, "POGOProtos.Data.PokemonData"
    optional :capture_probability, :message, 3, "POGOProtos.Data.Capture.CaptureProbability"
  end
  add_enum "POGOProtos.Networking.Responses.DiskEncounterResponse.Result" do
    value :UNKNOWN, 0
    value :SUCCESS, 1
    value :NOT_AVAILABLE, 2
    value :NOT_IN_RANGE, 3
    value :ENCOUNTER_ALREADY_FINISHED, 4
    value :POKEMON_INVENTORY_FULL, 5
  end
  add_message "POGOProtos.Networking.Responses.LevelUpRewardsResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.LevelUpRewardsResponse.Result"
    repeated :items_awarded, :message, 2, "POGOProtos.Inventory.Item.ItemAward"
    repeated :items_unlocked, :enum, 4, "POGOProtos.Inventory.Item.ItemId"
  end
  add_enum "POGOProtos.Networking.Responses.LevelUpRewardsResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :AWARDED_ALREADY, 2
  end
  add_message "POGOProtos.Networking.Responses.PlayerUpdateResponse" do
    repeated :wild_pokemons, :message, 1, "POGOProtos.Map.Pokemon.WildPokemon"
    repeated :forts, :message, 2, "POGOProtos.Map.Fort.FortData"
    optional :forts_nearby, :int32, 3
  end
  add_message "POGOProtos.Networking.Responses.MarkTutorialCompleteResponse" do
    optional :success, :bool, 1
    optional :player_data, :message, 2, "POGOProtos.Data.PlayerData"
  end
  add_message "POGOProtos.Networking.Responses.ReleasePokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.ReleasePokemonResponse.Result"
    optional :candy_awarded, :int32, 2
  end
  add_enum "POGOProtos.Networking.Responses.ReleasePokemonResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :POKEMON_DEPLOYED, 2
    value :FAILED, 3
    value :ERROR_POKEMON_IS_EGG, 4
  end
  add_message "POGOProtos.Networking.Responses.CollectDailyDefenderBonusResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.CollectDailyDefenderBonusResponse.Result"
    repeated :currency_type, :string, 2
    repeated :currency_awarded, :int32, 3
    optional :defenders_count, :int32, 4
  end
  add_enum "POGOProtos.Networking.Responses.CollectDailyDefenderBonusResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :FAILURE, 2
    value :TOO_SOON, 3
    value :NO_DEFENDERS, 4
  end
  add_message "POGOProtos.Networking.Responses.GetMapObjectsResponse" do
    repeated :map_cells, :message, 1, "POGOProtos.Map.MapCell"
    optional :status, :enum, 2, "POGOProtos.Map.MapObjectsStatus"
  end
  add_message "POGOProtos.Networking.Responses.CheckCodenameAvailableResponse" do
    optional :codename, :string, 1
    optional :user_message, :string, 2
    optional :is_assignable, :bool, 3
    optional :status, :enum, 4, "POGOProtos.Networking.Responses.CheckCodenameAvailableResponse.Status"
  end
  add_enum "POGOProtos.Networking.Responses.CheckCodenameAvailableResponse.Status" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :CODENAME_NOT_AVAILABLE, 2
    value :CODENAME_NOT_VALID, 3
    value :CURRENT_OWNER, 4
    value :CODENAME_CHANGE_NOT_ALLOWED, 5
  end
  add_message "POGOProtos.Networking.Responses.UseIncenseResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UseIncenseResponse.Result"
    optional :applied_incense, :message, 2, "POGOProtos.Inventory.AppliedItem"
  end
  add_enum "POGOProtos.Networking.Responses.UseIncenseResponse.Result" do
    value :UNKNOWN, 0
    value :SUCCESS, 1
    value :INCENSE_ALREADY_ACTIVE, 2
    value :NONE_IN_INVENTORY, 3
    value :LOCATION_UNSET, 4
  end
  add_message "POGOProtos.Networking.Responses.ClaimCodenameResponse" do
    optional :codename, :string, 1
    optional :user_message, :string, 2
    optional :is_assignable, :bool, 3
    optional :status, :enum, 4, "POGOProtos.Networking.Responses.ClaimCodenameResponse.Status"
  end
  add_enum "POGOProtos.Networking.Responses.ClaimCodenameResponse.Status" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :CODENAME_NOT_AVAILABLE, 2
    value :CODENAME_NOT_VALID, 3
    value :CURRENT_OWNER, 4
    value :CODENAME_CHANGE_NOT_ALLOWED, 5
  end
  add_message "POGOProtos.Networking.Responses.AddFortModifierResponse" do
  end
  add_message "POGOProtos.Networking.Responses.CatchPokemonResponse" do
    optional :status, :enum, 1, "POGOProtos.Networking.Responses.CatchPokemonResponse.CatchStatus"
    optional :miss_percent, :double, 2
    optional :captured_pokemon_id, :fixed64, 3
    optional :capture_award, :message, 4, "POGOProtos.Data.Capture.CaptureAward"
  end
  add_enum "POGOProtos.Networking.Responses.CatchPokemonResponse.CatchStatus" do
    value :CATCH_ERROR, 0
    value :CATCH_SUCCESS, 1
    value :CATCH_ESCAPE, 2
    value :CATCH_FLEE, 3
    value :CATCH_MISSED, 4
  end
  add_message "POGOProtos.Networking.Responses.UseItemReviveResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.UseItemReviveResponse.Result"
    optional :stamina, :int32, 2
  end
  add_enum "POGOProtos.Networking.Responses.UseItemReviveResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_NO_POKEMON, 2
    value :ERROR_CANNOT_USE, 3
    value :ERROR_DEPLOYED_TO_FORT, 4
  end
  add_message "POGOProtos.Networking.Responses.GetIncensePokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.GetIncensePokemonResponse.Result"
    optional :pokemon_id, :enum, 2, "POGOProtos.Enums.PokemonId"
    optional :latitude, :double, 3
    optional :longitude, :double, 4
    optional :encounter_location, :string, 5
    optional :encounter_id, :fixed64, 6
    optional :disappear_timestamp_ms, :int64, 7
  end
  add_enum "POGOProtos.Networking.Responses.GetIncensePokemonResponse.Result" do
    value :INCENSE_ENCOUNTER_UNKNOWN, 0
    value :INCENSE_ENCOUNTER_AVAILABLE, 1
    value :INCENSE_ENCOUNTER_NOT_AVAILABLE, 2
  end
  add_message "POGOProtos.Networking.Responses.FortDetailsResponse" do
    optional :fort_id, :string, 1
    optional :team_color, :enum, 2, "POGOProtos.Enums.TeamColor"
    optional :pokemon_data, :message, 3, "POGOProtos.Data.PokemonData"
    optional :name, :string, 4
    repeated :image_urls, :string, 5
    optional :fp, :int32, 6
    optional :stamina, :int32, 7
    optional :max_stamina, :int32, 8
    optional :type, :enum, 9, "POGOProtos.Map.Fort.FortType"
    optional :latitude, :double, 10
    optional :longitude, :double, 11
    optional :description, :string, 12
    repeated :modifiers, :message, 13, "POGOProtos.Map.Fort.FortModifier"
  end
  add_message "POGOProtos.Networking.Responses.CollectDailyBonusResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.CollectDailyBonusResponse.Result"
  end
  add_enum "POGOProtos.Networking.Responses.CollectDailyBonusResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :FAILURE, 2
    value :TOO_SOON, 3
  end
  add_message "POGOProtos.Networking.Responses.EncounterTutorialCompleteResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.EncounterTutorialCompleteResponse.Result"
    optional :pokemon_data, :message, 2, "POGOProtos.Data.PokemonData"
    optional :capture_award, :message, 3, "POGOProtos.Data.Capture.CaptureAward"
  end
  add_enum "POGOProtos.Networking.Responses.EncounterTutorialCompleteResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_INVALID_POKEMON, 2
  end
  add_message "POGOProtos.Networking.Responses.RecycleInventoryItemResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.RecycleInventoryItemResponse.Result"
    optional :new_count, :int32, 2
  end
  add_enum "POGOProtos.Networking.Responses.RecycleInventoryItemResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_NOT_ENOUGH_COPIES, 2
    value :ERROR_CANNOT_RECYCLE_INCUBATORS, 3
  end
  add_message "POGOProtos.Networking.Responses.FortDeployPokemonResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.FortDeployPokemonResponse.Result"
    optional :fort_details, :message, 2, "POGOProtos.Networking.Responses.FortDetailsResponse"
    optional :pokemon_data, :message, 3, "POGOProtos.Data.PokemonData"
    optional :gym_state, :message, 4, "POGOProtos.Data.Gym.GymState"
  end
  add_enum "POGOProtos.Networking.Responses.FortDeployPokemonResponse.Result" do
    value :NO_RESULT_SET, 0
    value :SUCCESS, 1
    value :ERROR_ALREADY_HAS_POKEMON_ON_FORT, 2
    value :ERROR_OPPOSING_TEAM_OWNS_FORT, 3
    value :ERROR_FORT_IS_FULL, 4
    value :ERROR_NOT_IN_RANGE, 5
    value :ERROR_PLAYER_HAS_NO_TEAM, 6
    value :ERROR_POKEMON_NOT_FULL_HP, 7
    value :ERROR_PLAYER_BELOW_MINIMUM_LEVEL, 8
  end
  add_message "POGOProtos.Networking.Responses.SetAvatarResponse" do
    optional :status, :enum, 1, "POGOProtos.Networking.Responses.SetAvatarResponse.Status"
    optional :player_data, :message, 2, "POGOProtos.Data.PlayerData"
  end
  add_enum "POGOProtos.Networking.Responses.SetAvatarResponse.Status" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :AVATAR_ALREADY_SET, 2
    value :FAILURE, 3
  end
  add_message "POGOProtos.Networking.Responses.AttackGymResponse" do
    optional :result, :enum, 1, "POGOProtos.Networking.Responses.AttackGymResponse.Result"
    optional :battle_log, :message, 2, "POGOProtos.Data.Battle.BattleLog"
    optional :battle_id, :string, 3
    optional :active_defender, :message, 4, "POGOProtos.Data.Battle.BattlePokemonInfo"
    optional :active_attacker, :message, 5, "POGOProtos.Data.Battle.BattlePokemonInfo"
  end
  add_enum "POGOProtos.Networking.Responses.AttackGymResponse.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
    value :ERROR_INVALID_ATTACK_ACTIONS, 2
    value :ERROR_NOT_IN_RANGE, 3
  end
  add_message "POGOProtos.Networking.Responses.GetPlayerResponse" do
    optional :success, :bool, 1
    optional :player_data, :message, 2, "POGOProtos.Data.PlayerData"
  end
end

module POGOProtos
  module Networking
    module Responses
      SetContactSettingsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetContactSettingsResponse").msgclass
      SetContactSettingsResponse::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetContactSettingsResponse.Status").enummodule
      SetPlayerTeamResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetPlayerTeamResponse").msgclass
      SetPlayerTeamResponse::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetPlayerTeamResponse.Status").enummodule
      UpgradePokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UpgradePokemonResponse").msgclass
      UpgradePokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UpgradePokemonResponse.Result").enummodule
      UseItemEggIncubatorResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemEggIncubatorResponse").msgclass
      UseItemEggIncubatorResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemEggIncubatorResponse.Result").enummodule
      EncounterResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EncounterResponse").msgclass
      EncounterResponse::Background = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EncounterResponse.Background").enummodule
      EncounterResponse::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EncounterResponse.Status").enummodule
      FortRecallPokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortRecallPokemonResponse").msgclass
      FortRecallPokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortRecallPokemonResponse.Result").enummodule
      UseItemPotionResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemPotionResponse").msgclass
      UseItemPotionResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemPotionResponse.Result").enummodule
      GetSuggestedCodenamesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetSuggestedCodenamesResponse").msgclass
      DownloadRemoteConfigVersionResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DownloadRemoteConfigVersionResponse").msgclass
      DownloadRemoteConfigVersionResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DownloadRemoteConfigVersionResponse.Result").enummodule
      SfidaActionLogResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SfidaActionLogResponse").msgclass
      SfidaActionLogResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SfidaActionLogResponse.Result").enummodule
      DownloadSettingsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DownloadSettingsResponse").msgclass
      GetDownloadUrlsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetDownloadUrlsResponse").msgclass
      EchoResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EchoResponse").msgclass
      GetAssetDigestResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetAssetDigestResponse").msgclass
      GetPlayerProfileResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetPlayerProfileResponse").msgclass
      GetPlayerProfileResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetPlayerProfileResponse.Result").enummodule
      UseItemGymResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemGymResponse").msgclass
      UseItemGymResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemGymResponse.Result").enummodule
      FortSearchResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortSearchResponse").msgclass
      FortSearchResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortSearchResponse.Result").enummodule
      GetHatchedEggsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetHatchedEggsResponse").msgclass
      UseItemXpBoostResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemXpBoostResponse").msgclass
      UseItemXpBoostResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemXpBoostResponse.Result").enummodule
      StartGymBattleResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.StartGymBattleResponse").msgclass
      StartGymBattleResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.StartGymBattleResponse.Result").enummodule
      IncenseEncounterResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.IncenseEncounterResponse").msgclass
      IncenseEncounterResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.IncenseEncounterResponse.Result").enummodule
      GetGymDetailsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetGymDetailsResponse").msgclass
      GetGymDetailsResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetGymDetailsResponse.Result").enummodule
      SetFavoritePokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetFavoritePokemonResponse").msgclass
      SetFavoritePokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetFavoritePokemonResponse.Result").enummodule
      EvolvePokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EvolvePokemonResponse").msgclass
      EvolvePokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EvolvePokemonResponse.Result").enummodule
      GetInventoryResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetInventoryResponse").msgclass
      EquipBadgeResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EquipBadgeResponse").msgclass
      EquipBadgeResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EquipBadgeResponse.Result").enummodule
      CheckAwardedBadgesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CheckAwardedBadgesResponse").msgclass
      NicknamePokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.NicknamePokemonResponse").msgclass
      NicknamePokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.NicknamePokemonResponse.Result").enummodule
      DownloadItemTemplatesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DownloadItemTemplatesResponse").msgclass
      DownloadItemTemplatesResponse::ItemTemplate = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DownloadItemTemplatesResponse.ItemTemplate").msgclass
      UseItemCaptureResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemCaptureResponse").msgclass
      DiskEncounterResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DiskEncounterResponse").msgclass
      DiskEncounterResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.DiskEncounterResponse.Result").enummodule
      LevelUpRewardsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.LevelUpRewardsResponse").msgclass
      LevelUpRewardsResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.LevelUpRewardsResponse.Result").enummodule
      PlayerUpdateResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.PlayerUpdateResponse").msgclass
      MarkTutorialCompleteResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.MarkTutorialCompleteResponse").msgclass
      ReleasePokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.ReleasePokemonResponse").msgclass
      ReleasePokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.ReleasePokemonResponse.Result").enummodule
      CollectDailyDefenderBonusResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CollectDailyDefenderBonusResponse").msgclass
      CollectDailyDefenderBonusResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CollectDailyDefenderBonusResponse.Result").enummodule
      GetMapObjectsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetMapObjectsResponse").msgclass
      CheckCodenameAvailableResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CheckCodenameAvailableResponse").msgclass
      CheckCodenameAvailableResponse::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CheckCodenameAvailableResponse.Status").enummodule
      UseIncenseResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseIncenseResponse").msgclass
      UseIncenseResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseIncenseResponse.Result").enummodule
      ClaimCodenameResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.ClaimCodenameResponse").msgclass
      ClaimCodenameResponse::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.ClaimCodenameResponse.Status").enummodule
      AddFortModifierResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.AddFortModifierResponse").msgclass
      CatchPokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CatchPokemonResponse").msgclass
      CatchPokemonResponse::CatchStatus = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CatchPokemonResponse.CatchStatus").enummodule
      UseItemReviveResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemReviveResponse").msgclass
      UseItemReviveResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.UseItemReviveResponse.Result").enummodule
      GetIncensePokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetIncensePokemonResponse").msgclass
      GetIncensePokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetIncensePokemonResponse.Result").enummodule
      FortDetailsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortDetailsResponse").msgclass
      CollectDailyBonusResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CollectDailyBonusResponse").msgclass
      CollectDailyBonusResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.CollectDailyBonusResponse.Result").enummodule
      EncounterTutorialCompleteResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EncounterTutorialCompleteResponse").msgclass
      EncounterTutorialCompleteResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.EncounterTutorialCompleteResponse.Result").enummodule
      RecycleInventoryItemResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.RecycleInventoryItemResponse").msgclass
      RecycleInventoryItemResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.RecycleInventoryItemResponse.Result").enummodule
      FortDeployPokemonResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortDeployPokemonResponse").msgclass
      FortDeployPokemonResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.FortDeployPokemonResponse.Result").enummodule
      SetAvatarResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetAvatarResponse").msgclass
      SetAvatarResponse::Status = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.SetAvatarResponse.Status").enummodule
      AttackGymResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.AttackGymResponse").msgclass
      AttackGymResponse::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.AttackGymResponse.Result").enummodule
      GetPlayerResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Networking.Responses.GetPlayerResponse").msgclass
    end
  end
end