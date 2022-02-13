Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB614B3DE4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiBMWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:02:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbiBMWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:02:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B7541AB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644789732; x=1676325732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GRRDRwAyuRUthgsnp7PMFzr7hutQ2aKWIrRPUmcF2J4=;
  b=Lt/dI/+/GR9ID6MGGR+21Xf5ixpuwLOqhp88BMu+fMJP02sapsG2NUJV
   Abej/C71QQaUyDAwxOhrkPyzOVHiEHBX1W2CRRQ6/IrqFBoyOxb+ZYpFF
   BYQH5XTGnK26/m2kkZDzd1kOvb3hMN/8tDwiRdLUlPlmolVuM5yMhF3vi
   sCApjIf/AxW94lU81ZURM9WPsFM6ahxFdTv+l1TBDAgwr5R2jeg1rNgj5
   zHO8H7BNNMZ1a2Lj2zJ0UzGZcEBbdJn5PS8A0N4Pw4B+phlDShrLadE5v
   XOnYOlhckM+TB/UOBqECLt4vpPSt9TOC27pwW8oRB1Cbkw/QbJgpwT+nK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230614861"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="230614861"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501415210"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 14:02:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJMwb-0007tE-SG; Sun, 13 Feb 2022 22:02:09 +0000
Date:   Mon, 14 Feb 2022 06:02:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-02 5/11] ld.lld: error: duplicate symbol:
 pifo_map_dequeue
Message-ID: <202202140559.L2j44zUI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-02
head:   26dde94b299bc277f7a99a99ba64b4363964e833
commit: 34cc5abfbae0dfcb6967c54cb80f7595bc9c5c37 [5/11] Add a PIFO map type for queueing packets
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220214/202202140559.L2j44zUI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=34cc5abfbae0dfcb6967c54cb80f7595bc9c5c37
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-02
        git checkout 34cc5abfbae0dfcb6967c54cb80f7595bc9c5c37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from net/socket.c:55:
   In file included from include/linux/bpf-cgroup.h:5:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/socket.c:2206:6: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
           int max_optlen;
               ^
   2 warnings generated.
--
   In file included from net/core/sock.c:133:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   1 warning generated.
--
   In file included from net/core/dev.c:95:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/core/dev.c:4971:1: warning: unused function 'sch_handle_ingress' [-Wunused-function]
   sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
   ^
   net/core/dev.c:5120:19: warning: unused function 'nf_ingress' [-Wunused-function]
   static inline int nf_ingress(struct sk_buff *skb, struct packet_type **pt_prev,
                     ^
   3 warnings generated.
--
   In file included from net/core/net-traces.c:35:
   In file included from include/trace/events/tcp.h:12:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   In file included from net/core/net-traces.c:50:
   In file included from include/trace/events/neigh.h:255:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:873:
   include/trace/events/neigh.h:42:20: warning: variable 'pin6' set but not used [-Wunused-but-set-variable]
                   struct in6_addr *pin6;
                                    ^
   In file included from net/core/net-traces.c:50:
   In file included from include/trace/events/neigh.h:255:
   In file included from include/trace/define_trace.h:103:
   In file included from include/trace/perf.h:107:
   include/trace/events/neigh.h:42:20: warning: variable 'pin6' set but not used [-Wunused-but-set-variable]
                   struct in6_addr *pin6;
                                    ^
   3 warnings generated.
--
   In file included from net/ipv4/route.c:95:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/ipv4/route.c:869:6: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
           int log_martians;
               ^
   2 warnings generated.
--
   In file included from net/ipv4/tcp_output.c:40:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/ipv4/tcp_output.c:188:3: warning: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
                   NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/ip.h:292:41: note: expanded from macro 'NET_ADD_STATS'
   #define NET_ADD_STATS(net, field, adnd) SNMP_ADD_STATS((net)->mib.net_statistics, field, adnd)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/snmp.h:143:4: note: expanded from macro 'SNMP_ADD_STATS'
                           this_cpu_add(mib->mibs[field], addend)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
   #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   <scratch space>:148:1: note: expanded from here
   this_cpu_add_4
   ^
   arch/x86/include/asm/percpu.h:268:34: note: expanded from macro 'this_cpu_add_4'
   #define this_cpu_add_4(pcp, val)        percpu_add_op(4, volatile, (pcp), val)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/percpu.h:127:31: note: expanded from macro 'percpu_add_op'
                                 ((val) == 1 || (val) == -1)) ?            \
                                                ~~~~~ ^  ~~
   2 warnings generated.
--
   In file included from net/netfilter/ipvs/ip_vs_core.c:34:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/netfilter/ipvs/ip_vs_core.c:1596:8: warning: variable 'outer_proto' set but not used [-Wunused-but-set-variable]
           char *outer_proto = "IPIP";
                 ^
   2 warnings generated.
--
   In file included from net/netfilter/ipvs/ip_vs_xmit.c:33:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/netfilter/ipvs/ip_vs_xmit.c:107:1: warning: unused function '__mtu_check_toobig_v6' [-Wunused-function]
   __mtu_check_toobig_v6(const struct sk_buff *skb, u32 mtu)
   ^
   2 warnings generated.
--
   In file included from net/mptcp/options.c:11:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:1966:19: warning: no previous prototype for function 'pifo_map_dequeue' [-Wmissing-prototypes]
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
                     ^
   include/linux/bpf.h:1966:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct xdp_frame *pifo_map_dequeue(struct bpf_map *map, u64 flags)
   ^
   static 
   net/mptcp/options.c:554:21: warning: parameter 'remaining' set but not used [-Wunused-but-set-parameter]
                                             unsigned int remaining,
                                                          ^
   2 warnings generated.
--
>> ld.lld: error: duplicate symbol: pifo_map_dequeue
   >>> defined in net/bluetooth/bluetooth.o(l2cap_core.o)
   >>> defined in net/bluetooth/bluetooth.o(l2cap_sock.o)
--
>> ld.lld: error: duplicate symbol: pifo_map_dequeue
   >>> defined in net/netfilter/ipset/ip_set.o(ip_set_getport.o)
   >>> defined in net/netfilter/ipset/ip_set.o(pfxlen.o)
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
