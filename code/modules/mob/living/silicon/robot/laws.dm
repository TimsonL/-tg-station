/mob/living/silicon/robot/verb/cmd_show_laws()
	set category = "Robot Commands"
	set name = "Show Laws"

	if(usr.stat == DEAD)
		return //won't work if dead
	show_laws()

/mob/living/silicon/robot/show_laws(everyone = 0)
	laws_sanity_check()
	var/who

	if (everyone)
		who = world
	else
		who = src
	if(lawupdate)
		if (connected_ai)
			if(connected_ai.stat || connected_ai.control_disabled)
				src << "<b>AI signal lost, unable to sync laws.</b>"

			else
				lawsync()
				src << "<b>Laws synced with AI, be sure to note any changes.</b>"
				if(is_special_character(src))
					src << "<b>Remember, your AI does NOT share or know about your law 0.</b>"
					if(src.connected_ai.laws.zeroth)
						src << "<b>While you are free to disregard it, your AI has a law 0 of its own.</b>"
		else
			src << "<b>No AI selected to sync laws with, disabling lawsync protocol.</b>"
			lawupdate = 0

	who << "<b>�������� ���� �������:</b>"
	laws.show_laws(who)
	if (is_special_character(src) && connected_ai)
		who << "<b>���������, [connected_ai.name] ���������� &#255;��&#255;���&#255; ����� ��������, �� ���� ������&#255; ������������.</b>"
	else if (connected_ai)
		who << "<b>���������, [connected_ai.name] ��� ������, ������ �� ����� ���� ������������.</b>"
	else if (emagged)
		who << "<b>���������, ��� �� ��&#255;�������� ������&#255;���&#255; ��.</b>"
	else
		who << "<b>���������, �� �� ����&#255;���� �� � ������ ��, ��� �� ��&#255;�������� ������&#255;���&#255; ��.</b>"


/mob/living/silicon/robot/proc/lawsync()
	laws_sanity_check()
	var/datum/ai_laws/master = connected_ai ? connected_ai.laws : null
	var/temp
	if (master)
		laws.ion.len = master.ion.len
		for (var/index = 1, index <= master.ion.len, index++)
			temp = master.ion[index]
			if (length(temp) > 0)
				laws.ion[index] = temp

		if (!is_special_character(src)) //Don't override the borg's existing law 0, if any
			if(master.zeroth_borg) //If the AI has a defined law zero specifically for its borgs, give it that one, otherwise give it the same one. --NEO
				temp = master.zeroth_borg
			else
				temp = master.zeroth
			laws.zeroth = temp

		laws.inherent.len = master.inherent.len
		for (var/index = 1, index <= master.inherent.len, index++)
			temp = master.inherent[index]
			if (length(temp) > 0)
				laws.inherent[index] = temp

		laws.supplied.len = master.supplied.len
		for (var/index = 1, index <= master.supplied.len, index++)
			temp = master.supplied[index]
			if (length(temp) > 0)
				laws.supplied[index] = temp
	return