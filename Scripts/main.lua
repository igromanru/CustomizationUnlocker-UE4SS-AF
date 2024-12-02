--[[
    Author: Igromanru
    Date: 19.10.2024
    Mod Name: Customization Unlocker
]]

-------------------------------------
---------- Configurations -----------
-------------------------------------
UnlockPermanently = false

------------------------------
-- Don't change code below --
------------------------------
ModName = "CustomizationUnlocker"
ModVersion = "1.0.2"

local function ModInfoAsPrefix()
    return "["..ModName.." v"..ModVersion.."] "
end

print(ModInfoAsPrefix().."Starting mod initialization\n")

ExecuteInGameThread(function()
    print(ModInfoAsPrefix().."Initializing hooks\n")
    LoadAsset("/Game/Blueprints/Meta/Abiotic_GameInstance.Abiotic_GameInstance_C")
    RegisterHook("/Game/Blueprints/Meta/Abiotic_GameInstance.Abiotic_GameInstance_C:IsCustomizationRowUnlocked", function(Context, RowName, Unlocked)
        local gameInstance = Context:get() ---@type UAbiotic_GameInstance_C
        local rowName = RowName:get()
        local unlocked = Unlocked:get()
    
        if not unlocked then
            Unlocked:set(true)
            if UnlockPermanently then
                gameInstance:UnlockCustomization(rowName)
            end
        end
    end)
    print(ModInfoAsPrefix().."Hooks initialized\n")
end)

print(ModInfoAsPrefix().."Mod loaded successfully\n")
