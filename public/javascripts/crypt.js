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

// crypt(crypt(s,data),data) == s になる
function crypt(str,seeddata){
    var hash = MD5_hexhash(seeddata);
    var res = "";
    for(i=0;i<str.length;i++){
	var j = i % 8;
	var s = hash.substring(j*4,j*4+4);
	var n = parseInt(s,16);
	res += crypt_char(str[i],n+i);
    }
    return res;
}
