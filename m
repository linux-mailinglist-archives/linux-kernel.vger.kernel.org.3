Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A155786E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiFWLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiFWLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:08:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB15488BA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655982520; x=1687518520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDBs8M+jgTWYdg5RVXayfMMhFZCDPzjM8skP7sHVPHw=;
  b=RQwZzjyGRvx2F8SPzH94VMUyCY5wCAHYWpKiJgVZVfEhf5sPYUQ7lhFL
   pXdnhefrAgS/9fzM48XEr5ZABmk+FNikB7tCWbVVObXBjK4wjLvDGdAP1
   cWYBy7md7Xgk7w97OhXiF2zLKdfpMAlBW0yfpxL1wdu9c7INtK5V1nsev
   w6zDLo+wZlAfEbIfnyvzkep70ZkJGlw7gIAvEiI7XeLfn/3JStLQpyjiL
   IGLfEcyYmrdcVFnpCjJkioYBlJfUkVVIp/PBnwbsxbH6S4lpzHx9NRhtX
   XBnPqE9ZSuzl3XZzzmVJOWhxH32vhPS1JBb6X3UrgdKsYfmg/81A5LxgH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261120728"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="261120728"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 04:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834591545"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 04:08:38 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25NB8bjR023549;
        Thu, 23 Jun 2022 12:08:37 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [norov:fns 7/19] include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_600' declared with attribute error: BUILD_BUG_ON failed: !__builtin_constant_p(res)
Date:   Thu, 23 Jun 2022 13:08:20 +0200
Message-Id: <20220623110820.1017185-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <202206230121.wlBiPZcR-lkp@intel.com>
References: <202206230121.wlBiPZcR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kernel test robot <lkp@intel.com>
Date: Thu, 23 Jun 2022 01:16:29 +0800

Hi Yury,

> tree:   https://github.com/norov/linux fns
> head:   dc85542660535a9072c3b98819f4b80ff182b92a
> commit: 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f [7/19] lib: test_bitmap: add compile-time optimization/evaluations assertions
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230121.wlBiPZcR-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/norov/linux/commit/2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
>         git remote add norov https://github.com/norov/linux
>         git fetch --no-tags norov fns
>         git checkout 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

Can't reproduce it at all on x86_64 with the attached config, were
there any other changes maybe that could cause this?

> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    lib/test_bitmap.c: In function 'test_bitmap_const_eval':
> >> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_600' declared with attribute error: BUILD_BUG_ON failed: !__builtin_constant_p(res)
>      352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
>      333 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
>      352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    lib/test_bitmap.c:904:9: note: in expansion of macro 'BUILD_BUG_ON'
>      904 |         BUILD_BUG_ON(!__builtin_constant_p(res));
>          |         ^~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_600 +352 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  338  
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  341  
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  342  /**
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  346   *
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  349   * compiler has support to do so.
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  350   */
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2d Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2d Will Deacon 2020-07-21  353  
> 
> :::::: The code at line 352 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Thanks,
Olek
