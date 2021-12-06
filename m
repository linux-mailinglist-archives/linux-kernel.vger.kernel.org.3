Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB246A0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376931AbhLFQM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:12:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:43185 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445640AbhLFQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:12:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237156183"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237156183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 08:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="542437618"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2021 08:08:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muGXD-000LRp-0c; Mon, 06 Dec 2021 16:08:11 +0000
Date:   Tue, 7 Dec 2021 00:07:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Volodymyr Mytnyk <vmytnyk@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vadym Kochan <vkochan@marvell.com>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>
Subject: include/linux/compiler_types.h:322:45: error: call to
 '__compiletime_assert_368' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(struct prestera_msg_event_fdb) != 20
Message-ID: <202112070020.g6ADUeiU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
commit: bb5dbf2cc64d5cfa696765944c784c0010c48ae8 net: marvell: prestera: add firmware v4.0 support
date:   5 weeks ago
config: arm-randconfig-r003-20211206 (https://download.01.org/0day-ci/archive/20211207/202112070020.g6ADUeiU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb5dbf2cc64d5cfa696765944c784c0010c48ae8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bb5dbf2cc64d5cfa696765944c784c0010c48ae8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/prestera/prestera_hw.c:284:1: warning: alignment 1 of 'union prestera_msg_port_param' is less than 4 [-Wpacked-not-aligned]
     284 | } __packed;
         | ^
   In file included from <command-line>:
   In function 'prestera_hw_build_tests',
       inlined from 'prestera_hw_switch_init' at drivers/net/ethernet/marvell/prestera/prestera_hw.c:788:2:
>> include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_368' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct prestera_msg_event_fdb) != 20
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/prestera/prestera_hw.c:531:9: note: in expansion of macro 'BUILD_BUG_ON'
     531 |         BUILD_BUG_ON(sizeof(struct prestera_msg_event_fdb) != 20);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_368 +322 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  308  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  309  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  310  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  311  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  312  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  314   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  315   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  316   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  317   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  318   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  321  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @322  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  323  

:::::: The code at line 322 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
