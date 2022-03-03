Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087994CB54F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiCCDNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiCCDN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:13:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE065E2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646277163; x=1677813163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oiBxM+Dk06pIBtxUU/wgmez2/avML2DTNdQkfjW+cYA=;
  b=frQTFc7XqrHWiIJp0iDcbcOFuU0Duy5AgREFUXIMTd7be6hP4ZL5j3os
   4ibGRDEhdhxAGM6noh4UduMh/Or7BaZ7Mupd9w9eMWibIXRPslS/MA/sM
   iEaBmX8l6+iR6qPNnPkwK16qCVJ1YxLM7GK8Dw21ex1ouAwHib4LTjqXb
   kJbhLi8mZL343ZEpt7+QkHW7RDDbufmjz+R6k/JuJntiuTmhtsTj0dCkL
   YoHyTUtOhL9t9RfCFyJ8rwAM3uqPKm5VmnhZ9RwsJ2Y738XZtpMzD4bKx
   +s8xF+TRot8D1xU1LCk+NfPE7BIC+Jcqz06P129pi/fHPNt7oidjQ8F4P
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316782836"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="316782836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 19:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="535641923"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 19:12:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPbtR-00004F-GD; Thu, 03 Mar 2022 03:12:41 +0000
Date:   Thu, 3 Mar 2022 11:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:fsnotify-volatile 5/5]
 include/linux/compiler_types.h:346:45: error: call to
 '__compiletime_assert_271' declared with attribute error: BUILD_BUG_ON
 failed: HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13
Message-ID: <202203030951.3eFFn4A5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fsnotify-volatile
head:   bc58808cbec71bead5572997dafe604c50f2b4af
commit: bc58808cbec71bead5572997dafe604c50f2b4af [5/5] fanotify: FAN_MARK_VOLATILE - WIP
config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20220303/202203030951.3eFFn4A5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/bc58808cbec71bead5572997dafe604c50f2b4af
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il fsnotify-volatile
        git checkout bc58808cbec71bead5572997dafe604c50f2b4af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/notify/fanotify/fanotify_user.c: In function 'fanotify_user_setup':
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_271' declared with attribute error: BUILD_BUG_ON failed: HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   fs/notify/fanotify/fanotify_user.c:1756:9: note: in expansion of macro 'BUILD_BUG_ON'
    1756 |         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_271 +346 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  332  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  333  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  334  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  335  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  336  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  337   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  338   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  339   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  340   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  341   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  342   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  343   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  344   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  345  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @346  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  347  

:::::: The code at line 346 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
