import logging
import requests
import subprocess
from telegram import Update, ForceReply
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters, CallbackContext, ConversationHandler

# Enable logging
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

logger = logging.getLogger(__name__)

# Define constants for conversation states
NAME, IP, DOMAIN = range(3)

# Cloudflare credentials
CF_ID = "super.anggaaa@gmail.com"
CF_KEY = "d3e27af474728cd2c31ba76a433b1bc90cd51"

def start(update: Update, context: CallbackContext) -> int:
    """Starts the conversation and asks the user for their first name."""
    update.message.reply_text('Halo! Masukkan nama depan untuk subdomain:')
    return NAME

def name(update: Update, context: CallbackContext) -> int:
    """Stores the name and asks for the VPS IP."""
    context.user_data['nama_depan'] = update.message.text
    update.message.reply_text('Masukkan IP VPS:')
    return IP

def ip(update: Update, context: CallbackContext) -> int:
    """Stores the IP and asks for the domain."""
    context.user_data['IP'] = update.message.text
    update.message.reply_text('Pilih domain:\n1. angga.foundation\n2. caramelia.biz.id\nMasukkan nomor domain yang ingin digunakan (1-2):')
    return DOMAIN

def domain(update: Update, context: CallbackContext) -> int:
    """Stores the domain and updates DNS record."""
    domain_option = update.message.text
    if domain_option == '1':
        context.user_data['DOMAIN'] = 'angga.foundation'
    elif domain_option == '2':
        context.user_data['DOMAIN'] = 'caramelia.biz.id'
    else:
        update.message.reply_text('Pilihan tidak valid. Silakan mulai lagi dengan /start.')
        return ConversationHandler.END
    
    nama_depan = context.user_data['nama_depan']
    IP = context.user_data['IP']
    DOMAIN = context.user_data['DOMAIN']
    dns = f"{nama_depan}.{DOMAIN}"

    try:
        # Get the zone ID for the domain
        zone_response = requests.get(
            f"https://api.cloudflare.com/client/v4/zones?name={DOMAIN}&status=active",
            headers={
                "X-Auth-Email": CF_ID,
                "X-Auth-Key": CF_KEY,
                "Content-Type": "application/json"
            }
        )
        zone_id = zone_response.json()['result'][0]['id']

        # Get the DNS record ID if it exists
        record_response = requests.get(
            f"https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records?name={dns}",
            headers={
                "X-Auth-Email": CF_ID,
                "X-Auth-Key": CF_KEY,
                "Content-Type": "application/json"
            }
        )
        record_id = record_response.json()['result'][0]['id'] if record_response.json()['result'] else None

        # Create a new DNS record if it does not exist
        if not record_id:
            create_response = requests.post(
                f"https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records",
                headers={
                    "X-Auth-Email": CF_ID,
                    "X-Auth-Key": CF_KEY,
                    "Content-Type": "application/json"
                },
                json={
                    "type": "A",
                    "name": dns,
                    "content": IP,
                    "ttl": 120,
                    "proxied": False
                }
            )
            record_id = create_response.json()['result']['id']

        # Update the DNS record with the new IP
        update_response = requests.put(
            f"https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records/{record_id}",
            headers={
                "X-Auth-Email": CF_ID,
                "X-Auth-Key": CF_KEY,
                "Content-Type": "application/json"
            },
            json={
                "type": "A",
                "name": dns,
                "content": IP,
                "ttl": 120,
                "proxied": False
            }
        )

        update.message.reply_text(
            f"----------------------\n"
            f"Sukses!\n"
            f"----------------------\n"
            f"Domain : {dns}\n"
            f"IP VPS : {IP}\n"
            f"----------------------"
        )

    except Exception as e:
        logger.error(f"Error updating DNS: {e}")
        update.message.reply_text("Terjadi kesalahan saat memperbarui DNS. Silakan coba lagi nanti.")

    return ConversationHandler.END

def cancel(update: Update, context: CallbackContext) -> int:
    """Cancels and ends the conversation."""
    update.message.reply_text('Operasi dibatalkan.')
    return ConversationHandler.END

def main() -> None:
    """Run the bot."""
    # Replace 'YOUR_TOKEN' with your bot's token
    updater = Updater("7032109934:AAE2QyEtkVNxf5zQdh3OmT7BHbL6k_hQjNI")

    dispatcher = updater.dispatcher

    # Add conversation handler with the states NAME, IP, DOMAIN
    conv_handler = ConversationHandler(
        entry_points=[CommandHandler('start', start)],
        states={
            NAME: [MessageHandler(Filters.text & ~Filters.command, name)],
            IP: [MessageHandler(Filters.text & ~Filters.command, ip)],
            DOMAIN: [MessageHandler(Filters.text & ~Filters.command, domain)],
        },
        fallbacks=[CommandHandler('cancel', cancel)],
    )

    dispatcher.add_handler(conv_handler)

    # Start the Bot
    updater.start_polling()

    updater.idle()

if __name__ == '__main__':
    main()
