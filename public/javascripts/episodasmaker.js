//
// EpisoDASのDASパタンを入力させてJSON生成
//

var width, height;

var qas, answers;
var name;
var seed;

var mousediv = null;
var mousedown = false;

var selections;
var selected = [];

var finished = false;

var page = 0;

var arg = {};

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

function select(s){
    if(page < qas.length){
	selected.push(s);
    }
    if(page+1 == qas.length){
	finished = true;
    }
}

function shuffle(array){
    for(var i = array.length - 1; i > 0; i--){
	var r = Math.floor(Math.random() * (i + 1));
	var tmp = array[i];
	array[i] = array[r];
	array[r] = tmp;
    }
}

function finish(){
    //save = () ->
    //data['seed'] = $('#seed').val()
    //    $.ajax
    //type: "POST"
    //async: true
    //url: "/#{name}/__write"
    //data: "data=#{JSON.stringify(data)}"

    // シャフルしたJSONを作成
    for(var i = 0; i < selected.length; i++){
	var answers = data.qas[i].answers;
	var rightanswer = answers[selections[i]];
	shuffle(answers);
	var curanswer = answers[selected[i]];
	if(curanswer != rightanswer){
	    for(var j = 0; j < answers.length; j++){
		if(answers[j] == rightanswer){
		    answers[j] = curanswer;
		    answers[selected[i]] = rightanswer;
		    break;
		}
	    }
	}
    }
    jsonstr = JSON.stringify(data) ;

    $.ajax({
	    type: "POST",
		async: true,
		url: `/${name}/__write`,
				   data: `data=${jsonstr}`
									  });
    alert('DASサイトを生成しました。移動します。');
    location.href = `/DAS/${name}/${seed}`;
    return;

    $('body').children().remove();

    // Data URI scheme
    var datatext = "data:application/json;base64," +
	btoa(unescape(encodeURIComponent(jsonstr)));
    var a = $('<a>');
    a.attr('href',datatext);
    a.text('JSON data');
    a.css('margin',10);
    $('body').append(a);

    $('body').append($('<p>'));

    var div = $('<div>');
    div.attr('font-size',width*0.002);
    div.text(jsonstr);
    div.css('margin',10);
    $('body').append(div);
}

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
    // GET引数解析
    var argstr = location.search.substring(1);
    argstr.split('&').map(function(s){
	    var kv = s.split('=');
	    arg[kv[0]] = kv[1];
	});
    name = arg['name'];
    seed = arg['seed'];
    selections = arg['selections'].split(',');
    
    // JSON読み出し
    namehash = exports.MD5_hexhash(name);
    $.ajax({
	    url: `./data/${namehash}`,
		dataType: 'json',
		async: false,
		success: function(json) {
		data = json;
	    }
	});

    if(!seed) data['seed'] = seed;
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

    // 
    var qdiv = $('<div>');
    qdiv.text('DASパタンを入力して下さい');
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
		}
	    }
	    mousedown = false;
	});
    }

    initsize();
}

$(function() {
    init();
});
