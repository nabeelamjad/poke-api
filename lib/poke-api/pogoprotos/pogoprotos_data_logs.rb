# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: POGOProtos.Data.Logs.proto

require 'google/protobuf'

require_relative 'pogoprotos_enums'
require_relative 'pogoprotos_inventory_item'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "POGOProtos.Data.Logs.ActionLogEntry" do
    optional :timestamp_ms, :int64, 1
    optional :sfida, :bool, 2
    oneof :Action do
      optional :catch_pokemon, :message, 3, "POGOProtos.Data.Logs.CatchPokemonLogEntry"
      optional :fort_search, :message, 4, "POGOProtos.Data.Logs.FortSearchLogEntry"
    end
  end
  add_message "POGOProtos.Data.Logs.CatchPokemonLogEntry" do
    optional :result, :enum, 1, "POGOProtos.Data.Logs.CatchPokemonLogEntry.Result"
    optional :pokemon_id, :enum, 2, "POGOProtos.Enums.PokemonId"
    optional :combat_points, :int32, 3
    optional :pokemon_data_id, :uint64, 4
  end
  add_enum "POGOProtos.Data.Logs.CatchPokemonLogEntry.Result" do
    value :UNSET, 0
    value :POKEMON_CAPTURED, 1
    value :POKEMON_FLED, 2
  end
  add_message "POGOProtos.Data.Logs.FortSearchLogEntry" do
    optional :result, :enum, 1, "POGOProtos.Data.Logs.FortSearchLogEntry.Result"
    optional :fort_id, :string, 2
    repeated :items, :message, 3, "POGOProtos.Inventory.Item.ItemData"
    optional :eggs, :int32, 4
  end
  add_enum "POGOProtos.Data.Logs.FortSearchLogEntry.Result" do
    value :UNSET, 0
    value :SUCCESS, 1
  end
end

module POGOProtos
  module Data
    module Logs
      ActionLogEntry = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Data.Logs.ActionLogEntry").msgclass
      CatchPokemonLogEntry = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Data.Logs.CatchPokemonLogEntry").msgclass
      CatchPokemonLogEntry::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Data.Logs.CatchPokemonLogEntry.Result").enummodule
      FortSearchLogEntry = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Data.Logs.FortSearchLogEntry").msgclass
      FortSearchLogEntry::Result = Google::Protobuf::DescriptorPool.generated_pool.lookup("POGOProtos.Data.Logs.FortSearchLogEntry.Result").enummodule
    end
  end
end
