//
//  var json = '<%= @json %>';
//  var name = '<%= @name %>';
//  var seed = '<%= @seed %>';
//
var data = JSON.parse(json);
var qas = data['qas'];

var answer = [];
var answerelements = [];

var qadivs = [];
var images = [];

var qa_minusbutton;
var ans_minusbuttons = [];

var Crypt = new Crypt();

function answerline(i,j){
    var adiv = $('<span>');
    adiv.css('border','none');
    adiv.css('borderWidth','0');
    adiv.css('padding','0');
    adiv.css('margin',0);
    var input = $('<input>');
    if(! answerelements[i]) answerelements[i] = [];
    answerelements[i][j] = input;
    input.attr('type','text');
    input.attr('autocomplete','off');
    //input.attr('size','10');
    input.attr('qnumber',i);
    input.attr('anumber',j);
    input.val(qas[i]['answers'][j]);
    //input.css('border','solid');
    input.css('border','dotted');
    //input.css('border','dashed');
    input.css('border-width','1px');
    input.css('padding','1');
    input.css('margin','0 0 2 2');
    input.css('vertical-aign','middle');
    input.css('background-color','#ffffff');
    input.css('width','120');
    if(j == 0) input.css('background-color','#ccf');
    input.css('font-size','9pt');
    input.css('font-family','sans-serif');
    input.on('click',function(){
	    var q = Number($(this).attr('qnumber'));
	    var a = Number($(this).attr('anumber'));
	    answer[q] = a;
	    for(var i=0;i<qas[q]['answers'].length;i++){
		var e = answerelements[q][i];
		e.css('background-color',i == a ? '#ccf' : '#fff');
	    }
	    calcpass();
	});
    input.on('keyup',function(){
	    var q = Number($(this).attr('qnumber'));
	    var a = Number($(this).attr('anumber'));
	    qas[q]['answers'][a] = $(this).val();
	    calcpass();
	});
    adiv.append(input);
    return adiv;
}

function qadiv(i){
    answer[i] = 0;
    
    var div = $("<div>");
    div.css('background-color','#cee');
    div.css('padding','2');
    div.css('width','100%');
    
    var qdiv = $('<div>');
    qdiv.attr('width','100%');
    qdiv.css('width','100%');
    qdiv.css('border','none');
    qdiv.css('border-width','0');
    qdiv.css('padding','0');
    qdiv.css('margin',0);
    
    var qinput = $('<input>');
    qinput.attr('type','text');
    qinput.attr('autocomplete','off');
    qinput.css('width','100%');
    
    qinput.attr('qnumber',i);
    qinput.val(qas[i]['question']);
    qinput.css('background-color','#ffd');
    qinput.css('font-size','10pt');
    qinput.css('font-family','sans-serif');
    qinput.css('font-weight','bold');
    qinput.css('border','solid');
    qinput.css('border-width','1px');
    qinput.css('border-color','#888');
    qinput.css('padding','2');
    qinput.css('margin','0 0 2 2');
    qinput.css('vertical-aign','middle');
    qinput.on('keyup',function(){
	    var q = Number($(this).attr('qnumber'));
	    var qstr = $(this).val();
	    qas[q]['question'] = qstr;
	    if(qstr.match(/\.(png|jpeg|jpg|gif)$/i)){
		images[q].attr('src',qstr);
		images[q].css('display','block');
	    }
	    else {
		images[q].css('display','none');
	    }
	    calcpass();
	});
    
    qdiv.append(qinput);
    div.append(qdiv);
    
    var img = $("<img>");
    images[i] = img;
    img.css('float','left');
    img.css('padding','2');
    
    if(qas[i]['question'].match(/\.(gif|jpeg|jpg|png)/i)){
	img.attr('src',qas[i]['question']);
	img.css('height','100');
	img.css('display','block');
	div.append(img);
    } 
    else {
	img.css('display','none');
	div.append(img);
    }
    
    var ansdiv = $("<div>");
    ansdiv.css('float','left');
    ansdiv.css('padding','0');
    for(var j=0;j<qas[i]['answers'].length;j++){
	ansdiv.append(answerline(i,j));
    }
    
    ansdiv.append($('<span>  </span>'));
    
    var minus = $('<input>');
    minus.attr('type','button');
    minus.val(' - ');
    minus.attr('qnumber',i);
    minus.click(function(event){
	    var q = Number($(this).attr('qnumber'));
	    qas[q]['answers'].pop();
	    answerelements[q].pop().remove();
	});
    ansdiv.append(minus);
    ans_minusbuttons[i] = minus;
    
    ansdiv.append($('<span>  </span>'));
    
    var plus = $('<input>');
    plus.attr('type','button');
    plus.val(' + ')
	plus.attr('qnumber',i);
    plus.click(function(event){
	    var q = Number($(this).attr('qnumber'));
	    var nelements = answerelements[q].length;
	    qas[q]['answers'].push('新しい回答例');
	    ans_minusbuttons[q].before(answerline(q,nelements));
	});
    ansdiv.append(plus);
    
    div.append(ansdiv);
    
    var br = $('<br>');
    br.attr('clear','all');
    div.append(br);
    
    return div;
}

function maindiv(){
    // ブラウザから「別名で保存」すると #main に入れたデータが全部格納されて
    // しまうので、最初に全部消しておく
    $("#main").children().remove();

    for(i=0;i<qas.length;i++){
	div = qadiv(i);
	qadivs[i] = div;
	$("#main").append(div);
    }
    
    var minus = $('<input>');
    qa_minusbutton = minus;
    minus.attr('type','button');
    minus.val(' - ');
    minus.attr('qnumber',i);
    minus.css('width','50');
    minus.click(function(event){
	    qas.pop();
	    qadivs.pop().remove();
	    calcpass();
	});
    $("#main").append(minus);
    
    $("#main").append($('<span>  </span>'));
    
    var plus = $('<input>');
    plus.attr('type','button');
    plus.val(' + ');
    plus.attr('qnumber',i);
    plus.css('width','50');
    plus.click(function(event){
	    var dummy = {};
	    dummy.question = "新しい質問";
	    dummy.answers = ["回答11","回答22","回答33"];
	    qas.push(dummy);
	    var newqadiv = qadiv(qadivs.length);
	    qadivs.push(newqadiv);
	    qa_minusbutton.before(newqadiv);
	    calcpass();
	});
    $("#main").append(plus);
}

function secretstr(){
    var secret = "";
    for(var i=0;i<qas.length;i++){
	secret += qas[i]['question'];
	secret += qas[i]['answers'][answer[i]];
    }
    return secret;
}

function calcpass(){
    var newpass = Crypt.crypt($('#seed').val(),secretstr());
    $('#pass').val(newpass);
}

function calcseed(){
    var newseed = Crypt.crypt($('#pass').val(),secretstr());
    $('#seed').val(newseed);
    data['seed'] = newseed;
}

function sendfile(files){
    var file = files[0];

    // ファイルの内容は FileReader で読み込みます.
    var fileReader = new FileReader();
    fileReader.onload = function(event) {
	// event.target.result に読み込んだファイルの内容が入っています.
	// ドラッグ＆ドロップでファイルアップロードする場合は result の内容を Ajax でサーバに送信しましょう!
	json = event.target.result;

	$.ajax({
		url: "/" + name + "/__upload",
		    type: "POST",
		    data: fd,
		    processData: false,
		    contentType: false,
		    dataType: 'text',
		    error: function(XMLHttpRequest, textStatus, errorThrown) {
		    // 通常はここでtextStatusやerrorThrownの値を見て処理を切り分けるか、
		    // 単純に通信に失敗した際の処理を記述します。
		    alert('upload fail');
		    this; // thisは他のコールバック関数同様にAJAX通信時のオプションを示します。
		},
		    success: function(d) {
		    $("#main").children().remove();
		    data = JSON.parse(json);
		    qas = data['qas'];
		    maindiv();
		    calcpass();
		}
	    });
    }
    fileReader.readAsText(file);

    var fd = new FormData;
    fd.append('uploadfile', file);
    return false;
}

function init(){
    $('#seed').keyup(function(e){
	    data['seed'] = $('#seed').val();
	    calcpass();
	});
    
    $('#pass').keyup(function(e){
	    calcseed();
	});
    
    $("#save").click(function(){
	    $.ajax({
		    type: "POST",
			async: true,
			url: "/" + name + "/__write",
			data: "data=" + JSON.stringify(data)
			});
	});
    
    $('#seed').val(seed);

    $('#qa_json').click(function(event){
	    event.preventDefault();
	    location.href = 'data:application/json;charset=utf-8,' + JSON.stringify(data);
	});

    // Drag&Drop対応
    var b = $('body');
    b.bind("dragover", function(e) {
	    return false;
    	});
    b.bind("dragend", function(e) {
	    return false;
    	});
    b.bind("drop", function(e) {
            var files;
            e.preventDefault(); // デフォルトは「ファイルを開く」
            files = e.originalEvent.dataTransfer.files;
            sendfile(files);
            return false;
        });

    maindiv();
    calcpass();
}

init();