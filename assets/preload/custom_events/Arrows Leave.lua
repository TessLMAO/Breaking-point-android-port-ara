function onEvent(name,value1,value2)
	if name == 'Arrows Leave' then 
		if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
			-- middle scroll on
			noteTweenX("Mdx5", 0, -410, 7, "quartInOut");
			noteTweenAngle("Mdr5", 0, 360, 7, "quartInOut");
			noteTweenX("Mdx6", 1, -522, 7, "quartInOut");
			noteTweenAngle("Mdr6", 1, 360, 7, "quartInOut");
			noteTweenX("Mdx7", 2, 1666, 7, "quartInOut");
			noteTweenAngle("Mdr7", 2, -360, 7, "quartInOut");
			noteTweenX("Mdx8", 3, 1793, 7, "quartInOut");
			noteTweenAngle("Mdr8", 3, -360, 7, "quartInOut");
		end
		if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
			-- your? note 1
			noteTweenX("x5", 0, -410, 7, "quartInOut");
			noteTweenAngle("r5", 0, 720, 7, "quartInOut");
			-- your? note 2
			noteTweenX("x6", 1, -522, 7, "quartInOut");
			noteTweenAngle("r6", 1, 720, 7, "quartInOut");
			-- your? note 3
			noteTweenX("x7", 2, -633, 7, "quartInOut");
			noteTweenAngle("r7", 2, 720, 7, "quartInOut");
			-- your? note 4
			noteTweenX("x8", 3, -745, 7, "quartInOut");
			noteTweenAngle("r8", 3, 720, 7, "quartInOut");
			-- !your note 1
			noteTweenX("Mx5", 4, 1420, 7, "quartInOut");
			noteTweenAngle("Mr5", 4, -360, 7, "quartInOut");
			-- !your note 2
			noteTweenX("Mx6", 5, 1544, 7, "quartInOut");
			noteTweenAngle("Mr6", 5, -360, 7, "quartInOut");
			-- !your note 3
			noteTweenX("Mx7", 6, 1666, 7, "quartInOut");
			noteTweenAngle("Mr7", 6, -360, 7, "quartInOut");
			-- !your note 4
			noteTweenX("Mx8", 7, 1793, 7, "quartInOut");
			noteTweenAngle("Mr8", 7, -360, 7, "quartInOut");
        end
    end
end
