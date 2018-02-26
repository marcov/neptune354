
<!--
*********************************************************
*   Copyright 2003, CyberTAN  Inc.  All Rights Reserved *
*********************************************************

This is UNPUBLISHED PROPRIETARY SOURCE CODE of CyberTAN Inc.
the contents of this file may not be disclosed to third parties,
copied or duplicated in any form without the prior written
permission of CyberTAN Inc.

This software should be used as a reference only, and it not
intended for production use!


THIS SOFTWARE IS OFFERED "AS IS", AND CYBERTAN GRANTS NO WARRANTIES OF ANY
KIND, EXPRESS OR IMPLIED, BY STATUTE, COMMUNICATION OR OTHERWISE.  CYBERTAN
SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A SPECIFIC PURPOSE OR NONINFRINGEMENT CONCERNING THIS SOFTWARE
-->

<HTML><HEAD><TITLE>Setup</TITLE>

<% no_cache(); %>

<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<!--<META http-equiv=Content-Type content="text/html; charset=unicode">-->

<link rel="stylesheet" type="text/css" href="style.css">

<style fprolloverstyle>

A:hover {color: #00FFFF}

.small A:hover {color: #00FFFF}

</style>

<script src="common.js"></script>
<script language="JavaScript" type="text/javascript" src="share.js"></script>
<script language="JavaScript" type="text/javascript" src="capsetup.js"></script>

<SCRIPT language=JavaScript>

function check_repeat_value(F,N,num,I)
{
	if ((I.value == "00:00:00:00:00:00") || (I.value == "000000000000"))
	{
		alert("The mac value can not be zero !");
		I.value = I.defaultValue;
		return false;
	}
	for (i = 0; i < num; i ++)
	{
		val = eval(N+i);
		if (I == val) continue;
		if (I.value == val.value) 
		{
			alert("The value existed, please try another one !");
			I.value = I.defaultValue;
			return false;
		}
	}
	return true;
}

function valid_host_name(F,I,check_box)
{
	if(I.value != "")
	{
		total_num = 0;
		len = I.value.length - 1;
		while(1)
		{
			ch = I.value.charAt(len);
			if (ch == ' ') len --;
			else break;
		}
		for(i = 0 ; i <= len; i ++)
		{
			ch = I.value.charAt(i);
			if ((ch == '_') || (ch == '-')) continue;
			if (((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (_ch <= 'Z'))) continue;
			
			if (!((ch >= '0') && (ch <= '9')))
			{
				alert('Standard name may include char(a-z, A-Z);digital(0-9)and symbol (-,_)');
				I.value = I.defaultValue;
				check_box.checked = 0;
				return false;
			}else total_num ++;

		}
		if (total_num >= I.value.length)
		{
				alert('Standard name must not be all digitals !');
				I.value = I.defaultValue;
				check_box.checked = 0;
				return false;
		}
		if (!check_repeat_value(F,"F.dhcp_host",10,I))
    	{
    		check_box.checked = 0;
    		return false;
    	}
	}else {
		check_box.checked = 0;
		I.defaultValue = "";
	}
	return true;
}
function valid_check(mac_host, ip, I)
{
	if ((mac_host.value == "") || (ip.value == ""))
	{
		alert("Can not be checked !");
		I.checked = 0;
		return false;
	}
	return true;
}
function valid_my_ip(F,I,check_box,start,end)
{
	if(I.value == "")
	{
		if (check_box.checked) check_box.checked = 0;
		I.defaultValue = "";
		return true;
	}
	else{
		var start, end;
		var index = window.name.indexOf('_');
		if (index == -1)
		{
			start = 1;
			end = 253;
		}else {
			start = window.name.substring(0, index);
			var len = window.name.length;
			end = window.name.substring(index+1,len);
			if (start == '') start = 1;
			if (end == '') end = 253;
			else end = parseInt(end, 10) + parseInt(start, 10);
			if (parseInt(end, 10) > 253) end = 253;
		}
	
		if (valid_range(I,start,end,"IP") == false)
		{
			I.value = I.defaultValue; 
			check_box.checked = 0;
			return false;
		}
	    if (!check_repeat_value(F,"F.dhcp_mac_ip",10,I))
    	{
    		check_box.checked = 0;
    		return false;
    	}
	    if (!check_repeat_value(F,"F.dhcp_host_ip",10,I))
    	{
    		check_box.checked = 0;
    		
    		return false;
    	}
	}
	return true;
}

function valid_sharewanip_mac(F,I)
{
	if(I.value == "")
	{
		I.defaultValue = "";
		return true;
	}
	else if(I.value.length == 12)
		valid_macs_12(I);
	else if(I.value.length == 17)
		valid_macs_17(I);
	else{
		alert('The MAC Address length is not correct!!');
		I.value = I.defaultValue;
		return false;
        }
    if (!check_repeat_value(F,"F.dhcp_mac",11,I))
    {
    	return false;
    }
}

function valid_macs_all(F,I,check_box)
{
	if(I.value == "")
	{
		check_box.checked = 0;
		I.defaultValue = "";
		return true;
	}
	else if(I.value.length == 12)
		valid_macs_12(I);
	else if(I.value.length == 17)
		valid_macs_17(I);
	else{
		alert('The MAC Address length is not correct!!');
		I.value = I.defaultValue;
		check_box.checked = 0;
		return false;
        }
    if (!check_repeat_value(F,"F.dhcp_mac",11,I))
    {
    	check_box.checked = 0;
    	return false;
    }
}
<% support_elsematch("STB_SUPPORT", "1", "", "/*"); %>	
function stb_enable_switch(F) 
{
	if(!F.stb_enable.checked)
	{
		choose_disable(F.stbvalue_0);
		choose_disable(F.stbvalue_1);
		choose_disable(F.stbvalue_2);
		choose_disable(F.stbvalue_3);
		choose_disable(F.enable_0);
		choose_disable(F.enable_1);
		choose_disable(F.enable_2);
		choose_disable(F.enable_3);
		choose_disable(F.telus_ipaddr_0);
		choose_disable(F.telus_ipaddr_1);
		choose_disable(F.telus_ipaddr_2);
		choose_disable(F.telus_ipaddr_3);
	}
	else
	{
		choose_enable(F.stbvalue_0);
		choose_enable(F.stbvalue_1);
		choose_enable(F.stbvalue_2);
		choose_enable(F.stbvalue_3);
		choose_enable(F.enable_0);
		choose_enable(F.enable_1);
		choose_enable(F.enable_2);
		choose_enable(F.enable_3);
		choose_enable(F.telus_ipaddr_0);
		choose_enable(F.telus_ipaddr_1);
		choose_enable(F.telus_ipaddr_2);
		choose_enable(F.telus_ipaddr_3);
	}
}

function check_spec(I,M1)
{
	M = unescape(M1);
	for(i = 0;i < I.value.length; i++)
	{
		ch = I.value.charAt(i);
		if(ch == '?')
		{
			alert(M + 'is not allow \'?\'');
			I.focus();
			return false;
		}
	}
	return true;
}

function valid_stbvalue(F)
{
	
	if(!F.stb_enable.checked)
		return true;
	if((F.enable_0.checked) && (F.stbvalue_0.value == ""))
	{
		alert("Please enter type value");
		F.stbvalue_0.focus();
	   	return false;
	}
	else if((F.enable_1.checked) && (F.stbvalue_1.value==""))
	{
		alert("Please enter type value");
		F.stbvalue_1.focus();
	   	return false;
	}
	else if((F.enable_2.checked) && (F.stbvalue_2.value==""))
	{
		alert("Please enter type value");
		F.stbvalue_2.focus();
	   	return false;
	}	
	else if((F.enable_3.checked) && (F.stbvalue_3.value==""))
	{
		alert("Please enter type value");
		F.stbvalue_3.focus();
	   	return false;
	}	
	
   if(!valid_ip(F,"F.telus_ipaddr","Telus Server IP",ZERO_NO|MASK_NO))
                        {
                                F.telus_ipaddr_0.focus();
                                return false;
                        }

			if(!valid_range(F.telus_ipaddr_0,1,223,"IP"))
			{
				F.telus_ipaddr_0.focus();
				return false;
			}
			if(!valid_range(F.telus_ipaddr_3,1,254,"IP"))
			{
				F.telus_ipaddr_3.focus();
				return false;
			}
	
	if(check_spec(F.stbvalue_0,"STB%20Type") &&
	   check_spec(F.stbvalue_1,"STB%20Type") &&
	   check_spec(F.stbvalue_2,"STB%20Type") &&
	   check_spec(F.stbvalue_3,"STB%20Type"))
		return true;
	else 
		return false;
}
<% support_elsematch("STB_SUPPORT", "1", "", "*/"); %>	


var old_share_value=-1;
function share_wan_ip(F)
{
	old_share_value = F._share_wanip.checked;
	F._share_wanip_comm.disabled = !old_share_value;
	if (old_share_value == 1)
		alert("If this function enable, it will disable DMZ function by force!");

	if (!F._single_pc_mode.checked)
	{
		if (F.dhcp_mac10.value == "")
		{
			alert('Please write a MAC address!');
			F._share_wanip.checked = 0;
			return false;
		}else if (F.share_wanip_lease.value == "")
		{
			alert('Please write a lease time!');
			F._share_wanip.checked = 0;
			return false;
		}
	}
}

function single_pcmode(F)
{
	if (old_share_value == -1)
		old_share_value = F._share_wanip.checked;

	if (F._single_pc_mode.checked)
	{
		F._share_wanip.checked = 1;
		F.dhcp_mac10.disabled = true;
		F.share_wanip_if.disabled = true;
		F.share_wanip_lease.disabled = true;
		F._share_wanip_comm.disabled = false;
	}else 
	{
		F.dhcp_mac10.disabled = false;
		F.share_wanip_if.disabled = false;
		F.share_wanip_lease.disabled = false;
		F._share_wanip.checked = old_share_value;
		F._share_wanip_comm.disabled = !old_share_value;

		if ((F.share_wanip_lease.value == "") || (F.dhcp_mac10.value == ""))
		{
			F._share_wanip.checked = 0;;
			F._share_wanip_comm.disabled = true;
		}
	}
}



function to_submit(F)
{
    F.submit_button.value = "dhcp_reserved";
    F.action.value = "Apply";
	//leijun 2004-0623
	if(F._share_wanip.checked) F.share_wanip.value = 1;
	else F.share_wanip.value = 0;

	if(F._single_pc_mode.checked) F.single_pc_mode.value = 1;
	else F.single_pc_mode.value = 0;

	if(F._share_wanip_comm.checked) F.share_wanip_comm.value = 1;
	else F.share_wanip_comm.value = 0;
	
	F.dhcp_mac10.disabled = false;
	F.share_wanip_if.disabled = false;
	F.share_wanip_lease.disabled = false;
<% support_elsematch("STB_SUPPORT", "1", "", "/*"); %>	
        if(valid_stbvalue(F))
<% support_elsematch("STB_SUPPORT", "1", "", "*/"); %>	


    F.submit();
}

function load_init()
{
	window.focus();
	if (document.dhcpreserved._single_pc_mode.checked)
	{
		document.dhcpreserved.dhcp_mac10.disabled = true;
		document.dhcpreserved.share_wanip_if.disabled = true;
		document.dhcpreserved.share_wanip_lease.disabled = true;
	}
	document.dhcpreserved._share_wanip_comm.disabled = !document.dhcpreserved._share_wanip.checked;
<% support_elsematch("STB_SUPPORT", "1", "", "/*"); %>	
<% dump_stb_entry(); %>	
<% support_elsematch("STB_SUPPORT", "1", "", "*/"); %>

}
</SCRIPT>
</HEAD>

<BODY>

<DIV align=center>

<FORM name=dhcpreserved method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name="telus_ipaddr" value=4>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=action>
<input type=hidden name=start_ip>
<input type=hidden name=dhcp_reserved_ip_list>
<input type=hidden name=share_wanip>
<input type=hidden name=single_pc_mode>
<input type=hidden name=share_wanip_comm>

<% support_elsematch("STB_SUPPORT", "1", "", "<!--"); %>
<input type=hidden name=stbentry_config>
<input type=hidden name=telus_config>
<% support_elsematch("STB_SUPPORT", "1", "", "-->"); %>

<TABLE cellSpacing=0 cellPadding=0 width=809 border=0>

  <TBODY>

  <TR>

    <TD width=95>

    <IMG src="image/UI_Linksys.gif" 

      border=0 width="165" height="57"></TD>

    <TD vAlign=bottom align=right width=714 bgColor=#6666cc><FONT 

      style="FONT-SIZE: 7pt" color=#ffffff><FONT face=Arial><script>Capture(share.firmwarever)</script>:&nbsp;<% get_firmware_version(); %>&nbsp;&nbsp;&nbsp;</FONT></FONT></TD></TR>

  <TR>

    <TD width=808 bgColor=#6666cc colSpan=2>

    <IMG height=11 

      src="image/UI_10.gif" width=809 border=0></TD></TR></TBODY></TABLE>

<TABLE height=77 cellSpacing=0 cellPadding=0 width=809 bgColor=black border=0>

  <TBODY>

  <TR>

    <TD 

    style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" 

    borderColor=#000000 align=middle width=163 height=49>

      <H3 style="MARGIN-TOP: 1px; MARGIN-BOTTOM: 1px"><FONT 

      style="FONT-SIZE: 15pt" face=Arial color=#ffffff><script>Capture(bmenu.setup)</script></FONT></H3></TD>

    <TD 

    style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" 

    vAlign=center borderColor=#000000 width=646 bgColor=#000000 height=49>

      <TABLE 

      style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; BORDER-COLLAPSE: collapse; FONT-VARIANT: normal" 

      height=33 cellSpacing=0 cellPadding=0 bgColor=#6666cc border=0>

        <TBODY>

        <TR>

          <TD style="FONT-WEIGHT: bolder; FONT-SIZE: 10pt" align=right 

          bgColor=#6666cc height=33><FONT color=#ffffff><% wireless_support(1); %><script>Capture(share.wireless_g)</script><% wireless_support(2); %><script>Capture(share.productname)</script>&nbsp;&nbsp;</FONT></TD>

          <TD borderColor=#000000 borderColorLight=#000000 align=middle 

          width=109 bgColor=#000000 borderColorDark=#000000 height=12 

            rowSpan=2><FONT color=#ffffff><SPAN 

            style="FONT-SIZE: 8pt"><B><% nvram_get("router_name"); %></B></SPAN></FONT></TD></TR>

        <TR>

          <TD 

          style="FONT-WEIGHT: normal; FONT-SIZE: 1pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" 

          width=537 bgColor=#000000 height=1>&nbsp;</TD></TR>

        <TR>

          <TD width=646 bgColor=#000000 colSpan=2 height=32>

            <TABLE id=AutoNumber1 

            style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; BORDER-COLLAPSE: collapse; FONT-VARIANT: normal" 

            height=6 cellSpacing=0 cellPadding=0 width=637 border=0>

              <TBODY>

              <TR 

              style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; FONT-WEIGHT: normal; FONT-SIZE: 1pt; BORDER-LEFT: medium none; COLOR: black; BORDER-BOTTOM: medium none; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" 

              align=middle bgColor=#6666cc>
                <TD width=83  height=1><IMG height=10 src="image/UI_07.gif" width=83  border=0></TD>
                <TD width=83  height=1><IMG height=10 src="image/UI_06.gif" width=83  border=0></TD>
                <TD width=103 height=1><IMG height=10 src="image/UI_06.gif" width=103 border=0></TD>
                <TD width=103 height=1><IMG height=10 src="image/UI_06.gif" width=103 border=0></TD>
                <TD width=103 height=1><IMG height=10 src="image/UI_06.gif" width=103 border=0></TD>
                <TD width=103 height=1><IMG height=10 src="image/UI_06.gif" width=103 border=0></TD>
                <TD width=68  height=1><IMG height=10 src="image/UI_06.gif" width=68  border=0></TD></TR>
              <TR>

                <TD align=middle bgColor=#6666cc height=20><FONT 

                  style="FONT-WEIGHT: 700" color=#ffffff>

                <A 

                  style="TEXT-DECORATION: none" 

                  href="index.asp"><script>Capture(bmenu.setup)</script></A></FONT></TD>

                <% wireless_support(1); %><TD align=middle bgColor=#000000 height=20><FONT 

                  style="FONT-WEIGHT: 700" color=#ffffff>

                <a style="TEXT-DECORATION: none" href="Wireless_Basic.asp"><script>Capture(bmenu.wireless)</script></a></FONT></TD><% wireless_support(2); %>

                <TD align=middle bgColor=#000000 height=20><FONT 

                  style="FONT-WEIGHT: 700" color=#ffffff>

                <a style="TEXT-DECORATION: none" href="Firewall.asp"><script>Capture(bmenu.security)</script></a></FONT></TD>

                <TD align=middle bgColor=#000000 height=20><FONT 

                  style="FONT-WEIGHT: 700" color=#ffffff>

                <a style="TEXT-DECORATION: none" href="<% support_elsematch("PARENTAL_CONTROL_SUPPORT", "1", "Parental_Control.asp", "Filters.asp"); %>"><script>Capture(bmenu.accrestriction)</script></a></FONT></TD>

                <TD align=middle bgColor=#000000 height=20>

                  <P style="MARGIN-BOTTOM: 4px"><FONT style="FONT-WEIGHT: 700" 

                  color=#ffffff>

                  <a style="TEXT-DECORATION: none" href="Forward_UPnP.asp"><script>Capture(bmenu.application)</script> 

                  <BR>&amp; <script>Capture(bmenu.gaming)</script></a>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></P></TD>

                <TD align=middle bgColor=#000000 height=20>

                  <P style="MARGIN-BOTTOM: 4px"><FONT style="FONT-WEIGHT: 700" 

                  color=#ffffff>

                  <a style="TEXT-DECORATION: none" href="Management.asp">&nbsp;&nbsp;<script>Capture(bmenu.admin)</script></a>&nbsp;&nbsp;</FONT></P></TD>

                <TD align=middle bgColor=#000000 height=20>

                  <P style="MARGIN-BOTTOM: 4px"><FONT style="FONT-WEIGHT: 700" 

                  color=#ffffff>

                  <a style="TEXT-DECORATION: none" href="Status_Router.asp"><script>Capture(bmenu.statu)</script></a>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></P></TD>

              </TR>

                <TD width=643 bgColor=#6666cc colSpan=7 height=21>

                  <TABLE borderColor=black height=21 cellSpacing=0 cellPadding=0>

                    <TBODY>

                    <TR align=center>

                      <TD class=small width=140> <A href="index.asp"><script>Capture(settopmenu.basicsetup)</script></A></TD>

                      <TD> <P class=bar><font color='white'><b>|</b></font></P></TD>

					  <TD class=small width=100><A href="dhcp_reserved.asp"><font color='white'>Static DHCP</A></TD>
                      <TD><P class=bar><font color='white'><b>|</b></font></P></TD>

                      <TD class=small width=100><A href="DDNS.asp"><script>Capture(settopmenu.ddns)</script></FONT></TD>

                      <TD> <P class=bar><font color='white'><b>|</b></font></P></TD>

                      <TD class=small width=153> <A href="WanMAC.asp">MAC Address Clone</A></TD>

                      <TD> <P class=bar><font color='white'><b>|</b></font></P></TD>

                      <TD class=small width=140> <A href="Routing.asp"><script>Capture(settopmenu.advrouting)</script></A></TD>

<% support_invmatch("DHCP_DOMAIN_IP_MAPPING_SUPPORT", "1", "<!--"); %>
                      <TD><P class=bar><font color='white'><b>|</b></font></P></TD>
                      <TD class=small width=100><A href="VOIP.asp"><script>Capture(settopmenu.voip)</script></A></TD>
<% support_invmatch("DHCP_DOMAIN_IP_MAPPING_SUPPORT", "1", "-->"); %>

<% support_invmatch("HSIAB_SUPPORT", "1", "<!--"); %>
                      <TD><P class=bar><font color='white'><b>|</b></font></P></TD>
                      <TD class=small width=120><A href="HotSpot_Admin.asp"><script>Capture(settopmenu.hotspot)</script></TD>
<% support_invmatch("HSIAB_SUPPORT", "1", "-->"); %>

		</TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>

<TABLE height=5 cellSpacing=0 cellPadding=0 width=806 bgColor=black border=0>

  <TBODY>

  <TR bgColor=black>

    <TD 

    style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" 

    borderColor=#e7e7e7 width=163 bgColor=#e7e7e7 height=1>

    <IMG height=15 

      src="image/UI_03.gif" width=164 border=0></TD>

    <TD 

    style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; COLOR: black; FONT-STYLE: normal; FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-VARIANT: normal" 

    width=646 height=1>

    <IMG height=15 src="image/UI_02.gif" width=645 

      border=0></TD></TR></TBODY></TABLE>

<TABLE id=AutoNumber9 style="BORDER-COLLAPSE: collapse" borderColor=#111111 

height=23 cellSpacing=0 cellPadding=0 width=809 border=0>

  <TBODY>

  <TR>

    <TD width=633>

      <TABLE cellSpacing=0 cellPadding=0 border=0 width="633">

        <TBODY>

        <TR>

          <TD width=162 bgColor=#000000 height=25>

            <P align=right><B><FONT style="FONT-SIZE: 9pt" face=Arial 

            color=#ffffff>Static DHCP</FONT></B></P></TD>

          <TD width=4 bgColor=#000000 height=25>&nbsp;</TD>

          <TD width=12 height=25>&nbsp;</TD>

          <TD width=427 height=25 colspan="3">&nbsp;</TD>


          <TD width=25 height=25>&nbsp;</TD>

          <TD width=6 background=image/UI_05.gif height=25>&nbsp;</TD></TR>


        <TR>

          <TD width=162 bgColor=#e7e7e7 height=1>&nbsp;</TD>

          <TD width=4 background=image/UI_04.gif height=1>&nbsp;</TD>

          <TD colSpan=5 width=458>

            <TABLE>

              <TBODY>

              <TR>

                <TD width=16 height=1>&nbsp;</TD>

                <TD width=4 height=1>&nbsp;</TD>

                <TD width=410 colSpan=3 height=1>

                  <center>
					<table cellSpacing="0" cellPadding="10" width="422" border="1" height="212">
						<tr>
							<td width="398">
							<table height="30" cellSpacing="0" cellPadding="0" border="0" width="398">
								<tr>
									<td height="39" align="center">
									<p align="center"><b>
									<font face="Arial" size="4" color="#0000FF">
									DHCP </font>
									<font face="Arial" color="#0000ff" size="4">
									Reserved IP List</font></b></td>
								</tr>
							</table>
							<table style="BORDER-COLLAPSE: collapse" borderColor="silver" height="25" cellSpacing="0" cellPadding="0" width="398" border="1">
								<tr>
									<td class="headrow" align="middle" height="25" width="24">&nbsp;</td>
									<td class="headrow" align="middle" height="25" width="132">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									MAC&nbsp;Address</font></b></td>
									<td class="headrow" align="middle" height="25" width="178">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									IP Address</font></b></td>
									<td class="headrow" align="middle" height="25" width="60">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									Enabled</font></b></td>
								</tr>
			<% dhcp_reserved_ip("mac"); %>
								<tr>
									<td class="headrow" align="middle" height="25" width="24">&nbsp;</td>
									<td class="headrow" align="middle" height="25" width="132">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									Host Name</font></b></td>
									<td class="headrow" align="middle" height="25" width="178">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									IP Address</font></b></td>
									<td class="headrow" align="middle" height="25" width="60">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									Enabled</font></b></td>
								</tr>
			<% dhcp_reserved_ip("host"); %>
	    					</table>
							<table height="30" cellSpacing="0" cellPadding="0" border="0" width="397">
								<tr>
									<td height="39" align="center">
									<p align="center"><b>
									<font face="Arial" size="4" color="#0000FF">
									Share WAN IP</font></b></td>
								</tr>
							</table>
							<table style="BORDER-COLLAPSE: collapse" borderColor="silver" height="24" cellSpacing="0" cellPadding="0" width="398" border="1">
								<tr>
									<td class="headrow" align="middle" height="25" width="126">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									MAC&nbsp;Address</font></b></td>
									<td class="headrow" align="middle" height="25" width="172">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									WAN IP Interface</font></b></td>
									<td class="headrow" align="middle" height="25" width="100">
									<b>
									<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
									Lease Time</font></b></td>
								</tr>
			<% dhcp_reserved_ip("share"); %>
<!--			<TR align=center>
	<TD width=126 height=25><FONT style="FONT-SIZE: 10pt" face=Arial><INPUT maxLength=17 size=17 name=share_wanip_mac value="" onblur=valid_sharewanip_mac(this.form,this) class=num></TD>
	<TD width=172 height=25><FONT style="FONT-SIZE: 10pt" face=Arial><SELECT name=share_wanip_if onChange="">
		<option value="255" selected>Auto Search</option>
</SELECT></TD>
	<TD width=100 height=25><FONT style="FONT-SIZE: 10pt" face=Arial><INPUT maxLength=4 size=4 name=share_wanip_lease value=10 onBlur=valid_range(this,0,9999,"Share-WAN-IP-Lease-Time") class=num>&nbsp;minutes</TD></TR>
-->
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
							&nbsp;<input type="checkbox" value="1" onclick="share_wan_ip(this.form)" name="_share_wanip" <% nvram_match("share_wanip","1","checked"); %>> 
							Share WAN IP &nbsp;&nbsp;&nbsp;<input type="checkbox" value="1" name="_share_wanip_comm" <% nvram_match("share_wanip_comm","1","checked"); %>>Communicate 
							with Other LAN devices&nbsp;&nbsp;&nbsp;&nbsp;
 							<p>&nbsp;<input type="checkbox" value="1" onclick="single_pcmode(this.form)" name="_single_pc_mode" <% nvram_match("single_pc_mode","1","checked"); %>> 
							Single PC Mode </font></td>
						</tr>
					</table>
 <% support_elsematch("STB_SUPPORT", "1", "", "<!--"); %>
      			<table height="30" cellSpacing="0" cellPadding="0" border="0" width="398">
					<tr>
						<td height="39" align="center">
						<p align="center"><b>
						<font face="Arial" size="4" color="#0000FF">STB Type 
						Table</font></b></td>
					</tr>
					</table>
					<table style="BORDER-COLLAPSE: collapse" borderColor="silver" height="25" cellSpacing="0" cellPadding="0" width="398" border="1">
						<tr>
							<td class="headrow" align="middle" height="25" width="50">
							<font size="2"><b><span style="font-family: Arial">
							Index</span></b></font></td>
							<td class="headrow" align="middle" height="25" width="277">
							<font size="2"><b><span style="font-family: Arial">
							Match Type</span></b></font></td>
							<td class="headrow" align="middle" height="25" width="66">
							<font size="2"><b><span style="font-family: Arial">
							Select</span></b></font></td>
						</tr>
						<tr>
							<td class="headrow" align="middle" height="25" width="50">
							1</td>
							<td class="headrow" align="middle" height="25" width="277">
							<font size="2">
							<input maxLength="50" size="50" name="stbvalue_0"></font></td>
							<td class="headrow" align="middle" height="25" width="66">
							<input type="checkbox" name="enable_0" value="1"></td>
						</tr>
						<tr>
							<td class="headrow" align="middle" height="25" width="50">
							2</td>
							<td class="headrow" align="middle" height="25" width="277">
							<font size="2">
							<input maxLength="50" size="50" name="stbvalue_1"></font></td>
							<td class="headrow" align="middle" height="25" width="66">
							<input type="checkbox" name="enable_1" value="1"></td>
						</tr>
						<tr>
							<td class="headrow" align="middle" height="25" width="50">
							3</td>
							<td class="headrow" align="middle" height="25" width="277">
							<font size="2">
							<input maxLength="50" size="50" name="stbvalue_2"></font></td>
							<td class="headrow" align="middle" height="25" width="66">
							<input type="checkbox" name="enable_2" value="1"></td>
						</tr>
						<tr>
							<td class="headrow" align="middle" height="25" width="50">
							4</td>
							<td class="headrow" align="middle" height="25" width="277">
							<font size="2">
							<input maxLength="50" size="50" name="stbvalue_3"></font></td>
							<td class="headrow" align="middle" height="25" width="66">
							<input type="checkbox" name="enable_3" value="1"></td>
						</tr>
					</table>
					<p align="center"><font style="FONT-SIZE: 8pt" face="Arial">
					<b>Telus Server</b>:
					<input class="num" maxLength="3" size="3" value="<% telus_config("ipaddr", 0); %>" name="telus_ipaddr_0" onBlur="valid_range(this,1,223,&quot;IP&quot;)" <% telus_config("ipaddr", 4); %>> 
					.
					<input class="num" maxLength="3" size="3" value="<% telus_config("ipaddr", 1); %>" name="telus_ipaddr_1" onBlur="valid_range(this,0,255,&quot;IP&quot;)" <% telus_config("ipaddr", 4); %>> 
					.
					<input class="num" maxLength="3" size="3" value="<% telus_config("ipaddr", 2); %>" name="telus_ipaddr_2" onBlur="valid_range(this,0,255,&quot;IP&quot;)" <% telus_config("ipaddr", 4); %>> 
					.
					<input class="num" maxLength="3" size="3" value="<% telus_config("ipaddr", 3); %>" name="telus_ipaddr_3" onBlur="valid_range(this,1,254,&quot;IP&quot;)" <% telus_config("ipaddr", 4); %>></font>
					</p>
					<p align="center">
					<font style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
					<input type="checkbox" value="1" onclick="stb_enable_switch(this.form)" name="stb_enable" <% nvram_match("stb_enable","1","checked"); %>>
					</font><font size="2"><span style="font-family: Arial">STB 
					Enable</span></font> </p>
					<p align="center">&nbsp;
<% support_elsematch("STB_SUPPORT", "1", "", "-->"); %>   
</p>
					<p>
					<input type="button" value="Save Settings" onClick="to_submit(this.form)">&nbsp;
					<input type="button" value="Cancel Changes" name="cancel" onClick="javascript:window.location.href='dhcp_reserved.asp'"></p>
					</center>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p>&nbsp;</TD>

                <TD width=4 height=1>&nbsp;</TD></TR></TBODY></TABLE></TD>

          <TD width=6 background=image/UI_05.gif height=1>&nbsp;</TD></TR>


        <TR>

          <TD width=162 bgColor=#e7e7e7 height=25></TD>

          <TD width=4 background=image/UI_04.gif height=25>&nbsp;</TD>

          <TD colSpan=2 width=13 height=25>&nbsp;</TD>

          <TD width=110 height=25>&nbsp;</TD>

          <TD width=310 height=25>&nbsp;</TD>

          <TD width=25 height=25>&nbsp;</TD>

          <TD width=6 background=image/UI_05.gif height=25>&nbsp;</TD></TR>


        <TR>

          <TD width=162 bgColor=#e7e7e7 height=5>&nbsp;</TD>

          <TD width=4 background=image/UI_04.gif height=5>&nbsp;</TD>

          <TD width=458 colSpan=5 height=5>&nbsp;</TD>

          <TD width=6 background=image/UI_05.gif 

        height=5>&nbsp;</TD></TR></TBODY></TABLE></TD>

    <TD vAlign=top width=176 bgColor=#6666cc>

      <TABLE cellSpacing=0 cellPadding=0 width=176 border=0>

        <TBODY>

        <TR>

          <TD width=11 bgColor=#6666cc height=25>&nbsp;</TD>

          <TD width=160 bgColor=#6666cc height=25><font color="#FFFFFF">

          <span ><a target="_blank" href="help/HSetup.asp"><script>Capture(share.more)</script>...</a></span></font></TD>

          <TD width=9 bgColor=#6666cc height=25>&nbsp;</TD></TR></TBODY></TABLE></TD></TR>

</DIV></BODY></HTML>
