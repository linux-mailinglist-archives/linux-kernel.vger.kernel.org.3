Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B8E52C9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiESCmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiESCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:42:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C6D682D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652928165; x=1684464165;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AIWIkbNCcUBOYv3nACVTaf4KrgIX64Kcu2vC3ITYeaY=;
  b=n8VlSbfGG5aKT/PArED5aOtNBaODFgPnvztK5dqyzoHALMvtkIJYMDQF
   nHZi0BeIdzb6Qqmt4HjuD5TRvMfbJv22nMFGtFvizYOcYce+JGNA0xB2e
   qwE/YM/XHpsIVvkHhwUUuk7c4MmfYcK3Q71pwrLXv4swvejNjzK2Jsa28
   dW1B4KP8e+cdovjYaHnqwggbTA7RiLhtcDjEyfVhrRJr77wr4/BtmosKE
   QHBqPWR2cYK7MIJUqWvgDF5sRw0gZ/vmv4XeM1XcDDbgvdaDbh0cyG/c4
   4QbYaB11XqzUP6I8yUYcOkckYbLX6EdKbMU54/nuADrVDhcCgDg04Mlhs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335034321"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="335034321"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 19:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="898555303"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2022 19:42:43 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrW7e-0002xh-VO;
        Thu, 19 May 2022 02:42:42 +0000
Date:   Thu, 19 May 2022 10:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 53/55]
 include/linux/rcupdate.h:207:34: error: implicit declaration of function
 'rcu_tasks_trace_qs'; did you mean 'rcu_tasks_classic_qs'?
Message-ID: <202205191043.pLKc0AwM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   b2a7e376a9dcfa2de46236696dfdd48275edf63d
commit: 840470b0e655a13aae153f3b46d1e02fadf5c06a [53/55] fixup! tasks-rcu: Track blocked RCU Tasks Trace readers
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220519/202205191043.pLKc0AwM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/840470b0e655a13aae153f3b46d1e02fadf5c06a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 840470b0e655a13aae153f3b46d1e02fadf5c06a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/core.c:5235:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5235 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:11,
                    from include/linux/dcache.h:8,
                    from include/linux/fs.h:8,
                    from include/linux/highmem.h:5,
                    from kernel/sched/core.c:9:
   kernel/sched/core.c: In function '__schedule':
>> include/linux/rcupdate.h:207:34: error: implicit declaration of function 'rcu_tasks_trace_qs'; did you mean 'rcu_tasks_classic_qs'? [-Werror=implicit-function-declaration]
     207 | #define rcu_tasks_qs(t, preempt) rcu_tasks_trace_qs(t);
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/rcutiny.h:74:17: note: in expansion of macro 'rcu_tasks_qs'
      74 |                 rcu_tasks_qs(current, (preempt)); \
         |                 ^~~~~~~~~~~~
   kernel/sched/core.c:6279:9: note: in expansion of macro 'rcu_note_context_switch'
    6279 |         rcu_note_context_switch(!!sched_mode);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:9432:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9432 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:9460:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9460 | void __init sched_init(void)
         |             ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +207 include/linux/rcupdate.h

   201	
   202	#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
   203	void exit_tasks_rcu_start(void);
   204	void exit_tasks_rcu_finish(void);
   205	#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
   206	#define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 > 207	#define rcu_tasks_qs(t, preempt) rcu_tasks_trace_qs(t);
   208	#define rcu_note_voluntary_context_switch(t) do { } while (0)
   209	#define call_rcu_tasks call_rcu
   210	#define synchronize_rcu_tasks synchronize_rcu
   211	static inline void exit_tasks_rcu_start(void) { }
   212	static inline void exit_tasks_rcu_finish(void) { }
   213	#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
   214	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
