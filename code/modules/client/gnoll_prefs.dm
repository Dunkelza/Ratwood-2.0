/datum/gnoll_prefs
	var/gnoll_name = ""
	var/gnoll_pronouns = HE_HIM
	var/pelt_type = "firepelt"
	var/list/genitals = list(
		"penis" = FALSE,
		"vagina" = FALSE,
		"breasts" = FALSE
	)
	var/descriptor_height     = /datum/mob_descriptor/height/moderate
	var/descriptor_body       = /datum/mob_descriptor/body/muscular
	var/descriptor_fur        = /datum/mob_descriptor/fur/coarse
	var/descriptor_voice      = /datum/mob_descriptor/voice/growly
	var/descriptor_muzzle     = /datum/mob_descriptor/face/gnoll/long_muzzle
	var/descriptor_expression = /datum/mob_descriptor/face_exp/gnoll/alert

/datum/gnoll_prefs/New()
	. = ..()
	if(!gnoll_name)
		gnoll_name = "[pick(GLOB.wolf_prefixes)] [pick(GLOB.wolf_suffixes)]"

/datum/gnoll_prefs/proc/gnoll_show_ui(mob/user)
	if(!user.client)
		return

	var/list/dat = list()
	dat += "<html><head><title>Gnoll Customization</title></head><body>"
	dat += "<center><h2>Choose your form to spread terror in the name of the GORESTAR!!</h2></center><br>"

	// Name section
	dat += "<b>Current Name:</b> [gnoll_name] "
	dat += "<a href='?_src_=gnoll_prefs;action=set_name'>Set Custom Name</a> | "
	dat += "<a href='?_src_=gnoll_prefs;action=random_name'>Random Gnoll Name</a><br><br>"

	// Pronouns section
	dat += "<b>Pronouns:</b> "
	var/list/pronoun_options = list(HE_HIM, SHE_HER, THEY_THEM, IT_ITS)
	var/list/pronoun_display = list(
		HE_HIM = "He/Him",
		SHE_HER = "She/Her",
		THEY_THEM = "They/Them",
		IT_ITS = "It/Its"
	)
	for(var/pronoun in pronoun_options)
		var/display_pronoun = pronoun_display[pronoun] ? pronoun_display[pronoun] : pronoun
		if(gnoll_pronouns == pronoun)
			dat += "<b>[display_pronoun]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_pronouns;pronouns=[pronoun]'>[display_pronoun]</a> "
	dat += "<br><br>"

	// Pelt type section
	dat += "<b>Pelt Pattern:</b> "
	var/list/pelt_options = list(
		"Firepelt" = "firepelt",
		"Rotpelt" = "rotpelt",
		"Whitepelt" = "whitepelt",
		"Bloodpelt" = "bloodpelt",
		"Nightpelt" = "nightpelt",
		"Darkpelt" = "darkpelt"
	)
	for(var/pelt_label in pelt_options)
		var/pelt_id = pelt_options[pelt_label]
		if(pelt_type == pelt_id)
			dat += "<b>[pelt_label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_pelt;pelt=[pelt_id]'>[pelt_label]</a> "
	dat += "<br><br>"

	// Genitals section
	dat += "<b>Genitals:</b><br>"
	var/list/genital_options = list(
		"Penis" = "penis",
		"Vagina" = "vagina",
		"Breasts" = "breasts"
	)
	for(var/genital_label in genital_options)
		var/genital_id = genital_options[genital_label]
		var/status = genitals[genital_id] ? "Yes" : "No"
		var/toggle_action = genitals[genital_id] ? "disable" : "enable"
		dat += "&nbsp;&nbsp;[genital_label]: [status] "
		dat += "<a href='?_src_=gnoll_prefs;action=toggle_genital;genital=[genital_id];toggle=[toggle_action]'>[toggle_action == "enable" ? "Enable" : "Disable"]</a><br>"
	dat += "<br>"

	// Height section
	dat += "<b>Height:</b> "
	var/list/height_options = list(
		/datum/mob_descriptor/height/moderate = "Moderate",
		/datum/mob_descriptor/height/middling = "Middling",
		/datum/mob_descriptor/height/short = "Short",
		/datum/mob_descriptor/height/tall = "Tall",
		/datum/mob_descriptor/height/towering = "Towering",
		/datum/mob_descriptor/height/giant = "Giant",
		/datum/mob_descriptor/height/tiny = "Tiny"
	)
	for(var/tp in height_options)
		var/label = height_options[tp]
		if(descriptor_height == tp)
			dat += "<b>[label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_descriptor;slot=height;type=[tp]'>[label]</a> "
	dat += "<br><br>"

	// Body section
	dat += "<b>Build:</b> "
	var/list/body_options = list(
		/datum/mob_descriptor/body/average = "Average",
		/datum/mob_descriptor/body/athletic = "Athletic",
		/datum/mob_descriptor/body/muscular = "Muscular",
		/datum/mob_descriptor/body/herculean = "Herculean",
		/datum/mob_descriptor/body/toned = "Toned",
		/datum/mob_descriptor/body/heavy = "Heavy",
		/datum/mob_descriptor/body/lean = "Lean",
		/datum/mob_descriptor/body/burly = "Burly",
		/datum/mob_descriptor/body/gaunt = "Gaunt",
		/datum/mob_descriptor/body/lanky = "Lanky"
	)
	for(var/tp in body_options)
		var/label = body_options[tp]
		if(descriptor_body == tp)
			dat += "<b>[label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_descriptor;slot=body;type=[tp]'>[label]</a> "
	dat += "<br><br>"

	// Fur section
	dat += "<b>Coat:</b> "
	var/list/fur_options = list(
		/datum/mob_descriptor/fur/plain = "Plain",
		/datum/mob_descriptor/fur/short = "Short",
		/datum/mob_descriptor/fur/coarse = "Coarse",
		/datum/mob_descriptor/fur/bristly = "Bristly",
		/datum/mob_descriptor/fur/fluffy = "Fluffy",
		/datum/mob_descriptor/fur/shaggy = "Shaggy",
		/datum/mob_descriptor/fur/silky = "Silky",
		/datum/mob_descriptor/fur/lank = "Lank",
		/datum/mob_descriptor/fur/mangy = "Mangy",
		/datum/mob_descriptor/fur/velvety = "Velvety",
		/datum/mob_descriptor/fur/dense = "Dense",
		/datum/mob_descriptor/fur/matted = "Matted"
	)
	for(var/tp in fur_options)
		var/label = fur_options[tp]
		if(descriptor_fur == tp)
			dat += "<b>[label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_descriptor;slot=fur;type=[tp]'>[label]</a> "
	dat += "<br><br>"

	// Voice section
	dat += "<b>Voice:</b> "
	var/list/voice_options = list(
		/datum/mob_descriptor/voice/growly = "Growly",
		/datum/mob_descriptor/voice/deep = "Deep",
		/datum/mob_descriptor/voice/booming = "Booming",
		/datum/mob_descriptor/voice/gravelly = "Gravelly",
		/datum/mob_descriptor/voice/commanding = "Commanding",
		/datum/mob_descriptor/voice/monotone = "Monotone",
		/datum/mob_descriptor/voice/ordinary = "Ordinary",
		/datum/mob_descriptor/voice/soft = "Soft",
		/datum/mob_descriptor/voice/grave = "Grave",
		/datum/mob_descriptor/voice/venomous = "Venomous",
		/datum/mob_descriptor/voice/dispassionate = "Dispassionate",
		/datum/mob_descriptor/voice/whiny = "Whiny",
		/datum/mob_descriptor/voice/drawling = "Drawling",
		/datum/mob_descriptor/voice/shrill = "Shrill",
		/datum/mob_descriptor/voice/stilted = "Stilted"
	)
	for(var/tp in voice_options)
		var/label = voice_options[tp]
		if(descriptor_voice == tp)
			dat += "<b>[label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_descriptor;slot=voice;type=[tp]'>[label]</a> "
	dat += "<br><br>"

	// Muzzle shape section
	dat += "<b>Muzzle Shape:</b> "
	var/list/muzzle_options = list(
		/datum/mob_descriptor/face/gnoll/long_muzzle = "Long",
		/datum/mob_descriptor/face/gnoll/short_muzzle = "Short",
		/datum/mob_descriptor/face/gnoll/broad_muzzle = "Broad",
		/datum/mob_descriptor/face/gnoll/narrow_muzzle = "Narrow",
		/datum/mob_descriptor/face/gnoll/scarred_muzzle = "Scarred",
		/datum/mob_descriptor/face/gnoll/sharp_muzzle = "Sharp",
		/datum/mob_descriptor/face/gnoll/worn_muzzle = "Worn",
		/datum/mob_descriptor/face/gnoll/disfigured_muzzle = "Disfigured"
	)
	for(var/tp in muzzle_options)
		var/label = muzzle_options[tp]
		if(descriptor_muzzle == tp)
			dat += "<b>[label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_descriptor;slot=muzzle;type=[tp]'>[label]</a> "
	dat += "<br><br>"

	// Expression section
	dat += "<b>Expression:</b> "
	var/list/expression_options = list(
		/datum/mob_descriptor/face_exp/gnoll/alert = "Alert",
		/datum/mob_descriptor/face_exp/gnoll/snarling = "Snarling",
		/datum/mob_descriptor/face_exp/gnoll/predatory = "Predatory",
		/datum/mob_descriptor/face_exp/gnoll/hollow = "Hollow",
		/datum/mob_descriptor/face_exp/gnoll/fierce = "Fierce",
		/datum/mob_descriptor/face_exp/gnoll/vacant = "Vacant",
		/datum/mob_descriptor/face_exp/gnoll/groveling = "Groveling",
		/datum/mob_descriptor/face_exp/gnoll/leering = "Leering"
	)
	for(var/tp in expression_options)
		var/label = expression_options[tp]
		if(descriptor_expression == tp)
			dat += "<b>[label]</b> "
		else
			dat += "<a href='?_src_=gnoll_prefs;action=set_descriptor;slot=expression;type=[tp]'>[label]</a> "
	dat += "<br><br>"

	dat += "<center><a href='?_src_=gnoll_prefs;action=close'>Close</a></center>"
	dat += "</body></html>"

	var/datum/browser/popup = new(user, "gnoll_prefs", "Gnoll Customization", 500, 600)
	popup.set_content(dat.Join())
	popup.open()

/datum/gnoll_prefs/proc/gnoll_process_link(mob/user, list/href_list)
	if(!user || !user.client)
		return

	var/action = href_list["action"]
	switch(action)
		if("set_name")
			var/new_name = input(user, "Enter a custom name for your gnoll:", "Gnoll Name", gnoll_name) as text|null
			if(new_name)
				gnoll_name = sanitize_name(new_name)
				gnoll_show_ui(user)

		if("random_name")
			gnoll_name = "[pick(GLOB.wolf_prefixes)] [pick(GLOB.wolf_suffixes)]"
			gnoll_show_ui(user)

		if("set_pronouns")
			var/new_pronouns = href_list["pronouns"]
			if(new_pronouns in list(HE_HIM, SHE_HER, THEY_THEM, IT_ITS))
				gnoll_pronouns = new_pronouns
				gnoll_show_ui(user)

		if("set_pelt")
			var/new_pelt = href_list["pelt"]
			var/list/valid_pelts = list("firepelt", "rotpelt", "whitepelt", "bloodpelt", "nightpelt", "darkpelt")
			if(new_pelt in valid_pelts)
				pelt_type = new_pelt
				gnoll_show_ui(user)

		if("toggle_genital")
			var/genital = href_list["genital"]
			var/toggle = href_list["toggle"]
			if(genital in genitals)
				genitals[genital] = (toggle == "enable")
				gnoll_show_ui(user)

		if("set_descriptor")
			var/slot = href_list["slot"]
			var/new_type = text2path(href_list["type"])
			if(!new_type)
				return
			switch(slot)
				if("height")
					var/list/valid_height = list(
						/datum/mob_descriptor/height/moderate,
						/datum/mob_descriptor/height/middling,
						/datum/mob_descriptor/height/short,
						/datum/mob_descriptor/height/tall,
						/datum/mob_descriptor/height/towering,
						/datum/mob_descriptor/height/giant,
						/datum/mob_descriptor/height/tiny
					)
					if(new_type in valid_height)
						descriptor_height = new_type
				if("body")
					var/list/valid_body = list(
						/datum/mob_descriptor/body/average,
						/datum/mob_descriptor/body/athletic,
						/datum/mob_descriptor/body/muscular,
						/datum/mob_descriptor/body/herculean,
						/datum/mob_descriptor/body/toned,
						/datum/mob_descriptor/body/heavy,
						/datum/mob_descriptor/body/lean,
						/datum/mob_descriptor/body/burly,
						/datum/mob_descriptor/body/gaunt,
						/datum/mob_descriptor/body/lanky
					)
					if(new_type in valid_body)
						descriptor_body = new_type
				if("fur")
					var/list/valid_fur = list(
						/datum/mob_descriptor/fur/plain,
						/datum/mob_descriptor/fur/short,
						/datum/mob_descriptor/fur/coarse,
						/datum/mob_descriptor/fur/bristly,
						/datum/mob_descriptor/fur/fluffy,
						/datum/mob_descriptor/fur/shaggy,
						/datum/mob_descriptor/fur/silky,
						/datum/mob_descriptor/fur/lank,
						/datum/mob_descriptor/fur/mangy,
						/datum/mob_descriptor/fur/velvety,
						/datum/mob_descriptor/fur/dense,
						/datum/mob_descriptor/fur/matted
					)
					if(new_type in valid_fur)
						descriptor_fur = new_type
				if("voice")
					var/list/valid_voice = list(
						/datum/mob_descriptor/voice/growly,
						/datum/mob_descriptor/voice/deep,
						/datum/mob_descriptor/voice/booming,
						/datum/mob_descriptor/voice/gravelly,
						/datum/mob_descriptor/voice/commanding,
						/datum/mob_descriptor/voice/monotone,
						/datum/mob_descriptor/voice/ordinary,
						/datum/mob_descriptor/voice/soft,
						/datum/mob_descriptor/voice/grave,
						/datum/mob_descriptor/voice/venomous,
						/datum/mob_descriptor/voice/dispassionate,
						/datum/mob_descriptor/voice/whiny,
						/datum/mob_descriptor/voice/drawling,
						/datum/mob_descriptor/voice/shrill,
						/datum/mob_descriptor/voice/stilted
					)
					if(new_type in valid_voice)
						descriptor_voice = new_type
				if("muzzle")
					var/list/valid_muzzle = list(
						/datum/mob_descriptor/face/gnoll/long_muzzle,
						/datum/mob_descriptor/face/gnoll/short_muzzle,
						/datum/mob_descriptor/face/gnoll/broad_muzzle,
						/datum/mob_descriptor/face/gnoll/narrow_muzzle,
						/datum/mob_descriptor/face/gnoll/scarred_muzzle,
						/datum/mob_descriptor/face/gnoll/sharp_muzzle,
						/datum/mob_descriptor/face/gnoll/worn_muzzle,
						/datum/mob_descriptor/face/gnoll/disfigured_muzzle
					)
					if(new_type in valid_muzzle)
						descriptor_muzzle = new_type
				if("expression")
					var/list/valid_expression = list(
						/datum/mob_descriptor/face_exp/gnoll/alert,
						/datum/mob_descriptor/face_exp/gnoll/snarling,
						/datum/mob_descriptor/face_exp/gnoll/predatory,
						/datum/mob_descriptor/face_exp/gnoll/hollow,
						/datum/mob_descriptor/face_exp/gnoll/fierce,
						/datum/mob_descriptor/face_exp/gnoll/vacant,
						/datum/mob_descriptor/face_exp/gnoll/groveling,
						/datum/mob_descriptor/face_exp/gnoll/leering
					)
					if(new_type in valid_expression)
						descriptor_expression = new_type
			gnoll_show_ui(user)

		if("close")
			user << browse(null, "window=gnoll_prefs")

	return TRUE
