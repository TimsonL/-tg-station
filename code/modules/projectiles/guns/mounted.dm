/obj/item/weapon/gun/energy/gun/advtaser/mounted
	name = "mounted taser"
	desc = "An arm mounted dual-mode weapon that fires electrodes and disabler shots."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "taser"
	item_state = "armcannonstun4"
	force = 5
	selfcharge = 1
	can_flashlight = 0
	can_pull_pin = 0
	cell_removing = 0

/obj/item/weapon/gun/energy/gun/advtaser/mounted/dropped()//if somebody manages to drop this somehow...
	..()
	src.loc = null//send it to nullspace to get retrieved by the implant later on. gotta cover those edge cases.

/obj/item/weapon/gun/energy/laser/mounted
	name = "mounted laser"
	desc = "An arm mounted cannon that fires lethal lasers."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "laser"
	item_state = "armcannonlase"
	force = 5
	selfcharge = 1
	can_pull_pin = 0
	cell_removing = 0

/obj/item/weapon/gun/energy/laser/mounted/dropped()
	..()
	src.loc = null