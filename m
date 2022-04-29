Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4205140CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiD2DBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiD2DBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:01:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829BBB099
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651201072; x=1682737072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iwmaNv8Mz1sl8eYpdeW1vmgH0LaPk2vCD5QTVC0RnHY=;
  b=h5WRhlN8l8huo9mdvWsYPJ5K2Bi7B4GCzzMTQJqU/P/Rl8qhPefvOrpj
   UcHrYqlQW4Hh/AeqrXp4Qt0iR9/wSDOmmQlL7NE7gq8F5ajsoB6sF4eyP
   b/nPS1wU8IZEKBVwNUPosx2QkNiDdMbu3QSWC10N5GOPPr1cMPWCPdLOf
   lEyHlmV4+rgcn1dQxXBsWXjBls7Ualj2o65e+8ou9prOW4sNk7e43C9CU
   9fG5KgfoFQKPM3TMcU5wC7wQYReq2PA+03ub8NYgWmz67ZXI1gkEoysxD
   tX9De60WO5jMOMiBdWWfTi3iTDBPhJTuTh52oKeroKNtSRqjHIXZ/0p/o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="247064830"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="247064830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 19:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731830511"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2022 19:57:49 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkGpJ-0005v1-4K;
        Fri, 29 Apr 2022 02:57:49 +0000
Date:   Fri, 29 Apr 2022 10:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 3/7]
 include/linux/sched/jobctl.h:23:2: error: stray '#' in program
Message-ID: <202204291009.ntJSd5uS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   a1b437cfec0d2b0060cf85538c2379c74fb63ad5
commit: 4cb4f3dc01c45f8a1621f13b55705ba4a6844081 [3/7] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220429/202204291009.ntJSd5uS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4cb4f3dc01c45f8a1621f13b55705ba4a6844081
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 4cb4f3dc01c45f8a1621f13b55705ba4a6844081
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched/signal.h:8,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/cgroup.h:17,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
>> include/linux/sched/jobctl.h:23:2: error: stray '#' in program
      23 | q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
         |  ^
   include/linux/sched/jobctl.h:23:1: error: unknown type name 'q'
      23 | q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
         | ^
>> include/linux/sched/jobctl.h:23:10: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'JOBCTL_STOPPED_BIT'
      23 | q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
         |          ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
>> include/linux/sched/jobctl.h:35:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      35 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:298:36: note: in expansion of macro 'JOBCTL_STOPPED'
     298 |                 current->jobctl |= JOBCTL_STOPPED;
         |                                    ^~~~~~~~~~~~~~
   include/linux/sched/jobctl.h:35:41: note: each undeclared identifier is reported only once for each function it appears in
      35 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:298:36: note: in expansion of macro 'JOBCTL_STOPPED'
     298 |                 current->jobctl |= JOBCTL_STOPPED;
         |                                    ^~~~~~~~~~~~~~
   include/linux/sched/signal.h: In function 'signal_wake_up':
>> include/linux/sched/jobctl.h:35:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      35 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:444:32: note: in expansion of macro 'JOBCTL_STOPPED'
     444 |                 t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
         |                                ^~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:120: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +23 include/linux/sched/jobctl.h

    13	
    14	#define JOBCTL_STOP_DEQUEUED_BIT 16	/* stop signal dequeued */
    15	#define JOBCTL_STOP_PENDING_BIT	17	/* task should stop for group stop */
    16	#define JOBCTL_STOP_CONSUME_BIT	18	/* consume group stop count */
    17	#define JOBCTL_TRAP_STOP_BIT	19	/* trap for STOP */
    18	#define JOBCTL_TRAP_NOTIFY_BIT	20	/* trap for NOTIFY */
    19	#define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
    20	#define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
    21	#define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
    22	#define JOBCTL_DELAY_WAKEKILL_BIT	24	/* delay killable wakeups */
  > 23	q#define JOBCTL_STOPPED_BIT	25	/* do_signal_stop() */
    24	#define JOBCTL_TRACED_BIT	26	/* ptrace_stop() */
    25	
    26	#define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
    27	#define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
    28	#define JOBCTL_STOP_CONSUME	(1UL << JOBCTL_STOP_CONSUME_BIT)
    29	#define JOBCTL_TRAP_STOP	(1UL << JOBCTL_TRAP_STOP_BIT)
    30	#define JOBCTL_TRAP_NOTIFY	(1UL << JOBCTL_TRAP_NOTIFY_BIT)
    31	#define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
    32	#define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
    33	#define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
    34	#define JOBCTL_DELAY_WAKEKILL	(1UL << JOBCTL_DELAY_WAKEKILL_BIT)
  > 35	#define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
    36	#define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
    37	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
