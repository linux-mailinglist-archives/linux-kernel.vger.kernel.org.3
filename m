Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5424745B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhLNOzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:55:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:39413 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235081AbhLNOzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639493713; x=1671029713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZARHgNyQLGNe98GhfrOTANNVUC34fXbMtvGpxDk0kzA=;
  b=CNXap8ldsvRnlsPRjMClITRtu8Pi8eQ/6A1dNfEcApUz0Trrk++iw/fR
   opbLQa/UzQQDqxbNbr2DkSDleCUmZ6Va5mxW6743BH1pFyhkAPLctC2lB
   x/gkPofpJwdQ4vnYun342HW8TNw0hPK7CyOVc6Y8ikAidwW2I9UqeISXn
   ALlYL5Bb42jc+XWQA7mDb2pr6a3WYLZ4G197AdA0dHWKqtqc0yBB/9Ggr
   I0zr3KOfxF9WYKz3ldfQWW7s++S0fduuIVa09uhOBeo6H1LktCGZlOXyh
   40QPPaqVnxJQWST3uXhVPoe9DZX1Pf0lTCpJF6DQmBc3yfaFuGO/NaCfA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325268239"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="325268239"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 06:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="614292741"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2021 06:55:11 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx9Cw-0000Qj-Cy; Tue, 14 Dec 2021 14:55:10 +0000
Date:   Tue, 14 Dec 2021 22:54:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [chenxing:msc313_mainlining 69/78]
 drivers/clocksource/timer-msc313e.c:38:21: error: field has incomplete type
 'struct delay_timer'
Message-ID: <202112142240.MQkK0BR0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   04c62a6ed8b1b9034464e903809c8b6a9354bf6e
commit: 6d59a74a236d8cd686cc2dde0d122e9a609216c5 [69/78] clocksource: Add MStar MSC313e timer support
config: hexagon-buildonly-randconfig-r002-20211214 (https://download.01.org/0day-ci/archive/20211214/202112142240.MQkK0BR0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/6d59a74a236d8cd686cc2dde0d122e9a609216c5
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 6d59a74a236d8cd686cc2dde0d122e9a609216c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clocksource/timer-msc313e.c:38:21: error: field has incomplete type 'struct delay_timer'
           struct delay_timer delay;
                              ^
   drivers/clocksource/timer-msc313e.c:38:9: note: forward declaration of 'struct delay_timer'
           struct delay_timer delay;
                  ^
>> drivers/clocksource/timer-msc313e.c:197:2: error: implicit declaration of function 'register_current_timer_delay' [-Werror,-Wimplicit-function-declaration]
           register_current_timer_delay(&msc313e_delay.delay);
           ^
   2 errors generated.


vim +38 drivers/clocksource/timer-msc313e.c

    35	
    36	struct msc313e_delay {
    37		void __iomem *base;
  > 38		struct delay_timer delay;
    39	};
    40	
    41	static void __iomem *msc313e_clksrc;
    42	static struct msc313e_delay msc313e_delay;
    43	
    44	static void msc313e_timer_stop(void __iomem *base)
    45	{
    46		writew(0, base + MSC313E_REG_CTRL);
    47	}
    48	
    49	static void msc313e_timer_start(void __iomem *base, bool periodic)
    50	{
    51		u16 reg;
    52	
    53		reg = readw(base + MSC313E_REG_CTRL);
    54		if (periodic)
    55			reg |= MSC313E_REG_CTRL_TIMER_EN;
    56		else
    57			reg |= MSC313E_REG_CTRL_TIMER_TRIG;
    58		writew(reg | MSC313E_REG_CTRL_TIMER_INT_EN, base + MSC313E_REG_CTRL);
    59	}
    60	
    61	static void msc313e_timer_setup(void __iomem *base, unsigned long delay)
    62	{
    63		writew(delay >> 16, base + MSC313E_REG_TIMER_MAX_HIGH);
    64		writew(delay & 0xffff, base + MSC313E_REG_TIMER_MAX_LOW);
    65	}
    66	
    67	static unsigned long msc313e_timer_current_value(void __iomem *base)
    68	{
    69		unsigned long result;
    70	
    71		result = readw(base + MSC313E_REG_COUNTER_LOW);
    72		result |= readw(base + MSC313E_REG_COUNTER_HIGH) << 16;
    73	
    74		return result;
    75	}
    76	
    77	static int msc313e_timer_clkevt_shutdown(struct clock_event_device *evt)
    78	{
    79		struct timer_of *timer = to_timer_of(evt);
    80	
    81		msc313e_timer_stop(timer_of_base(timer));
    82	
    83		return 0;
    84	}
    85	
    86	static int msc313e_timer_clkevt_set_oneshot(struct clock_event_device *evt)
    87	{
    88		struct timer_of *timer = to_timer_of(evt);
    89	
    90		msc313e_timer_stop(timer_of_base(timer));
    91		msc313e_timer_start(timer_of_base(timer), false);
    92	
    93		return 0;
    94	}
    95	
    96	static int msc313e_timer_clkevt_set_periodic(struct clock_event_device *evt)
    97	{
    98		struct timer_of *timer = to_timer_of(evt);
    99	
   100		msc313e_timer_stop(timer_of_base(timer));
   101		msc313e_timer_setup(timer_of_base(timer), timer_of_period(timer));
   102		msc313e_timer_start(timer_of_base(timer), true);
   103	
   104		return 0;
   105	}
   106	
   107	static int msc313e_timer_clkevt_next_event(unsigned long evt, struct clock_event_device *clkevt)
   108	{
   109		struct timer_of *timer = to_timer_of(clkevt);
   110	
   111		msc313e_timer_stop(timer_of_base(timer));
   112		msc313e_timer_setup(timer_of_base(timer), evt);
   113		msc313e_timer_start(timer_of_base(timer), false);
   114	
   115		return 0;
   116	}
   117	
   118	static irqreturn_t msc313e_timer_clkevt_irq(int irq, void *dev_id)
   119	{
   120		struct clock_event_device *evt = dev_id;
   121	
   122		evt->event_handler(evt);
   123	
   124		return IRQ_HANDLED;
   125	}
   126	
   127	static u64 msc313e_timer_clksrc_read(struct clocksource *cs)
   128	{
   129		return msc313e_timer_current_value(msc313e_clksrc) & cs->mask;
   130	}
   131	
   132	static unsigned long msc313e_read_delay_timer_read(void)
   133	{
   134		return msc313e_timer_current_value(msc313e_delay.base);
   135	}
   136	
   137	static u64 msc313e_timer_sched_clock_read(void)
   138	{
   139		return msc313e_timer_current_value(msc313e_clksrc);
   140	}
   141	
   142	static struct clock_event_device msc313e_clkevt = {
   143		.name = TIMER_NAME,
   144		.rating = 300,
   145		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
   146		.set_state_shutdown = msc313e_timer_clkevt_shutdown,
   147		.set_state_periodic = msc313e_timer_clkevt_set_periodic,
   148		.set_state_oneshot = msc313e_timer_clkevt_set_oneshot,
   149		.tick_resume = msc313e_timer_clkevt_shutdown,
   150		.set_next_event = msc313e_timer_clkevt_next_event,
   151	};
   152	
   153	static int __init msc313e_clkevt_init(struct device_node *np)
   154	{
   155		int ret;
   156		struct timer_of *to;
   157	
   158		to = kzalloc(sizeof(*to), GFP_KERNEL);
   159		if (!to)
   160			return -ENOMEM;
   161	
   162		to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
   163		to->of_irq.handler = msc313e_timer_clkevt_irq;
   164		ret = timer_of_init(np, to);
   165		if (ret)
   166			return ret;
   167	
   168		msc313e_clkevt.cpumask = cpu_possible_mask;
   169		msc313e_clkevt.irq = to->of_irq.irq;
   170		to->clkevt = msc313e_clkevt;
   171	
   172		clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
   173						TIMER_SYNC_TICKS, 0xffffffff);
   174		return 0;
   175	}
   176	
   177	static int __init msc313e_clksrc_init(struct device_node *np)
   178	{
   179		struct timer_of to = { 0 };
   180		int ret;
   181		u16 reg;
   182	
   183		to.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
   184		ret = timer_of_init(np, &to);
   185		if (ret)
   186			return ret;
   187	
   188		msc313e_delay.base = timer_of_base(&to);
   189		msc313e_delay.delay.read_current_timer = msc313e_read_delay_timer_read;
   190		msc313e_delay.delay.freq = timer_of_rate(&to);
   191	
   192		msc313e_clksrc = timer_of_base(&to);
   193		reg = readw(msc313e_clksrc + MSC313E_REG_CTRL);
   194		reg |= MSC313E_REG_CTRL_TIMER_EN;
   195		writew(reg, msc313e_clksrc + MSC313E_REG_CTRL);
   196	
 > 197		register_current_timer_delay(&msc313e_delay.delay);
   198	
   199		sched_clock_register(msc313e_timer_sched_clock_read, 32, timer_of_rate(&to));
   200		return clocksource_mmio_init(timer_of_base(&to), TIMER_NAME, timer_of_rate(&to), 300, 32,
   201					     msc313e_timer_clksrc_read);
   202	}
   203	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
