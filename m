Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6894EAEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiC2Nn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiC2Nnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:43:55 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C69D5B3D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648561332; x=1680097332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bvzHM8usULaiZ+dlYU28pB9Yr/14ERu2KQhlxv7TE4k=;
  b=iqkHKg6HWwlHa87LxhYvVG4FOUBgFWAEBl8xeJNFHUraUvXbDMJO7Vut
   BY4t7zWrt46eGb7lwwJyevOvsMbbFELe7kcCsF/A/lG/BwtdTiU6jkhJT
   zSmysFGmJKIs+nQZYjlxw0pXA/tZJXJzr86wdsBTet9MF5vJHDLlKqLfy
   IKf5dc0pSdv2gaxzT7X30nrLNtAtbm3GIqf8rM4LvgI6rKwuJnS8uJ5oO
   8zI4cMzczXCgVqByznSCWPihTJtjj41VAviApQYqNl6XyIJdhiiM4yjQM
   QsSNcJ9h/+0UJPugSsik4Kq1GogRGHDyq6RE+JaAnIV15OF1nOwa2v2KY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="319949718"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="319949718"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="652975214"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2022 06:42:10 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZC6r-0000GF-V0; Tue, 29 Mar 2022 13:42:09 +0000
Date:   Tue, 29 Mar 2022 21:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: lib/stackinit_kunit.c:334:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202203292149.t3xqiQ2d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: 02788ebcf521fe78c24eb221fd1ed7f86792c330 lib: stackinit: Convert to KUnit
date:   8 days ago
config: powerpc-randconfig-s032-20220327 (https://download.01.org/0day-ci/archive/20220329/202203292149.t3xqiQ2d-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02788ebcf521fe78c24eb221fd1ed7f86792c330
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 02788ebcf521fe78c24eb221fd1ed7f86792c330
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/stackinit_kunit.c:334:1: sparse: sparse: Using plain integer as NULL pointer
>> lib/stackinit_kunit.c:334:1: sparse: sparse: Using plain integer as NULL pointer
>> lib/stackinit_kunit.c:334:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:336:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:337:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:337:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:337:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:337:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:337:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:337:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:338:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:339:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:340:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:340:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:340:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:340:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:340:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:340:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:341:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:341:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:341:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:344:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:344:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:344:1: sparse: sparse: Using plain integer as NULL pointer
   lib/stackinit_kunit.c:346:1: sparse: sparse: Using plain integer as NULL pointer

vim +334 lib/stackinit_kunit.c

   303	
   304	#define DEFINE_SCALAR_TEST(name, init, xfail)			\
   305			DEFINE_TEST(name ## _ ## init, name, SCALAR,	\
   306				    init, xfail)
   307	
   308	#define DEFINE_SCALAR_TESTS(init, xfail)			\
   309			DEFINE_SCALAR_TEST(u8, init, xfail);		\
   310			DEFINE_SCALAR_TEST(u16, init, xfail);		\
   311			DEFINE_SCALAR_TEST(u32, init, xfail);		\
   312			DEFINE_SCALAR_TEST(u64, init, xfail);		\
   313			DEFINE_TEST(char_array_ ## init, unsigned char,	\
   314				    STRING, init, xfail)
   315	
   316	#define DEFINE_STRUCT_TEST(name, init, xfail)			\
   317			DEFINE_TEST(name ## _ ## init,			\
   318				    struct test_ ## name, STRUCT, init, \
   319				    xfail)
   320	
   321	#define DEFINE_STRUCT_TESTS(init, xfail)			\
   322			DEFINE_STRUCT_TEST(small_hole, init, xfail);	\
   323			DEFINE_STRUCT_TEST(big_hole, init, xfail);	\
   324			DEFINE_STRUCT_TEST(trailing_hole, init, xfail);	\
   325			DEFINE_STRUCT_TEST(packed, init, xfail)
   326	
   327	#define DEFINE_STRUCT_INITIALIZER_TESTS(base, xfail)		\
   328			DEFINE_STRUCT_TESTS(base ## _ ## partial,	\
   329					    xfail);			\
   330			DEFINE_STRUCT_TESTS(base ## _ ## all, xfail)
   331	
   332	/* These should be fully initialized all the time! */
   333	DEFINE_SCALAR_TESTS(zero, ALWAYS_PASS);
 > 334	DEFINE_STRUCT_TESTS(zero, ALWAYS_PASS);
   335	/* Struct initializers: padding may be left uninitialized. */
   336	DEFINE_STRUCT_INITIALIZER_TESTS(static, STRONG_PASS);
   337	DEFINE_STRUCT_INITIALIZER_TESTS(dynamic, STRONG_PASS);
   338	DEFINE_STRUCT_INITIALIZER_TESTS(runtime, STRONG_PASS);
   339	DEFINE_STRUCT_INITIALIZER_TESTS(assigned_static, STRONG_PASS);
   340	DEFINE_STRUCT_INITIALIZER_TESTS(assigned_dynamic, STRONG_PASS);
   341	DEFINE_STRUCT_TESTS(assigned_copy, ALWAYS_FAIL);
   342	/* No initialization without compiler instrumentation. */
   343	DEFINE_SCALAR_TESTS(none, STRONG_PASS);
   344	DEFINE_STRUCT_TESTS(none, BYREF_PASS);
   345	/* Initialization of members with __user attribute. */
   346	DEFINE_TEST(user, struct test_user, STRUCT, none, USER_PASS);
   347	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
