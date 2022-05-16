Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22D527C28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiEPCvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiEPCvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:51:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107467669
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652669499; x=1684205499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VTStXm2hruIzjOsm2ehlfzGSDK9or5rC7CyVRmP9dTo=;
  b=gixlp9yo++uAHB8GPL994O+rYPFB9ajBtoOlkJP13cuFtWY+AEYS46xI
   gRM8NzxWfkAUBpQtbxYblMWQIpM4DleOcuxDktxdZ3pN5/+M4b9I7nnEZ
   06pLCJbzrq6H3etWHKu2Arw8FMJa82ZLtIVsz2/ZaLxcgefTR4nnMIkjL
   37o3krMDdpLNYSmiEGmjGTr3LQqN1tj9gATX66/B7AsVKJZ0+lKkINQN+
   gfKyZnU/r3NXXXnZB9kZrPPRMdtzo2Qeeg2B2taE+ARbFjuzB3ZvuHTE6
   Zr117BFBieiLqoRXmAiWZ7KOa8W+zg5tcY0xjtJdv9cXUqTih4vA7bkXW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="295972973"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="295972973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="625726298"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2022 19:51:37 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqQpc-00026z-L2;
        Mon, 16 May 2022 02:51:36 +0000
Date:   Mon, 16 May 2022 10:50:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_352' declared with attribute error: Please avoid
 flushing system_highpri_wq.
Message-ID: <202205161020.AQoBsxLz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220516-093322/Tetsuo-Handa/checkpatch-warn-about-flushing-system-wide-workqueues/20220425-073327
head:   cd007363b7985a824de0ec5e05f0cb0705e59c88
commit: cd007363b7985a824de0ec5e05f0cb0705e59c88 workqueue: Wrap flush_workqueue() using a macro
date:   75 minutes ago
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220516/202205161020.AQoBsxLz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cd007363b7985a824de0ec5e05f0cb0705e59c88
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220516-093322/Tetsuo-Handa/checkpatch-warn-about-flushing-system-wide-workqueues/20220425-073327
        git checkout cd007363b7985a824de0ec5e05f0cb0705e59c88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/block/rnbd/ drivers/staging/wfx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/staging/wfx/bh.c: In function 'wfx_bh_poll_irq':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_352' declared with attribute error: Please avoid flushing system_highpri_wq.
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:676:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     676 |         BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_highpri_wq) && \
         |         ^~~~~~~~~~~~~~~~
   drivers/staging/wfx/bh.c:298:9: note: in expansion of macro 'flush_workqueue'
     298 |         flush_workqueue(system_highpri_wq);
         |         ^~~~~~~~~~~~~~~
--
   In file included from <command-line>:
   In function 'rnbd_destroy_sessions',
       inlined from 'rnbd_client_exit' at drivers/block/rnbd/rnbd-clt.c:1801:2:
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_319' declared with attribute error: Please avoid flushing system_long_wq.
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/workqueue.h:679:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     679 |         BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_long_wq) && \
         |         ^~~~~~~~~~~~~~~~
   drivers/block/rnbd/rnbd-clt.c:1769:9: note: in expansion of macro 'flush_workqueue'
    1769 |         flush_workqueue(system_long_wq);
         |         ^~~~~~~~~~~~~~~


vim +/__compiletime_assert_352 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
