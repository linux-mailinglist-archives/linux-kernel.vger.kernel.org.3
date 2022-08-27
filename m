Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E025A35C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbiH0IDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbiH0ICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:02:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8636170B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661587372; x=1693123372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t4s7PJsF+XQiNPvI7hWCOrw+97ygo5kzYBM70ND3TtU=;
  b=VVfhIWALDoq+vRL0ONoGbdh5WqnPNaGWvLL3oTSnluGbIdRQ0fYtdPH7
   vdqf26gFX+RCiOrA9cxmsxq4N+lBiwWsv926Vdi427bYe44AtezWEqJrf
   MSNIaNYQ77WPsiLUWFSAtlxl73TWqitcN7A4x3JVR13AccKpENu1dTBqj
   0aPK1r5Ro8UhtS47RU8wdMGZ47YGxA3uqWvADjIKxN3h68Afa81x47SOC
   T0UdqO961RbCx4CK3mo1vbGdL+53YrSONoBQvQxwEXGqgtCxA9MmD9D2s
   kV54eb+uMxWN0JsDkMdspuAEf0GJJV+8ruDQ/HEq1CMeBO2kPCL9LK/ck
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="277661530"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="277661530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 01:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="700081484"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2022 01:02:42 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRqmA-000175-09;
        Sat, 27 Aug 2022 08:02:42 +0000
Date:   Sat, 27 Aug 2022 16:02:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/insn/rework 9/10] include/linux/compiler_types.h:354:45:
 error: call to '__compiletime_assert_782' declared with attribute error:
 BUILD_BUG_ON failed: !aarch64_insn_is_adrp(insn)
Message-ID: <202208271534.S8qjhvQ9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/insn/rework
head:   93eeddf361d2aa52865155791d8f344896f98cb8
commit: 484a2f552745c6634031e23e9e14bbc1f5ccd581 [9/10] arm64: insn: rework ADRP helpers
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220827/202208271534.S8qjhvQ9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=484a2f552745c6634031e23e9e14bbc1f5ccd581
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/insn/rework
        git checkout 484a2f552745c6634031e23e9e14bbc1f5ccd581
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/module-plts.c:285:5: warning: no previous prototype for 'module_frob_arch_sections' [-Wmissing-prototypes]
     285 | int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   In function 'aarch64_insn_adrp_get_offset',
       inlined from 'plt_entries_equal' at arch/arm64/kernel/module-plts.c:59:14:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_782' declared with attribute error: BUILD_BUG_ON failed: !aarch64_insn_is_adrp(insn)
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/insn.h:851:9: note: in expansion of macro 'BUILD_BUG_ON'
     851 |         BUILD_BUG_ON(!aarch64_insn_is_adrp(insn));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_782 +354 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355  

:::::: The code at line 354 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
