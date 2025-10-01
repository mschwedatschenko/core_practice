set display_name {mary-core}

set core [ipx::current_core]

set_property DISPLAY_NAME $display_name $core
set_property DESCRIPTION $display_name $core

set_property VENDOR {WPI} $core
set_property VENDOR_DISPLAY_NAME {WPI} $core
set_property COMPANY_URL {https://www.wpi.edu/} $core