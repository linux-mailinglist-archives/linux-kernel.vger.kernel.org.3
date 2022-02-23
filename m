Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A844C1CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiBWUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiBWUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86984C79D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645646868; x=1677182868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qq/Uj/oanOOnM1hq1nBDWXIWp/d/ZOT1rfxnh3bhqLg=;
  b=Nlqa+Jd1RnDeFlXPMHApzH24yGb8YF10Fy+ZtgaUgGHOG2NBBR4J3+ut
   0SA8Plw/7tti/WwC8pR4PrfRlXn/N9FinkRUsHFh6yk65r+yI98G6kxis
   +OsgrMfeDadWvarnGyBZmWBiQ5+HR49TJp6QHR3K1YLUhsjJSa9QTEE9M
   jq0BL9Vs4H0tcuk+KMWyKa0pDWCjNw0QvC8CL7cNBI+8OwBGGxlM2lmsr
   0uEMQqDuDo3fMuUBC05qDdALbrh/n5zid3kXBn4JFXxBPSONb+vCK6IyZ
   A43IEe4vCY7R1B0YBZ2qp6EqGhE5xxmhfuBTEj9MlrewvxkM59Rosj5TJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249650749"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="249650749"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 12:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="639447901"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2022 12:07:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxvN-0001mZ-Rb; Wed, 23 Feb 2022 20:07:45 +0000
Date:   Thu, 24 Feb 2022 04:07:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Volodymyr Mytnyk <vmytnyk@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vadym Kochan <vkochan@marvell.com>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>
Subject: include/linux/compiler_types.h:322:45: error: call to
 '__compiletime_assert_365' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(struct prestera_msg_event_fdb) != 20
Message-ID: <202202240334.RwxcQUfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c1ee569660d4a205dced9cb4d0306b907fb7599
commit: bb5dbf2cc64d5cfa696765944c784c0010c48ae8 net: marvell: prestera: add firmware v4.0 support
date:   4 months ago
config: arm-buildonly-randconfig-r002-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240334.RwxcQUfp-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/ethernet/marvell/prestera/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/prestera/prestera_hw.c:284:1: warning: alignment 1 of 'union prestera_msg_port_param' is less than 4 [-Wpacked-not-aligned]
     284 | } __packed;
         | ^
   In file included from <command-line>:
   In function 'prestera_hw_build_tests',
       inlined from 'prestera_hw_switch_init' at drivers/net/ethernet/marvell/prestera/prestera_hw.c:788:2:
>> include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_365' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct prestera_msg_event_fdb) != 20
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


vim +/__compiletime_assert_365 +322 include/linux/compiler_types.h

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
