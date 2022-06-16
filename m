Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3354EDB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379284AbiFPW6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbiFPW6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:58:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651F62A05
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655420308; x=1686956308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aL2bGAoy8rBsX2XRSTJs9E3sEQ8FRbGQJzlqyxP0boE=;
  b=MRWDEb3XH/286uo5lj8NwRZ8GV7S7a3ruFx6vcQqKU87RFzmmaHoLGOJ
   0R2ct+LRy7LklDI6Hrz1Jz6LOLAUO51SF2ZhL8ZU250Dk9uUbWFQvlU5l
   eFFH6iXR/wFUSXunwQPTwGYAAdQV9jO5OhIvSmbvIfPcC7CMSFfFxnLbO
   ++LxUvrAda9ihiPBk8M53WaK2ylqRjpwfW1bohGHNH036UmsiDLiT+RnL
   YfcFyWpLEwlASS0oB/6LmQPYTOqrxhZfn9BwwJFrOGeA3igqXO/qDnFh1
   6sw3rk3BSAZNKBy+FpWY+n8TOmy5A40S5WW5vHHJUOJrV03RV/fkL38y/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341025753"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341025753"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="576074137"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2022 15:58:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1yRN-000Oqk-NP;
        Thu, 16 Jun 2022 22:58:17 +0000
Date:   Fri, 17 Jun 2022 06:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 66/146] include/linux/bits.h:35:29:
 warning: left shift count >= width of type
Message-ID: <202206170626.0T1niDps-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: 2881ac404cd937d1529d641acc4055fb14822de0 [66/146] fs/resctrl: Export the closid/rmid to user-space
config: arc-randconfig-r043-20220616 (https://download.01.org/0day-ci/archive/20220617/202206170626.0T1niDps-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=2881ac404cd937d1529d641acc4055fb14822de0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout 2881ac404cd937d1529d641acc4055fb14822de0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from <command-line>:
   include/linux/resctrl.h: In function '__resctrl_id_decode':
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
      69 |                                  ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
      69 |                                  ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:34: note: in expansion of macro '__bf_cast_unsigned'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:34: note: in expansion of macro '__bf_cast_unsigned'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:128:17: note: in expansion of macro '__BF_FIELD_CHECK'
     128 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
   In file included from include/linux/resctrl.h:5,
                    from fs/proc/base.c:97:
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:129:44: note: in definition of macro 'FIELD_GET'
     129 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:129:44: note: in definition of macro 'FIELD_GET'
     129 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   include/linux/resctrl.h:286:17: note: in expansion of macro 'FIELD_GET'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                 ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   include/linux/resctrl.h:40:33: note: in expansion of macro 'GENMASK'
      40 | #define RESCTRL_ID_RMID         GENMASK(63, 32)
         |                                 ^~~~~~~
   include/linux/resctrl.h:286:27: note: in expansion of macro 'RESCTRL_ID_RMID'
     286 |         *rmid = FIELD_GET(RESCTRL_ID_RMID, id);
         |                           ^~~~~~~~~~~~~~~


vim +35 include/linux/bits.h

295bcca84916cb Rikard Falkeborn 2020-04-06  33  
295bcca84916cb Rikard Falkeborn 2020-04-06  34  #define __GENMASK(h, l) \
95b980d62d52c4 Masahiro Yamada  2019-07-16 @35  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
95b980d62d52c4 Masahiro Yamada  2019-07-16 @36  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
295bcca84916cb Rikard Falkeborn 2020-04-06  37  #define GENMASK(h, l) \
295bcca84916cb Rikard Falkeborn 2020-04-06  38  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
8bd9cb51daac89 Will Deacon      2018-06-19  39  

:::::: The code at line 35 was first introduced by commit
:::::: 95b980d62d52c4c1768ee719e8db3efe27ef52b2 linux/bits.h: make BIT(), GENMASK(), and friends available in assembly

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
