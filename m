Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D819758D427
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiHIHEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHIHEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:04:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787B1CB09
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660028685; x=1691564685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c9rz1QFpgr7P8OUQ0jtVXvlcp16HHW9uL6/FaIw9cdc=;
  b=e5q8DuImGcZ4HtGJcK9nLu6b9nS9Hxib8Y25YziqEX3qo0k/d8FyrHGf
   qFioB9tl9GFrkbDMQKNHhVnmvi5Zi3ojf1B32XGEMV0I4JPsxs7ij0aur
   Y075bB7GCFA25d07N3bypymBfkrAyowLuYJPdeA+OJ/ecatgybLrKWnuk
   lemVVzd8q/QnZ35un4c/vRNB7rJtAOOEOyk62TN5oJGz7xW3lx9rt2Nzs
   3UryBfh1D1O2jiUZeLEqRV11/3KYi9Ve1V8cwrCQU7UTbMV+QWbNJ5rwX
   J4zb+C1i0AiQDicrtxY83qKUwbMJj7fNL8C+3oTUe8CU87+P4oVjGf6Up
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="273820766"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="273820766"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 00:04:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="694041659"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2022 00:04:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLJIA-000Moy-35;
        Tue, 09 Aug 2022 07:04:42 +0000
Date:   Tue, 9 Aug 2022 15:04:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-amx:init_fpstate 2/3] arch/x86/kernel/fpu/xstate.c:362:24:
 warning: format specifies type 'unsigned int' but the argument has type
 'unsigned long'
Message-ID: <202208091405.uYHLXk68-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/amx-linux.git init_fpstate
head:   b1323896658f2b069193a782265a47e3c99611e4
commit: 86878d20f388dc243b534c20a5de1bedfb534df1 [2/3] x86/fpu: Avoid the init XSTATE buffer overflow
config: x86_64-randconfig-r023-20220808 (https://download.01.org/0day-ci/archive/20220809/202208091405.uYHLXk68-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/amx-linux/commit/86878d20f388dc243b534c20a5de1bedfb534df1
        git remote add intel-amx https://github.com/intel/amx-linux.git
        git fetch --no-tags intel-amx init_fpstate
        git checkout 86878d20f388dc243b534c20a5de1bedfb534df1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/fpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:362:24: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                          "%u bytes\n", sizeof(union fpregs_state), init_fpstate.size);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:507:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +362 arch/x86/kernel/fpu/xstate.c

   328	
   329	/*
   330	 * All supported features have either init state all zeros or are
   331	 * handled in setup_init_fpu() individually. This is an explicit
   332	 * feature list and does not use XFEATURE_MASK*SUPPORTED to catch
   333	 * newly added supported features at build time and make people
   334	 * actually look at the init state for the new feature.
   335	 */
   336	#define XFEATURES_INIT_FPSTATE_HANDLED		\
   337		(XFEATURE_MASK_FP |			\
   338		 XFEATURE_MASK_SSE |			\
   339		 XFEATURE_MASK_YMM |			\
   340		 XFEATURE_MASK_OPMASK |			\
   341		 XFEATURE_MASK_ZMM_Hi256 |		\
   342		 XFEATURE_MASK_Hi16_ZMM	 |		\
   343		 XFEATURE_MASK_PKRU |			\
   344		 XFEATURE_MASK_BNDREGS |		\
   345		 XFEATURE_MASK_BNDCSR |			\
   346		 XFEATURE_MASK_PASID |			\
   347		 XFEATURE_MASK_XTILE)
   348	
   349	/*
   350	 * setup the xstate image representing the init state
   351	 */
   352	static int __init setup_init_fpu_buf(void)
   353	{
   354		BUILD_BUG_ON((XFEATURE_MASK_USER_SUPPORTED |
   355			      XFEATURE_MASK_SUPERVISOR_SUPPORTED) !=
   356			     XFEATURES_INIT_FPSTATE_HANDLED);
   357	
   358		print_xstate_features();
   359	
   360		if (init_fpstate.size > sizeof(union fpregs_state)) {
   361			pr_err("x86/fpu: init_fpstate (%u bytes) is not enough for the configured size:"
 > 362			       "%u bytes\n", sizeof(union fpregs_state), init_fpstate.size);
   363			return -EINVAL;
   364		}
   365	
   366		xstate_init_xcomp_bv(&init_fpstate.regs.xsave, init_fpstate.xfeatures);
   367	
   368		/*
   369		 * Init all the features state with header.xfeatures being 0x0
   370		 */
   371		os_xrstor_booting(&init_fpstate.regs.xsave);
   372	
   373		/*
   374		 * All components are now in init state. Read the state back so
   375		 * that init_fpstate contains all non-zero init state. This only
   376		 * works with XSAVE, but not with XSAVEOPT and XSAVEC/S because
   377		 * those use the init optimization which skips writing data for
   378		 * components in init state.
   379		 *
   380		 * XSAVE could be used, but that would require to reshuffle the
   381		 * data when XSAVEC/S is available because XSAVEC/S uses xstate
   382		 * compaction. But doing so is a pointless exercise because most
   383		 * components have an all zeros init state except for the legacy
   384		 * ones (FP and SSE). Those can be saved with FXSAVE into the
   385		 * legacy area. Adding new features requires to ensure that init
   386		 * state is all zeroes or if not to add the necessary handling
   387		 * here.
   388		 */
   389		fxsave(&init_fpstate.regs.fxsave);
   390		return 0;
   391	}
   392	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
