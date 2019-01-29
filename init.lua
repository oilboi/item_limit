local item_limit_stack_max = 999 ---the new stack max for all items

 local mod_storage = minetest.get_mod_storage() --initialize mod storage

--make this optional for true modularity
local depends_string = "optional_depends = " --create empty file list

--go through all installed mods
for _,modname in pairs(minetest.get_modnames()) do
  if modname ~= minetest.get_current_modname() then
    depends_string = depends_string .. modname .. ","
  end
end

depends_string = depends_string:sub(1, -2) -- remove the last comma off the end

--print(depends_string)

--minetest.safe_file_write(minetest.get_modpath("item_limit").."/mod.conf", depends_string)

--update the dependancies if needed
print("--------------------")
print("ATTENTION: ITEM_LIMIT IS CHECKING FOR ALL INSTALLED MODS!")
print("--------------------")
minetest.after(3,function()
  minetest.chat_send_all("ATTENTION: ITEM_LIMIT IS CHECKING FOR ALL INSTALLED MODS!")
end)
if mod_storage:get_string("depends") == "" then
    print("NO DEPENDANCIES SET! (FIRST TIME SETUP)")
    print("--------------------")
    print("SETTING DEPENDANCIES!")
    mod_storage:set_string("depends", depends_string)
    minetest.safe_file_write(minetest.get_modpath(minetest.get_current_modname()).."/mod.conf", depends_string)
    print("---------------------")
    print("DEPENDANCIES SET!")
    print("---------------------")
    print("PLEASE RESTART MINETEST TO ENJOY!")
    minetest.after(4,function()
      minetest.chat_send_all("NO DEPENDANCIES SET! (FIRST TIME SETUP)")
    end)
    minetest.after(5,function()
      minetest.chat_send_all("SETTING DEPENDANCIES!")
    end)
    minetest.after(6,function()
      minetest.chat_send_all("DEPENDANCIES SET!")
    end)
    minetest.after(7,function()
      minetest.chat_send_all("PLEASE RESTART MINETEST TO ENJOY!")
    end)
else
    --if no change tell
    if mod_storage:get_string("depends") == depends_string then
      print("NO NEW MODS DISCOVERED!")
      print("--------------------")
      print("END OF INDEX!")
      minetest.after(4,function()
        minetest.chat_send_all("NO NEW MODS DISCOVERED!")
      end)
      minetest.after(5,function()
        minetest.chat_send_all("END OF INDEX!")
      end)

    --if added mod, update
    else
      print("NEW MODS DISCOVERED!")
      print("--------------------")
      print("UPDATING DEPENDANCIES!")
      print("--------------------")
      mod_storage:set_string("depends", depends_string)
      minetest.safe_file_write(minetest.get_modpath(minetest.get_current_modname()).."/mod.conf", depends_string)
      print("DEPENDANCIES UPDATED!")
      print("--------------------")
      print("PLEASE RESTART TO ENJOY YOUR NEW MODS!")
      minetest.after(4,function()
        minetest.chat_send_all("NEW MODS DISCOVERED!")
      end)
      minetest.after(5,function()
        minetest.chat_send_all("UPDATING DEPENDANCIES!")
      end)
      minetest.after(6,function()
        minetest.chat_send_all("DEPENDANCIES UPDATED!")
      end)
      minetest.after(7,function()
        minetest.chat_send_all("PLEASE RESTART TO ENJOY YOUR NEW MODS!")
      end)
    end
end

--set all item stacks to max defined at line 1
for i,a in pairs(minetest.registered_items) do
  minetest.override_item(a.name, {stack_max = item_limit_stack_max})
end
