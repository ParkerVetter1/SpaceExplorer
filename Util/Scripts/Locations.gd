extends Resource
class_name Location

var locations: Dictionary = {"player" : Vector2.ZERO, "ship" : Vector2(3000, 3000), "ship2" : Vector2(-3000, -3000)}

@warning_ignore("unused_signal") signal addedLocation

func addLocation(position: Vector2, lname: String):
	locations[lname] = position
	emit_signal("addedLocation")

func deleteLocation(lname: String):
	locations.erase(lname)
