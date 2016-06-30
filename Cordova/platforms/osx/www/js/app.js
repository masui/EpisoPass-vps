//
//
//

//if(json == '###JSON###' && false){
//    json = '{"qas":[{"answers":["西崎","櫛田","日下部","塩田","河野","水田","妹尾","三浦","野口","西山","岸野","堀井","板尾","今田","海老沢","米山","郷田","芳賀","中園","ふくち"],"question":"汚い乱暴者は?"},{"answers":["0798","7799","1233","9876","2525","4553","3435","2301","3678","5838","6594","9008","3904","2381","2435","6253","3238","7473"],"question":"祖母宅の昔の電話番号は?"},{"question":"かるたで負けたのは?","answers":["仲西","野口","村上","覚前","手島","西水","結城","岩田","勝谷","高田","和田","川村"]},{"question":"関学に行きたいと言ってたのは?","answers":["西崎","櫛田","日下部","塩田","河野","水田","妹尾","三浦","野口","西山","岸野","堀井","板尾","今田","海老沢","米山","郷田","芳賀","中園"]},{"question":"好きな六甲山のコースは?","answers":["保久良山","トウェンティクロス","四十八滝","杣谷","魚屋道","徳川道","紅葉谷","奥池","サンライズ"]},{"question":"BBQに連れていってもらったのは?","answers":["浜甲子園","千刈","武庫川","雨ヶ峠","箕面","北山ダム","雪彦山","逆瀬川","道場","木津川","曽爾高原","夙川"]},{"question":"トランペットを指導してたのは?","answers":["山本先生","守屋先生","水口先生","波多野先生","田結庄先生","打越先生","村上先生","鈴木先生","伊藤先生","藤原先生","若松先生","清水先生"]},{"question":"鉄条網で足を怪我したのは?","answers":["高木町","門戸西町","門戸荘","下大市","神呪町","字中谷","若松町","岡田山","上甲東園","段上","上ヶ原","新甲陽","甲東園","上大市"]},{"question":"http://gyazo.com/ac515f5ce991b516e785122dd9192dd2.png","answers":["妹尾","竹田","田村","松丸","藤崎","三浦","東海","小野田","西条","山肩"]}],"seed":"Twitter123456"}';
//}

//if(name == '###NAME###'){
//    name = 'masui';
//}

var data;

var width, height, size;

var state = 0; // 0:init 1: QA 2: result
var qno = 0; // いくつめの問題か

var body;
var answer = [];
var seed;
var firsttime = true;

var Crypt;

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

var display = function(){
    body  = $('body');
    
    window.devicePixelRatio = 1.0;
    
    width = browserWidth();
    height = browserHeight();
    size = (width + height) / 2;
    
    
    body.children().remove();
    
    var center;
    if(state == 0){
        center = $('<center>');
        body.append(center);
	
	var image = $('<img>');
	image.attr('src',"img/episopass.png");
	image.css('vertical-align','middle');
	center.append(image);
	
        //var namespan = $('<span>');
        //namespan.text(' ' + name);
        //namespan.css('font-size',size * 0.08);
	//namespan.css('vertical-aligh','middle');
        //center.append(namespan);
	
        center.append($('<p>'));
	
	seed = data['seed'];
	if(!firsttime && window.localStorage.length > 1){
	    // seed = "";
	}
	firsttime = false;
	
        //var seedspan = $('<span>');
        //seedspan.text('Seed = ');
        //seedspan.css('font-size',size * 0.08);
        //center.append(seedspan);
        var seedinput = $('<input>');
        seedinput.attr('type','text');
        seedinput.attr('size','12');
	seedinput.attr('value',seed);
        seedinput.css('font-size',size * 0.08);
	
	// seedのオートコンプリート
	// http://zxcvbnmnbvcxz.com/form-improvement-2-10/
	var candidates = [];
	for(var i=0;i<window.localStorage.length;i++){
	    candidates.push(window.localStorage.key(i));
	}
	seedinput.autocomplete({
	    source: candidates
	});
	
        center.append(seedinput);
	
        center.append($('<p>'));
	
        var startbutton = $('<input>');
        startbutton.attr('type','button');
        startbutton.attr('value','Start');
        startbutton.css('font-size',size*0.08);
        startbutton.css('border-radius',size*0.015);
        startbutton.css('margin',size*0.03);
        startbutton.css('padding',size*0.01);
        startbutton.on('click',function(event){
	    event.preventDefault();
	    seed = seedinput.val();
	    qno = 0;
	    state = 1;
	    
	    window.localStorage.setItem(seed,"seed");
	    
	    display();
	});
        center.append(startbutton);
    }
    else if(state == 1){
	var qtext = data['qas'][qno]['question'];
	var localimage = data['qas'][qno]['localimage'];
	
        center = $('<center>');
        body.append(center);
	
	var imagediv;

	if(localimage){ // 動的アプリのとき
	    imagediv = $('<img>');
	    imagediv.attr('src',localimage);
	    imagediv.css('width',width*0.4);
	    center.append(imagediv);
	}
	else if(a = qtext.match(/\/([^\/]+\.(gif|png|jpg|jpeg))$/i)){
	    imagediv = $('<img>');
	    imagediv.css('width',width*0.4);
	    center.append(imagediv);
	    
	    function img_gotFS(fileSystem) {
		fileSystem.root.getDirectory("EpisoPass", {create: true, exclusive: false}, img_onGetDirectoryWin, img_onGetDirectoryFail);
	    }
	    var img_onGetDirectoryWin = function(parent) {
		parent.getFile(a[1], {create: false, exclusive: false}, img_gotFileEntry, img_fail);
	    };
	    var img_onGetDirectoryFail = function(){};
	    var img_gotFileEntry = function(fileEntry){
		fileEntry.file(img_gotFile, fail);
	    };
	    var img_gotFile = function(file){
		var reader = new FileReader();
		reader.onloadend = function(evt){
		    imagediv.attr('src',evt.target.result);
		};
		reader.readAsDataURL(file);
	    };
	    var img_fail = function(error) {
		console.log(error.code);
	    };
	    imagediv.attr('src',qtext);
	}
	else {
	    var questiondiv = $('<div>');
	    questiondiv.text(qtext);
	    questiondiv.css('background-color','#ccc');
	    questiondiv.css('width',width * 0.9);
	    questiondiv.css('font-size',size * 0.08);
	    questiondiv.css('margin',size*0.03);
	    questiondiv.css('padding',size*0.02);
	    questiondiv.css('margin','0 auto');
	    center.append(questiondiv);
	}
        center.append($('<p>'));
        var answersdiv = $('<div>');
        center.append(answersdiv);
	
        var answers = data['qas'][qno]['answers'];
        for(var i=0;i<answers.length;i++){
            var input = $('<input>');
            input.attr('type','button');
            input.attr('value',answers[i]);
	    input.attr('anumber',i);
            input.css('font-size',size*0.07);
            input.css('border-radius',size*0.015);
            input.css('margin',size*0.01);
            input.css('padding',size*0.005);
            input.click(function(event){
		event.preventDefault();
		var a = Number($(this).attr('anumber'));
		answer[qno] = a;
		if(qno < data['qas'].length - 1){
		    qno += 1;
		    obj = {};
		    obj.qno = qno;
		    window.history.pushState(obj, null, location.href);
		}
		else {
		    state = 2;
		}
		display();
	    });
            answersdiv.append(input);
        };

	center.append($('<p>'));

	input = $('<input>');
	input.attr('type','button');
	input.attr('value','戻る');
	input.css('font-size',size*0.05);
	input.css('border-radius',size*0.015);
	input.css('margin',size*0.01);
	input.css('padding',size*0.005);
	input.click(function(event){
		state = 0;
		//if(uselocalfile){
		//    onDeviceReady();
		//}
                display();
            });
	center.append(input);
    }
    else if(state == 2){
        var newpass = Crypt.crypt(seed,secretstr());
        center = $('<center>');
        body.append(center);
        var passspan = $('<span>');
        passspan.text(newpass);
        passspan.css('font-size',size * 0.08);
        center.append(passspan);

        center.append($('<p>'));

	var input = $('<input>');
	input.attr('type','button');
	input.attr('value','戻る');
	input.css('font-size',size*0.05);
	input.css('border-radius',size*0.015);
	input.css('margin',size*0.01);
	input.css('padding',size*0.005);
	input.click(function(event){
		state = 0;
                display();
            });
	center.append(input);
    }
};

var secretstr = function(){
    var secret = "";
    var qas = data['qas'];
    for(var i=0;i<qas.length;i++){
	secret += qas[i]['question'];
	secret += qas[i]['answers'][answer[i]];
    }
    return secret;
};

$(function(){
    $.getJSON("qa.json", function(d){
	data = d;
	// data = JSON.parse(json);
	
	window.addEventListener('popstate', function(event) {
	    qno = event.state.qno;
	    display();
	},false );
	
	$(window).on('resize',function(){
	    if(state == 1) display();
	});
	
	display();
	
	Crypt = new Crypt();
    });
});
