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
ModVersion = "1.0.3"
DebugMode = true

local function ModInfoAsPrefix()
    return "[" .. ModName .. " v" .. ModVersion .. "] "
end

print(ModInfoAsPrefix() .. "Starting mod initialization\n")

ExecuteWithDelay(10000, function()
    ExecuteInGameThread(function()
        print(ModInfoAsPrefix() .. "Initializing hooks\n")
        LoadAsset("/Game/Blueprints/Meta/Abiotic_GameInstance.Abiotic_GameInstance_C")
        RegisterHook("/Game/Blueprints/Meta/Abiotic_GameInstance.Abiotic_GameInstance_C:IsCustomizationRowUnlocked",
            function(Context, RowName, Unlocked)
                local gameInstance = Context:get() ---@type UAbiotic_GameInstance_C
                local rowName = RowName:get() ---@type FName
                local unlocked = Unlocked:get() ---@type boolean

                if DebugMode then
                    print(ModInfoAsPrefix() .. "IsCustomizationRowUnlocked RowName: " .. rowName:ToString() .. "\n")
                    print(ModInfoAsPrefix() .. "IsCustomizationRowUnlocked Unlocked: " .. tostring(unlocked) .. "\n")
                end

                if not unlocked then
                    Unlocked:set(true)
                    if UnlockPermanently then
                        if DebugMode then
                            print(ModInfoAsPrefix() .. "UnlockCustomization: " .. rowName:ToString() .. "\n")
                        end
                        gameInstance:UnlockCustomization(rowName)
                    end
                end
            end)
        RegisterHook("/Game/Blueprints/Meta/Abiotic_GameInstance.Abiotic_GameInstance_C:CheckCustomizationSpecialConditions",
            function(Context, Conditions, Unlocked)
                -- local gameInstance = Context:get() ---@type UAbiotic_GameInstance_C
                local conditions = Conditions:get() ---@type FString
                local unlocked = Unlocked:get() ---@type boolean

                if DebugMode then
                    print(ModInfoAsPrefix() .. "CheckCustomizationSpecialConditions Conditions: " .. conditions:ToString() .. "\n")
                    print(ModInfoAsPrefix() .. "CheckCustomizationSpecialConditions Unlocked: " .. tostring(unlocked) .. "\n")
                end

                if not unlocked then
                    Unlocked:set(true)
                end
            end)
        print(ModInfoAsPrefix() .. "Hooks initialized\n")
    end)
end)

print(ModInfoAsPrefix() .. "Mod loaded successfully\n")
