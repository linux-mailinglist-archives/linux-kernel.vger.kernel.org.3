Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A5516ADF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383364AbiEBGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351045AbiEBGew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:34:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F66367
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651473084; x=1683009084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FEOmMqLtE0UdioK63JNCa+6iTD3V4OZduVfNZUkUvb4=;
  b=YS6Uq+8bOm+ZLMMKVSWwOWKIpZRNMFSynfhogLDfwDtdTtHfb541fqUK
   TLWfKKk7drVuH0KeJdxat8E9ltSg62/W4aY4a3UWu/FMi88u46GBc1y01
   +rivHyY3uYQit4sUcwsHfNuqMeZyTDKjz52Jm7MUXwMWCKjJhSu/YUmp7
   lqo1g9OBV0t48YIt2P9fbsvaFnCavrcvtLOUbB926JjE18Y8P1+2z7Idf
   MMLCB2SQ2+BHDgG8M4bInsWAFFpTi5T8x3b221q+MPVO+rPcdlufBaAAU
   PkFD5CNNRBomeJ81PlDwffCMfbOAg8jtP+9Si3nNk43MwH2ydcN22KulQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="327674314"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="327674314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 23:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515939630"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2022 23:31:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlPac-0009LP-0r;
        Mon, 02 May 2022 06:31:22 +0000
Date:   Mon, 2 May 2022 14:31:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tomoyo-test1:master 2/2] include/linux/compiler_types.h:352:45:
 error: call to '__compiletime_assert_302' declared with attribute error:
 Please avoid flushing system_long_wq.
Message-ID: <202205021411.imkBoPfj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git master
head:   c806998d6e2cfdbcf8f4b241b709552b7d85fa3e
commit: c806998d6e2cfdbcf8f4b241b709552b7d85fa3e [2/2] workqueue: Wrap flush_workqueue() using a macro
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220502/202205021411.imkBoPfj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        git remote add tomoyo-test1 https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git
        git fetch --no-tags tomoyo-test1 master
        git checkout c806998d6e2cfdbcf8f4b241b709552b7d85fa3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'rnbd_destroy_sessions',
       inlined from 'rnbd_client_exit' at drivers/block/rnbd/rnbd-clt.c:1801:2:
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_302' declared with attribute error: Please avoid flushing system_long_wq.
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
   include/linux/workqueue.h:666:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     666 |         BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_long_wq) && \
         |         ^~~~~~~~~~~~~~~~
   drivers/block/rnbd/rnbd-clt.c:1769:9: note: in expansion of macro 'flush_workqueue'
    1769 |         flush_workqueue(system_long_wq);
         |         ^~~~~~~~~~~~~~~
--
   In file included from <command-line>:
   drivers/infiniband/core/device.c: In function 'ib_core_cleanup':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_514' declared with attribute error: Please avoid flushing system_unbound_wq.
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
   include/linux/workqueue.h:669:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     669 |         BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_unbound_wq) && \
         |         ^~~~~~~~~~~~~~~~
   drivers/infiniband/core/device.c:2857:9: note: in expansion of macro 'flush_workqueue'
    2857 |         flush_workqueue(system_unbound_wq);
         |         ^~~~~~~~~~~~~~~


vim +/__compiletime_assert_302 +352 include/linux/compiler_types.h

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

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
