// CentrexOS KWin window rules
// Loaded by KWin scripting engine at session start

// Keep file manager dialogs on the same virtual desktop as the opener
workspace.windowAdded.connect(function(client) {
    // Float utility windows
    if (client.dialog || client.utility || client.splash) {
        client.keepAbove = true;
    }

    // Restore geometry for known apps that forget their size
    if (client.resourceClass === "dolphin" && client.normalWindow) {
        client.setMaximize(false, false);
    }

    // Keep system settings dialog above its parent
    if (client.resourceName === "systemsettings") {
        client.keepAbove = false; // let user arrange freely
    }
});

// Borders: no window borders in tiled/maximised state
options.borderlessMaximizedWindows = true;
