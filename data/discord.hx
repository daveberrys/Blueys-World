import funkin.backend.utils.DiscordUtil;

function onReady() {
	DiscordUtil.changePresenceAdvanced({
		state: "This mod is made with Codename Engine!",
		details: "Playing Bluey's World",
	});
}

function onDiscordPresenceUpdate(e) {
	var data = e.presence;

	if(data.button1Label == null)
		data.button1Label = "Join the Community!";
	if(data.button1Url == null)
		data.button1Url = "https://discord.gg/eyTeeEZS7U";
}