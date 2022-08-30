Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A25A613C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiH3Kz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiH3KzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:55:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1365556
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661856918; x=1693392918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fHChqWiJZU6kMIxVVG7wGPZwoTpXakEO2Ay1MLbH2+0=;
  b=kfFNpuRtlVXtWFCiZMsllSZxPaqTK2yHk+J27k5SLe057BcOAbwLRSoo
   /+1hXj+1R+9wLTJW8G1OvlGF1dqlf4HMMjWzNKZm+72lq02HhRrdxebx2
   a+vrmE45s88BOLzIX4IK1RW1Dsajz15NC178wta9QI7Iy+HOOi/LCaVda
   fur2aiffCJfkeO8Toso7MBiPCglpJ+4XhYKUuthW9gnfxoiRj6vQuA32V
   3BrQM9C1vNNm8089wMHbbqPne5GxIoKkYl/sv9UgY6N/S/b3/J7f03gk+
   HK0y1kNY1h1t0VsD8KrswTLmP46BZU2KFYkTXsmMq8If07zcoaAQW52rJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295925060"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="295925060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="562601260"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 03:55:16 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSytn-0000D9-1T;
        Tue, 30 Aug 2022 10:55:15 +0000
Date:   Tue, 30 Aug 2022 18:54:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Subject: lib/overflow_kunit.c:451:1: warning: the frame size of 12656 bytes
 is larger than 2048 bytes
Message-ID: <202208301850.iuv9VwA8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: 617f55e20743fc50c989b498f9dee289eb644cfd lib: overflow: Convert to Kunit
date:   6 months ago
config: i386-buildonly-randconfig-r002-20220829 (https://download.01.org/0day-ci/archive/20220830/202208301850.iuv9VwA8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=617f55e20743fc50c989b498f9dee289eb644cfd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 617f55e20743fc50c989b498f9dee289eb644cfd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/overflow_kunit.c:191:19: warning: 's64_tests' defined but not used [-Wunused-const-variable=]
     191 | DEFINE_TEST_ARRAY(s64) = {
         |                   ^~~
   lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
      24 |         } t ## _tests[]
         |           ^
   lib/overflow_kunit.c:94:19: warning: 'u64_tests' defined but not used [-Wunused-const-variable=]
      94 | DEFINE_TEST_ARRAY(u64) = {
         |                   ^~~
   lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
      24 |         } t ## _tests[]
         |           ^
   lib/overflow_kunit.c: In function 'overflow_shift_test':
>> lib/overflow_kunit.c:451:1: warning: the frame size of 12656 bytes is larger than 2048 bytes [-Wframe-larger-than=]
     451 | }
         | ^
   lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
   lib/overflow_kunit.c:644:1: warning: the frame size of 2468 bytes is larger than 2048 bytes [-Wframe-larger-than=]
     644 | }
         | ^


vim +451 lib/overflow_kunit.c

d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  289  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  290  	/* Sane shifts. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  291  	TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  292  	TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  293  	TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  294  	TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  295  	TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  296  	TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  297  	TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  298  	TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  299  	TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  300  	TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  301  	TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  302  	TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  303  	TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  304  	TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  305  	TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  306  	TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  307  	TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  308  	TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  309  	TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  310  	TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  311  	TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  312  	TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  313  	TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  314  	TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  315  	TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  316  	TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64, 0xFFFFFFFFULL << 32, false);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  317  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  318  	/* Sane shift: start and end with 0, without a too-wide shift. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  319  	TEST_ONE_SHIFT(0, 7, u8, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  320  	TEST_ONE_SHIFT(0, 15, u16, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  321  	TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  322  	TEST_ONE_SHIFT(0, 31, u32, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  323  	TEST_ONE_SHIFT(0, 63, u64, 0, false);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  324  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  325  	/* Sane shift: start and end with 0, without reaching signed bit. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  326  	TEST_ONE_SHIFT(0, 6, s8, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  327  	TEST_ONE_SHIFT(0, 14, s16, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  328  	TEST_ONE_SHIFT(0, 30, int, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  329  	TEST_ONE_SHIFT(0, 30, s32, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  330  	TEST_ONE_SHIFT(0, 62, s64, 0, false);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  331  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  332  	/* Overflow: shifted the bit off the end. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  333  	TEST_ONE_SHIFT(1, 8, u8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  334  	TEST_ONE_SHIFT(1, 16, u16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  335  	TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  336  	TEST_ONE_SHIFT(1, 32, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  337  	TEST_ONE_SHIFT(1, 64, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  338  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  339  	/* Overflow: shifted into the signed bit. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  340  	TEST_ONE_SHIFT(1, 7, s8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  341  	TEST_ONE_SHIFT(1, 15, s16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  342  	TEST_ONE_SHIFT(1, 31, int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  343  	TEST_ONE_SHIFT(1, 31, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  344  	TEST_ONE_SHIFT(1, 63, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  345  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  346  	/* Overflow: high bit falls off unsigned types. */
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  347  	/* 10010110 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  348  	TEST_ONE_SHIFT(150, 1, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  349  	/* 1000100010010110 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  350  	TEST_ONE_SHIFT(34966, 1, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  351  	/* 10000100000010001000100010010110 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  352  	TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  353  	TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  354  	/* 1000001000010000010000000100000010000100000010001000100010010110 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  355  	TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  356  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  357  	/* Overflow: bit shifted into signed bit on signed types. */
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  358  	/* 01001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  359  	TEST_ONE_SHIFT(75, 1, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  360  	/* 0100010001001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  361  	TEST_ONE_SHIFT(17483, 1, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  362  	/* 01000010000001000100010001001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  363  	TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  364  	TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  365  	/* 0100000100001000001000000010000001000010000001000100010001001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  366  	TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  367  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  368  	/* Overflow: bit shifted past signed bit on signed types. */
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  369  	/* 01001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  370  	TEST_ONE_SHIFT(75, 2, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  371  	/* 0100010001001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  372  	TEST_ONE_SHIFT(17483, 2, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  373  	/* 01000010000001000100010001001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  374  	TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  375  	TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  376  	/* 0100000100001000001000000010000001000010000001000100010001001011 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  377  	TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  378  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  379  	/* Overflow: values larger than destination type. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  380  	TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  381  	TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  382  	TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  383  	TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  384  	TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  385  	TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  386  	TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  387  	TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  388  	TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  389  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  390  	/* Nonsense: negative initial value. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  391  	TEST_ONE_SHIFT(-1, 0, s8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  392  	TEST_ONE_SHIFT(-1, 0, u8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  393  	TEST_ONE_SHIFT(-5, 0, s16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  394  	TEST_ONE_SHIFT(-5, 0, u16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  395  	TEST_ONE_SHIFT(-10, 0, int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  396  	TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  397  	TEST_ONE_SHIFT(-100, 0, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  398  	TEST_ONE_SHIFT(-100, 0, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  399  	TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  400  	TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  401  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  402  	/* Nonsense: negative shift values. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  403  	TEST_ONE_SHIFT(0, -5, s8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  404  	TEST_ONE_SHIFT(0, -5, u8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  405  	TEST_ONE_SHIFT(0, -10, s16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  406  	TEST_ONE_SHIFT(0, -10, u16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  407  	TEST_ONE_SHIFT(0, -15, int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  408  	TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  409  	TEST_ONE_SHIFT(0, -20, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  410  	TEST_ONE_SHIFT(0, -20, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  411  	TEST_ONE_SHIFT(0, -30, s64, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  412  	TEST_ONE_SHIFT(0, -30, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  413  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  414  	/* Overflow: shifted at or beyond entire type's bit width. */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  415  	TEST_ONE_SHIFT(0, 8, u8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  416  	TEST_ONE_SHIFT(0, 9, u8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  417  	TEST_ONE_SHIFT(0, 8, s8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  418  	TEST_ONE_SHIFT(0, 9, s8, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  419  	TEST_ONE_SHIFT(0, 16, u16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  420  	TEST_ONE_SHIFT(0, 17, u16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  421  	TEST_ONE_SHIFT(0, 16, s16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  422  	TEST_ONE_SHIFT(0, 17, s16, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  423  	TEST_ONE_SHIFT(0, 32, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  424  	TEST_ONE_SHIFT(0, 33, u32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  425  	TEST_ONE_SHIFT(0, 32, int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  426  	TEST_ONE_SHIFT(0, 33, int, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  427  	TEST_ONE_SHIFT(0, 32, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  428  	TEST_ONE_SHIFT(0, 33, s32, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  429  	TEST_ONE_SHIFT(0, 64, u64, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  430  	TEST_ONE_SHIFT(0, 65, u64, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  431  	TEST_ONE_SHIFT(0, 64, s64, 0, true);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  432  	TEST_ONE_SHIFT(0, 65, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  433  
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  434  	/*
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  435  	 * Corner case: for unsigned types, we fail when we've shifted
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  436  	 * through the entire width of bits. For signed types, we might
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  437  	 * want to match this behavior, but that would mean noticing if
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  438  	 * we shift through all but the signed bit, and this is not
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  439  	 * currently detected (but we'll notice an overflow into the
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  440  	 * signed bit). So, for now, we will test this condition but
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  441  	 * mark it as not expected to overflow.
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  442  	 */
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  443  	TEST_ONE_SHIFT(0, 7, s8, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  444  	TEST_ONE_SHIFT(0, 15, s16, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  445  	TEST_ONE_SHIFT(0, 31, int, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  446  	TEST_ONE_SHIFT(0, 31, s32, 0, false);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  447  	TEST_ONE_SHIFT(0, 63, s64, 0, false);
8e7c8ca6b98890 lib/test_overflow.c  Kees Cook 2021-09-20  448  
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  449  	kunit_info(test, "%d shift tests finished\n", count);
8e7c8ca6b98890 lib/test_overflow.c  Kees Cook 2021-09-20  450  #undef TEST_ONE_SHIFT
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01 @451  }
d36b6ad27c7b95 lib/test_overflow.c  Kees Cook 2018-08-01  452  

:::::: The code at line 451 was first introduced by commit
:::::: d36b6ad27c7b95e3f6bfbf6ea33757c8e8accf01 test_overflow: Add shift overflow tests

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
