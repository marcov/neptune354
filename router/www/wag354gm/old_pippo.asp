<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 

<!-- <% no_cache(); %> -->
		
<html>

<head>
	
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=iso-8859-1" />
	<title>Utility Page</title>
	
	<script type="text/javascript">
		
		function to_submit(F){
			F.action.value="Apply";
			F.submit();
			return true;
		}
		
		function PippoStart(F)
		{
			F.change_action.value = "gozila_cgi";
			F.submit_type.value = "startpippo";
			F.submit();
			Refresh();
			return true;
		}
		
		function GenKey(F,I){
			F.submit_type.value = I;
			F.submit_button.value = "pippo";
			F.change_action.value = "gozila_cgi";
			F.submit();
			return true;
		}
			
						
		function CreatePart(F,I){
			F.submit_type.value = I;
			F.submit_button.value = "pippo"
			F.change_action.value = "gozila_cgi";
			F.submit();
			return true;
		}
		
	</script>

</head>

	
	<body>
		
		<div align="center"><h1 color="blue">Utility Page</h1></div>
		<br />
		<p>In this page you can execute some utility actions. Sorry for the basic graphic, ATM it's not a priority.</p>
		
		
		<form name="F1" method="post" action="apply.cgi">
			<input type="hidden" name="submit_button" />
			<input type="hidden" name="change_action" />
			<input type="hidden" name="action" />
			<input type="hidden" name="submit_type" />
					
			<div>
				<p>This button let you generate a new private key used by the sshd server. 
				First of using it, you should have formatted and mounted the rw partition, 
				otherwise you'll get an error.<br />
				<script type="text/javascript">document.write("<input type=\"button\" value=\"Generate new private key\" onClick=\"GenKey(this.form,'genkey')\">");</script>
				</p>
			</div>	
			<br />
			<div>
				<p>This button let you format an unused 128 RW partition on your router. 
				You can store there the ssh private key, startup scripts and other conf files. <br />
				<script type="text/javascript">document.write("<input type=\"button\" value=\"Format the partition\" onClick=\"CreatePart(this.form,'createpart')\">");</script>
				&nbsp;<input type="checkbox" name="mount" value="valuemount"/> Mount after the creation
				</p>
			</div>	
		
		</form>
		
		<form name="F2" method="post" action="apply.cgi">
			<div>
				<p> These are nothing but demo buttons, do not abuse of their power!<br />
				<input type="hidden" name="submit_button" value="pippo" />
				<input type="hidden" name="change_action" />
				<input type="hidden" name="action" />
				<input type="hidden" name="submit_type" />
				<input class="num" maxLength="3"  size="3"  value="000" name="input_pippo" />
	         
				<script type="text/javascript">document.write("<input type=\"button\" value=\"Demo button\" onClick=\"PippoStart(this.form)\">");</script>
				<script type="text/javascript">document.write("<input type=\"button\" value=\"Demo submit button\" onClick=\"to_submit(F2)\" disabled>");</script>
				</p>
			</div>	
		</form>
		
		<br />
		<br />
		<h6><a href="Management.asp">Back to the Management page</a></h6>
		
	</body>
	
</html>	