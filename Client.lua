local sH,sW = guiGetScreenSize()
local xCord, yCord = (sH*0.826), (sW*0.1472)

local lenght = (sH*0.16875)

local height_team = sW*0.03
local height_players = sW*0.03

local pixelSpace = sW*0.001

local textOffset = sH*0.005

local image_top = dxCreateTexture( "images/top.png", "argb", true, "clamp" )
local image_heart = dxCreateTexture( "images/heart.png", "argb", true, "clamp" )

local pts = math.random(0,150)

function getTeams()
	dxDrawImage(xCord, yCord-(sW*0.0313725), lenght, sW*0.0313725, image_top, 0, 0, 0, tocolor(15, 15, 15, 255), false) -- top hat
	local offset = 0
	local teams = getElementsByType("team")
	local pl = 0
	for it, team in ipairs(teams) do
		local r, g, b = getTeamColor(teams[it])
		--local colorp = 0.85
		dxDrawRectangle(xCord, yCord+offset, lenght, height_team-pixelSpace, tocolor(15, 15, 15,153)) -- team name rectangle
		dxDrawText(getTeamName(team),xCord, yCord+offset, xCord+lenght, (yCord+offset)+height_team, tocolor(255,255,255, 255), (sW*0.02)*0.04629, "default-bold", "center", "center", false, false, false, true, false)
		dxDrawLine( xCord, yCord+offset+height_team-pixelSpace, xCord+lenght, yCord+offset+height_team-pixelSpace, tocolor(r,g,b, 255), 1.2 )
		offset = offset + height_team
	    for ip, player in ipairs(getPlayersInTeam(team)) do
	    	if ip % 2 == 0 then    
			    alpha = 140
			else
			    alpha = 150
			end
	    	dxDrawRectangle(xCord, yCord+offset, lenght, height_players, tocolor(10,10,10,alpha)) -- player name rectangle
	    	name = getPlayerName(player)

			local n = name:gsub("#%x%x%x%x%x%x","")
			if #n > 12 then

				local width = dxGetTextWidth(n,(sW*0.02)*0.04629,"default-bold")
				if width > (lenght/3) then
					name = string.sub(n,1,14).."..."
				end
			end
			if getElementData(player,"state") == "alive" then
				state_r,state_g,state_b = 63, 250, 54
			elseif getElementData(player,"state") == "waiting" then
				state_r,state_g,state_b = 211, 240, 54
			elseif getElementData(player,"state") ~= "alive" then
				state_r,state_g,state_b = 121, 24, 24
			end
			dxDrawImage(xCord+lenght-(lenght/5),yCord+offset+((height_players/2.5)/2),height_players/2.5,height_players/2.5,image_heart,0,0,0,tocolor(state_r,state_g,state_b), false)
	    	dxDrawText(name,xCord+textOffset, yCord+offset, xCord+lenght, yCord+offset+height_players, tocolor(255,255,255,255),(sW*0.02)*0.04629, "default-bold", "left", "center", false, false, false, true, false)
	    	dxDrawText(pts,xCord+textOffset+lenght-(lenght/5)+(height_players/2.5), yCord+offset, xCord+lenght, yCord+offset+height_players, tocolor(255,255,255,255),(sW*0.02)*0.04629, "default-bold", "center", "center", false, false, false, true, false)
	    	offset = offset + height_players
	    end
	    pl = pl + #getPlayersInTeam(team)
	end
	dxDrawImage(xCord, yCord+(pl*height_players)+(#teams*height_team), lenght, sW*0.0313725, image_top, 180, 0, 0, tocolor(15, 15, 15, 255), false)
end
addEventHandler("onClientRender", root, getTeams)