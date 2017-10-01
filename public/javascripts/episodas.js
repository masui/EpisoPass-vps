var exports = {};

var browserWidth = function(){  
    if(window.innerWidth){ return window.innerWidth; }  
    else if(document.body){ return document.body.clientWidth; }  
    return 0;  
}

var browserHeight = function(){  
    if(window.innerHeight){ return window.innerHeight; }  
    else if(document.body){ return document.body.clientHeight; }  
    return 0;  
}

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

function select_answer(s){
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

var mousedown = false;
var curdiv = null;
var buttondiv;
var buttondivs = [];

function mouseenter(div){
    curdiv = div
    if(mousedown){
        curdiv.css('background-color','#f3f3f3');
        select_answer(curdiv.attr('index'));
    }
}

function mouseleave(div){
    curdiv = null;
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
}

function mousemove(e){
    var mousex = (e.pageX ? e.pageX : e.originalEvent.touches[0].pageX);
    var mousey = (e.pageY ? e.pageY : e.originalEvent.touches[0].pageY);
    for(var i=0;i<answers.length;i++){
        //buttondiv = $(`#id${i}`);
        buttondiv = buttondivs[i];
        buttonx = buttondiv.offset().left;
        buttony = buttondiv.offset().top;
        buttonw = buttondiv.width();
        buttonh = buttondiv.height();
        if(buttonx < mousex && buttonx+buttonw > mousex &&
           buttony < mousey && buttony+buttonh > mousey){
            if(curdiv != buttondiv){
                if(curdiv){
                    mouseleave(curdiv);
                }
                mouseenter(buttondiv);
                curdiv = buttondiv;
            }
            return;
        }
    }
    if(curdiv){
        mouseleave(curdiv);
        mousediv = null;
    }
}

function init(){
    qas = data['qas'];
    page = 0;
    
    curdiv = null;
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

    $('body').on('mousemove',mousemove);
    $('body').on('touchmove',mousemove);

    // 問題領域
    var qdiv = $('<div>');
    //qdiv.text('...');
    qdiv.attr('height',100);
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
        buttondivs[i] = div;
        div.css('float','left');
        div.attr('index',i);
        div.attr('id',`id${i}`);
        center.append(div);

        div.on('mousedown',function(e){
                e.preventDefault();
                mousedown = true;
                curdiv = null;
                mousemove(e);
        });
        div.on('touchstart',function(e){
                e.preventDefault();
                mousedown = true;
                curdiv = null;
                mousemove(e);
        });
        div.on('mouseup',function(e){
                if(curdiv) mouseleave(curdiv);
                mousedown = false;
                curdiv = null;
        });
        div.on('touchend',function(e){
                if(curdiv) mouseleave(curdiv);
                mousedown = false;
                curdiv = null;
        });
    }

    initsize();
    display();
}

$(function() {
    init();
});
