/// @description Handle logout button

if global.logoutActive {
	exit;
}

instance_create_layer(0, 0, "Logout", obj_LogoutController);