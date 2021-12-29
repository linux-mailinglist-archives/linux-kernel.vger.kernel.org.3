Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2775A481364
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhL2NPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:15:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:40480 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240343AbhL2NPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783704; x=1672319704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TBG8xNNnwXlpGe2S88CDUP9cr/6jhD0IQJ/sVnn4jIo=;
  b=TPNOVVmu9NBDy0G/NEnGCMc4LBZCLjddhMOMtVgJCWd9OPSsUqWnxygx
   XD/OUFhJcsqyH7OIMq5KmYuj9NjfHsBecDIKGOilU9FY2QRU2yfZHC2Bc
   afKeT3xOIm1ak6mZU4KQuCmaC7VLxZvFCL8U2GiSfFqbxMSR2dhVQ2Lbs
   Pl+3PcE9hvnmWoVjZi9ZCRRdjKZgYxcktQ5S2+N5x+0dTr8l2qmBPByWG
   FfELaJAekxM1JCyVN/73l5Wxe6hfHdfY/ERBVpAg442fw94Os+mKZrHRr
   vf8DlALgJPPSR1BBVqdANuzSPmzBbWXwIMRRZZHQE3HdBFnEXPD1acfzL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="239060721"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="239060721"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="619034875"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2021 05:15:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2YnF-0008wE-8j; Wed, 29 Dec 2021 13:15:01 +0000
Date:   Wed, 29 Dec 2021 21:14:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 20/32]
 arch/riscv/mm/init.c:588:6: warning: no previous prototype for function
 'pt_ops_set_early'
Message-ID: <202112292145.5uDQRp8q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2_sv48_v3_xtpbmt
head:   29a08e898f4e552bc0d5117b437ac3073e6ebb81
commit: 396e995ffd8ad52873006e1e8f1f6f1cd8242537 [20/32] riscv: Introduce functions to switch pt_ops
config: riscv-randconfig-r013-20211228 (https://download.01.org/0day-ci/archive/20211229/202112292145.5uDQRp8q-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/396e995ffd8ad52873006e1e8f1f6f1cd8242537
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_xtpbmt
        git checkout 396e995ffd8ad52873006e1e8f1f6f1cd8242537
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/mm/init.c:588:6: warning: no previous prototype for function 'pt_ops_set_early' [-Wmissing-prototypes]
   void pt_ops_set_early(void)
        ^
   arch/riscv/mm/init.c:588:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pt_ops_set_early(void)
   ^
   static 
>> arch/riscv/mm/init.c:606:6: warning: no previous prototype for function 'pt_ops_set_fixmap' [-Wmissing-prototypes]
   void pt_ops_set_fixmap(void)
        ^
   arch/riscv/mm/init.c:606:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pt_ops_set_fixmap(void)
   ^
   static 
>> arch/riscv/mm/init.c:620:6: warning: no previous prototype for function 'pt_ops_set_late' [-Wmissing-prototypes]
   void pt_ops_set_late(void)
        ^
   arch/riscv/mm/init.c:620:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pt_ops_set_late(void)
   ^
   static 
   3 warnings generated.


vim +/pt_ops_set_early +588 arch/riscv/mm/init.c

   583	
   584	/*
   585	 * MMU is not enabled, the page tables are allocated directly using
   586	 * early_pmd/pud/p4d and the address returned is the physical one.
   587	 */
 > 588	void pt_ops_set_early(void)
   589	{
   590		pt_ops.alloc_pte = alloc_pte_early;
   591		pt_ops.get_pte_virt = get_pte_virt_early;
   592	#ifndef __PAGETABLE_PMD_FOLDED
   593		pt_ops.alloc_pmd = alloc_pmd_early;
   594		pt_ops.get_pmd_virt = get_pmd_virt_early;
   595	#endif
   596	}
   597	
   598	/*
   599	 * MMU is enabled but page table setup is not complete yet.
   600	 * fixmap page table alloc functions must be used as a means to temporarily
   601	 * map the allocated physical pages since the linear mapping does not exist yet.
   602	 *
   603	 * Note that this is called with MMU disabled, hence kernel_mapping_pa_to_va,
   604	 * but it will be used as described above.
   605	 */
 > 606	void pt_ops_set_fixmap(void)
   607	{
   608		pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
   609		pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
   610	#ifndef __PAGETABLE_PMD_FOLDED
   611		pt_ops.alloc_pmd = kernel_mapping_pa_to_va((uintptr_t)alloc_pmd_fixmap);
   612		pt_ops.get_pmd_virt = kernel_mapping_pa_to_va((uintptr_t)get_pmd_virt_fixmap);
   613	#endif
   614	}
   615	
   616	/*
   617	 * MMU is enabled and page table setup is complete, so from now, we can use
   618	 * generic page allocation functions to setup page table.
   619	 */
 > 620	void pt_ops_set_late(void)
   621	{
   622		pt_ops.alloc_pte = alloc_pte_late;
   623		pt_ops.get_pte_virt = get_pte_virt_late;
   624	#ifndef __PAGETABLE_PMD_FOLDED
   625		pt_ops.alloc_pmd = alloc_pmd_late;
   626		pt_ops.get_pmd_virt = get_pmd_virt_late;
   627	#endif
   628	}
   629	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
