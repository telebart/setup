local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

local function perform_action(window, pane, choices)
	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(win, _, id, label)
				if not id and not label then
				else
					win:perform_action(
						act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }),
						pane
					)
				end
			end),
			fuzzy = true,
      fuzzy_description = "> ",
			title = "Select project",
			choices = choices,
		}),
		pane
	)
end

M.create_or_switch = function(window, pane)
	local projects = {}

  local home = os.getenv("HOME")
	local success, stdout, stderr = wezterm.run_child_process({
		"fd",
		"-HI",
		"^.git$",
		"--max-depth=4",
		"--prune",
		home .. "/repos",
		home .. "/personal",
	})

	if not success then
		wezterm.log_error("Failed to run fd: " .. stderr)
		return
	end

	for line in stdout:gmatch("([^\n]*)\n?") do
		local project = line:gsub("/.git.*$", "")
		local label = project
		local id = project:gsub(".*/", "")
		table.insert(projects, { label = tostring(label), id = tostring(id) })
	end

  perform_action(window, pane, projects)
end

M.switch = function(window, pane)
  local workspaces = {}
  for _, workspace in pairs(wezterm.mux.get_workspace_names()) do
		table.insert(workspaces, { label = workspace})
  end

  perform_action(window, pane, workspaces)
end


return M
