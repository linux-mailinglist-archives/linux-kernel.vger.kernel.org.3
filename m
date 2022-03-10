Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A04D4F00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbiCJQZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbiCJQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:25:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F46DD31EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646929472; x=1678465472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zIROuIz4VDiLoEV0FgJ11yT8r3Ow88twf/lT5+YoMuA=;
  b=j45/DrK+kgIzSMcANKkaKL66p2Ouf0cs4+Blrixv0Sc+dIg/1n2KL4y8
   LUisTpZHCM4fvZACMC3bT0O53dBohcA2Nbmb3zok/cowxvIDe9+UFDcDL
   x8iMeL2wFd1/AAVNK+thpHciqubRNK3EU+KW4+cnTiNtkaudZGC0rpPIn
   bBMEwB1qPdUKDVsiz6Po20/h4eaTUJKp/6mUHlpexnI+0bxC4Gbv6dJs1
   nQLdK04boVFoVqdXrseKx1RokqyMtZAIn7XBSvZsV4v8GCCOeliLOYGiZ
   XWjo7s9+67zERD81Pnrsg2WJqx6IsQ+IG1PgNbRwCRlgP0SIvIohKtQKs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255028535"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255028535"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688705951"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2022 08:24:29 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSLaW-000596-BF; Thu, 10 Mar 2022 16:24:28 +0000
Date:   Fri, 11 Mar 2022 00:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Volodymyr Mytnyk <vmytnyk@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vadym Kochan <vkochan@marvell.com>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>
Subject: include/linux/compiler_types.h:322:45: error: call to
 '__compiletime_assert_358' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(struct prestera_msg_event_fdb) != 20
Message-ID: <202203110037.A6XQZBmz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1db333d9a51f3459fba1bcaa564d95befe79f0b3
commit: bb5dbf2cc64d5cfa696765944c784c0010c48ae8 net: marvell: prestera: add firmware v4.0 support
date:   4 months ago
config: arm-buildonly-randconfig-r004-20220310 (https://download.01.org/0day-ci/archive/20220311/202203110037.A6XQZBmz-lkp@intel.com/config)
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
>> include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_358' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct prestera_msg_event_fdb) != 20
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


vim +/__compiletime_assert_358 +322 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  308  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  309  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  310  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  311  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  312  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  313   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  314   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  315   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  316   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  317   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  318   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  319   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  320   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  321  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @322  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  323  

:::::: The code at line 322 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
