extends Node

var name_array = ["aaa", "bbb", "ccc"]
var age_array = [10, 20, 30]
 
func _ready():
	for value in range(name_array.size()):
		print("Name : " + name_array[value] + " and Age : " +str(age_array[value]))
	