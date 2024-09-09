local http_request = require('http_client')


vim.api.nvim_create_user_command('HttpEnvFile', function()
    http_request.commands.select_env_file()
end, {})


vim.api.nvim_create_user_command('HttpEnv', function(opts)
    http_request.commands.set_env(opts.args)
end, { nargs = 1 })


vim.api.nvim_create_user_command('HttpRun', function(opts)
    http_request.commands.run_request({ verbose = opts.bang })
end, { bang = true })


vim.api.nvim_create_user_command('HttpVerbose', function(opts)
    if opts.args == "on" then
        http_request.commands.set_verbose_mode(true)
    elseif opts.args == "off" then
        http_request.commands.set_verbose_mode(false)
    else
        print("Usage: HttpVerbose on|off")
    end
end, { nargs = 1, complete = function(_, _, _) return { "on", "off" } end })


vim.api.nvim_create_user_command('HttpStop', function()
    http_request.commands.stop_request()
end, {})


vim.api.nvim_create_user_command('HttpDryRun', function()
    http_request.commands.dry_run()
end, {})
