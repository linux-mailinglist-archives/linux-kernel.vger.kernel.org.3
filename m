Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2984DA6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352786AbiCPAVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352781AbiCPAVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:21:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D35DE47
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647390029; x=1678926029;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uyRbb64jAwyTgkz30/o5xUNR06MPFlvgVBBudxREcv0=;
  b=oDAIJBsSM2Cjjw3Er1HjjgeQCUd2SImWlHQFtHUyCmBfwtjRUXhybXYe
   Gzq4vjDHGSFMrtRV1yb3YI9xTF+iVtb3e3J3zF6DtGoouiLk+LXJONCih
   DlFu9rLn90urd5dALXl0L+LpNOVnO/2dVv7ozHXgibub3/3PSMmFr6Kzu
   QOGCAwPQNjwx4RgS3xSoCC+j/Y+Pig+Sh0jm473TNhkk8XiP9wezcICmw
   jSDn2PrhsTXntBp35b6ZEXKtiNEm3+MwLM14ushcfzX6b3l99Zy7HY9QW
   VTd3tlbs6C9g7RRZ/ouDDEhKvAfwGqPRty9p+K6R8KkM9Gaoaz/Un+dmu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256642911"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256642911"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516096595"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 17:20:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHOo-000Bgc-L0; Wed, 16 Mar 2022 00:20:22 +0000
Date:   Wed, 16 Mar 2022 08:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 558/2335] include/linux/thread_info.h:26:32:
 error: implicit declaration of function 'task_thread_info'
Message-ID: <202203160827.7cTN3ShQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: fc65f6666073b489472bc5f3625d1f90d3dde51f [558/2335] headers/deps: Move task->thread_info to per_task()
config: s390-randconfig-r044-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160827.7cTN3ShQ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fc65f6666073b489472bc5f3625d1f90d3dde51f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout fc65f6666073b489472bc5f3625d1f90d3dde51f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   arch/s390/include/asm/preempt.h: In function '__preempt_count_dec_and_test':
>> include/linux/thread_info.h:26:32: error: implicit declaration of function 'task_thread_info' [-Werror=implicit-function-declaration]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:64:29: note: in expansion of macro 'current_thread_info'
      64 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: in expansion of macro 'test_thread_flag'
     103 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   arch/s390/include/asm/preempt.h:110:49: note: in expansion of macro 'tif_need_resched'
     110 |         return !--S390_lowcore.preempt_count && tif_need_resched();
         |                                                 ^~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:26:32: warning: passing argument 1 of 'test_ti_thread_flag' makes pointer from integer without a cast [-Wint-conversion]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                |
         |                                int
   include/linux/sched/thread_info_api_lowlevel.h:64:29: note: in expansion of macro 'current_thread_info'
      64 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: in expansion of macro 'test_thread_flag'
     103 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   arch/s390/include/asm/preempt.h:110:49: note: in expansion of macro 'tif_need_resched'
     110 |         return !--S390_lowcore.preempt_count && tif_need_resched();
         |                                                 ^~~~~~~~~~~~~~~~
   In file included from include/linux/thread_info.h:63,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/linux/sched/thread_info_api_lowlevel.h:39:59: note: expected 'struct thread_info *' but argument is of type 'int'
      39 | static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
         |                                       ~~~~~~~~~~~~~~~~~~~~^~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/smp.h:12,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   arch/s390/include/asm/preempt.h: In function 'should_resched':
>> include/linux/thread_info.h:26:32: warning: passing argument 1 of 'test_ti_thread_flag' makes pointer from integer without a cast [-Wint-conversion]
      26 | # define current_thread_info() task_thread_info(current)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                |
         |                                int
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/sched/thread_info_api_lowlevel.h:64:29: note: in expansion of macro 'current_thread_info'
      64 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: in expansion of macro 'test_thread_flag'
     103 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   arch/s390/include/asm/preempt.h:116:25: note: in expansion of macro 'tif_need_resched'
     116 |                         tif_need_resched());
         |                         ^~~~~~~~~~~~~~~~
   In file included from include/linux/thread_info.h:63,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/linux/sched/thread_info_api_lowlevel.h:39:59: note: expected 'struct thread_info *' but argument is of type 'int'
      39 | static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
         |                                       ~~~~~~~~~~~~~~~~~~~~^~
   In file included from include/linux/sched.h:12,
                    from include/linux/hardirq.h:9,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/linux/sched/per_task.h: At top level:
   include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/task_thread_info +26 include/linux/thread_info.h

    16	
    17	#ifdef CONFIG_THREAD_INFO_IN_TASK
    18	/* We are racing with <linux/sched/thread_info.h> to do this: */
    19	# ifndef current_thread_info
    20	  /*
    21	   * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
    22	   * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
    23	   * including <asm/current.h> can cause a circular dependency on some platforms.
    24	   */
    25	# include <asm/current.h>
  > 26	# define current_thread_info() task_thread_info(current)
    27	# endif
    28	#endif
    29	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
