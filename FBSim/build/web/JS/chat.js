var ws;

function chat_selectFriend() {
    var x = document.getElementById("lfriends").value;
    if (x === "0") {
        document.getElementById("to").value = "";
    } else {
        document.getElementById("to").value = x;
    }
}


function connect() {
    //document.getElementById("jchat").disabled = true; 
    var username = document.getElementById("username").value;
    var api = document.getElementById("chatAPI").value;
    var wsurl = "ws://" + api + "/chat/" + username;
    //alert(wsurl);
    ws = new WebSocket(wsurl);


    ws.onmessage = function (event) {
        var log = document.getElementById("log");
        console.log(event.data);
        var message = JSON.parse(event.data);
        if (message.content === 'online!') {
            var options = document.getElementById('lfriends').options;
            for (var i = 0; i < options.length; i++) {
                //console.log(options[i].value);//log the value
                if (options[i].value === message.from) {
                    log.innerHTML += message.from + " : " + message.content + "\n";
                }
            }
            if (username === message.from) {
                log.innerHTML += message.from + " : " + message.content + "\n";
            }            
        }
        else if (message.content === 'offline!') {
            var options = document.getElementById('lfriends').options;
            for (var i = 0; i < options.length; i++) {                
                if (options[i].value === message.from) {
                    log.innerHTML += message.from + " : " + message.content + "\n";
                }
            }
            if (username === message.from) {
                log.innerHTML += message.from + " : " + message.content + "\n";
            }
        }
        else {
            var options = document.getElementById('lfriends').options;
            for (var i = 0; i < options.length; i++) {                
                if (options[i].value === message.from) {
                    log.innerHTML += message.from + " : " + message.content + "\n";
                }
            }
        }
    };
}

function send() {
    var content = document.getElementById("msg").value;
    var to = document.getElementById("to").value;
    var json = JSON.stringify({
        "to": to,
        "content": content
    });

    ws.send(json);
    log.innerHTML += "Me : " + content + "\n";
}