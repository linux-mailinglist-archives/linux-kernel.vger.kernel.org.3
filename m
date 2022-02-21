Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F164BED86
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiBUXBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:01:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiBUXBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:01:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1065B2409C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645484446; x=1677020446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qq9QyeavgWTs4Tm1a0pglTEgo7g64t+UI0lWQ0mpaAA=;
  b=A+kkdG4V4+mvIMWiBLxA9T0S6M6WNsTJIbT/JKdiCRTodYngSnU5NLe/
   zyWXcJjd07fjRa1xoSUkNglBOFC08R1L/ChKkTSH1Z0lD0DquAs4UUEGe
   fIua5II5NKt0ILJKYCj3QXenlb5jbrcvBGiRye+C4VC2/vK6EgFcnwzH6
   W+fk/2M1e0OWRtNs86nShQQAcixH8EB9eQqDQGOX8svaFsKNCjYmH2Inp
   OboCER5E++uP30xvRbHZRHbMi+MC+gwtcWBPcnKCr6lAXS7ZG0LY8gTXe
   RXooTeD1ECuQL6EAdUsnLSq71IvgM0MgLKAm1XXJ/WFz7mFPoyaTwYdsB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="238994437"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="238994437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="531995764"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 15:00:44 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMHff-00022o-L2; Mon, 21 Feb 2022 23:00:43 +0000
Date:   Tue, 22 Feb 2022 06:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 15/28]
 arch/x86/include/asm/pgtable.h:928:41: error: implicit declaration of
 function 'p4d_index'
Message-ID: <202202220626.x88hpnzN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   5ca7e5f74d85e6d2ddeabaa1b85b64ae50864676
commit: 1f20265f4c3946344b0e7c88cc5ecd758726c752 [15/28] mm: make x86's definition of p4d_index() the default
config: x86_64-randconfig-a002-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220626.x88hpnzN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=1f20265f4c3946344b0e7c88cc5ecd758726c752
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 1f20265f4c3946344b0e7c88cc5ecd758726c752
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/memcontrol.h:20,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   arch/x86/include/asm/pgtable.h: In function 'p4d_offset':
>> arch/x86/include/asm/pgtable.h:928:41: error: implicit declaration of function 'p4d_index' [-Werror=implicit-function-declaration]
     928 |  return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
         |                                         ^~~~~~~~~
   In file included from include/linux/mm.h:33,
                    from include/linux/memcontrol.h:20,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/pgtable.h: At top level:
>> include/linux/pgtable.h:84:29: error: conflicting types for 'p4d_index'
      84 | static inline unsigned long p4d_index(unsigned long address)
         |                             ^~~~~~~~~
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/memcontrol.h:20,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   arch/x86/include/asm/pgtable.h:928:41: note: previous implicit declaration of 'p4d_index' was here
     928 |  return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
         |                                         ^~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/p4d_index +928 arch/x86/include/asm/pgtable.h

7cfb81024bc1db Jeremy Fitzhardinge 2009-02-05  922  
7cfb81024bc1db Jeremy Fitzhardinge 2009-02-05  923  /* to find an entry in a page-table-directory. */
b8c1e4293a5d1d Kirill A. Shutemov  2018-06-26  924  static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
3d081b1812bd4d Jeremy Fitzhardinge 2009-02-05  925  {
ed7588d5dc6f5e Kirill A. Shutemov  2018-05-18  926  	if (!pgtable_l5_enabled())
98219dda2ab56c Kirill A. Shutemov  2018-02-14  927  		return (p4d_t *)pgd;
f2a6a7050109e0 Kirill A. Shutemov  2017-03-17 @928  	return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
3d081b1812bd4d Jeremy Fitzhardinge 2009-02-05  929  }
30f103167fcf2b Jeremy Fitzhardinge 2009-02-05  930  

:::::: The code at line 928 was first introduced by commit
:::::: f2a6a7050109e0a5c7a84c70aa6010f682b2f1ee x86: Convert the rest of the code to support p4d_t

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
