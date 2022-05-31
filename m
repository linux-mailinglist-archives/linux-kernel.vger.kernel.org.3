Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83B538AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbiEaErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiEaErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:47:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C1DEE9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653972418; x=1685508418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dsljJZJpdOgC/cqu+DzOSVS7dwFiKyD01thxVC8LABc=;
  b=GaftfBJStrhWEUpaSWSVODVxukMV+CdN2FKpvNw3RX/DiZ6U9gbamTfe
   vEanDVjNuqz0cpXOJJ6o2JBIFC1NJ1Klaxikj2MWVXYL8mZpGnq6dBu9S
   uDeWmrnfqUxKCqbXklL7txPL5y+Ebo7iLGhuQCRtdVa0pHi0L59nsEGzQ
   /hDdbdzwnXRy1DWVhZOZOLFAEEoMoi5qpdaXkHSCGI3cF7aR+ygc5V7a2
   d0fqGLa2Qs5QuCjiuxT1nO/Dwif1SF/TjTlqfQn2YhAvP6twIvtgPeAeR
   RH/zUslxs6GFK1zPnUEbUIbCr4iYpvoFRm+oUVcTcjZkP3PqLkt42DVg1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="255009464"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="255009464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 21:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="551600518"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2022 21:46:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvtmR-0002KY-G5;
        Tue, 31 May 2022 04:46:55 +0000
Date:   Tue, 31 May 2022 12:46:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 20/20]
 arch/arm64/include/asm/memory.h:311:16: error: implicit declaration of
 function '__phys_to_pfn'
Message-ID: <202205311221.dNwFCY8b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   eae5a86aafbe4bfbcb5c21b271073b014626a472
commit: eae5a86aafbe4bfbcb5c21b271073b014626a472 [20/20] arm64: memory: Make virt_to_pfn() a static inline
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220531/202205311221.dNwFCY8b-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=eae5a86aafbe4bfbcb5c21b271073b014626a472
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout eae5a86aafbe4bfbcb5c21b271073b014626a472
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from arch/arm64/include/asm/thread_info.h:17,
                    from include/linux/thread_info.h:60,
                    from arch/arm64/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
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
   arch/arm64/include/asm/memory.h: In function 'virt_to_pfn':
>> arch/arm64/include/asm/memory.h:311:16: error: implicit declaration of function '__phys_to_pfn' [-Werror=implicit-function-declaration]
     311 |         return __phys_to_pfn(__virt_to_phys((unsigned long)(x)));
         |                ^~~~~~~~~~~~~
>> arch/arm64/include/asm/memory.h:311:61: error: 'x' undeclared (first use in this function)
     311 |         return __phys_to_pfn(__virt_to_phys((unsigned long)(x)));
         |                                                             ^
   arch/arm64/include/asm/memory.h:311:61: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__phys_to_pfn +311 arch/arm64/include/asm/memory.h

   308	
   309	static inline unsigned long virt_to_pfn(const void *p)
   310	{
 > 311		return __phys_to_pfn(__virt_to_phys((unsigned long)(x)));
   312	}
   313	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
