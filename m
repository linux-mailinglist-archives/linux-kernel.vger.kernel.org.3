Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD00A555223
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377313AbiFVRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377306AbiFVRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:16:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5F1159
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655918217; x=1687454217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n4yhqG+LU29ooFZAPH5woGAXIo4qRtzL2wSTnLiPG0Y=;
  b=cFKUuahKMmd45WZIVqmnXVadZoCzycgauZsryIHEvntWxBC8q2UI+dQB
   a7eJw4akmQ6zDWijXNex0aBF2bW6rgWwtmno3NCA2NG9Iv0m/MsiNh/xF
   A+ui0vimkZsRqT7dSXWRciIJO7k3VmQnjuIuRxaLPuU7zfZmmnSf001lP
   TeqdbO7gPwN7gWX58P2jZyYVI/ZCvt5K7xm9r1mzqbelpSm1GewZCTYi3
   jwocBR3jQcTRnv5pnzvh4AtmSnj95uZ8tzqFPiXkr+pglND3GTVqrq/ZH
   n9ER2qQ737n6o8Hx6Wr489bQIImMXdF8Ua5mWOXWvh+iFAwNYWdtEx4TJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342166712"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342166712"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690603560"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 10:16:55 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o43yI-0001W5-Je;
        Wed, 22 Jun 2022 17:16:54 +0000
Date:   Thu, 23 Jun 2022 01:16:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [norov:fns 7/19] include/linux/compiler_types.h:352:45: error: call
 to '__compiletime_assert_600' declared with attribute error: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
Message-ID: <202206230121.wlBiPZcR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux fns
head:   dc85542660535a9072c3b98819f4b80ff182b92a
commit: 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f [7/19] lib: test_bitmap: add compile-time optimization/evaluations assertions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230121.wlBiPZcR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   lib/test_bitmap.c: In function 'test_bitmap_const_eval':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_600' declared with attribute error: BUILD_BUG_ON failed: !__builtin_constant_p(res)
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
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/test_bitmap.c:904:9: note: in expansion of macro 'BUILD_BUG_ON'
     904 |         BUILD_BUG_ON(!__builtin_constant_p(res));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_600 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  353  

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
