Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930974C74FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiB1Rrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiB1RoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD99E576
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069792; x=1677605792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oc3EwdvPkCRX9VtOGg0y58VHgEG5oYia76pX3LF4U1Q=;
  b=RsxT7QcK2/G6N9OMMjSzk9Gv4FwW9VfwjeHXFoNWOZ7kuC8tB4EDNNUG
   4Psd+gLxCUiU6SncjoCKMXR9uWGNNA2C+KOpfhrifpduGV76xtTxNuAd6
   gcx5Mcdkd647Ykhlm72FbXLS+HjAgl/turLHWMAY3S+CaAXR48cH0Xdrk
   bQgyl5Ops/G8b2Pux+GANRLFoEyhrzlFR1LhW+QMPQwFtv8wA5CPSk3Dn
   UZaJPpcv6lKpHDpo/7ygMe6EsQq6Ga4n4q1TRe+FeW00qZjtYjdYO7N0E
   W7u95MmYuQQWGgJrbcL9U1ijF9utO0ie2LcLwWxjX81pkpR583ytsCmqF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233560250"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="233560250"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="544807364"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2022 09:36:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjwU-0007am-9u; Mon, 28 Feb 2022 17:36:14 +0000
Date:   Tue, 1 Mar 2022 01:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 5/7] clocksource/drivers/timer-microchip-pit64b: add
 delay timer
Message-ID: <202202282139.f38uxhKT-lkp@intel.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on soc/for-next linus/master v5.17-rc6 next-20220225]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220228-191933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: openrisc-randconfig-r035-20220228 (https://download.01.org/0day-ci/archive/20220228/202202282139.f38uxhKT-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6050ca5a0af604ed2c397dcb907a9b057635a64e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220228-191933
        git checkout 6050ca5a0af604ed2c397dcb907a9b057635a64e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-microchip-pit64b.c: In function 'mchp_pit64b_init_clksrc':
>> drivers/clocksource/timer-microchip-pit64b.c:382:23: error: invalid use of undefined type 'struct delay_timer'
     382 |         mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
         |                       ^
   drivers/clocksource/timer-microchip-pit64b.c:383:23: error: invalid use of undefined type 'struct delay_timer'
     383 |         mchp_pit64b_dt.freq = clk_rate;
         |                       ^
>> drivers/clocksource/timer-microchip-pit64b.c:384:9: error: implicit declaration of function 'register_current_timer_delay' [-Werror=implicit-function-declaration]
     384 |         register_current_timer_delay(&mchp_pit64b_dt);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-microchip-pit64b.c: At top level:
>> drivers/clocksource/timer-microchip-pit64b.c:97:27: error: storage size of 'mchp_pit64b_dt' isn't known
      97 | static struct delay_timer mchp_pit64b_dt;
         |                           ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +382 drivers/clocksource/timer-microchip-pit64b.c

   341	
   342	static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
   343						  u32 clk_rate)
   344	{
   345		struct mchp_pit64b_clksrc *cs;
   346		int ret;
   347	
   348		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
   349		if (!cs)
   350			return -ENOMEM;
   351	
   352		mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
   353	
   354		mchp_pit64b_cs_base = timer->base;
   355	
   356		cs->timer.base = timer->base;
   357		cs->timer.pclk = timer->pclk;
   358		cs->timer.gclk = timer->gclk;
   359		cs->timer.mode = timer->mode;
   360		cs->clksrc.name = MCHP_PIT64B_NAME;
   361		cs->clksrc.mask = CLOCKSOURCE_MASK(64);
   362		cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
   363		cs->clksrc.rating = 210;
   364		cs->clksrc.read = mchp_pit64b_clksrc_read;
   365		cs->clksrc.suspend = mchp_pit64b_clksrc_suspend;
   366		cs->clksrc.resume = mchp_pit64b_clksrc_resume;
   367	
   368		ret = clocksource_register_hz(&cs->clksrc, clk_rate);
   369		if (ret) {
   370			pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
   371	
   372			/* Stop timer. */
   373			writel_relaxed(MCHP_PIT64B_CR_SWRST,
   374				       timer->base + MCHP_PIT64B_CR);
   375			kfree(cs);
   376	
   377			return ret;
   378		}
   379	
   380		sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
   381	
 > 382		mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
   383		mchp_pit64b_dt.freq = clk_rate;
 > 384		register_current_timer_delay(&mchp_pit64b_dt);
   385	
   386		return 0;
   387	}
   388	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
