	var mindex = 0;

			var posxlist = [];
			var posylist = [];

			var xnow = 0;
			var ynow = 0;
			var maxlength = 100;
			var moves = 0;







	

	


			function record()
				{
					posxlist.push(xnow);
					posylist.push(ynow);	

					$("#label").html(xnow + ", " + ynow);
					
					if (posxlist.length>maxlength)
					{
						var a1 = posxlist.slice(-maxlength);
						posxlist = a1;
						var a2 = posylist.slice(-maxlength);
						posylist = a2;
					}
					calcular();
				};

			function calcular()
				{

					var totalxdif= 0;
					var totalydif = 0;
					moves = 0;
		
					var i ;
					for (i = 1;i<(posxlist.length-1);i++)
					{	
		
						if (((Math.abs(posxlist[i]-posxlist[i-1]))>75)||((Math.abs(posylist[i]-posylist[i-1]))>75))
						{
							moves++;
						}

					}
					

					mindex = moves/posxlist.length;

					//$("#box").html(mindex);

					if (posxlist.length>10)
						{
							if (mindex > 0.6)
								{state = "frantic"}
							else if (mindex > 0.5)
								{state = "busy"}
							else if (mindex > 0.35)
								{state = "chilled"}
							else if (mindex > 0.25)
								{state = "focused"}
							else if (mindex > 0.15)
								{state = "zen"};

							//$("#box2").html(state);
						}

					
				}

			$(document).ready(function(){
				 $(document).mousemove(function(e){
				 	xnow = e.pageX;
				 	ynow = e.pageY;

				 	});







				 interval_id = setInterval(function(){record();},500);


  				  var interval_id;
				  $(window).focus(function() {
					    if (!interval_id)
					       { interval_id = setInterval(function(){record();},500);
					   		}
				  });

			  	  $(window).blur(function() {
					    clearInterval(interval_id);
					    interval_id = 0;
					   moves += 3;
				  });



	

					 

					 


			});