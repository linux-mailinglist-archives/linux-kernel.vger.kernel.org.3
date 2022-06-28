Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05955E87A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbiF1PaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346691AbiF1PaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:30:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F960F2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656430200; x=1687966200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DkHXO1XAtfgSFlm4XIyu0K59BkHqpN7Fhdck9GG/JyY=;
  b=UMIxjjxu2gVDIv/uyZokL7xGBCsmSGeqAcYGAKBml/E0UAP4xPV4qC1G
   7tVPw6ThNeueBv8KosibxtOD82S/POGA6CY0xvlxG4KlfV8JYtgshs3Ai
   /wzJxLcHlGxoh7z1gMD93zygbFoGIR5/9y14W9zIfOGdY+Vo5Q8hOnS7F
   U9TKRIarCdFpTMVeP18ahJDFiRQYlrU7TWf5Q+hZOeq2hrRUNzA1g4uk4
   2UoGpO+K0lXPe39jsFmhWaJxLDLss4KYM73XjDO41lF4SyIfSqG0ukdX+
   7tUpHB3GYOfPEvvFYmY6n/1Xho0mNwvuQtPw8OT98Faw/nOSDnM+KfRJd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="261576107"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="261576107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="680094473"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2022 08:29:58 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6DA6-000AJs-3T;
        Tue, 28 Jun 2022 15:29:58 +0000
Date:   Tue, 28 Jun 2022 23:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-filter 10/28] arch/x86/kernel/head64.c:527:2:
 error: call to undeclared function 'tdx_filter_init'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202206282311.jGZChFVY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-filter
head:   0a555e67b143701a81612d819e693cf5786de418
commit: f0270b8da57a2d69e1eb8aa9c79ad9b6a01c90ab [10/28] x86/tdx: Add command line option to disable TDX guest filter support
config: x86_64-randconfig-a002-20220627 (https://download.01.org/0day-ci/archive/20220628/202206282311.jGZChFVY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/f0270b8da57a2d69e1eb8aa9c79ad9b6a01c90ab
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-filter
        git checkout f0270b8da57a2d69e1eb8aa9c79ad9b6a01c90ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/head64.c:527:2: error: call to undeclared function 'tdx_filter_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           tdx_filter_init();
           ^
   1 error generated.


vim +/tdx_filter_init +527 arch/x86/kernel/head64.c

   471	
   472	asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
   473	{
   474		/*
   475		 * Build-time sanity checks on the kernel image and module
   476		 * area mappings. (these are purely build-time and produce no code)
   477		 */
   478		BUILD_BUG_ON(MODULES_VADDR < __START_KERNEL_map);
   479		BUILD_BUG_ON(MODULES_VADDR - __START_KERNEL_map < KERNEL_IMAGE_SIZE);
   480		BUILD_BUG_ON(MODULES_LEN + KERNEL_IMAGE_SIZE > 2*PUD_SIZE);
   481		BUILD_BUG_ON((__START_KERNEL_map & ~PMD_MASK) != 0);
   482		BUILD_BUG_ON((MODULES_VADDR & ~PMD_MASK) != 0);
   483		BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
   484		MAYBE_BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
   485					(__START_KERNEL & PGDIR_MASK)));
   486		BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
   487	
   488		cr4_init_shadow();
   489	
   490		/* Kill off the identity-map trampoline */
   491		reset_early_page_tables();
   492	
   493		clear_bss();
   494	
   495		/*
   496		 * This needs to happen *before* kasan_early_init() because latter maps stuff
   497		 * into that page.
   498		 */
   499		clear_page(init_top_pgt);
   500	
   501		/*
   502		 * SME support may update early_pmd_flags to include the memory
   503		 * encryption mask, so it needs to be called before anything
   504		 * that may generate a page fault.
   505		 */
   506		sme_early_init();
   507	
   508		kasan_early_init();
   509	
   510		/*
   511		 * Flush global TLB entries which could be left over from the trampoline page
   512		 * table.
   513		 *
   514		 * This needs to happen *after* kasan_early_init() as KASAN-enabled .configs
   515		 * instrument native_write_cr4() so KASAN must be initialized for that
   516		 * instrumentation to work.
   517		 */
   518		__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
   519	
   520		idt_setup_early_handler();
   521	
   522		/* Needed before cc_platform_has() can be used for TDX */
   523		tdx_early_init();
   524	
   525		copy_bootdata(__va(real_mode_data));
   526	
 > 527		tdx_filter_init();
   528	
   529		/*
   530		 * Load microcode early on BSP.
   531		 */
   532		load_ucode_bsp();
   533	
   534		/* set init_top_pgt kernel high mapping*/
   535		init_top_pgt[511] = early_top_pgt[511];
   536	
   537		x86_64_start_reservations(real_mode_data);
   538	}
   539	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
