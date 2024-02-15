local wpilib = function(opts)
    if opts.args == "RefreshCppLsp" then
        vim.cmd("!./gradlew generateCompileCommands")
        vim.cmd("!mv build/TargetedCompileCommands/linuxx86-64debug/compile_commands.json compile_commands.json")
        vim.cmd.LspRestart()
    end

    if opts.args == "Build" then
        vim.cmd("!./gradlew build")
    end

    if opts.args == "Deploy" then
        vim.cmd("!./gradlew deploy")
    end
end

vim.api.nvim_create_user_command('WPILib', wpilib, { nargs = 1 })
