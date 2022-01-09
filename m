Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC2488CE9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 23:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiAIWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 17:44:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:49628 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237329AbiAIWoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 17:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641768242; x=1673304242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iyjTCySE0zve+TY3ce5l8pWwsA4o7tvfTiZksYf9uac=;
  b=LFXkAthRVHOLC8Pnn4tzg+7FBibUHdcmnoge7+blRKgRfU3oTiuAF4E/
   2I/+hlqBT4H4cJGy8oTrmrYxrBZ3UYX+2Pc9MimNOd1P1/jEkqlYu2dp5
   z/kPgxdLnEe8oq+/ZSrv44pofCSWFLHJR6L26xWDFqPNv4AFssZxO2E3n
   U436QoS6jgCsbGI+TMKmNVWZ4X2YFszL48EamBmw5bmhTDYxdWT81N/Hn
   ZbhoLkRnFmyw7uYUiJCkGOItr4Q0qm+Gei/yZDlMAeEv/DEEshKFGMF42
   GYAJOr2zXqQLcfQBHJYpIf9MrieHaEq9Yz7Y2oJSJCd3ehp/TJcI7ivtU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="306479708"
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="306479708"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 14:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="764355337"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2022 14:43:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6gus-0001wX-KW; Sun, 09 Jan 2022 22:43:58 +0000
Date:   Mon, 10 Jan 2022 06:43:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1105/2380]
 arch/powerpc/include/asm/inst.h:143:17: error: implicit declaration of
 function 'sprintf'
Message-ID: <202201100628.S5iEUAdr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351bfbf7f1e8dce84b605c8007c98dd603c4ca4d
commit: cda4a13524f2ac766110f33d7851a490d39accd4 [1105/2380] headers/deps: Add header dependencies to .c files: <linux/kernel.h>
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220110/202201100628.S5iEUAdr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=cda4a13524f2ac766110f33d7851a490d39accd4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout cda4a13524f2ac766110f33d7851a490d39accd4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 351bfbf7f1e8dce84b605c8007c98dd603c4ca4d builds fine.
      It only hurts bisectability.

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/hw_breakpoint.h:12,
                    from arch/powerpc/include/asm/processor.h:43,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:61,
                    from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from kernel/bounds.c:10:
   arch/powerpc/include/asm/cpu_has_feature.h:21:31: error: array type has incomplete element type 'struct static_key_true'
      21 | extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
         |                               ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cpu_has_feature.h: In function 'cpu_has_feature':
   arch/powerpc/include/asm/cpu_has_feature.h:32:14: error: 'static_key_initialized' undeclared (first use in this function)
      32 |         if (!static_key_initialized) {
         |              ^~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cpu_has_feature.h:32:14: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/include/asm/cpu_has_feature.h:46:16: error: implicit declaration of function 'static_branch_likely' [-Werror=implicit-function-declaration]
      46 |         return static_branch_likely(&cpu_feature_keys[i]);
         |                ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cpu_has_feature.h:25:13: warning: variable 'i' set but not used [-Wunused-but-set-variable]
      25 |         int i;
         |             ^
   In file included from arch/powerpc/include/asm/hw_breakpoint.h:13,
                    from arch/powerpc/include/asm/processor.h:43,
                    from arch/powerpc/include/asm/thread_info.h:40,
                    from include/linux/thread_info.h:61,
                    from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from kernel/bounds.c:10:
   arch/powerpc/include/asm/inst.h: In function '__ppc_inst_as_str':
>> arch/powerpc/include/asm/inst.h:143:17: error: implicit declaration of function 'sprintf' [-Werror=implicit-function-declaration]
     143 |                 sprintf(str, "%08x %08x", ppc_inst_val(x), ppc_inst_suffix(x));
         |                 ^~~~~~~
   arch/powerpc/include/asm/inst.h:1:1: note: include '<stdio.h>' or provide a declaration of 'sprintf'
     +++ |+#include <stdio.h>
       1 | /* SPDX-License-Identifier: GPL-2.0-or-later */
>> arch/powerpc/include/asm/inst.h:143:17: warning: incompatible implicit declaration of built-in function 'sprintf' [-Wbuiltin-declaration-mismatch]
     143 |                 sprintf(str, "%08x %08x", ppc_inst_val(x), ppc_inst_suffix(x));
         |                 ^~~~~~~
   arch/powerpc/include/asm/inst.h:143:17: note: include '<stdio.h>' or provide a declaration of 'sprintf'
   In file included from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/atomic_api.h:1,
                    from include/linux/jump_label.h:76,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from kernel/bounds.c:10:
   arch/powerpc/include/asm/thread_info.h: In function 'clear_thread_local_flags':
   include/linux/thread_info.h:26:32: error: implicit declaration of function 'task_thread_info'; did you mean 'current_thread_info'? [-Werror=implicit-function-declaration]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h:159:34: note: in expansion of macro 'current_thread_info'
     159 |         struct thread_info *ti = current_thread_info();
         |                                  ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:26:32: warning: initialization of 'struct thread_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h:159:34: note: in expansion of macro 'current_thread_info'
     159 |         struct thread_info *ti = current_thread_info();
         |                                  ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h: In function 'test_thread_local_flags':
   include/linux/thread_info.h:26:32: warning: initialization of 'struct thread_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/thread_info.h:165:34: note: in expansion of macro 'current_thread_info'
     165 |         struct thread_info *ti = current_thread_info();
         |                                  ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/sprintf +143 arch/powerpc/include/asm/inst.h

50428fdc53ba48 Jordan Niethe 2020-06-02  139  
50428fdc53ba48 Jordan Niethe 2020-06-02  140  static inline char *__ppc_inst_as_str(char str[PPC_INST_STR_LEN], struct ppc_inst x)
50428fdc53ba48 Jordan Niethe 2020-06-02  141  {
50428fdc53ba48 Jordan Niethe 2020-06-02  142  	if (ppc_inst_prefixed(x))
50428fdc53ba48 Jordan Niethe 2020-06-02 @143  		sprintf(str, "%08x %08x", ppc_inst_val(x), ppc_inst_suffix(x));
50428fdc53ba48 Jordan Niethe 2020-06-02  144  	else
50428fdc53ba48 Jordan Niethe 2020-06-02  145  		sprintf(str, "%08x", ppc_inst_val(x));
50428fdc53ba48 Jordan Niethe 2020-06-02  146  
50428fdc53ba48 Jordan Niethe 2020-06-02  147  	return str;
50428fdc53ba48 Jordan Niethe 2020-06-02  148  }
50428fdc53ba48 Jordan Niethe 2020-06-02  149  

:::::: The code at line 143 was first introduced by commit
:::::: 50428fdc53ba48f6936b10dfdc0d644972403908 powerpc: Add a ppc_inst_as_str() helper

:::::: TO: Jordan Niethe <jniethe5@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
