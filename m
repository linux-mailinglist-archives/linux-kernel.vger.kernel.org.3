Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADA4A3CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 05:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357620AbiAaE0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 23:26:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:48273 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbiAaE0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643603166; x=1675139166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qVKoCRh34IbpEZlm4rz8/LiZLM+FnC8RWyQZWPg1MKw=;
  b=N816yypF9zAKs6JqcGzecXUETAEsQ+xJed8WjsMTejFvDqi6u9AWcPuH
   G7iPU1zun96OqwsnnIBejua/NKet4DPONWIwAPc9G6DC3TuCrLbA2j6V1
   Vpjdvf2pDX1z2HT2KgVakt4Azk4yV/HcCHCML5zppDhPaZtX0tMyd+Nw8
   iI0FcWTm0LyLf+nYBKKE83FZnm2SDbAwoWR720Ty88YwuvKIFwQEJ4NkJ
   otzWEEOFqIW1X/UKYAdqqRXx6BwSA7EJTuDB9ks4/wUHVqAOJZK0BBpyI
   PXLJhfWf6x5tXTr/YBvgyjoXm1zUVFgbHJj1viCZAtGrxd/3bVhdVRS0M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="228061748"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="228061748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 20:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="522511637"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2022 20:26:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEOGS-000RND-MU; Mon, 31 Jan 2022 04:26:04 +0000
Date:   Mon, 31 Jan 2022 12:25:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:319:45: error: call to
 '__compiletime_assert_234' declared with attribute error: BUILD_BUG_ON
 failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
Message-ID: <202201311235.CG0Foseq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: 39cac191ff37939544af80d5d2af6b870fd94c9b arc/mm/highmem: Use generic kmap atomic implementation
date:   1 year, 3 months ago
config: arc-randconfig-r003-20220130 (https://download.01.org/0day-ci/archive/20220131/202201311235.CG0Foseq-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39cac191ff37939544af80d5d2af6b870fd94c9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 39cac191ff37939544af80d5d2af6b870fd94c9b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/arc/mm/highmem.c: In function 'kmap_init':
>> include/linux/compiler_types.h:319:45: error: call to '__compiletime_assert_234' declared with attribute error: BUILD_BUG_ON failed: FIX_KMAP_SLOTS > PTRS_PER_PTE
     319 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:300:25: note: in definition of macro '__compiletime_assert'
     300 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:319:9: note: in expansion of macro '_compiletime_assert'
     319 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/arc/mm/highmem.c:69:9: note: in expansion of macro 'BUILD_BUG_ON'
      69 |         BUILD_BUG_ON(FIX_KMAP_SLOTS > PTRS_PER_PTE);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_234 +319 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  305  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  306  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  307  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  308  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  309  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  310   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  311   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  312   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  313   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  314   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  315   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  316   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  317   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  318  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @319  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  320  

:::::: The code at line 319 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
