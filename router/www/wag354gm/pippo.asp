<% show_status("init"); %>
<HTML>
	<HEAD>
		<TITLE>Utility</TITLE>
		<% no_cache(); %>
		<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
				
		<link rel="stylesheet" type="text/css" href="style.css">
		<style fprolloverstyle>
			A:hover
			{
				color: #00FFFF;
			}
			
			.small A:hover
			{
				color: #00FFFF;
			}
		</style>
		
		<SCRIPT language="Javascript" type="text/javascript" src="common.js"></SCRIPT>
		<SCRIPT language="Javascript" type="text/javascript" src="share.js"></SCRIPT>
		<SCRIPT language="Javascript" type="text/javascript" src="capadmin.js"></SCRIPT>
		
		<script type="text/javascript">
		
			function to_submit(F)
			{
				F.submit_button.value = "pippo";
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
			
			function GenKey(F,I)
			{
				F.submit_type.value = I;
				F.submit_button.value = "pippo";
				F.change_action.value = "gozila_cgi";
				F.submit();
				return true;
			}
				
							
			function CreatePart(F,I)
			{
				F.submit_type.value = I;
				F.submit_button.value = "pippo"
				F.change_action.value = "gozila_cgi";
				F.submit();
				return true;
			}
			
			function submit_wlan_switch(F,I)
			{
				F.submit_type.value = I;
				F.submit_button.value = "pippo"
				F.change_action.value = "gozila_cgi";
				F.submit();
				return true;
			}
			
		</script>
						
	</HEAD>

	<BODY>
	<DIV align="center">	
		

		<!-- up right intestation -->
		<TABLE cellSpacing=0 cellPadding=0 width=809 border=0>
			<TBODY>
				<TR>
					<TD width=95><IMG src="image/UI_Linksys.gif" border=0 width="165" height="57"></TD>
					<TD vAlign=bottom align=right width=714 bgColor=#6666cc>
						<FONT style="FONT-SIZE: 7pt" color=#ffffff>
				  		<FONT face=Arial><script>Capture(share.firmwarever)</script>:&nbsp;<% get_firmware_version(); %>&nbsp;&nbsp;&nbsp;</FONT>
						</FONT>
					</TD>
				</TR>
				
				<TR>
					<TD width=808 bgColor=#6666cc colSpan=2><IMG height=11 src="image/UI_10.gif" width=809 border=0></TD>
				</TR>
			</TBODY>
		</TABLE>
		<!-- end up right intestation -->
		
		
		
		<!-- Upper part -->
		<TABLE height=77 cellSpacing=0 cellPadding=0 width=809 bgColor=black border=0>
			<TBODY>
				<TR>
					<TD style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" borderColor=#000000 align=middle width=163 height=49><H3 style="MARGIN-TOP: 1px; MARGIN-BOTTOM: 1px"><FONT style="FONT-SIZE: 15pt" face=Arial color=#ffffff><script>Capture(bmenu.admin)</script></FONT></H3></TD>
					<TD style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" vAlign=center borderColor=#000000 width=646 bgColor=#000000 height=49><TABLE style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; BORDER-COLLAPSE: collapse; FONT-VARIANT: normal" height=33 cellSpacing=0 cellPadding=0 bgColor=#6666cc border=0>

						<!-- Boh -->
						<TABLE style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; BORDER-COLLAPSE: collapse; FONT-VARIANT: normal" height=33 cellSpacing=0 cellPadding=0 bgColor=#6666cc border=0 >
							<TBODY>
								<TR>
									<TD style="FONT-WEIGHT: bolder; FONT-SIZE: 10pt;" align=right bgColor=#6666cc height=33 >
										<FONT color=#ffffff>
											<span><% wireless_support(1); %>
												<script>Capture(share.wireless_g)</script><% wireless_support(2); %>
												<script>Capture(share.productname)</script>&nbsp;&nbsp;
											</span>
										</FONT>
									</TD>
									
									<TD borderColor=#000000 borderColorLight=#000000 align=middle width=109 bgColor=#000000 borderColorDark=#000000 height=12 rowSpan=2 >
										<FONT color=#ffffff>
											<SPAN style="FONT-SIZE: 8pt"><B><% nvram_get("router_name"); %></B></SPAN>
										</FONT>
									</TD>
								</TR>
								
								<TR>
									<TD style="FONT-WEIGHT: normal; FONT-SIZE: 1pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" width=537 bgColor=#000000 height=1 >&nbsp;</TD>
								</TR>
								
								
								<!-- Start All links -->
								<TR>
									<TD width=646 bgColor=#000000 colSpan=2 height=32>
										
										<TABLE id=AutoNumber1 style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; BORDER-COLLAPSE: collapse; FONT-VARIANT: normal" height=6 cellSpacing=0 cellPadding=0 width=637 border=0 >
											<TBODY>
												
												
												<!-- up grey bar-->
												<TR style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; FONT-WEIGHT: normal; FONT-SIZE: 1pt; BORDER-LEFT: medium none; COLOR: black; BORDER-BOTTOM: medium none; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" align=middle bgColor=#6666cc >
													<TD width=83  height=1><IMG height=10 src="image/UI_06.gif" width=83  border=0></TD>
													<TD width=83  height=1><IMG height=10 src="image/UI_06.gif" width=83  border=0></TD>
													<TD width=103 height=1><IMG height=10 src="image/UI_06.gif" width=103 border=0></TD>
													<TD width=103 height=1><IMG height=10 src="image/UI_06.gif" width=103 border=0></TD>
													<TD width=103 height=1><IMG height=10 src="<% wireless_support(3); %>" width=103 border=0></TD>
													<TD width=103  height=1><IMG height=10 src="<% wireless_support(4); %>" width=103  border=0></TD>
													<TD width=60 height=1><IMG height=10 src="image/UI_06.gif" width=60 border=0></TD>
												</TR>
												<!-- End up grey bar-->
												
												<!--landmarks links -->
												<TR>
													<TD align=middle bgColor=#000000 height=20>
														<FONT style="FONT-WEIGHT: 700" color=#ffffff>
															<A style="TEXT-DECORATION: none" href="index.asp"><script>Capture(bmenu.setup)</script></A>
														</FONT>
													</TD>
													
													<% wireless_support(1); %>
													
													<TD align=middle bgColor=#000000 height=20>
														<FONT style="FONT-WEIGHT: 700" color=#ffffff>
															<a style="TEXT-DECORATION: none" href="Wireless_Basic.asp"><script>Capture(bmenu.wireless)</script></a>
														</FONT>
													</TD>
													
													<% wireless_support(2); %>
													
													<TD align=middle bgColor=#000000 height=20>
														<FONT style="FONT-WEIGHT: 700" color=#ffffff>
															<a style="TEXT-DECORATION: none" href="Firewall.asp"><script>Capture(bmenu.security)</script></a>
														</FONT>
													</TD>
													
													<TD align=middle bgColor=#000000 height=20>
														<FONT style="FONT-WEIGHT: 700" color=#ffffff>
															<a style="TEXT-DECORATION: none" href="<% support_elsematch("PARENTAL_CONTROL_SUPPORT", "1", "Parental_Control.asp", "Filters.asp"); %>" > <script>Capture(bmenu.accrestriction)</script></a>
														</FONT>
													</TD>
													
													<TD align=middle bgColor=#000000 height=20>
														<P style="MARGIN-BOTTOM: 4px">
															<FONT style="FONT-WEIGHT: 700" color=#ffffff >
																<a style="TEXT-DECORATION: none" href="Forward_UPnP.asp"><script>Capture(bmenu.application)</script>
																	<BR>&amp; 
																	<script>Capture(bmenu.gaming)</script>
																</a>
																&nbsp;&nbsp;&nbsp;&nbsp;
															</FONT>
														</P>
													</TD>
													
													 <TD align=middle bgColor=#6666cc height=20>
														 <P style="MARGIN-BOTTOM: 4px"><FONT style="FONT-WEIGHT: 700" color=#ffffff>&nbsp;&nbsp;
													 		<script>Capture(bmenu.admin)</script>&nbsp;&nbsp;
													 	</FONT></P>
													 </TD>

													
													<TD align=middle bgColor=#000000 height=20>
														<P style="MARGIN-BOTTOM: 4px"><FONT style="FONT-WEIGHT: 700" color=#ffffff>
															<a style="TEXT-DECORATION: none" href="Status_Router.asp">
																<script>Capture(bmenu.statu)</script>
															</a>&nbsp;&nbsp;&nbsp;&nbsp;
														</FONT></P>
													</TD>       

												</TR>
												<!-- End landmakrs -->
											
												<!-- transitional links -->
												<TR>
												<TD width=643 bgColor=#6666cc colSpan=7 height=21>
													<TABLE borderColor=black height=21 cellSpacing=0 cellPadding=0>
														<TBODY>
															<TR align=center>
																<TD class=small width=80><a href="Management.asp"><script>Capture(admtopmenu.manage)</script></a></TD>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD class=small width=80><a href="Log.asp"><script>Capture(admtopmenu.report)</script></a></TD>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD class=small width=80><A href="Diagnostics.asp"><script>Capture(admtopmenu.diag)</script></A></TD>
																<% support_elsematch("BACKUP_RESTORE_SUPPORT","1","","<!--"); %>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD  class=small width=110><A href="Backup_Restore.asp"><script>Capture(admtopmenu.bakrest)</script></A></TD>
																<% support_elsematch("BACKUP_RESTORE_SUPPORT","1","","-->"); %>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD class=small width=110><A href="Factory_Defaults.asp"><script>Capture(admtopmenu.facdef)</script></A></TD>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD class=small width=120><A href="Upgrade.asp"><script>Capture(admtopmenu.upgrade)</script></A></TD>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD class=small width=63><A href="Reboot.asp"><script>Capture(admtopmenu.reboot)</script></A></TD>
																<TD width=1><P class=bar><font color='white'><b>|</b></font></P></TD>
																<TD width=80><FONT style="COLOR: white">Utility</FONT></TD>
					  										</TR>
														</TBODY>
													</TABLE>
												</TD>
											</TR>
												<!-- End transitional links -->
											
										
											</TBODY>
										</TABLE>
									</TD>
								</TR>
								<!-- End All links-->
							
							</TBODY>
						</TABLE>
						<!-- End Boh -->
					
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<!-- End upper part -->
		              
	
		<!-- grey line under transitiona links -->
		<TABLE height=5 cellSpacing=0 cellPadding=0 width=806 bgColor=black border=0>
			<TBODY>
				<TR bgColor=black>
					<TD style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" borderColor=#e7e7e7 width=163 bgColor=#e7e7e7 height=1>
						<IMG height=15 src="image/UI_03.gif" width=164 border=0>
					</TD>
					<TD style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" width=646 height=1>
						<IMG height=15 src="image/UI_02.gif" width=645 border=0>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		
		
		
		
		<!-- Main -->
		<TABLE id=AutoNumber9 style="BORDER-COLLAPSE: collapse" borderColor=#111111 height=23 cellSpacing=0 cellPadding=0 width=809 border=0 >
			<TBODY>
			
				<TR>
					
					
					<!-- Content -->
					<form name="F1" method="post" action="apply.cgi">
						<input type="hidden" name="submit_button" />
						<input type="hidden" name="change_action" />
						<input type="hidden" name="action" />
						<input type="hidden" name="submit_type" />
					
					
						<TD width=633>
							<TABLE cellSpacing=0 cellPadding=0 border=0 >
								<TBODY>
									<!-- Blank Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									
									<!-- SSH -->
									
									<!-- Black Title -->
									<TR>
										<TD width=156 bgColor=#000000 height=25>
											<P align=right><B><FONT style="FONT-SIZE: 9pt" face=Arial color=#ffffff>SSH Private Key</FONT></B></P>
										</TD>
										
										<TD width=8 bgColor=#000000 height=25>&nbsp;</TD>
										<TD width=14 height=25>&nbsp;</TD>
										<TD width=17 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=101 height=25>&nbsp;</TD>
										<TD width=296 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD>
									</TR>
									
									<!-- Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6 align="center">
											<p>This button let you generate a new private key used by the sshd server. 
												First of using it, you should have formatted and mounted the rw partition, 
												otherwise you'll get an error.<br />
												<script type="text/javascript">document.write("<input type=\"button\" value=\"Generate new private key\" onClick=\"GenKey(this.form,'genkey')\">");</script>
											</p>
										</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<!-- Blank Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									<!-- Light Blue Line -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6><HR color=#b5b5e6 SIZE=1></TD>
										<TD width=15 background=image/UI_05.gif height=5 >&nbsp;</TD>
									</TR>
									
									
									<!-- End SSH -->
									
									
									
									
									
									<!-- RW Part -->
									
									<!-- Black Title -->
									<TR>
										<TD width=156 bgColor=#000000 height=25>
											<P align=right><B><FONT style="FONT-SIZE: 9pt" face=Arial color=#ffffff>RW Partition</FONT></B></P>
										</TD>
										
										<TD width=8 bgColor=#000000 height=25>&nbsp;</TD>
										<TD width=14 height=25>&nbsp;</TD>
										<TD width=17 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=101 height=25>&nbsp;</TD>
										<TD width=296 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD>
									</TR>
									
									<!-- Blank Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<!-- Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6 align="center">
										<p>This button let you format an unused 128 RW partition on your router. 
										You can store there the ssh private key, startup scripts and other conf files. <br />
										<script type="text/javascript">document.write("<input type=\"button\" value=\"Format the partition\" onClick=\"CreatePart(this.form,'createpart')\">");</script>
										&nbsp;<input type="checkbox" name="mount" value="valuemount"/> Mount after the creation
										</p>
										</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<!-- Blank Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									<!-- Light Blue Line -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6><HR color=#b5b5e6 SIZE=1></TD>
										<TD width=15 background=image/UI_05.gif height=5 >&nbsp;</TD>
									</TR>
									
									<!-- End RW Part -->
									
									
									<!-- Begin NFS -->
									
									<!-- Black Title -->
									<TR>
										<TD width=156 bgColor=#000000 height=25>
											<P align=right><B><FONT style="FONT-SIZE: 9pt" face=Arial color=#ffffff>NFS Management</FONT></B></P>
										</TD>
										
										<TD width=8 bgColor=#000000 height=25>&nbsp;</TD>
										<TD width=14 height=25>&nbsp;</TD>
										<TD width=17 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=101 height=25>&nbsp;</TD>
										<TD width=296 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD>
									</TR>
									
									<!-- Blank Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<!-- Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6 align="left">
											Mount NFS folder at boot:
											
											<INPUT type="radio" value="1" name="nfsmount_enable" <% nvram_match("nfsmount_enable","1","checked"); %>>
											<b>Enable</b>
											&nbsp;&nbsp;&nbsp;
											<INPUT type="radio" value="0" name="nfsmount_enable" <% nvram_invmatch("nfsmount_enable","1","checked"); %>>
											<b>Disable</b>
										</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									
									<!-- Row-->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6 align="left">
										NFS Server: 
										<input name="nfsmount_ip" size="15"  align="right" value="<% nvram_get("nfsmount_ip"); %>" />
										</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									<!-- Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6 align="left">
										Server Folder(full path required):
										<input name="nfsmount_path" size="30" value="<% nvram_get("nfsmount_path"); %>" />
										</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<!-- Blank Row -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									<!-- Light Blue Line -->
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6><HR color=#b5b5e6 SIZE=1></TD>
										<TD width=15 background=image/UI_05.gif height=5 >&nbsp;</TD>
									</TR>
									
									<!-- End NFS -->
									
									
									<!-- Switch Wlan -->
									
									<!-- Black Title >
									<!--
									<TR>
										<TD width=156 bgColor=#000000 height=25>
											<P align=right><B><FONT style="FONT-SIZE: 9pt" face=Arial color=#ffffff>Wireless</FONT></B></P>
										</TD>
										
										<TD width=8 bgColor=#000000 height=25>&nbsp;</TD>
										<TD width=14 height=25>&nbsp;</TD>
										<TD width=17 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=101 height=25>&nbsp;</TD>
										<TD width=296 height=25>&nbsp;</TD>
										<TD width=13 height=25>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD>
									</TR>
									
									<! Blank Row >
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<! Row >
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6 align="center">
										<p>This could be an useful feature for those of you who use the wireless without an external antenna.
										When you pop-out the connector for the external antenna, a switch is closed on your router, 
										so that the external antenna is used. If you enable this feature you will have instead the ability to
										start/stop wireless.<br />
										
										<INPUT type="radio" value="1" name="wlan_switch" <% nvram_match("wlan_switch","1","checked"); %>>
										<b>Enable</b>
										&nbsp;&nbsp;&nbsp;
										<INPUT type="radio" value="0" name="wlan_switch" <% nvram_match("wlan_switch","0","checked"); %>>
										<b>Disable</b>
							
										<script type="text/javascript">document.write("<input type=\"button\" value=\"Apply\" onClick=\"submit_wlan_switch(this.form,'wlan_switch')\">");</script>
										
										</p>
										</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									
									<! Blank Row >
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6>&nbsp;</TD>
										<TD width=15 background=image/UI_05.gif height=5>&nbsp;</TD>
									</TR>
									<! Light Blue Line >
									<TR>
										<TD width=156 bgColor=#e7e7e7 height=5>&nbsp;</TD>
										<TD width=8 background=image/UI_04.gif height=5>&nbsp;</TD>
										<TD colSpan=6><HR color=#b5b5e6 SIZE=1></TD>
										<TD width=15 background=image/UI_05.gif height=5 >&nbsp;</TD>
									</TR>
									<!-- End Switch Wlan -->
								</TBODY>
							</TABLE>
						</TD>
						
					
					<!-- TO BE IMPLEMENTED -->
					<!--
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
				
					-->	


					<!-- End content -->
				  
					<!-- Help -->
					<TD vAlign=top width=176 bgColor=#6666cc>
					  	<TABLE cellSpacing=0 cellPadding=0 width=176 border=0>
							<TBODY>
								<TR>
									<TD width=11 bgColor=#6666cc height=25>&nbsp;</TD>
									<TD width=156 bgColor=#6666cc height=25><font color="#FFFFFF">
									<span ><a target="_blank" href="http://www.google.com/search?q=wag354g+user+guide"><script>Capture(share.more)</script>...</a></span></font>&nbsp;</TD>
									<TD width=9 bgColor=#6666cc height=25>&nbsp;</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<!-- End Help -->
				
				</TR>
				
				
				<!-- Footer -->
				<TR>
					<TD width=809 colSpan=2>
						<TABLE cellSpacing=0 cellPadding=0 border=0>
							<TR>
								<TD width=156 bgColor=#e7e7e height=30>&nbsp;</TD>
								<TD width=8 ><IMG src='image/UI_04.gif' border=0 width=8 height=30></TD>
								<TD width=16>&nbsp;</TD>
								<TD width=12>&nbsp;</TD>
								<TD width=411>&nbsp;</TD>
								<TD width=15>&nbsp;</TD>
								<TD width=15 ><IMG src='image/UI_05.gif' border=0 width=15 height=30></TD>
								<TD width=176 bgColor=#6666cc rowSpan=2><IMG height=64 
								src='image/UI_Cisco.gif' width=176 border=0></TD></TR>
							<TR>
								<TD width=156 bgColor=#000000>&nbsp;</TD>
								<TD width=8 bgColor=#000000>&nbsp;</TD>
								<TD width=16 bgColor=#6666cc>&nbsp;</TD>
								<TD width=12 bgColor=#6666cc>&nbsp;</TD>
								
								<TD width=411 bgColor=#6666cc>
					            <TABLE height=19 cellSpacing=0 cellPadding=0 align=right border=0 width="220">
					            <TBODY>
					              <TR>
					                <TD align=middle bgColor=#42498c width="101"><FONT color=#ffffff><B><A href='javascript:to_submit(document.forms[0]);'><script>Capture(share.saves)</script></A></B></FONT>
					                </TD>
					                <TD align=middle width=8 bgColor=#6666cc>&nbsp;</TD>
					               <TD align=middle bgColor=#434a8f width="111"><FONT color=#ffffff><B><A href=index.asp><script>Capture(share.cancels)</script></A></B></FONT></TD> 
					                <TD align=middle width=4 bgColor=#6666cc>&nbsp;</TD>
					                </TR></TBODY></TABLE></TD>
					                <TD width=15 bgColor=#6666cc height=33>&nbsp;</TD>
					                <TD width=15 bgColor=#000000 height=33>&nbsp;</TD>
					              </TR>
					            </TBODY>
					            </TABLE>
					          </TD>
							  </form>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<!-- End Footer -->
				
				
		  </TBODY>
		</TABLE>
		<!-- End Main -->
			
	</div>
	</BODY>
</HTML>
