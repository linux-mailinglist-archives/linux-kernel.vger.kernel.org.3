Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A445E585832
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiG3DOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiG3DOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:14:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D83E0D2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659150876; x=1690686876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ouKHMW5OsQwRdxhdVr0DdUGBWguB2w0ugievmYDNaKI=;
  b=dvE2Z/oB30Wi+qTZiNfxwAfPbxo6CYi3lSw2g1vNsrP0WV0BOIkHvOXP
   ZsgW7itt05fgSkPfOtAhBKteY0wlK/Cvb7YciRT5Ks44MYOeR/yvGlrjW
   u3FMoafR0ll16XzPMsVQrTicKZep+OlGRI4TsGDi+7KzmNmGzl81+SK5u
   1ON+RRDh0fmjDPH1CyHsV5BIsaNAKVhk2xOr+86SrqaUeahI2hqzT/1E4
   yVT4D1g61VuT9vgzhvXOlXC2IfI1K7VKNrydWTcXa1gXhgfgQSEkyFxpy
   VQsz+Li5AoB2Kfq4BkwDucSEGhn/vh+7fPCteKeAiO2lxfSEKcuD0eFA0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268653712"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="268653712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 20:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="629595734"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 20:14:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHcvy-000CKH-2N;
        Sat, 30 Jul 2022 03:14:34 +0000
Date:   Sat, 30 Jul 2022 11:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202207301145.GkvEseBz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e65c6a46df94c8d76ea1129eb2d4564670c6f214
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   4 months ago
config: arm-randconfig-s033-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301145.GkvEseBz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void *dest
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
--
   arch/arm/mach-imx/pm-imx5.c:244:17: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:25: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:42: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:51: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx5_cpu_suspend_info *suspend_info @@     got void [noderef] __iomem *static [addressable] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse:     expected struct imx5_cpu_suspend_info *suspend_info
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse:     got void [noderef] __iomem *static [addressable] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void *dest
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
--
   arch/arm/mach-imx/pm-imx6.c:373:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void *s
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx6_cpu_pm_info *pm_info @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     expected struct imx6_cpu_pm_info *pm_info
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void *dest
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *

vim +145 arch/arm/mach-mvebu/pmsu.c

3076cc58c958090 Gregory CLEMENT 2014-07-23  121  
3076cc58c958090 Gregory CLEMENT 2014-07-23  122  /*
3076cc58c958090 Gregory CLEMENT 2014-07-23  123   * This function sets up the boot address workaround needed for SMP
3076cc58c958090 Gregory CLEMENT 2014-07-23  124   * boot on Armada 375 Z1 and cpuidle on Armada 370. It unmaps the
3076cc58c958090 Gregory CLEMENT 2014-07-23  125   * BootROM Mbus window, and instead remaps a crypto SRAM into which a
3076cc58c958090 Gregory CLEMENT 2014-07-23  126   * custom piece of code is copied to replace the problematic BootROM.
3076cc58c958090 Gregory CLEMENT 2014-07-23  127   */
3076cc58c958090 Gregory CLEMENT 2014-07-23  128  int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
3076cc58c958090 Gregory CLEMENT 2014-07-23  129  			     unsigned int crypto_eng_attribute,
3076cc58c958090 Gregory CLEMENT 2014-07-23  130  			     phys_addr_t resume_addr_reg)
3076cc58c958090 Gregory CLEMENT 2014-07-23  131  {
3076cc58c958090 Gregory CLEMENT 2014-07-23  132  	void __iomem *sram_virt_base;
d0d378ff451a66e Ethan Tuttle    2018-06-19  133  	u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
3076cc58c958090 Gregory CLEMENT 2014-07-23  134  
3076cc58c958090 Gregory CLEMENT 2014-07-23  135  	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
3076cc58c958090 Gregory CLEMENT 2014-07-23  136  	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
3076cc58c958090 Gregory CLEMENT 2014-07-23  137  				    SRAM_PHYS_BASE, SZ_64K);
3076cc58c958090 Gregory CLEMENT 2014-07-23  138  
3076cc58c958090 Gregory CLEMENT 2014-07-23  139  	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
3076cc58c958090 Gregory CLEMENT 2014-07-23  140  	if (!sram_virt_base) {
3076cc58c958090 Gregory CLEMENT 2014-07-23  141  		pr_err("Unable to map SRAM to setup the boot address WA\n");
3076cc58c958090 Gregory CLEMENT 2014-07-23  142  		return -ENOMEM;
3076cc58c958090 Gregory CLEMENT 2014-07-23  143  	}
3076cc58c958090 Gregory CLEMENT 2014-07-23  144  
3076cc58c958090 Gregory CLEMENT 2014-07-23 @145  	memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
3076cc58c958090 Gregory CLEMENT 2014-07-23  146  
3076cc58c958090 Gregory CLEMENT 2014-07-23  147  	/*
3076cc58c958090 Gregory CLEMENT 2014-07-23  148  	 * The last word of the code copied in SRAM must contain the
3076cc58c958090 Gregory CLEMENT 2014-07-23  149  	 * physical base address of the PMSU register. We
3076cc58c958090 Gregory CLEMENT 2014-07-23  150  	 * intentionally store this address in the native endianness
3076cc58c958090 Gregory CLEMENT 2014-07-23  151  	 * of the system.
3076cc58c958090 Gregory CLEMENT 2014-07-23  152  	 */
3076cc58c958090 Gregory CLEMENT 2014-07-23  153  	__raw_writel((unsigned long)resume_addr_reg,
3076cc58c958090 Gregory CLEMENT 2014-07-23  154  		     sram_virt_base + code_len - 4);
3076cc58c958090 Gregory CLEMENT 2014-07-23  155  
3076cc58c958090 Gregory CLEMENT 2014-07-23  156  	iounmap(sram_virt_base);
3076cc58c958090 Gregory CLEMENT 2014-07-23  157  
3076cc58c958090 Gregory CLEMENT 2014-07-23  158  	return 0;
3076cc58c958090 Gregory CLEMENT 2014-07-23  159  }
3076cc58c958090 Gregory CLEMENT 2014-07-23  160  

:::::: The code at line 145 was first introduced by commit
:::::: 3076cc58c958090ad50acf50fc855845e3462523 ARM: mvebu: add a common function for the boot address work around

:::::: TO: Gregory CLEMENT <gregory.clement@free-electrons.com>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
