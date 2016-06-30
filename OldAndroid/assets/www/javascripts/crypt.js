//
// crypt.js - EpisoPassでの文字置換
//
// Toshiyuki Masui @ Pitecan.com
// Last Modified: 2013/06/23 11:21:21
//
// var Crypt = new Crypt();
// Crypt.crypt(str,seed)

var Crypt = function(){
    //  文字種ごとに置換を行なうためのテーブル
    var charset = [
		   'abcdefghijklmnopqrstuvwxyz',
		   'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		   '0123456789',
		   '-',
		   '~!@#$%^&*()_=+[{]}|;:.,/?',
		   ' '
		   ];
    
    var charkind = function(c){
	for(var i=0;i<charset.length;i++){
	    if(charset[i].indexOf(c) >= 0) return i;
	}
	return null;
    }
    
    // crypt_char(crypt_char(c,n),n) == c になるような文字置換関数
    var crypt_char = function(c,n){
	var kind = charkind(c);
	var chars = charset[kind];
	var cind = chars.indexOf(c);
	var len = chars.length;
	var ind = (n - cind + len) % len;
	return chars[ind];
    }
    
    // UTF8文字列をバイト文字列(?)に変換
    // (MD5_hexhashがUTF8データをうまく扱えないため)
    var utf2bytestr = function(text) {
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
    this.crypt = function(str,seeddata){
	// seeddataのMD5の32バイト値の一部を取り出して数値化し、
	// その値にもとづいて文字置換を行なう
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
};
