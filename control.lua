--control.lua

script.on_event({defines.events.on_tick},
   function (e)
      if e.tick % 30 == 0 then -- 60 ticks per second, so check every half-second
         for index,tree in pairs(game.surfaces["nauvis"].find_entities_filtered{type="tree"}) do
            if tree.tree_stage_index == tree.tree_stage_index_max and not(tree.to_be_deconstructed()) then
               tree.order_deconstruction(game.forces["player"])
            end
         end
      end
   end
)
