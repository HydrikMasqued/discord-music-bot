# 🧹 Discord Purge Bot Module

A **modular** Discord message purging feature that can be easily added to or removed from your Music Bot setup. This module runs independently and can be stopped/started without affecting your main music bot functionality.

## ✨ Features

- **Modular Design**: Can be easily removed without affecting the main music bot
- **Multiple Purge Types**: 
  - Purge by message count
  - Purge by keyword
  - Purge by count + keyword combination
- **Smart Filtering**: Only deletes messages containing specified keywords
- **Permission Checks**: Ensures users have proper permissions before executing commands
- **Auto-cleanup**: Confirmation messages auto-delete after 5 seconds
- **Discord API Compliant**: Respects 14-day message age and bulk delete limitations

## 📋 Commands

| Command | Description | Example |
|---------|-------------|---------|
| `!purge [number]` | Delete last X messages (1-100) | `!purge 10` |
| `!purge [keyword]` | Delete messages containing keyword | `!purge test` |
| `!purge [number] [keyword]` | Delete X messages with keyword | `!purge 5 spam` |
| `!purgehelp` | Show detailed help message | `!purgehelp` |

## 🚀 Quick Start

### 1. Build the Module
```bash
BUILD_PURGE_BOT.bat
```

### 2. Configure (Optional)
The module uses the same Discord token as your music bot by default. If you want to customize settings, edit `purge-config.properties`.

### 3. Start the Module
```bash
START_PURGE_BOT.bat
```

### 4. Use Commands in Discord
- `!purge 25` - Delete last 25 messages
- `!purge spam` - Delete all messages containing "spam"
- `!purge 10 test` - Delete last 10 messages containing "test"

## 🔧 Easy Removal

To completely remove this feature:

### Option 1: Stop the Module
```bash
STOP_PURGE_BOT.bat
```
The module stops running but files remain for future use.

### Option 2: Complete Removal
1. Run `STOP_PURGE_BOT.bat`
2. Delete the entire `purge-module` folder
3. Done! Your music bot is unaffected.

## ⚙️ Requirements

### Bot Permissions
- `MANAGE_MESSAGES` - To delete messages
- `MESSAGE_HISTORY` - To read message history
- `SEND_MESSAGES` - To send confirmation messages

### User Permissions
- `MANAGE_MESSAGES` - Required to use purge commands

### System Requirements
- Java 17 or higher
- Maven (for building from source)
- Same Discord bot token as your music bot

## 🏗️ Technical Details

### File Structure
```
purge-module/
├── src/main/java/com/purgebot/
│   └── PurgeBot.java           # Main bot code
├── BUILD_PURGE_BOT.bat         # Build script
├── START_PURGE_BOT.bat         # Start script
├── STOP_PURGE_BOT.bat          # Stop script
├── purge-config.properties     # Configuration
├── pom.xml                     # Maven build file
└── README.md                   # This file
```

### How It Works
1. **Independent Process**: Runs as a separate Java process alongside your music bot
2. **Shared Token**: Uses the same Discord token, so both bots appear as one
3. **Command Filtering**: Only responds to purge-related commands
4. **Clean Architecture**: Completely isolated from music bot code

## 🛡️ Safety Features

- **Permission Validation**: Checks user and bot permissions before execution
- **Age Limitation**: Respects Discord's 14-day bulk delete limitation
- **Count Limits**: Maximum 100 messages per command (Discord API limit)
- **Auto-cleanup**: Status messages automatically delete
- **Error Handling**: Graceful handling of API errors and edge cases

## 🔄 Updating the Module

1. Stop the current module: `STOP_PURGE_BOT.bat`
2. Modify the source code as needed
3. Rebuild: `BUILD_PURGE_BOT.bat`  
4. Restart: `START_PURGE_BOT.bat`

## 💡 Examples

### Basic Message Purging
```
!purge 10
```
Deletes the last 10 messages in the current channel.

### Keyword-Based Purging
```
!purge test
```
Deletes all recent messages containing the word "test".

### Combined Purging
```
!purge 20 spam
```
Deletes up to 20 recent messages that contain the word "spam".

## 🚨 Important Notes

- **14-Day Limit**: Discord doesn't allow bulk deletion of messages older than 14 days
- **Single Channel**: Commands only affect the channel where they're used
- **Case Insensitive**: Keyword searches are case-insensitive
- **Instant Execution**: Commands execute immediately - be careful!
- **No Undo**: Deleted messages cannot be recovered

## 🤝 Integration

This module is designed to work alongside your existing Music Bot:
- **Same Token**: Both bots use the same Discord application
- **Different Commands**: No command conflicts (music uses `!play`, purge uses `!purge`)
- **Independent Operation**: Each can run/stop without affecting the other
- **Easy Management**: Simple batch files for all operations

---

**Need Help?** Use `!purgehelp` in Discord for command assistance, or check the batch file outputs for system messages.
