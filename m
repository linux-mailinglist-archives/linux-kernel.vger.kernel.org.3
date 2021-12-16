Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92F476B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhLPHZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:25:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:57407 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhLPHZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639639547; x=1671175547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N7NUQnAt+/agyuam93aBJVf+FxNemRWA4qMhv3PZCoc=;
  b=HHnKQY7258htivgOUHrOkqhYMW8C4OD7u9+N8d2E5YE3gEYUbvGQgHzN
   RGB9Q7KYvubIaMpNWQ+cqomMBK1TnH3vQbJ4veNWKlN0/hGnpC7MGvDrr
   uxZYVaz2/PVMvwjdTvPXgeLRkoDcCAvOdjsAO3yoPST+Pnosk3TjwQeur
   CpnCu59Rh3UuxU0l5H9owp+5w3BAF2KlqeYceSuLCRdgkoBtIIN4y7L0t
   x5E2I0oJmvbYdWpg54yH3TAhUlgrnPP4X/puR3XN6Q2kswlI89cHBKwYK
   AmytCauCpXzxCoLbUYLzLPlQogAzVLrim59iyvIKSp2pbI3R5BN3NFI54
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220105191"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="220105191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 23:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="465931907"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2021 23:25:45 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxl96-0002tN-Bu; Thu, 16 Dec 2021 07:25:44 +0000
Date:   Thu, 16 Dec 2021 15:25:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 313/325]
 include/linux/compiler_types.h:335:45: error: call to
 '__compiletime_assert_344' declared with attribute error: BUILD_BUG_ON
 failed: xfbtree_bbsize() != xfo_to_bb(1)
Message-ID: <202112161552.z3DAtTY4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git repair-symlink-swapext
head:   851df07d9599471df909c4ff0e3cf33f4b9619f0
commit: 53f0df23f10ebce0fd9e928cafd6a6c11dd9effc [313/325] xfs: support in-memory btrees
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211216/202112161552.z3DAtTY4-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=53f0df23f10ebce0fd9e928cafd6a6c11dd9effc
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout 53f0df23f10ebce0fd9e928cafd6a6c11dd9effc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/xfs/scrub/xfbtree.c: In function 'xfbtree_ptr_to_daddr':
>> include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_344' declared with attribute error: BUILD_BUG_ON failed: xfbtree_bbsize() != xfo_to_bb(1)
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:316:25: note: in definition of macro '__compiletime_assert'
     316 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   fs/xfs/scrub/xfbtree.c:165:9: note: in expansion of macro 'BUILD_BUG_ON'
     165 |         BUILD_BUG_ON(xfbtree_bbsize() != xfo_to_bb(1));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_344 +335 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  321  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  322  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  323  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  324  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  325  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  327   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  328   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  329   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  330   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  331   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  332   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @335  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  

:::::: The code at line 335 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
