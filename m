Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04D52ACB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352910AbiEQU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiEQU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:27:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FD5527EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652819278; x=1684355278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3vKHHKgoh+36e4WdvV0tcuXmnLDyIUERFmKWJ2bCzMg=;
  b=XYi6IucXtWX6rEuLP8/uH4qOcnmF28j+ScjfmvQ70NVdRqZIralbQhlV
   USSrbcypvplyBthVW04/8brhYuPT1MRMuBFzBs2vLqC9e1rgbXhM0/iHw
   wkAy1Pg/K9+ArRMpnU/IMEgUIXr9HQOLf9q9m3RIL0wIkhYMmwQMww977
   MnRbpWBiCT6QyaMTkfaIbGmGHCaxZd9RXvnYByamPgN3yyLtfV3T53Mj7
   1qtliGKo/BVi2HgFKAPYRsDO6HojuoTWI2TUKt7xI05/Y5WSSknidDKx4
   3yJmnAoExkvBrbZvTJUvl2FSykNH4/zJGtopm6XC8a6NAbQU24eQ+jZJk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251832560"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251832560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 13:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="545078895"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2022 13:27:57 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr3nQ-0001N2-KA;
        Tue, 17 May 2022 20:27:56 +0000
Date:   Wed, 18 May 2022 04:27:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/9]
 arch/arm/include/asm/memory.h:333:33: error: 'KERNEL_PFN_OFFSET' undeclared;
 did you mean 'KERNEL_OFFSET'?
Message-ID: <202205180458.0iXDsFhX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   67a8d6eb3d015908f35d6091c02f17d7c3b55bf3
commit: 52cbc963c5c9daba74109e9782e3487cdf48fe5c [8/9] ARM: Compile the kernel into VMALLOC
config: arm-lpc18xx_defconfig (https://download.01.org/0day-ci/archive/20220518/202205180458.0iXDsFhX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=52cbc963c5c9daba74109e9782e3487cdf48fe5c
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 52cbc963c5c9daba74109e9782e3487cdf48fe5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/page.h:163,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arm/kernel/asm-offsets.c:11:
   arch/arm/include/asm/memory.h: In function 'virt_to_pfn':
>> arch/arm/include/asm/memory.h:333:33: error: 'KERNEL_PFN_OFFSET' undeclared (first use in this function); did you mean 'KERNEL_OFFSET'?
     333 |                                 KERNEL_PFN_OFFSET);
         |                                 ^~~~~~~~~~~~~~~~~
         |                                 KERNEL_OFFSET
   arch/arm/include/asm/memory.h:333:33: note: each undeclared identifier is reported only once for each function it appears in
   make[2]: *** [scripts/Makefile.build:120: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +333 arch/arm/include/asm/memory.h

   322	
   323	static inline unsigned long virt_to_pfn(const void *p)
   324	{
   325		unsigned long kaddr = (unsigned long)p;
   326		if (!IS_ENABLED(CONFIG_ARM_KERNEL_IN_VMALLOC)) {
   327			return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
   328				PHYS_PFN_OFFSET);
   329		} else {
   330			if ((kaddr >= KERNEL_OFFSET) &&
   331			    (kaddr < (KERNEL_OFFSET + KERNEL_SECTION_SIZE))) {
   332				return (((kaddr - KERNEL_OFFSET) >> PAGE_SHIFT) +
 > 333					KERNEL_PFN_OFFSET);
   334			} else {
   335				return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
   336					PHYS_PFN_OFFSET);
   337			}
   338		}
   339	}
   340	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
