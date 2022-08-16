Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F5595A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiHPLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiHPLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:36:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EF9C6536
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660647716; x=1692183716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zuKvvCbOiSOfUsk2tQb96EE443GOWd6hdwmlwRUxTT8=;
  b=mxLAN0x52xh0meSImBj/XkEFco5M6ChzlNfyTrqiZj9FUWd0U0BsAIrk
   rDLXqd8uzr5rZHrQBOsctIsf4tRMOnm6MLncbFRSilE+XR3qFSFfWOT3S
   0aP3bZ9zWZkhaSw5bx7l64btxFphyTV5aWlkdMubHedAtmrOkP73qsyes
   mXtPA0SDjuKByDia4fkKaorIxJSdx4GQnAkojZBqwpA0ssLnqTazzsIeT
   5I2iBEmKfmYxSfI09JNm7gVHV4u1XrnMcdxFDIdAfhjnzr98p8yfMkESp
   w0Sqxc8CHQYB4rnmOj7y/sAihEcsv1BxRg/q5FzdwqbnsT2+dMlH4wqQm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290942271"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290942271"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667066460"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 04:01:53 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNuKW-0001iP-2e;
        Tue, 16 Aug 2022 11:01:52 +0000
Date:   Tue, 16 Aug 2022 19:01:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 4/17]
 include/linux/compiler_types.h:354:45: error: call to
 '__compiletime_assert_377' declared with attribute error: FIELD_PREP: mask
 is not constant
Message-ID: <202208161856.lyCoTMHi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   85225bbe01a2a74102db8d75e316b4e46f1cb07f
commit: 59000ffdca0f77c3f45fe7610510b17382fc8974 [4/17] platform/apple: Add new Apple Mac SMC driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220816/202208161856.lyCoTMHi-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/59000ffdca0f77c3f45fe7610510b17382fc8974
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 59000ffdca0f77c3f45fe7610510b17382fc8974
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:129:44: note: in definition of macro 'FIELD_GET'
     129 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:129:44: note: in definition of macro 'FIELD_GET'
     129 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/platform/apple/smc_rtkit.c:332:45: note: in expansion of macro 'FIELD_GET'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/platform/apple/smc_rtkit.c:332:45: note: in expansion of macro 'FIELD_GET'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_417' declared with attribute error: FIELD_GET: mask is not constant
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
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:45: note: in expansion of macro 'FIELD_GET'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   In function 'apple_smc_cmd',
       inlined from 'apple_smc_rtkit_get_key_info' at drivers/platform/apple/smc_rtkit.c:224:8:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_377' declared with attribute error: FIELD_PREP: mask is not constant
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
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:125:16: note: in expansion of macro 'FIELD_PREP'
     125 |                FIELD_PREP(SMC_DATA, arg));
         |                ^~~~~~~~~~
   In function 'apple_smc_cmd',
       inlined from 'apple_smc_rtkit_get_key_by_index' at drivers/platform/apple/smc_rtkit.c:212:8:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_377' declared with attribute error: FIELD_PREP: mask is not constant
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
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:125:16: note: in expansion of macro 'FIELD_PREP'
     125 |                FIELD_PREP(SMC_DATA, arg));
         |                ^~~~~~~~~~
   In function 'apple_smc_cmd',
       inlined from '_apple_smc_rtkit_read_key.isra' at drivers/platform/apple/smc_rtkit.c:167:8:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_377' declared with attribute error: FIELD_PREP: mask is not constant
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
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:125:16: note: in expansion of macro 'FIELD_PREP'
     125 |                FIELD_PREP(SMC_DATA, arg));
         |                ^~~~~~~~~~
   In function 'apple_smc_cmd',
       inlined from 'apple_smc_rtkit_write_key' at drivers/platform/apple/smc_rtkit.c:192:9:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_377' declared with attribute error: FIELD_PREP: mask is not constant
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
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:125:16: note: in expansion of macro 'FIELD_PREP'
     125 |                FIELD_PREP(SMC_DATA, arg));
         |                ^~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_write_key_atomic':
   include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_332' declared with attribute error: FIELD_PREP: mask is not constant
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
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:77:16: note: in expansion of macro 'FIELD_PREP'
      77 |                FIELD_PREP(SMC_DATA, key));
         |                ^~~~~~~~~~


vim +/__compiletime_assert_377 +354 include/linux/compiler_types.h

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
