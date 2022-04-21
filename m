Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF850A88D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391655AbiDUS6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391621AbiDUS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:58:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A979BA3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650567306; x=1682103306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S1Y8jxeMLBIxfVkkKRPuDHDTsSNIZt3EKDqYI0fSa/c=;
  b=flhMf/n5L6NCJgKhBnRBVKQ+GCZRpwyN5ZYTgvMshTinZIaRTHsCuYVG
   sjLIldyPuJs8MQ0oWC79Ezt7AtaQJzybBIUYkDNr64IpkjQdOASnkXJjg
   ULO/vgCnKWbi3wUY44OPz0+hggyACnU4LQtqcM7toJrOZbHJjV30nhVRa
   rBrZF3JBb2oJhGeq1+QIo5MqRJvfiDcPYyLnbqope4uO87GOKu4H6jxQb
   fVelfYswMXP0TKGGNUmwbEkuLbv8yX7/zAYZrBSxs6UUZWp9XVhQvcJ6E
   Rj4NEm64MyuDJ1UCyqMwxzEpMbl2w3BNCdES6ZTPYLC0N4QMddbTfObvv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264617927"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="264617927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="671177374"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 11:54:33 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhbwm-0008gB-Tv;
        Thu, 21 Apr 2022 18:54:32 +0000
Date:   Fri, 22 Apr 2022 02:53:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:rxrpc-ringless 10/21] net/rxrpc/local_object.c:172:24:
 warning: format specifies type 'unsigned short' but the argument has type
 'int'
Message-ID: <202204220213.WUyOhZZg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git rxrpc-ringless
head:   c388a8388ad238ffbe0cd204c3eacaf200055751
commit: 3f63ce6fffedc9a4b84006b79835fda0d51fb12d [10/21] rxrpc: Don't use a ring buffer for call Tx queue
config: hexagon-randconfig-r021-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220213.WUyOhZZg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=3f63ce6fffedc9a4b84006b79835fda0d51fb12d
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs rxrpc-ringless
        git checkout 3f63ce6fffedc9a4b84006b79835fda0d51fb12d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/rxrpc/local_object.c:172:24: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                                     "krxrpctxd/%hu", ntohs(udp_conf.local_udp_port));
                                                ~~~   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                %d
   include/linux/kthread.h:54:48: note: expanded from macro 'kthread_run'
                   = kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
                                                    ~~~~~~~     ^~~~~~~~~~~
   include/linux/kthread.h:28:66: note: expanded from macro 'kthread_create'
           kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
                                                                ~~~~~~~    ^~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:43:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/rxrpc/local_object.c:246:23: warning: unused variable 'c' [-Wunused-variable]
                   struct rxrpc_local *c = hlist_entry(cursor, struct rxrpc_local, link);
                                       ^
   2 warnings generated.


vim +172 net/rxrpc/local_object.c

   105	
   106	/*
   107	 * create the local socket
   108	 * - must be called with rxrpc_local_mutex locked
   109	 */
   110	static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
   111	{
   112		struct udp_tunnel_sock_cfg tuncfg = {NULL};
   113		struct sockaddr_rxrpc *srx = &local->srx;
   114		struct udp_port_cfg udp_conf = {0};
   115		struct task_struct *transmitter;
   116		struct sock *usk;
   117		int ret;
   118	
   119		_enter("%p{%d,%d}",
   120		       local, srx->transport_type, srx->transport.family);
   121	
   122		udp_conf.family = srx->transport.family;
   123		if (udp_conf.family == AF_INET) {
   124			udp_conf.local_ip = srx->transport.sin.sin_addr;
   125			udp_conf.local_udp_port = srx->transport.sin.sin_port;
   126	#if IS_ENABLED(CONFIG_AF_RXRPC_IPV6)
   127		} else {
   128			udp_conf.local_ip6 = srx->transport.sin6.sin6_addr;
   129			udp_conf.local_udp_port = srx->transport.sin6.sin6_port;
   130	#endif
   131		}
   132		ret = udp_sock_create(net, &udp_conf, &local->socket);
   133		if (ret < 0) {
   134			_leave(" = %d [socket]", ret);
   135			return ret;
   136		}
   137	
   138		tuncfg.encap_type = UDP_ENCAP_RXRPC;
   139		tuncfg.encap_rcv = rxrpc_input_packet;
   140		tuncfg.sk_user_data = local;
   141		setup_udp_tunnel_sock(net, local->socket, &tuncfg);
   142	
   143		/* set the socket up */
   144		usk = local->socket->sk;
   145		usk->sk_error_report = rxrpc_error_report;
   146	
   147		switch (srx->transport.family) {
   148		case AF_INET6:
   149			/* we want to receive ICMPv6 errors */
   150			ip6_sock_set_recverr(usk);
   151	
   152			/* Fall through and set IPv4 options too otherwise we don't get
   153			 * errors from IPv4 packets sent through the IPv6 socket.
   154			 */
   155			fallthrough;
   156		case AF_INET:
   157			/* we want to receive ICMP errors */
   158			ip_sock_set_recverr(usk);
   159	
   160			/* we want to set the don't fragment bit */
   161			ip_sock_set_mtu_discover(usk, IP_PMTUDISC_DO);
   162	
   163			/* We want receive timestamps. */
   164			sock_enable_timestamps(usk);
   165			break;
   166	
   167		default:
   168			BUG();
   169		}
   170	
   171		transmitter = kthread_run(rxrpc_transmitter, local,
 > 172					  "krxrpctxd/%hu", ntohs(udp_conf.local_udp_port));
   173		if (IS_ERR(transmitter)) {
   174			ret = PTR_ERR(transmitter);
   175			goto error_sock;
   176		}
   177	
   178		local->transmitter = transmitter;
   179		_leave(" = 0");
   180		return 0;
   181	
   182	error_sock:
   183		kernel_sock_shutdown(local->socket, SHUT_RDWR);
   184		local->socket->sk->sk_user_data = NULL;
   185		sock_release(local->socket);
   186		local->socket = NULL;
   187		return ret;
   188	}
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
