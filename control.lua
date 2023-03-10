--control.lua

script.on_event({defines.events.on_tick},
function (e)
   if e.tick % 30 == 15 then -- 60 ticks per second, so check every half-second, offset a bit
      for pl_idx,player in pairs(game.connected_players) do -- loop through all players on the server
         local chunk_radius = settings.global['tree-cleaner-chunk-range'].value
         local top_left     = {x = player.position.x-chunk_radius*32, y = player.position.y-chunk_radius*32}
         local bottom_right = {x = player.position.x+chunk_radius*32, y = player.position.y+chunk_radius*32}
         local tree_filter = {}
         if settings.global['tree-cleaner-cliffs-too'].value then
            -- player.print("DEBUG(TC): Including cliffs")
            tree_filter = {area={top_left,bottom_right}, type={"tree","cliff"}}
         else
            -- player.print("DEBUG(TC): Excluding cliffs")
            tree_filter = {area={top_left,bottom_right}, type={"tree"}}
         end
         -- player.print("DEBUG(TC): Tree_List type:" .. type(tree_filter))
         for index,tree in pairs(player.surface.find_entities_filtered(tree_filter)) do
            if ((tree.type == "tree" and tree.tree_stage_index == tree.tree_stage_index_max) or tree.type == "cliff") and not(tree.to_be_deconstructed()) then
               tree.order_deconstruction(game.forces["player"])
            end
         end
      end
   end
end
)
