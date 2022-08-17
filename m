Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF5596D86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiHQL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHQL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:27:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4480526
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660735639; x=1692271639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wQBPYTDfzOaWOSuE3eEbPh2j+IRvYqG3KIwlIfqEICE=;
  b=hy8jlWGqgVLjWGVIBpxh5hna19S//dp7VA7nFoFwAVhPBMB91yF2JlxB
   g1G+wMYOMIbuux8jBa6mziWtjZOxC8mhxeuSPjeRnl0CZtJ9JsLJwMEeF
   VLTvk9x/YSz9949BxrzciscuJKmKI+AIb7k5EbijDP+sDyyyAS0ruquz2
   01FFkdR6rdOA2G0Ov+T1Jw4TGP7bVTr9W9joEIEgR2VRIPxn1PPDHz5wV
   RTEr7ByTHz5/i8v6Sgyse+bXoF4tmDtZQ0ZHHYAdNyk4Pebow+HkPhIB8
   ndqo1pVLa6YGqZ3FgGstVbi3BZ3f39gE2IxBwET378lxpOVHVjEsnFHTS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="279432985"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="279432985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 04:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="783379154"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2022 04:27:17 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOHCf-0000rY-0m;
        Wed, 17 Aug 2022 11:27:17 +0000
Date:   Wed, 17 Aug 2022 19:26:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/tcm.c:256:13: warning: no previous prototype for
 function 'tcm_init'
Message-ID: <202208171922.vDMgonxr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3cc40a443a04d52b0c95255dce264068b01e9bfe
commit: 0361c7e504b1fa3c2901643088e2f29c0354ab31 ARM: ep93xx: multiplatform support
date:   5 months ago
config: arm-randconfig-c002-20220815 (https://download.01.org/0day-ci/archive/20220817/202208171922.vDMgonxr-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0361c7e504b1fa3c2901643088e2f29c0354ab31
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0361c7e504b1fa3c2901643088e2f29c0354ab31
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ arch/arm/mm/ drivers/irqchip/

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
>> arch/arm/mm/copypage-v4wb.c:47:6: warning: no previous prototype for function 'v4wb_copy_user_highpage' [-Wmissing-prototypes]
   void v4wb_copy_user_highpage(struct page *to, struct page *from,
        ^
   arch/arm/mm/copypage-v4wb.c:47:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void v4wb_copy_user_highpage(struct page *to, struct page *from,
   ^
   static 
>> arch/arm/mm/copypage-v4wb.c:65:6: warning: no previous prototype for function 'v4wb_clear_user_highpage' [-Wmissing-prototypes]
   void v4wb_clear_user_highpage(struct page *page, unsigned long vaddr)
        ^
   arch/arm/mm/copypage-v4wb.c:65:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void v4wb_clear_user_highpage(struct page *page, unsigned long vaddr)
   ^
   static 
   2 warnings generated.
--
>> arch/arm/mm/copypage-fa.c:38:6: warning: no previous prototype for function 'fa_copy_user_highpage' [-Wmissing-prototypes]
   void fa_copy_user_highpage(struct page *to, struct page *from,
        ^
   arch/arm/mm/copypage-fa.c:38:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void fa_copy_user_highpage(struct page *to, struct page *from,
   ^
   static 
>> arch/arm/mm/copypage-fa.c:55:6: warning: no previous prototype for function 'fa_clear_user_highpage' [-Wmissing-prototypes]
   void fa_clear_user_highpage(struct page *page, unsigned long vaddr)
        ^
   arch/arm/mm/copypage-fa.c:55:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void fa_clear_user_highpage(struct page *page, unsigned long vaddr)
   ^
   static 
   2 warnings generated.
--
   drivers/irqchip/irq-ftintc010.c:128:39: warning: no previous prototype for function 'ft010_irqchip_handle_irq' [-Wmissing-prototypes]
   asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
                                         ^
   drivers/irqchip/irq-ftintc010.c:128:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
              ^
              static 
>> drivers/irqchip/irq-ftintc010.c:165:12: warning: no previous prototype for function 'ft010_of_init_irq' [-Wmissing-prototypes]
   int __init ft010_of_init_irq(struct device_node *node,
              ^
   drivers/irqchip/irq-ftintc010.c:165:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init ft010_of_init_irq(struct device_node *node,
   ^
   static 
   2 warnings generated.


vim +/tcm_init +256 arch/arm/kernel/tcm.c

0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  252  
bc581770cfdd8c1 Linus Walleij              2009-09-15  253  /*
bc581770cfdd8c1 Linus Walleij              2009-09-15  254   * This initializes the TCM memory
bc581770cfdd8c1 Linus Walleij              2009-09-15  255   */
bc581770cfdd8c1 Linus Walleij              2009-09-15 @256  void __init tcm_init(void)
bc581770cfdd8c1 Linus Walleij              2009-09-15  257  {
90b9222ec632bc8 Linus Walleij              2011-12-12  258  	u32 tcm_status;
90b9222ec632bc8 Linus Walleij              2011-12-12  259  	u8 dtcm_banks;
90b9222ec632bc8 Linus Walleij              2011-12-12  260  	u8 itcm_banks;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  261  	size_t dtcm_code_sz = &__edtcm_data - &__sdtcm_data;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  262  	size_t itcm_code_sz = &__eitcm_text - &__sitcm_text;
bc581770cfdd8c1 Linus Walleij              2009-09-15  263  	char *start;
bc581770cfdd8c1 Linus Walleij              2009-09-15  264  	char *end;
bc581770cfdd8c1 Linus Walleij              2009-09-15  265  	char *ram;
1dbd30e9890fd69 Linus Walleij              2010-07-12  266  	int ret;
598509779e5b803 Linus Walleij              2010-07-12  267  	int i;
bc581770cfdd8c1 Linus Walleij              2009-09-15  268  
90b9222ec632bc8 Linus Walleij              2011-12-12  269  	/*
90b9222ec632bc8 Linus Walleij              2011-12-12  270  	 * Prior to ARMv5 there is no TCM, and trying to read the status
90b9222ec632bc8 Linus Walleij              2011-12-12  271  	 * register will hang the processor.
90b9222ec632bc8 Linus Walleij              2011-12-12  272  	 */
90b9222ec632bc8 Linus Walleij              2011-12-12  273  	if (cpu_architecture() < CPU_ARCH_ARMv5) {
90b9222ec632bc8 Linus Walleij              2011-12-12  274  		if (dtcm_code_sz || itcm_code_sz)
90b9222ec632bc8 Linus Walleij              2011-12-12  275  			pr_info("CPU TCM: %u bytes of DTCM and %u bytes of "
90b9222ec632bc8 Linus Walleij              2011-12-12  276  				"ITCM code compiled in, but no TCM present "
90b9222ec632bc8 Linus Walleij              2011-12-12  277  				"in pre-v5 CPU\n", dtcm_code_sz, itcm_code_sz);
90b9222ec632bc8 Linus Walleij              2011-12-12  278  		return;
90b9222ec632bc8 Linus Walleij              2011-12-12  279  	}
90b9222ec632bc8 Linus Walleij              2011-12-12  280  
90b9222ec632bc8 Linus Walleij              2011-12-12  281  	tcm_status = read_cpuid_tcmstatus();
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  282  
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  283  	/*
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  284  	 * This code only supports v6-compatible TCMTR implementations.
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  285  	 */
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  286  	if (tcm_status & TCMTR_FORMAT_MASK)
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  287  		return;
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  288  
90b9222ec632bc8 Linus Walleij              2011-12-12  289  	dtcm_banks = (tcm_status >> 16) & 0x03;
90b9222ec632bc8 Linus Walleij              2011-12-12  290  	itcm_banks = (tcm_status & 0x03);
90b9222ec632bc8 Linus Walleij              2011-12-12  291  
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  292  	register_undef_hook(&tcm_hook);
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  293  
9715efb8dc9ffa6 Linus Walleij              2011-07-01  294  	/* Values greater than 2 for D/ITCM banks are "reserved" */
9715efb8dc9ffa6 Linus Walleij              2011-07-01  295  	if (dtcm_banks > 2)
9715efb8dc9ffa6 Linus Walleij              2011-07-01  296  		dtcm_banks = 0;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  297  	if (itcm_banks > 2)
9715efb8dc9ffa6 Linus Walleij              2011-07-01  298  		itcm_banks = 0;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  299  
bc581770cfdd8c1 Linus Walleij              2009-09-15  300  	/* Setup DTCM if present */
1dbd30e9890fd69 Linus Walleij              2010-07-12  301  	if (dtcm_banks > 0) {
598509779e5b803 Linus Walleij              2010-07-12  302  		for (i = 0; i < dtcm_banks; i++) {
1dbd30e9890fd69 Linus Walleij              2010-07-12  303  			ret = setup_tcm_bank(0, i, dtcm_banks, &dtcm_end);
1dbd30e9890fd69 Linus Walleij              2010-07-12  304  			if (ret)
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  305  				goto unregister;
1dbd30e9890fd69 Linus Walleij              2010-07-12  306  		}
9715efb8dc9ffa6 Linus Walleij              2011-07-01  307  		/* This means you compiled more code than fits into DTCM */
9715efb8dc9ffa6 Linus Walleij              2011-07-01  308  		if (dtcm_code_sz > (dtcm_end - DTCM_OFFSET)) {
9715efb8dc9ffa6 Linus Walleij              2011-07-01  309  			pr_info("CPU DTCM: %u bytes of code compiled to "
9715efb8dc9ffa6 Linus Walleij              2011-07-01  310  				"DTCM but only %lu bytes of DTCM present\n",
9715efb8dc9ffa6 Linus Walleij              2011-07-01  311  				dtcm_code_sz, (dtcm_end - DTCM_OFFSET));
9715efb8dc9ffa6 Linus Walleij              2011-07-01  312  			goto no_dtcm;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  313  		}
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  314  		/*
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  315  		 * This means that the DTCM sizes were 0 or the DTCM banks
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  316  		 * were inaccessible due to TrustZone configuration.
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  317  		 */
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  318  		if (!(dtcm_end - DTCM_OFFSET))
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  319  			goto no_dtcm;
1dbd30e9890fd69 Linus Walleij              2010-07-12  320  		dtcm_res.end = dtcm_end - 1;
bc581770cfdd8c1 Linus Walleij              2009-09-15  321  		request_resource(&iomem_resource, &dtcm_res);
1dbd30e9890fd69 Linus Walleij              2010-07-12  322  		dtcm_iomap[0].length = dtcm_end - DTCM_OFFSET;
bc581770cfdd8c1 Linus Walleij              2009-09-15  323  		iotable_init(dtcm_iomap, 1);
bc581770cfdd8c1 Linus Walleij              2009-09-15  324  		/* Copy data from RAM to DTCM */
bc581770cfdd8c1 Linus Walleij              2009-09-15  325  		start = &__sdtcm_data;
bc581770cfdd8c1 Linus Walleij              2009-09-15  326  		end   = &__edtcm_data;
bc581770cfdd8c1 Linus Walleij              2009-09-15  327  		ram   = &__dtcm_start;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  328  		memcpy(start, ram, dtcm_code_sz);
9715efb8dc9ffa6 Linus Walleij              2011-07-01  329  		pr_debug("CPU DTCM: copied data from %p - %p\n",
9715efb8dc9ffa6 Linus Walleij              2011-07-01  330  			 start, end);
201043f227576d4 Linus Walleij              2011-07-01  331  		dtcm_present = true;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  332  	} else if (dtcm_code_sz) {
9715efb8dc9ffa6 Linus Walleij              2011-07-01  333  		pr_info("CPU DTCM: %u bytes of code compiled to DTCM but no "
9715efb8dc9ffa6 Linus Walleij              2011-07-01  334  			"DTCM banks present in CPU\n", dtcm_code_sz);
bc581770cfdd8c1 Linus Walleij              2009-09-15  335  	}
bc581770cfdd8c1 Linus Walleij              2009-09-15  336  
9715efb8dc9ffa6 Linus Walleij              2011-07-01  337  no_dtcm:
bc581770cfdd8c1 Linus Walleij              2009-09-15  338  	/* Setup ITCM if present */
1dbd30e9890fd69 Linus Walleij              2010-07-12  339  	if (itcm_banks > 0) {
598509779e5b803 Linus Walleij              2010-07-12  340  		for (i = 0; i < itcm_banks; i++) {
1dbd30e9890fd69 Linus Walleij              2010-07-12  341  			ret = setup_tcm_bank(1, i, itcm_banks, &itcm_end);
1dbd30e9890fd69 Linus Walleij              2010-07-12  342  			if (ret)
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  343  				goto unregister;
1dbd30e9890fd69 Linus Walleij              2010-07-12  344  		}
9715efb8dc9ffa6 Linus Walleij              2011-07-01  345  		/* This means you compiled more code than fits into ITCM */
9715efb8dc9ffa6 Linus Walleij              2011-07-01  346  		if (itcm_code_sz > (itcm_end - ITCM_OFFSET)) {
9715efb8dc9ffa6 Linus Walleij              2011-07-01  347  			pr_info("CPU ITCM: %u bytes of code compiled to "
9715efb8dc9ffa6 Linus Walleij              2011-07-01  348  				"ITCM but only %lu bytes of ITCM present\n",
9715efb8dc9ffa6 Linus Walleij              2011-07-01  349  				itcm_code_sz, (itcm_end - ITCM_OFFSET));
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  350  			goto unregister;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  351  		}
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  352  		/*
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  353  		 * This means that the ITCM sizes were 0 or the ITCM banks
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  354  		 * were inaccessible due to TrustZone configuration.
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  355  		 */
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  356  		if (!(itcm_end - ITCM_OFFSET))
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  357  			goto unregister;
1dbd30e9890fd69 Linus Walleij              2010-07-12  358  		itcm_res.end = itcm_end - 1;
bc581770cfdd8c1 Linus Walleij              2009-09-15  359  		request_resource(&iomem_resource, &itcm_res);
1dbd30e9890fd69 Linus Walleij              2010-07-12  360  		itcm_iomap[0].length = itcm_end - ITCM_OFFSET;
bc581770cfdd8c1 Linus Walleij              2009-09-15  361  		iotable_init(itcm_iomap, 1);
bc581770cfdd8c1 Linus Walleij              2009-09-15  362  		/* Copy code from RAM to ITCM */
bc581770cfdd8c1 Linus Walleij              2009-09-15  363  		start = &__sitcm_text;
bc581770cfdd8c1 Linus Walleij              2009-09-15  364  		end   = &__eitcm_text;
bc581770cfdd8c1 Linus Walleij              2009-09-15  365  		ram   = &__itcm_start;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  366  		memcpy(start, ram, itcm_code_sz);
9715efb8dc9ffa6 Linus Walleij              2011-07-01  367  		pr_debug("CPU ITCM: copied code from %p - %p\n",
9715efb8dc9ffa6 Linus Walleij              2011-07-01  368  			 start, end);
201043f227576d4 Linus Walleij              2011-07-01  369  		itcm_present = true;
9715efb8dc9ffa6 Linus Walleij              2011-07-01  370  	} else if (itcm_code_sz) {
9715efb8dc9ffa6 Linus Walleij              2011-07-01  371  		pr_info("CPU ITCM: %u bytes of code compiled to ITCM but no "
9715efb8dc9ffa6 Linus Walleij              2011-07-01  372  			"ITCM banks present in CPU\n", itcm_code_sz);
bc581770cfdd8c1 Linus Walleij              2009-09-15  373  	}
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  374  
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  375  unregister:
0bbe6b5a73c00f8 Michael van der Westhuizen 2015-06-04  376  	unregister_undef_hook(&tcm_hook);
bc581770cfdd8c1 Linus Walleij              2009-09-15  377  }
bc581770cfdd8c1 Linus Walleij              2009-09-15  378  

:::::: The code at line 256 was first introduced by commit
:::::: bc581770cfdd8c17ea17d324dc05e2f9c599e7ca ARM: 5580/2: ARM TCM (Tightly-Coupled Memory) support v3

:::::: TO: Linus Walleij <linus.walleij@stericsson.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
