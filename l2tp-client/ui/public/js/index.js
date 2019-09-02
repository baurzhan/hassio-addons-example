function ping() {
    var request = new XMLHttpRequest();
    request.onreadystatechange = function() {
        if(request.readyState === 4) {
            if(request.status === 200) {
                var status = document.getElementById('status');
                var result = JSON.parse(request.responseText); 
                if (status) {
                    status.innerHTML = result.alive ? 'online' : 'offline';
                    status.className = result.alive ? 'online' : 'offline';
                }
            } else {
                status.innerHTML = 'offline';
            } 
        }
    }
    request.open('GET', 'ping', true);
    request.send();
}
window.onload = function () {
    ping();
    window.setInterval(ping, 10000);
}


