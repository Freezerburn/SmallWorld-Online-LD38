/// @description Add text put into writeToConsole to the console

if is_real(parser.toWrite) && ds_exists(parser.toWrite, ds_type_list) {
	for (var i = 0; i < ds_list_size(parser.toWrite); i++) {
		ds_list_add(console.drawLines, ds_list_find_value(parser.toWrite, i));
	}
} else if is_string(parser.toWrite) {
	ds_list_add(console.drawLines, parser.toWrite);
} else {
	ds_list_add(console.drawLines, string(parser.toWrite));
}
writeToConsole = -1;