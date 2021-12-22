Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC347D89C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhLVVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:14:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:52017 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237992AbhLVVOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640207644; x=1671743644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qtcuv87VpnAy2VYqaWBjLnjLSv0iDh2WCm4VqWLVPxw=;
  b=ajeQfHwuhTr8BWiUf34qfTY3cErI5EIoC/sNkskfyZL9X66jMylofN1E
   5xymABcHLeGBkVOSZzsgPv6wig8eO5NGjEAkp92Gu1nT9ndCcFJ6HT/zm
   mhR6qBGfIyGJxmnyU0MMrrXclaRbw87qqemS/adJF98XNunVGk5dMMJVn
   uwjQNB8SmkQY6X/36LDn8USQTsU/h8Q1pcUdTHwXvlE6iYTTyoj3OjHPz
   1AK3g49Fxr/crGnp3JWJLOW/TTYFTAyGzUe3yhiAkHLMIUWigx0VJBusB
   BKb2UMrZqmgp7HuVk5jjdkXgZ8pCEV8N+oAai0jsh8s7MADGEKFfORx6F
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327015991"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="327015991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 13:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="570692791"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2021 13:14:02 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n08vx-0000y7-P7; Wed, 22 Dec 2021 21:14:01 +0000
Date:   Thu, 23 Dec 2021 05:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v1 8/13]
 include/linux/compiler_types.h:335:45: error: call to
 '__compiletime_assert_340' declared with attribute error: BUILD_BUG_ON
 failed: KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << (64 -
 KASAN_SHADOW_SCALE_SHIFT))
Message-ID: <202112230554.PiBj9UiQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v1
head:   60f122c486d0c1c8b30e0b264c215db4a5a0124d
commit: 4fe3cee132aa8a76e949f7b8feb413776d916672 [8/13] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20211223/202112230554.PiBj9UiQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/4fe3cee132aa8a76e949f7b8feb413776d916672
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v1
        git checkout 4fe3cee132aa8a76e949f7b8feb413776d916672
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/riscv/mm/kasan_init.c: In function 'kasan_early_init':
>> include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_340' declared with attribute error: BUILD_BUG_ON failed: KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT))
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
   arch/riscv/mm/kasan_init.c:20:9: note: in expansion of macro 'BUILD_BUG_ON'
      20 |         BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_340 +335 include/linux/compiler_types.h

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
