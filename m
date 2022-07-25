Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1446957F7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiGYAko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 20:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 20:40:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E26555
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658709640; x=1690245640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z/9yC4CVtJOlKMdZ2hxN3f1lgU4U9wDQV2ytR9vS8r4=;
  b=KvBf8NqODPGOBKIx+EMGGhN4FNpY4GjG117K9228zASqB5gH5Q0qgG8w
   k3YQqs+9jAtI11iugIcJ0BTVtawokYq865PjISTiuyX9reYs1gtMSrUzr
   EKMSuX+bNCUsArS3MmeBTdXqzofHBn8n2jowtwTyO6Ge12dWnAm/c5iyj
   ENxer+9T5pz6zTFls47d7T8gE3ksHw7f3rrQ1/I3u2bszRmddEBxcrU50
   aVc0LzgUyxPi4FgINs/XaKy2D0zLONI8kkLXDaZV3ZBCn69eyXF9Hqr/p
   Yp/vkvzWQNmTQiPMpZk1u+FNZXGncrJ6c60RAE6a784yUob+zJJoe7yQh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="286342020"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="286342020"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 17:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="845329208"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2022 17:40:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFm9G-0004R7-0T;
        Mon, 25 Jul 2022 00:40:38 +0000
Date:   Mon, 25 Jul 2022 08:40:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: drivers/clocksource/timer-ixp4xx.c:48:8: warning: Excessive padding
 in 'struct ixp4xx_timer' (48 padding bytes, where 16 is optimal). Optimal
 fields order: clkevt, base, latch, delay_timer, consider reordering the
 fields or adding explicit padding members...
Message-ID: <202207250823.mR3iK7kc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 21a0a29d16c672b0c6e3662ea55969dccdbc5547 watchdog: ixp4xx: Rewrite driver to use core
date:   12 months ago
config: arm-randconfig-c002-20220721 (https://download.01.org/0day-ci/archive/20220725/202207250823.mR3iK7kc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=21a0a29d16c672b0c6e3662ea55969dccdbc5547
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 21a0a29d16c672b0c6e3662ea55969dccdbc5547
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)
   3 warnings generated.
   include/linux/hid.h:1007:9: warning: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'input') [clang-analyzer-core.NullDereference]
                                       input->name, c, type);
                                       ^
   drivers/hid/hid-sunplus.c:39:6: note: Assuming the condition is false
           if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-sunplus.c:39:2: note: Taking false branch
           if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
           ^
   drivers/hid/hid-sunplus.c:42:2: note: Control jumps to 'case 8451:'  at line 44
           switch (usage->hid & HID_USAGE) {
           ^
   drivers/hid/hid-sunplus.c:44:15: note: Calling 'hid_map_usage_clear'
           case 0x2103: sp_map_key_clear(KEY_ZOOMOUT);     break;
                        ^
   drivers/hid/hid-sunplus.c:33:29: note: expanded from macro 'sp_map_key_clear'
   #define sp_map_key_clear(c)     hid_map_usage_clear(hi, usage, bit, max, \
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1035:2: note: Calling 'hid_map_usage'
           hid_map_usage(hidinput, usage, bit, max, type, c);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:982:2: note: 'input' initialized here
           struct input_dev *input = hidinput->input;
           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:986:2: note: Control jumps to 'case 1:'  at line 995
           switch (type) {
           ^
   include/linux/hid.h:998:3: note:  Execution continues on line 1005
                   break;
                   ^
   include/linux/hid.h:1005:15: note: 'c' is <= 'limit'
           if (unlikely(c > limit || !bmap)) {
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   include/linux/hid.h:1005:15: note: Left side of '||' is false
           if (unlikely(c > limit || !bmap)) {
                        ^
   include/linux/hid.h:1005:28: note: Assuming 'bmap' is null
           if (unlikely(c > limit || !bmap)) {
                                     ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   include/linux/hid.h:1005:28: note: Assuming pointer value is null
           if (unlikely(c > limit || !bmap)) {
                                     ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   include/linux/hid.h:1005:2: note: Taking true branch
           if (unlikely(c > limit || !bmap)) {
           ^
   include/linux/hid.h:1006:3: note: Assuming the condition is true
                   pr_warn_ratelimited("%s: Invalid code %d type %d\n",
                   ^
   include/linux/printk.h:557:2: note: expanded from macro 'pr_warn_ratelimited'
           printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:540:6: note: expanded from macro 'printk_ratelimited'
           if (__ratelimit(&_rs))                                          \
               ^~~~~~~~~~~~~~~~~
   include/linux/ratelimit_types.h:41:28: note: expanded from macro '__ratelimit'
   #define __ratelimit(state) ___ratelimit(state, __func__)
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1006:3: note: Taking true branch
                   pr_warn_ratelimited("%s: Invalid code %d type %d\n",
                   ^
   include/linux/printk.h:557:2: note: expanded from macro 'pr_warn_ratelimited'
           printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
           ^
   include/linux/printk.h:540:2: note: expanded from macro 'printk_ratelimited'
           if (__ratelimit(&_rs))                                          \
           ^
   include/linux/hid.h:1007:9: note: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'input')
                                       input->name, c, type);
                                       ^
   include/linux/printk.h:557:49: note: expanded from macro 'pr_warn_ratelimited'
           printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                                          ^~~~~~~~~~~
   include/linux/printk.h:541:17: note: expanded from macro 'printk_ratelimited'
                   printk(fmt, ##__VA_ARGS__);                             \
                                 ^~~~~~~~~~~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   12 warnings generated.
   Suppressed 12 warnings (2 in non-user code, 10 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   drivers/clocksource/timer-fttmr010.c:99:8: warning: Excessive padding in 'struct fttmr010' (39 padding bytes, where 7 is optimal). Optimal fields order: clkevt, base, tick_rate, t1_enable_val, timer_shutdown, delay_timer, is_aspeed, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct fttmr010 {
   ~~~~~~~^~~~~~~~~~
   drivers/clocksource/timer-fttmr010.c:99:8: note: Excessive padding in 'struct fttmr010' (39 padding bytes, where 7 is optimal). Optimal fields order: clkevt, base, tick_rate, t1_enable_val, timer_shutdown, delay_timer, is_aspeed, consider reordering the fields or adding explicit padding members
   struct fttmr010 {
   ~~~~~~~^~~~~~~~~~
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
>> drivers/clocksource/timer-ixp4xx.c:48:8: warning: Excessive padding in 'struct ixp4xx_timer' (48 padding bytes, where 16 is optimal). Optimal fields order: clkevt, base, latch, delay_timer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ixp4xx_timer {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/clocksource/timer-ixp4xx.c:48:8: note: Excessive padding in 'struct ixp4xx_timer' (48 padding bytes, where 16 is optimal). Optimal fields order: clkevt, base, latch, delay_timer, consider reordering the fields or adding explicit padding members
   struct ixp4xx_timer {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   drivers/clocksource/timer-stm32.c:282:9: warning: The result of the left shift is undefined due to shifting by '32', which is greater or equal to the width of type 'int' [clang-analyzer-core.UndefinedBinaryOperatorResult]
                                           (1 <<  bits) - 1);
                                              ^
   drivers/clocksource/timer-stm32.c:295:6: note: Assuming 'to' is non-null
           if (!to)
               ^~~
   drivers/clocksource/timer-stm32.c:295:2: note: Taking false branch
           if (!to)
           ^
   drivers/clocksource/timer-stm32.c:302:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/clocksource/timer-stm32.c:302:2: note: Taking false branch
           if (ret)
           ^
   drivers/clocksource/timer-stm32.c:307:6: note: Assuming field 'private_data' is non-null
           if (!to->private_data) {
               ^~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:307:2: note: Taking false branch
           if (!to->private_data) {
           ^
   drivers/clocksource/timer-stm32.c:313:2: note: Taking true branch
           if (!IS_ERR(rstc)) {
           ^
   drivers/clocksource/timer-stm32.c:318:2: note: Calling 'stm32_timer_set_width'
           stm32_timer_set_width(to);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:196:30: note: Assuming the condition is true
           stm32_timer_of_bits_set(to, width == UINT_MAX ? 32 : 16);
                                       ^~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:196:30: note: '?' condition is true
   drivers/clocksource/timer-stm32.c:196:30: note: Passing the value 32 via 2nd parameter 'bits'
           stm32_timer_of_bits_set(to, width == UINT_MAX ? 32 : 16);
                                       ^~~~~
   drivers/clocksource/timer-stm32.c:196:2: note: Calling 'stm32_timer_of_bits_set'
           stm32_timer_of_bits_set(to, width == UINT_MAX ? 32 : 16);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:66:2: note: The value 32 is assigned to field 'bits'
           pd->bits = bits;
           ^~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:196:2: note: Returning from 'stm32_timer_of_bits_set'
           stm32_timer_of_bits_set(to, width == UINT_MAX ? 32 : 16);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:318:2: note: Returning from 'stm32_timer_set_width'
           stm32_timer_set_width(to);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:323:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/clocksource/timer-stm32.c:323:2: note: Taking false branch
           if (ret)
           ^
   drivers/clocksource/timer-stm32.c:326:2: note: Calling 'stm32_clockevent_init'
           stm32_clockevent_init(to);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:270:13: note: Calling 'stm32_timer_of_bits_get'
           u32 bits = stm32_timer_of_bits_get(to);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:82:2: note: Returning the value 32
           return pd->bits;
           ^~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:270:13: note: Returning from 'stm32_timer_of_bits_get'
           u32 bits = stm32_timer_of_bits_get(to);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-stm32.c:270:2: note: 'bits' initialized to 32

vim +48 drivers/clocksource/timer-ixp4xx.c

13e0b4059b984a Linus Walleij 2019-01-26  47  
13e0b4059b984a Linus Walleij 2019-01-26 @48  struct ixp4xx_timer {
13e0b4059b984a Linus Walleij 2019-01-26  49  	void __iomem *base;
13e0b4059b984a Linus Walleij 2019-01-26  50  	u32 latch;
13e0b4059b984a Linus Walleij 2019-01-26  51  	struct clock_event_device clkevt;
13e0b4059b984a Linus Walleij 2019-01-26  52  #ifdef CONFIG_ARM
13e0b4059b984a Linus Walleij 2019-01-26  53  	struct delay_timer delay_timer;
13e0b4059b984a Linus Walleij 2019-01-26  54  #endif
13e0b4059b984a Linus Walleij 2019-01-26  55  };
13e0b4059b984a Linus Walleij 2019-01-26  56  

:::::: The code at line 48 was first introduced by commit
:::::: 13e0b4059b984a1c63cae5604e1f665472751ea1 clocksource/drivers/ixp4xx: Add driver

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
