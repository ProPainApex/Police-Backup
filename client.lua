------------------------------------
--- Police Backup, Made by FAXES ---
------------------------------------

--- CONFIG ---
local leoPeds = {
    "s_m_y_cop_01",
}

--------------------------------------------------------------------------------------------------------
function checkPed(ped, PedList)
	for i = 1, #PedList do
		if GetHashKey(PedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function playCode99Sound()
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
end

RegisterNetEvent('Fax:ShowInfo')
AddEventHandler('Fax:ShowInfo', function(notetext)
	ShowInfo(notetext)
end)

RegisterNetEvent('Fax:BackupReq')
AddEventHandler('Fax:BackupReq', function(bk, s)
    local src = s
    local bkLvl = bk
    local bkLvlTxt = "N/A"
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(src)))
    local street1 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local streetName = (GetStreetNameFromHashKey(street1))

    if checkPed(GetPlayerPed(PlayerId()), leoPeds) then
        if bkLvl == "1" then
            bkLvlTxt = "~r~PRIO 1"
            PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
        elseif bkLvl == "2" then
            bkLvlTxt = "~y~prio 2"
        elseif bkLvl == "3" then
            bkLvlTxt = "~b~prio 3
        elseif bkLvl == "99" then
            bkLvlTxt = "~r~~h~OMEDELBAR LIVSFARA"
        end

        ShowInfo("En kollega behöver förstärkning med " .. bkLvlTxt .. "~s~. ~o~till: ~s~" .. streetName .. ".")
        SetNewWaypoint(coords.x, coords.y)

        if bkLvl == "99" then
            playCode99Sound()
        end
    end
end)
