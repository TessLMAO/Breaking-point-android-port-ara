local allowCountdown = false
local startedEndDialogue = false
local keepScroll = false

function onCreate()
	makeLuaSprite('sonic', 'bg/sonic', -250, -50)
	addLuaSprite('sonic', false)
	
	setProperty('skipCountdown', true)
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'darkFleetw')
	
	makeLuaSprite('screendarken', 'cover', 0, 0)
	setProperty('screendarken.alpha', 0)
	scaleObject('screendarken', 120, 120)
	setObjectCamera('screendarken', 'other')
	
	makeLuaSprite('screendarkenBeginning', 'makeGraphicsucks', -1000, -1000)
	setProperty('screendarkenBeginning.alpha', 1)
	scaleObject('screendarkenBeginning', 16000, 16000)
	setObjectCamera('screendarkenBeginning', 'camGame')
	addLuaSprite('screendarkenBeginning', true)
	
    addCharacterToList('sonic-xain', 'dad')
    addCharacterToList('sonic-getoutstillhere', 'boyfriend')
    addCharacterToList('sonic-stillhere', 'boyfriend')
	addCharacterToList('darkFleetw', 'boyfriend')
	
	precacheSound('FleetAppear')
	precacheSound('FleetLaugh')
	precacheSound('FleetLaugh2')
	precacheSound('FleetStepitup')
	precacheSound('FleetScream')
	precacheSound('FleetGrowl')
	precacheSound('FleetGrowl2')
	precacheSound('FleetShutUp')
	
    precacheImage('overlay')
	precacheImage('coverarrow')
	precacheImage('xain_veins')
	precacheImage('sonic', 'bg/sonic')
	precacheImage('xain', 'bg/xain')
	precacheImage('dw', 'bg/dw')
	precacheImage('getout', 'bg/getoutofmyhead')
	setProperty('cameraSpeed', 0.5)
	
	setProperty('camGame.alpha', 1)
	
    setProperty('gf.alpha', tonumber(0))
    setProperty('iconP1.alpha', tonumber(0))
	setProperty('iconP2.alpha', tonumber(0))
	setProperty('healthBar.alpha', tonumber(0))
	setProperty('scoreTxt.visible', false)
	
	makeLuaSprite('sonicIcon', 'sonicweaker', getProperty('iconP1.x'), getProperty('iconP1.y'))
	
	setObjectOrder('gfGroup', getObjectOrder('boyfriendGroup')+10) --gf layered on top of bf
	
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
    
    local var font = "vcr.ttf" -- the font that the text will use.
	
	setProperty('camHUD.alpha', 0);
	
	if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
        makeLuaText("sonicScore", 'Score: 0', 200, 440, 26);
    else
        makeLuaText("sonicScore", 'Score: 0', 200, 440, 664);
    end
	
    setObjectCamera("sonicScore", 'camHUD');
    setTextColor('sonicScore', '0xffffff')
    setTextSize('sonicScore', 20);
    addLuaText("sonicScore");
    setTextFont('sonicScore', font)
    setTextAlignment('sonicScore', 'center')
	setObjectOrder('sonicScore', getObjectOrder('iconP1')-1)

	if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
		makeLuaText("maxmisses", 'Max Misses: 5', 200, 640, 26);
	else
		makeLuaText("maxmisses", 'Max Misses: 5', 200, 640, 664);
	end

    setObjectCamera("maxmisses", 'hud');

    setTextColor('maxmisses', '0x36eaf7')
    setTextSize('maxmisses', 20);
    addLuaText("maxmisses");
    setTextFont('maxmisses', font)
    setTextAlignment('maxmisses', 'center')
	setObjectOrder('maxmisses', getObjectOrder('iconP1')-1)
	
	setProperty('warning1.alpha', tonumber(0))
	setProperty('warning2.alpha', tonumber(0))
	setProperty('maxmisses.alpha', tonumber(1))
end

function onSongStart()
	triggerEvent('Change Character', 'bf', 'sonic-getoutstillhere')
	triggerEvent('Change Character', 'bf', 'sonic-stillhere')
	triggerEvent('Change Character', 'bf', 'darkFleetw')
end

function onCreatePost()
	if dadName == 'sonic-xain' then --replace the name for your character name if you have the charecter as your opp youll get the notes
		for i=0,4 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'HisNotes')
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'HisNotes'); --Change texture
			end
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'InvNotes' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'InvNotes'); --Change texture
			end
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    health = getProperty('health')
	if curStep < 1235 or curStep > 1359 then
		if getProperty('health') > 0.023 then
			setProperty('health', health- 0.022)
		end
	else
		if getProperty('health') > 0.023 then
			setProperty('health', health- 0.0115)
		end
	end
end

function goodNoteHit()
	if curStep > 1359 then
		health = getProperty('health')
		setProperty('health', health+ 0.022)
	end
end

function XainSing()
	makeAnimatedLuaSprite('fx', 'bg/vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 16, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHUD')
	objectPlayAnimation('fx', 'idle', true)

	makeLuaSprite('xain', 'bg/xain', -250, -50)
	addLuaSprite('xain', false)
	removeLuaSprite('sonic')
	removeLuaSprite('getout')
	
	setProperty('fx.alpha', 0.4)
	doTweenAlpha('XainSinging', 'fx', 0.25, 1, 'linear')
	addLuaSprite('fx', true)
	
	setProperty('fxdw.alpha', 0.4)
	doTweenAlpha('DWSinging', 'fxdw', 0, 1, 'linear')
end

function DWSing()
	makeAnimatedLuaSprite('fxdw', 'bg/vintagedw', 0, 0)
	addAnimationByPrefix('fxdw', 'idle', 'idle', 16, true)
	scaleObject('fxdw', 3, 3)
	setObjectCamera('fxdw', 'camHUD')
	objectPlayAnimation('fxdw', 'idle', true)
	
	makeLuaSprite('dw', 'bg/dw', -250, -50)
	addLuaSprite('dw', false)
	removeLuaSprite('xain')
	removeLuaSprite('sonic')
	removeLuaSprite('getout')
	
	setProperty('fxdw.alpha', 0.4)
	doTweenAlpha('DWSinging', 'fxdw', 0.25, 1, 'linear')
	addLuaSprite('fxdw', true)
	
	setProperty('fx.alpha', 0.4)
	doTweenAlpha('XainSinging', 'fx', 0, 1, 'linear')
end

function onGameOver()
	if getProperty('songMisses') < 5 then
		return Function_Stop
	else
		return Function_Continue
	end
end

function onDestroy()
	setPropertyFromClass("openfl.Lib","application.window.title", "Friday Night Funkin': Psych Engine")
end

function onUpdate(elapsed)
	fakeScoring = getProperty('songScore')
    fakeRating = getProperty('ratingFC')
	
    if inGameOver then
		setPropertyFromClass("openfl.Lib","application.window.title", "YOU'RE JUST AS WEAK AS HIM")
    end
	
	setTextString('sonicScore', 'Score: ' .. fakeScoring .. ' - ' .. fakeRating)
	
	if curStep >= 0 and curStep <= 2050 then --change window name back at end of song
		if getProperty('songMisses') == 0 then
			setTextString('maxmisses', 'Max Misses: 5')
			setPropertyFromClass("openfl.Lib","application.window.title", "B R E A K I N G   P O I N T")
		elseif getProperty('songMisses') == 1 then
			setTextString('maxmisses', 'Max Misses: 4')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween', 'screendarken', 0.2, 1.5, 'linear')
			doTweenAlpha('XainVeinsReturn1', 'xain_veins', 0.25, 1.5, 'linear')
		elseif getProperty('songMisses') == 2 then
			setTextString('maxmisses', 'Max Misses: 3')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween2', 'screendarken', 0.35, 1.5, 'linear')
			doTweenAlpha('XainVeinsReturn2', 'xain_veins', 0.5, 1.5, 'linear')
		elseif getProperty('songMisses') == 3 then
			setTextString('maxmisses', 'Max Misses: 2')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween3', 'screendarken', 0.5, 1.5, 'linear')
			doTweenAlpha('XainVeinsReturn3', 'xain_veins', 0.75, 1.5, 'linear')
		elseif getProperty('songMisses') == 4 then
			setTextString('maxmisses', 'Max Misses: 1')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween4', 'screendarken', 0.65, 1.5, 'linear')
			doTweenAlpha('XainVeinsReturn4', 'xain_veins', 1, 1.5, 'linear')
			triggerEvent('Screen Shake','0.125,0.00125','0.125,0.00125')
		elseif getProperty('songMisses') >= 5 then
			setTextString('maxmisses', 'Max Misses: 0')
			setPropertyFromClass("openfl.Lib","application.window.title", "YOU'RE JUST AS WEAK AS HIM")
			setTextString('Lost', "YOU LOST")
			setProperty('health', 0)
		end
	elseif curStep >= 2050 then
		setPropertyFromClass("openfl.Lib","application.window.title", "Friday Night Funkin': Psych Engine")
	end
	if curStep < 1235 or curStep > 1359 and curStep < 1491 then --1236 --1360
    -- icon fading shit
		if curBeat % 2 == 1 and curStep > 164 then
			doTweenAlpha('areYouFading?Tween1', 'iconP1', 0.6, 0.3, 'linear')
			if curStep > 164 and curStep < 1930 then
				doTweenAlpha('areYouFading?Tween2', 'iconP2', 0.6, 0.3, 'linear')
			end
		elseif curBeat % 2 == 0 and curStep > 164 then
			doTweenAlpha('areYouNotFading?Tween1', 'iconP1', 0.9, 0.3, 'linear')
			if curStep > 164 and curStep < 1930 then
				doTweenAlpha('areYouNotFading?Tween2', 'iconP2', 0.9, 0.3, 'linear')
			end
		elseif curBeat % 2 == 1 and curStep > 164 then
			doTweenAlpha('ohShitTween1', 'iconP1', 0.1, 0.1, 'linear')
			if curStep > 164 and curStep < 1930 then
				doTweenAlpha('ohShitTween2', 'iconP2', 0.1, 0.1, 'linear')
			end
		elseif curBeat % 2 == 0 and curStep > 164 then
			doTweenAlpha('ohShitFuckTween1', 'iconP1', 0.4, 0.1, 'linear')
			if curStep > 164 and curStep < 1930 then
				doTweenAlpha('ohShitFuckTween2', 'iconP2', 0.4, 0.1, 'linear')
			end
		elseif curBeat % 2 == 1 and curStep > 164 then
			doTweenAlpha('nahWeGooTween1', 'iconP1', 0.8, 0.3, 'linear')
			if curStep > 164 and curStep <= 1930 then
				doTweenAlpha('nahWeGooTween2', 'iconP2', 0.8, 0.3, 'linear')
			end
		elseif curBeat % 2 == 0 and curStep > 164 then
			doTweenAlpha('nahWeGoo2Tween1', 'iconP1', 1, 0.3, 'linear')
			if curStep > 164 and curStep < 1930 then
				doTweenAlpha('nahWeGoo2Tween2', 'iconP2', 1, 0.3, 'linear')
			end
		end
	-- end of icon fading shit
	elseif curStep < 1555 then
		doTweenAlpha('donefadingaaa2', 'iconP2', 1, 0.3, 'linear')
	end
	if curStep > 1 and curStep < 1376 then --1236 --1360
		setProperty('sonicIcon.x', getProperty('iconP1.x'))
		setProperty('sonicIcon.y', getProperty('iconP1.y'))
		setProperty('sonicIcon.scale.x', getProperty('iconP1.scale.x'))
		setProperty('sonicIcon.scale.y', getProperty('iconP1.scale.y'))
		setProperty('sonicIcon.antialiasing',true)
		setProperty('sonicIcon.angle', getProperty('iconP1.angle'))
		setObjectCamera('sonicIcon', 'hud')
		setObjectOrder('sonicIcon', getObjectOrder('scoreTxt') - 1)
		setProperty('sonicIcon.x',P1Mult - 180)
		setProperty('sonicIcon.origin.x',320)
	end

    --Heavy Flicker
    if getProperty('songMisses') == 4 then
        if curStep % 2 == 0 then
            setTextColor('maxmisses', 'ff0000');
        end
        if curStep % 2 == 1 then
            setTextColor('maxmisses', 'ffffff')
        end
    end 
	--Medium Flicker
	if getProperty('songMisses') == 3 then
        if curStep % 4 == 0 then
            setTextColor('maxmisses', 'ff0000');
        end
        if curStep % 4 == 2 then
            setTextColor('maxmisses', 'ffffff')
        end
    end
	--Light Flicker
    if getProperty('songMisses') == 2 or getProperty('songMisses') == 1 then
        if curStep % 8 == 0 then
            setTextColor('maxmisses', 'ff0000');
        end
        if curStep % 8 == 4 then
            setTextColor('maxmisses', 'ffffff')
        end
    end
	
	if curBeat % 2 == 0 then
		setTextColor('warning2', 'ff0000');
	end
    if curBeat % 2 == 1 then
		setTextColor('warning2', 'ffffff')
	end
end

function CoverArrowFlash()
	makeLuaSprite('coverarrow', 'cover', 0, 0)
	addLuaSprite('coverarrow', true)
	scaleObject('coverarrow', 120, 120)
	setProperty('coverarrow.alpha', 1)
	setObjectCamera('coverarrow', 'other')
	doTweenAlpha('coverarrowtween1', 'coverarrow', 0, 1.5, 'linear')
end

function SonicSinging()
	setProperty('defaultCamZoom', 0.7)
	setProperty('boyfriend.x', 450)
	cameraFlash('game', '0xFFFFFF', 0.5, true)
	setProperty('boyfriend.alpha', 1)
	setProperty('dad.alpha', 0)
	DWSing()
end

function XainSinging()
	cameraFlash('game', '0x000000', 0.5, true)
	setProperty('boyfriend.x', 300)
	setProperty('boyfriend.alpha', 0)
	setProperty('dad.x', 450)
	setProperty('dad.alpha', 1)
	setProperty('defaultCamZoom', 0.8)
	XainSing()
	
	setProperty('dad.x', 450)
	setProperty('dad.alpha', 1)
	setProperty('dad.visible', true)
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
end

function XainBesideSonic()
	cameraFlash('game', '0x000000', 0.5, true)
	setProperty('boyfriend.x', 450)
	setProperty('boyfriend.alpha', 1)
	setProperty('dad.x', 300)
	setProperty('dad.alpha', 0.25)
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
	setProperty('defaultCamZoom', 0.7)
	DWSing()
	
	setProperty('dad.x', 300)
	setProperty('dad.alpha', 0.25)
	setProperty('dad.visible', true)
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
end

function SonicBesideXain()
	cameraFlash('game', '0x000000', 0.5, true)
	setProperty('boyfriend.alpha', 0.25)
	setProperty('boyfriend.x', 300)
	setProperty('dad.x', 450)
	setProperty('dad.alpha', 1)
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top bf
	setProperty('defaultCamZoom', 0.8)
	XainSing()
	
	setProperty('dad.x', 450)
	setProperty('dad.alpha', 1)
	setProperty('dad.visible', true)
	setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
end

function SonicSingingStillHere()
	addLuaSprite('sonicIcon', true)
	doTweenAlpha('sonicIconfadehere', 'sonicIcon', 0.85, 2, "linear")
	doTweenAlpha('bfIconfade', 'iconP1', 0.15, 1, "linear")
	setProperty('dad.x', 300)
	setProperty('boyfriend.x', 450)
	setProperty('gf.x', 450)
	cameraFlash('game', '0xFFFFFF', 0.5, true)
	setProperty('gf.alpha', 1)
	setProperty('boyfriend.alpha', 0)
	setProperty('dad.alpha', 0.25)
	SonicSing()
end

function SonicFadeBackToFleet()
	setProperty('dad.x', 300)
	setProperty('boyfriend.x', 450)
	setProperty('gf.x', 450)
	doTweenAlpha('gfAlpha0', 'gf', 0, 1.25, "linear")
	doTweenAlpha('bfAlpha0', 'boyfriend', 1, 1.25, "linear")
	doTweenAlpha('bfIconfade', 'iconP1', 1, 2, "linear")
	doTweenAlpha('sonicIconfadebye', 'sonicIcon', 0, 2, "linear")
	SonicSing()
	setProperty('defaultCamZoom', 0.7)
end

-- long function time
function onStepHit()
	if curStep == 1 then
		setProperty('dad.alpha', 0)
		setProperty('boyfriend.alpha', 1)
		setProperty('sonicIcon.alpha', tonumber(0))
	end
	if curStep == 68 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
		cameraFlash('game', '0xFFFFFF', 0.5, true)
	end
	if curStep == 69 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 72 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 73 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 76 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 77 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 80 then
		doTweenAlpha('hud', 'camHUD', 1, 6, "quartInOut")
		
		doTweenZoom('zoomieIntoSonic', 'camGame', 1, 6, 'circOut')
		
        makeLuaText('warning1', "MAX MISSES: 5", 500, screenWidth / 2 - 250, screenHeight / 2 - 100);
        setObjectCamera("warning1", 'hud');
        setTextColor('warning1', '0xff0000')
        setTextSize('warning1', 30);
        addLuaText("warning1");
        doTweenAlpha('warning1alpha', 'warning1', 1, 1, 'linear')
        setTextFont('warning1', font);
        setTextAlignment('warning1', 'center');
		
        makeLuaText('warning2', "Mild epliepsy warning and screen shaking, proceed with caution!", 500, screenWidth / 2 - 250, screenHeight / 2 + 50);
        setObjectCamera("warning2", 'hud');
        setTextColor('warning2', '0xffffff')
        setTextSize('warning2', 25);
        addLuaText("warning2");
        doTweenAlpha('warning2alpha', 'warning2', 1, 1, 'linear')
        setTextFont('warning2', font)
        setTextAlignment('warning2', 'center')
		
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
		
		doTweenAlpha('sonicScoreAlpha', 'sonicScore', 0, 0.075, "linear")
		doTweenAlpha('maxmissesAlpha', 'maxmisses', 0, 0.075, "linear")
	end
	if curStep == 81 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 84 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 85 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 88 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 89 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 92 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 93 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 96 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 97 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 100 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 101 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 104 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 105 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 108 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 109 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 112 then
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.075, "linear")
	end
	if curStep == 113 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 0.25, "linear")
	end
	if curStep == 116 then
		DWSing()
		doTweenAlpha('beatFlashAlpha0', 'screendarkenBeginning', 0, 0.025, "linear")
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		playSound('FleetAppear', 1)
		playSound('FleetLaugh', 2)
		doTweenZoom('zoom12', 'camGame', 1.3, 0.01, 'linear')
		doTweenAlpha('healthBarFadeIn', 'healthBar', 1, 0.5, "linear")
		doTweenAlpha('iconP1FadeIn', 'iconP1', 1, 0.5, "linear")
		doTweenAlpha('sonicScoreAlpha', 'sonicScore', 1, 0.5, "linear")
		doTweenAlpha('maxmissesAlpha', 'maxmisses', 1, 0.5, "linear")
	end
	if curStep == 132 then
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		doTweenZoom('zoom22', 'camGame', 0.7, 0.1, 'linear')
		
		doTweenAlpha('warning1alpha', 'warning1', 0, 1, 'linear')
		doTweenAlpha('warning2alpha', 'warning2', 0, 1, 'linear')
	end
	if curStep == 164 then --xain fades in, sonic fades out.
		XainBesideSonic()
	end
	if curStep == 196 then --sonic fades in, xain fades out.
		XainSinging()
	end
	if curStep == 204 then --xain fades in but to left side.
		SonicBesideXain()
	end
	if curStep == 248 then --step it up
		playSound('FleetStepitup', 2)
	end
	if curStep == 260 then --sonic fades in, xain fades out.
		SonicSinging()
	end
	if curStep == 292 then --xain fades in, sonic fades out.
		XainSinging()
	end
	if curStep == 308 then	--sonic fades in, xain fades out.
		SonicBesideXain()
    end
	if curStep == 324 then --sonic fades in, xain fades out.
		SonicSinging()
	end
	if curStep == 356 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 364 then --xain fades in, sonic fades out.
		XainSinging()
	end
	if curStep == 396 then --sonic fades in, xain fades out.
		SonicSinging()
	end
	if curStep == 428 then --xain fades in, sonic fades out.
		XainSinging()
	end
	if curStep == 452 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 484 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 532 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 596 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 648 then --fleetway laugh
		playSound('FleetLaugh2', 2)
	end
	if curStep == 660 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 692 then --xain fades in, sonic fades out.
		XainSinging()
	end
	if curStep == 724 then --sonic fades in, xain fades out.
		SonicSinging()
	end
	if curStep == 788 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 852 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 860 then --sonic fades in, xain fades out.
		SonicSinging()
	end
	if curStep == 884 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 916 then --xain fades in, sonic fades out.
		XainSinging()
	end
	if curStep == 924 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 971 then --fleetway growl
		playSound('FleetGrowl', 2)
	end
	if curStep == 980 then --sonic fades in, xain fades out.
		SonicSinging()
	end
	if curStep == 1044 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 1108 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 1172 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 1236 then --sonic is still here?
		SonicSingingStillHere()
		
		setProperty('defaultCamZoom', 0.8)
		doTweenAlpha('sonicIconfade', 'sonicIcon', 1, 2, "linear")
    end
	if curStep == 1252 then --slight camera zoom
		setProperty('defaultCamZoom', 0.85)
	end
	if curStep == 1268 then --slight camera zoom
		setProperty('defaultCamZoom', 0.9)
	end
	if curStep == 1284 then --slight camera zoom
		setProperty('defaultCamZoom', 0.95)
	end
	if curStep == 1300 then --slight camera zoom
		setProperty('defaultCamZoom', 1)
	end
	if curStep == 1316 then --slight camera zoom
		setProperty('defaultCamZoom', 1.1)
	end
	if curStep == 1332 then --slight camera zoom
		setProperty('defaultCamZoom', 1.2)
	end
	if curStep == 1348 then --slight camera zoom
		setProperty('defaultCamZoom', 1.3)
	end
	if curStep == 1358 then --fleetway growl
		playSound('FleetGrowl2', 2)
	end
	if curStep == 1360 then --bye sonic lol
		SonicFadeBackToFleet()
		setProperty('defaultCamZoom', 0.7)
		
		triggerEvent('Screen Shake', 2,0.1, 2,0.1)
    end
	if curStep == 1364 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 1396 then --sonic fades in, xain fades out.
		SonicSinging()
		playSound('FleetShutUp', 2)
	end
	if curStep == 1428 then --xain fades in, sonic to left side.
		SonicBesideXain()
    end
	if curStep == 1460 then --sonic fades in, xain fades out.
		XainBesideSonic()
	end
	if curStep == 1492 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 1, true)
		doTweenAlpha('byebyexain2', 'iconP2', 0, 8, "linear")
		doTweenAlpha('byebyexain', 'dad', 0, 8, "linear")
		setProperty('defaultCamZoom', 1)
	end
	if curStep == 1508 then
		setProperty('defaultCamZoom', 0.8)
	end
	if curStep == 1556 then --end of song
		cameraFlash('game', '0xFFFFFF', 1, true)
		setProperty('iconP2.visible', false)
		setProperty('defaultCamZoom', 0.6)
		playSound('FleetScream', 2)
		triggerEvent('Screen Shake', 2.5,0.1, 2.5,0.1)
	end
	if curStep == 1575 then
		doTweenAlpha('beatFlashAlpha', 'screendarkenBeginning', 1, 5, "linear")
		doTweenAlpha('camhudbyebye', 'camHUD', 0, 5, "linear")
		doTweenAlpha('healthBarFadeIn', 'healthBar', 0, 2.5, "linear")
		doTweenAlpha('iconP1FadeIn', 'iconP1', 0, 2.5, "linear")
		doTweenAlpha('sonicScoreAlpha', 'sonicScore', 0, 2.5, "linear")
		doTweenAlpha('maxmissesAlpha', 'maxmisses', 0, 2.5, "linear")
	end
end