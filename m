Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E655AE20
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiFZCFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiFZCFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:05:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F211713E80
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656209146; x=1687745146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oGGo4RNGctnJDhv0L8ayLvzfxgVY8w/oAR4I/OrbY48=;
  b=WLxDYC1r278xkcsTh5ED2/6vBLhqltdd+GA+E1XeRT0WzAOR2T4Fn574
   o0SYmze22uhXjPl2k38GJ9ZwuPmig9Alelacl90cX0ab9I6sCjke5XW5S
   YrLQkEEtpGkvlUy5UUj/gncNJicKGBvLemshSw7ngOkLbdrW8gsrf20Qo
   pDPvWtmFhhyjjpVZ8l7c0iFYBi+U6i5zOISaASuCJ2x7++vCE/WibT08P
   nvTEwBwIa+Gha+7WKeUBhxM/1g1u3Epiwg+VQG+KBEhdWhUf1oo3e/1xq
   QKp7mjBELluJX5pgQsH+Jy1r1Dh0xp42gOGrsGIPOWOmcC71Q2D0j66pc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="264282550"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="264282550"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 19:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="679062730"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2022 19:05:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5Heh-0006bh-N3;
        Sun, 26 Jun 2022 02:05:43 +0000
Date:   Sun, 26 Jun 2022 10:04:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:fns 24/24] lib/test_bitmap.c:226:37: error: 'EXP1_IN_BITS'
 undeclared
Message-ID: <202206260916.2HQZFpcE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux fns
head:   c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
commit: c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7 [24/24] fixes
config: ia64-randconfig-r011-20220626
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bitmap.h:9,
                    from lib/test_bitmap.c:8:
   lib/test_bitmap.c: In function 'test_find_nth_bit':
>> lib/test_bitmap.c:226:37: error: 'EXP1_IN_BITS' undeclared (first use in this function)
     226 |         for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
         |                                     ^~~~~~~~~~~~
   include/linux/find.h:345:45: note: in definition of macro 'for_each_set_bit'
     345 |         for ((bit) = find_next_bit((addr), (size), 0);          \
         |                                             ^~~~
   lib/test_bitmap.c:226:37: note: each undeclared identifier is reported only once for each function it appears in
     226 |         for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
         |                                     ^~~~~~~~~~~~
   include/linux/find.h:345:45: note: in definition of macro 'for_each_set_bit'
     345 |         for ((bit) = find_next_bit((addr), (size), 0);          \
         |                                             ^~~~
   lib/test_bitmap.c: In function 'test_find_next_bit_wrap':
   lib/test_bitmap.c:234:53: error: 'EXP1_IN_BITS' undeclared (first use in this function)
     234 |         const unsigned long w = bitmap_weight(exp1, EXP1_IN_BITS);
         |                                                     ^~~~~~~~~~~~
   At top level:
   lib/test_bitmap.c:232:20: warning: 'test_find_next_bit_wrap' defined but not used [-Wunused-function]
     232 | static void __init test_find_next_bit_wrap(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +/EXP1_IN_BITS +226 lib/test_bitmap.c

   221	
   222	static void __init test_find_nth_bit(void)
   223	{
   224		unsigned long b, bit, cnt = 0;
   225	
 > 226		for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
   227			b = find_nth_bit(exp1, EXP1_IN_BITS, ++cnt);
   228			expect_eq_uint(b, bit);
   229		}
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
