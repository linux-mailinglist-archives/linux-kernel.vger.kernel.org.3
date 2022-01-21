Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB45495EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380336AbiAUMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:24:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:44938 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380326AbiAUMYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642767888; x=1674303888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3hfDR6qd0OhhK8ZgQ4/ZQOZpwPEBT6cE5sRbv1NeCD0=;
  b=IoQl98cm0m9hmn1GvVY9ffmipUyqlwQHD8vPumRmjiAucGNAJXmZFGX2
   J/N1nXTbreUUoP/3UQQVSJLzsEcI925XoYfs5s2SdMDtIVSZJKLaJBNO+
   S1S/RqEGs6kF+9i0De6RuiGY7Lpd1mQRwJMI+ZKsOwlUIU3KPM9cgAbdZ
   +chrVUBkSthAEUSD8tN3kem9aZD8XSa5Z4u+26IwAVcl6/w3X6esefwVz
   pGo3Te6A9JIlrj6lwmexOQ30jf3Z4lbkLvWznRSA9rwpAYP7YvZeZc5DK
   0yhw8BnhT6jSq4biIf5NzEkGsIJEaKHZD5dPptpKyfa/nHMvwSVZxB3q5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="331993633"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="331993633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 04:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="579592908"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2022 04:24:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAsyC-000FHR-AK; Fri, 21 Jan 2022 12:24:44 +0000
Date:   Fri, 21 Jan 2022 20:23:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v11 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Message-ID: <202201212032.qL41ty3V-lkp@intel.com>
References: <20220120080347.1595379-5-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120080347.1595379-5-laurent@vivier.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linux/master linus/master next-20220121]
[cannot apply to geert-m68k/for-next v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20220120-160832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220121/202201212032.qL41ty3V-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ea1170b472532011ab0c8208b6414a36810f45ab
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20220120-160832
        git checkout ea1170b472532011ab0c8208b6414a36810f45ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-goldfish.c: In function 'goldfish_timer_read':
>> drivers/clocksource/timer-goldfish.c:52:20: error: implicit declaration of function 'gf_ioread32'; did you mean 'ioread32'? [-Werror=implicit-function-declaration]
      52 |         time_low = gf_ioread32(base + TIMER_TIME_LOW);
         |                    ^~~~~~~~~~~
         |                    ioread32
   drivers/clocksource/timer-goldfish.c: In function 'goldfish_timer_set_oneshot':
>> drivers/clocksource/timer-goldfish.c:65:9: error: implicit declaration of function 'gf_iowrite32'; did you mean 'iowrite32'? [-Werror=implicit-function-declaration]
      65 |         gf_iowrite32(0, base + TIMER_ALARM_HIGH);
         |         ^~~~~~~~~~~~
         |         iowrite32
   cc1: some warnings being treated as errors


vim +52 drivers/clocksource/timer-goldfish.c

    40	
    41	static u64 goldfish_timer_read(struct clocksource *cs)
    42	{
    43		struct goldfish_timer *timerdrv = cs_to_gf(cs);
    44		void __iomem *base = timerdrv->base;
    45		u32 time_low, time_high;
    46		u64 ticks;
    47	
    48		/*
    49		 * time_low: get low bits of current time and update time_high
    50		 * time_high: get high bits of time at last time_low read
    51		 */
  > 52		time_low = gf_ioread32(base + TIMER_TIME_LOW);
    53		time_high = gf_ioread32(base + TIMER_TIME_HIGH);
    54	
    55		ticks = ((u64)time_high << 32) | time_low;
    56	
    57		return ticks;
    58	}
    59	
    60	static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
    61	{
    62		struct goldfish_timer *timerdrv = ced_to_gf(evt);
    63		void __iomem *base = timerdrv->base;
    64	
  > 65		gf_iowrite32(0, base + TIMER_ALARM_HIGH);
    66		gf_iowrite32(0, base + TIMER_ALARM_LOW);
    67		gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
    68	
    69		return 0;
    70	}
    71	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
