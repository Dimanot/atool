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
	sampAddChatMessage("[DTool]: {E2FF00}Работает!", color_red)
	sampAddChatMessage("[DTool]: {E2FF00}Версия: 0.1!", color_red)
	sampAddChatMessage("Автор: {E2FF00}Inesi", color_red)
	sampAddChatMessage("Скрипт создан для {E2FF00}ETERNITY ROLE PLAY {307EFC}DOMINANT", color_red)
	sampAddChatMessage("Нашел баг или что-то подобное? Не ленись, пиши мне в вк:vk.com/inesi1 Или В дискорд:Inesi#2316", color_red)
	sampAddChatMessage("Для запуска введи /et!", color_red)
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

local update_url = "https://raw.githubusercontent.com/Dimanot/atool/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "" -- тут свою ссылку
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
                sampAddChatMessage("Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("Скрипт успешно обновлен!", color_red)
                    thisScript():reload()
                end
            end)
            break
        end

	end
end

function cmd_update(arg)
    sampShowDialog(1000, "Автообновление v2.0", "{FFFFFF}Это урок по обновлению\n{FFF000}Новая версия", "Закрыть", "", 0)
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
	sampSetChatInputText("/a Возьмите пожалуйста репорт, я немного занят. ")
	imgui.Process = false
end

function thrgnews()
	sampSendChat("/news ....:::Музыкальная заставка San News Corporation:::...")
	wait(4000)
	sampSendChat("/news Здраствуйте, дорогие радиослушатели. В эфире Новости Штата.")
	wait(4000)
	sampSendChat("/news Сегодня Президент, улетел в Сан-Фиерро для переговоров, пожелаем ему удачи.")
	wait(4000)
	sampSendChat("/news В городе Лос-Сантос завезли новую пачку купюр.")
	wait(4000)
	sampSendChat("/news Была поймана группировка Ballas Gang под руководительством Uragan, по кличке Hokage.")
	wait(4000)
	sampSendChat("/news В Лас-Вентурас был найден и раскрыт крупный наркобарон.")
	wait(4000)
	sampSendChat("/news В Мэрии города Лос-Сантос, проходят выборы в Мэры города.")
	wait(4000)
	sampSendChat("/news <<Реклама>> Продажа Burger Shot в Лос-Сантосе. Цена: Договорная. Тел.: 65432. <<Реклама>> ")
	wait(4000)
	sampSendChat("/news Были найдены украшения, украденные из магазина Luxury Gold.")
	wait(4000)
	sampSendChat("/news С вами как всегда был ваш Директор San News, до скорых встреч!")
	wait(4000)
	sampSendChat("/news ....:::Музыкальная заставка San News Corporation:::...")
end

function thrgweather()
	sampSendChat('/news ....:::Музыкальная заставка San News Corporations:::...')
	wait(4000)
	sampSendChat('/news Здраствуйте, дорогие радиослушатели. В эфире прогноз погоды.')
	wait(4000)
	sampSendChat('/news С вами я - Директор San News')
	wait(4000)
	sampSendChat('/news Синоптики сообщают что в городах вот такие прогнозы:')
	wait(4000)
	sampSendChat('/news В г."Los-Santos" +20 °С. Без осадков.')
	wait(4000)
	sampSendChat('/news В г."San-Fierro" +18 °С.Возможно будет дождь, приготовьте зонтики.')
	wait(4000)
	sampSendChat('/news А в г."Las-Venturas" +14 °С.Облачно.')
	wait(4000)
	sampSendChat('/news А пока на этом все.Спасибо за внимание!Всего хорошего!.')
	wait(4000)
	sampSendChat('/news С уважением San News г."Los-Santos".')
	wait(4000)
	sampSendChat('/news С вами как всегда был Директор San News. Не переключайтесь!')
	wait(4000)
	sampSendChat('/news ....:::Музыкальная заставка San News Corporations:::...')
end
function thrgspcars()
	sampSendChat("/o Уважаемые игроки, сейчас произойдет респавн тс! Займите свои места!")
	wait(1000)
	sampSendChat("/spawncars")
	wait(17000)
	sampSendChat("/fuelcars")
	wait(1000)
	sampSendChat("/o Все тс были успешно заспавнены! Приятной игры!")
end

function imgui.OnDrawFrame()
	local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(596, 460), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"Dominant Tool by Inesi", main_window_state, imgui.WindowFlags.NoResize+imgui.WindowFlags.NoMove)
	if imgui.CollapsingHeader(u8'Инструменты') then
	if imgui.Button(u8("Реклама")) then
		sampSendChat("/o Ув.Игроки! Действуют низкие цены на Админ-панель. Подробнее /donate.")
	end
	if imgui.Button(u8("Реклама 2")) then
		sampSendChat("/o Дорогие Игроки Доминант! Покупайте админки по низким ценам! Подробнее /donate.")
	end
	if imgui.Button(u8("Реклама 3")) then
		sampSendChat("/o Здравствуй, уважаемый игрок нашего сервера! У нас действуют низкие цены на Админки! Скорей >>> /donate.")
	end
	if imgui.Button(u8("Заспавнить/заправить кары")) then
		thrgspcars:run()
	end
	if imgui.Button(u8("Пожелать приятной игры")) then
		thrgegg:run()
	end
	if imgui.Button(u8("Передать репорт")) then
		thrgrep:run()
	end
	if imgui.Button(u8("Сообщение")) then
		sampSendChat("/a Тестируется мое говно творение. Не охуевайте с сообщений")
	end
end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8'Для ГА') then
	if imgui.Button(u8("Реклама повышения")) then
		sampSendChat("/a При покупке повышения на каждые плюс 3 лвла, в подарок ещё плюс 2 сверху и кмд /veh!")
		sampSendChat("/a При покупке повышения на каждые плюс 2 лвла, в подарок ещё плюс 1 сверху!")
		sampSendChat("/a Скриншоты чека платежа присылать в вк за получением бонуса - Основателю Проекта!")
	end
	if imgui.Button(u8("Наставления Админам")) then
	sampSendChat("/a РЕПОРТЫ НЕ ИГНОРИМ! ОТВЕЧАЕМ НА РЕПОРТЫ! ЛИДЕРОВ СТАВИМ! ДЕРЖИМ 13+ ЛИДЕРОВ!!")
	sampSendChat("/a РЕПОРТЫ НЕ ИГНОРИМ! ОТВЕЧАЕМ НА РЕПОРТЫ! ЛИДЕРОВ СТАВИМ! ДЕРЖИМ 13+ ЛИДЕРОВ!!")
	sampSendChat("/a РЕПОРТЫ НЕ ИГНОРИМ! ОТВЕЧАЕМ НА РЕПОРТЫ! ЛИДЕРОВ СТАВИМ! ДЕРЖИМ 13+ ЛИДЕРОВ!!")
	end
	imgui.NewLine()
	end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8("Эфиры")) then
		if imgui.Button(u8("Новости")) then
			thrgnews:run()
		end
		if imgui.Button(u8("Погода")) then
			thrgweather:run()
		end
	end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8("Утилиты")) then
		if imgui.Button(u8("Заспавнить транспорт")) then
			thrgspcars:run()
		end
end
	imgui.NewLine()
	if imgui.CollapsingHeader(u8'Шпора') then
		if imgui.CollapsingHeader(u8"Убийство") then
			if imgui.CollapsingHeader(u8"DeatMatch (DM)") then
				imgui.Text(u8("Запрещено убийство игрока без причины."))
				imgui.NewLine()
				imgui.Text(u8("К DM относится:"))
				imgui.Text(u8("- Стрельба без явных причин со стороны любого игрока (любой организации)"))
				imgui.Text(u8("- Беспорядочная стрельба с крыш зданий."))
				imgui.Text(u8("- Стрельба в деятелей администрации (Если администратор всячески мешал вашей игре"))
				imgui.Text(u8(" - напишите жалобу на форум со скриншотами или фрапсом)."))
				imgui.Text(u8("Исключение для банд: На территории гетто разрешено убивать гражданских, если они вам"))
				imgui.Text(u8("мешают, если они стреляют в ответ. Всё остальное будет считаться как DM."))
				imgui.NewLine()
				imgui.Text(u8("К DM не относится:"))
				imgui.Text(u8("- Стрельба идёт между бандитами на территории гетто."))
				imgui.Text(u8("- Стрельба идёт между мафиози."))
				imgui.Text(u8("- Стрельба идёт между бандитами/мафиози и полицейскими."))
				imgui.Text(u8("- Мероприятия любого рода (Так и от администраторов, так и от игроков)"))
				imgui.Text(u8("Если не было никаких RP отыгровок, просто приехали и стали убивать друг друга - считается"))
				imgui.Text(u8("как DM."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 10-20 min]"))
			end
			if imgui.CollapsingHeader(u8"DeatMatch в зеленой зоне (DM in ZZ)") then
				imgui.Text(u8("Запрещены любые побои, убийства в зеленой зоне."))
				imgui.NewLine()
				imgui.Text(u8("Зеленой зоной считается: Интерьер мэрии, и небольшой радиус в округи мэрии; респаун"))
				imgui.Text(u8("новичков, интерьер банка, интерьер наркопритона, интерьер казино."))
				imgui.Text(u8("Исключение: RolePlay мероприятия от банд или мафий."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail-30 min]"))
			end
			if imgui.CollapsingHeader(u8"DeatMatch с использованием огнестрельного транспорта") then
				imgui.Text(u8("Запрещено убийства игроков с использованием огнестрельного транспорта (Танк, Hydra,"))
				imgui.Text(u8("Apache.)"))
				imgui.Text(u8("Исключение: Отбитие атак на военной базе."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Warn]"))
			end
			if imgui.CollapsingHeader(u8"DriveBy (DB)") then
				imgui.Text(u8("Запрещено убийство игрока с водительского места, либо наездом на него."))
				imgui.NewLine()
				imgui.Text(u8("К DB относится:"))
				imgui.Text(u8("- Наезд на игрока, тем самым убивая его."))
				imgui.Text(u8("- Стрельба с водительского места (Стрельба с пассажирского места, к DB не относится)"))
				imgui.Text(u8("- Если придавили транспортным средством и вышли из него."))
				imgui.Text(u8("Примечание: Сбивать игроков разрешено, но убивать их этим запрещено (сбить, развернуться,"))
				imgui.Text(u8("снова сбить)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail на 10-20 min] в зависимости от тяжести нарушения"))
			end
			if imgui.CollapsingHeader(u8"Нападение на игрока в интерьере дома/особняка(SK)") then
				imgui.Text(u8("Запрещено нападение на игрока в интерьере дома/особняка."))
				imgui.Text(u8("Исключение: была погоня."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 20-30 min]"))
			end
			if imgui.CollapsingHeader(u8"Убийство на респауне (Spawnkill)") then
				imgui.Text(u8("Запрещено нападение на игрока в месте его авторизации/появления (радиус 50 метров), это"))
				imgui.Text(u8("может быть, что дом, что респаун организации, респаун новичков."))
				imgui.Text(u8("Исключение: На хитманов при выполнении заказов правило не распространяется. Обязательно"))
				imgui.Text(u8("делайте скриншот с /time заказа, если у администратора будут претензии - предъявите его."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 20-30 min]"))
			end
			if imgui.CollapsingHeader(u8"Убийство своих коллег (TeamKill)") then
				imgui.Text(u8("Запрещено убивать своих коллег/корешей по работе."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 20 min] с последующим увольнением данного игрока."))
				imgui.Text(u8("Примечание: Под TK не попадает PvP в бандах. PvP проходит строго на респауне банды!"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"Чат") then
			if imgui.CollapsingHeader(u8"Оффтоп") then
				imgui.Text(u8("Это написание текста в определенный чат не по его тематике."))
				imgui.Text(u8("Ad, Vad - Чат для рекламы, используется для покупки/продажи имущества, рекламы услуг,"))
				imgui.Text(u8("но только за игровые деньги (Пример Offtop’a: Куплю машину, id 25 хватит ДМить)."))
				imgui.Text(u8("Report - чат для жалоб на игроков (Пример Offtop'a: Админ тп/СРОЧНО тп/Сними варн/пж)."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Предупреждение, если нарушение продолжилось - [Mute 10 min]"))
			end
			if imgui.CollapsingHeader(u8"Флуд") then
				imgui.Text(u8("Это однотипное сообщение, написанное в любой из чатов 5 раз и более в течение 2 минут."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Флуд в любой из чатов - [Mute 10-20 min]"))
			end
			if imgui.CollapsingHeader(u8"CapsLock (Капс)") then
				imgui.Text(u8("Это слова, которые написаны большими буквами. На сервере запрещено писать капсом."))
				imgui.NewLine()
				imgui.Text(u8("К капсу относится:"))
				imgui.Text(u8("-Слово(а) или предложение, которое написано заглавными   буквами(ВСЕМ ПРИВЕТ, Я АРТЁМ!)."))
				imgui.Text(u8('- Два слова или предложение, которое написано "забором" (ПрИмЕр).'))
				imgui.NewLine()
				imgui.Text(u8("К капсу не относится:"))
				imgui.Text(u8("- Аббревиатуры (ФБР, ПДД, ЛКН и т.д)."))
				imgui.Text(u8("- Имена игроков, написанные заглавными буквами(FABIAN LORENZO)."))
				imgui.Text(u8("Исключение: RolePlay Caps (Пример: Куплю порошок, СРОЧНО)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание:  [Mute 10 min]"))
			end
			if imgui.CollapsingHeader(u8"Троллинг") then
				imgui.Text(u8('Запрещено провоцирование игроков на написание сообщения с целью флуда в OOC, Ad, Report'))
				imgui.Text(u8('и другие чаты. Пример: ("Кому нравится Eternity MP "+" в /vad!").'))
				imgui.Text(u8('Исключение: Чат sms. При указании чужого id - приравнивается к троллингу.'))
				imgui.NewLine()
				imgui.Text(u8('Наказание: [Mute 10 min]'))
			end
			if imgui.CollapsingHeader(u8"Повторение символов") then
				imgui.Text(u8('Запрещено написание в один из чатов "+++++" "_____", а так же смайлов и прочее (/b чат под'))
				imgui.Text(u8('правило не попадает)'))
				imgui.NewLine()
				imgui.Text(u8('Наказание:  [Mute 5-10 min] в зависимости от тяжести нарушения.'))
				imgui.Text(u8('Примечание: Наказание за больше 5-ти знаков. Умышленное написание реплики в подобном'))
				imgui.Text(u8('роде, обходя наказание, также попадает под правило.'))
			end
			if imgui.CollapsingHeader(u8"Метагейминг") then
				imgui.Text(u8("Запрещено писать информацию из реальной жизни в игровой чат (OOC in IC)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Предупреждение, если нарушение продолжилось - [Mute 10 min]"))
				imgui.Text(u8("Текст относящийся к реальной жизни и не имеющий никакого отношения в игровому процессу."))
				imgui.Text(u8("Пример: Зайди на форум и посмотри,за дм дают наказание в виде *** минут джайла,а ты нарушаешь!"))
			end
			if imgui.CollapsingHeader(u8"Оскорбление") then
				imgui.Text(u8('Это неадекватное поведение игрока, который проявил неуважение к другому игроку. Из уст'))
				imgui.Text(u8('игрока, которого льется оскорбление в любой чат будет наказан. (Нуб не оскорбление!).'))
				imgui.Text(u8('Исключение: Оскорблять друг друга, если вы друзья и терпите такое отношение, не наказуемо,'))
				imgui.Text(u8('только если вы сами не пожалуетесь. Если нарушение серьёзное администратор в праве'))
				imgui.Text(u8('заблокировать аккаунт.'))
				imgui.Text(u8('Если оскорбление входит в РП процесс, то есть вы состоите в банде и оскорбили другого'))
				imgui.Text(u8('бандита, а потом встретились и разобрались и это все доказано скриншотами с /time,'))
				imgui.Text(u8('то наказания не будет.'))
				imgui.NewLine()
				imgui.Text(u8('Наказание:'))
				imgui.Text(u8('1. Оскорбление игрока – [Mute 30-40 min] в зависимости от тяжести нарушения.'))
				imgui.Text(u8('("Нуб"не считается оскорблением.)'))
				imgui.Text(u8('2. Оскорбление Администрации – [Mute 60 min, Ban 3 Дня. В зависимости от нарушения]'))
				imgui.Text(u8('3. Оскорбление родных и какие-либо зарекания на счёт родственников – [ban 15-30 дней]'))
				imgui.Text(u8('4. Оскорбление нации игрока - [Mute 180 min]'))
				imgui.Text(u8('5. Оскорбление любой организации – [Mute 20 min]'))
				imgui.Text(u8('Оскорбление любой организации в Vad – [Mute 20 min] + 1 предупреждение VIP игроку.'))
				imgui.Text(u8('6. Оскорбление сервера - [Mute 60-300 min, Pernament BAN]  в зависимости от тяжести нарушения.'))
				imgui.Text(u8('7. К оскорблениям так же относится завуалировка, по типу "lox", "s o si", и тому подобное,'))
				imgui.Text(u8('на перевод которых отнекивались игроки.'))
				imgui.Text(u8('8. Оскорбление проекта карается занесением нарушителя в его Чёрный Список.'))
				imgui.Text(u8('Примечание: Скрытое оскорбление также является наказуемым.'))
			end
			if imgui.CollapsingHeader(u8"Мат") then
				imgui.Text(u8('Наиболее грубая разновидность ненормативной лексики (Литературные слова, как "С*ка",'))
				imgui.Text(u8('оставьте при себе). Игрок, из уст которого льётся мат, будет наказан.'))
				imgui.NewLine()
				imgui.Text(u8('Наказание: Мат в любой из чатов карается [Mute 10 min]. Пытайтесь себя держать в руках или'))
				imgui.Text(u8('идите в скайп.')) 
				imgui.Text(u8('Примечание: Скрытый мат также наказуем.'))
			end
			if imgui.CollapsingHeader(u8"Шантаж игроков/администраторов") then
				imgui.Text(u8("Шантаж игроков/администраторов запрещен. (Пример: Давай 100к или я кину на тебя жалобу)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание:"))
				imgui.Text(u8("1. Шантаж игроков – [Mute 20 min]"))
				imgui.Text(u8("2. Шантаж администраторов - [Mute 40 min]"))
			end
			if imgui.CollapsingHeader(u8"Обман") then
				imgui.Text(u8("Запрещены любые попытки обмана игроков/администрации."))
				imgui.NewLine()
				imgui.Text(u8("Наказание:"))
				imgui.Text(u8("Обман администрации – [Бан или же мут-40 минут]-Взависимости от тяжести нарушения."))
				imgui.Text(u8("Обман игроков – [Jail 20 min] + [Mute 40 min]"))
				imgui.Text(u8("Примечание: Администрация вправе посадить всех игроков, причастных к обману. В случае"))
				imgui.Text(u8("обмана на имущество, заполученная недвижимость возвращается в руки пострадавшего."))
			end
			if imgui.CollapsingHeader(u8"Угроза жалобами/баном/снятием") then
				imgui.Text(u8('Запрещены угрозы баном по типу "Мой друг админ, жди бана." или же "Жди бан уродец" и др.'))
				imgui.Text(u8('Также запрещена угроза жалобами или снятиями администраторов. (Не нравится'))
				imgui.Text(u8('администратор – пишите жалобу на форум, но фразы «жди жб» или  «жди снятия» и т.д.'))
				imgui.Text(u8('оставьте при себе)'))
				imgui.NewLine()
				imgui.Text(u8('Наказание: [Mute 20-30 min] в зависимости от тяжести нарушения.'))
			end
			if imgui.CollapsingHeader(u8"Неадекватное поведение") then
				imgui.Text(u8("Запрещено неадекватное поведение в любой из чатов (Пример: Я вас всех е*ал ко*пы е*учие;"))
				imgui.Text(u8("Не люди, а е*антяи и т.п.)."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Mute 20-30 min]  в зависимости от тяжести нарушения."))
			end
			if imgui.CollapsingHeader(u8"Распространение слухов") then
				imgui.Text(u8("Запрещено распространение слухов, клеветы о сервере и администраторах."))
				imgui.Text(u8("Наказание: [Mute 30 min]"))
				imgui.Text(u8("Примечание: Сохраняйте дружелюбный тон и манеру общения."))
			end
			if imgui.CollapsingHeader(u8"Реклама стороннего сервера/сайта") then
				imgui.Text(u8("Рекламы сторонних сайтов, проектов запрещены."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"Обсуждение действий администрации") then
				imgui.Text(u8("Запрещено обсуждать/оспаривать действия администрации, выданные ими наказания на"))
				imgui.Text(u8("форуме и в игре. Для этого существует раздел жалоб на администрацию проекта."))
				imgui.NewLine()
				imgui.Text(u8("Наказание:"))
				imgui.Text(u8("В игре: [Mute 15 min]"))
				imgui.Text(u8("На форуме: Блокировка аккаунта на 5 дней."))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"РП") then
			if imgui.CollapsingHeader(u8"Срывы/помехи") then
				imgui.Text(u8("Запрещены какие-либо срывы, помехи в восприятии игрового процесса"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Предупреждение, если нарушение продолжилось - [Jail 10 min]"))
			end
			if imgui.CollapsingHeader(u8"Раздача звезд (Законники)") then
				imgui.Text(u8("Запрещена дача звёзд с бессмысленными причинами, которые не закреплены в уголовном"))
				imgui.Text(u8("кодексе штата. А так же раздача звёзд законниками, без наличия фактического нарушения"))
				imgui.Text(u8("закона. Также запрещена увеличенная раздача звезд. ( Пример: за убийство дают 3 звезды,"))
				imgui.Text(u8("но законник выдал 6)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Warn]"))
			end
			if imgui.CollapsingHeader(u8"Использование команд /iznas и /minet") then
				imgui.Text(u8("Запрещено использовать более 5 команд на человеке, а так же флудить ими."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Предупреждение, если нарушение продолжилось - [Jail 15 min]"))
			end
			if imgui.CollapsingHeader(u8"Служебное положение") then
				imgui.Text(u8("Запрещено использовать служебное положение в личных целях. (Например, использовать"))
				imgui.Text(u8("шокер на мероприятиях, пользоваться возможностями лидера в корыстных целях и т.п.)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 20-30 min]"))
			end
			if imgui.CollapsingHeader(u8"Срыв собраний организаций") then
				imgui.Text(u8("Запрещено срывать собрания организаций. Конечно, если это будет супер мега РП нападение"))
				imgui.Text(u8("с взятием в заложники и с минимумом выстрелов, то наказания не будет. Степень РП"))
				imgui.Text(u8("определит главный администратор."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 10 min]"))
			end
			if imgui.CollapsingHeader(u8"RP процесс") then
				imgui.Text(u8("Запрещено вести себя не по RP ситуации (т.е. срывать RP процесс, делая то, что не положено"))
				imgui.Text(u8("и т.д.), иными словами NonRP."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 10-30 min], в зависимости от тяжести нарушения."))
			end
			if imgui.CollapsingHeader(u8"Увольнение игроков") then
				imgui.Text(u8('Запрещено увольнять игроков по глупым причинам (Пример: уволил по причине: "закройся")'))
				imgui.NewLine()
				imgui.Text(u8('Наказание: [Uval]'))
			end
			if imgui.CollapsingHeader(u8"NonRP Набор") then
				imgui.Text(u8("Запрещено принимать набор в неположенном для этого места, принимать без всякой"))
				imgui.Text(u8("RP отыгровки/опроса."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Uval или же jail-30 min]"))
			end
			if imgui.CollapsingHeader(u8"PowerGaming") then
				imgui.Text(u8("Запрещено вести себя так, как бы вы не поступили в реальной жизни, запрещено изображать"))
				imgui.Text(u8("из себя героя. (Пример: игрок, находящийся под прицелом противника, безоружный"))
				imgui.Text(u8("отказывается сдаваться или игрок дерется на кулаках против 3 вооруженных противников)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 10 min],  при неоднократном нарушении - [Warn]"))
			end
			if imgui.CollapsingHeader(u8"Сбив анимации") then
				imgui.Text(u8("Запрещено сбивать анимацию персонажа."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Jail 30 min]. При неоднократном сбивании игроку выдается [Warn]"))
			end
			if imgui.CollapsingHeader(u8"Отыгровка с администратором") then
				imgui.Text(u8('Игрокам запрещено отыгрывать РП ситуации с админами, нацеленные на отыгровку с'))
				imgui.Text(u8('админом, либо на ведение с ним РП диалога.'))
				imgui.Text(u8('Примечание: Админ нонРП персонаж, помните это. Его задача помогать, а не играть.'))
				imgui.Text(u8('Разговаривать с ним можно в любой чат, не соблюдая МетаГейминг.'))
				imgui.NewLine()
				imgui.Text(u8('Наказание: Предупреждение игроку. Далее [Jail 10 min] с причиной "Отыгровка с админом".'))
			end
			if imgui.CollapsingHeader(u8"Нахождение ПД в Гетто") then
				imgui.Text(u8('ПД разрешается находиться в гетто в следующих случаях: патрулирование(минимум'))
				imgui.Text(u8('2 человека),провождение спец операций,RP отыгровок(проведение облав,наркорейды и тд).'))
				imgui.NewLine()
				imgui.Text(u8('Наказание:  Два предупреждения в репорт покинуть гетто.После этого Jail 10 min.'))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"АФК/Уход") then
			if imgui.CollapsingHeader(u8"Использование Анти-Афк") then
				imgui.Text(u8("Запрещено специальное зажатие клавиш или с помощью программы, с целью чтобы вас не"))
				imgui.Text(u8("кикало с сервера."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Джайил-30 минут.. При повторном простаивании -[Warn]"))
			end
			if imgui.CollapsingHeader(u8"Отход в AFK") then
				imgui.Text(u8("Запрещён несвоевременный выход из игры, а так же несвоевременное использование паузы."))
				imgui.NewLine()
				imgui.Text(u8("Наказание:"))
				imgui.Text(u8("1. Выход из игры после нарушения правил сервера [Warn]"))
				imgui.Text(u8("2. Выход при аресте [Jail 20-30 min]"))
				imgui.Text(u8("3. AFK при аресте – [Jail 20-30 min] (если игрок в режиме AFK более двух минут)"))
				imgui.Text(u8("4. Длительный простой без движения - Кик (если игрок стоит на одном месте более часа)"))
			end
			if imgui.CollapsingHeader(u8"Уход от наказания") then
				imgui.Text(u8("Запрещено уходить от наказания администрации."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Warn]"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"ПО") then
			if imgui.CollapsingHeader(u8"Программное обеспечение") then
				imgui.Text(u8("Запрещено использование стороннего программного обеспечения, клео, скриптов, читов."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [BAN 7-10 days] или [Warn], в зависимости от тяжести нарушения."))
				imgui.Text(u8("Если человек состоит в организации – [Warn]"))
			end
			if imgui.CollapsingHeader(u8"Оружие") then
				imgui.Text(u8("Не допускается использовать запрещенное оружие (исключение: M4, AK47, Desert Eagle,"))
				imgui.Text(u8("Shotgun, Smg, балончик, коповская дубинка, дымовая граната, нож и снайперская винтовка[если игрок хитман])."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [BAN 7 days], если игрок использовал запрещенное ПО. Если оружие выдал"))
				imgui.Text(u8("администратор – sethp игроку и выговор администратору (выговор будет дан даже в том"))
				imgui.Text(u8("случае, если администратор сам себе его выдал)"))
			end
			if imgui.CollapsingHeader(u8"Распространение ПО") then
				imgui.Text(u8("Запрещено распространять стороннее ПО, клео, скрипты, читы, баги игры на сервере."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Бан без права на восстановление."))
			end
			if imgui.CollapsingHeader(u8"Модернизации клиента") then
				imgui.Text(u8("Запрещены любые модернизации клиента игры, которые дают преимущество над другими"))
				imgui.Text(u8("игроками. (Например, паркур мод, убирание столбов, зданий)"))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Warn], если игрок не удалил мод – [BAN 7 days]"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"Багоюз") then
			if imgui.CollapsingHeader(u8"Багоюз") then
				imgui.Text(u8("Намеренное использование недоработок сервера в своих и корыстных целях. Прежде, чем"))
				imgui.Text(u8("что-либо сделать игрок должен задуматься о последствиях, спросить у администрации"))
				imgui.Text(u8("сервера можно ли так делать или нет. При нахождении багов игрового мода, следует"))
				imgui.Text(u8("немедленно сообщить о них администрации при помощи репорта или при помощи /bags."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Warn]"))
			end
			if imgui.CollapsingHeader(u8"+C") then
				imgui.Text(u8("Запрещено использовать багоюз +С на сервере."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [jail 10-20 min]"))
			end
			if imgui.CollapsingHeader(u8"Обход системы мута и прочих систем") then
				imgui.Text(u8('Запрещено использовать недоработки мода, связанные с обходом системы мута и иных систем,'))
				imgui.Text(u8('написанием .ru и иных доменов в конце вашего предложения для того, чтобы администратор'))
				imgui.Text(u8('увидел это сообщение.'))
				imgui.NewLine()
				imgui.Text(u8('Наказание:  [Warn] с пометкой "Багоюз"'))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"Никнеймы") then
			if imgui.CollapsingHeader(u8"Фейк-ники") then
				imgui.Text(u8("Запрещено создавать аккаунт с именем игрока, который уже существует."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: устное предупреждение в виде просьбы сменить имя, при отказе – [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"НонРП ники") then
				imgui.Text(u8("Создавая аккаунт с нонРП ником вы должны осознавать и понимать, что с нонРП ником"))
				imgui.Text(u8("никуда не вступить. Имя должно состоять из латиницы и нести смысловую нагрузку."))
				imgui.Text(u8('Примечание: Помните, что состоять с нонРП ником во фракции запрещено и любые подобные'))
				imgui.Text(u8('случаи будут пресекаться, а игроки с нонРП никами увольняться. Если их повторно заметят в'))
				imgui.Text(u8('этих же организациях - они получат варн с причиной "НонРП ник".'))
				imgui.NewLine()
				imgui.Text(u8("Наказание:  Устное предупреждение в виде просьбы сменить имя."))
			end
			if imgui.CollapsingHeader(u8"Плохие ники") then
				imgui.Text(u8("Запрещено использовать имена, содержащие оскорбительный смысл, либо нецензурные слова."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"Тэг в нике") then
				imgui.Text(u8("Запрещено ставить тэг банд/мафий/организаций/кланов в имена."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Perpetual BAN]"))
			end
			if imgui.CollapsingHeader(u8"Выдача себя за другого игрока") then
				imgui.Text(u8("Запрещена выдача себя за администратора или другого игрока."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Perpetual BAN]"))
			end
			imgui.NewLine()
		end
		if imgui.CollapsingHeader(u8"Другое") then
			if imgui.CollapsingHeader(u8"Мультиаккунты") then
				imgui.Text(u8("Иметь 3 и больше аккаунтов запрещено, можно иметь только 2 аккаунта."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Удаление всех аккаунтов. Останется только 2 аккаунта с наибольшим уровнем."))
			end
			if imgui.CollapsingHeader(u8"Махинации с аккаунтами") then
				imgui.Text(u8("Махинации с аккаунтами (Продажа/покупка/передача/обмен/игровыми аккаунтами) запрещены,"))
				imgui.Text(u8("при возникновении вопросов, аккаунт будет заблокирован."))
				imgui.Text(u8("Наказание: [Perpetual BAN]"))
				imgui.Text(u8("Примечание: Дать аккаунт брату, сестре, другу, родственникам так же считается нарушением"))
			end
			if imgui.CollapsingHeader(u8"Вред проекту") then
				imgui.Text(u8("Вред проекту Eternity Project не допускается и будет наказан."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Perpetual BAN] или блокировка сети без права на разблокировку сети."))
			end
			if imgui.CollapsingHeader(u8"Продажа/покупка игровой валюты") then
				imgui.Text(u8("Запрещены продажи/покупки игровой валюты от других игроков за реальные деньги. При"))
				imgui.Text(u8("осуществлении сделки наказаны будут обе стороны."))
				imgui.NewLine()
				imgui.Text(u8("Наказание: [Perpetual BAN] обеих сторон"))
				imgui.Text(u8("Примечание: Администрация вправе наказать игрока за ПОПЫТКУ осуществления сделки."))
			end
			if imgui.CollapsingHeader(u8"Пропаганда экстремистских группировок и запрещенных движений") then
				imgui.Text(u8("Запрещена пропаганда любого движения/группировки, которое запрещено на территории"))
				imgui.Text(u8('Российской Федерации, такие как "Исламское государство",'))
				imgui.Text(u8('"Имарат Кавказ", "Братья-мусульмане" и т.д.'))
				imgui.NewLine()
				imgui.Text(u8("Наказание: Бан без права на восстановление."))
			end
			imgui.NewLine()
		end
	end
	imgui.NewLine()
	imgui.Text(u8("----------------------------------------------------------------------"))
	imgui.Text(u8(string.format('Текущая дата и время: %s', os.date())))
	imgui.Text(u8("----------------------------------------------------------------------"))
	imgui.End()
end