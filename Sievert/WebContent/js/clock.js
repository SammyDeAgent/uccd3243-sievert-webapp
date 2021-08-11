$(document).ready(
	function initializeClock(){
		displayClock();
	}
);

function displayClock(){
	var date = new Date();
	var cur_date = date.getDate() + "-" + dateConvert(date.getMonth(), "month") + "-" + date.getFullYear();
	
	var day = dateConvert(date.getDay(), "day");
			
	var hours = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();

	var meridiem;
	if (hours > 12) {
		hours -= 12;
		meridiem = "PM";
	} else if (hours == 12) {
		meridiem = "PM";
	} else if (hours == 0) {
		hours += 12;
		meridiem = "AM";
	} else {
		meridiem = "AM";
	}

	hours = leadingzero(hours);
	minutes = leadingzero(minutes);
	seconds = leadingzero(seconds);
				
	var local_time = hours + ":" + minutes + ":" + seconds + " " + meridiem;
	$("#clockHeader span").html(local_time + " <span class=\"text-success\">" + day + "</span> " + cur_date);

	refreshClock();
}

function refreshClock(){
	var refresh = 1000; // Refresh rate in ms
	mytime=setTimeout('displayClock()',refresh)
};

function leadingzero(num){
	var num2;
	if(num < 10){
		return num2 = "0" + num;
	}else return num;
};

function dateConvert(num, option){
	if(option == "day"){
		switch(num){
			case 0: return "Sunday";
			case 1: return "Monday";
			case 2: return "Tuesday";
			case 3: return "Wednesday";
			case 4: return "Thursday";
			case 5: return "Friday";
			case 6: return "Saturday";
			default: return null;
		}
	}else if(option == "month"){
		switch(num){
			case 0: return "Jan";
			case 1: return "Feb";
			case 2: return "Mar";
			case 3: return "Apr";
			case 4: return "May";
			case 5: return "Jun";
			case 6: return "Jul";
			case 7: return "Aug";
			case 8: return "Sep";
			case 9: return "Oct";
			case 10: return "Nov";
			case 11: return "Dec";
			default: return null;
		}
	}
}