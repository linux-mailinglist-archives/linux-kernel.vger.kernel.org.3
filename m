Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9491F5A9061
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiIAHeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiIAHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:33:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B7213
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662017553; x=1693553553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zbD3mEf6CnfaKUc7mVObNw2BqsH1QNHbnxeeVuWi7RY=;
  b=ZDR+WDlqjdA0HFtX1/S2OU1o8zgL289txM4DfMXJscacUE/NKo8KDiZ1
   ofYYNQSkDnZK2WRvXcWAUiY+3lboQFsJPck9SNtbDhKlHqU7qSm5fambM
   TXzRM+V+IGjFBDDt1qs0D+xUgJPJorK7sPotQJKPM1Q3OaBj5P8JfiaV9
   Pg9vh4leYaGYI3bBwUjFXj+XpDbu4pGaluHrmbNibzPm3Ys+NPjHYt3M0
   a8Mh/rpO3J9gN240RMpNxvf5Jw64QYFbGvMyyWt11+n0YtbXBtelpc3X4
   HFDScdK/1S1qxWLI3PMinLX6A6r0ABW/Hw8KhI7ud1yOG2LU3z9rvF5xQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296427052"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="296427052"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="642218793"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 00:32:14 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTegP-00003v-1f;
        Thu, 01 Sep 2022 07:32:13 +0000
Date:   Thu, 1 Sep 2022 15:31:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/tcm.c:256:13: warning: no previous prototype for
 function 'tcm_init'
Message-ID: <202209011540.DTgSvBbw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5e4d5e99162ba8025d58a3af7ad103f155d2df7
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   5 months ago
config: arm-randconfig-c002-20220831 (https://download.01.org/0day-ci/archive/20220901/202209011540.DTgSvBbw-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1c66bacd6cde1f37d6ac96c45b389666a1334ec0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ drivers/clk/ti/ dtbs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/kernel/tcm.c:256:13: warning: no previous prototype for function 'tcm_init' [-Wmissing-prototypes]
   void __init tcm_init(void)
               ^
   arch/arm/kernel/tcm.c:256:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init tcm_init(void)
   ^
   static 
   1 warning generated.
--
>> drivers/clk/ti/dpll.c:107:29: warning: unused variable 'omap3_dpll_core_ck_ops' [-Wunused-const-variable]
   static const struct clk_ops omap3_dpll_core_ck_ops = {};
                               ^
   1 warning generated.
--
>> drivers/clk/ti/apll.c:95:5: warning: variable 'state' set but not used [-Wunused-but-set-variable]
           u8 state = 1;
              ^
   1 warning generated.


vim +/tcm_init +256 arch/arm/kernel/tcm.c

0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  252  
bc581770cfdd8c Linus Walleij              2009-09-15  253  /*
bc581770cfdd8c Linus Walleij              2009-09-15  254   * This initializes the TCM memory
bc581770cfdd8c Linus Walleij              2009-09-15  255   */
bc581770cfdd8c Linus Walleij              2009-09-15 @256  void __init tcm_init(void)
bc581770cfdd8c Linus Walleij              2009-09-15  257  {
90b9222ec632bc Linus Walleij              2011-12-12  258  	u32 tcm_status;
90b9222ec632bc Linus Walleij              2011-12-12  259  	u8 dtcm_banks;
90b9222ec632bc Linus Walleij              2011-12-12  260  	u8 itcm_banks;
9715efb8dc9ffa Linus Walleij              2011-07-01  261  	size_t dtcm_code_sz = &__edtcm_data - &__sdtcm_data;
9715efb8dc9ffa Linus Walleij              2011-07-01  262  	size_t itcm_code_sz = &__eitcm_text - &__sitcm_text;
bc581770cfdd8c Linus Walleij              2009-09-15  263  	char *start;
bc581770cfdd8c Linus Walleij              2009-09-15  264  	char *end;
bc581770cfdd8c Linus Walleij              2009-09-15  265  	char *ram;
1dbd30e9890fd6 Linus Walleij              2010-07-12  266  	int ret;
598509779e5b80 Linus Walleij              2010-07-12  267  	int i;
bc581770cfdd8c Linus Walleij              2009-09-15  268  
90b9222ec632bc Linus Walleij              2011-12-12  269  	/*
90b9222ec632bc Linus Walleij              2011-12-12  270  	 * Prior to ARMv5 there is no TCM, and trying to read the status
90b9222ec632bc Linus Walleij              2011-12-12  271  	 * register will hang the processor.
90b9222ec632bc Linus Walleij              2011-12-12  272  	 */
90b9222ec632bc Linus Walleij              2011-12-12  273  	if (cpu_architecture() < CPU_ARCH_ARMv5) {
90b9222ec632bc Linus Walleij              2011-12-12  274  		if (dtcm_code_sz || itcm_code_sz)
90b9222ec632bc Linus Walleij              2011-12-12  275  			pr_info("CPU TCM: %u bytes of DTCM and %u bytes of "
90b9222ec632bc Linus Walleij              2011-12-12  276  				"ITCM code compiled in, but no TCM present "
90b9222ec632bc Linus Walleij              2011-12-12  277  				"in pre-v5 CPU\n", dtcm_code_sz, itcm_code_sz);
90b9222ec632bc Linus Walleij              2011-12-12  278  		return;
90b9222ec632bc Linus Walleij              2011-12-12  279  	}
90b9222ec632bc Linus Walleij              2011-12-12  280  
90b9222ec632bc Linus Walleij              2011-12-12  281  	tcm_status = read_cpuid_tcmstatus();
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  282  
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  283  	/*
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  284  	 * This code only supports v6-compatible TCMTR implementations.
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  285  	 */
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  286  	if (tcm_status & TCMTR_FORMAT_MASK)
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  287  		return;
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  288  
90b9222ec632bc Linus Walleij              2011-12-12  289  	dtcm_banks = (tcm_status >> 16) & 0x03;
90b9222ec632bc Linus Walleij              2011-12-12  290  	itcm_banks = (tcm_status & 0x03);
90b9222ec632bc Linus Walleij              2011-12-12  291  
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  292  	register_undef_hook(&tcm_hook);
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  293  
9715efb8dc9ffa Linus Walleij              2011-07-01  294  	/* Values greater than 2 for D/ITCM banks are "reserved" */
9715efb8dc9ffa Linus Walleij              2011-07-01  295  	if (dtcm_banks > 2)
9715efb8dc9ffa Linus Walleij              2011-07-01  296  		dtcm_banks = 0;
9715efb8dc9ffa Linus Walleij              2011-07-01  297  	if (itcm_banks > 2)
9715efb8dc9ffa Linus Walleij              2011-07-01  298  		itcm_banks = 0;
9715efb8dc9ffa Linus Walleij              2011-07-01  299  
bc581770cfdd8c Linus Walleij              2009-09-15  300  	/* Setup DTCM if present */
1dbd30e9890fd6 Linus Walleij              2010-07-12  301  	if (dtcm_banks > 0) {
598509779e5b80 Linus Walleij              2010-07-12  302  		for (i = 0; i < dtcm_banks; i++) {
1dbd30e9890fd6 Linus Walleij              2010-07-12  303  			ret = setup_tcm_bank(0, i, dtcm_banks, &dtcm_end);
1dbd30e9890fd6 Linus Walleij              2010-07-12  304  			if (ret)
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  305  				goto unregister;
1dbd30e9890fd6 Linus Walleij              2010-07-12  306  		}
9715efb8dc9ffa Linus Walleij              2011-07-01  307  		/* This means you compiled more code than fits into DTCM */
9715efb8dc9ffa Linus Walleij              2011-07-01  308  		if (dtcm_code_sz > (dtcm_end - DTCM_OFFSET)) {
9715efb8dc9ffa Linus Walleij              2011-07-01  309  			pr_info("CPU DTCM: %u bytes of code compiled to "
9715efb8dc9ffa Linus Walleij              2011-07-01  310  				"DTCM but only %lu bytes of DTCM present\n",
9715efb8dc9ffa Linus Walleij              2011-07-01  311  				dtcm_code_sz, (dtcm_end - DTCM_OFFSET));
9715efb8dc9ffa Linus Walleij              2011-07-01  312  			goto no_dtcm;
9715efb8dc9ffa Linus Walleij              2011-07-01  313  		}
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  314  		/*
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  315  		 * This means that the DTCM sizes were 0 or the DTCM banks
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  316  		 * were inaccessible due to TrustZone configuration.
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  317  		 */
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  318  		if (!(dtcm_end - DTCM_OFFSET))
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  319  			goto no_dtcm;
1dbd30e9890fd6 Linus Walleij              2010-07-12  320  		dtcm_res.end = dtcm_end - 1;
bc581770cfdd8c Linus Walleij              2009-09-15  321  		request_resource(&iomem_resource, &dtcm_res);
1dbd30e9890fd6 Linus Walleij              2010-07-12  322  		dtcm_iomap[0].length = dtcm_end - DTCM_OFFSET;
bc581770cfdd8c Linus Walleij              2009-09-15  323  		iotable_init(dtcm_iomap, 1);
bc581770cfdd8c Linus Walleij              2009-09-15  324  		/* Copy data from RAM to DTCM */
bc581770cfdd8c Linus Walleij              2009-09-15  325  		start = &__sdtcm_data;
bc581770cfdd8c Linus Walleij              2009-09-15  326  		end   = &__edtcm_data;
bc581770cfdd8c Linus Walleij              2009-09-15  327  		ram   = &__dtcm_start;
9715efb8dc9ffa Linus Walleij              2011-07-01  328  		memcpy(start, ram, dtcm_code_sz);
9715efb8dc9ffa Linus Walleij              2011-07-01  329  		pr_debug("CPU DTCM: copied data from %p - %p\n",
9715efb8dc9ffa Linus Walleij              2011-07-01  330  			 start, end);
201043f227576d Linus Walleij              2011-07-01  331  		dtcm_present = true;
9715efb8dc9ffa Linus Walleij              2011-07-01  332  	} else if (dtcm_code_sz) {
9715efb8dc9ffa Linus Walleij              2011-07-01  333  		pr_info("CPU DTCM: %u bytes of code compiled to DTCM but no "
9715efb8dc9ffa Linus Walleij              2011-07-01  334  			"DTCM banks present in CPU\n", dtcm_code_sz);
bc581770cfdd8c Linus Walleij              2009-09-15  335  	}
bc581770cfdd8c Linus Walleij              2009-09-15  336  
9715efb8dc9ffa Linus Walleij              2011-07-01  337  no_dtcm:
bc581770cfdd8c Linus Walleij              2009-09-15  338  	/* Setup ITCM if present */
1dbd30e9890fd6 Linus Walleij              2010-07-12  339  	if (itcm_banks > 0) {
598509779e5b80 Linus Walleij              2010-07-12  340  		for (i = 0; i < itcm_banks; i++) {
1dbd30e9890fd6 Linus Walleij              2010-07-12  341  			ret = setup_tcm_bank(1, i, itcm_banks, &itcm_end);
1dbd30e9890fd6 Linus Walleij              2010-07-12  342  			if (ret)
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  343  				goto unregister;
1dbd30e9890fd6 Linus Walleij              2010-07-12  344  		}
9715efb8dc9ffa Linus Walleij              2011-07-01  345  		/* This means you compiled more code than fits into ITCM */
9715efb8dc9ffa Linus Walleij              2011-07-01  346  		if (itcm_code_sz > (itcm_end - ITCM_OFFSET)) {
9715efb8dc9ffa Linus Walleij              2011-07-01  347  			pr_info("CPU ITCM: %u bytes of code compiled to "
9715efb8dc9ffa Linus Walleij              2011-07-01  348  				"ITCM but only %lu bytes of ITCM present\n",
9715efb8dc9ffa Linus Walleij              2011-07-01  349  				itcm_code_sz, (itcm_end - ITCM_OFFSET));
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  350  			goto unregister;
9715efb8dc9ffa Linus Walleij              2011-07-01  351  		}
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  352  		/*
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  353  		 * This means that the ITCM sizes were 0 or the ITCM banks
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  354  		 * were inaccessible due to TrustZone configuration.
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  355  		 */
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  356  		if (!(itcm_end - ITCM_OFFSET))
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  357  			goto unregister;
1dbd30e9890fd6 Linus Walleij              2010-07-12  358  		itcm_res.end = itcm_end - 1;
bc581770cfdd8c Linus Walleij              2009-09-15  359  		request_resource(&iomem_resource, &itcm_res);
1dbd30e9890fd6 Linus Walleij              2010-07-12  360  		itcm_iomap[0].length = itcm_end - ITCM_OFFSET;
bc581770cfdd8c Linus Walleij              2009-09-15  361  		iotable_init(itcm_iomap, 1);
bc581770cfdd8c Linus Walleij              2009-09-15  362  		/* Copy code from RAM to ITCM */
bc581770cfdd8c Linus Walleij              2009-09-15  363  		start = &__sitcm_text;
bc581770cfdd8c Linus Walleij              2009-09-15  364  		end   = &__eitcm_text;
bc581770cfdd8c Linus Walleij              2009-09-15  365  		ram   = &__itcm_start;
9715efb8dc9ffa Linus Walleij              2011-07-01  366  		memcpy(start, ram, itcm_code_sz);
9715efb8dc9ffa Linus Walleij              2011-07-01  367  		pr_debug("CPU ITCM: copied code from %p - %p\n",
9715efb8dc9ffa Linus Walleij              2011-07-01  368  			 start, end);
201043f227576d Linus Walleij              2011-07-01  369  		itcm_present = true;
9715efb8dc9ffa Linus Walleij              2011-07-01  370  	} else if (itcm_code_sz) {
9715efb8dc9ffa Linus Walleij              2011-07-01  371  		pr_info("CPU ITCM: %u bytes of code compiled to ITCM but no "
9715efb8dc9ffa Linus Walleij              2011-07-01  372  			"ITCM banks present in CPU\n", itcm_code_sz);
bc581770cfdd8c Linus Walleij              2009-09-15  373  	}
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  374  
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  375  unregister:
0bbe6b5a73c00f Michael van der Westhuizen 2015-06-04  376  	unregister_undef_hook(&tcm_hook);
bc581770cfdd8c Linus Walleij              2009-09-15  377  }
bc581770cfdd8c Linus Walleij              2009-09-15  378  

:::::: The code at line 256 was first introduced by commit
:::::: bc581770cfdd8c17ea17d324dc05e2f9c599e7ca ARM: 5580/2: ARM TCM (Tightly-Coupled Memory) support v3

:::::: TO: Linus Walleij <linus.walleij@stericsson.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
