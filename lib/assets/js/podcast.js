( function()
{
	if (document.createElement('audio').canPlayType) {
    if (!document.createElement('audio').canPlayType('audio/mpeg')) {
    	var arr = document.getElementsByClassName('audio');

    	for (var i = 0; i < arr.length; i++) {
    		var tag = arr.item(i);
      		tag.innerHTML = '';
      	}
    }
 	}
})();
