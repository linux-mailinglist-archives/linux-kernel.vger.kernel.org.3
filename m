Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6161E484C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiAECf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:35:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:44398 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbiAECfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641350125; x=1672886125;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qyz+YA3MnH1X/OtpJBOSOsuhyjXINtWuxG2bQFgejmM=;
  b=UYcDbNIIlWTgTnPnJCwneAj56ytpoGKsM/enPzF7ZuNl4uzwI6k2fxqP
   JluQftlUpgeeIM+1BiQiprtKyIoh5imBP8eNBV620GFCIln/Gjp7AjMAF
   3+7406iu7TYFxsPufuInwIwAJk7ORvr1FA9YKHrsN+hgWm9A1BKXQ0El8
   Gfng3URlytPF4xSxuYWQHq6cZSldsqCSeGFBjaGO0/RvwenyIOARUjMfz
   KLlf52u9+ecPFG1ZRBpI06iPCi1oDCt5bcQR+fHTxtnyyrF20yOIAj9L8
   bWq/lKKzBWvZT+7zWMlwOhw2Deo/PQjuqn2kQEtZuv5nEJKVhNlkDYT2e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223029606"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="223029606"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 18:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="472298683"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 18:35:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4w94-000GAY-Ie; Wed, 05 Jan 2022 02:35:22 +0000
Date:   Wed, 5 Jan 2022 10:34:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jianbo Liu <jianbol@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:24:29:
 warning: 'strncpy' output may be truncated copying 16 bytes from a string of
 length 20
Message-ID: <202201051026.81C1NmK2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 9724fd5d9c2a0d3686b799ed5ca90cb9378ca4f2 net/mlx5: Bridge, add tracepoints
date:   7 months ago
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220105/202201051026.81C1NmK2-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9724fd5d9c2a0d3686b799ed5ca90cb9378ca4f2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9724fd5d9c2a0d3686b799ed5ca90cb9378ca4f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:113,
                    from drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:12:
   drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h: In function 'trace_event_raw_event_mlx5_esw_bridge_fdb_template':
>> drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:24:29: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 20 [-Wstringop-truncation]
      24 |                             strncpy(__entry->dev_name,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
      25 |                                     netdev_name(fdb->dev),
         |                                     ~~~~~~~~~~~~~~~~~~~~~~
      26 |                                     IFNAMSIZ);
         |                                     ~~~~~~~~~
   include/trace/trace_events.h:706:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     706 |         { assign; }                                                     \
         |           ^~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:23:21: note: in expansion of macro 'TP_fast_assign'
      23 |                     TP_fast_assign(
         |                     ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:113,
                    from drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:12:
   drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h: In function 'perf_trace_mlx5_esw_bridge_fdb_template':
>> drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:24:29: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 20 [-Wstringop-truncation]
      24 |                             strncpy(__entry->dev_name,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
      25 |                                     netdev_name(fdb->dev),
         |                                     ~~~~~~~~~~~~~~~~~~~~~~
      26 |                                     IFNAMSIZ);
         |                                     ~~~~~~~~~
   include/trace/perf.h:66:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      66 |         { assign; }                                                     \
         |           ^~~~~~
   drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h:23:21: note: in expansion of macro 'TP_fast_assign'
      23 |                     TP_fast_assign(
         |                     ^~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by
   - PROVE_LOCKING && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT


vim +/strncpy +24 drivers/net/ethernet/mellanox/mlx5/core/esw/diag/bridge_tracepoint.h

    12	
    13	DECLARE_EVENT_CLASS(mlx5_esw_bridge_fdb_template,
    14			    TP_PROTO(const struct mlx5_esw_bridge_fdb_entry *fdb),
    15			    TP_ARGS(fdb),
    16			    TP_STRUCT__entry(
    17				    __array(char, dev_name, IFNAMSIZ)
    18				    __array(unsigned char, addr, ETH_ALEN)
    19				    __field(u16, vid)
    20				    __field(u16, flags)
    21				    __field(unsigned int, used)
    22				    ),
    23			    TP_fast_assign(
  > 24				    strncpy(__entry->dev_name,
    25					    netdev_name(fdb->dev),
    26					    IFNAMSIZ);
    27				    memcpy(__entry->addr, fdb->key.addr, ETH_ALEN);
    28				    __entry->vid = fdb->key.vid;
    29				    __entry->flags = fdb->flags;
    30				    __entry->used = jiffies_to_msecs(jiffies - fdb->lastuse)
    31				    ),
    32			    TP_printk("net_device=%s addr=%pM vid=%hu flags=%hx used=%u",
    33				      __entry->dev_name,
    34				      __entry->addr,
    35				      __entry->vid,
    36				      __entry->flags,
    37				      __entry->used / 1000)
    38		);
    39	
    40	DEFINE_EVENT(mlx5_esw_bridge_fdb_template,
    41		     mlx5_esw_bridge_fdb_entry_init,
    42		     TP_PROTO(const struct mlx5_esw_bridge_fdb_entry *fdb),
    43		     TP_ARGS(fdb)
    44		);
    45	DEFINE_EVENT(mlx5_esw_bridge_fdb_template,
    46		     mlx5_esw_bridge_fdb_entry_refresh,
    47		     TP_PROTO(const struct mlx5_esw_bridge_fdb_entry *fdb),
    48		     TP_ARGS(fdb)
    49		);
    50	DEFINE_EVENT(mlx5_esw_bridge_fdb_template,
    51		     mlx5_esw_bridge_fdb_entry_cleanup,
    52		     TP_PROTO(const struct mlx5_esw_bridge_fdb_entry *fdb),
    53		     TP_ARGS(fdb)
    54		);
    55	
    56	DECLARE_EVENT_CLASS(mlx5_esw_bridge_vlan_template,
    57			    TP_PROTO(const struct mlx5_esw_bridge_vlan *vlan),
    58			    TP_ARGS(vlan),
    59			    TP_STRUCT__entry(
    60				    __field(u16, vid)
    61				    __field(u16, flags)
    62				    ),
    63			    TP_fast_assign(
    64				    __entry->vid = vlan->vid;
    65				    __entry->flags = vlan->flags;
    66				    ),
    67			    TP_printk("vid=%hu flags=%hx",
    68				      __entry->vid,
    69				      __entry->flags)
    70		);
    71	
    72	DEFINE_EVENT(mlx5_esw_bridge_vlan_template,
    73		     mlx5_esw_bridge_vlan_create,
    74		     TP_PROTO(const struct mlx5_esw_bridge_vlan *vlan),
    75		     TP_ARGS(vlan)
    76		);
    77	DEFINE_EVENT(mlx5_esw_bridge_vlan_template,
    78		     mlx5_esw_bridge_vlan_cleanup,
    79		     TP_PROTO(const struct mlx5_esw_bridge_vlan *vlan),
    80		     TP_ARGS(vlan)
    81		);
    82	
    83	DECLARE_EVENT_CLASS(mlx5_esw_bridge_port_template,
    84			    TP_PROTO(const struct mlx5_esw_bridge_port *port),
    85			    TP_ARGS(port),
    86			    TP_STRUCT__entry(
    87				    __field(u16, vport_num)
    88				    ),
    89			    TP_fast_assign(
    90				    __entry->vport_num = port->vport_num;
    91				    ),
    92			    TP_printk("vport_num=%hu", __entry->vport_num)
    93		);
    94	
    95	DEFINE_EVENT(mlx5_esw_bridge_port_template,
    96		     mlx5_esw_bridge_vport_init,
    97		     TP_PROTO(const struct mlx5_esw_bridge_port *port),
    98		     TP_ARGS(port)
    99		);
   100	DEFINE_EVENT(mlx5_esw_bridge_port_template,
   101		     mlx5_esw_bridge_vport_cleanup,
   102		     TP_PROTO(const struct mlx5_esw_bridge_port *port),
   103		     TP_ARGS(port)
   104		);
   105	
   106	#endif
   107	
   108	/* This part must be outside protection */
   109	#undef TRACE_INCLUDE_PATH
   110	#define TRACE_INCLUDE_PATH esw/diag
   111	#undef TRACE_INCLUDE_FILE
   112	#define TRACE_INCLUDE_FILE bridge_tracepoint
 > 113	#include <trace/define_trace.h>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
