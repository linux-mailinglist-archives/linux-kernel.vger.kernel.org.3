Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11E4E1B46
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiCTLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiCTLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:10:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FAB4FC75
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 04:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647774546; x=1679310546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kS7nB5wKB0lFLr05hGgs0Zt0HxhfWwY+aKIBo4angRg=;
  b=HbJDPM6Tk4AecFmKOve844EvgiWxOXTEo0acq4s62YHrxJdRZAjqxGbN
   jiUg6iv3DSckYUXfdKoqKzLUWRArBP/9Mh0pVzAp99wPlzhdPZ+d4NexB
   bpXPU66jOQLnfEDZDGbCj/RTZKGgLp9DyNtTRbZCuqPoNDZCI2Kpprihb
   vI2eIM9Y7rxcDY55/nomhORzypMYMh/19y30u21bpg7hIXNPCp4fOaw56
   eNAEiTHAkMs3qGl6sy0XpRzCblBGBJ1ppWK7r7+56IxAcJjM2+fXSykwy
   tqEn7YENJVDj+odBSIMW7uMMhhYE3BZppatJoYLNNt8ovT+hxQR8lGghy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="256203186"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="256203186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 04:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="499853126"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2022 04:09:04 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVtQl-000Gqx-Cb; Sun, 20 Mar 2022 11:09:03 +0000
Date:   Sun, 20 Mar 2022 19:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme-rfc 5/12] drivers/soc/apple/rtkit-internal.h:21:51:
 warning: format '%llx' expects argument of type 'long long unsigned int',
 but argument 5 has type 'dma_addr_t' {aka 'unsigned int'}
Message-ID: <202203201919.HHwaX0TL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220320/202203201919.HHwaX0TL-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/5f102aac51098ef778ed49811de43091e05ca895
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-rfc
        git checkout 5f102aac51098ef778ed49811de43091e05ca895
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:241:27: note: in expansion of macro 'FIELD_GET'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                           ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:61:41: note: in expansion of macro 'GENMASK'
      61 | #define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK(41, 0)
         |                                         ^~~~~~~
   drivers/soc/apple/rtkit.c:241:37: note: in expansion of macro 'APPLE_RTKIT_BUFFER_REQUEST_IOVA'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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
   include/linux/bitfield.h:71:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      71 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:56: note: in expansion of macro '__bf_shf'
      72 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:241:27: note: in expansion of macro 'FIELD_GET'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                           ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:61:41: note: in expansion of macro 'GENMASK'
      61 | #define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK(41, 0)
         |                                         ^~~~~~~
   drivers/soc/apple/rtkit.c:241:37: note: in expansion of macro 'APPLE_RTKIT_BUFFER_REQUEST_IOVA'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/soc/apple/rtkit-internal.h:5,
                    from drivers/soc/apple/rtkit.c:9:
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:126:44: note: in definition of macro 'FIELD_GET'
     126 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:61:41: note: in expansion of macro 'GENMASK'
      61 | #define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK(41, 0)
         |                                         ^~~~~~~
   drivers/soc/apple/rtkit.c:241:37: note: in expansion of macro 'APPLE_RTKIT_BUFFER_REQUEST_IOVA'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:42:38: note: in definition of macro '__bf_shf'
      42 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/soc/apple/rtkit.c:241:27: note: in expansion of macro 'FIELD_GET'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                           ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:61:41: note: in expansion of macro 'GENMASK'
      61 | #define APPLE_RTKIT_BUFFER_REQUEST_IOVA GENMASK(41, 0)
         |                                         ^~~~~~~
   drivers/soc/apple/rtkit.c:241:37: note: in expansion of macro 'APPLE_RTKIT_BUFFER_REQUEST_IOVA'
     241 |         dma_addr_t iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/soc/apple/rtkit-internal.h:7,
                    from drivers/soc/apple/rtkit.c:9:
>> drivers/soc/apple/rtkit-internal.h:21:51: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
      21 | #define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
         |                                                   ^~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/soc/apple/rtkit-internal.h:21:33: note: in expansion of macro 'dev_dbg'
      21 | #define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
         |                                 ^~~~~~~
   drivers/soc/apple/rtkit.c:245:9: note: in expansion of macro 'rtk_dbg'
     245 |         rtk_dbg("buffer request for 0x%zx bytes at 0x%llx\n", size, iova);
         |         ^~~~~~~
   In file included from <command-line>:
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:62:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      62 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:265:25: note: in expansion of macro 'FIELD_PREP'
     265 |                 reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
         |                         ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:63:33: note: in expansion of macro 'GENMASK'
      63 | #define APPLE_RTKIT_SYSLOG_TYPE GENMASK(59, 52)
         |                                 ^~~~~~~
   drivers/soc/apple/rtkit.c:265:36: note: in expansion of macro 'APPLE_RTKIT_SYSLOG_TYPE'
     265 |                 reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:62:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      62 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/soc/apple/rtkit.c:265:25: note: in expansion of macro 'FIELD_PREP'
     265 |                 reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
         |                         ^~~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/soc/apple/rtkit.c:63:33: note: in expansion of macro 'GENMASK'
      63 | #define APPLE_RTKIT_SYSLOG_TYPE GENMASK(59, 52)
         |                                 ^~~~~~~
   drivers/soc/apple/rtkit.c:265:36: note: in expansion of macro 'APPLE_RTKIT_SYSLOG_TYPE'
     265 |                 reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
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
   drivers/soc/apple/rtkit.c:265:25: note: in expansion of macro 'FIELD_PREP'


vim +21 drivers/soc/apple/rtkit-internal.h

    17	
    18	#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
    19	#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
    20	#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
  > 21	#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
    22	
    23	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
