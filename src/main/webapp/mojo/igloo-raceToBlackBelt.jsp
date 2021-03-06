<div>
	<style type="text/css">
		body {
			font-family: Overpass, Sans-serif; color: #333;
		}
		
		table {
			border: solid 1px #ddd; cellspacing: 0px; cellpadding: 0px; width: 210px;/* width of the mojo widget in Overview mode, remove for Tiles mode*/
		}
		
		table tr:not(:first-child) td {
			padding: 4px; border-bottom: solid 1px #ddd;
		}
		
		.header {
			background-color: #000000; color: white; padding-top: 15px;
		}
		
		.header h2 {
			margin-bottom: 3px;
		}
		
		.subtitle {
			font-size: 10pt; color: white; padding-bottom: 3px;
		}
		
		.header td {
			font-weight: bold;
		}
		
		.avatar {
			border: 0px solid black; border-radius: 50px; -webkit-border-radius: 50px; -moz-border-radius: 50px;
		}
		
		.col {
			padding-left: 10px; padding-right: 10px;
		}
		
		.col-3 {
			text-align: center;
		}
		
		.even td {
			background-color: f9f9f9;
		}
		
		.belt {
			color: white;
		}
		/*
		.belt-black {
			background-color: black !important;
		}
		
		.belt-red {
			background-color: #a21c20 !important;
		}
		
		.belt-grey {
			background-color: #aaaaaa !important;
		}
		
		.belt-blue {
			background-color: #a4dbea !important;
		}
		*/
		
		.belt-blue {
			/*color: #a4dbea;*/
			background-color: #316EC2 !important;
		}
		
		.belt-red {
			/*color: #a21c20;*/
			background-color: #41A85F !important;
		}
		
		.belt-grey {
			/*color: #999999;*/
			background-color: #808080 !important;
		}
		
		.belt-black {
			/*color: #000000;*/
			background-color: #FAC51C !important;
		}
		

	</style>

	<table cellpadding="0" cellspacing="0" id="race">
		<tbody>
			<tr>
				<td class="header" colspan="4">
					<h2 style="text-align: center;"><span style="font-size: 24px;"><strong>Race to the<br>Gold Star!</strong></span></h2>
					<div class="subtitle" style="text-align: center;">First to 75 points wins the race!</div>
				</td>
			</tr>
		</tbody>
	</table>
	<script type="text/javascript">
		/*<![CDATA[*/
		var topX = 10;

		var ctx = "https://ninja-graphs-ninja-graphs.6923.rh-us-east-1.openshiftapps.com/ninja-graphs";

		var xhr = new XMLHttpRequest();
			//xhr.open("GET", ctx+"/api/proxy/leaderboard_10", true);
		xhr.open("GET", ctx + "/api/proxy/ninjas", true);
		xhr.send();
		xhr.onloadend = function()
		{
			var json = JSON.parse(xhr.responseText);

			var tableRef = document.getElementById('race');

			//for(var i=0;i<topX;i++){
			//  if (json['custom1'][i]=='mallen'){ json['custom1'].splice(i); json['labels'].splice(i); }
			//  if (json['custom1'][i]=='ablock'){ json['custom1'].splice(i); json['labels'].splice(i); }
			//  if (json['custom1'][i]=='esauer'){ json['custom1'].splice(i); json['labels'].splice(i); }
			//}
			var xx = 1;
			users = [];
			for (var i = 0; i < json['labels'].length; i++)
			{
				if (xx > 10) break;
				var custom1 = json['custom1'][i].split("|");
				if (custom1[0] == 'mallen') continue;
				if (custom1[0] == 'ablock') continue;
				if (custom1[0] == 'esauer') continue;


				var newRow = tableRef.insertRow(tableRef.rows.length);
				newRow.className = i % 2 ? "even" : "odd";
					// add numeric
				var c1 = newRow.insertCell(0);
					//var c1t  = document.createTextNode(i+1);
				var c1t = document.createTextNode(xx++);
				c1.className = "col col-1";
				c1.appendChild(c1t);

				users.push(custom1[0]);

				// add Image
				var c2 = newRow.insertCell(1);
				var c2t = document.createElement('img');
				c2t.src = '/cmedia/img/none.gif';
				c2t.style = "width: 50px; height: 50px; max-width: none;"
				c2t.className = "avatar user-" + custom1[0];
				c2.className = "col col-2";
				c2.appendChild(c2t);

				// add Name
				var c3 = newRow.insertCell(2);
				var c3t = document.createTextNode("");
				c3.innerHTML = json['labels'][i] + "<br/>" + json['datasets'][0]['data'][i] + "pts";
				c3.className = "col col-3 belt belt-" + custom1[1];
				c3.appendChild(c3t);

				// add Pts
				//var c4  = newRow.insertCell(3);
				//var c4t  = document.createTextNode(json['datasets'][0]['data'][i]+"pts");
				//c4.className="col col-4";
				//c4.appendChild(c4t);
			}

			getUserPics(users);
		}

		function getUserPics(users)
		{
			var jqxhr = jQuery.getJSON("/.api2/api/v1/communities/10/search/members?query=" + users.join("+OR+") + "&memberSearchType=email&limit=1000", function(data)
			{
				usersinfo = data.results;
				for (i in usersinfo)
				{
					var email = usersinfo[i].email;
					if (undefined != email)
					{
						var el = jQuery('.user-' + usersinfo[i].email.split('@')[0]);
						if (el.length > 0)
						{
							jQuery('.user-' + usersinfo[i].email.split('@')[0])[0].src = "/download-profile/{" + usersinfo[i].id + "}/profile/crxlarge?noCache=" + Math.round(new Date().getTime() / 1000)

						}
					}
				}
			})
		}

		function resizeParent()
		{
			window.frameElement.style.height = window.frameElement.contentWindow.document.body.scrollHeight + 'px';
		}
		/*]]]]]]]]]]]]]>*/

	</script>
</div>
