Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706E576C76
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiGPICK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:02:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52C27B00
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657958525; x=1689494525;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f12xGD20zUzK0e6oaPQHRJXX1MBn3vsPxRZT2QamBrM=;
  b=Bb5j0YTxCKOqQPSQp2NI5Q0CZDWjSM+5UGMT3hJ1X/tcfBK7WXjYHYL8
   h44ziEXkDTLv+Qs7JFa3tiXzYZd6TXr+bRLcFukO/DUayNWIuv1cRoolf
   lN01XwFxaZBmEPdCvM0BujK0bzRmYaevErJOUbISVefedZ3nfnvMYPnNt
   LRLKdnYkKv1Bb2MGQfjKlE2hrXFSsz1eAzMkeOdRcQZYFJbW1+vMkwzPN
   iNzjant6T3+s9goK9ZeKjM43qv/N9XV/thFSIPOytKV3e8SU6lqH3UlQo
   b5s+4GfkoI1c0xH1CIZ83D9Tl/HYDw1u7zBcx2vyewc+bBeJmfOKji8Mq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286693599"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="286693599"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 01:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="546928298"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 01:02:03 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCckU-0001HY-Q7;
        Sat, 16 Jul 2022 08:02:02 +0000
Date:   Sat, 16 Jul 2022 16:01:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 15/24] include/linux/compiler_types.h:354:45:
 error: call to '__compiletime_assert_277' declared with attribute error:
 BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
Message-ID: <202207161502.X3pdC4MC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   84a3fd7f92957f64c411595a9efcc2eed18db2be
commit: 5faed77192c5455fe17fb4e6aea87e5bcc48a13d [15/24] COVER
config: arm64-randconfig-r023-20220716 (https://download.01.org/0day-ci/archive/20220716/202207161502.X3pdC4MC-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc
        git checkout 5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'fix_to_virt',
       inlined from 'patch_map' at arch/arm64/kernel/patching.c:45:17:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_277' declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
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
   include/asm-generic/fixmap.h:32:9: note: in expansion of macro 'BUILD_BUG_ON'
      32 |         BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_277 +354 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  340  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  344  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  348   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  351   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  352   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  355  

:::::: The code at line 354 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
