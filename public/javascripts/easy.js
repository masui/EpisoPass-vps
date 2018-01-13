function shuffle(array, n){
    for(var i=0; i<n; i++){
        var r = i + 1 + Math.floor(Math.random() * (array.length - i - 1));
        var tmp = array[i];
        array[i] = array[r];
        array[r] = tmp;
    }
}
$(function() {
    $('#id').val('Masui_Twitter');
    $('#seed').val('Twitter_12345678');
    $('#answers').attr('placeholder',
		       "山田\n鈴木\n田中"
		      );
    $('#questions').attr('placeholder',
			 "絵が上手いのは?\n" +
			 "足が遅いのは?\n" +
			 "スケート場は?\n");
    $('#addnames').click(function(){
        shuffle(names,30);
        $('#answers').val(names.slice(0,30).join("\n"));
    });
    $('#addquestions').click(function(){
        shuffle(questions,10);
        $('#questions').val(questions.slice(0,10).join("\n"));
    });
    $('.button').click(function(){
        var id = $('#id').val();
        if(id == '' || !id.match(/^[a-zA-Z0-9_@-]+$/)){
            alert("IDを半角文字列で指定して下さい");
            return;
        }
        var seed = $('#seed').val();
        if(seed == ''){
            alert("半角のシード文字列を指定して下さい");
            return;
        }
        data = {};
        data['seed'] = seed;
        answers = $.grep($('#answers').val().split(/\n+/), function(s,i){
            return s != "";
        });
        if(answers.length == 0){
            alert("名前リストを指定して下さい");
            return;
        }
        qs = $.grep($('#questions').val().split(/\n+/), function(s,i){
            return s != "";
        });
        if(qs.length == 0){
            alert("質問リストを指定して下さい");
            return;
        }
        qas = [];
        for(var i=0;i<qs.length;i++){
            qa = {};
            qa['question'] = qs[i];
            qa['answers'] = answers;
            qas.push(qa);
        }
        data['qas'] = qas;
        //
        $.ajax({
            type: "POST",
            async: true,
            url: `/${id}/__write`,
            data: `data=${JSON.stringify(data)}`,
            success: function(){
		location.href = `http://EpisoPass.com/${id}/${seed}`;
            }
        });
    });
});
