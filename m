Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38CF4F5260
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850039AbiDFCrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580823AbiDEXew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:34:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076115F4E2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649195860; x=1680731860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0w8O0Vd1TQMF4m2IKNfcg2j0Z1CYEGhYwuFP/DSTEKM=;
  b=h7My4x3sl6U5lj9+ftiwl/XOWgeESGnZtJfZqfwkAYqcXKSGxGQ71Tw2
   D+HC+4Vy4Ndr2ge7cBwWebbnk/OsoUYWy1Bh5Yv4c2BNS0pVmVUwZqeOb
   bBLeRBjNsr/o5BfMOO81tu59QPq7NlFYadKM/aXEn0xOLvzJ+KcXVvGIJ
   NxNOaYuX+2aNxfMDuZ1Pc/gFWPgELY50ItSBfRUgWWDZymx7MVbrCzWYf
   1viTOU056jENslYLKVrG9DsQr2PPYc7YfqVktVIvYC2tshrOx/l76cSfs
   fqRdheCN38zAR062uqk9IJDceNhc7uc5zoa403GBH7+7wgKnFe3sSsaC8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="243012945"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="243012945"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="608621905"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 14:57:36 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbrBA-0003np-2h;
        Tue, 05 Apr 2022 21:57:36 +0000
Date:   Wed, 6 Apr 2022 05:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 4/9]
 net/rxrpc/local_object.c:172:24: warning: format specifies type 'unsigned
 short' but the argument has type 'int'
Message-ID: <202204060503.2pTsIRTu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   a4b855ffcf1d116e65df68fa6f5df04878bc0083
commit: 569092d7590362c7148ac768a923783886248c3b [4/9] rxrpc: Don't use a ring buffer for call Tx queue
config: riscv-randconfig-r042-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060503.2pTsIRTu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/569092d7590362c7148ac768a923783886248c3b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout 569092d7590362c7148ac768a923783886248c3b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/rxrpc/local_object.c:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/rxrpc/local_object.c:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/rxrpc/local_object.c:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
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
   9 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


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
