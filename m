Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431754FB62
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383407AbiFQQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382905AbiFQQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:48:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423C4EA22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484523; x=1687020523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NWT5G7v6qiDI1typND5DU/S+KVPYeSehOILvgouHk4Q=;
  b=II/rItcOdOD5kyCVhR35ZVmDHLxoFHRM5ZojBWx2q70jN0CeVzYnN/w1
   3Nd2F/yIsokqLd/wsnqKHtr1i+H+50fj6EHuAC1TLfpxcCinpCoMFjSJD
   d+3AidYV15KJWoM0/7L2huZXhj1Do55qX9cq5/mFAhNVtl5bjAwitjdm3
   nUdhRLJGTbWlmV24i5i3Q8927Bbi64wIlEcvw9xhfSpuXU8DAeW2Od5QB
   WnQPeHv/xOdN4qfFifr9SbHfxhG2JFRIYhIv9fJ5qWxyPSqquFE0UWN6+
   wA1QeJyTRjO8MXOlv1Kgzn90kCS+S5MrJLLpo9gjSfPtPzJcjo9NMRaPA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304934785"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="304934785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 06:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642038625"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2022 06:51:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2CNy-000PUD-PM;
        Fri, 17 Jun 2022 13:51:42 +0000
Date:   Fri, 17 Jun 2022 21:51:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 66/146]
 include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_224' declared with attribute error: FIELD_GET: mask is
 not constant
Message-ID: <202206172131.vepUdudV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: 2881ac404cd937d1529d641acc4055fb14822de0 [66/146] fs/resctrl: Export the closid/rmid to user-space
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220617/202206172131.vepUdudV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=2881ac404cd937d1529d641acc4055fb14822de0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout 2881ac404cd937d1529d641acc4055fb14822de0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   fs/resctrl/rdtgroup.c:1461:14: note: in expansion of macro 'FIELD_PREP'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |              ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   fs/resctrl/rdtgroup.c:1461:25: note: in expansion of macro 'RESCTRL_ID_RMID'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |                         ^~~~~~~~~~~~~~~
   In file included from include/linux/resctrl.h:5,
                    from fs/resctrl/internal.h:5,
                    from fs/resctrl/rdtgroup.c:33:
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   fs/resctrl/rdtgroup.c:1461:14: note: in expansion of macro 'FIELD_PREP'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |              ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   fs/resctrl/rdtgroup.c:1461:25: note: in expansion of macro 'RESCTRL_ID_RMID'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |                         ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   fs/resctrl/rdtgroup.c:1461:14: note: in expansion of macro 'FIELD_PREP'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |              ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   fs/resctrl/rdtgroup.c:1461:25: note: in expansion of macro 'RESCTRL_ID_RMID'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |                         ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:115:63: note: in definition of macro 'FIELD_PREP'
     115 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   fs/resctrl/rdtgroup.c:1461:25: note: in expansion of macro 'RESCTRL_ID_RMID'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |                         ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:115:63: note: in definition of macro 'FIELD_PREP'
     115 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   fs/resctrl/rdtgroup.c:1461:25: note: in expansion of macro 'RESCTRL_ID_RMID'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |                         ^~~~~~~~~~~~~~~
   In file included from <command-line>:
   In function '__resctrl_id_decode',
       inlined from 'resctrl_id_decode' at fs/resctrl/rdtgroup.c:1471:2:
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_224' declared with attribute error: FIELD_GET: mask is not constant
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   In function 'resctrl_id_encode',
       inlined from 'rdtgroup_id_show' at fs/resctrl/rdtgroup.c:1507:8:
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_246' declared with attribute error: FIELD_PREP: mask is not constant
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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
   fs/resctrl/rdtgroup.c:1461:14: note: in expansion of macro 'FIELD_PREP'
    1461 |              FIELD_PREP(RESCTRL_ID_RMID, rmid);
         |              ^~~~~~~~~~


vim +/__compiletime_assert_224 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
