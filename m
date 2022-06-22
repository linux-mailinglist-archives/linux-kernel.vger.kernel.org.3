Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9158554254
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiFVFpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFVFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:45:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D736339
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655876736; x=1687412736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1al0NA0DcInJ4srWwF8okteA4Fime0izH6k8duXBSao=;
  b=BX0SaoAvFwbTTfH+QVoMpB83dLNsHRtB4twqj5seAScaV+u+v8FeAW8P
   MMn5XnWI629je6tGbHHrSch8Qwr5l9lA3AmVbBMqY31KNZdLs7pi7zGcs
   gfjTvvBI9zmZlKxwVIsJlwdpPqY9iCLrsqasR6dYZjbg8Ex5URqe+Hqti
   SCJGXqDBC3mOLDVUuW4B1HUAgJ421J+/2p0hHk9ofn5W5Hnu/Q+xHmKwP
   TMZkiLIUsRgqpepEXt+Vg445LLefZx/A8/kRTT7tHhxhyiAp4droPgEh1
   9TEqXvG6+Pp+6hAlwpno9+8fMSY6x5715t2bffc2N2NW1cdu0JmdOXSQZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344310785"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="344310785"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 22:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="690308734"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 22:45:34 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3tBF-0000tj-MK;
        Wed, 22 Jun 2022 05:45:33 +0000
Date:   Wed, 22 Jun 2022 13:45:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [alobakin:bitops 8/8] lib/test_bitmap.c:904:2: error: call to
 __compiletime_assert_233 declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
Message-ID: <202206221354.8jzbVLLL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   53dc46e3f72d9b77c9c4ec23a3261d452b3bd67a
commit: 53dc46e3f72d9b77c9c4ec23a3261d452b3bd67a [8/8] lib: test_bitmap: add compile-time optimization/evaluations assertions
config: s390-randconfig-r044-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221354.8jzbVLLL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/alobakin/linux/commit/53dc46e3f72d9b77c9c4ec23a3261d452b3bd67a
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout 53dc46e3f72d9b77c9c4ec23a3261d452b3bd67a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:904:2: error: call to __compiletime_assert_233 declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
           BUILD_BUG_ON(!__builtin_constant_p(res));
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:180:1: note: expanded from here
   __compiletime_assert_233
   ^
   1 error generated.


vim +/error +904 lib/test_bitmap.c

   871	
   872	static void __init test_bitmap_const_eval(void)
   873	{
   874		DECLARE_BITMAP(bitmap, BITS_PER_LONG);
   875		unsigned long initvar = BIT(2);
   876		unsigned long bitopvar = 0;
   877		unsigned long var = 0;
   878		int res;
   879	
   880		/*
   881		 * Compilers must be able to optimize all of those to compile-time
   882		 * constants on any supported optimization level (-O2, -Os) and any
   883		 * architecture. Otherwise, trigger a build bug.
   884		 * The whole function gets optimized out then, there's nothing to do
   885		 * in runtime.
   886		 */
   887	
   888		/* Equals to `unsigned long bitmap[1] = { BIT(5), }` */
   889		bitmap_clear(bitmap, 0, BITS_PER_LONG);
   890		if (!test_bit(7, bitmap))
   891			bitmap_set(bitmap, 5, 1);
   892	
   893		/* Equals to `unsigned long bitopvar = BIT(20)` */
   894		__change_bit(31, &bitopvar);
   895		bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
   896	
   897		/* Equals to `unsigned long var = BIT(25)` */
   898		var |= BIT(25);
   899		if (var & BIT(0))
   900			var ^= GENMASK(9, 6);
   901	
   902		/* __const_hweight<32|64>(BIT(5)) == 1 */
   903		res = bitmap_weight(bitmap, 20);
 > 904		BUILD_BUG_ON(!__builtin_constant_p(res));
   905	
   906		/* !(BIT(31) & BIT(18)) == 1 */
   907		res = !test_bit(18, &bitopvar);
   908		BUILD_BUG_ON(!__builtin_constant_p(res));
   909	
   910		/* BIT(2) & GENMASK(14, 8) == 0 */
   911		BUILD_BUG_ON(!__builtin_constant_p(initvar & GENMASK(14, 8)));
   912		/* ~BIT(25) */
   913		BUILD_BUG_ON(!__builtin_constant_p(~var));
   914	}
   915	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
