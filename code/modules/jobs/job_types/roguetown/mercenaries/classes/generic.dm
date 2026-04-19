/datum/advclass/mercenary/generic
	name = "Sellknight"
	tutorial = "Combat experience and skill doesn't pay for lodging, mammons do. A knight only in appearance, you took to the mercenary guild to sell your services as sword-toting muscle to the highest bidder."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/generic_sellknight
	class_select_category = CLASS_CAT_GENERIC
	category_tags = list(CTAG_MERCENARY)
	cmode_music = 'sound/music/combat_fullplate.ogg'
	traits_applied = list(TRAIT_HEAVYARMOR)
	subclass_stats = list( //Equivalent to the Doppelsoldner, but without their unique sword or blacksteel armor, in exchange they're basically just a dude in plate armor
		STATKEY_CON = 3,
		STATKEY_WIL = 3,
		STATKEY_STR = 2,
		STATKEY_PER = 1,
		STATKEY_SPD = -1
	)
	subclass_skills = list(
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT, //Sword and board kinda guy
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/mercenary/generic_sellknight/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("Combat experience and skill doesn't pay for lodging, mammons do. A knight only in appearance, you took to the mercenary guild to sell your services as sword-toting muscle to the highest bidder."))
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half //Sorry! If you want good armor, better get someone to pay you
	if(H.mind)
		var/weapons = list("Greatsword", "Longsword & Shield", "Rapier & Buckler")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		switch(weapon_choice)
			if("Greatsword")
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				r_hand = /obj/item/rogueweapon/greatsword
			if("Longsword & Shield")
				beltr = /obj/item/rogueweapon/scabbard/sword
				r_hand = /obj/item/rogueweapon/sword/long
				backl = /obj/item/rogueweapon/shield/iron
			if("Rapier & Buckler")
				beltr = /obj/item/rogueweapon/scabbard/sword
				r_hand = /obj/item/rogueweapon/sword/rapier
				backl = /obj/item/rogueweapon/shield/buckler
		var/helmets = list(
			"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
			"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
			"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
			"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
			"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
			"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
			"Armet"				= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
			"Hounskull Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
			"Etruscan Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
			"Slitted Kettle" = /obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle,
			"Froggemund Helmet"	= /obj/item/clothing/head/roguetown/helmet/heavy/frogmouth,
			"None"
		)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]
	wrists = /obj/item/clothing/wrists/roguetown/splintarms //We're lowkey kinda poor, so mostly iron armor for anything which isn't vital
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.merctype = 17

/datum/advclass/mercenary/generic/sellspear
	name = "Sellspear"
	tutorial = "Faceless and numerous, the mercenary guild is occupied by many of your ilk. Maille and polearms are as easily used by the unskilled as they are effective."
	outfit = /datum/outfit/job/roguetown/mercenary/generic_sellspear
	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list( //Extremely all-rounder statline for an extremely all-rounder weapon class and middling armor class. You are John Spearman
		STATKEY_STR = 1,
		STATKEY_CON = 1,
		STATKEY_WIL = 2,
		STATKEY_SPD = 1,
		STATKEY_PER = 2 //For stabbing and guardsman larping
	)
	subclass_skills = list(
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/roguetown/mercenary/generic_sellspear/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("Faceless and numerous, the mercenary guild is occupied by many of your ilk. Maille and polearms are as easily used by the unskilled as they are effective."))
	backl = /obj/item/rogueweapon/scabbard/gwstrap
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	if(H.mind)
		var/weapons = list("Halberd", "Partizan", "Eagle's Beak")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		switch(weapon_choice)
			if("Halberd")
				r_hand = /obj/item/rogueweapon/halberd
			if("Partizan")
				r_hand = /obj/item/rogueweapon/spear/partizan
			if("Eagle's Beak")
				r_hand = /obj/item/rogueweapon/eaglebeak
		var/helmets = list(
			"Simple Helmet" 	= /obj/item/clothing/head/roguetown/helmet,
			"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle,
			"Bascinet Helmet"	= /obj/item/clothing/head/roguetown/helmet/bascinet,
			"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet,
			"Winged Helmet" 	= /obj/item/clothing/head/roguetown/helmet/winged,
			"Skull Cap"			= /obj/item/clothing/head/roguetown/helmet/skullcap,
			"None"
		)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	gloves = /obj/item/clothing/gloves/roguetown/chain
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.merctype = 17

/datum/advclass/mercenary/generic/crossbowman
	name = "Light Crossbowman"
	tutorial = "Once a member of a guard mayhaps - you recieved training in bludgeons and crossbows, serving as a generic yet numerous and effective ranged service to the mercenary guild."
	outfit = /datum/outfit/job/roguetown/mercenary/generic_crossbowman
	traits_applied = list(TRAIT_KEENEARS) // Guardmaxing
	subclass_stats = list( // You're a little bit more tailored to the crossbowman identity than the Grenzelhoft crossbowman which is more of a utility role
		STATKEY_SPD = 1,
		STATKEY_WIL = 2,
		STATKEY_PER = 3,
		STATKEY_STR = 1,
		STATKEY_CON = -1
	)
	subclass_skills = list(
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN, //Crossbow is your main weapon
		/datum/skill/combat/crossbows = SKILL_LEVEL_MASTER,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE, //Ranged babies are made to be grabbed
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/swords = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/mercenary/generic_crossbowman/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("Once a member of a guard, mayhaps - you recieved training in bludgeons and crossbows, serving as a generic yet numerous and effective ranged service to the mercenary guild."))
	beltr = /obj/item/quiver/bolts
	beltl = /obj/item/rogueweapon/mace/cudgel
	r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	if(H.mind)
		var/armor_options = list("Light Brigandine", "Studded Leather Vest")
		var/armor_choice = input(H, "Choose your armor.", "DRESS UP") as anything in armor_options
		switch(armor_choice)
			if("Light Brigandine")
				armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
			if("Studded Leather Vest")
				armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
		var/helmets = list(
			"Simple Helmet" 	= /obj/item/clothing/head/roguetown/helmet,
			"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle,
			"Bascinet Helmet"	= /obj/item/clothing/head/roguetown/helmet/bascinet,
			"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet,
			"Winged Helmet" 	= /obj/item/clothing/head/roguetown/helmet/winged,
			"Skull Cap"			= /obj/item/clothing/head/roguetown/helmet/skullcap,
			"None"
		)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	gloves = /obj/item/clothing/gloves/roguetown/chain
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.merctype = 17
