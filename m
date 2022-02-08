Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1617E4AE4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbiBHWeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386515AbiBHUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:48:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5FC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644353289; x=1675889289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T1Dq70dqxoGsKjC3M8rAVhSwDwdOT6gVU2rJNwMN/fY=;
  b=aVdVvj7Yqa2mXwqBAZRfcgSD4QlVlTNTuS2j7l4BOUQ9HVWIIpMOGDgf
   w4oxL9q1D+/Yz0nHdivUBvA8ET+dm7qBXhUbuZW/6Sn1f72RNqk4SK7Pg
   CRuuaNKmaCJI4xgYn/cm75HGhA67fJVz0L1S4u6FpbGYHZ9KpnBWtFB8d
   sjrUjvqkUSxYME8v5sMUXjgRh8TrvXARy488VSrfQ2ej6wNjsyqNYPVf5
   Zd6zEpG9EZb+ZQrscyQG+Pxx7pg31GfK1nn38AfAri5w1oAoiIY7ksGsG
   obQ71T9kdpp4w7idHSoK3fYYaSX/v3zIesSmuTamB35fxV17ADS7ATnLY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229020844"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="229020844"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632976632"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2022 12:48:07 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHXPD-0000j5-2E; Tue, 08 Feb 2022 20:48:07 +0000
Date:   Wed, 9 Feb 2022 04:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/preempt-dynamic-static-key 7/7]
 arch/arm64/include/asm/preempt.h:85:25: error: a parameter list without
 types is only allowed in a function definition
Message-ID: <202202090439.RWVJ0AMJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/preempt-dynamic-static-key
head:   106f60395c0b424e5e05a69bbd40075152f9a17f
commit: 106f60395c0b424e5e05a69bbd40075152f9a17f [7/7] arm64: support PREEMPT_DYNAMIC
config: arm64-randconfig-r025-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090439.RWVJ0AMJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=106f60395c0b424e5e05a69bbd40075152f9a17f
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/preempt-dynamic-static-key
        git checkout 106f60395c0b424e5e05a69bbd40075152f9a17f
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
