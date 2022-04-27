Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCFF510F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357485AbiD0D2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbiD0D2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:28:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872ABF6E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651029923; x=1682565923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pnKrycee21aDUCZf4kWsfwjfxpOM+2+c8gST5n/8tg0=;
  b=nYKgulNk7WIKb+NEzMZkgx6YdeXYBW6tEJvphohV01c6XEzfnT0g/8C2
   HT/tQ66PePGcvqaEHCMJ8ZD3wLZdBxbPV/1JxQGHTLTGNqGCBnSzoNZ3F
   DZcqaitgN2oucF3TbMSONr95JtMewAhqvd+DmRb9iOlMPjDBuN5dN3LZI
   r8TjYFGkqyYolxjdjjXntfMqZDM2QAzAb1xS2MWVRAAwgcx14NrTN+VPI
   T20fCuOaEx8R/wXHSxNgzhhTyb+zGZmORxpiKDo0kRVKT9CwDIjRu5KbI
   692e0+Ds+4kf5L0DSc3JL8fvrPyoxYc69C2SRWFG1ficymrKXuv6MwjD4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290948571"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="290948571"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 20:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="564878800"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2022 20:25:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njYIr-0004Gl-6q;
        Wed, 27 Apr 2022 03:25:21 +0000
Date:   Wed, 27 Apr 2022 11:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:stackleak/rework 9/9] drivers/misc/lkdtm/stackleak.c:30:34:
 error: call to undeclared function 'stackleak_task_high_bound'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202204271126.59JDH9bK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stackleak/rework
head:   7d99ba3a2a80dcf7265eafacebceaa798f5ca231
commit: 7d99ba3a2a80dcf7265eafacebceaa798f5ca231 [9/9] WIP: stackleak: rework the LKDTM stackleak test
config: hexagon-randconfig-r025-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271126.59JDH9bK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=7d99ba3a2a80dcf7265eafacebceaa798f5ca231
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stackleak/rework
        git checkout 7d99ba3a2a80dcf7265eafacebceaa798f5ca231
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/lkdtm/stackleak.c:30:34: error: call to undeclared function 'stackleak_task_high_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const unsigned long task_high = stackleak_task_high_bound(current);
                                           ^
>> drivers/misc/lkdtm/stackleak.c:31:33: error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const unsigned long task_low = stackleak_task_low_bound(current);
                                          ^
>> drivers/misc/lkdtm/stackleak.c:32:37: error: no member named 'lowest_stack' in 'struct task_struct'
           unsigned long lowest_sp = current->lowest_stack;
                                     ~~~~~~~  ^
>> drivers/misc/lkdtm/stackleak.c:33:29: error: use of undeclared identifier 'current_stack_pointer'
           unsigned long current_sp = current_stack_pointer;
                                      ^
   4 errors generated.


vim +/stackleak_task_high_bound +30 drivers/misc/lkdtm/stackleak.c

    13	
    14	/*
    15	 * Check that stackleak tracks the lowest stack pointer and erases the stack
    16	 * below this as expected.
    17	 *
    18	 * Returns true if tests pass, false otherwise.
    19	 *
    20	 * To prevent the lowest stack pointer changing during the test, IRQs are
    21	 * masked and instrumentation of this function is disabled. We assume that the
    22	 * compiler will create a fixed-size stack frame for this function.
    23	 *
    24	 * We cannot call any non-inlined functions during the test as these may alter
    25	 * the lowest stack pointer and the poisoned region. As soon as we log an error
    26	 * the test must be aborted as the printing code will use the stack.
    27	 */
    28	static noinstr bool check_stackleak_irqoff(void)
    29	{
  > 30		const unsigned long task_high = stackleak_task_high_bound(current);
  > 31		const unsigned long task_low = stackleak_task_low_bound(current);
  > 32		unsigned long lowest_sp = current->lowest_stack;
  > 33		unsigned long current_sp = current_stack_pointer;
    34		unsigned long check_high, check_low, check_ptr;
    35		unsigned long untracked_low;
    36		unsigned long found = 0;
    37		const unsigned long check_depth =
    38				STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
    39	
    40		/*
    41		 * Check that the current and lowest recorded stack pointers are within
    42		 * expected bounds.
    43		 */
    44		if (current_sp < task_low || current_sp >= task_high) {
    45			pr_err("FAIL: current_stack_pointer (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
    46			       current_sp, task_low, task_high - 1);
    47			return false;
    48		}
    49		if (lowest_sp < task_low || lowest_sp >= task_high) {
    50			pr_err("FAIL: current->lowest_stack (0x%lx) outside of task stack bounds [0x%lx..0x%lx]\n",
    51			       lowest_sp, task_low, task_high - 1);
    52			return false;
    53		}
    54	
    55		/*
    56		 * Poison values are naturally-aligned unsigned long, and any poison
    57		 * will be below the used portion of the stack, so align down to find
    58		 * the address immediately above the first possible poison value.
    59		 */
    60		current_sp = ALIGN_DOWN(current_sp, sizeof(unsigned long));
    61		lowest_sp = ALIGN_DOWN(current_sp, sizeof(unsigned long));
    62	
    63		/*
    64		 * This function is not instrumented. If its stack frame starts more
    65		 * than STACKLEAK_SEARCH_DEPTH below the lowest recorded stack pointer
    66		 * (after alignment), erasing will not function correctly.
    67		 */
    68		if (current_sp < lowest_sp - STACKLEAK_SEARCH_DEPTH) {
    69			pr_err("FAIL: stack pointer (0x%lx) is %ld bytes below current->lowest_stack (0x%lx)\n",
    70			       current_sp, lowest_sp - current_sp, lowest_sp);
    71			return false;
    72		}
    73	
    74		/*
    75		 * Depending on what has run prior to this function (including any
    76		 * interrupts handled on the task stack), it's possible that:
    77		 *
    78		 * a) current_stack_pointer < current->lowest_stack
    79		 *
    80		 * b) current_stack_pointer == current->lowest_stack
    81		 *
    82		 * c) current_stack_pointer > current->lowest_stack
    83		 *
    84		 * For the high boundary we must start checking immediately below the
    85		 * lowest of the two.
    86		 *
    87		 * For the low boundary we start immediately above the STACK_END_MAGIC.
    88		 */
    89		check_high = min(current_sp, lowest_sp);
    90		check_low = task_low;
    91	
    92		check_ptr = check_high - sizeof(unsigned long);
    93	
    94		if (check_ptr <= check_low) {
    95			pr_err("FAIL: not enough stack space for the test\n");
    96			return false;
    97		}
    98	
    99		/*
   100		 * Search for 'check_depth' poison values in a row as stackleak_erase()
   101		 * does.
   102		 */
   103		while (check_ptr > check_low && found <= check_depth) {
   104			if (*(unsigned long *)check_ptr == STACKLEAK_POISON)
   105				found++;
   106			else
   107				found = 0;
   108	
   109			check_ptr -= sizeof(unsigned long);
   110		}
   111	
   112		/*
   113		 * Either we found 'check_depth' poison values in a row, or we hit the
   114		 * low check boundary. Either way, 'check_ptr' is just below the last
   115		 * poison we checked.
   116		 */
   117		untracked_low = check_ptr + sizeof(unsigned long) * found;
   118	
   119		/*
   120		 * Check for any remaining unpoisoned stack.
   121		 */
   122		while (check_ptr > check_low) {
   123			unsigned long val = *(unsigned long *)check_ptr;
   124	
   125			if (val != STACKLEAK_POISON) {
   126				pr_err("FAIL: non-poison value 0x%lx %lu bytes into poison region\n",
   127				       val, untracked_low - check_ptr);
   128				return false;
   129			}
   130	
   131			check_ptr -= sizeof(unsigned long);
   132		}
   133	
   134		pr_info("tracked: %lu bytes, untracked: %lu bytes, poisoned: %lu bytes\n",
   135			task_high - check_high,
   136			check_high - untracked_low,
   137			untracked_low - task_low);
   138	
   139		return true;
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
