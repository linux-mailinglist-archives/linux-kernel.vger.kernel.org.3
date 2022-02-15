Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8164B6C90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiBOMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:46:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBOMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:46:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0ED14098
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644929151; x=1676465151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k6V/EzoT1G6Iy6HpgWTP4Y7tnAk/b162v4eJl26GNMo=;
  b=WZtv61wMgwPWpycw5rCEa8EPtc5ENbmD9w3l0KNVpy9Wqkp0k1ZUr381
   RJCGoK3LDis3v20GaaMPWX14X7dEFGOkuRfbpKpOnXu9Z/8ciRfAZ25zB
   Zq+R3fZPZDjGKo3iUTNl51zHJYYe3uTLBdyUcYQSKZE/HTyQh6Ud3J6Oh
   Vsd54Cw2BaLt4HosUNHqW4tqBnF9d95js4djZXKo0T12MDziM/PNQiE8j
   Q/AQ8RGsRGcj43e8mrVl/F1F1aBXSheq2jPSCpoAEw7i9EuaNCcWoFa8C
   d/dnSjw21pNgug+zyiNCI8uc9zE9/tabuE5Zl4ytHIgpqZnG5hyjeGZ9A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247938875"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="247938875"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635856567"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 04:45:48 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJxDI-0009ew-4i; Tue, 15 Feb 2022 12:45:48 +0000
Date:   Tue, 15 Feb 2022 20:45:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qinglin Pan <panqinglin2020@iscas.ac.cn>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-sv57 2/4]
 arch/riscv/mm/init.c:782:83: warning: suggest braces around empty body in an
 'if' statement
Message-ID: <202202152048.f2hoyu2a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-sv57
head:   8fbdccd2b17335e1881a23865e98c63fcc345938
commit: 677b9eb8810edc6c616a699018a83e24ed0cccab [2/4] riscv: mm: Prepare pt_ops helper functions for sv57
config: riscv-randconfig-r021-20220214 (https://download.01.org/0day-ci/archive/20220215/202202152048.f2hoyu2a-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/677b9eb8810edc6c616a699018a83e24ed0cccab
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-sv57
        git checkout 677b9eb8810edc6c616a699018a83e24ed0cccab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/riscv/mm/init.c: In function 'create_fdt_early_page_table':
>> arch/riscv/mm/init.c:782:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     782 |                                    (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
         |                                                                                   ^
   arch/riscv/mm/init.c:786:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     786 |                                    (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
         |                                                                                   ^
   arch/riscv/mm/init.c: At top level:
   arch/riscv/mm/init.c:813:13: warning: no previous prototype for 'pt_ops_set_early' [-Wmissing-prototypes]
     813 | void __init pt_ops_set_early(void)
         |             ^~~~~~~~~~~~~~~~
   arch/riscv/mm/init.c:835:13: warning: no previous prototype for 'pt_ops_set_fixmap' [-Wmissing-prototypes]
     835 | void __init pt_ops_set_fixmap(void)
         |             ^~~~~~~~~~~~~~~~~
   arch/riscv/mm/init.c:853:13: warning: no previous prototype for 'pt_ops_set_late' [-Wmissing-prototypes]
     853 | void __init pt_ops_set_late(void)
         |             ^~~~~~~~~~~~~~~


vim +/if +782 arch/riscv/mm/init.c

   764	
   765	/*
   766	 * Setup a 4MB mapping that encompasses the device tree: for 64-bit kernel,
   767	 * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
   768	 * entry.
   769	 */
   770	static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
   771	{
   772	#ifndef CONFIG_BUILTIN_DTB
   773		uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
   774	
   775		create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
   776				   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
   777				   PGDIR_SIZE,
   778				   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
   779	
   780		if (pgtable_l5_enabled)
   781			create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
 > 782					   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
   783	
   784		if (pgtable_l4_enabled)
   785			create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
   786					   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
   787	
   788		if (IS_ENABLED(CONFIG_64BIT)) {
   789			create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
   790					   pa, PMD_SIZE, PAGE_KERNEL);
   791			create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
   792					   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
   793		}
   794	
   795		dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
   796	#else
   797		/*
   798		 * For 64-bit kernel, __va can't be used since it would return a linear
   799		 * mapping address whereas dtb_early_va will be used before
   800		 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
   801		 * kernel is mapped in the linear mapping, that makes no difference.
   802		 */
   803		dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
   804	#endif
   805	
   806		dtb_early_pa = dtb_pa;
   807	}
   808	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
