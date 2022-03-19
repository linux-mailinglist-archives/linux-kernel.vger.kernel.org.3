Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30D64DEA46
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbiCSTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbiCSTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:04:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DEFFD0D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647716612; x=1679252612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DxqlguLXXHa1mw3YAZpLW2y72uiwjjmn2D+xpujqOIQ=;
  b=gVlx2YjB484oRwsXDkw/eAxBxEdQWIPx0JFzZrfU9+d+FpX2dorwpElu
   14gU8JoSfBeQ7XTGfmNqGeKIrn5S021EGqnyoCbXQmmzrks3/8EnnPvvx
   RI84gop9O9wLzSevQ/0ailr3EsIJPfDH+FW8VPtuTfVVbdn4jGfMJyI56
   AIRIx3viWZUXpYdvmYrP99OyhR2pPR2urV0eJHdOLRjHCxDxNh9PAMPx7
   OrYxCFMHp/sfxDu7RpWxR9SIbsnommloA281N6kOM7RMAzcuUZlV2/xUQ
   5qGr/AHCQeJOWNxvN3+DCyHRgRKPhVCG3VM/V3uWsCTrqO+KQcCTzUNXo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="239479628"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="239479628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="514439417"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2022 12:03:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVeMK-000GDv-7n; Sat, 19 Mar 2022 19:03:28 +0000
Date:   Sun, 20 Mar 2022 03:03:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme-rfc 5/12] include/linux/compiler_types.h:346:45:
 error: call to '__compiletime_assert_224' declared with attribute error:
 FIELD_PREP: mask is zero
Message-ID: <202203200250.vLHx5IYH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-rfc
head:   668a74289aa4cdde7d55e4f602043ece670ea71c
commit: 5f102aac51098ef778ed49811de43091e05ca895 [5/12] soc: apple: rtkit: Add RTKit IPC library
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220320/202203200250.vLHx5IYH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/5f102aac51098ef778ed49811de43091e05ca895
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-rfc
        git checkout 5f102aac51098ef778ed49811de43091e05ca895
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      71 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:56: note: in expansion of macro '__bf_shf'
      72 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:581:15: note: in expansion of macro 'FIELD_PREP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |               ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:52:39: note: in expansion of macro 'GENMASK'
      52 | #define APPLE_RTKIT_MGMT_STARTEP_EP   GENMASK(39, 32)
         |                                       ^~~~~~~
   drivers/soc/apple/rtkit.c:581:26: note: in expansion of macro 'APPLE_RTKIT_MGMT_STARTEP_EP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/soc/apple/rtkit-internal.h:5,
                    from drivers/soc/apple/rtkit.c:9:
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:42:38: note: in definition of macro '__bf_shf'
      42 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/soc/apple/rtkit.c:581:15: note: in expansion of macro 'FIELD_PREP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |               ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:52:39: note: in expansion of macro 'GENMASK'
      52 | #define APPLE_RTKIT_MGMT_STARTEP_EP   GENMASK(39, 32)
         |                                       ^~~~~~~
   drivers/soc/apple/rtkit.c:581:26: note: in expansion of macro 'APPLE_RTKIT_MGMT_STARTEP_EP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:42:38: note: in definition of macro '__bf_shf'
      42 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/soc/apple/rtkit.c:581:15: note: in expansion of macro 'FIELD_PREP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |               ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:52:39: note: in expansion of macro 'GENMASK'
      52 | #define APPLE_RTKIT_MGMT_STARTEP_EP   GENMASK(39, 32)
         |                                       ^~~~~~~
   drivers/soc/apple/rtkit.c:581:26: note: in expansion of macro 'APPLE_RTKIT_MGMT_STARTEP_EP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:112:63: note: in definition of macro 'FIELD_PREP'
     112 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:52:39: note: in expansion of macro 'GENMASK'
      52 | #define APPLE_RTKIT_MGMT_STARTEP_EP   GENMASK(39, 32)
         |                                       ^~~~~~~
   drivers/soc/apple/rtkit.c:581:26: note: in expansion of macro 'APPLE_RTKIT_MGMT_STARTEP_EP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:112:63: note: in definition of macro 'FIELD_PREP'
     112 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:52:39: note: in expansion of macro 'GENMASK'
      52 | #define APPLE_RTKIT_MGMT_STARTEP_EP   GENMASK(39, 32)
         |                                       ^~~~~~~
   drivers/soc/apple/rtkit.c:581:26: note: in expansion of macro 'APPLE_RTKIT_MGMT_STARTEP_EP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   In function 'apple_rtkit_management_send',
       inlined from 'apple_rtkit_set_ap_power_state' at drivers/soc/apple/rtkit.c:686:2,
       inlined from 'apple_rtkit_hibernate' at drivers/soc/apple/rtkit.c:766:8:
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_224' declared with attribute error: FIELD_PREP: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:100:16: note: in expansion of macro 'FIELD_PREP'
     100 |         msg |= FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, type);
         |                ^~~~~~~~~~
   drivers/soc/apple/rtkit.c: In function 'apple_rtkit_shutdown':
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_224' declared with attribute error: FIELD_PREP: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:100:16: note: in expansion of macro 'FIELD_PREP'
     100 |         msg |= FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, type);
         |                ^~~~~~~~~~
   In function 'apple_rtkit_management_rx',
       inlined from 'apple_rtkit_rx' at drivers/soc/apple/rtkit.c:459:3,
       inlined from 'apple_rtkit_worker' at drivers/soc/apple/rtkit.c:526:5:
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_282' declared with attribute error: FIELD_GET: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:214:19: note: in expansion of macro 'FIELD_GET'
     214 |         u8 type = FIELD_GET(APPLE_RTKIT_MGMT_TYPE, msg);
         |                   ^~~~~~~~~
   In function 'apple_rtkit_crashlog_rx',
       inlined from 'apple_rtkit_rx' at drivers/soc/apple/rtkit.c:462:3,
       inlined from 'apple_rtkit_worker' at drivers/soc/apple/rtkit.c:526:5:
   include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_313' declared with attribute error: FIELD_GET: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:306:19: note: in expansion of macro 'FIELD_GET'
     306 |         u8 type = FIELD_GET(APPLE_RTKIT_SYSLOG_TYPE, msg);
         |                   ^~~~~~~~~
   In function 'apple_rtkit_syslog_rx',
       inlined from 'apple_rtkit_rx' at drivers/soc/apple/rtkit.c:465:3,
       inlined from 'apple_rtkit_worker' at drivers/soc/apple/rtkit.c:526:5:
   include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_334' declared with attribute error: FIELD_GET: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:409:19: note: in expansion of macro 'FIELD_GET'
     409 |         u8 type = FIELD_GET(APPLE_RTKIT_SYSLOG_TYPE, msg);
         |                   ^~~~~~~~~
   In function 'apple_rtkit_ioreport_rx',
       inlined from 'apple_rtkit_rx' at drivers/soc/apple/rtkit.c:468:3,
       inlined from 'apple_rtkit_worker' at drivers/soc/apple/rtkit.c:526:5:
   include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_318' declared with attribute error: FIELD_GET: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:344:19: note: in expansion of macro 'FIELD_GET'
     344 |         u8 type = FIELD_GET(APPLE_RTKIT_SYSLOG_TYPE, msg);
         |                   ^~~~~~~~~
   In function 'apple_rtkit_oslog_rx',
       inlined from 'apple_rtkit_rx' at drivers/soc/apple/rtkit.c:471:3,
       inlined from 'apple_rtkit_worker' at drivers/soc/apple/rtkit.c:526:5:
   include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_345' declared with attribute error: FIELD_GET: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:439:19: note: in expansion of macro 'FIELD_GET'
     439 |         u8 type = FIELD_GET(APPLE_RTKIT_OSLOG_TYPE, msg);
         |                   ^~~~~~~~~
   In function 'apple_rtkit_management_send',
       inlined from 'apple_rtkit_wake' at drivers/soc/apple/rtkit.c:801:2:
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_224' declared with attribute error: FIELD_PREP: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:100:16: note: in expansion of macro 'FIELD_PREP'
     100 |         msg |= FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, type);
         |                ^~~~~~~~~~
   drivers/soc/apple/rtkit.c: In function 'apple_rtkit_start_ep':
   include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_350' declared with attribute error: FIELD_PREP: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:581:15: note: in expansion of macro 'FIELD_PREP'
     581 |         msg = FIELD_PREP(APPLE_RTKIT_MGMT_STARTEP_EP, endpoint);
         |               ^~~~~~~~~~
   In function 'apple_rtkit_management_send',
       inlined from 'apple_rtkit_set_ap_power_state' at drivers/soc/apple/rtkit.c:686:2,
       inlined from 'apple_rtkit_boot' at drivers/soc/apple/rtkit.c:740:9:
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_224' declared with attribute error: FIELD_PREP: mask is zero
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:64:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      64 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:100:16: note: in expansion of macro 'FIELD_PREP'
     100 |         msg |= FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, type);
         |                ^~~~~~~~~~


vim +/__compiletime_assert_224 +346 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  332  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  335  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  337   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  338   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @346  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  

:::::: The code at line 346 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
