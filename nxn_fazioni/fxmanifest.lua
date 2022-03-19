fx_version 'adamant'

game 'gta5'

name 'nxn_fazioni'

author 'utisss.#0672'

shared_scripts {
    '@es_extended/imports.lua'
}

server_scripts {
    'config.lua',
    'server/server.lua'
}

client_scripts {
    'config.lua',
    'client/client.lua'
}

dependencies {
    'gridsystem',
    'ox_inventory'
}