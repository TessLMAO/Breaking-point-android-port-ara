local allowCountdown = false
local startedEndDialogue = false
local keepScroll = false

function onCreate()
	makeLuaSprite('xain_veins', 'xain_veins', 0, 0)
	setObjectCamera('xain_veins', 'camHUD')
	scaleObject('xain_veins', 2, 2)	
	
	makeLuaSprite('screendarken', 'cover', 0, 0)
	setProperty('screendarken.alpha', 0)
	scaleObject('screendarken', 120, 120)
	setObjectCamera('screendarken', 'other')
	
    addCharacterToList('sonic-xain', 'dad')
    addCharacterToList('sonic-getout', 'boyfriend')
    addCharacterToList('sonic-weak', 'boyfriend')
    precacheImage('overlay')
	precacheImage('coverarrow')
	precacheImage('xain_veins')
	setProperty('cameraSpeed', 0.5)
    setProperty('gf.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))
    setProperty('health', 0.01)
	setProperty('scoreTxt.visible', false)
    
    local var font = "vcr.ttf" -- the font that the text will use.
	
	setProperty('camHUD.alpha', 0);
	setProperty('camGame.alpha', 0);
	
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
	triggerEvent('Change Character', 'bf', 'sonic-getout')
	triggerEvent('Change Character', 'bf', 'sonic-tired')
	triggerEvent('Change Character', 'bf', 'sonic-weak')
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
	if dadName == 'sonic-xain' then
		if curStep >= 512 and curStep <= 670 then
			cameraShake('camHUD', 0.025, 0.025)
			cameraShake('camGame', 0.025, 0.025)
			if getProperty('health') > 0.036 then
				setProperty('health', health- 0.0359)
			end
		end
		
		if curStep <= 512 or curStep >= 670 then
			if getProperty('health') > 0.024 then
				setProperty('health', health- 0.0241)
			end
		end
	end
end

function XainSing()
	makeAnimatedLuaSprite('fx', 'bg/vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 12, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHUD')
	objectPlayAnimation('fx', 'idle', true)

	makeLuaSprite('xain', 'bg/xain', -250, -50)
	addLuaSprite('xain', false)
	removeLuaSprite('sonic')
	removeLuaSprite('getout')
	
	setProperty('fx.alpha', 0.8)
	doTweenAlpha('XainSinging', 'fx', 0.25, 1, 'linear')
	addLuaSprite('fx', true)
end

function SonicSing()
	makeLuaSprite('sonic', 'bg/sonic', -250, -50)
	addLuaSprite('sonic', false)
	removeLuaSprite('xain')
	removeLuaSprite('getout')
	
	setProperty('fx.alpha', 0.8)
	doTweenAlpha('XainNotSinging', 'fx', 0, 1, 'linear')
end

function GETOUTOFMYHEAD()
	cameraFlash('game', '0x000000', 0.5, true)
	removeLuaSprite('xain')
	makeAnimatedLuaSprite('fx', 'bg/vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 12, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHUD')
	objectPlayAnimation('fx', 'idle', true)
	removeLuaSprite('sonic')
	
	setProperty('fx.alpha', 0)
	addLuaSprite('fx', true)
end

function GETOUTXAIN()
	makeAnimatedLuaSprite('fx', 'bg/vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 16, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHUD')
	objectPlayAnimation('fx', 'idle', true)

	makeLuaSprite('getout', 'bg/getoutofmyhead', -250, -50)
	addLuaSprite('getout', false)
	removeLuaSprite('sonic')
	removeLuaSprite('xain')
	
	setProperty('fx.alpha', 0.8)
	doTweenAlpha('XainSinging', 'fx', 0.3, 1, 'linear')
	addLuaSprite('fx', true)
end

function GETOUTSONIC()
	makeLuaSprite('getout', 'bg/getoutofmyhead', -250, -50)
	addLuaSprite('getout', false)
	removeLuaSprite('sonic')
	removeLuaSprite('xain')
	
	setProperty('fx.alpha', 0.8)
	doTweenAlpha('XainNotSinging', 'fx', 0.3, 1, 'linear')
	addLuaSprite('fx', true)
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
		setPropertyFromClass("openfl.Lib","application.window.title", "I HAVE FULL CONTROL OVER YOU")
    end
	
	if boyfriendName == 'sonic-getout' then
		triggerEvent('Screen Shake','0.5,0.005','0.5,0.005')
	end
	
	if boyfriendName == 'sonic-getout' or boyfriendName == 'sonic-weak' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'sonic-getout')
	elseif boyfriendName == 'sonic-tired' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'sonic-tired')
	end
	
	setTextString('sonicScore', 'Score: ' .. fakeScoring .. ' - ' .. fakeRating)
	
	if curStep >= 0 and curStep <= 2050 then --change window name back at end of song
		if getProperty('songMisses') == 0 then
			setTextString('maxmisses', 'Max Misses: 5')
			setPropertyFromClass("openfl.Lib","application.window.title", "Lost my mind...")
		elseif getProperty('songMisses') == 1 then
			setTextString('maxmisses', 'Max Misses: 4')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween', 'screendarken', 0.2, 1.5, 'linear')
			setPropertyFromClass("openfl.Lib","application.window.title", "I can't let him take over...")
			doTweenAlpha('XainVeinsReturn1', 'xain_veins', 0.25, 1.5, 'linear')
		elseif getProperty('songMisses') == 2 then
			setTextString('maxmisses', 'Max Misses: 3')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween2', 'screendarken', 0.35, 1.5, 'linear')
			setPropertyFromClass("openfl.Lib","application.window.title", "I don't want to lose my sanity...")
			doTweenAlpha('XainVeinsReturn2', 'xain_veins', 0.5, 1.5, 'linear')
		elseif getProperty('songMisses') == 3 then
			setTextString('maxmisses', 'Max Misses: 2')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween3', 'screendarken', 0.5, 1.5, 'linear')
			setPropertyFromClass("openfl.Lib","application.window.title", "Please don't let him win...")
			doTweenAlpha('XainVeinsReturn3', 'xain_veins', 0.75, 1.5, 'linear')
		elseif getProperty('songMisses') == 4 then
			setTextString('maxmisses', 'Max Misses: 1')
			addLuaSprite('screendarken', true)
			doTweenAlpha('screendarkentween4', 'screendarken', 0.65, 1.5, 'linear')
			setPropertyFromClass("openfl.Lib","application.window.title", "...")
			doTweenAlpha('XainVeinsReturn4', 'xain_veins', 1, 1.5, 'linear')
			triggerEvent('Screen Shake','0.125,0.00125','0.125,0.00125')
		elseif getProperty('songMisses') >= 5 then
			setTextString('maxmisses', 'Max Misses: 0')
			setPropertyFromClass("openfl.Lib","application.window.title", "I HAVE FULL CONTROL OVER YOU")
			setTextString('Lost', "YOU LOST")
			setProperty('health', 0)
		end
	elseif curStep >= 2050 then
		setPropertyFromClass("openfl.Lib","application.window.title", "Friday Night Funkin': Psych Engine")
	end

    -- icon fading shit
    if curBeat % 2 == 1 and curStep >= 192 and getProperty('health') <= 1.7 and curStep <= 1984 then 
        doTweenAlpha('areYouFading?Tween1', 'iconP1', 0.6, 0.3, 'linear')
		if curStep >= 192 and curStep <= 1930 then
			doTweenAlpha('areYouFading?Tween2', 'iconP2', 0.6, 0.3, 'linear')
		end
    elseif curBeat % 2 == 0 and curStep >= 192 and getProperty('health') <= 1.7 and curStep <= 1984 then
        doTweenAlpha('areYouNotFading?Tween1', 'iconP1', 0.9, 0.3, 'linear')
		if curStep >= 192 and curStep <= 1930 then
			doTweenAlpha('areYouNotFading?Tween2', 'iconP2', 0.9, 0.3, 'linear')
		end
    elseif curBeat % 2 == 1 and curStep >= 192 and getProperty('health') <= 0.29 and curStep <= 1984 then
        doTweenAlpha('ohShitTween1', 'iconP1', 0.1, 0.1, 'linear')
		if curStep >= 192 and curStep <= 1930 then
			doTweenAlpha('ohShitTween2', 'iconP2', 0.1, 0.1, 'linear')
		end
    elseif curBeat % 2 == 0 and curStep >= 192 and getProperty('health') <= 0.29 and curStep <= 1984 then
        doTweenAlpha('ohShitFuckTween1', 'iconP1', 0.4, 0.1, 'linear')
		if curStep >= 192 and curStep <= 1930 then
			doTweenAlpha('ohShitFuckTween2', 'iconP2', 0.4, 0.1, 'linear')
		end
    elseif curBeat % 2 == 1 and curStep >= 192 and getProperty('health') >= 1.8 and curStep <= 1984 then
        doTweenAlpha('nahWeGooTween1', 'iconP1', 0.8, 0.3, 'linear')
		if curStep >= 192 and curStep <= 1930 then
			doTweenAlpha('nahWeGooTween2', 'iconP2', 0.8, 0.3, 'linear')
		end
    elseif curBeat % 2 == 0 and curStep >= 192 and getProperty('health') >= 1.8 and curStep <= 1984 then
        doTweenAlpha('nahWeGoo2Tween1', 'iconP1', 1, 0.3, 'linear')
		if curStep >= 192 and curStep <= 1930 then
			doTweenAlpha('nahWeGoo2Tween2', 'iconP2', 1, 0.3, 'linear')
		end
	end
	if curStep >= 1984 then
		doTweenAlpha('soniciconwintween', 'iconP1', 1, 0.5, 'linear')
		doTweenAlpha('xainiconlosetween', 'iconP2', 0, 0.5, 'linear')
	end
	--end of icon fading shit
	
	--xain veins lol
	if curStep >= 511 then
		addLuaSprite('xain_veins', true)
	end
	
	if curBeat % 2 == 1 and curStep >= 511 and curStep <= 672 then 
        doTweenAlpha('XainVeinsTween1', 'xain_veins', 0.6, 0.3, 'linear')
    elseif curBeat % 2 == 0 and curStep >= 511 and curStep <= 672 then
        doTweenAlpha('XainVeinsTween2', 'xain_veins', 0.9, 0.3, 'linear')
    elseif curBeat % 2 == 1 and curStep >= 511 and curStep <= 672 then
        doTweenAlpha('XainVeinsTween3', 'xain_veins', 0.1, 0.1, 'linear')
    elseif curBeat % 2 == 0 and curStep >= 511 and curStep <= 672 then
        doTweenAlpha('XainVeinsTween4', 'xain_veins', 0.4, 0.1, 'linear')
    elseif curBeat % 2 == 1 and curStep >= 511 and curStep <= 672 then
        doTweenAlpha('XainVeinsTween5', 'xain_veins', 0.8, 0.3, 'linear')
    elseif curBeat % 2 == 0 and curStep >= 511 and curStep <= 672 then
        doTweenAlpha('XainVeinsTween6', 'xain_veins', 1, 0.3, 'linear')
	end

	--xain veins go away
	if curStep > 672 and curStep < 704 then 
        doTweenAlpha('XainVeinsTweenStop', 'xain_veins', 0, 3, 'linear')
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

-- long function time
function onStepHit()
	if curStep == 1 then
		doTweenAlpha('game', 'camGame', 1, 10, "quartInOut")
		setProperty('dad.alpha', 0)
		setProperty('boyfriend.alpha', 1)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
	end
	if curStep == 50 then
		doTweenAlpha('hud', 'camHUD', 1, 6, "quartInOut")
		
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
	end
	if curStep == 120 then
        doTweenAlpha('warning1alpha', 'warning1', 0, 1, 'linear')
		doTweenAlpha('warning2alpha', 'warning2', 0, 1, 'linear')
    end
	if curStep == 127 then
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		doTweenZoom('zoom1', 'camGame', 1.25, 0.01, 'linear')
	end
	if curStep == 130 then
		doTweenZoom('zoom2', 'camGame', 0.8, 0.1, 'linear')
	end
	if curStep == 192 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 256 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 320 then --xain fades in but to left side.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 344 then --sonic fades in, xain to left side.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.x', 300)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('dad.alpha', 1)
	end
	if curStep == 356 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
	end
	if curStep == 376 then --sonic fades in to left side.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('dad.alpha', 1)
	end
	if curStep == 384 then --sonic fades in, xain fades out.
		setProperty('boyfriend.x', 450)
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 448 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 476 then --note skin change
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'GetOutNotes');
			end
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'HisNotes' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'HisNotes'); --Change texture
			end
		end
	end
	if curStep == 496 then --GET OUT OF MY HEAD
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
        triggerEvent('Change Scroll Speed', '1.15', '0')
		doTweenAlpha('dadTween', 'dad', 0, 0.1, 'linear')
		triggerEvent('Change Character', 'bf', 'sonic-getout')
		doTweenZoom('zoom', 'camGame', 1.5, 0.5, 'linear')
		GETOUTOFMYHEAD()
    end
	if curStep == 508 then --rapid cameraFlash
		cameraFlash('game', '0xFFFFFF', 0.05, true)
	end
	if curStep == 509 then --rapid cameraFlash
		cameraFlash('game', '0xFFFFFF', 0.05, true)
	end
	if curStep == 510 then --rapid cameraFlash
		cameraFlash('game', '0xFFFFFF', 0.05, true)
	end
	if curStep == 511 then
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		makeLuaSprite('Xain_overlay', 'overlay')
		setObjectCamera('Xain_overlay', 'other')
        addLuaSprite('Xain_overlay', true)
		GETOUTSONIC()
	end
	if curStep == 513 then
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'GetOutNotes');
		end
	end
	if curStep == 528 then
		cameraFlash('game', '0x000000', 0.25, true)
        triggerEvent('Change Scroll Speed', '1.25', '0')
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		GETOUTXAIN()
    end
	if curStep == 544 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		GETOUTSONIC()
	end
	if curStep == 560 then --sonic fades out, xain fades in.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		GETOUTXAIN()
	end
	if curStep == 576 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		GETOUTSONIC()
	end
	if curStep == 640 then --sonic fades out, xain fades in. showing sonic calm down.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.x', 300)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('dad.alpha', 1)
		GETOUTXAIN()
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets');
			end
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'HisNotes' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'HisNotes'); --Change texture
			end
		end
	end
    if curStep == 672 then
        triggerEvent('Change Scroll Speed', '1', '0')
		triggerEvent('Change Character', 'bf', 'sonic-tired')
		triggerEvent('Play Animation', 'calmDown', 'bf')
		setProperty('boyfriend.x', 300)
		CoverArrowFlash()
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_assets');
		end
    end
	if curStep == 704 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.25, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 736 then --sonic fades out, xain fades in.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 768 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 800 then --sonic and xain duet start
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
		setProperty('dad.x', 300)
		setProperty('boyfriend.x', 450)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
	end
	if curStep == 832 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
	end
	if curStep == 844 then --sonic and xain duet, xain to left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('dad.x', 300)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
	end
	if curStep == 864 then --sonic fades in, xain fades out.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
	end
	if curStep == 876 then --sonic and xain duet, xain to left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('dad.x', 300)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
	end
	if curStep == 896 then --sonic fades in, xain fades out.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
	end
	if curStep == 908 then --sonic and xain duet, xain to left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('dad.x', 300)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
	end
	if curStep == 928 then --sonic fades in, xain fades out.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
	end
	if curStep == 940 then --sonic and xain duet, xain to left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('dad.x', 300)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
	end
	if curStep == 960 then --sonic and xain duet, sonic to left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.x', 300)
		setProperty('dad.x', 468)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('dad.alpha', 1)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
		XainSing()
	end
	if curStep == 1088 then --sonic and xain duet, xain to left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.x', 450)
		setProperty('dad.x', 300)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
		SonicSing()
	end
	if curStep == 1215 then --flash white part
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		triggerEvent('Change Character', 'bf', 'sonic-weak')
		setProperty('dad.x', 468)
		setProperty('boyfriend.x', 450)
		setProperty('dad.alpha', 0)
		setProperty('boyfriend.alpha', 1)
    end
	if curStep == 1280 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 1344 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1408 then --sonic and xain duet. sonic on left side.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('boyfriend.x', 300)
		setProperty('dad.alpha', 1)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
		XainSing()
	end
	if curStep == 1472 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1536 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 1592 then --sonic and xain duet. sonic on left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('boyfriend.x', 300)
		setProperty('dad.alpha', 1)
	end
	if curStep == 1600 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1664 then --sonic and xain duet. xain on left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.x', 300)
		setProperty('dad.alpha', 0.25)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
	end
	if curStep == 1728 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.x', 468)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 1760 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1766 then --sonic and xain duet. xain on left side.
		cameraFlash('game', '0x000000', 0.25, true)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.x', 300)
		setProperty('dad.alpha', 0.25)
	end
	if curStep == 1792 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.x', 468)
		setProperty('boyfriend.x', 300)
		setProperty('dad.alpha', 1)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
		XainSing()
	end
	if curStep == 1798 then
		setProperty('boyfriend.alpha', 0.25)
		cameraFlash('game', '0x000000', 0.5, true)
	end
	if curStep == 1808 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1828 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 1838 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1862 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.x', 300)
		setProperty('dad.x', 468)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 1872 then --xain fades in, sonic fades out.
		setProperty('boyfriend.alpha', 0)
		cameraFlash('game', '0x000000', 0.5, true)
	end
	if curStep == 1892 then --sonic fades in, xain fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0)
		SonicSing()
	end
	if curStep == 1902 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.x', 300)
		setProperty('dad.x', 468)
		setProperty('boyfriend.alpha', 0)
		setProperty('dad.alpha', 1)
		XainSing()
	end
	if curStep == 1918 then --xain fades in, sonic fades out.
		cameraFlash('game', '0x000000', 0.5, true)
		setProperty('boyfriend.x', 300)
		setProperty('dad.x', 468)
		setProperty('boyfriend.alpha', 0.25)
		setProperty('dad.alpha', 1)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) --opponent layered on top of bf
	end
	if curStep == 1920 then --xain fades in, sonic fades out.
		cameraFlash('game', '0xFFFFFF', 0.5, true)
		setProperty('boyfriend.x', 450)
		setProperty('dad.x', 300)
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 0.25)
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')-1) --opponent layered behind bf
		SonicSing()
	end
	if curStep == 1936 then --xain fades out.
		doTweenAlpha('dadTween', 'dad', 0, 3, 'linear')
		doTweenAlpha('dadTweenP2', 'iconP2', 0, 3, 'linear')
	end
    if curStep == 1984 then
        if getProperty('songMisses') < 5 then
            doTweenAlpha('byebyeMiss', 'maxmisses', 0, 1, 'linear')
			doTweenAlpha('byebyeScore', 'sonicScore', 0, 1, 'linear')
            removeLuaText('warning1', true)
            removeLuaText('warning2', true)
			doTweenAlpha('game', 'camGame', 0, 8, "quartInOut")
			doTweenAlpha('hud', 'camHUD', 0, 4, "quartInOut")
			SonicSing()
		end
    end
end