#!/bin/bash
# Created BY MY-ANGGA

# Fungsi untuk menampilkan animasi loading
loading_animation() {
    echo -ne 'Loading...\r'
    sleep 0.3
    echo -ne 'Loading.. \r'
    sleep 0.3
    echo -ne 'Loading.  \r'
    sleep 0.3
    echo -ne 'Loading...'
    sleep 0.3
    echo -ne '           \r'  # Clear the line
}

# Fungsi untuk menambahkan IP ke file ipseller.txt di hosting
add_ip() {
    clear
    echo "╭───────────────────────────────────────╮"
    echo "│             TAMBAH IP VPS             │"
    echo "╰───────────────────────────────────────╯"
    echo
    read -p "Masukkan nama: " nama
    read -p "Masukkan IP: " ip
    echo
    echo "Pilih opsi tanggal:"
    echo "1. 30 hari"
    echo "2. 60 hari"
    echo "3. 90 hari"
    echo "4. Custom"
    echo
    read -p "Pilih opsi [1-4]: " option

    case $option in
        1) tanggal=$(date -d "+30 days" +%Y-%m-%d) ;;
        2) tanggal=$(date -d "+60 days" +%Y-%m-%d) ;;
        3) tanggal=$(date -d "+90 days" +%Y-%m-%d) ;;
        4)
            read -p "Masukkan jumlah hari: " custom_days
            if [[ ! $custom_days =~ ^[0-9]+$ ]]; then
                echo "Jumlah hari tidak valid."
                return
            fi
            tanggal=$(date -d "+${custom_days} days" +%Y-%m-%d)
            ;;
        *) echo "Pilihan tidak valid."; return ;;
    esac

    data="### $nama $tanggal $ip"
    response=$(curl -s --data-urlencode "data=$data" https://anggaalfa.my.id/LandeanVPN/add_ip.php)

    echo
    echo "╭───────────────────────────────────────────────╮"
    echo "│                  HASIL OPERASI                │"
    echo "╰───────────────────────────────────────────────╯"

    # Menampilkan response dengan garis pembatas di atas dan bawah
    echo "╭───────────────────────────────────────────────╮"
    echo "│ $response"
    echo "╰───────────────────────────────────────────────╯"

    if [ "$response" = "IP sudah terdaftar." ]; then
        # Menampilkan pesan bahwa IP sudah terdaftar
        echo "╭───────────────────────────────────────────────╮"
        echo "│ IP sudah terdaftar sebelumnya.                │"
        echo "╰───────────────────────────────────────────────╯"
    else
        # Menampilkan detail IP yang telah didaftarkan
        echo "╭───────────────────────────────────────────────╮"
        echo "│ Berikut adalah detail IP yang didaftarkan:    │"
        echo "├───────────────────────────────────────────────┤"
        echo "│ Nama:      $nama"
        echo "│ IP:        $ip"
        echo "│ Expired:   $tanggal"
        echo "╰───────────────────────────────────────────────╯"
        # Send notification to Telegram
        telegram_bot_token="7018756220:AAGNCSgUiju15ZgFqGFLQw7m4cCPzW03hyc"
        telegram_chat_id="5196612474"
        message="╭────────────────────╮
│ 🎉 *IP baru telah di daftarkan:*
├────────────────────┤
│ 👤 *Nama:*         \`$nama\`
│ 🌐 *IP:*                 \`$ip\`
│ 📅 *Expired:*      \`$tanggal\`
╰────────────────────╯"
        curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" \
        -d chat_id="$telegram_chat_id" \
        -d text="$message" \
        -d parse_mode="MarkdownV2" > /dev/null
    fi

    read -p "Klik Enter untuk kembali ke menu..."
    clear
}

main_menu() {
    clear
    echo "╭───────────────────────────────────────╮"
    echo "│            MENU UTAMA VPS             │"
    echo "╰───────────────────────────────────────╯"
    echo "1. Tambah IP VPS"
    echo "2. Perbarui Expired IP VPS"
    echo "3. Keluar"
    echo
    read -p "Pilih opsi [1-3]: " main_option

    case $main_option in
        1) add_ip ;;
        2) update_expired_ip ;;
        3) exit ;;
        *) echo "Pilihan tidak valid."; sleep 2; main_menu ;;
    esac
}

# Fungsi untuk menghapus IP dari file listip.txt di hosting
delete_ip() {
    clear
echo "╭───────────────────────────────────────────╮"
echo "│              HAPUS IP VPS                 │"
echo "╰───────────────────────────────────────────╯"
echo
read -p "Masukkan IP yang akan dihapus: " ip
echo

if [ -z "$ip" ]; then
    read -p "Klik Enter untuk kembali ke menu..."
    clear
    exit
fi

response=$(curl -s --data-urlencode "ip=$ip" https://anggaalfa.my.id/LandeanVPN/delete_ip.php)

echo
echo "╭───────────────────────────────────────────╮"
echo "│              HASIL OPERASI                │"
echo "╰───────────────────────────────────────────╯"
echo "$response"
echo "───────────────────────────────────────────"

read -p "Klik Enter untuk kembali ke menu..."
clear
}

# Fungsi untuk merenew IP dalam file ipseller.txt di hosting
update_expired_ip() {
    clear
    echo "╭───────────────────────────────────────╮"
    echo "│         PERBARUI EXPIRED IP VPS       │"
    echo "╰───────────────────────────────────────╯"
    echo
    read -p "Masukkan IP: " ip
    echo
    echo "Pilih opsi perpanjangan tanggal:"
    echo "1. 30 hari"
    echo "2. 60 hari"
    echo "3. 90 hari"
    echo "4. Custom"
    echo
    read -p "Pilih opsi [1-4]: " option

    case $option in
        1) tanggal=$(date -d "+30 days" +%Y-%m-%d) ;;
        2) tanggal=$(date -d "+60 days" +%Y-%m-%d) ;;
        3) tanggal=$(date -d "+90 days" +%Y-%m-%d) ;;
        4)
            read -p "Masukkan jumlah hari: " custom_days
            if [[ ! $custom_days =~ ^[0-9]+$ ]]; then
                echo "Jumlah hari tidak valid."
                return
            fi
            tanggal=$(date -d "+${custom_days} days" +%Y-%m-%d)
            ;;
        *) echo "Pilihan tidak valid."; return ;;
    esac

    data="### update $tanggal $ip"
    response=$(curl -s --data-urlencode "data=$data" https://anggaalfa.my.id/LandeanVPN/update_expired_ip.php)

    echo
    echo "╭───────────────────────────────────────────────╮"
    echo "│                  HASIL OPERASI                │"
    echo "╰───────────────────────────────────────────────╯"

    # Menampilkan response dengan garis pembatas di atas dan bawah
    echo "╭───────────────────────────────────────────────╮"
    echo "│ $response"
    echo "╰───────────────────────────────────────────────╯"

    if [ "$response" = "IP tidak ditemukan." ]; then
        # Menampilkan pesan bahwa IP tidak ditemukan
        echo "╭───────────────────────────────────────────────╮"
        echo "│ IP tidak ditemukan.                           │"
        echo "╰───────────────────────────────────────────────╯"
    else
        # Menampilkan detail IP yang telah diperbarui
        echo "╭───────────────────────────────────────────────╮"
        echo "│ Berikut adalah detail IP yang diperbarui:     │"
        echo "├───────────────────────────────────────────────┤"
        echo "│ IP:        $ip"
        echo "│ Expired:   $tanggal"
        echo "╰───────────────────────────────────────────────╯"
    fi

    read -p "Klik Enter untuk kembali ke menu..."
    clear
}

# Fungsi untuk menampilkan daftar IP yang sudah terdaftar
display_registered_ips() {
    clear
    echo "╭─────────────────────────────────────────────────────╮"
    echo "│               LIST VPS yang Terdaftar               │"
    echo "╰─────────────────────────────────────────────────────╯"
    loading_animation
    # Mendapatkan data dari URL
    data=$(curl -s http://anggaalfa.my.id/LandeanVPN/daftar-ip.txt)

    # Memisahkan data menjadi reseller dan member
    reseller_data=""
    member_data=""
    reseller_count=0
    member_count=0
    while IFS= read -r line; do
        name=$(echo "$line" | awk '{print $2}')
        date=$(echo "$line" | awk '{print $3}')
        ip=$(echo "$line" | awk '{print $4}')
        if [[ $line == *" ON" ]]; then
            ((reseller_count++))
            reseller_data+="│ $reseller_count. $name $date $ip\n"
        else
            ((member_count++))
            member_data+="│ $member_count. $name $date $ip\n"
        fi
    done <<< "$data"

    # Menampilkan data reseller
    if [ -n "$reseller_data" ]; then
        echo "╭─────────────────────────────────────────────────────╮"
        echo "│                       RESELLER                      │"
        echo "├─────────────────────────────────────────────────────╯"
        echo -e "$reseller_data"
    else
        echo "│ Tidak ada data reseller yang terdaftar.            │"
    fi

    # Menampilkan data member
    if [ -n "$member_data" ]; then
        echo "╭─────────────────────────────────────────────────────╮"
        echo "│                       MEMBER                        │"
        echo "├─────────────────────────────────────────────────────╯"
        echo -e "$member_data"
    else
        echo "│ Tidak ada data member yang terdaftar.              │"
    fi
    read -p " Klik Enter untuk kembali ke menu..."
    clear
}

# Fungsi untuk menampilkan menu
show_menu() {
    clear
    echo "╭─────────────────────────────────────────╮"
    echo "│       MENU REGIS IP LandeanVPN          │"
    echo "├─────────────────────────────────────────┤"
    echo "│ 1. Daftar IP VPS                        │"
    echo "│ 2. Hapus IP VPS                         │"
    echo "│ 3. Renew IP VPS                         │"
    echo "│ 4. IP VPS Terdaftar                     │"
    echo "│ 5. Keluar                               │"
    echo "╰─────────────────────────────────────────╯"
}


# Fungsi untuk menampilkan animasi saat masuk menu
menu_animation() {
    clear
    echo -ne '\e[1;32mWelcome to the IP Registration Tool\e[0m\n'
    echo -ne 'Loading'
    for i in {1..3}; do
        echo -ne '.'
        sleep 0.4
    done
    echo -ne '\r                  \r'  # Clear the line
}

# Loop untuk menampilkan menu dan meminta input dari pengguna
while true; do
    menu_animation
    show_menu
    read -p "Pilih menu [1-4]: " choice
    case $choice in
        1) add_ip ;;
        2) delete_ip ;;
        3) update_expired_ip ;;
        4) display_registered_ips ;;
        5) 
            echo "========================================="
            echo "    Terima kasih telah menggunakan tools ini."
            echo "========================================="
            break ;;
        *) 
            echo "Pilihan tidak valid."
            read -p "Klik Enter untuk kembali ke menu..."
            clear ;;
    esac
done
