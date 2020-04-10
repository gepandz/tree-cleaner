--control.lua

script.on_event({defines.events.on_tick},
   function (e)
      if e.tick % 30 == 0 then -- 60 ticks per second, so check every half-second
         for pl_idx,player in pairs(game.connected_players) do -- loop through all players on the server
	    local chunk_radius = settings.global['tree-cleaner-chunk-range'].value
	    local top_left     = {x = player.position.x-chunk_radius*32, y = player.position.y-chunk_radius*32}
	    local bottom_right = {x = player.position.x+chunk_radius*32, y = player.position.y+chunk_radius*32}
            for index,tree in pairs(game.surfaces["nauvis"].find_entities_filtered{area={top_left,bottom_right}, type="tree"}) do
               if tree.tree_stage_index == tree.tree_stage_index_max and not(tree.to_be_deconstructed()) then
                  tree.order_deconstruction(game.forces["player"])
               end
            end
         end
      end
   end
)
