Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9CD53061D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351663AbiEVVUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351648AbiEVVUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:20:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73123617C
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653254436; x=1684790436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vEmm3EweKvekID0oeaEyRBQ7S50CkOoQdYG/38hDSIM=;
  b=VbYYYK0bk4PaGQt078lx9qdIJMq/WuVt6jLOXJM0uCihMc+E9G8mUdky
   YapB2w+lHr/pItZgVz/1/yfvZ2GQB7lgdK/5/qQa0Qlln30ejeN9MJCwm
   PW1kF44kT32UeZgwl7AusOXYp2VyOetD/I4xrUqwoVu/CrhA2/4ADxTCK
   X6Fxv0nM25KsQ0lBsHk+GOVDxmpl4FJwbfAgFn/Dfs5r4tQJe8Mb4/qqx
   A3rr2G3SWYfTuRmc2zMd/79WPKXG2JWG2DuqAHusct+jpYapMgUZa01Tk
   uhv5M2uIXhN0j8o9ZPyfERcwsOFL4dcqO91L2nea0EYuN49bO4RbUxvgL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="272762745"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="272762745"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 14:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="607885877"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 May 2022 14:20:35 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nst06-0000cl-CK;
        Sun, 22 May 2022 21:20:34 +0000
Date:   Mon, 23 May 2022 05:19:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qinglin Pan <panqinglin2020@iscas.ac.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/mm/init.c:782:83: warning: suggest braces around empty
 body in an 'if' statement
Message-ID: <202205230554.bQhtkCTA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qinglin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b0986a3613c92f4ec1bdc7f60ec66fea135991f
commit: 677b9eb8810edc6c616a699018a83e24ed0cccab riscv: mm: Prepare pt_ops helper functions for sv57
date:   3 months ago
config: riscv-randconfig-r042-20220522 (https://download.01.org/0day-ci/archive/20220523/202205230554.bQhtkCTA-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=677b9eb8810edc6c616a699018a83e24ed0cccab
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 677b9eb8810edc6c616a699018a83e24ed0cccab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
