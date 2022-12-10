function onEvent(name,value1,value2)
	if name == 'Middle Scroll' then 
		if curBeat < 495 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				-- middle scroll on
				noteTweenX("Mdx5", 0, 410, 16, "quartInOut");
				noteTweenAngle("Mdr5", 0, 360, 16, "quartInOut");
				noteTweenX("Mdx6", 1, 522, 16, "quartInOut");
				noteTweenAngle("Mdr6", 1, 360, 16, "quartInOut");
				noteTweenX("Mdx7", 2, 633, 16, "quartInOut");
				noteTweenAngle("Mdr7", 2, -360, 16, "quartInOut");
				noteTweenX("Mdx8", 3, 745, 16, "quartInOut");
				noteTweenAngle("Mdr8", 3, -360, 16, "quartInOut");
			end
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
                    -- your? note 1
				noteTweenX("x5", 0, 410, 16, "quartInOut");
				noteTweenAngle("r5", 0, 360, 16, "quartInOut");
                    -- your? note 2
				noteTweenX("x6", 1, 522, 16, "quartInOut");
				noteTweenAngle("r6", 1, 360, 16, "quartInOut");
                    -- your? note 3
				noteTweenX("x7", 2, 633, 16, "quartInOut");
				noteTweenAngle("r7", 2, 360, 16, "quartInOut");
                    -- your? note 4
				noteTweenX("x8", 3, 745, 16, "quartInOut");
				noteTweenAngle("r8", 3, 360, 16, "quartInOut");
                    -- !your note 1
				noteTweenX("Mx5", 4, 410, 16, "quartInOut");
				noteTweenAngle("Mr5", 4, 360, 16, "quartInOut");
                    -- !your note 2
				noteTweenX("Mx6", 5, 522, 16, "quartInOut");
				noteTweenAngle("Mr6", 5, 360, 16, "quartInOut");
                    -- !your note 3
				noteTweenX("Mx7", 6, 633, 16, "quartInOut");
				noteTweenAngle("Mr7", 6, 360, 16, "quartInOut");
                    -- !your note 4
				noteTweenX("Mx8", 7, 745, 16, "quartInOut");
				noteTweenAngle("Mr8", 7, 360, 16, "quartInOut");
			end
		end
		if curBeat > 495 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				-- middle scroll on
				noteTweenX("Mdx5", 0, -410, 4, "quartInOut");
				noteTweenAngle("Mdr5", 0, 360, 4, "quartInOut");
				noteTweenX("Mdx6", 1, -522, 4, "quartInOut");
				noteTweenAngle("Mdr6", 1, 360, 4, "quartInOut");
				noteTweenX("Mdx7", 2, 1266, 4, "quartInOut");
				noteTweenAngle("Mdr7", 2, -360, 4, "quartInOut");
				noteTweenX("Mdx8", 3, 1493, 4, "quartInOut");
				noteTweenAngle("Mdr8", 3, -360, 4, "quartInOut");
			end
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
                    -- your? note 1
				noteTweenX("x5", 0, -410, 4, "quartInOut");
				noteTweenAngle("r5", 0, 360, 4, "quartInOut");
                    -- your? note 2
				noteTweenX("x6", 1, -522, 4, "quartInOut");
				noteTweenAngle("r6", 1, 360, 4, "quartInOut");
                    -- your? note 3
				noteTweenX("x7", 2, -633, 4, "quartInOut");
				noteTweenAngle("r7", 2, 360, 4, "quartInOut");
                    -- your? note 4
				noteTweenX("x8", 3, -745, 4, "quartInOut");
				noteTweenAngle("r8", 3, 360, 4, "quartInOut");
                    -- !your note 1
				noteTweenX("Mx5", 4, 820, 4, "quartInOut");
				noteTweenAngle("Mr5", 4, 360, 4, "quartInOut");
                    -- !your note 2
				noteTweenX("Mx6", 5, 1044, 4, "quartInOut");
				noteTweenAngle("Mr6", 5, 360, 4, "quartInOut");
                    -- !your note 3
				noteTweenX("Mx7", 6, 1266, 4, "quartInOut");
				noteTweenAngle("Mr7", 6, 360, 4, "quartInOut");
                    -- !your note 4
				noteTweenX("Mx8", 7, 1493, 4, "quartInOut");
				noteTweenAngle("Mr8", 7, 360, 4, "quartInOut");
			end
        end
    end
end
