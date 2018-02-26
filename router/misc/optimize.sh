#! /bin/sh

#Hostname
echo neptune > /proc/sys/kernel/hostname

#Timezone
nvram get time_zone > /tmp/TZ

# fix McMCC, 13122005
echo "1" > /proc/sys/vm/overcommit_memory
# unreserve for unp systems
echo "0 0" > /proc/sys/vm/pagetable_cache
# router
echo 1 > /proc/sys/net/ipv4/ip_forward
# pppox
echo 1 > /proc/sys/net/ipv4/ip_dynaddr
# ignore_all not yet used: this should be satisfactory
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
# drop spoofed addr: turn this off on non-loop-free networks
# echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
# echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
# do not honor source route flags
echo 0 > /proc/sys/net/ipv4/conf/default/accept_source_route
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route
# protect against syn flood attacks
echo 1 >/proc/sys/net/ipv4/tcp_syncookies
# fix for Windows Vista, McMCC, 02122006
echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
# this needs proper sampling on av_blog to determine optimal value
# for now just observe softnet_stats to see # time was throttled
# historical value was 300
echo 100 > /proc/sys/net/core/netdev_max_backlog

echo 50 > /proc/sys/net/core/mod_cong
echo 30 > /proc/sys/net/core/lo_cong
echo 10 > /proc/sys/net/core/no_cong


###################
#Network
echo 0 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_log_invalid_scale
echo 0 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_log_out_of_window
echo 5 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_close
echo 120 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_close_wait
echo 60 > /proc/sys/net/ipv4/netfilter/ip_conntrack_generic_timeout
echo 60 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_time_wait
echo 256 > /proc/sys/net/ipv4/tcp_max_syn_backlog
echo 1200 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established
echo 1 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_be_liberal
echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses
echo 1 > /proc/sys/net/ipv4/tcp_rfc1337

