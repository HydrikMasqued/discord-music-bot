# 🎵 Discord Music Bot - Command Guide

## ❌ **WRONG WAY (Don't use these):**
- `/play` ❌ (This is a Discord slash command - won't work)
- `/queue` ❌ 
- `/skip` ❌

## ✅ **CORRECT WAY (Use these):**

### 🎵 **Basic Music Commands:**
```
!play [song name]     - Play a song
!play never gonna give you up
!play bohemian rhapsody queen
!play https://youtube.com/watch?v=...

!queue               - Show current queue
!np                  - Show now playing
!skip                - Skip current song
!stop                - Stop music and clear queue
!pause               - Pause music
!resume              - Resume music
!volume 50           - Set volume (0-100)
```

### 🔧 **Queue Management:**
```
!shuffle             - Shuffle the queue
!remove 3            - Remove song #3 from queue
!skipto 5            - Skip to song #5 in queue
!repeat              - Toggle repeat mode
```

### ℹ️ **Information Commands:**
```
!help                - Show all commands
!settings            - Show bot settings (owner only)
!ping                - Check bot response time
```

### 👑 **Owner Commands (Only you can use):**
```
!shutdown            - Stop the bot completely
!setgame [text]      - Change bot's status
!eval [code]         - Execute code (dangerous!)
```

## 🎯 **How to Use Commands:**

1. **Make sure you're in a text channel where the bot can see messages**
2. **Type the command starting with !** (exclamation mark)
3. **The bot must be in your Discord server**

## 🔊 **For Voice Commands:**
1. **Join a voice channel first**
2. **Then use `!play [song]`**
3. **The bot will join your channel and play music**

## ⚠️ **Troubleshooting:**

### If commands don't work:
- ✅ Use `!` not `/`
- ✅ Make sure bot is online (green status)
- ✅ Bot needs permission to read messages in that channel
- ✅ For voice: Bot needs permission to connect/speak in voice channels

### If "Application did not respond":
- ❌ You used `/play` instead of `!play`
- ❌ Bot might not be running
- ❌ Bot doesn't have slash commands enabled (it uses text commands)

## 🎵 **Example Usage:**
```
User: !play never gonna give you up
Bot: 🎶 Added to queue: Rick Astley - Never Gonna Give You Up

User: !queue
Bot: 📋 Queue (1 song):
     1. Rick Astley - Never Gonna Give You Up [3:32]

User: !volume 75
Bot: 🔊 Volume set to 75%
```

---

**Remember: Use `!` (exclamation mark), not `/` (slash)!**
