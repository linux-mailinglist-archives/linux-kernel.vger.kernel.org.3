Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997724B9766
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiBQEES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:04:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiBQEEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:04:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A3D2A22AD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645070641; x=1676606641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zhFXlAR4H63qsxXD7MCMTe1kjTBib/DCLsYseU4m9/8=;
  b=IvG5xHN6ROdJX87afMqFeE9JFSX6XdGVKKtwx8AGawZSAN6cmoe0Zaw+
   4QRKQ1pKMeUThDVZPIBgi+Z8mpnAqC6q2VyiCSpbbUyzjpBO1diKmA1gG
   LJsphmPu5a6EjQVbq8Hnbs7ZlKZFD5Pf5g0WPscj18B2cxD6NY+HLNBLb
   kRW1XOaglm+Cz1VXul19EBY9xAkfWuSELBoaF6s2KWBrEV6MQ8upqbtvi
   HFhsp07PELdOcfAIUxMyP0Gy1jDwcfUY6L1wAt2SG+3vF6jX3KW3hajUU
   CnNd9zT1g2QbDYNKsQ4O2fTzguwjzPoiJ37iJW8wgj1uYG2GOtxY1nv5H
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249619844"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249619844"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 20:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="625777194"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2022 20:04:00 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKY1P-000BRQ-RH; Thu, 17 Feb 2022 04:03:59 +0000
Date:   Thu, 17 Feb 2022 12:03:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:for-next/lkdtm 3/4] drivers/misc/lkdtm/usercopy.c:74:39:
 error: use of undeclared identifier 'current_stack_pointer'
Message-ID: <202202171116.tFKzkUFI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
head:   2223f39d57e495531165ed5bf1d94bf4f1be7963
commit: d89624a74df284274743400bb318dba7246250a4 [3/4] lkdtm/usercopy: Expand size of "out of frame" object
config: riscv-randconfig-r004-20220216 (https://download.01.org/0day-ci/archive/20220217/202202171116.tFKzkUFI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=d89624a74df284274743400bb318dba7246250a4
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/lkdtm
        git checkout d89624a74df284274743400bb318dba7246250a4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/lkdtm/usercopy.c:74:39: error: use of undeclared identifier 'current_stack_pointer'
           pr_info("stack     : %px\n", (void *)current_stack_pointer);
                                                ^
   1 error generated.


vim +/current_stack_pointer +74 drivers/misc/lkdtm/usercopy.c

    53	
    54	static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
    55	{
    56		unsigned long user_addr;
    57		unsigned char good_stack[32];
    58		unsigned char *bad_stack;
    59		int i;
    60	
    61		/* Exercise stack to avoid everything living in registers. */
    62		for (i = 0; i < sizeof(good_stack); i++)
    63			good_stack[i] = test_text[i % sizeof(test_text)];
    64	
    65		/* This is a pointer to outside our current stack frame. */
    66		if (bad_frame) {
    67			bad_stack = do_usercopy_stack_callee((uintptr_t)&bad_stack);
    68		} else {
    69			/* Put start address just inside stack. */
    70			bad_stack = task_stack_page(current) + THREAD_SIZE;
    71			bad_stack -= sizeof(unsigned long);
    72		}
    73	
  > 74		pr_info("stack     : %px\n", (void *)current_stack_pointer);
    75		pr_info("good_stack: %px-%px\n", good_stack, good_stack + sizeof(good_stack));
    76		pr_info("bad_stack : %px-%px\n", bad_stack, bad_stack + sizeof(good_stack));
    77	
    78		user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
    79				    PROT_READ | PROT_WRITE | PROT_EXEC,
    80				    MAP_ANONYMOUS | MAP_PRIVATE, 0);
    81		if (user_addr >= TASK_SIZE) {
    82			pr_warn("Failed to allocate user memory\n");
    83			return;
    84		}
    85	
    86		if (to_user) {
    87			pr_info("attempting good copy_to_user of local stack\n");
    88			if (copy_to_user((void __user *)user_addr, good_stack,
    89					 unconst + sizeof(good_stack))) {
    90				pr_warn("copy_to_user failed unexpectedly?!\n");
    91				goto free_user;
    92			}
    93	
    94			pr_info("attempting bad copy_to_user of distant stack\n");
    95			if (copy_to_user((void __user *)user_addr, bad_stack,
    96					 unconst + sizeof(good_stack))) {
    97				pr_warn("copy_to_user failed, but lacked Oops\n");
    98				goto free_user;
    99			}
   100		} else {
   101			/*
   102			 * There isn't a safe way to not be protected by usercopy
   103			 * if we're going to write to another thread's stack.
   104			 */
   105			if (!bad_frame)
   106				goto free_user;
   107	
   108			pr_info("attempting good copy_from_user of local stack\n");
   109			if (copy_from_user(good_stack, (void __user *)user_addr,
   110					   unconst + sizeof(good_stack))) {
   111				pr_warn("copy_from_user failed unexpectedly?!\n");
   112				goto free_user;
   113			}
   114	
   115			pr_info("attempting bad copy_from_user of distant stack\n");
   116			if (copy_from_user(bad_stack, (void __user *)user_addr,
   117					   unconst + sizeof(good_stack))) {
   118				pr_warn("copy_from_user failed, but lacked Oops\n");
   119				goto free_user;
   120			}
   121		}
   122	
   123	free_user:
   124		vm_munmap(user_addr, PAGE_SIZE);
   125	}
   126	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
