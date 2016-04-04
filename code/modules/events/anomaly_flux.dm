/datum/round_event_control/anomaly/anomaly_flux
	name = "Anomaly: Hyper-Energetic Flux"
	typepath = /datum/round_event/anomaly/anomaly_flux

	min_players = 15
	max_occurrences = 3
	weight = 20

/datum/round_event/anomaly/anomaly_flux
	startWhen = 3
	announceWhen = 20
	endWhen = 150


/datum/round_event/anomaly/anomaly_flux/announce()
	priority_announce("������� �������� ������� �������� ���������� ����� �����-��������������� ������. ����� ���������� �����������: [impact_area.name].", "�������! ��������!")


/datum/round_event/anomaly/anomaly_flux/start()
	var/turf/T = safepick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/flux(T)


/datum/round_event/anomaly/anomaly_flux/end()
	if(newAnomaly.loc)//If it hasn't been neutralized, it's time to blow up.
		explosion(newAnomaly, 1, 4, 16, 18) //Low devastation, but hits a lot of stuff.
		qdel(newAnomaly)