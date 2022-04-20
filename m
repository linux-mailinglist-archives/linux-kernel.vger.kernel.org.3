Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87835080F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359499AbiDTGVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiDTGUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:20:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453F39684
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650435489; x=1681971489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/tbQbCDmy6h33YZpXnVDHh2TW+tmiNo3b0FfQIZOlQE=;
  b=EYlZCNnQx6v8A16GpRzWZLBAm5KFKWXzRw8iwfCt9VmKTwytZg0plWYN
   2adPE7YbCtrqpK9PABOooivw2BvrMSf7+wacxB6Y1XiNL3qVN9jP9XejY
   sTZS68m3VOq1rqFwhwMWh9CGwjcYlRJk1IhcVybfyF3CQs/JlHYAHDkrn
   Lg7HsBvy9BEyXQbeX8CvB8L3nNJvD21sUmvESvR/TFWhO1WUQ7orBR6V9
   xfGm9YNjVBoTPiVrAJcEgtTRpo+WXpCCtG0Rhhoa6OwMqOpl/bm4C5YTn
   x6cPPMqeZ8M8u/9hbCAv/lPA0vcyE5OjDvDeQRFBcdwoGQvsQMPkJ0uhb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="289054058"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="289054058"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="667880470"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2022 23:18:07 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh3fC-0006ei-RE;
        Wed, 20 Apr 2022 06:18:06 +0000
Date:   Wed, 20 Apr 2022 14:17:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [kees:for-next/lkdtm 6/6] drivers/misc/lkdtm/cfi.c:72:13: sparse:
 sparse: non size-preserving pointer to integer cast
Message-ID: <202204201422.AzI0RBIZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
head:   2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
commit: 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25 [6/6] lkdtm: Add CFI_BACKWARD to test ROP mitigations
config: nios2-randconfig-s032-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201422.AzI0RBIZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/lkdtm
        git checkout 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/misc/lkdtm/cfi.c:100:27: sparse: sparse: Using plain integer as NULL pointer
>> drivers/misc/lkdtm/cfi.c:72:13: sparse: sparse: non size-preserving pointer to integer cast
>> drivers/misc/lkdtm/cfi.c:72:13: sparse: sparse: non size-preserving integer to pointer cast
   drivers/misc/lkdtm/cfi.c:87:13: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/lkdtm/cfi.c:87:13: sparse: sparse: non size-preserving integer to pointer cast

vim +72 drivers/misc/lkdtm/cfi.c

    60	
    61	#define no_pac_addr(addr)      \
    62		((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
    63	
    64	/* The ultimate ROP gadget. */
    65	static noinline __no_ret_protection
    66	void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
    67	{
    68		/* Use of volatile is to make sure final write isn't seen as a dead store. */
    69		unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
    70	
    71		/* Make sure we've found the right place on the stack before writing it. */
  > 72		if (no_pac_addr(*ret_addr) == expected)
    73			*ret_addr = (addr);
    74		else
    75			/* Check architecture, stack layout, or compiler behavior... */
    76			pr_warn("Eek: return address mismatch! %px != %px\n",
    77				*ret_addr, addr);
    78	}
    79	
    80	static noinline
    81	void set_return_addr(unsigned long *expected, unsigned long *addr)
    82	{
    83		/* Use of volatile is to make sure final write isn't seen as a dead store. */
    84		unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
    85	
    86		/* Make sure we've found the right place on the stack before writing it. */
    87		if (no_pac_addr(*ret_addr) == expected)
    88			*ret_addr = (addr);
    89		else
    90			/* Check architecture, stack layout, or compiler behavior... */
    91			pr_warn("Eek: return address mismatch! %px != %px\n",
    92				*ret_addr, addr);
    93	}
    94	
    95	static volatile int force_check;
    96	
    97	static void lkdtm_CFI_BACKWARD(void)
    98	{
    99		/* Use calculated gotos to keep labels addressable. */
 > 100		void *labels[] = {0, &&normal, &&redirected, &&check_normal, &&check_redirected};
   101	
   102		pr_info("Attempting unchecked stack return address redirection ...\n");
   103	
   104		/* Always false */
   105		if (force_check) {
   106			/*
   107			 * Prepare to call with NULLs to avoid parameters being treated as
   108			 * constants in -02.
   109			 */
   110			set_return_addr_unchecked(NULL, NULL);
   111			set_return_addr(NULL, NULL);
   112			if (force_check)
   113				goto *labels[1];
   114			if (force_check)
   115				goto *labels[2];
   116			if (force_check)
   117				goto *labels[3];
   118			if (force_check)
   119				goto *labels[4];
   120			return;
   121		}
   122	
   123		/*
   124		 * Use fallthrough switch case to keep basic block ordering between
   125		 * set_return_addr*() and the label after it.
   126		 */
   127		switch (force_check) {
   128		case 0:
   129			set_return_addr_unchecked(&&normal, &&redirected);
   130			fallthrough;
   131		case 1:
   132	normal:
   133			/* Always true */
   134			if (!force_check) {
   135				pr_err("FAIL: stack return address manipulation failed!\n");
   136				/* If we can't redirect "normally", we can't test mitigations. */
   137				return;
   138			}
   139			break;
   140		default:
   141	redirected:
   142			pr_info("ok: redirected stack return address.\n");
   143			break;
   144		}
   145	
   146		pr_info("Attempting checked stack return address redirection ...\n");
   147	
   148		switch (force_check) {
   149		case 0:
   150			set_return_addr(&&check_normal, &&check_redirected);
   151			fallthrough;
   152		case 1:
   153	check_normal:
   154			/* Always true */
   155			if (!force_check) {
   156				pr_info("ok: control flow unchanged.\n");
   157				return;
   158			}
   159	
   160	check_redirected:
   161			pr_err("FAIL: stack return address was redirected!\n");
   162			break;
   163		}
   164	
   165		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL)) {
   166			pr_expected_config(CONFIG_ARM64_PTR_AUTH_KERNEL);
   167			return;
   168		}
   169		if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
   170			pr_expected_config(CONFIG_SHADOW_CALL_STACK);
   171			return;
   172		}
   173		pr_warn("This is probably expected, since this %s was built *without* %s=y nor %s=y\n",
   174			lkdtm_kernel_info,
   175			"CONFIG_ARM64_PTR_AUTH_KERNEL", "CONFIG_SHADOW_CALL_STACK");
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
