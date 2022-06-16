Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0F54EDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379276AbiFPW6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379259AbiFPW6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:58:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692B62A05
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655420300; x=1686956300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BWxsxWawtf6Hs4uicUqdzcEgaSLbxNpf6q1slaH91EY=;
  b=Fn/3ysQ+MFOjvkVLN/lW4KyDuM1dkuhCsT6+LTif3VltKc6tryvW2WyC
   2JKURcKZtZ7hvnIabkhpM9XTMwLbnHPCQg6A2pC4G14HsInesZs5X9fdl
   AwXB4Iy2Nnc4NAVEA3sORHecv38gjG5v3XCvK8KLy99ImIcW5Y0HDpmh4
   LFP4COX72Y3oqQdQ0HHS23yDyrset/Uz8vLChu68QGmMYTts5mXWjj2ld
   fGR+8rQugk9iD4czMFlWrA39aG6Yib3ec18QxznqqPvKdeE2Ui6sMeOjf
   HHsjdapyrqu1dR35U5IVbtVBA4BWI9I5vsWRBr7eFikSdbUPUUVMOzbGY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304819564"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="304819564"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="763034903"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 15:58:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1yRN-000Oqn-O4;
        Thu, 16 Jun 2022 22:58:17 +0000
Date:   Fri, 17 Jun 2022 06:57:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 66/146] include/linux/resctrl.h:286:20:
 warning: shift count >= width of type
Message-ID: <202206170631.gKMr1Rch-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: 2881ac404cd937d1529d641acc4055fb14822de0 [66/146] fs/resctrl: Export the closid/rmid to user-space
config: hexagon-randconfig-r041-20220616 (https://download.01.org/0day-ci/archive/20220617/202206170631.gKMr1Rch-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=2881ac404cd937d1529d641acc4055fb14822de0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout 2881ac404cd937d1529d641acc4055fb14822de0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   include/linux/bitfield.h:129:30: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                              ^~~~~
   In file included from fs/proc/base.c:97:
>> include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:129:30: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                              ^~~~~
   In file included from fs/proc/base.c:97:
   include/linux/resctrl.h:286:20: warning: shift count >= width of type [-Wshift-count-overflow]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^
   include/linux/bitfield.h:129:50: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                                         ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   In file included from fs/proc/base.c:97:
   include/linux/resctrl.h:286:20: warning: shift count is negative [-Wshift-count-negative]
           *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
                   ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/resctrl.h:40:26: note: expanded from macro 'RESCTRL_ID_RMID'
   #define RESCTRL_ID_RMID         GENMASK(63, 32)
                                   ^
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:129:50: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                                         ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   22 warnings generated.


vim +286 include/linux/resctrl.h

   269	
   270	/**
   271	 * __resctrl_id_decode() - unpack a known-good id that has been checked by
   272	 *                         resctrl_id_decode().
   273	 * @id:		The value originally passed by user-space.
   274	 * @closid:	Returned closid.
   275	 * @rmid:	Returned rmid.
   276	 *
   277	 * Decodes the id field with no error checking. resctrl_id_decode() must have
   278	 * been used to check the id produces values that are in range and are
   279	 * allocated at the time of first use.
   280	 */
   281	static inline void __resctrl_id_decode(u64 id, u32 *closid, u32 *rmid)
   282	{
   283		id ^= resctrl_id_obsfucation;
   284	
   285		*closid = FIELD_GET(RESCTRL_ID_CLOSID, id);
 > 286		*rmid = FIELD_GET(RESCTRL_ID_RMID, id);
   287	}
   288	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
