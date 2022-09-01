Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3005A8D67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiIAFd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiIAFdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:33:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309DA12F12B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662010430; x=1693546430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R3/3G0isbzli2LHv764XCRl+eIc0zAdChlNXzKctOuw=;
  b=f+2JzLI8wfFufgTZ1LZ6X68XKnLMdU87CbKIfPnB0iavJ4lPZ51+eFrU
   vCfCian9DypMbxkh5fr3aqpGYmOvoRrrab6qhJLeXLDY5enn3aqwJeCB5
   MrCVPfPEPY0YSKlORXvU7X4d+PqsMRhL5C8lNzp79WBnz0zQsy7PoK4MC
   EJ30uA6uIpz2qKgyH3ADrzZQkzxSzcoxnlbKV/ejk3j3WQgUpQF5AQp+p
   Vu3ExOZ3bX8zE+ZqOziIh1Y7D4H/xL13/+UOPFA8CuRSedDzT2Gzt5Q6e
   gWcHnrEPLR86slP3ULa09RqPCkD9kP21m5A7EAnPyVwF38eXr2kvnHWfM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294361015"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294361015"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 22:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="563307764"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 22:33:47 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTcpm-00019u-1P;
        Thu, 01 Sep 2022 05:33:46 +0000
Date:   Thu, 1 Sep 2022 13:32:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Volodymyr Mytnyk <vmytnyk@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vadym Kochan <vkochan@marvell.com>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>
Subject: include/linux/compiler_types.h:322:45: error: call to
 '__compiletime_assert_359' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(struct prestera_msg_event_fdb) != 20
Message-ID: <202209011301.Vy6Qk7rX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5e4d5e99162ba8025d58a3af7ad103f155d2df7
commit: bb5dbf2cc64d5cfa696765944c784c0010c48ae8 net: marvell: prestera: add firmware v4.0 support
date:   10 months ago
config: arm-randconfig-r036-20220831 (https://download.01.org/0day-ci/archive/20220901/202209011301.Vy6Qk7rX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb5dbf2cc64d5cfa696765944c784c0010c48ae8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bb5dbf2cc64d5cfa696765944c784c0010c48ae8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/ethernet/marvell/prestera/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/marvell/prestera/prestera_hw.c:4:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1349:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1349 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1335:27: note: 'mem_section' declared here
    1335 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   drivers/net/ethernet/marvell/prestera/prestera_hw.c: At top level:
   drivers/net/ethernet/marvell/prestera/prestera_hw.c:284:1: warning: alignment 1 of 'union prestera_msg_port_param' is less than 4 [-Wpacked-not-aligned]
     284 | } __packed;
         | ^
   In file included from <command-line>:
   In function 'prestera_hw_build_tests',
       inlined from 'prestera_hw_switch_init' at drivers/net/ethernet/marvell/prestera/prestera_hw.c:788:2:
>> include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_359' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct prestera_msg_event_fdb) != 20
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


vim +/__compiletime_assert_359 +322 include/linux/compiler_types.h

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
