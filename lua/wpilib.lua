local M = {}

M.wpilib = function(opts)
    if opts.args == "RefreshCppLsp" then
        vim.cmd("!./gradlew generateCompileCommands")
        vim.cmd("!mv build/TargetedCompileCommands/linuxathenadebug/compile_commands.json compile_commands.json")
        vim.cmd.LspRestart()
    end

    if opts.args == "Build" then
        vim.cmd("!./gradlew build")
    end

    if opts.args == "Deploy" then
        vim.cmd("!./gradlew deploy")
    end

    if opts.args == "Simulate" then
        if M.get_lang() == "cpp" then
            vim.cmd("!./gradlew :simulateNative")
        end

        if M.get_lang() == "java" then
            vim.cmd("!./gradlew :simulateJava")
        end
    end

    if opts.args == "InstallLibrary" or opts.args "Vendordep" then
            url = vim.fn.input("URL > ")
            vim.cmd("!./gradlew vendordep " .. url)
    end
end

M.get_lang = function()
    local object = vim.api.json_decode(vim.cmd("!cat .wpilib/wpilib_preferences.json"))
    return object.currentLanguage
end

vim.api.nvim_create_user_command('WPILib', M.wpilib, { nargs = 1, complete=arglist})
