local M = {}
local environment = require('http_request.environment')
local file_utils = require('http_request.file_utils')
local http_client = require('http_request.http_client')
local parser = require('http_request.parser')
local ui = require('http_request.ui')

M.select_env_file = function()
    local files = file_utils.find_files('*.env.json')
    vim.ui.select(files, {
        prompt = 'Select environment file:',
    }, function(choice)
        if choice then
            environment.set_env_file(choice)
            print('Environment file set to: ' .. choice)
        end
    end)
end

M.set_env = function(env_name)
    local success = environment.set_env(env_name)
    if success then
        print('Environment set to: ' .. env_name)
    else
        print('Failed to set environment: ' .. env_name)
    end
end

M.run_request = function()
    local request = parser.get_request_under_cursor()
    if not request then
        print('No valid HTTP request found under cursor')
        return
    end

    local env = environment.get_current_env()
    request = parser.replace_placeholders(request, env)

    http_client.send_request(request, function(response)
        ui.display_response(response)
    end)
end

M.stop_request = function()
    http_client.stop_request()
    print('HTTP request stopped')
end

return M

