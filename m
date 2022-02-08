Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D214AD76B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348901AbiBHLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356834AbiBHLJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:09:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6FAC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644318563; x=1675854563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vw5L34v5z7ro1Pr/rbQizdHnMJaPjSEjkP3wX6XWVtY=;
  b=nrC0e+mP2VcGWmqLzu/uLgrlxgC0TzAbAAZ7ICLHyerBURstyfnYzLBD
   PL3UgqhaAXVVEE2IGxGVHe/NiiBwunTrU86P6i9Jnaqlj1sKI8Cuk4bKQ
   LKGBUofp1tmvGjHY8Fpj8099+eZeA6eh0Crz6y+Y6dI4kizkOXZU2Pp0s
   WHrO/+FwjI+zSefFIRUQQCQiFoglCqZ3A36g/5rBsqAsA6e7xVlE911tz
   uxBZVES4dNvF0h/LzfC+0FugEA/9+hpzz/7xY4RjvjbKQ1tSY8NhGhR03
   ME1hBkmFisMzrMKFYTm3lGut3r4D9kEfzCvxzVFpVHiSJPH9XeJD/DxLI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273455262"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="273455262"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 03:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="499535293"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2022 03:09:21 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHON6-00005c-Qr; Tue, 08 Feb 2022 11:09:20 +0000
Date:   Tue, 8 Feb 2022 19:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 32/32]
 arch/arm64/include/asm/preempt.h:85:1: error: type defaults to 'int' in
 declaration of 'DECLARE_STATIC_KEY_TRUE'
Message-ID: <202202081918.RDLHzFHh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   ac7695a93a578befdcf4900a90860bf19e057e1b
commit: ac7695a93a578befdcf4900a90860bf19e057e1b [32/32] arm64: support PREEMPT_DYNAMIC
config: arm64-randconfig-s031-20220208 (https://download.01.org/0day-ci/archive/20220208/202202081918.RDLHzFHh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=ac7695a93a578befdcf4900a90860bf19e057e1b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout ac7695a93a578befdcf4900a90860bf19e057e1b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/preempt.h:78,
                    from include/linux/smp.h:110,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> arch/arm64/include/asm/preempt.h:85:1: warning: data definition has no type or storage class
      85 | DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/preempt.h:85:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_TRUE' [-Werror=implicit-int]
>> arch/arm64/include/asm/preempt.h:85:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +85 arch/arm64/include/asm/preempt.h

    84	
  > 85	DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
    86	void dynamic_preempt_schedule(void);
    87	#define __preempt_schedule()		dynamic_preempt_schedule()
    88	void dynamic_preempt_schedule_notrace(void);
    89	#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
    90	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
