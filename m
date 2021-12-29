Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED9481177
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbhL2KAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:00:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:33196 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhL2KAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640772000; x=1672308000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0aOEpGbdxdmsCn2xeSNPJQDkRypdPglW65tgSt3fD8M=;
  b=TnXKioBWI1czldDMAmuwupirYkbumlHgrLZfnKrovg48PCbgBILTb67c
   K9TmwQ6jmuOPiMP61lsboje/j+uVriFfnO2ounhOrM8SB6+Cy1g/ZFEgl
   1RELRc/Lw0lUciRGJ2M5W4qVRzT/fv4ylWhyCoJcOQZE5mEUUt67874Ss
   oIEOObFsndb2jYeHRQeDgv6mg6YGkPqsqNlBmCOVyZ5ZYiJXyoHmh9QMa
   gLsj2Kcn6UFHvR4Rz/Xfz6uIC+B263ErfQXUWAnH53PTqrjYynC0zN1vu
   9BiAByHoW2xsGWXVF4NkvqvUfQerI6Nt60kPNv1EAum/XCJtVu2KGlMrW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="265730770"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="265730770"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 02:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="510470040"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2021 01:59:58 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2VkU-0008oW-0s; Wed, 29 Dec 2021 09:59:58 +0000
Date:   Wed, 29 Dec 2021 17:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 20/32]
 arch/riscv/mm/init.c:588:6: warning: no previous prototype for
 'pt_ops_set_early'
Message-ID: <202112291754.EJomZ5Hs-lkp@intel.com>
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
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20211229/202112291754.EJomZ5Hs-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/396e995ffd8ad52873006e1e8f1f6f1cd8242537
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_xtpbmt
        git checkout 396e995ffd8ad52873006e1e8f1f6f1cd8242537
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/mm/init.c:588:6: warning: no previous prototype for 'pt_ops_set_early' [-Wmissing-prototypes]
     588 | void pt_ops_set_early(void)
         |      ^~~~~~~~~~~~~~~~
>> arch/riscv/mm/init.c:606:6: warning: no previous prototype for 'pt_ops_set_fixmap' [-Wmissing-prototypes]
     606 | void pt_ops_set_fixmap(void)
         |      ^~~~~~~~~~~~~~~~~
>> arch/riscv/mm/init.c:620:6: warning: no previous prototype for 'pt_ops_set_late' [-Wmissing-prototypes]
     620 | void pt_ops_set_late(void)
         |      ^~~~~~~~~~~~~~~


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
