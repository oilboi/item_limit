local item_limit_stack_max = 999 -- the max item limit per stack
minetest.register_on_mods_loaded(function()
  for i,a in pairs(minetest.registered_items) do
    print(a.name)
    minetest.override_item(a.name, {stack_max = item_limit_stack_max})
  end
end)
