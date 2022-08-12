Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD960591084
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiHLMJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiHLMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:09:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F024B0293
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660306184; x=1691842184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=06DGROnmmHYe42BnYcF+ZxsPUNuOOsIs6pH7L/g5i9E=;
  b=KtsxtaRoG0y83NPw488qCEoNqNzxpjHKGuERb2Zh3i+l8c/enwmo+FGM
   pe4LRfvwTKGy5sIPTW+DgkCu4CDD9u91rrOZOcJHpUks2KxUDY47M6FqG
   L4oLw1KqlddhnW84ee8XTCY0dg2aDc1XgRo0Eif3DTfyC/6Ae0dXNfWIi
   hW6Y8SHf9F6vuij9AJ93MMB7C2iBX5ppQ2pUpqxf9pkjPUZocLCMJVu+k
   gwG3QCmfwKo6rC5oXOkXu4UdWXH2+3h1JRrmGcSR42FcRoGn+8A3Xisqg
   ka8SD9NAaa7HOTT6/ISQUDVWP9mLAp0OgLXMswqCcq0yqoXW6meGbYo04
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="291581781"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="291581781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 05:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="582065431"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2022 05:09:41 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMTTw-0000Up-2H;
        Fri, 12 Aug 2022 12:09:40 +0000
Date:   Fri, 12 Aug 2022 20:09:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202208121906.8R3iBMLM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   4 months ago
config: arm-randconfig-s051-20220811 (https://download.01.org/0day-ci/archive/20220812/202208121906.8R3iBMLM-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-mvebu/ drivers/soc/bcm/brcmstb/pm/ drivers/soc/ti/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void const *
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
>> arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void const *
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void *
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
--
>> drivers/soc/ti/knav_dma.c:539:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/soc/ti/knav_dma.c:539:31: sparse:     expected void [noderef] __iomem *
   drivers/soc/ti/knav_dma.c:539:31: sparse:     got void *
--
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     expected void const *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     expected void const *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     expected void *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:660:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:660:31: sparse:     expected void [noderef] __iomem *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:660:31: sparse:     got void *

vim +145 arch/arm/mach-mvebu/pmsu.c

3076cc58c95809 Gregory CLEMENT 2014-07-23  121  
3076cc58c95809 Gregory CLEMENT 2014-07-23  122  /*
3076cc58c95809 Gregory CLEMENT 2014-07-23  123   * This function sets up the boot address workaround needed for SMP
3076cc58c95809 Gregory CLEMENT 2014-07-23  124   * boot on Armada 375 Z1 and cpuidle on Armada 370. It unmaps the
3076cc58c95809 Gregory CLEMENT 2014-07-23  125   * BootROM Mbus window, and instead remaps a crypto SRAM into which a
3076cc58c95809 Gregory CLEMENT 2014-07-23  126   * custom piece of code is copied to replace the problematic BootROM.
3076cc58c95809 Gregory CLEMENT 2014-07-23  127   */
3076cc58c95809 Gregory CLEMENT 2014-07-23  128  int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
3076cc58c95809 Gregory CLEMENT 2014-07-23  129  			     unsigned int crypto_eng_attribute,
3076cc58c95809 Gregory CLEMENT 2014-07-23  130  			     phys_addr_t resume_addr_reg)
3076cc58c95809 Gregory CLEMENT 2014-07-23  131  {
3076cc58c95809 Gregory CLEMENT 2014-07-23  132  	void __iomem *sram_virt_base;
d0d378ff451a66 Ethan Tuttle    2018-06-19  133  	u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
3076cc58c95809 Gregory CLEMENT 2014-07-23  134  
3076cc58c95809 Gregory CLEMENT 2014-07-23  135  	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
3076cc58c95809 Gregory CLEMENT 2014-07-23  136  	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
3076cc58c95809 Gregory CLEMENT 2014-07-23  137  				    SRAM_PHYS_BASE, SZ_64K);
3076cc58c95809 Gregory CLEMENT 2014-07-23  138  
3076cc58c95809 Gregory CLEMENT 2014-07-23  139  	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
3076cc58c95809 Gregory CLEMENT 2014-07-23  140  	if (!sram_virt_base) {
3076cc58c95809 Gregory CLEMENT 2014-07-23  141  		pr_err("Unable to map SRAM to setup the boot address WA\n");
3076cc58c95809 Gregory CLEMENT 2014-07-23  142  		return -ENOMEM;
3076cc58c95809 Gregory CLEMENT 2014-07-23  143  	}
3076cc58c95809 Gregory CLEMENT 2014-07-23  144  
3076cc58c95809 Gregory CLEMENT 2014-07-23 @145  	memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
3076cc58c95809 Gregory CLEMENT 2014-07-23  146  
3076cc58c95809 Gregory CLEMENT 2014-07-23  147  	/*
3076cc58c95809 Gregory CLEMENT 2014-07-23  148  	 * The last word of the code copied in SRAM must contain the
3076cc58c95809 Gregory CLEMENT 2014-07-23  149  	 * physical base address of the PMSU register. We
3076cc58c95809 Gregory CLEMENT 2014-07-23  150  	 * intentionally store this address in the native endianness
3076cc58c95809 Gregory CLEMENT 2014-07-23  151  	 * of the system.
3076cc58c95809 Gregory CLEMENT 2014-07-23  152  	 */
3076cc58c95809 Gregory CLEMENT 2014-07-23  153  	__raw_writel((unsigned long)resume_addr_reg,
3076cc58c95809 Gregory CLEMENT 2014-07-23  154  		     sram_virt_base + code_len - 4);
3076cc58c95809 Gregory CLEMENT 2014-07-23  155  
3076cc58c95809 Gregory CLEMENT 2014-07-23  156  	iounmap(sram_virt_base);
3076cc58c95809 Gregory CLEMENT 2014-07-23  157  
3076cc58c95809 Gregory CLEMENT 2014-07-23  158  	return 0;
3076cc58c95809 Gregory CLEMENT 2014-07-23  159  }
3076cc58c95809 Gregory CLEMENT 2014-07-23  160  

:::::: The code at line 145 was first introduced by commit
:::::: 3076cc58c958090ad50acf50fc855845e3462523 ARM: mvebu: add a common function for the boot address work around

:::::: TO: Gregory CLEMENT <gregory.clement@free-electrons.com>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
