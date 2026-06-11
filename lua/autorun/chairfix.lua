effect = CreateConVar("chairfix_effect", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_CHEAT}, "If true, shows disabled collision effect on chair")

function playerExit(ply, veh)
	local tr = util.TraceLine({
		start = ply:GetPos(),
		endpos = Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z + 50),
		mask = MASK_ALL,
		filter = {ply, "prop_vehicle_prisoner_pod" },
	})

    if (tr.Entity == NULL) then
        return
    elseif (tr.Entity:GetClass() == "worldspawn") then
        if effect:GetBool() then
            veh:SetColor(Color(0,255,0))
            veh:SetMaterial("Models/effects/comball_tape")
        end

        veh:SetCollisionGroup(COLLISION_GROUP_WORLD)
        ply:SetPos(Vector(veh:GetPos().x, veh:GetPos().y, veh:GetPos().z + 10))

        timer.Simple(1, function()
            if !IsValid(veh) then return end

            veh:SetColor(Color(255, 255, 255, 255))
            veh:SetMaterial("")
            veh:SetCollisionGroup(COLLISION_GROUP_NONE)
        end)
    end
end

hook.Add("PlayerLeaveVehicle", "PlayerLeftVehicle", playerExit)
