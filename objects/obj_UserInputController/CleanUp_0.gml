/// @description

while ds_list_size(charObjectsArray) > 0 {
	var instance = ds_list_find_value(charObjectsArray, 0);
	ds_list_delete(charObjectsArray, 0);
	instance_destroy(instance);
}
ds_list_destroy(charObjectsArray);