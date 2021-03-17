script_name('AdminTools by Inesi')
script_author('Inesi')
script_description('AdminTools v0.1')

require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local color_yellow = 0xE2FF00
local color_blue = 0x307EFC
local color_red = 0xFF006B

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	
	sampAddChatMessage("---------------------------------------------------------------------------------", color_blue)
	sampAddChatMessage("[DTool]: {E2FF00}��������!", color_red)
	sampAddChatMessage("[DTool]: {E2FF00}������: 0.1!", color_red)
	sampAddChatMessage("�����: {E2FF00}Inesi", color_red)
	sampAddChatMessage("������ ������ ��� {E2FF00}ETERNITY ROLE PLAY {307EFC}DOMINANT", color_red)
	sampAddChatMessage("����� ��� ��� ���-�� ��������? �� ������, ���� ��� � ��:vk.com/inesi1 ��� � �������:Inesi#2316", color_red)
	sampAddChatMessage("��� ������� ����� /et!", color_red)
	sampAddChatMessage("---------------------------------------------------------------------------------", color_blue)
	
	sampRegisterChatCommand("et", cmd_et)
	
	thrgegg = lua_thread.create_suspended(thrgegg)
	thrgrep = lua_thread.create_suspended(thrgrep)
	thrgnews = lua_thread.create_suspended(thrgnews)
	thrgweather = lua_thread.create_suspended(thrgweather)
	thrgspcars = lua_thread.create_suspended(thrgspcars)
	
	imgui.Process = false
	
	while true do
		wait(0)
		
		if main_window_state.v == false then
			imgui.Process = false
		end
	end
end


update_state = false

local script_vers = 1
local script_vers_text = "0.1"

local update_url = "https://raw.githubusercontent.com/Dimanot/atool/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "" -- ��� ���� ������
local script_path = thisScript().path


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(id)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
    
	while true do
        wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� ��������!", color_red)
                    thisScript():reload()
                end
            end)
            break
        end

	end
end

function cmd_update(arg)
    sampShowDialog(1000, "�������������� v2.0", "{FFFFFF}��� ���� �� ����������\n{FFF000}����� ������", "�������", "", 0)
end

function cmd_dt(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function thrgegg()
	sampSendChat("/a /gg 3")
	wait(1000)
	sampSendChat("/a /gg 2")
	wait(1000)
	sampSendChat("/a /gg 1")
	wait(1000)
	sampSendChat("/gg")
end

function thrgrep()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/a �������� ���������� ������, � ������� �����. ")
	imgui.Process = false
end

function thrgnews()
	sampSendChat("/news ....:::����������� �������� San News Corporation:::...")
	wait(4000)
	sampSendChat("/news �����������, ������� ��������������. � ����� ������� �����.")
	wait(4000)
	sampSendChat("/news ������� ���������, ������ � ���-������ ��� �����������, �������� ��� �����.")
	wait(4000)
	sampSendChat("/news � ������ ���-������ ������� ����� ����� �����.")
	wait(4000)
	sampSendChat("/news ���� ������� ����������� Ballas Gang ��� ����������������� Uragan, �� ������ Hokage.")
	wait(4000)
	sampSendChat("/news � ���-�������� ��� ������ � ������� ������� ����������.")
	wait(4000)
	sampSendChat("/news � ����� ������ ���-������, �������� ������ � ���� ������.")
	wait(4000)
	sampSendChat("/news <<�������>> ������� Burger Shot � ���-�������. ����: ����������. ���.: 65432. <<�������>> ")
	wait(4000)
	sampSendChat("/news ���� ������� ���������, ���������� �� �������� Luxury Gold.")
	wait(4000)
	sampSendChat("/news � ���� ��� ������ ��� ��� �������� San News, �� ������ ������!")
	wait(4000)
	sampSendChat("/news ....:::����������� �������� San News Corporation:::...")
end

function thrgweather()
	sampSendChat('/news ....:::����������� �������� San News Corporations:::...')
	wait(4000)
	sampSendChat('/news �����������, ������� ��������������. � ����� ������� ������.')
	wait(4000)
	sampSendChat('/news � ���� � - �������� San News')
	wait(4000)
	sampSendChat('/news ��������� �������� ��� � ������� ��� ����� ��������:')
	wait(4000)
	sampSendChat('/news � �."Los-Santos" +20 ��. ��� �������.')
	wait(4000)
	sampSendChat('/news � �."San-Fierro" +18 ��.�������� ����� �����, ����������� �������.')
	wait(4000)
	sampSendChat('/news � � �."Las-Venturas" +14 ��.�������.')
	wait(4000)
	sampSendChat('/news � ���� �� ���� ���.������� �� ��������!����� ��������!.')
	wait(4000)
	sampSendChat('/news � ��������� San News �."Los-Santos".')
	wait(4000)
	sampSendChat('/news � ���� ��� ������ ��� �������� San News. �� ��������������!')
	wait(4000)
	sampSendChat('/news ....:::����������� �������� San News Corporations:::...')
end
function thrgspcars()
	sampSendChat("/o ��������� ������, ������ ���������� ������� ��! ������� ���� �����!")
	wait(1000)
	sampSendChat("/spawncars")
	wait(17000)
	sampSendChat("/fuelcars")
	wait(1000)
	sampSendChat("/o ��� �� ���� ������� ����������! �������� ����!")
end

function imgui.OnDrawFrame()
	local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(596, 460), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"Dominant Tool by Inesi", main_window_state, imgui.WindowFlags.NoResize+imgui.WindowFlags.NoMove)
	if imgui.CollapsingHeader(u8'�����������') then
	if imgui.Button(u8("�������")) then
		sampSendChat("/o ��.������! ��������� ������ ���� �� �����-������. ��������� /donate.")
	end
	if imgui.Button(u8("������� 2")) then
		sampSendChat("/o ������� ������ ��������! ��������� ������� �� ������ �����! ��������� /donate.")
	end
	if imgui.Button(u8("������� 3")) then
		sampSendChat("/o ����������, ��������� ����� ������ �������! � ��� ��������� ������ ���� �� �������! ������ >>> /donate.")
	end
	if imgui.Button(u8("����������/��������� ����")) then
		thrgspcars:run()
	end
	if imgui.Button(u8("�������� �������� ����")) then
		thrgegg:run()
	end
	if imgui.Button(u8("�������� ������")) then
		thrgrep:run()
	end
	if imgui.Button(u8("���������")) then
		sampSendChat("/a ����������� ��� ����� ��������. �� ��������� � ���������")
	end
end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8'��� ��') then
	if imgui.Button(u8("������� ���������")) then
		sampSendChat("/a ��� ������� ��������� �� ������ ���� 3 ����, � ������� ��� ���� 2 ������ � ��� /veh!")
		sampSendChat("/a ��� ������� ��������� �� ������ ���� 2 ����, � ������� ��� ���� 1 ������!")
		sampSendChat("/a ��������� ���� ������� ��������� � �� �� ���������� ������ - ���������� �������!")
	end
	if imgui.Button(u8("����������� �������")) then
	sampSendChat("/a ������� �� �������! �������� �� �������! ������� ������! ������ 13+ �������!!")
	sampSendChat("/a ������� �� �������! �������� �� �������! ������� ������! ������ 13+ �������!!")
	sampSendChat("/a ������� �� �������! �������� �� �������! ������� ������! ������ 13+ �������!!")
	end
	imgui.NewLine()
	end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8("�����")) then
		if imgui.Button(u8("�������")) then
			thrgnews:run()
		end
		if imgui.Button(u8("������")) then
			thrgweather:run()
		end
	end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8("�������")) then
		if imgui.Button(u8("���������� ���������")) then
			thrgspcars:run()
		end
end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8'�����') then
		if imgui.CollapsingHeader(u8"��������") then
			if imgui.CollapsingHeader(u8"DeatMatch (DM)") then
				imgui.Text(u8("��������� �������� ������ ��� �������."))
				imgui.NewLine()
				imgui.Text(u8("� DM ���������:"))
				imgui.Text(u8("- �������� ��� ����� ������ �� ������� ������ ������ (����� �����������)"))
				imgui.Text(u8("- ������������� �������� � ���� ������."))
				imgui.Text(u8("- �������� � �������� ������������� (���� ������������� �������� ����� ����� ����"))
				imgui.Text(u8(" - �������� ������ �� ����� �� ����������� ��� �������)."))
				imgui.Text(u8("���������� ��� ����: �� ���������� ����� ��������� ������� �����������, ���� ��� ���"))
				imgui.Text(u8("������, ���� ��� �������� � �����. �� ��������� ����� ��������� ��� DM."))
				imgui.NewLine()
				imgui.Text(u8("� DM �� ���������:"))
				imgui.Text(u8("- �������� ��� ����� ��������� �� ���������� �����."))
				imgui.Text(u8("- �������� ��� ����� �������."))
				imgui.Text(u8("- �������� ��� ����� ���������/������� � ������������."))
				imgui.Text(u8("- ����������� ������ ���� (��� � �� ���������������, ��� � �� �������)"))
				imgui.Text(u8("���� �� ���� ������� RP ���������, ������ �������� � ����� ������� ���� ����� - ���������"))
				imgui.Text(u8("��� DM."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 10-20 min]"))
			end
			if imgui.CollapsingHeader(u8"DeatMatch � ������� ���� (DM in ZZ)") then
				imgui.Text(u8("��������� ����� �����, �������� � ������� ����."))
				imgui.NewLine()
				imgui.Text(u8("������� ����� ���������: �������� �����, � ��������� ������ � ������ �����; �������"))
				imgui.Text(u8("��������, �������� �����, �������� ������������, �������� ������."))
				imgui.Text(u8("����������: RolePlay ����������� �� ���� ��� �����."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail-30 min]"))
			end
			if imgui.CollapsingHeader(u8"DeatMatch � �������������� �������������� ����������") then
				imgui.Text(u8("��������� �������� ������� � �������������� �������������� ���������� (����, Hydra,"))
				imgui.Text(u8("Apache.)"))
				imgui.Text(u8("����������: ������� ���� �� ������� ����."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Warn]"))
			end
			if imgui.CollapsingHeader(u8"DriveBy (DB)") then
				imgui.Text(u8("��������� �������� ������ � ������������� �����, ���� ������� �� ����."))
				imgui.NewLine()
				imgui.Text(u8("� DB ���������:"))
				imgui.Text(u8("- ����� �� ������, ��� ����� ������ ���."))
				imgui.Text(u8("- �������� � ������������� ����� (�������� � ������������� �����, � DB �� ���������)"))
				imgui.Text(u8("- ���� ��������� ������������ ��������� � ����� �� ����."))
				imgui.Text(u8("����������: ������� ������� ���������, �� ������� �� ���� ��������� (�����, ������������,"))
				imgui.Text(u8("����� �����)"))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail �� 10-20 min] � ����������� �� ������� ���������"))
			end
			if imgui.CollapsingHeader(u8"��������� �� ������ � ��������� ����/��������(SK)") then
				imgui.Text(u8("��������� ��������� �� ������ � ��������� ����/��������."))
				imgui.Text(u8("����������: ���� ������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 20-30 min]"))
			end
			if imgui.CollapsingHeader(u8"�������� �� �������� (Spawnkill)") then
				imgui.Text(u8("��������� ��������� �� ������ � ����� ��� �����������/��������� (������ 50 ������), ���"))
				imgui.Text(u8("����� ����, ��� ���, ��� ������� �����������, ������� ��������."))
				imgui.Text(u8("����������: �� �������� ��� ���������� ������� ������� �� ����������������. �����������"))
				imgui.Text(u8("������� �������� � /time ������, ���� � �������������� ����� ��������� - ���������� ���."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 20-30 min]"))
			end
			if imgui.CollapsingHeader(u8"�������� ����� ������ (TeamKill)") then
				imgui.Text(u8("��������� ������� ����� ������/������� �� ������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 20 min] � ����������� ����������� ������� ������."))
				imgui.Text(u8("����������: ��� TK �� �������� PvP � ������. PvP �������� ������ �� �������� �����!"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"���") then
			if imgui.CollapsingHeader(u8"������") then
				imgui.Text(u8("��� ��������� ������ � ������������ ��� �� �� ��� ��������."))
				imgui.Text(u8("Ad, Vad - ��� ��� �������, ������������ ��� �������/������� ���������, ������� �����,"))
				imgui.Text(u8("�� ������ �� ������� ������ (������ Offtop�a: ����� ������, id 25 ������ �����)."))
				imgui.Text(u8("Report - ��� ��� ����� �� ������� (������ Offtop'a: ����� ��/������ ��/����� ����/��)."))
				imgui.NewLine()
				imgui.Text(u8("���������: ��������������, ���� ��������� ������������ - [Mute 10 min]"))
			end
			if imgui.CollapsingHeader(u8"����") then
				imgui.Text(u8("��� ���������� ���������, ���������� � ����� �� ����� 5 ��� � ����� � ������� 2 �����."))
				imgui.NewLine()
				imgui.Text(u8("���������: ���� � ����� �� ����� - [Mute 10-20 min]"))
			end
			if imgui.CollapsingHeader(u8"CapsLock (����)") then
				imgui.Text(u8("��� �����, ������� �������� �������� �������. �� ������� ��������� ������ ������."))
				imgui.NewLine()
				imgui.Text(u8("� ����� ���������:"))
				imgui.Text(u8("-�����(�) ��� �����������, ������� �������� ����������   �������(���� ������, � ��Ҩ�!)."))
				imgui.Text(u8('- ��� ����� ��� �����������, ������� �������� "�������" (������).'))
				imgui.NewLine()
				imgui.Text(u8("� ����� �� ���������:"))
				imgui.Text(u8("- ������������ (���, ���, ��� � �.�)."))
				imgui.Text(u8("- ����� �������, ���������� ���������� �������(FABIAN LORENZO)."))
				imgui.Text(u8("����������: RolePlay Caps (������: ����� �������, ������)"))
				imgui.NewLine()
				imgui.Text(u8("���������:  [Mute 10 min]"))
			end
			if imgui.CollapsingHeader(u8"��������") then
				imgui.Text(u8('��������� �������������� ������� �� ��������� ��������� � ����� ����� � OOC, Ad, Report'))
				imgui.Text(u8('� ������ ����. ������: ("���� �������� Eternity MP "+" � /vad!").'))
				imgui.Text(u8('����������: ��� sms. ��� �������� ������ id - �������������� � ���������.'))
				imgui.NewLine()
				imgui.Text(u8('���������: [Mute 10 min]'))
			end
			if imgui.CollapsingHeader(u8"���������� ��������") then
				imgui.Text(u8('��������� ��������� � ���� �� ����� "+++++" "_____", � ��� �� ������� � ������ (/b ��� ���'))
				imgui.Text(u8('������� �� ��������)'))
				imgui.NewLine()
				imgui.Text(u8('���������:  [Mute 5-10 min] � ����������� �� ������� ���������.'))
				imgui.Text(u8('����������: ��������� �� ������ 5-�� ������. ���������� ��������� ������� � ��������'))
				imgui.Text(u8('����, ������ ���������, ����� �������� ��� �������.'))
			end
			if imgui.CollapsingHeader(u8"�����������") then
				imgui.Text(u8("��������� ������ ���������� �� �������� ����� � ������� ��� (OOC in IC)"))
				imgui.NewLine()
				imgui.Text(u8("���������: ��������������, ���� ��������� ������������ - [Mute 10 min]"))
				imgui.Text(u8("����� ����������� � �������� ����� � �� ������� �������� ��������� � �������� ��������."))
				imgui.Text(u8("������: ����� �� ����� � ��������,�� �� ���� ��������� � ���� *** ����� ������,� �� ���������!"))
			end
			if imgui.CollapsingHeader(u8"�����������") then
				imgui.Text(u8('��� ������������ ��������� ������, ������� ������� ���������� � ������� ������. �� ���'))
				imgui.Text(u8('������, �������� ������ ����������� � ����� ��� ����� �������. (��� �� �����������!).'))
				imgui.Text(u8('����������: ���������� ���� �����, ���� �� ������ � ������� ����� ���������, �� ���������,'))
				imgui.Text(u8('������ ���� �� ���� �� �����������. ���� ��������� ��������� ������������� � �����'))
				imgui.Text(u8('������������� �������.'))
				imgui.Text(u8('���� ����������� ������ � �� �������, �� ���� �� �������� � ����� � ��������� �������'))
				imgui.Text(u8('�������, � ����� ����������� � ����������� � ��� ��� �������� ����������� � /time,'))
				imgui.Text(u8('�� ��������� �� �����.'))
				imgui.NewLine()
				imgui.Text(u8('���������:'))
				imgui.Text(u8('1. ����������� ������ � [Mute 30-40 min] � ����������� �� ������� ���������.'))
				imgui.Text(u8('("���"�� ��������� ������������.)'))
				imgui.Text(u8('2. ����������� ������������� � [Mute 60 min, Ban 3 ���. � ����������� �� ���������]'))
				imgui.Text(u8('3. ����������� ������ � �����-���� ��������� �� ���� ������������� � [ban 15-30 ����]'))
				imgui.Text(u8('4. ����������� ����� ������ - [Mute 180 min]'))
				imgui.Text(u8('5. ����������� ����� ����������� � [Mute 20 min]'))
				imgui.Text(u8('����������� ����� ����������� � Vad � [Mute 20 min] + 1 �������������� VIP ������.'))
				imgui.Text(u8('6. ����������� ������� - [Mute 60-300 min, Pernament BAN]  � ����������� �� ������� ���������.'))
				imgui.Text(u8('7. � ������������ ��� �� ��������� ������������, �� ���� "lox", "s o si", � ���� ��������,'))
				imgui.Text(u8('�� ������� ������� ������������ ������.'))
				imgui.Text(u8('8. ����������� ������� �������� ���������� ���������� � ��� ׸���� ������.'))
				imgui.Text(u8('����������: ������� ����������� ����� �������� ����������.'))
			end
			if imgui.CollapsingHeader(u8"���") then
				imgui.Text(u8('�������� ������ ������������� ������������� ������� (������������ �����, ��� "�*��",'))
				imgui.Text(u8('�������� ��� ����). �����, �� ��� �������� ������ ���, ����� �������.'))
				imgui.NewLine()
				imgui.Text(u8('���������: ��� � ����� �� ����� �������� [Mute 10 min]. ��������� ���� ������� � ����� ���'))
				imgui.Text(u8('����� � �����.')) 
				imgui.Text(u8('����������: ������� ��� ����� ��������.'))
			end
			if imgui.CollapsingHeader(u8"������ �������/���������������") then
				imgui.Text(u8("������ �������/��������������� ��������. (������: ����� 100� ��� � ���� �� ���� ������)"))
				imgui.NewLine()
				imgui.Text(u8("���������:"))
				imgui.Text(u8("1. ������ ������� � [Mute 20 min]"))
				imgui.Text(u8("2. ������ ��������������� - [Mute 40 min]"))
			end
			if imgui.CollapsingHeader(u8"�����") then
				imgui.Text(u8("��������� ����� ������� ������ �������/�������������."))
				imgui.NewLine()
				imgui.Text(u8("���������:"))
				imgui.Text(u8("����� ������������� � [��� ��� �� ���-40 �����]-������������ �� ������� ���������."))
				imgui.Text(u8("����� ������� � [Jail 20 min] + [Mute 40 min]"))
				imgui.Text(u8("����������: ������������� ������ �������� ���� �������, ���������� � ������. � ������"))
				imgui.Text(u8("������ �� ���������, ������������ ������������ ������������ � ���� �������������."))
			end
			if imgui.CollapsingHeader(u8"������ ��������/�����/�������") then
				imgui.Text(u8('��������� ������ ����� �� ���� "��� ���� �����, ��� ����." ��� �� "��� ��� ������" � ��.'))
				imgui.Text(u8('����� ��������� ������ �������� ��� �������� ���������������. (�� ��������'))
				imgui.Text(u8('������������� � ������ ������ �� �����, �� ����� ���� �� ���  ���� ������� � �.�.'))
				imgui.Text(u8('�������� ��� ����)'))
				imgui.NewLine()
				imgui.Text(u8('���������: [Mute 20-30 min] � ����������� �� ������� ���������.'))
			end
			if imgui.CollapsingHeader(u8"������������ ���������") then
				imgui.Text(u8("��������� ������������ ��������� � ����� �� ����� (������: � ��� ���� �*�� ��*�� �*����;"))
				imgui.Text(u8("�� ����, � �*����� � �.�.)."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Mute 20-30 min]  � ����������� �� ������� ���������."))
			end
			if imgui.CollapsingHeader(u8"��������������� ������") then
				imgui.Text(u8("��������� ��������������� ������, ������� � ������� � ���������������."))
				imgui.Text(u8("���������: [Mute 30 min]"))
				imgui.Text(u8("����������: ���������� ����������� ��� � ������ �������."))
			end
			if imgui.CollapsingHeader(u8"������� ���������� �������/�����") then
				imgui.Text(u8("������� ��������� ������, �������� ���������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"���������� �������� �������������") then
				imgui.Text(u8("��������� ���������/���������� �������� �������������, �������� ��� ��������� ��"))
				imgui.Text(u8("������ � � ����. ��� ����� ���������� ������ ����� �� ������������� �������."))
				imgui.NewLine()
				imgui.Text(u8("���������:"))
				imgui.Text(u8("� ����: [Mute 15 min]"))
				imgui.Text(u8("�� ������: ���������� �������� �� 5 ����."))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"��") then
			if imgui.CollapsingHeader(u8"�����/������") then
				imgui.Text(u8("��������� �����-���� �����, ������ � ���������� �������� ��������"))
				imgui.NewLine()
				imgui.Text(u8("���������: ��������������, ���� ��������� ������������ - [Jail 10 min]"))
			end
			if imgui.CollapsingHeader(u8"������� ����� (���������)") then
				imgui.Text(u8("��������� ���� ���� � �������������� ���������, ������� �� ���������� � ���������"))
				imgui.Text(u8("������� �����. � ��� �� ������� ���� �����������, ��� ������� ������������ ���������"))
				imgui.Text(u8("������. ����� ��������� ����������� ������� �����. ( ������: �� �������� ���� 3 ������,"))
				imgui.Text(u8("�� �������� ����� 6)"))
				imgui.NewLine()
				imgui.Text(u8("���������: [Warn]"))
			end
			if imgui.CollapsingHeader(u8"������������� ������ /iznas � /minet") then
				imgui.Text(u8("��������� ������������ ����� 5 ������ �� ��������, � ��� �� ������� ���."))
				imgui.NewLine()
				imgui.Text(u8("���������: ��������������, ���� ��������� ������������ - [Jail 15 min]"))
			end
			if imgui.CollapsingHeader(u8"��������� ���������") then
				imgui.Text(u8("��������� ������������ ��������� ��������� � ������ �����. (��������, ������������"))
				imgui.Text(u8("����� �� ������������, ������������ ������������� ������ � ��������� ����� � �.�.)"))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 20-30 min]"))
			end
			if imgui.CollapsingHeader(u8"���� �������� �����������") then
				imgui.Text(u8("��������� ������� �������� �����������. �������, ���� ��� ����� ����� ���� �� ���������"))
				imgui.Text(u8("� ������� � ��������� � � ��������� ���������, �� ��������� �� �����. ������� ��"))
				imgui.Text(u8("��������� ������� �������������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 10 min]"))
			end
			if imgui.CollapsingHeader(u8"RP �������") then
				imgui.Text(u8("��������� ����� ���� �� �� RP �������� (�.�. ������� RP �������, ����� ��, ��� �� ��������"))
				imgui.Text(u8("� �.�.), ����� ������� NonRP."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 10-30 min], � ����������� �� ������� ���������."))
			end
			if imgui.CollapsingHeader(u8"���������� �������") then
				imgui.Text(u8('��������� ��������� ������� �� ������ �������� (������: ������ �� �������: "��������")'))
				imgui.NewLine()
				imgui.Text(u8('���������: [Uval]'))
			end
			if imgui.CollapsingHeader(u8"NonRP �����") then
				imgui.Text(u8("��������� ��������� ����� � ������������ ��� ����� �����, ��������� ��� ������"))
				imgui.Text(u8("RP ���������/������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Uval ��� �� jail-30 min]"))
			end
			if imgui.CollapsingHeader(u8"PowerGaming") then
				imgui.Text(u8("��������� ����� ���� ���, ��� �� �� �� ��������� � �������� �����, ��������� ����������"))
				imgui.Text(u8("�� ���� �����. (������: �����, ����������� ��� �������� ����������, ����������"))
				imgui.Text(u8("������������ ��������� ��� ����� ������� �� ������� ������ 3 ����������� �����������)"))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 10 min],  ��� ������������� ��������� - [Warn]"))
			end
			if imgui.CollapsingHeader(u8"���� ��������") then
				imgui.Text(u8("��������� ������� �������� ���������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Jail 30 min]. ��� ������������� �������� ������ �������� [Warn]"))
			end
			if imgui.CollapsingHeader(u8"��������� � ���������������") then
				imgui.Text(u8('������� ��������� ���������� �� �������� � ��������, ���������� �� ��������� �'))
				imgui.Text(u8('�������, ���� �� ������� � ��� �� �������.'))
				imgui.Text(u8('����������: ����� ����� ��������, ������� ���. ��� ������ ��������, � �� ������.'))
				imgui.Text(u8('������������� � ��� ����� � ����� ���, �� �������� �����������.'))
				imgui.NewLine()
				imgui.Text(u8('���������: �������������� ������. ����� [Jail 10 min] � �������� "��������� � �������".'))
			end
			if imgui.CollapsingHeader(u8"���������� �� � �����") then
				imgui.Text(u8('�� ����������� ���������� � ����� � ��������� �������: ��������������(�������'))
				imgui.Text(u8('2 ��������),����������� ���� ��������,RP ���������(���������� �����,���������� � ��).'))
				imgui.NewLine()
				imgui.Text(u8('���������:  ��� �������������� � ������ �������� �����.����� ����� Jail 10 min.'))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"���/����") then
			if imgui.CollapsingHeader(u8"������������� ����-���") then
				imgui.Text(u8("��������� ����������� ������� ������ ��� � ������� ���������, � ����� ����� ��� ��"))
				imgui.Text(u8("������ � �������."))
				imgui.NewLine()
				imgui.Text(u8("���������: ������-30 �����.. ��� ��������� ������������ -[Warn]"))
			end
			if imgui.CollapsingHeader(u8"����� � AFK") then
				imgui.Text(u8("�������� ��������������� ����� �� ����, � ��� �� ��������������� ������������� �����."))
				imgui.NewLine()
				imgui.Text(u8("���������:"))
				imgui.Text(u8("1. ����� �� ���� ����� ��������� ������ ������� [Warn]"))
				imgui.Text(u8("2. ����� ��� ������ [Jail 20-30 min]"))
				imgui.Text(u8("3. AFK ��� ������ � [Jail 20-30 min] (���� ����� � ������ AFK ����� ���� �����)"))
				imgui.Text(u8("4. ���������� ������� ��� �������� - ��� (���� ����� ����� �� ����� ����� ����� ����)"))
			end
			if imgui.CollapsingHeader(u8"���� �� ���������") then
				imgui.Text(u8("��������� ������� �� ��������� �������������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Warn]"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"��") then
			if imgui.CollapsingHeader(u8"����������� �����������") then
				imgui.Text(u8("��������� ������������� ���������� ������������ �����������, ����, ��������, �����."))
				imgui.NewLine()
				imgui.Text(u8("���������: [BAN 7-10 days] ��� [Warn], � ����������� �� ������� ���������."))
				imgui.Text(u8("���� ������� ������� � ����������� � [Warn]"))
			end
			if imgui.CollapsingHeader(u8"������") then
				imgui.Text(u8("�� ����������� ������������ ����������� ������ (����������: M4, AK47, Desert Eagle,"))
				imgui.Text(u8("Shotgun, Smg, ��������, ��������� �������, ������� �������, ��� � ����������� ��������[���� ����� ������])."))
				imgui.NewLine()
				imgui.Text(u8("���������: [BAN 7 days], ���� ����� ����������� ����������� ��. ���� ������ �����"))
				imgui.Text(u8("������������� � sethp ������ � ������� �������������� (������� ����� ��� ���� � ���"))
				imgui.Text(u8("������, ���� ������������� ��� ���� ��� �����)"))
			end
			if imgui.CollapsingHeader(u8"��������������� ��") then
				imgui.Text(u8("��������� �������������� ��������� ��, ����, �������, ����, ���� ���� �� �������."))
				imgui.NewLine()
				imgui.Text(u8("���������: ��� ��� ����� �� ��������������."))
			end
			if imgui.CollapsingHeader(u8"������������ �������") then
				imgui.Text(u8("��������� ����� ������������ ������� ����, ������� ���� ������������ ��� �������"))
				imgui.Text(u8("��������. (��������, ������ ���, �������� �������, ������)"))
				imgui.NewLine()
				imgui.Text(u8("���������: [Warn], ���� ����� �� ������ ��� � [BAN 7 days]"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"������") then
			if imgui.CollapsingHeader(u8"������") then
				imgui.Text(u8("���������� ������������� ����������� ������� � ����� � ��������� �����. ������, ���"))
				imgui.Text(u8("���-���� ������� ����� ������ ���������� � ������������, �������� � �������������"))
				imgui.Text(u8("������� ����� �� ��� ������ ��� ���. ��� ���������� ����� �������� ����, �������"))
				imgui.Text(u8("���������� �������� � ��� ������������� ��� ������ ������� ��� ��� ������ /bags."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Warn]"))
			end
			if imgui.CollapsingHeader(u8"+C") then
				imgui.Text(u8("��������� ������������ ������ +� �� �������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [jail 10-20 min]"))
			end
			if imgui.CollapsingHeader(u8"����� ������� ���� � ������ ������") then
				imgui.Text(u8('��������� ������������ ����������� ����, ��������� � ������� ������� ���� � ���� ������,'))
				imgui.Text(u8('���������� .ru � ���� ������� � ����� ������ ����������� ��� ����, ����� �������������'))
				imgui.Text(u8('������ ��� ���������.'))
				imgui.NewLine()
				imgui.Text(u8('���������:  [Warn] � �������� "������"'))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"��������") then
			if imgui.CollapsingHeader(u8"����-����") then
				imgui.Text(u8("��������� ��������� ������� � ������ ������, ������� ��� ����������."))
				imgui.NewLine()
				imgui.Text(u8("���������: ������ �������������� � ���� ������� ������� ���, ��� ������ � [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"����� ����") then
				imgui.Text(u8("�������� ������� � ����� ����� �� ������ ���������� � ��������, ��� � ����� �����"))
				imgui.Text(u8("������ �� ��������. ��� ������ �������� �� �������� � ����� ��������� ��������."))
				imgui.Text(u8('����������: �������, ��� �������� � ����� ����� �� ������� ��������� � ����� ��������'))
				imgui.Text(u8('������ ����� �����������, � ������ � ����� ������ �����������. ���� �� �������� ������� �'))
				imgui.Text(u8('���� �� ������������ - ��� ������� ���� � �������� "����� ���".'))
				imgui.NewLine()
				imgui.Text(u8("���������:  ������ �������������� � ���� ������� ������� ���."))
			end
			if imgui.CollapsingHeader(u8"������ ����") then
				imgui.Text(u8("��������� ������������ �����, ���������� �������������� �����, ���� ����������� �����."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"��� � ����") then
				imgui.Text(u8("��������� ������� ��� ����/�����/�����������/������ � �����."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"������ ���� �� ������� ������") then
				imgui.Text(u8("��������� ������ ���� �� �������������� ��� ������� ������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Perpetual BAN]"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"������") then
			if imgui.CollapsingHeader(u8"�������������") then
				imgui.Text(u8("����� 3 � ������ ��������� ���������, ����� ����� ������ 2 ��������."))
				imgui.NewLine()
				imgui.Text(u8("���������: �������� ���� ���������. ��������� ������ 2 �������� � ���������� �������."))
			end
			if imgui.CollapsingHeader(u8"��������� � ����������") then
				imgui.Text(u8("��������� � ���������� (�������/�������/��������/�����/�������� ����������) ���������,"))
				imgui.Text(u8("��� ������������� ��������, ������� ����� ������������."))
				imgui.Text(u8("���������: [Perpetual BAN]"))
				imgui.Text(u8("����������: ���� ������� �����, ������, �����, ������������� ��� �� ��������� ����������"))
			end
			if imgui.CollapsingHeader(u8"���� �������") then
				imgui.Text(u8("���� ������� Eternity Project �� ����������� � ����� �������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Perpetual BAN] ��� ���������� ���� ��� ����� �� ������������� ����."))
			end
			if imgui.CollapsingHeader(u8"�������/������� ������� ������") then
				imgui.Text(u8("��������� �������/������� ������� ������ �� ������ ������� �� �������� ������. ���"))
				imgui.Text(u8("������������� ������ �������� ����� ��� �������."))
				imgui.NewLine()
				imgui.Text(u8("���������: [Perpetual BAN] ����� ������"))
				imgui.Text(u8("����������: ������������� ������ �������� ������ �� ������� ������������� ������."))
			end
			if imgui.CollapsingHeader(u8"���������� �������������� ����������� � ����������� ��������") then
				imgui.Text(u8("��������� ���������� ������ ��������/�����������, ������� ��������� �� ����������"))
				imgui.Text(u8('���������� ���������, ����� ��� "��������� �����������",'))
				imgui.Text(u8('"������ ������", "������-����������" � �.�.'))
				imgui.NewLine()
				imgui.Text(u8("���������: ��� ��� ����� �� ��������������."))
			end
			imgui.NewLine()
		end
	end
	imgui.NewLine()
	imgui.Text(u8("----------------------------------------------------------------------"))
	imgui.Text(u8(string.format('������� ���� � �����: %s', os.date())))
	imgui.Text(u8("----------------------------------------------------------------------"))
	imgui.End()
end