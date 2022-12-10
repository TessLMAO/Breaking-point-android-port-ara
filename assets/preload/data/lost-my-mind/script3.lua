function onCreate()
	makeLuaSprite('readthefiletitlelol', 'makeGraphicsucks', 0, 0);
	scaleObject('readthefiletitlelol', 6.0, 6.0);
	setObjectCamera('readthefiletitlelol', 'other');
	addLuaSprite('readthefiletitlelol', true);
	
	makeLuaSprite('introcircle', 'StartScreens/Circle-LostMyMind', -400, 0);
	setObjectCamera('introcircle', 'other');
	scaleObject('introcircle', 2, 2)
	addLuaSprite('introcircle', true);
end

function onStartCountdown()
	doTweenX('circleTween', 'introcircle', 30, 2, 'quintOut')
	doTweenX('textTween', 'introtext', 100, 2, 'quintOut')
end

function onStepHit()
	if curStep > 4 and curStep < 6 then
		doTweenAlpha('graphicAlpha', 'readthefiletitlelol', 0, 3, 'linear');
		doTweenAlpha('circleAlpha', 'introcircle', 0, 3, 'linear');
		doTweenAlpha('textAlpha', 'introtext', 0, 3, 'linear');
	end
end