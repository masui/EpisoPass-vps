var charset = [
	       'abcdefghijklmnopqrstuvwxyz',
               'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
               '0123456789',
               '-',
               '~!@#$%^&*()_=+[{]}|;:.,/?'
	       ];

function charkind(c){
    for(var i=0;i<charset.length;i++){
	if(charset[i].indexOf(c) >= 0) return i;
    }
    return null;
}

// crypt_char(crypt_char(c,n),n) == c になる
function crypt_char(c,n){
    var kind = charkind(c);
    var chars = charset[kind];
    var cind = chars.indexOf(c);
    var len = chars.length;
    var ind = (n - cind + len) % len;
    return chars[ind];
}

function utf2bytearray(text) {
    var result = [];
    if (text == null)
        return result;
    for (var i = 0; i < text.length; i++) {
        var c = text.charCodeAt(i);
        if (c <= 0x7f) {
            result.push(c);
        } else if (c <= 0x07ff) {
            result.push(((c >> 6) & 0x1F) | 0xC0);
            result.push((c & 0x3F) | 0x80);
        } else {
            result.push(((c >> 12) & 0x0F) | 0xE0);
            result.push(((c >> 6) & 0x3F) | 0x80);
            result.push((c & 0x3F) | 0x80);
        }
    }
    return result;
}

function utf2bytestr(text) {
    var result = "";
    if (text == null)
        return result;
    for (var i = 0; i < text.length; i++) {
        var c = text.charCodeAt(i);
        if (c <= 0x7f) {
            result += String.fromCharCode(c);
        } else if (c <= 0x07ff) {
            result += String.fromCharCode(((c >> 6) & 0x1F) | 0xC0);
            result += String.fromCharCode((c & 0x3F) | 0x80);
        } else {
            result += String.fromCharCode(((c >> 12) & 0x0F) | 0xE0);
            result += String.fromCharCode(((c >> 6) & 0x3F) | 0x80);
            result += String.fromCharCode((c & 0x3F) | 0x80);
        }
    }
    return result;
}

// crypt(crypt(s,data),data) == s になる
function crypt(str,seeddata){
    var hash = MD5_hexhash(utf2bytestr(seeddata));
    var res = "";
    for(i=0;i<str.length;i++){
	var j = i % 8;
	var s = hash.substring(j*4,j*4+4);
	var n = parseInt(s,16);
	res += crypt_char(str[i],n+i);
    }
    return res;
}



