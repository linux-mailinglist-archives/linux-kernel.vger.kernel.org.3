Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0625661BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiGEDSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiGEDSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:18:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB51057F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656991127; x=1688527127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y8/vsJ2akNeG1JxUoeIHqSTZ/tzFxtb2EVBPNYJ85K4=;
  b=NVLqPU53sMNl9SExBYNqybvVcKTvzgAEF+teypyBMEJHv3ztDyt6rmYO
   BCDjZ2l1HgZ/mB+xrr+UXRjt7X7/YNsOrBpcWunK/9nqOgy0LHYQIn7JH
   LMJXpBWpVhCQs+Pw0+EcP3ULJynZjbv06Z9l+hKVRJqIND1XNKW+PNS75
   5PEV2Tq+P5nXWfgaFrOfjGtxUwZqxxp/5+JcN33KEdJTZgDkZ4xWoPpTg
   /RrzBK4ksL9XjthmccNKdivcEzwxyzEYY/D/2+9PqLXnNaPMkLs0qwwsj
   M+6m/gDYcMdwE7p/POmZFFrN7qLqFnIMYCnOzsBgLaKMAijaglUfoelVQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283969001"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283969001"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 20:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919535162"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 20:18:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Z5J-000Ifl-4A;
        Tue, 05 Jul 2022 03:18:45 +0000
Date:   Tue, 5 Jul 2022 11:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: lib/stackinit_kunit.c:259:8: warning: Excessive padding in 'struct
 test_big_hole' (124 padding bytes, where 60 is optimal). Optimal fields
 order: four, one, two, three, consider reordering the fields or adding
 explicit padding members [clang-analyzer-opti...
Message-ID: <202207051135.RcGXqwnQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1084b6c5620a743f86947caca66d90f24060f56
commit: 02788ebcf521fe78c24eb221fd1ed7f86792c330 lib: stackinit: Convert to KUnit
date:   4 months ago
config: riscv-randconfig-c006-20220703 (https://download.01.org/0day-ci/archive/20220705/202207051135.RcGXqwnQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02788ebcf521fe78c24eb221fd1ed7f86792c330
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 02788ebcf521fe78c24eb221fd1ed7f86792c330
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
   include/asm-generic/bug.h:161:27: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                             ^
   fs/reiserfs/inode.c:1943:6: note: 'err' is 0
           if (err)
               ^~~
   fs/reiserfs/inode.c:1943:2: note: Taking false branch
           if (err)
           ^
   fs/reiserfs/inode.c:1945:6: note: Assuming field 'i_nlink' is not equal to 0
           if (!dir->i_nlink) {
               ^~~~~~~~~~~~~
   fs/reiserfs/inode.c:1945:2: note: Taking false branch
           if (!dir->i_nlink) {
           ^
   fs/reiserfs/inode.c:1953:6: note: Assuming field 'k_objectid' is not equal to 0
           if (!ih.ih_key.k_objectid) {
               ^~~~~~~~~~~~~~~~~~~~~
   fs/reiserfs/inode.c:1953:2: note: Taking false branch
           if (!ih.ih_key.k_objectid) {
           ^
   fs/reiserfs/inode.c:1958:6: note: Assuming the condition is false
           if (old_format_only(sb))
               ^
   fs/reiserfs/reiserfs.h:728:29: note: expanded from macro 'old_format_only'
   #define old_format_only(s) (REISERFS_SB(s)->s_properties & (1 << REISERFS_3_5))
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/reiserfs/inode.c:1958:2: note: Taking false branch
           if (old_format_only(sb))
           ^
   fs/reiserfs/inode.c:1962:3: note: Calling 'make_le_item_head'
                   make_le_item_head(&ih, NULL, KEY_FORMAT_3_6, SD_OFFSET,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/reiserfs/inode.c:142:6: note: 'key' is null
           if (key) {
               ^~~
   fs/reiserfs/inode.c:142:2: note: Taking false branch
           if (key) {
           ^
   fs/reiserfs/inode.c:147:2: note: Loop condition is false.  Exiting loop
           put_ih_version(ih, version);
           ^
   fs/reiserfs/reiserfs.h:1403:38: note: expanded from macro 'put_ih_version'
   #define put_ih_version(ih, val)      do { (ih)->ih_version = cpu_to_le16(val); } while (0)
                                        ^
   fs/reiserfs/inode.c:148:2: note: Calling 'set_le_ih_k_offset'
           set_le_ih_k_offset(ih, offset);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/reiserfs/reiserfs.h:1522:2: note: Calling 'set_le_key_k_offset'
           set_le_key_k_offset(ih_version(ih), &(ih->ih_key), offset);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/reiserfs/reiserfs.h:1502:6: note: 'version' is not equal to KEY_FORMAT_3_5
           if (version == KEY_FORMAT_3_5)
               ^~~~~~~
   fs/reiserfs/reiserfs.h:1502:2: note: Taking false branch
           if (version == KEY_FORMAT_3_5)
           ^
   fs/reiserfs/reiserfs.h:1505:3: note: Calling 'set_offset_v2_k_offset'
                   set_offset_v2_k_offset(&key->u.k_offset_v2, offset);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/reiserfs/reiserfs.h:1280:17: note: The left operand of '&' is a garbage value
           v2->v = (v2->v & cpu_to_le64(15ULL << 60)) | cpu_to_le64(offset);
                    ~~~~~ ^
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   3 warnings generated.
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (2 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (2 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   135 warnings generated.
>> lib/stackinit_kunit.c:259:8: warning: Excessive padding in 'struct test_big_hole' (124 padding bytes, where 60 is optimal). Optimal fields order: four, one, two, three, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct test_big_hole {
   ~~~~~~~^~~~~~~~~~~~~~~
   lib/stackinit_kunit.c:259:8: note: Excessive padding in 'struct test_big_hole' (124 padding bytes, where 60 is optimal). Optimal fields order: four, one, two, three, consider reordering the fields or adding explicit padding members
   struct test_big_hole {
   ~~~~~~~^~~~~~~~~~~~~~~
   lib/stackinit_kunit.c:333:1: warning: Address of stack memory associated with local variable 'var' is still referred to by the global variable 'fill_start' upon returning to the caller.  This will be a dangling reference [clang-analyzer-core.StackAddressEscape]
   DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
   ^
   lib/stackinit_kunit.c:309:3: note: expanded from macro 'DEFINE_SCALAR_TESTS'
                   DEFINE_SCALAR_TEST(u8, init, xfail);            \
                   ^
   lib/stackinit_kunit.c:305:3: note: expanded from macro 'DEFINE_SCALAR_TEST'
                   DEFINE_TEST(name ## _ ## init, name, SCALAR,    \
                   ^
   lib/stackinit_kunit.c:237:2: note: expanded from macro 'DEFINE_TEST'
           return (int)buf[0] | (int)buf[sizeof(buf) - 1];         \
           ^
   lib/stackinit_kunit.c:333:1: note: Taking false branch
   DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
   ^
   lib/stackinit_kunit.c:309:3: note: expanded from macro 'DEFINE_SCALAR_TESTS'
                   DEFINE_SCALAR_TEST(u8, init, xfail);            \
                   ^
   lib/stackinit_kunit.c:305:3: note: expanded from macro 'DEFINE_SCALAR_TEST'
                   DEFINE_TEST(name ## _ ## init, name, SCALAR,    \
                   ^
   lib/stackinit_kunit.c:238:10: note: expanded from macro 'DEFINE_TEST'
   }                                                               \
                                                                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:346:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:334:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:326:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   lib/stackinit_kunit.c:333:1: note: Loop condition is false.  Exiting loop
   DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
   ^
   lib/stackinit_kunit.c:309:3: note: expanded from macro 'DEFINE_SCALAR_TESTS'
                   DEFINE_SCALAR_TEST(u8, init, xfail);            \
                   ^
   lib/stackinit_kunit.c:305:3: note: expanded from macro 'DEFINE_SCALAR_TEST'
                   DEFINE_TEST(name ## _ ## init, name, SCALAR,    \
                   ^
   lib/stackinit_kunit.c:238:10: note: expanded from macro 'DEFINE_TEST'
   }                                                               \
                                                                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:346:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:334:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:318:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   lib/stackinit_kunit.c:333:1: note: Calling 'leaf_u8_zero'
   DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
   ^
   lib/stackinit_kunit.c:309:3: note: expanded from macro 'DEFINE_SCALAR_TESTS'
                   DEFINE_SCALAR_TEST(u8, init, xfail);            \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/stackinit_kunit.c:305:3: note: expanded from macro 'DEFINE_SCALAR_TEST'
                   DEFINE_TEST(name ## _ ## init, name, SCALAR,    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/stackinit_kunit.c:238:10: note: expanded from macro 'DEFINE_TEST'
   }                                                               \
                                                                   ^
   lib/stackinit_kunit.c:163:12: note: expanded from macro '\
   DEFINE_TEST_DRIVER'
           ignored = leaf_ ##name((unsigned long)&ignored, 1,      \
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: expanded from here
   lib/stackinit_kunit.c:333:1: note: 'fill' is true
   DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
   ^
   lib/stackinit_kunit.c:309:3: note: expanded from macro 'DEFINE_SCALAR_TESTS'
                   DEFINE_SCALAR_TEST(u8, init, xfail);            \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/stackinit_kunit.c:305:3: note: expanded from macro 'DEFINE_SCALAR_TEST'
                   DEFINE_TEST(name ## _ ## init, name, SCALAR,    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/stackinit_kunit.c:223:6: note: expanded from macro 'DEFINE_TEST'
           if (fill) {                                             \
               ^~~~
   lib/stackinit_kunit.c:333:1: note: Taking true branch
   DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
   ^
   lib/stackinit_kunit.c:309:3: note: expanded from macro 'DEFINE_SCALAR_TESTS'
                   DEFINE_SCALAR_TEST(u8, init, xfail);            \
                   ^
   lib/stackinit_kunit.c:305:3: note: expanded from macro 'DEFINE_SCALAR_TEST'
                   DEFINE_TEST(name ## _ ## init, name, SCALAR,    \
                   ^
   lib/stackinit_kunit.c:223:2: note: expanded from macro 'DEFINE_TEST'

vim +259 lib/stackinit_kunit.c

50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  257  
f9398f15605a50 lib/test_stackinit.c Kees Cook 2021-07-23  258  /* Trigger unhandled padding in a structure. */
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23 @259  struct test_big_hole {
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  260  	u8 one;
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  261  	u8 two;
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  262  	u8 three;
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  263  	/* 61 byte padding hole here. */
f9398f15605a50 lib/test_stackinit.c Kees Cook 2021-07-23  264  	u8 four __aligned(64);
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  265  } __aligned(64);
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  266  

:::::: The code at line 259 was first introduced by commit
:::::: 50ceaa95ea09703722b30b4afa617c972071cd7f lib: Introduce test_stackinit module

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
