Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FF4BD2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 01:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbiBUAkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 19:40:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBUAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 19:40:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583149695
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 16:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645404004; x=1676940004;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O5UhviWjVtkykzvON/54bUuwHi/lJmIznX9Q1kvWxPY=;
  b=kAqBwNoRe7v6V3PV0fhQruKMvEsTicEkD9i2eppefiK8gsRSMlksGWKG
   N3Ox8UxUeiRj5hhK2rslwQgKwJ3JA15lfob+IDpe0FHGkALufui/eTZ1k
   Tu0rUiQbBMmYJ8qXpzhgSv4vYBvgScOIcbFGlYsrlEruE+HL8I2FJSjmZ
   jq+ynjcbS1EMygajrZ2JsGM+yJGfDXBTrk7ivWt7Lyh7fMOL1EXsk5U+D
   MuGdEYtSf6MI07z/9o8iybxNE7i0XKBZqWzcodARLHsLRtMOZwhsIBj2O
   M/LW8NL6qZAgS+/eoDkkiNmGVh2dnllmRK7IDBPj9TYwx6Z0u4+P2zEQp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251595417"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251595417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 16:40:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="683044226"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 16:40:00 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLwkC-00015e-10; Mon, 21 Feb 2022 00:40:00 +0000
Date:   Mon, 21 Feb 2022 08:39:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 563/2574]
 include/linux/thread_info.h:26:32: error: implicit declaration of function
 'task_thread_info'
Message-ID: <202202210837.WwxLXNe0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 4f6c6b91b52731738bf7ad7781424f7081f05e62 [563/2574] headers/deps: Move task->thread_info to per_task()
config: s390-randconfig-r016-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210837.WwxLXNe0-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4f6c6b91b52731738bf7ad7781424f7081f05e62
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4f6c6b91b52731738bf7ad7781424f7081f05e62
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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
