package com.purgebot;

import net.dv8tion.jda.api.JDA;
import net.dv8tion.jda.api.JDABuilder;
import net.dv8tion.jda.api.Permission;
import net.dv8tion.jda.api.entities.Message;
import net.dv8tion.jda.api.entities.channel.concrete.TextChannel;
import net.dv8tion.jda.api.events.message.MessageReceivedEvent;
import net.dv8tion.jda.api.hooks.ListenerAdapter;
import net.dv8tion.jda.api.requests.GatewayIntent;
import net.dv8tion.jda.api.utils.MemberCachePolicy;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

/**
 * Modular Purge Bot - Easily removable Discord message purging functionality
 * 
 * Features:
 * - !purge [number] - Purges X number of messages
 * - !purge [keyword] - Purges messages containing the keyword
 * - !purge [number] [keyword] - Purges X messages containing the keyword
 * 
 * Requirements:
 * - Bot needs MANAGE_MESSAGES and READ_MESSAGE_HISTORY permissions
 * - User needs MANAGE_MESSAGES permission to use commands
 */
public class PurgeBot extends ListenerAdapter {
    
    private static final String CONFIG_FILE = "purge-config.properties";
    private static final String DEFAULT_PREFIX = "!";
    private static final int MAX_PURGE_LIMIT = 100; // Discord API limit
    
    private String prefix;
    private String ownerId;
    
    public static void main(String[] args) {
        try {
            new PurgeBot().start();
        } catch (Exception e) {
            System.err.println("Failed to start PurgeBot: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public void start() throws Exception {
        Properties config = loadConfig();
        
        String token = config.getProperty("token");
        this.prefix = config.getProperty("prefix", DEFAULT_PREFIX);
        this.ownerId = config.getProperty("owner");
        
        if (token == null || token.trim().isEmpty()) {
            throw new IllegalArgumentException("Bot token is required in " + CONFIG_FILE);
        }
        
        System.out.println("===============================================");
        System.out.println("           [PURGE BOT MODULE]                ");
        System.out.println("===============================================");
        System.out.println("[+] Starting Modular Purge Bot...");
        System.out.println("[+] Prefix: " + prefix);
        System.out.println("[+] Owner ID: " + (ownerId != null ? ownerId : "Not set"));
        System.out.println();
        System.out.println("Available Commands:");
        System.out.println("  " + prefix + "purge [number]           - Purge X messages");
        System.out.println("  " + prefix + "purge [keyword]          - Purge messages with keyword");
        System.out.println("  " + prefix + "purge [number] [keyword] - Purge X messages with keyword");
        System.out.println("  " + prefix + "purgehelp                - Show purge commands help");
        System.out.println();
        System.out.println("[!] Requires MANAGE_MESSAGES permission");
        System.out.println("===============================================");
        
        JDA jda = JDABuilder.createDefault(token)
                .setMemberCachePolicy(MemberCachePolicy.VOICE)
                .enableIntents(GatewayIntent.GUILD_MESSAGES, GatewayIntent.MESSAGE_CONTENT)
                .addEventListeners(this)
                .build();
        
        jda.awaitReady();
        System.out.println("[+] Purge Bot Module is ready and connected to Discord!");
        System.out.println("[!] This module can be easily removed by stopping this process.");
        
        // Keep the bot running
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("[-] Shutting down Purge Bot Module...");
            jda.shutdown();
        }));
    }
    
    private Properties loadConfig() throws IOException {
        Properties config = new Properties();
        try (FileInputStream fis = new FileInputStream(CONFIG_FILE)) {
            config.load(fis);
        }
        return config;
    }
    
    @Override
    public void onMessageReceived(MessageReceivedEvent event) {
        // Ignore bot messages and non-guild messages
        if (event.getAuthor().isBot() || !event.isFromGuild()) {
            return;
        }
        
        String content = event.getMessage().getContentRaw();
        if (!content.startsWith(prefix)) {
            return;
        }
        
        // Remove prefix and split arguments
        String command = content.substring(prefix.length()).trim();
        String[] args = command.split("\\s+");
        
        if (args.length == 0) {
            return;
        }
        
        String cmd = args[0].toLowerCase();
        
        switch (cmd) {
            case "purge":
                handlePurgeCommand(event, args);
                break;
            case "purgehelp":
                handlePurgeHelp(event);
                break;
        }
    }
    
    private void handlePurgeCommand(MessageReceivedEvent event, String[] args) {
        // Check permissions
        if (!event.getMember().hasPermission(Permission.MESSAGE_MANAGE)) {
            event.getChannel().sendMessage("[ERROR] You need the `MANAGE_MESSAGES` permission to use purge commands.").queue();
            return;
        }
        
        if (!event.getGuild().getSelfMember().hasPermission(Permission.MESSAGE_MANAGE) ||
            !event.getGuild().getSelfMember().hasPermission(Permission.MESSAGE_HISTORY)) {
            event.getChannel().sendMessage("[ERROR] I need `MANAGE_MESSAGES` and `MESSAGE_HISTORY` permissions to purge messages.").queue();
            return;
        }
        
        if (args.length == 1) {
            // Show usage
            event.getChannel().sendMessage(
                "**Purge Command Usage:**\\n" +
                "- `" + prefix + "purge [number]` - Purge X messages (1-" + MAX_PURGE_LIMIT + ")\\n" +
                "- `" + prefix + "purge [keyword]` - Purge messages containing keyword\\n" +
                "- `" + prefix + "purge [number] [keyword]` - Purge X messages with keyword\\n\\n" +
                "**Examples:**\\n" +
                "- `" + prefix + "purge 10` - Delete last 10 messages\\n" +
                "- `" + prefix + "purge test` - Delete all messages containing 'test'\\n" +
                "- `" + prefix + "purge 5 spam` - Delete last 5 messages containing 'spam'"
            ).queue();
            return;
        }
        
        TextChannel channel = event.getChannel().asTextChannel();
        
        // Parse arguments
        int count = 0;
        String keyword = null;
        
        try {
            count = Integer.parseInt(args[1]);
            if (count <= 0 || count > MAX_PURGE_LIMIT) {
                event.getChannel().sendMessage("[ERROR] Purge count must be between 1 and " + MAX_PURGE_LIMIT).queue();
                return;
            }
            
            // Check if there's a keyword after the number
            if (args.length > 2) {
                keyword = String.join(" ", java.util.Arrays.copyOfRange(args, 2, args.length));
            }
        } catch (NumberFormatException e) {
            // First argument is not a number, treat it as keyword
            keyword = String.join(" ", java.util.Arrays.copyOfRange(args, 1, args.length));
            count = MAX_PURGE_LIMIT; // Default to max when only keyword is provided
        }
        
        // Delete the command message first
        event.getMessage().delete().queue();
        
        // Perform the purge
        if (keyword == null) {
            // Simple number purge
            purgeMessages(channel, count, null, event);
        } else {
            // Keyword-based purge
            purgeMessages(channel, count, keyword.toLowerCase(), event);
        }
    }
    
    private void purgeMessages(TextChannel channel, int maxCount, String keyword, MessageReceivedEvent originalEvent) {
        channel.getHistory().retrievePast(Math.min(maxCount, MAX_PURGE_LIMIT)).queue(messages -> {
            List<Message> messagesToDelete;
            
            if (keyword == null) {
                // Delete all retrieved messages
                messagesToDelete = messages;
            } else {
                // Filter messages by keyword
                messagesToDelete = messages.stream()
                    .filter(msg -> msg.getContentRaw().toLowerCase().contains(keyword))
                    .limit(maxCount)
                    .collect(java.util.stream.Collectors.toList());
            }
            
            if (messagesToDelete.isEmpty()) {
                String response = keyword == null ? 
                    "[ERROR] No messages found to purge." :
                    "[ERROR] No messages found containing keyword: `" + keyword + "`";
                channel.sendMessage(response).queue(msg -> 
                    msg.delete().queueAfter(5, TimeUnit.SECONDS));
                return;
            }
            
            // Discord bulk delete has a 14-day limit and minimum 2 messages
            List<Message> recentMessages = messagesToDelete.stream()
                .filter(msg -> System.currentTimeMillis() - msg.getTimeCreated().toInstant().toEpochMilli() < 1209600000L) // 14 days
                .collect(java.util.stream.Collectors.toList());
                
            int deletedCount = recentMessages.size();
            
            if (recentMessages.size() >= 2) {
                // Use bulk delete for efficiency
                channel.deleteMessages(recentMessages).queue(success -> {
                    String response = keyword == null ?
                        "[SUCCESS] Purged " + deletedCount + " messages." :
                        "[SUCCESS] Purged " + deletedCount + " messages containing: `" + keyword + "`";
                    
                    channel.sendMessage(response).queue(msg -> 
                        msg.delete().queueAfter(5, TimeUnit.SECONDS));
                }, error -> {
                    channel.sendMessage("[ERROR] Failed to purge messages: " + error.getMessage()).queue(msg ->
                        msg.delete().queueAfter(5, TimeUnit.SECONDS));
                });
            } else if (recentMessages.size() == 1) {
                // Single message delete
                recentMessages.get(0).delete().queue(success -> {
                    String response = keyword == null ?
                        "[SUCCESS] Purged 1 message." :
                        "[SUCCESS] Purged 1 message containing: `" + keyword + "`";
                    
                    channel.sendMessage(response).queue(msg -> 
                        msg.delete().queueAfter(5, TimeUnit.SECONDS));
                });
            } else {
                String response = "[ERROR] No recent messages found to purge (messages older than 14 days cannot be bulk deleted).";
                channel.sendMessage(response).queue(msg -> 
                    msg.delete().queueAfter(5, TimeUnit.SECONDS));
            }
        }, error -> {
            channel.sendMessage("[ERROR] Failed to retrieve messages: " + error.getMessage()).queue(msg ->
                msg.delete().queueAfter(5, TimeUnit.SECONDS));
        });
    }
    
    private void handlePurgeHelp(MessageReceivedEvent event) {
        String help = "**Purge Bot Module - Help**\\n\\n" +
                     "**Available Commands:**\\n" +
                     "- `" + prefix + "purge [number]` - Purge the last X messages (1-" + MAX_PURGE_LIMIT + ")\\n" +
                     "- `" + prefix + "purge [keyword]` - Purge all messages containing the keyword\\n" +
                     "- `" + prefix + "purge [number] [keyword]` - Purge X messages containing the keyword\\n" +
                     "- `" + prefix + "purgehelp` - Show this help message\\n\\n" +
                     "**Examples:**\\n" +
                     "- `" + prefix + "purge 25` - Delete the last 25 messages\\n" +
                     "- `" + prefix + "purge test` - Delete all messages containing 'test'\\n" +
                     "- `" + prefix + "purge 10 spam` - Delete the last 10 messages containing 'spam'\\n\\n" +
                     "**Requirements:**\\n" +
                     "- You need `MANAGE_MESSAGES` permission to use these commands\\n" +
                     "- Bot needs `MANAGE_MESSAGES` and `MESSAGE_HISTORY` permissions\\n" +
                     "- Messages older than 14 days cannot be bulk deleted (Discord limitation)\\n\\n" +
                     "**Note:** This is a modular feature that can be easily removed by stopping the purge bot process.";
        
        event.getChannel().sendMessage(help).queue(msg -> 
            msg.delete().queueAfter(30, TimeUnit.SECONDS));
    }
}
