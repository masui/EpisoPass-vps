var width, height;

var seed, qas, answers;

var mousediv = null;
var mousedown = false;

var selected = [];

var finished = false;

var page = 0;

var data; // JSONデータ

var browserWidth = function(){  
    if(window.innerWidth){ return window.innerWidth; }  
    else if(document.body){ return document.body.clientWidth; }  
    return 0;  
};

var browserHeight = function(){  
    if(window.innerHeight){ return window.innerHeight; }  
    else if(document.body){ return document.body.clientHeight; }  
    return 0;  
};


function display(){ // n番目の問題と答リストを設定
    if(page < qas.length){
	var question = qas[page].question;
	$('#question').text(question);
	answers = qas[page].answers;
	for(var i=0;i<answers.length;i++){
	    $(`#id${i}`).text(answers[i]);
	}
    }
}

function select(s){
    if(page < qas.length){
	selected.push(s);
    }
    if(page+1 == qas.length){
	finished = true;
    }
}

function finish(){
    $('body').children().remove();

    // パスワードを表示!!
    var newpass = exports.crypt(seed,secretstr());
    var center = $('<center>');
    $('body').append(center);
    var passspan = $('<span>');
    passspan.text(newpass);
    passspan.css('font-size',width * 0.08);
    center.append(passspan);
    
    center.append($('<p>'));

    var input = $('<input>');
    input.attr('type','button');
    input.attr('value','もう一度');
    input.css('font-size',width*0.05);
    input.css('border-radius',width*0.015);
    input.css('margin',width*0.01);
    input.css('padding',width*0.02);
    input.click(function(event){
        init();
    });
    center.append(input);
}

secretstr = function() {
    var j, ref, results;
    return (function() {
	results = [];
	for (var j = 0, ref = qas.length; 0 <= ref ? j < ref : j > ref; 0 <= ref ? j++ : j--){ results.push(j); }
	return results;
    }).apply(this).map(function(i) {
	return qas[i].question + qas[i]['answers'][selected[i]];
    }).join('');
};

function initsize(){
    width = browserWidth();
    height = browserHeight();
    for(var i=0;i<answers.length;i++){
	div = $(`#id${i}`);
	div.css('background-color','#ccc');
	div.css('width',width / 6.5);
	div.css('height',height / 9);
	div.css('font-size',width * 0.04);

	// FlexBoxでセンタリング
	div.css('display','flex');
	div.css('justify-content','center');
	div.css('align-items','center');

	div.css('margin',width / 100);
	div.css('padding',width / 100);
	div.css('border',0);
	div.css('border-radius',width*0.01);
	div.css('box-shadow','5px 5px 4px #888');
    }
    $('#question').css('font-size',width * 0.06);
}

function init(){
    // 引数解析、JSON読み出し
    var name = location.search.substring(1);
    namehash = exports.MD5_hexhash(name);
    $.ajax({
	    url: `./data/${namehash}`,
		dataType: 'json',
		async: false,
		success: function(json) {
		// alert(json.seed);
		data = json;
	    }
	});
    
    seed = data['seed'];
    qas = data['qas'];
    page = 0;
    
    mousediv = null;
    mousedown = false;
    selected = [];
    finished = false;

    $(window).on('resize',initsize);

    $('body').css('margin',0);
    $('body').css('padding',0);
    $('body').css('border',0);
    $('body').children().remove();
    
    var center = $('<center>');
    $('body').append(center);

    // 問題領域
    var qdiv = $('<div>');
    qdiv.text('...');
    qdiv.height(100);
    qdiv.css('display','flex');
    qdiv.css('justify-content','center');
    qdiv.css('align-items','center');
    qdiv.attr('id','question');
    center.append(qdiv);

    center.append($('<p>'));

    // 回答領域
    answers = qas[0].answers; // 回答の数は同じということを仮定
    for(var i=0;i<answers.length;i++){
	var div = $('<div>');
	div.css('float','left');
	div.attr('index',i);
	div.attr('id',`id${i}`);
	center.append(div);
	div.on('mouseenter',function(e){
	    mousediv = $(e.target);
	    if(mousedown){
		mousediv.css('background-color','#f3f3f3');
 		select(mousediv.attr('index'));
	    }
	});
	div.on('mouseleave',function(e){
	    mousediv = null;
	    if(mousedown){
		if(finished){
		    finish();
		}
		else {
		    if(selected.length > 0){
			$(`#id${selected[selected.length-1]}`).css('background-color','#ccc');
		    }
		    page += 1;
		    display();
		}
	    }
	});
	div.on('mousemove',function(e){
	    e.preventDefault();
	});
	div.on('touchmove',function(e){
	    e.preventDefault();
	});
	div.on('mousedown',function(e){
	    e.preventDefault();
	    mousedown = true;
	    if(mousediv){
		mousediv.css('background-color','#f3f3f3');
		select(mousediv.attr('index'));
	    }
	});
	div.on('touchstart',function(e){
	    e.preventDefault();
	    mousedown = true;
	    if($(e.target)){
		mousediv = $(e.target);
	    }
	    if(mousediv){
		mousediv.css('background-color','#f3f3f3');
		select(mousediv.attr('index'));
	    }
	});
	div.on('mouseup',function(e){
	    if(finished){
		finish();
	    }
	    else {
		e.preventDefault();
		if(mousedown){
		    if(selected.length > 0){
			$(`#id${selected[selected.length-1]}`).css('background-color','#ccc');
		    }
		    page += 1;
		    display();
		}
	    }
	    mousedown = false;
	});
	div.on('touchend',function(e){
	    if(finished){
		finish();
	    }
	    else {
		e.preventDefault();
		if(mousedown){
		    if(selected.length > 0){
			$(`#id${selected[selected.length-1]}`).css('background-color','#ccc');
		    }
		    page += 1;
		    display();
		}
	    }
	    mousedown = false;
	});
    }

    initsize();
    display();
}

$(function() {
    init();
});
