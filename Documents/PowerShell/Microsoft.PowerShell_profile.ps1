using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'rustup' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'rustup'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'rustup' {
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Set log level to ''DEBUG'' if ''RUSTUP_LOG'' is unset')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Set log level to ''DEBUG'' if ''RUSTUP_LOG'' is unset')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Disable progress output, set log level to ''WARN'' if ''RUSTUP_LOG'' is unset')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Disable progress output, set log level to ''WARN'' if ''RUSTUP_LOG'' is unset')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install or update the given toolchains, or by default the active toolchain')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall the given toolchains')
            [CompletionResult]::new('dump-testament', 'dump-testament', [CompletionResultType]::ParameterValue, 'Dump information about the build')
            [CompletionResult]::new('show', 'show', [CompletionResultType]::ParameterValue, 'Show the active and installed toolchains or profiles')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Update Rust toolchains and rustup')
            [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Check for updates to Rust toolchains and rustup')
            [CompletionResult]::new('default', 'default', [CompletionResultType]::ParameterValue, 'Set the default toolchain')
            [CompletionResult]::new('toolchain', 'toolchain', [CompletionResultType]::ParameterValue, 'Modify or query the installed toolchains')
            [CompletionResult]::new('target', 'target', [CompletionResultType]::ParameterValue, 'Modify a toolchain''s supported targets')
            [CompletionResult]::new('component', 'component', [CompletionResultType]::ParameterValue, 'Modify a toolchain''s installed components')
            [CompletionResult]::new('override', 'override', [CompletionResultType]::ParameterValue, 'Modify toolchain overrides for directories')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a command with an environment configured for a given toolchain')
            [CompletionResult]::new('which', 'which', [CompletionResultType]::ParameterValue, 'Display which binary will be run for a given command')
            [CompletionResult]::new('doc', 'doc', [CompletionResultType]::ParameterValue, 'Open the documentation for the current toolchain')
            [CompletionResult]::new('self', 'self', [CompletionResultType]::ParameterValue, 'Modify the rustup installation')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Alter rustup settings')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate tab-completion scripts for your shell')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;install' {
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'profile')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Comma-separated list of components to be added on installation')
            [CompletionResult]::new('--component', '--component', [CompletionResultType]::ParameterName, 'Comma-separated list of components to be added on installation')
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'Comma-separated list of targets to be added on installation')
            [CompletionResult]::new('--target', '--target', [CompletionResultType]::ParameterName, 'Comma-separated list of targets to be added on installation')
            [CompletionResult]::new('--no-self-update', '--no-self-update', [CompletionResultType]::ParameterName, 'Don''t perform self update when running the `rustup toolchain install` command')
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Force an update, even if some components are missing')
            [CompletionResult]::new('--allow-downgrade', '--allow-downgrade', [CompletionResultType]::ParameterName, 'Allow rustup to downgrade the toolchain to satisfy your component choice')
            [CompletionResult]::new('--force-non-host', '--force-non-host', [CompletionResultType]::ParameterName, 'Install toolchains that require an emulator. See https://github.com/rust-lang/rustup/wiki/Non-host-toolchains')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;uninstall' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;dump-testament' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;show' {
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Enable verbose output with rustc information for all installed toolchains')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Enable verbose output with rustc information for all installed toolchains')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('active-toolchain', 'active-toolchain', [CompletionResultType]::ParameterValue, 'Show the active toolchain')
            [CompletionResult]::new('home', 'home', [CompletionResultType]::ParameterValue, 'Display the computed value of RUSTUP_HOME')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'Show the default profile used for the `rustup install` command')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;show;active-toolchain' {
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Enable verbose output with rustc information')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Enable verbose output with rustc information')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;show;home' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;show;profile' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;show;help' {
            [CompletionResult]::new('active-toolchain', 'active-toolchain', [CompletionResultType]::ParameterValue, 'Show the active toolchain')
            [CompletionResult]::new('home', 'home', [CompletionResultType]::ParameterValue, 'Display the computed value of RUSTUP_HOME')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'Show the default profile used for the `rustup install` command')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;show;help;active-toolchain' {
            break
        }
        'rustup;show;help;home' {
            break
        }
        'rustup;show;help;profile' {
            break
        }
        'rustup;show;help;help' {
            break
        }
        'rustup;update' {
            [CompletionResult]::new('--no-self-update', '--no-self-update', [CompletionResultType]::ParameterName, 'Don''t perform self update when running the `rustup update` command')
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Force an update, even if some components are missing')
            [CompletionResult]::new('--force-non-host', '--force-non-host', [CompletionResultType]::ParameterName, 'Install toolchains that require an emulator. See https://github.com/rust-lang/rustup/wiki/Non-host-toolchains')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;check' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;default' {
            [CompletionResult]::new('--force-non-host', '--force-non-host', [CompletionResultType]::ParameterName, 'Install toolchains that require an emulator. See https://github.com/rust-lang/rustup/wiki/Non-host-toolchains')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;toolchain' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed toolchains')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install or update the given toolchains, or by default the active toolchain')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall the given toolchains')
            [CompletionResult]::new('link', 'link', [CompletionResultType]::ParameterValue, 'Create a custom toolchain by symlinking to a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;toolchain;list' {
            [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Enable verbose output with toolchain information')
            [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Enable verbose output with toolchain information')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Force the output to be a single column')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Force the output to be a single column')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;toolchain;install' {
            [CompletionResult]::new('--profile', '--profile', [CompletionResultType]::ParameterName, 'profile')
            [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Comma-separated list of components to be added on installation')
            [CompletionResult]::new('--component', '--component', [CompletionResultType]::ParameterName, 'Comma-separated list of components to be added on installation')
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'Comma-separated list of targets to be added on installation')
            [CompletionResult]::new('--target', '--target', [CompletionResultType]::ParameterName, 'Comma-separated list of targets to be added on installation')
            [CompletionResult]::new('--no-self-update', '--no-self-update', [CompletionResultType]::ParameterName, 'Don''t perform self update when running the `rustup toolchain install` command')
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Force an update, even if some components are missing')
            [CompletionResult]::new('--allow-downgrade', '--allow-downgrade', [CompletionResultType]::ParameterName, 'Allow rustup to downgrade the toolchain to satisfy your component choice')
            [CompletionResult]::new('--force-non-host', '--force-non-host', [CompletionResultType]::ParameterName, 'Install toolchains that require an emulator. See https://github.com/rust-lang/rustup/wiki/Non-host-toolchains')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;toolchain;uninstall' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;toolchain;link' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;toolchain;help' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed toolchains')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install or update the given toolchains, or by default the active toolchain')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall the given toolchains')
            [CompletionResult]::new('link', 'link', [CompletionResultType]::ParameterValue, 'Create a custom toolchain by symlinking to a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;toolchain;help;list' {
            break
        }
        'rustup;toolchain;help;install' {
            break
        }
        'rustup;toolchain;help;uninstall' {
            break
        }
        'rustup;toolchain;help;link' {
            break
        }
        'rustup;toolchain;help;help' {
            break
        }
        'rustup;target' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available targets')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a target to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a target from a Rust toolchain')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;target;list' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--installed', '--installed', [CompletionResultType]::ParameterName, 'List only installed targets')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Force the output to be a single column')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Force the output to be a single column')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;target;add' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;target;remove' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;target;help' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available targets')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a target to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a target from a Rust toolchain')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;target;help;list' {
            break
        }
        'rustup;target;help;add' {
            break
        }
        'rustup;target;help;remove' {
            break
        }
        'rustup;target;help;help' {
            break
        }
        'rustup;component' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available components')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a component to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a component from a Rust toolchain')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;component;list' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--installed', '--installed', [CompletionResultType]::ParameterName, 'List only installed components')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Force the output to be a single column')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Force the output to be a single column')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;component;add' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--target', '--target', [CompletionResultType]::ParameterName, 'target')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;component;remove' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--target', '--target', [CompletionResultType]::ParameterName, 'target')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;component;help' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available components')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a component to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a component from a Rust toolchain')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;component;help;list' {
            break
        }
        'rustup;component;help;add' {
            break
        }
        'rustup;component;help;remove' {
            break
        }
        'rustup;component;help;help' {
            break
        }
        'rustup;override' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List directory toolchain overrides')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the override toolchain for a directory')
            [CompletionResult]::new('unset', 'unset', [CompletionResultType]::ParameterValue, 'Remove the override toolchain for a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;override;list' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;override;set' {
            [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'Path to the directory')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;override;unset' {
            [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'Path to the directory')
            [CompletionResult]::new('--nonexistent', '--nonexistent', [CompletionResultType]::ParameterName, 'Remove override toolchain for all nonexistent directories')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;override;help' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List directory toolchain overrides')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the override toolchain for a directory')
            [CompletionResult]::new('unset', 'unset', [CompletionResultType]::ParameterValue, 'Remove the override toolchain for a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;override;help;list' {
            break
        }
        'rustup;override;help;set' {
            break
        }
        'rustup;override;help;unset' {
            break
        }
        'rustup;override;help;help' {
            break
        }
        'rustup;run' {
            [CompletionResult]::new('--install', '--install', [CompletionResultType]::ParameterName, 'Install the requested toolchain if needed')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;which' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', ''1.8.0'', or a custom toolchain name. For more information see `rustup help toolchain`')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;doc' {
            [CompletionResult]::new('--toolchain', '--toolchain', [CompletionResultType]::ParameterName, 'Toolchain name, such as ''stable'', ''nightly'', or ''1.8.0''. For more information see `rustup help toolchain`')
            [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'Only print the path to the documentation')
            [CompletionResult]::new('--alloc', '--alloc', [CompletionResultType]::ParameterName, 'The Rust core allocation and collections library')
            [CompletionResult]::new('--book', '--book', [CompletionResultType]::ParameterName, 'The Rust Programming Language book')
            [CompletionResult]::new('--cargo', '--cargo', [CompletionResultType]::ParameterName, 'The Cargo Book')
            [CompletionResult]::new('--clippy', '--clippy', [CompletionResultType]::ParameterName, 'The Clippy Documentation')
            [CompletionResult]::new('--core', '--core', [CompletionResultType]::ParameterName, 'The Rust Core Library')
            [CompletionResult]::new('--edition-guide', '--edition-guide', [CompletionResultType]::ParameterName, 'The Rust Edition Guide')
            [CompletionResult]::new('--embedded-book', '--embedded-book', [CompletionResultType]::ParameterName, 'The Embedded Rust Book')
            [CompletionResult]::new('--error-codes', '--error-codes', [CompletionResultType]::ParameterName, 'The Rust Error Codes Index')
            [CompletionResult]::new('--nomicon', '--nomicon', [CompletionResultType]::ParameterName, 'The Dark Arts of Advanced and Unsafe Rust Programming')
            [CompletionResult]::new('--proc_macro', '--proc_macro', [CompletionResultType]::ParameterName, 'A support library for macro authors when defining new macros')
            [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'The Rust Reference')
            [CompletionResult]::new('--rust-by-example', '--rust-by-example', [CompletionResultType]::ParameterName, 'A collection of runnable examples that illustrate various Rust concepts and standard libraries')
            [CompletionResult]::new('--rustc', '--rustc', [CompletionResultType]::ParameterName, 'The compiler for the Rust programming language')
            [CompletionResult]::new('--rustdoc', '--rustdoc', [CompletionResultType]::ParameterName, 'Documentation generator for Rust projects')
            [CompletionResult]::new('--std', '--std', [CompletionResultType]::ParameterName, 'Standard library API documentation')
            [CompletionResult]::new('--style-guide', '--style-guide', [CompletionResultType]::ParameterName, 'The Rust Style Guide')
            [CompletionResult]::new('--test', '--test', [CompletionResultType]::ParameterName, 'Support code for rustc''s built in unit-test and micro-benchmarking framework')
            [CompletionResult]::new('--unstable-book', '--unstable-book', [CompletionResultType]::ParameterName, 'The Unstable Book')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;self' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Download and install updates to rustup')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall rustup')
            [CompletionResult]::new('upgrade-data', 'upgrade-data', [CompletionResultType]::ParameterValue, 'Upgrade the internal data format')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;self;update' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;self;uninstall' {
            [CompletionResult]::new('-y', '-y', [CompletionResultType]::ParameterName, 'y')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;self;upgrade-data' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;self;help' {
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Download and install updates to rustup')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall rustup')
            [CompletionResult]::new('upgrade-data', 'upgrade-data', [CompletionResultType]::ParameterValue, 'Upgrade the internal data format')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;self;help;update' {
            break
        }
        'rustup;self;help;uninstall' {
            break
        }
        'rustup;self;help;upgrade-data' {
            break
        }
        'rustup;self;help;help' {
            break
        }
        'rustup;set' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('default-host', 'default-host', [CompletionResultType]::ParameterValue, 'The triple used to identify toolchains when not specified')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'The default components installed with a toolchain')
            [CompletionResult]::new('auto-self-update', 'auto-self-update', [CompletionResultType]::ParameterValue, 'The rustup auto self update mode')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;set;default-host' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;set;profile' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;set;auto-self-update' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;set;help' {
            [CompletionResult]::new('default-host', 'default-host', [CompletionResultType]::ParameterValue, 'The triple used to identify toolchains when not specified')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'The default components installed with a toolchain')
            [CompletionResult]::new('auto-self-update', 'auto-self-update', [CompletionResultType]::ParameterValue, 'The rustup auto self update mode')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;set;help;default-host' {
            break
        }
        'rustup;set;help;profile' {
            break
        }
        'rustup;set;help;auto-self-update' {
            break
        }
        'rustup;set;help;help' {
            break
        }
        'rustup;completions' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'rustup;help' {
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install or update the given toolchains, or by default the active toolchain')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall the given toolchains')
            [CompletionResult]::new('dump-testament', 'dump-testament', [CompletionResultType]::ParameterValue, 'Dump information about the build')
            [CompletionResult]::new('show', 'show', [CompletionResultType]::ParameterValue, 'Show the active and installed toolchains or profiles')
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Update Rust toolchains and rustup')
            [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Check for updates to Rust toolchains and rustup')
            [CompletionResult]::new('default', 'default', [CompletionResultType]::ParameterValue, 'Set the default toolchain')
            [CompletionResult]::new('toolchain', 'toolchain', [CompletionResultType]::ParameterValue, 'Modify or query the installed toolchains')
            [CompletionResult]::new('target', 'target', [CompletionResultType]::ParameterValue, 'Modify a toolchain''s supported targets')
            [CompletionResult]::new('component', 'component', [CompletionResultType]::ParameterValue, 'Modify a toolchain''s installed components')
            [CompletionResult]::new('override', 'override', [CompletionResultType]::ParameterValue, 'Modify toolchain overrides for directories')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a command with an environment configured for a given toolchain')
            [CompletionResult]::new('which', 'which', [CompletionResultType]::ParameterValue, 'Display which binary will be run for a given command')
            [CompletionResult]::new('doc', 'doc', [CompletionResultType]::ParameterValue, 'Open the documentation for the current toolchain')
            [CompletionResult]::new('self', 'self', [CompletionResultType]::ParameterValue, 'Modify the rustup installation')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Alter rustup settings')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate tab-completion scripts for your shell')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'rustup;help;install' {
            break
        }
        'rustup;help;uninstall' {
            break
        }
        'rustup;help;dump-testament' {
            break
        }
        'rustup;help;show' {
            [CompletionResult]::new('active-toolchain', 'active-toolchain', [CompletionResultType]::ParameterValue, 'Show the active toolchain')
            [CompletionResult]::new('home', 'home', [CompletionResultType]::ParameterValue, 'Display the computed value of RUSTUP_HOME')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'Show the default profile used for the `rustup install` command')
            break
        }
        'rustup;help;show;active-toolchain' {
            break
        }
        'rustup;help;show;home' {
            break
        }
        'rustup;help;show;profile' {
            break
        }
        'rustup;help;update' {
            break
        }
        'rustup;help;check' {
            break
        }
        'rustup;help;default' {
            break
        }
        'rustup;help;toolchain' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed toolchains')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install or update the given toolchains, or by default the active toolchain')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall the given toolchains')
            [CompletionResult]::new('link', 'link', [CompletionResultType]::ParameterValue, 'Create a custom toolchain by symlinking to a directory')
            break
        }
        'rustup;help;toolchain;list' {
            break
        }
        'rustup;help;toolchain;install' {
            break
        }
        'rustup;help;toolchain;uninstall' {
            break
        }
        'rustup;help;toolchain;link' {
            break
        }
        'rustup;help;target' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available targets')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a target to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a target from a Rust toolchain')
            break
        }
        'rustup;help;target;list' {
            break
        }
        'rustup;help;target;add' {
            break
        }
        'rustup;help;target;remove' {
            break
        }
        'rustup;help;component' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List installed and available components')
            [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a component to a Rust toolchain')
            [CompletionResult]::new('remove', 'remove', [CompletionResultType]::ParameterValue, 'Remove a component from a Rust toolchain')
            break
        }
        'rustup;help;component;list' {
            break
        }
        'rustup;help;component;add' {
            break
        }
        'rustup;help;component;remove' {
            break
        }
        'rustup;help;override' {
            [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List directory toolchain overrides')
            [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the override toolchain for a directory')
            [CompletionResult]::new('unset', 'unset', [CompletionResultType]::ParameterValue, 'Remove the override toolchain for a directory')
            break
        }
        'rustup;help;override;list' {
            break
        }
        'rustup;help;override;set' {
            break
        }
        'rustup;help;override;unset' {
            break
        }
        'rustup;help;run' {
            break
        }
        'rustup;help;which' {
            break
        }
        'rustup;help;doc' {
            break
        }
        'rustup;help;self' {
            [CompletionResult]::new('update', 'update', [CompletionResultType]::ParameterValue, 'Download and install updates to rustup')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall rustup')
            [CompletionResult]::new('upgrade-data', 'upgrade-data', [CompletionResultType]::ParameterValue, 'Upgrade the internal data format')
            break
        }
        'rustup;help;self;update' {
            break
        }
        'rustup;help;self;uninstall' {
            break
        }
        'rustup;help;self;upgrade-data' {
            break
        }
        'rustup;help;set' {
            [CompletionResult]::new('default-host', 'default-host', [CompletionResultType]::ParameterValue, 'The triple used to identify toolchains when not specified')
            [CompletionResult]::new('profile', 'profile', [CompletionResultType]::ParameterValue, 'The default components installed with a toolchain')
            [CompletionResult]::new('auto-self-update', 'auto-self-update', [CompletionResultType]::ParameterValue, 'The rustup auto self update mode')
            break
        }
        'rustup;help;set;default-host' {
            break
        }
        'rustup;help;set;profile' {
            break
        }
        'rustup;help;set;auto-self-update' {
            break
        }
        'rustup;help;completions' {
            break
        }
        'rustup;help;help' {
            break
        }
    })

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (bat --completion ps1 | Out-String)})
}

# pip powershell completion start
if ((Test-Path Function:\TabExpansion) -and -not `
    (Test-Path Function:\_pip_completeBackup)) {
    Rename-Item Function:\TabExpansion _pip_completeBackup
}
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
    if ($lastBlock.StartsWith("pip ")) {
        $Env:COMP_WORDS=$lastBlock
        $Env:COMP_CWORD=$lastBlock.Split().Length - 1
        $Env:PIP_AUTO_COMPLETE=1
        (& pip).Split()
        Remove-Item Env:COMP_WORDS
        Remove-Item Env:COMP_CWORD
        Remove-Item Env:PIP_AUTO_COMPLETE
    }
    elseif (Test-Path Function:\_pip_completeBackup) {
        # Fall back on existing tab expansion
        _pip_completeBackup $line $lastWord
    }
}
# pip powershell completion end


Remove-Alias -Name ls
Remove-Alias -Name cat
Remove-Alias -Name pwd

function eza-ls { eza --icons=auto --classify=auto $args }
function eza-ll { eza --long --header --icons=auto --classify=auto --git --smart-group $args }
function eza-la { eza --long --all --header --icons=auto --classify=auto --git --smart-group $args }
function eza-ltree { eza --tree --header --long --icons=auto --classify=auto --git --smart-group $args }
function eza-tree { eza --tree --icons=auto --classify=auto $args }
function cd-dl { cd "~/Downloads" }
function cd-zz { cd "-" }
function fzf-nvim { fzf --preview='bat --color=always -- {}' --bind 'enter:become(nvim {})' }
function fzf-bat { fzf --preview='bat --color=always -- {}' --bind 'enter:become(bat -- {})' }
function bin-bat { bat --nonprintable-notation caret --show-all $args }

function reboot-func {
    if ( -not $args ) {
        $shutdown_args = 0
    } else {
        $shutdown_args = $args
    }

    shutdown /r /t $shutdown_args
}

# Add ~/.local/bin to PATH if it exists
$local_bin="$env:HOME\.local\bin"
if ( (Test-Path $local_bin) -and (-not ($env:PATH -like "*$local_bin*") ) ) {
    $env:PATH += ";$local_bin;"
}

$env:FZF_DEFAULT_OPTS="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 --height 40% --layout=reverse --border --info=inline"
$env:LG_CONFIG_FILE="$env:HOME\.config\lazygit\config.yml,$env:HOME\.config\lazygit\pink.yml"
$env:EZA_CONFIG_DIR="$env:HOME\.config\eza"

New-Alias -Name vi -Value nvim
New-Alias -Name fvim -Value fzf-nvim
New-Alias -Name fbat -Value fzf-bat

New-Alias -Name dl -Value cd-dl
New-Alias -Name zz -Value cd-zz

New-Alias -Name ls -Value eza-ls
New-Alias -Name ll -Value eza-ll
New-Alias -Name la -Value eza-la
New-Alias -Name ltree -Value eza-ltree
New-Alias -Name tree -Value eza-tree

New-Alias -Name lg -Value lazygit.exe
New-Alias -Name cz -Value chezmoi.exe

New-Alias -Name cat -Value bat
New-Alias -Name binbat -Value bin-bat

New-Alias -Name sreload -value refreshenv.cmd
New-Alias -Name reboot -Value reboot-func

#New-Alias -Name more less.exe
$env:PAGER = 'less.exe'
$env:EDITOR= 'nvim'

if (Get-Command oh-my-posh -errorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$($env:HOME)/.config/oh-my-posh/catppuccin.omp.toml" | Invoke-Expression
}

if (Get-Command zoxide -errorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
}

if (Get-Command chezmoi -errorAction SilentlyContinue) {
    Invoke-Expression (& { (chezmoi completion powershell | Out-String)})
}

if (Test-Path -Path "$PSScriptRoot\functions") {
    Get-ChildItem "$PSScriptRoot\functions" -Filter *.ps1 | Foreach-Object {
        . "$($_.FullName)"
    }
}

