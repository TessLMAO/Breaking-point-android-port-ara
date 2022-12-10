local defaultNotePos = {};
local shake = 10;
 
function goodNoteHit(id, noteData, noteType, isSustainNote)
    for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
 
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
 
        table.insert(defaultNotePos, {x,y})
    end
end

function onCreatePost()
	window_x = getPropertyFromClass('openfl.Lib','application.window.x')
	window_y = getPropertyFromClass('openfl.Lib','application.window.y')
	--debugPrint(window_x)	--prints window x coords
	--debugPrint(window_y)	--prints window y coords
end

function onUpdate(elapsed)
 
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 160)
	
	if curStep >= 496 and curStep < 511 then --get out of my head lol
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + getRandomInt(-5, 5) + math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + getRandomInt(-5, 5) + math.sin((currentBeat + i*0.25) * math.pi))
        end                                                        
	end
    if curStep >= 512 and curStep < 671 then --get out of my head lol
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + getRandomInt(-shake, shake) + math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + getRandomInt(-shake, shake) + math.sin((currentBeat + i*0.25) * math.pi))
        end       
		setPropertyFromClass('openfl.Lib','application.window.x', window_x + math.random(1,11))
		setPropertyFromClass('openfl.Lib','application.window.y', window_y + math.random(1,11))
	end
    if curStep >= 671 and curStep < 1215 then --sonic calms down
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + getRandomInt(-0, 0) + math.sin((currentBeat + i*1.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + getRandomInt(-0, 0) + math.sin((currentBeat + i*1.25) * math.pi))
        end
		setPropertyFromClass('openfl.Lib','application.window.x', window_x)
		setPropertyFromClass('openfl.Lib','application.window.y', window_y)
    end
	if curStep == 1215 then --arrows don't shake
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1])
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2])
        end
    end
end