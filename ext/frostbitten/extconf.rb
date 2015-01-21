require 'mkmf'
extension_name = 'native'
dir_config(extension_name)
$CFLAGS << " -std=c99"
create_makefile("frostbitten/#{extension_name}")
