Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B74A7E07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349080AbiBCCkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:40:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:8455 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349059AbiBCCkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643856041; x=1675392041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3BqHO5iBDQRAvTrrrqjQBePcpT8OWh7S6XcUczEbbbw=;
  b=SCoWRxn8YOXpb7oMEYllMPq7Kf/uy47e/Cd4keQq5PVzL7pFazEYZhGz
   DtBGQT/MN9ndsV2gRSZItKYIs3Irc42yUBZdk17YlS/jMdNrYq+WUL++k
   t8EzbvKx9ituCSu80nFBT1OVEfJq3TjyJLw6PHWJ+sTgaFMTiQn/JxLKY
   ybNkm1Y1bgm399w3SP1VK28WCbrN6XVdnEtkkK8bZpM74SUCwRbfnEw1t
   6iC6MNsD572o5nDoH+3rFrgpL7gcCYmd1OshB0fe4pSwVcAU+Od1CxXE2
   v14vPgEXHfura0fdakDLWmNvwpCIDO8hyYmSH5s0MihrYiOSWYX0FFjsW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272554487"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="272554487"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 18:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483090592"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 18:40:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFS34-000VSD-Ej; Thu, 03 Feb 2022 02:40:38 +0000
Date:   Thu, 3 Feb 2022 10:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Tomas Jedlicka <tomas.jedlicka@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        David Mc Lean <david.mclean@oracle.com>,
        Vincent Lim <vincent.lim@oracle.com>
Subject: [oracle-dtrace:v2/5.17-rc2 8/10]
 include/uapi/asm-generic/unistd.h:889:24: error: 'sys_waitfd' undeclared
 here (not in a function); did you mean 'sys_waitid'?
Message-ID: <202202030948.BprVzIKX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/oracle/dtrace-linux-kernel v2/5.17-rc2
head:   28b391e36df8679828aedd18dae0ee5526512d4d
commit: 83f02cf9b0ce18b6a27d34c6a25933791779e807 [8/10] waitfd: new syscall implementing waitpid() over fds
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220203/202202030948.BprVzIKX-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/oracle/dtrace-linux-kernel/commit/83f02cf9b0ce18b6a27d34c6a25933791779e807
        git remote add oracle-dtrace https://github.com/oracle/dtrace-linux-kernel
        git fetch --no-tags oracle-dtrace v2/5.17-rc2
        git checkout 83f02cf9b0ce18b6a27d34c6a25933791779e807
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:863:1: note: in expansion of macro '__SC_COMP'
     863 | __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:865:1: note: in expansion of macro '__SYSCALL'
     865 | __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[442]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:865:1: note: in expansion of macro '__SYSCALL'
     865 | __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:867:1: note: in expansion of macro '__SYSCALL'
     867 | __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[443]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:867:1: note: in expansion of macro '__SYSCALL'
     867 | __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:870:1: note: in expansion of macro '__SYSCALL'
     870 | __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[444]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:870:1: note: in expansion of macro '__SYSCALL'
     870 | __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:872:1: note: in expansion of macro '__SYSCALL'
     872 | __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[445]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:872:1: note: in expansion of macro '__SYSCALL'
     872 | __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:874:1: note: in expansion of macro '__SYSCALL'
     874 | __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[446]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:874:1: note: in expansion of macro '__SYSCALL'
     874 | __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:881:1: note: in expansion of macro '__SYSCALL'
     881 | __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[448]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:881:1: note: in expansion of macro '__SYSCALL'
     881 | __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:884:1: note: in expansion of macro '__SYSCALL'
     884 | __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[449]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:884:1: note: in expansion of macro '__SYSCALL'
     884 | __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:887:1: note: in expansion of macro '__SYSCALL'
     887 | __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[450]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:887:1: note: in expansion of macro '__SYSCALL'
     887 | __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
         | ^~~~~~~~~
>> include/uapi/asm-generic/unistd.h:889:24: error: 'sys_waitfd' undeclared here (not in a function); did you mean 'sys_waitid'?
     889 | __SYSCALL(__NR_waitfd, sys_waitfd)
         |                        ^~~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:37: note: in definition of macro '__SYSCALL'
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/nds32/include/uapi/asm/unistd.h:15:1: note: in expansion of macro '__SYSCALL'
      15 | __SYSCALL(__NR_cacheflush, sys_cacheflush)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[244]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/nds32/include/uapi/asm/unistd.h:15:1: note: in expansion of macro '__SYSCALL'
      15 | __SYSCALL(__NR_cacheflush, sys_cacheflush)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: warning: initialized field overwritten [-Woverride-init]
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/nds32/include/uapi/asm/unistd.h:16:1: note: in expansion of macro '__SYSCALL'
      16 | __SYSCALL(__NR_fp_udfiex_crtl, sys_fp_udfiex_crtl)
         | ^~~~~~~~~
   arch/nds32/kernel/syscall_table.c:10:36: note: (near initialization for 'sys_call_table[245]')
      10 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   arch/nds32/include/uapi/asm/unistd.h:16:1: note: in expansion of macro '__SYSCALL'
      16 | __SYSCALL(__NR_fp_udfiex_crtl, sys_fp_udfiex_crtl)
         | ^~~~~~~~~


vim +889 include/uapi/asm-generic/unistd.h

   885	
   886	#define __NR_set_mempolicy_home_node 450
   887	__SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
   888	#define __NR_waitfd 473
 > 889	__SYSCALL(__NR_waitfd, sys_waitfd)
   890	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
