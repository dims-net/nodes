const net = require('net');
const fs = require('fs');
const base64 = require('base-64');

// Fungsi untuk memeriksa koneksi
async function checkConnection(url) {
    try {
        let ip, port;

        if (url.startsWith('vless') || url.startsWith('trojan')) {
            const config = url.split("@")[1].split('?')[0];
            [ip, port] = config.split(':');
        } else if (url.startsWith('ss')) {
            const config = url.split("@")[1].split('#')[0];
            [ip, port] = config.split(':');
        } else if (url.startsWith('vmess')) {
            const config = JSON.parse(base64.decode(url.slice(8)));
            ip = config.add;
            port = config.port;
        } else {
            return false;
        }

        return await new Promise((resolve, reject) => {
            const socket = new net.Socket();
            socket.setTimeout(5000);
            socket.connect(port, ip, () => {
                socket.end();
                resolve(true);
            });
            socket.on('error', () => resolve(false));
            socket.on('timeout', () => {
                socket.destroy();
                resolve(false);
            });
        });
    } catch (error) {
        return false;
    }
}

// Fungsi untuk menguji semua URL
async function testAll(urls) {
    const results = await Promise.all(urls.map(url => checkConnection(url)));
    return results;
}

// Fungsi untuk menyimpan URL dengan ping terbaik ke file teks
async function saveBestPing(urls, results, filePath) {
    const bestUrls = urls.filter((url, index) => results[index]);
    fs.writeFileSync(filePath, bestUrls.join('\n') + '\n');
}

// Membaca URL dari file All
const urls = fs.readFileSync('All', 'utf-8').split('\n').filter(Boolean);

// Menguji semua URL dan menyimpan hasilnya
testAll(urls)
    .then(results => saveBestPing(urls, results, 'best-ping.txt'))
    .catch(error => console.error(error));
