Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7458CFF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbiHHV4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiHHV4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:56:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F818D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659995796; x=1691531796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BnJokY09lT4LD22YU6LskLmEYancGP7NeFWMQhwH/PQ=;
  b=hFtOCY3CUtmbD0gR5bPd7Uvc95lxheaU4oBccXyvAGE1vcHrqprGCQqY
   BCKVzqevMBuKnLCKds4gQTlm493sEyrCvp5fiEM3PWa1BN+z8xkJJzrDr
   zHlDpdoTbRalCuv/1XvNf1ro9m84oRSFe21u87g6pHcyh5EERk/Cs+RAM
   HUYytwsb63qrrUu3+Frs72cMHLgfhipErec4DsiTXHCLAYwG6XhBrizoU
   Vs1PvYfU2tbvidb6O9Scx+rZfxpQ8CqB+vgEGHwjW97eVftyBjWkEwXht
   jHEGwwrLSKBzbbl1lxggZHFryDjFTegKadubi/s53iIyeijSyb3qFIhJx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="273749073"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="273749073"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="580534161"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2022 14:56:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLAjh-000MYj-3C;
        Mon, 08 Aug 2022 21:56:33 +0000
Date:   Tue, 9 Aug 2022 05:55:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202208090505.55iG35ny-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8a684e2e110376c58f0bfa30fb3855d1e319670
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: powerpc-randconfig-s031-20220808 (https://download.01.org/0day-ci/archive/20220809/202208090505.55iG35ny-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/52xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse:     expected void *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse:     got void [noderef] __iomem *irq_0x500
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse:     got void [noderef] __iomem *irq_0x500
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse:     expected void *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse:     expected void *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse:     expected void *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram

vim +133 arch/powerpc/platforms/52xx/mpc52xx_pm.c

2e1ee1f76684c5 Domen Puncer 2007-05-07  112  
2e1ee1f76684c5 Domen Puncer 2007-05-07  113  int mpc52xx_pm_enter(suspend_state_t state)
2e1ee1f76684c5 Domen Puncer 2007-05-07  114  {
2e1ee1f76684c5 Domen Puncer 2007-05-07  115  	u32 clk_enables;
2e1ee1f76684c5 Domen Puncer 2007-05-07  116  	u32 msr, hid0;
2e1ee1f76684c5 Domen Puncer 2007-05-07  117  	u32 intr_main_mask;
d3e0e02804a5f4 Domen Puncer 2007-07-09  118  	void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
2e1ee1f76684c5 Domen Puncer 2007-05-07  119  	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
741c5640a15a23 Kees Cook    2018-07-02  120  	char saved_0x500[0x600-0x500];
741c5640a15a23 Kees Cook    2018-07-02  121  
741c5640a15a23 Kees Cook    2018-07-02  122  	if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
741c5640a15a23 Kees Cook    2018-07-02  123  		return -ENOMEM;
2e1ee1f76684c5 Domen Puncer 2007-05-07  124  
2e1ee1f76684c5 Domen Puncer 2007-05-07  125  	/* disable all interrupts in PIC */
2e1ee1f76684c5 Domen Puncer 2007-05-07  126  	intr_main_mask = in_be32(&intr->main_mask);
2e1ee1f76684c5 Domen Puncer 2007-05-07  127  	out_be32(&intr->main_mask, intr_main_mask | 0x1ffff);
2e1ee1f76684c5 Domen Puncer 2007-05-07  128  
2e1ee1f76684c5 Domen Puncer 2007-05-07  129  	/* don't let DEC expire any time soon */
2e1ee1f76684c5 Domen Puncer 2007-05-07  130  	mtspr(SPRN_DEC, 0x7fffffff);
2e1ee1f76684c5 Domen Puncer 2007-05-07  131  
2e1ee1f76684c5 Domen Puncer 2007-05-07  132  	/* save SRAM */
2e1ee1f76684c5 Domen Puncer 2007-05-07 @133  	memcpy(saved_sram, sram, sram_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  134  
2e1ee1f76684c5 Domen Puncer 2007-05-07  135  	/* copy low level suspend code to sram */
2e1ee1f76684c5 Domen Puncer 2007-05-07 @136  	memcpy(sram, mpc52xx_ds_sram, mpc52xx_ds_sram_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  137  
2e1ee1f76684c5 Domen Puncer 2007-05-07  138  	out_8(&cdm->ccs_sleep_enable, 1);
2e1ee1f76684c5 Domen Puncer 2007-05-07  139  	out_8(&cdm->osc_sleep_enable, 1);
2e1ee1f76684c5 Domen Puncer 2007-05-07  140  	out_8(&cdm->ccs_qreq_test, 1);
2e1ee1f76684c5 Domen Puncer 2007-05-07  141  
2e1ee1f76684c5 Domen Puncer 2007-05-07  142  	/* disable all but SDRAM and bestcomm (SRAM) clocks */
2e1ee1f76684c5 Domen Puncer 2007-05-07  143  	clk_enables = in_be32(&cdm->clk_enables);
2e1ee1f76684c5 Domen Puncer 2007-05-07  144  	out_be32(&cdm->clk_enables, clk_enables & 0x00088000);
2e1ee1f76684c5 Domen Puncer 2007-05-07  145  
2e1ee1f76684c5 Domen Puncer 2007-05-07  146  	/* disable power management */
2e1ee1f76684c5 Domen Puncer 2007-05-07  147  	msr = mfmsr();
2e1ee1f76684c5 Domen Puncer 2007-05-07  148  	mtmsr(msr & ~MSR_POW);
2e1ee1f76684c5 Domen Puncer 2007-05-07  149  
2e1ee1f76684c5 Domen Puncer 2007-05-07  150  	/* enable sleep mode, disable others */
2e1ee1f76684c5 Domen Puncer 2007-05-07  151  	hid0 = mfspr(SPRN_HID0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  152  	mtspr(SPRN_HID0, (hid0 & ~(HID0_DOZE | HID0_NAP | HID0_DPM)) | HID0_SLEEP);
2e1ee1f76684c5 Domen Puncer 2007-05-07  153  
2e1ee1f76684c5 Domen Puncer 2007-05-07  154  	/* save original, copy our irq handler, flush from dcache and invalidate icache */
2e1ee1f76684c5 Domen Puncer 2007-05-07 @155  	memcpy(saved_0x500, irq_0x500, mpc52xx_ds_cached_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07 @156  	memcpy(irq_0x500, mpc52xx_ds_cached, mpc52xx_ds_cached_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  157  	flush_icache_range((unsigned long)irq_0x500, irq_0x500_stop);
2e1ee1f76684c5 Domen Puncer 2007-05-07  158  
2e1ee1f76684c5 Domen Puncer 2007-05-07  159  	/* call low-level sleep code */
2e1ee1f76684c5 Domen Puncer 2007-05-07  160  	mpc52xx_deep_sleep(sram, sdram, cdm, intr);
2e1ee1f76684c5 Domen Puncer 2007-05-07  161  
2e1ee1f76684c5 Domen Puncer 2007-05-07  162  	/* restore original irq handler */
2e1ee1f76684c5 Domen Puncer 2007-05-07  163  	memcpy(irq_0x500, saved_0x500, mpc52xx_ds_cached_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  164  	flush_icache_range((unsigned long)irq_0x500, irq_0x500_stop);
2e1ee1f76684c5 Domen Puncer 2007-05-07  165  
2e1ee1f76684c5 Domen Puncer 2007-05-07  166  	/* restore old power mode */
2e1ee1f76684c5 Domen Puncer 2007-05-07  167  	mtmsr(msr & ~MSR_POW);
2e1ee1f76684c5 Domen Puncer 2007-05-07  168  	mtspr(SPRN_HID0, hid0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  169  	mtmsr(msr);
2e1ee1f76684c5 Domen Puncer 2007-05-07  170  
2e1ee1f76684c5 Domen Puncer 2007-05-07  171  	out_be32(&cdm->clk_enables, clk_enables);
2e1ee1f76684c5 Domen Puncer 2007-05-07  172  	out_8(&cdm->ccs_sleep_enable, 0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  173  	out_8(&cdm->osc_sleep_enable, 0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  174  
2e1ee1f76684c5 Domen Puncer 2007-05-07  175  	/* restore SRAM */
2e1ee1f76684c5 Domen Puncer 2007-05-07  176  	memcpy(sram, saved_sram, sram_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  177  
2e1ee1f76684c5 Domen Puncer 2007-05-07  178  	/* reenable interrupts in PIC */
2e1ee1f76684c5 Domen Puncer 2007-05-07  179  	out_be32(&intr->main_mask, intr_main_mask);
2e1ee1f76684c5 Domen Puncer 2007-05-07  180  
2e1ee1f76684c5 Domen Puncer 2007-05-07  181  	return 0;
2e1ee1f76684c5 Domen Puncer 2007-05-07  182  }
2e1ee1f76684c5 Domen Puncer 2007-05-07  183  

:::::: The code at line 133 was first introduced by commit
:::::: 2e1ee1f76684c5d4dd8e5a08cbf22d57f88769ed [POWERPC] mpc52xx suspend to deep-sleep

:::::: TO: Domen Puncer <domen.puncer@telargo.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
