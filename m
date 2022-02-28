Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181B4C7515
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiB1Ru3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiB1RoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8B9D0DE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069778; x=1677605778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNaNNHqAIqgJiiZ16Dvv6Se8got1HO3XhTb5+wE1vwk=;
  b=N+IukYxpkmVOk+O0q9xeT7W3mrqrYY7suTbiA0JjIId9LVlADwWqjMrk
   2EaefzSiw4SrX0C3gfTwUI8iQFUI2C16l/PwlSjea//kR+iaSQ1YkJlgt
   F2KKDny+PxOlxPHMK3pGrQq/Ad7o9BjfilGy66bvUiCBDMtTxgrSxPpsU
   enzgqoMugZH4mdhLF2U4oiSm1wj3cXuN846Eh8M3+L1KU8kWJ5s85oPLr
   Ot8Tltts1C7N57Aq4eA87gUBWoebWjt+GG3t/V4jgCwjIjq00HeOMq3Va
   Wpq0EhdUuZBFeMVTKw5ocDIzwZFltnYusd/ggDL9s7/A4ZMimAIKxwfcO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252865435"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252865435"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="608524735"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2022 09:36:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjwU-0007aj-9X; Mon, 28 Feb 2022 17:36:14 +0000
Date:   Tue, 1 Mar 2022 01:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 5/7] clocksource/drivers/timer-microchip-pit64b: add
 delay timer
Message-ID: <202202282242.zM0FjCHj-lkp@intel.com>
References: <20220228111923.1400049-6-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228111923.1400049-6-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on soc/for-next linus/master v5.17-rc6 next-20220225]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220228-191933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: s390-randconfig-r036-20220228 (https://download.01.org/0day-ci/archive/20220228/202202282242.zM0FjCHj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/6050ca5a0af604ed2c397dcb907a9b057635a64e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220228-191933
        git checkout 6050ca5a0af604ed2c397dcb907a9b057635a64e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/clocksource/timer-microchip-pit64b.c:11:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/clocksource/timer-microchip-pit64b.c:11:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/clocksource/timer-microchip-pit64b.c:11:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/clocksource/timer-microchip-pit64b.c:97:27: warning: tentative definition of variable with internal linkage has incomplete non-array type 'struct delay_timer' [-Wtentative-definition-incomplete-type]
   static struct delay_timer mchp_pit64b_dt;
                             ^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   drivers/clocksource/timer-microchip-pit64b.c:382:16: error: incomplete definition of type 'struct delay_timer'
           mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
           ~~~~~~~~~~~~~~^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   drivers/clocksource/timer-microchip-pit64b.c:383:16: error: incomplete definition of type 'struct delay_timer'
           mchp_pit64b_dt.freq = clk_rate;
           ~~~~~~~~~~~~~~^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   drivers/clocksource/timer-microchip-pit64b.c:384:2: error: implicit declaration of function 'register_current_timer_delay' [-Werror,-Wimplicit-function-declaration]
           register_current_timer_delay(&mchp_pit64b_dt);
           ^
   drivers/clocksource/timer-microchip-pit64b.c:97:27: error: tentative definition has type 'struct delay_timer' that is never completed
   static struct delay_timer mchp_pit64b_dt;
                             ^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   13 warnings and 4 errors generated.


vim +97 drivers/clocksource/timer-microchip-pit64b.c

    87	
    88	#define clksrc_to_mchp_pit64b_timer(x) \
    89		((struct mchp_pit64b_timer *)container_of(x,\
    90			struct mchp_pit64b_clksrc, clksrc))
    91	
    92	/* Base address for clocksource timer. */
    93	static void __iomem *mchp_pit64b_cs_base;
    94	/* Default cycles for clockevent timer. */
    95	static u64 mchp_pit64b_ce_cycles;
    96	/* Delay timer. */
  > 97	static struct delay_timer mchp_pit64b_dt;
    98	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
