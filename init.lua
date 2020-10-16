function give_legacy_loadout(player_entity, inventory)
	local inventory_items = EntityGetAllChildren(inventory)

	-- remove default items
	if inventory_items ~= nil then
		for i,item_entity in ipairs(inventory_items) do
			GameKillInventoryItem(player_entity, item_entity)
		end
	end

	-- add loadout items
	local starting_wand = EntityLoad("data/entities/items/starting_wand.xml")
	if starting_wand then
		EntityAddChild(inventory, starting_wand)
	end

	local starting_bomb_wand = EntityLoad("data/entities/items/starting_bomb_wand.xml")
	if starting_bomb_wand then
		EntityAddChild(inventory, starting_bomb_wand)
	end

	local water_potion = EntityLoad("data/entities/items/pickup/potion_water.xml")
	if water_potion then
		EntityAddChild(inventory, water_potion)
	end
end

function OnPlayerSpawned(player_entity) -- this runs when player entity has been created
	local init_check_flag = "legacy_loadout_init_done"
	if GameHasFlagRun(init_check_flag) then
		return
	end
	GameAddFlagRun(init_check_flag)

	local player_child_entities = EntityGetAllChildren(player_entity)
	if (player_child_entities ~= nil) then
		for i,child_entity in ipairs(player_child_entities) do
			local child_entity_name = EntityGetName(child_entity)
			if (child_entity_name == "inventory_quick") then
				give_legacy_loadout(player_entity, child_entity)
			end
		end
	end
end