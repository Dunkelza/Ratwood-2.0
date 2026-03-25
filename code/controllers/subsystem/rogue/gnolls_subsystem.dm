SUBSYSTEM_DEF(gnoll_scaling)
	name = "Gnoll Scaling Controller"
	flags = SS_NO_FIRE

	var/gnoll_scaling_mode = 0
	var/gnoll_playercount_lock = TRUE
	var/desired_gnoll_slots = 1
	var/gnoll_scaling_check_queued = FALSE
	var/last_logged_target_slots = 1

/datum/controller/subsystem/gnoll_scaling/proc/get_mode_name(mode)
	switch(mode)
		if(GNOLL_SCALING_SINGLE)
			return "SINGLE"
		if(GNOLL_SCALING_FLAT)
			return "FLAT"
		if(GNOLL_SCALING_DYNAMIC)
			return "DYNAMIC"
	return "UNKNOWN([mode])"

/datum/controller/subsystem/gnoll_scaling/proc/queue_scaling_recheck()
	if(gnoll_scaling_check_queued)
		return
	gnoll_scaling_check_queued = TRUE
	addtimer(CALLBACK(src, .proc/unlock_gnoll_scaling), 6000)

/datum/controller/subsystem/gnoll_scaling/proc/unlock_gnoll_scaling()
	gnoll_scaling_check_queued = FALSE
	var/players_amt = get_active_player_count(alive_check = 1, afk_check = 1, human_check = 1)

	var/mode = get_gnoll_scaling()
	var/target_slots = 1
	var/previous_target_slots = desired_gnoll_slots

	switch(mode)
		if(GNOLL_SCALING_SINGLE)
			target_slots = 1
		if(GNOLL_SCALING_FLAT)
			target_slots = (players_amt >= 50) ? 3 : 1
		if(GNOLL_SCALING_DYNAMIC)
			target_slots = 2
			if(players_amt > 80)
				target_slots += (players_amt - 80)

	desired_gnoll_slots = target_slots
	gnoll_playercount_lock = (target_slots <= 1)
	if(target_slots != previous_target_slots && target_slots != last_logged_target_slots)
		last_logged_target_slots = target_slots
		var/log_msg = "GNOLL SCALING: target changed to [target_slots] (mode=[get_mode_name(mode)], active_humans=[players_amt])."
		log_game(log_msg)
		message_admins(log_msg)

	var/datum/job/gnoll_job = SSjob.GetJob("Gnoll")
	if(!gnoll_job)
		queue_scaling_recheck()
		return

	var/old_total = gnoll_job.total_positions
	var/old_spawn = gnoll_job.spawn_positions
	var/new_total = clamp(max(gnoll_job.total_positions, target_slots), 1, 6)
	var/new_spawn = clamp(max(gnoll_job.spawn_positions, target_slots), 1, 6)
	gnoll_job.total_positions = new_total
	gnoll_job.spawn_positions = new_spawn

	if(new_total > old_total || new_spawn > old_spawn)
		var/slot_log_msg = "GNOLL SCALING: slots increased from [old_total]/[old_spawn] to [new_total]/[new_spawn] (mode=[get_mode_name(mode)], active_humans=[players_amt])."
		log_game(slot_log_msg)
		message_admins(slot_log_msg)
		for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
			if(player.client)
				to_chat(player, span_alert("Graggar demands blood, gnolls flock to the Vale!"))

	if((mode == GNOLL_SCALING_FLAT && players_amt < 50) || (mode == GNOLL_SCALING_DYNAMIC && players_amt < 84))
		queue_scaling_recheck()

/datum/controller/subsystem/gnoll_scaling/proc/get_gnoll_scaling()
	if(gnoll_scaling_mode != 0)
		return gnoll_scaling_mode

	var/preferred_mode = GNOLL_SCALING_SINGLE
	if(SSgamemode?.current_storyteller)
		preferred_mode = SSgamemode.current_storyteller.preferred_gnoll_mode
	else if(SSgamemode?.selected_storyteller)
		var/datum/storyteller/selected_storyteller = SSgamemode.storytellers[SSgamemode.selected_storyteller]
		if(selected_storyteller)
			preferred_mode = selected_storyteller.preferred_gnoll_mode

	if(preferred_mode == GNOLL_SCALING_RANDOM)
		preferred_mode = pick(GNOLL_SCALING_SINGLE, GNOLL_SCALING_FLAT, GNOLL_SCALING_DYNAMIC)

	if(!(preferred_mode in list(GNOLL_SCALING_SINGLE, GNOLL_SCALING_FLAT, GNOLL_SCALING_DYNAMIC)))
		preferred_mode = GNOLL_SCALING_SINGLE

	gnoll_scaling_mode = preferred_mode
	return gnoll_scaling_mode
