# Music Bot Setup Instructions

This is your personal Discord Music Bot based on the JMusicBot by jagrosh. Follow these steps to get it running:

## Prerequisites

1. **Java 11 or higher** - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://openjdk.org/)
2. **Discord Bot Token** - See instructions below
3. **Your Discord User ID** - See instructions below

## Getting a Discord Bot Token

1. Go to the [Discord Developer Portal](https://discord.com/developers/applications)
2. Click "New Application" and give your bot a name
3. Go to the "Bot" section on the left sidebar
4. Click "Add Bot"
5. Under "Token", click "Copy" to copy your bot token
6. **Keep this token secret!** Don't share it with anyone

## Getting Your Discord User ID

1. Open Discord
2. Go to User Settings (click the gear icon next to your name)
3. Go to "Advanced" and enable "Developer Mode"
4. Close settings, right-click on your username anywhere, and select "Copy ID"

## Configuration

You have two options to configure the bot:

### Option 1: Edit config.txt (Recommended)

1. Open `config.txt` in a text editor
2. Replace `BOT_TOKEN_HERE` with your Discord bot token
3. Replace `0 // OWNER ID` with your Discord user ID
4. Optionally, change the prefix from `"!"` to whatever you prefer

### Option 2: Edit .env file

1. Open `.env` in a text editor
2. Replace `YOUR_BOT_TOKEN_HERE` with your Discord bot token
3. Replace `YOUR_DISCORD_USER_ID_HERE` with your Discord user ID
4. Optionally, change the prefix and activity status

## Inviting the Bot to Your Server

1. In the Discord Developer Portal, go to your application
2. Go to "OAuth2" → "URL Generator"
3. Under "Scopes", select:
   - `bot`
   - `applications.commands`
4. Under "Bot Permissions", select:
   - Send Messages
   - Use Slash Commands
   - Connect
   - Speak
   - Use Voice Activity
   - Read Message History
5. Copy the generated URL and open it in your browser
6. Select your server and authorize the bot

## Running the Bot

### Method 1: Using Maven (if you have it installed)
```bash
mvn clean compile exec:java
```

### Method 2: Download pre-compiled JAR
1. Go to [JMusicBot Releases](https://github.com/jagrosh/MusicBot/releases)
2. Download the latest `JMusicBot-X.X.X.jar` file
3. Place it in this folder
4. Run: `java -jar JMusicBot-X.X.X.jar`

### Method 3: Compile from source
1. Make sure you have Maven installed
2. Run: `mvn clean package`
3. The compiled JAR will be in the `target` folder
4. Run: `java -jar target/JMusicBot-X.X.X.jar`

## Bot Commands

Once the bot is running and in your server, you can use these commands:

### Music Commands (Anyone can use)
- `!play <song>` - Play a song from YouTube, SoundCloud, etc.
- `!queue` - Show the current queue
- `!skip` - Vote to skip the current song
- `!np` - Show now playing
- `!search <query>` - Search for songs
- `!lyrics` - Get lyrics for the current song

### DJ/Admin Commands
- `!pause` - Pause playback
- `!stop` - Stop playback and clear queue
- `!volume <0-100>` - Set volume
- `!skipto <position>` - Skip to a position in the queue
- `!shuffle` - Shuffle the queue
- `!repeat` - Toggle repeat mode

### Admin Commands
- `!settings` - Show server settings
- `!setdj <role>` - Set the DJ role
- `!prefix <new prefix>` - Change the bot prefix

## Troubleshooting

1. **Bot doesn't respond**: Check that the bot token is correct and the bot is online
2. **No audio**: Make sure the bot has permission to connect and speak in voice channels
3. **Java errors**: Ensure you're using Java 11 or higher
4. **Config errors**: Check that your config.txt file format is correct

## Features

- Play music from YouTube, SoundCloud, Bandcamp, and more
- Queue management
- Playlists support
- Volume control
- Skip voting
- Beautiful embedded messages
- Server-specific settings
- DJ role system

## Support

For issues with the original JMusicBot, check:
- [JMusicBot GitHub Issues](https://github.com/jagrosh/MusicBot/issues)
- [JMusicBot Discussions](https://github.com/jagrosh/MusicBot/discussions)
- [Setup Guide](https://jmusicbot.com/setup)

---

**Important**: Never share your bot token with anyone! Keep it secure and treat it like a password.
