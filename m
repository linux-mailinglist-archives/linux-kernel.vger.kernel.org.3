Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571754B95C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiBQCBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:01:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiBQCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:01:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2552A97F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645063258; x=1676599258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8P5/T4CCEOd0foutAYwZgeIWheYPgdUwiFeNe1L+/10=;
  b=hBX/5AcsZbTyaXajwtF1eqJyjOSaFGG/c43VWkjFHVpy2cog784/+tfC
   Ufl0C/aYT6eTkKx1OV0XyjFTPQtZVYbEIMYak9mR6bMbX0z8MJLVZmu4s
   /WNc9SExFDrpsIiWCUfysES9xXEy3geDD7qApxcdVWDvrMz53lhjkyvyb
   ZKVUFFK9JBIMFx8rcTiu4xECbqiGGHGkg3YfGCvCpSpPCnttlmHVb1+5b
   8zbmyMqks4bpq1ShTOFlmDrz3U9NbTrlD8sNRZkCvUinynX6jnLn49XJk
   HjO+VacN1mATuN7MCbCzL/UdQTfR3BuWh8K4bCsLmzIhwOFoDmbb1Co1k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="248366097"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="248366097"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 18:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="487656599"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Feb 2022 18:00:56 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKW6J-000BJi-Hw; Thu, 17 Feb 2022 02:00:55 +0000
Date:   Thu, 17 Feb 2022 09:59:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:for-next/lkdtm 3/4] drivers/misc/lkdtm/usercopy.c:74:46:
 error: 'current_stack_pointer' undeclared; did you mean
 'user_stack_pointer'?
Message-ID: <202202170944.e2X9PAcw-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
head:   2223f39d57e495531165ed5bf1d94bf4f1be7963
commit: d89624a74df284274743400bb318dba7246250a4 [3/4] lkdtm/usercopy: Expand size of "out of frame" object
config: openrisc-randconfig-r004-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170944.e2X9PAcw-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=d89624a74df284274743400bb318dba7246250a4
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/lkdtm
        git checkout d89624a74df284274743400bb318dba7246250a4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from drivers/misc/lkdtm/lkdtm.h:7,
                    from drivers/misc/lkdtm/usercopy.c:6:
   drivers/misc/lkdtm/usercopy.c: In function 'do_usercopy_stack':
>> drivers/misc/lkdtm/usercopy.c:74:46: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'user_stack_pointer'?
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |                                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/misc/lkdtm/usercopy.c:74:9: note: in expansion of macro 'pr_info'
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |         ^~~~~~~
   drivers/misc/lkdtm/usercopy.c:74:46: note: each undeclared identifier is reported only once for each function it appears in
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |                                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/misc/lkdtm/usercopy.c:74:9: note: in expansion of macro 'pr_info'
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |         ^~~~~~~


vim +74 drivers/misc/lkdtm/usercopy.c

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
