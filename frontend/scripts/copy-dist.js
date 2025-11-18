const fs = require('fs');
const path = require('path');

const projectRoot = path.resolve(__dirname, '..');
const dist = path.join(projectRoot, 'dist');
const target = path.join(projectRoot, '..', 'public', 'assets');

function cleanFolder(folder) {
    if (!fs.existsSync(folder)) return;
    fs.readdirSync(folder).forEach(file => {
        const curPath = path.join(folder, file);
        if (fs.lstatSync(curPath).isDirectory()) {
            cleanFolder(curPath);
            fs.rmdirSync(curPath);
        } else {
            fs.unlinkSync(curPath);
        }
    });
}

function copyRecursive(src, dest) {
    const stats = fs.statSync(src);
    if (stats.isDirectory()) {
        if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });
        fs.readdirSync(src).forEach(entry => {
            copyRecursive(path.join(src, entry), path.join(dest, entry));
        });
    } else if (stats.isFile()) {
        fs.copyFileSync(src, dest);
    }
}

// очистка содержимого, но не самой папки - собирал в Windows, не смог разобраться с нормальным удалением, удаление папки выдавало EBUSY
cleanFolder(target);

copyRecursive(dist, target);

console.log(`Copied ${dist} -> ${target} preserving folder structure`);
