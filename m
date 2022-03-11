Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C994D61C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348641AbiCKMwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiCKMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:52:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE11B60A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647003065; x=1678539065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DVQafXw2BCd4N+HVxNNtcqcB/Uq6XqHUwrDL7dKYpaE=;
  b=EQEJKaiyjds8Nzv5+TpCWd3A1Y9aVLea5jkCcW8o6ozz1vTSVgHthCTp
   l3We5+eVhPvEDDzIDjAtzak8m81wX7cP2/gDSOxR8APl0gPIHCk6+S8RC
   iinlK9bv0pI+q3shvwvooXHkZAADYoRbL8jCeZ8XChlFZo1q1KFiusSnC
   jAe2bzJ4W0hMtnZkbB65swm7V0wIOCvtZwXCu2iKfveFQaMPC6LVqsKDC
   nr03xiyCB9PKLDntBWVOMtsG3lS8Quj8EOBBBdnvunoQ7OFJvLo6Gqe6V
   wrjopj/3zeE3OVDjIP+B/pAJPDMoGQouR7Kgrykw0POAWSQyCNC5cRFYD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237738788"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="237738788"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 04:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="538987474"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2022 04:51:04 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSejX-0006PM-EN; Fri, 11 Mar 2022 12:51:03 +0000
Date:   Fri, 11 Mar 2022 20:50:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.17-rc1 4/8]
 arch/arm/mm/init.c:307:13: warning: no previous prototype for
 'mem_init_print_arm_info'
Message-ID: <202203112022.UTwSPbtn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.17-rc1
head:   66e9038ef48dc66c07b12443b73e2d1f3f12cbab
commit: 18e0d99ee35450767fc8222f1727febdd2a4deac [4/8] ARM: Print virtual memory info again
config: arm-randconfig-r025-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112022.UTwSPbtn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=18e0d99ee35450767fc8222f1727febdd2a4deac
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.17-rc1
        git checkout 18e0d99ee35450767fc8222f1727febdd2a4deac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mm/init.c:97:13: warning: no previous prototype for 'setup_dma_zone' [-Wmissing-prototypes]
      97 | void __init setup_dma_zone(const struct machine_desc *mdesc)
         |             ^~~~~~~~~~~~~~
>> arch/arm/mm/init.c:307:13: warning: no previous prototype for 'mem_init_print_arm_info' [-Wmissing-prototypes]
     307 | void __init mem_init_print_arm_info(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/mem_init_print_arm_info +307 arch/arm/mm/init.c

   306	
 > 307	void __init mem_init_print_arm_info(void)
   308	{
   309	#define MLM(b, t) b, t, ((t) - (b)) >> 20
   310		pr_notice("Virtual kernel memory layout:\n"
   311			  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   312			  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   313			  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   314	#ifdef CONFIG_MODULES
   315			  "    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n",
   316	#endif
   317			  "     kernel : 0x%08lx - 0x%08lx   (%4ld MB)\n",
   318			  MLM(FIXADDR_START, FIXADDR_END),
   319			  MLM(VMALLOC_START, VMALLOC_END),
   320			  MLM(PAGE_OFFSET, (unsigned long)high_memory),
   321	#ifdef CONFIG_MODULES
   322			  MLM(MODULES_VADDR, MODULES_END),
   323	#endif
   324			  /* From beginning of .text to end of .bss */
   325			  MLM((unsigned long)_text, (unsigned long)__bss_stop));
   326	#undef MLM
   327	}
   328	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
