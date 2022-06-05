Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD153DC7E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiFEPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFEPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:14:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA92D4D245
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654442088; x=1685978088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EKzCYUB+G5H6J3yL+rPO13Jwi1/ubXh6rP67lI562yo=;
  b=b+jMCiYAdZ9yjjaz11pfOvfGisfDACqQTCEhcY6bPCzXgDO35z/VdFxH
   xNll6xECvgRAgQwFmGSI4IfkXIwp/hgv+P6JGerbL7+u7o+4sS98btwrQ
   F0nAy28aisWGNcHFkzZoZgk2hMJov5sxyqaI5MNL41Qrk9tXmQc/gIgx6
   1yaWduseMhFXwklEOAxRw2n7Ss43n9+xNy6me+O8J1IkeA6YZgQ9GICEe
   rp6GcR/dpbTVQp8zxia5QIVy78nZ7P5hP1gGKmtEKF4diCNZe9nrk8ghe
   t+YQBTERKcQnQJnmkqGxP5xP6tYst6+HbTg0gjc8tzit4JLXRw72Bs2aC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276625876"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="276625876"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 08:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="758170331"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2022 08:14:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxrxm-000C0l-Mk;
        Sun, 05 Jun 2022 15:14:46 +0000
Date:   Sun, 5 Jun 2022 23:13:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 27/33] include/linux/sched/idle.h:28:9:
 error: implicit declaration of function 'arch_set_bit'; did you mean
 'arch_test_bit'?
Message-ID: <202206052314.vgAUvUv3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   5aca393851ce7ebb9a3405bb4ffd4f38d96949e4
commit: bb0533e97a1f03b96874efacec607cffb5fa7a3a [27/33] cpuidle,sched: Remove annotations from TIF_{POLLING_NRFLAG,NEED_RESCHED}
config: sh-buildonly-randconfig-r006-20220605 (https://download.01.org/0day-ci/archive/20220605/202206052314.vgAUvUv3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=bb0533e97a1f03b96874efacec607cffb5fa7a3a
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout bb0533e97a1f03b96874efacec607cffb5fa7a3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched/topology.h:7,
                    from include/linux/energy_model.h:10,
                    from include/linux/device.h:16,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/sh/kernel/asm-offsets.c:16:
   include/linux/sched/idle.h: In function '__current_set_polling':
>> include/linux/sched/idle.h:28:9: error: implicit declaration of function 'arch_set_bit'; did you mean 'arch_test_bit'? [-Werror=implicit-function-declaration]
      28 |         arch_set_bit(TIF_POLLING_NRFLAG,
         |         ^~~~~~~~~~~~
         |         arch_test_bit
   include/linux/sched/idle.h: In function '__current_clr_polling':
>> include/linux/sched/idle.h:47:9: error: implicit declaration of function 'arch_clear_bit'; did you mean 'arch___clear_bit'? [-Werror=implicit-function-declaration]
      47 |         arch_clear_bit(TIF_POLLING_NRFLAG,
         |         ^~~~~~~~~~~~~~
         |         arch___clear_bit
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/sh/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +28 include/linux/sched/idle.h

    25	
    26	static __always_inline void __current_set_polling(void)
    27	{
  > 28		arch_set_bit(TIF_POLLING_NRFLAG,
    29			     (unsigned long *)(&current_thread_info()->flags));
    30	}
    31	
    32	static __always_inline bool __must_check current_set_polling_and_test(void)
    33	{
    34		__current_set_polling();
    35	
    36		/*
    37		 * Polling state must be visible before we test NEED_RESCHED,
    38		 * paired by resched_curr()
    39		 */
    40		smp_mb__after_atomic();
    41	
    42		return unlikely(tif_need_resched());
    43	}
    44	
    45	static __always_inline void __current_clr_polling(void)
    46	{
  > 47		arch_clear_bit(TIF_POLLING_NRFLAG,
    48			       (unsigned long *)(&current_thread_info()->flags));
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
