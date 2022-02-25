Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079EE4C3EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiBYGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBYGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:53:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6E517B0D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645771970; x=1677307970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MTWYAo2XplF9d/JL4zrl8PSQxCWZekEPeOn9bOiE9JY=;
  b=G3ozA8YB5LiRoRdecO6unwkSMjm4jkuwukFettdNcBSdgl92kmyOVYuu
   qN+UUFFBR/q0Tfp8A9oarkaJj9q7Dj0Sbnn67AtT/1Q2e8+HiRqdl4xQG
   1n1c8UHArBaeTtzODEEjV70AWZmVGKo9D6biW8qWS0/31Dmh6JcXjqL/J
   N2hspnN0FFwX834Ehik8BKEP9AtcqUTaxkMW9rMdsaQ32xF+ArcpPflpn
   d6R3y/bDDsJzAJdggFQ1O9OZGrlJZVSzWcE+HBNnEyd9IDMMGzLaxL0mO
   NMJ5aKmY7TL71x/kgT04PQg38QxuLCC9m6sdAqvyjEg2RhCeQBdb8bfex
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252357160"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252357160"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 22:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="684564167"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 22:52:48 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNUT9-0003wR-9t; Fri, 25 Feb 2022 06:52:47 +0000
Date:   Fri, 25 Feb 2022 14:52:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: [dinguyen:nios2_for_v5.18 5/6] arch/arm64/kernel/traps.c:522:24:
 error: implicit declaration of function 'user_addr_max'
Message-ID: <202202251412.qBRDFDRl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.18
head:   048b7695b48a3a4523a7a7fbfedc396b40ccf62f
commit: f368e6211f42e086e37dde58d081a86ac033dda3 [5/6] uaccess: generalize access_ok()
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20220225/202202251412.qBRDFDRl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=f368e6211f42e086e37dde58d081a86ac033dda3
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen nios2_for_v5.18
        git checkout f368e6211f42e086e37dde58d081a86ac033dda3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from arch/arm64/kernel/traps.c:9:
   include/linux/syscalls.h: In function 'addr_limit_user_check':
   include/linux/syscalls.h:293:35: error: implicit declaration of function 'uaccess_kernel' [-Werror=implicit-function-declaration]
     293 |         if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
         |                                   ^~~~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/syscalls.h:293:13: note: in expansion of macro 'CHECK_DATA_CORRUPTION'
     293 |         if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
         |             ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c: In function 'user_cache_maint_handler':
>> arch/arm64/kernel/traps.c:522:24: error: implicit declaration of function 'user_addr_max' [-Werror=implicit-function-declaration]
     522 |         if (address >= user_addr_max()) {                       \
         |                        ^~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:548:17: note: in expansion of macro '__user_cache_maint'
     548 |                 __user_cache_maint("dc civac", address, ret);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c: At top level:
   arch/arm64/kernel/traps.c:803:43: warning: initialized field overwritten [-Woverride-init]
     803 |         [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:803:43: note: (near initialization for 'esr_class_str[0]')
   arch/arm64/kernel/traps.c:804:43: warning: initialized field overwritten [-Woverride-init]
     804 |         [ESR_ELx_EC_WFx]                = "WFI/WFE",
         |                                           ^~~~~~~~~
   arch/arm64/kernel/traps.c:804:43: note: (near initialization for 'esr_class_str[1]')
   arch/arm64/kernel/traps.c:805:43: warning: initialized field overwritten [-Woverride-init]
     805 |         [ESR_ELx_EC_CP15_32]            = "CP15 MCR/MRC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:805:43: note: (near initialization for 'esr_class_str[3]')
   arch/arm64/kernel/traps.c:806:43: warning: initialized field overwritten [-Woverride-init]
     806 |         [ESR_ELx_EC_CP15_64]            = "CP15 MCRR/MRRC",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:806:43: note: (near initialization for 'esr_class_str[4]')
   arch/arm64/kernel/traps.c:807:43: warning: initialized field overwritten [-Woverride-init]
     807 |         [ESR_ELx_EC_CP14_MR]            = "CP14 MCR/MRC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:807:43: note: (near initialization for 'esr_class_str[5]')
   arch/arm64/kernel/traps.c:808:43: warning: initialized field overwritten [-Woverride-init]
     808 |         [ESR_ELx_EC_CP14_LS]            = "CP14 LDC/STC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:808:43: note: (near initialization for 'esr_class_str[6]')
   arch/arm64/kernel/traps.c:809:43: warning: initialized field overwritten [-Woverride-init]
     809 |         [ESR_ELx_EC_FP_ASIMD]           = "ASIMD",
         |                                           ^~~~~~~
   arch/arm64/kernel/traps.c:809:43: note: (near initialization for 'esr_class_str[7]')
   arch/arm64/kernel/traps.c:810:43: warning: initialized field overwritten [-Woverride-init]
     810 |         [ESR_ELx_EC_CP10_ID]            = "CP10 MRC/VMRS",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:810:43: note: (near initialization for 'esr_class_str[8]')
   arch/arm64/kernel/traps.c:811:43: warning: initialized field overwritten [-Woverride-init]
     811 |         [ESR_ELx_EC_PAC]                = "PAC",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:811:43: note: (near initialization for 'esr_class_str[9]')
   arch/arm64/kernel/traps.c:812:43: warning: initialized field overwritten [-Woverride-init]
     812 |         [ESR_ELx_EC_CP14_64]            = "CP14 MCRR/MRRC",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:812:43: note: (near initialization for 'esr_class_str[12]')
   arch/arm64/kernel/traps.c:813:43: warning: initialized field overwritten [-Woverride-init]
     813 |         [ESR_ELx_EC_BTI]                = "BTI",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:813:43: note: (near initialization for 'esr_class_str[13]')
   arch/arm64/kernel/traps.c:814:43: warning: initialized field overwritten [-Woverride-init]
     814 |         [ESR_ELx_EC_ILL]                = "PSTATE.IL",
         |                                           ^~~~~~~~~~~
   arch/arm64/kernel/traps.c:814:43: note: (near initialization for 'esr_class_str[14]')
   arch/arm64/kernel/traps.c:815:43: warning: initialized field overwritten [-Woverride-init]
     815 |         [ESR_ELx_EC_SVC32]              = "SVC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:815:43: note: (near initialization for 'esr_class_str[17]')
   arch/arm64/kernel/traps.c:816:43: warning: initialized field overwritten [-Woverride-init]
     816 |         [ESR_ELx_EC_HVC32]              = "HVC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:816:43: note: (near initialization for 'esr_class_str[18]')
   arch/arm64/kernel/traps.c:817:43: warning: initialized field overwritten [-Woverride-init]
     817 |         [ESR_ELx_EC_SMC32]              = "SMC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:817:43: note: (near initialization for 'esr_class_str[19]')
   arch/arm64/kernel/traps.c:818:43: warning: initialized field overwritten [-Woverride-init]
     818 |         [ESR_ELx_EC_SVC64]              = "SVC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:818:43: note: (near initialization for 'esr_class_str[21]')
   arch/arm64/kernel/traps.c:819:43: warning: initialized field overwritten [-Woverride-init]
     819 |         [ESR_ELx_EC_HVC64]              = "HVC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:819:43: note: (near initialization for 'esr_class_str[22]')
   arch/arm64/kernel/traps.c:820:43: warning: initialized field overwritten [-Woverride-init]
     820 |         [ESR_ELx_EC_SMC64]              = "SMC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:820:43: note: (near initialization for 'esr_class_str[23]')
   arch/arm64/kernel/traps.c:821:43: warning: initialized field overwritten [-Woverride-init]
     821 |         [ESR_ELx_EC_SYS64]              = "MSR/MRS (AArch64)",
         |                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:821:43: note: (near initialization for 'esr_class_str[24]')
   arch/arm64/kernel/traps.c:822:43: warning: initialized field overwritten [-Woverride-init]
     822 |         [ESR_ELx_EC_SVE]                = "SVE",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:822:43: note: (near initialization for 'esr_class_str[25]')
   arch/arm64/kernel/traps.c:823:43: warning: initialized field overwritten [-Woverride-init]
     823 |         [ESR_ELx_EC_ERET]               = "ERET/ERETAA/ERETAB",
         |                                           ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:823:43: note: (near initialization for 'esr_class_str[26]')
   arch/arm64/kernel/traps.c:824:43: warning: initialized field overwritten [-Woverride-init]
     824 |         [ESR_ELx_EC_FPAC]               = "FPAC",
         |                                           ^~~~~~
   arch/arm64/kernel/traps.c:824:43: note: (near initialization for 'esr_class_str[28]')
   arch/arm64/kernel/traps.c:825:43: warning: initialized field overwritten [-Woverride-init]
     825 |         [ESR_ELx_EC_IMP_DEF]            = "EL3 IMP DEF",
         |                                           ^~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:825:43: note: (near initialization for 'esr_class_str[31]')
   arch/arm64/kernel/traps.c:826:43: warning: initialized field overwritten [-Woverride-init]
     826 |         [ESR_ELx_EC_IABT_LOW]           = "IABT (lower EL)",


vim +/user_addr_max +522 arch/arm64/kernel/traps.c

e16aeb072682d3 Amit Daniel Kachhap 2020-09-14  520  
7dd01aef055792 Andre Przywara      2016-06-28  521  #define __user_cache_maint(insn, address, res)			\
81cddd65b5c827 Kristina Martsenko  2017-05-03 @522  	if (address >= user_addr_max()) {			\
87261d19046aea Andre Przywara      2016-10-19  523  		res = -EFAULT;					\
39bc88e5e38e9b Catalin Marinas     2016-09-02  524  	} else {						\
39bc88e5e38e9b Catalin Marinas     2016-09-02  525  		uaccess_ttbr0_enable();				\
7dd01aef055792 Andre Przywara      2016-06-28  526  		asm volatile (					\
7dd01aef055792 Andre Przywara      2016-06-28  527  			"1:	" insn ", %1\n"			\
7dd01aef055792 Andre Przywara      2016-06-28  528  			"	mov	%w0, #0\n"		\
7dd01aef055792 Andre Przywara      2016-06-28  529  			"2:\n"					\
2e77a62cb3a6d2 Mark Rutland        2021-10-19  530  			_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)	\
7dd01aef055792 Andre Przywara      2016-06-28  531  			: "=r" (res)				\
2e77a62cb3a6d2 Mark Rutland        2021-10-19  532  			: "r" (address));			\
39bc88e5e38e9b Catalin Marinas     2016-09-02  533  		uaccess_ttbr0_disable();			\
39bc88e5e38e9b Catalin Marinas     2016-09-02  534  	}
7dd01aef055792 Andre Przywara      2016-06-28  535  

:::::: The code at line 522 was first introduced by commit
:::::: 81cddd65b5c82758ea5571a25e31ff6f1f89ff02 arm64: traps: fix userspace cache maintenance emulation on a tagged pointer

:::::: TO: Kristina Martsenko <kristina.martsenko@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
