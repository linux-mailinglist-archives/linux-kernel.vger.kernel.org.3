Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E94ADBD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379132AbiBHO7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379093AbiBHO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6CC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644332382; x=1675868382;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3zdqxWQwoN/nUQJbyJaitI/dH1KXQ3pdiHsoHtgxz6M=;
  b=Xn5E1XfWVZy6oolfq+qkflaInHC4pWTMNMMZE2HONGmQSCL3YVKO7wM+
   XEiCeFyHf7Aj3iN+ecwCpruaz+ZUaWZzAxYviZdmw204crrGFbnbd23Ex
   4FA5u4USGMZ9oifZaXzo99nZRpCQVnp4u4l7fQnmnhN++i19YmyZSMvEt
   fdZpSA7HwNZaYafITcbuAlFBLa3g6vRt6gP2vfLfXdH15yqbone0VBzfN
   eN6s0kOKT4GazGWBC8Ij+eBO7+J4/E6dW/I2+uvOWOPz2D90QjuoDNv4A
   guel1M5JZd/hwBZOwi0Jnn57rnCHaGL1NS7ZWBcr2sD2INgs4rFNIkoCA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248725663"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248725663"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 06:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="499584724"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2022 06:59:40 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHRxz-0000L3-KD; Tue, 08 Feb 2022 14:59:39 +0000
Date:   Tue, 8 Feb 2022 22:58:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 32/32]
 arch/arm64/include/asm/preempt.h:85:25: error: a parameter list without
 types is only allowed in a function definition
Message-ID: <202202082223.QmYxE9Ko-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm64-randconfig-r025-20220208 (https://download.01.org/0day-ci/archive/20220208/202202082223.QmYxE9Ko-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=ac7695a93a578befdcf4900a90860bf19e057e1b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout ac7695a93a578befdcf4900a90860bf19e057e1b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:13:
   In file included from include/linux/irqdomain.h:35:
   In file included from include/linux/of.h:17:
   In file included from include/linux/kobject.h:20:
   In file included from include/linux/sysfs.h:16:
   In file included from include/linux/kernfs.h:11:
   In file included from include/linux/mutex.h:17:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:110:
   In file included from include/linux/preempt.h:78:
>> arch/arm64/include/asm/preempt.h:85:1: warning: declaration specifier missing, defaulting to 'int'
   DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
   ^
   int
>> arch/arm64/include/asm/preempt.h:85:25: error: a parameter list without types is only allowed in a function definition
   DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
                           ^
   1 warning and 1 error generated.
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
