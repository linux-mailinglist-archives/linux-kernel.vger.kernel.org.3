Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B168C4D61CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348660AbiCKMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348667AbiCKMxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:53:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5A01B7187
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647003126; x=1678539126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5QSetv+PP1A/fdkcp2EKiLWClyc2pYwIJ2+iPsNa67w=;
  b=iAA3mUrUVQGRwdc239FlnFuHcZjR000EMqtK+OxN4IRHnl+PQazpP308
   2Sx2gmGADazsE/Ztc3sbTbfUtoNFKKExV/8Piyf0ibcYKIZCSQQJ9YvKt
   tiw5luL1XBry7UNriVkEIrfE2hxRMFltKNm9Oai5h5Wp0UmAhRwE18evf
   Vw8SKEYv0yDjNmEKYMwMNx+7Eg1BQ+3MhgXhLguZXm/6MMuhh9ORtCGhn
   flwBITM7PtQx4bKuXBRQoVIdS3N/v+rWjmUeeaZrBVzB/w2K9/KQLnTAn
   6SehtVOqfFveruOiFWalPznjvZXkCCuCauHKh3ejGvnvHVS0iVjzbasJx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253129071"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="253129071"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 04:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="496755736"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2022 04:52:04 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSekV-0006Pe-Ig; Fri, 11 Mar 2022 12:52:03 +0000
Date:   Fri, 11 Mar 2022 20:51:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.17-rc1 4/8]
 arch/arm/mm/init.c:307:13: warning: no previous prototype for function
 'mem_init_print_arm_info'
Message-ID: <202203112052.m5tYcVx1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.17-rc1
head:   66e9038ef48dc66c07b12443b73e2d1f3f12cbab
commit: 18e0d99ee35450767fc8222f1727febdd2a4deac [4/8] ARM: Print virtual memory info again
config: arm-vt8500_v6_v7_defconfig (https://download.01.org/0day-ci/archive/20220311/202203112052.m5tYcVx1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=18e0d99ee35450767fc8222f1727febdd2a4deac
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.17-rc1
        git checkout 18e0d99ee35450767fc8222f1727febdd2a4deac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mm/init.c:97:13: warning: no previous prototype for function 'setup_dma_zone' [-Wmissing-prototypes]
   void __init setup_dma_zone(const struct machine_desc *mdesc)
               ^
   arch/arm/mm/init.c:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init setup_dma_zone(const struct machine_desc *mdesc)
   ^
   static 
>> arch/arm/mm/init.c:307:13: warning: no previous prototype for function 'mem_init_print_arm_info' [-Wmissing-prototypes]
   void __init mem_init_print_arm_info(void)
               ^
   arch/arm/mm/init.c:307:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init mem_init_print_arm_info(void)
   ^
   static 
   2 warnings generated.


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
