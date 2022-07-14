Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF0574105
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiGNBrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGNBrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:47:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D122B1E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657763255; x=1689299255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bajISLyURZvr8+VzicBKZ2S+nSg+sewX9QOVxbvMrIE=;
  b=WsJ6YUuNSkqR/+03r8mVTs3f3jpxf4T0tQ4uS63CYXDs3Nn4vilTz7wg
   jxA9fvqCjwGrbweHHmM3kwD+FmjzKPaUXYyc06rJOtvL99X16QAtLGP1F
   d7Xd4V7+bJIvjJ8hYQgZ2WGNE8bNGsyWDrHx+5BGav6uLj8HW/Wtavl0y
   OcikauvcYIvW/btq81puFSDPckNWYs+h1nLAQIOyDSnHcID3YDlkxZ2g+
   905LgdRxIsoH/LAI2sM3QUSl+HZ6lxfMcb/Ksll0TkTDvxWl/WQ/54ggg
   HZFOGEsAryUu4enc2492/y/3HANFttOJJNUb/3cu5kwluBUJdOL8Gabda
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285413369"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="285413369"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:47:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="623208702"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2022 18:47:33 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBnwy-00043f-KD;
        Thu, 14 Jul 2022 01:47:32 +0000
Date:   Thu, 14 Jul 2022 09:47:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-bwmon-llcc-manual-regmap 21/21]
 drivers/soc/qcom/icc-bwmon.c:196:27: error: 'const struct icc_bwmon_data'
 has no member named 'irq_mask'
Message-ID: <202207140934.JwNKGHAA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-bwmon-llcc-manual-regmap
head:   f8c2f9796ac481bfd123096df5dd4d9f570c57b6
commit: f8c2f9796ac481bfd123096df5dd4d9f570c57b6 [21/21] wip
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220714/202207140934.JwNKGHAA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/f8c2f9796ac481bfd123096df5dd4d9f570c57b6
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-bwmon-llcc-manual-regmap
        git checkout f8c2f9796ac481bfd123096df5dd4d9f570c57b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/soc/qcom/icc-bwmon.c:9:
   drivers/soc/qcom/icc-bwmon.c: In function 'bwmon_clear_irq':
>> drivers/soc/qcom/icc-bwmon.c:196:27: error: 'const struct icc_bwmon_data' has no member named 'irq_mask'
     196 |         writel(bwmon->data->irq_mask, BWMON_REG(bwmon, irq_clear_reg));
         |                           ^~
   arch/sh/include/asm/io.h:31:83: note: in definition of macro '__raw_writel'
      31 | #define __raw_writel(v,a)       (__chk_io_ptr(a), *(volatile u32 __force *)(a) = (v))
         |                                                                                   ^
   arch/sh/include/asm/io.h:46:66: note: in expansion of macro 'ioswabl'
      46 | #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32)ioswabl(v),c))
         |                                                                  ^~~~~~~
   arch/sh/include/asm/io.h:56:43: note: in expansion of macro 'writel_relaxed'
      56 | #define writel(v,a)             ({ wmb(); writel_relaxed((v),(a)); })
         |                                           ^~~~~~~~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:196:9: note: in expansion of macro 'writel'
     196 |         writel(bwmon->data->irq_mask, BWMON_REG(bwmon, irq_clear_reg));
         |         ^~~~~~
   drivers/soc/qcom/icc-bwmon.c: In function 'bwmon_start':
   drivers/soc/qcom/icc-bwmon.c:273:40: error: 'const struct icc_bwmon_data' has no member named 'irq_mask'
     273 |         bwmon_enable(bwmon, bwmon->data->irq_mask);
         |                                        ^~
   drivers/soc/qcom/icc-bwmon.c: In function 'bwmon_intr':
   drivers/soc/qcom/icc-bwmon.c:283:30: error: 'const struct icc_bwmon_data' has no member named 'irq_mask'
     283 |         status &= bwmon->data->irq_mask;
         |                              ^~
>> drivers/soc/qcom/icc-bwmon.c:299:55: error: 'const struct icc_bwmon_data' has no member named 'irq_shift'
     299 |         zone = get_bitmask_order(status >> bwmon->data->irq_shift) - 1;
         |                                                       ^~
   drivers/soc/qcom/icc-bwmon.c: In function 'bwmon_intr_thread':
   drivers/soc/qcom/icc-bwmon.c:344:41: error: 'const struct icc_bwmon_data' has no member named 'irq_mask'
     344 |                 irq_enable = bwmon->data->irq_mask;
         |                                         ^~
   drivers/soc/qcom/icc-bwmon.c: At top level:
   drivers/soc/qcom/icc-bwmon.c:445:10: error: 'const struct icc_bwmon_data' has no member named 'irq_mask'
     445 |         .irq_mask = BWMON_V4_IRQ_ENABLE_MASK,
         |          ^~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:446:10: error: 'const struct icc_bwmon_data' has no member named 'irq_shift'
     446 |         .irq_shift = BWMON_V4_IRQ_STATUS_ZONE_SHIFT,
         |          ^~~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:39:49: warning: initialized field overwritten [-Woverride-init]
      39 | #define BWMON_V4_IRQ_STATUS                     0x100
         |                                                 ^~~~~
   drivers/soc/qcom/icc-bwmon.c:447:27: note: in expansion of macro 'BWMON_V4_IRQ_STATUS'
     447 |         .irq_status_reg = BWMON_V4_IRQ_STATUS,
         |                           ^~~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:39:49: note: (near initialization for 'msm8998_bwmon_data.irq_status_reg')
      39 | #define BWMON_V4_IRQ_STATUS                     0x100
         |                                                 ^~~~~
   drivers/soc/qcom/icc-bwmon.c:447:27: note: in expansion of macro 'BWMON_V4_IRQ_STATUS'
     447 |         .irq_status_reg = BWMON_V4_IRQ_STATUS,
         |                           ^~~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:41:49: warning: initialized field overwritten [-Woverride-init]
      41 | #define BWMON_V4_IRQ_CLEAR                      0x108
         |                                                 ^~~~~
   drivers/soc/qcom/icc-bwmon.c:448:26: note: in expansion of macro 'BWMON_V4_IRQ_CLEAR'
     448 |         .irq_clear_reg = BWMON_V4_IRQ_CLEAR,
         |                          ^~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:41:49: note: (near initialization for 'msm8998_bwmon_data.irq_clear_reg')
      41 | #define BWMON_V4_IRQ_CLEAR                      0x108
         |                                                 ^~~~~
   drivers/soc/qcom/icc-bwmon.c:448:26: note: in expansion of macro 'BWMON_V4_IRQ_CLEAR'
     448 |         .irq_clear_reg = BWMON_V4_IRQ_CLEAR,
         |                          ^~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/icc-bwmon.c:471:10: error: 'const struct icc_bwmon_data' has no member named 'irq_mask'
     471 |         .irq_mask = BWMON_V5_IRQ_ENABLE_MASK,
         |          ^~~~~~~~
>> drivers/soc/qcom/icc-bwmon.c:471:21: error: 'BWMON_V5_IRQ_ENABLE_MASK' undeclared here (not in a function); did you mean 'BWMON_V4_IRQ_ENABLE_MASK'?
     471 |         .irq_mask = BWMON_V5_IRQ_ENABLE_MASK,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
         |                     BWMON_V4_IRQ_ENABLE_MASK
   drivers/soc/qcom/icc-bwmon.c:472:10: error: 'const struct icc_bwmon_data' has no member named 'irq_shift'
     472 |         .irq_shift = BWMON_V5_IRQ_STATUS_ZONE_SHIFT,
         |          ^~~~~~~~~
>> drivers/soc/qcom/icc-bwmon.c:472:22: error: 'BWMON_V5_IRQ_STATUS_ZONE_SHIFT' undeclared here (not in a function); did you mean 'BWMON_V4_IRQ_STATUS_ZONE_SHIFT'?
     472 |         .irq_shift = BWMON_V5_IRQ_STATUS_ZONE_SHIFT,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                      BWMON_V4_IRQ_STATUS_ZONE_SHIFT


vim +196 drivers/soc/qcom/icc-bwmon.c

   > 9	#include <linux/interrupt.h>
    10	#include <linux/io.h>
    11	#include <linux/kernel.h>
    12	#include <linux/module.h>
    13	#include <linux/of_device.h>
    14	#include <linux/platform_device.h>
    15	#include <linux/pm_opp.h>
    16	#include <linux/sizes.h>
    17	
    18	/*
    19	 * The BWMON samples data throughput within 'sample_ms' time. With three
    20	 * configurable thresholds (Low, Medium and High) gives four windows (called
    21	 * zones) of current bandwidth:
    22	 *
    23	 * Zone 0: byte count < THRES_LO
    24	 * Zone 1: THRES_LO < byte count < THRES_MED
    25	 * Zone 2: THRES_MED < byte count < THRES_HIGH
    26	 * Zone 3: THRES_HIGH < byte count
    27	 *
    28	 * Zones 0 and 2 are not used by this driver.
    29	 */
    30	
    31	/* Internal sampling clock frequency */
    32	#define HW_TIMER_HZ				19200000
    33	
    34	#define BWMON_V4_GLOBAL_IRQ_STATUS		0x0
    35	#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x8
    36	#define BWMON_V4_GLOBAL_IRQ_ENABLE		0xc
    37	#define BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE	BIT(0)
    38	
    39	#define BWMON_V4_IRQ_STATUS			0x100
    40	#define BWMON_V4_IRQ_STATUS_ZONE_SHIFT		4
  > 41	#define BWMON_V4_IRQ_CLEAR			0x108
    42	#define BWMON_V4_IRQ_ENABLE			0x10c
    43	#define BWMON_V4_IRQ_ENABLE_ZONE1_SHIFT		5
    44	#define BWMON_V4_IRQ_ENABLE_ZONE2_SHIFT		6
    45	#define BWMON_V4_IRQ_ENABLE_ZONE3_SHIFT		7
    46	#define BWMON_V4_IRQ_ENABLE_MASK		(BIT(BWMON_V4_IRQ_ENABLE_ZONE1_SHIFT) | \
    47							 BIT(BWMON_V4_IRQ_ENABLE_ZONE3_SHIFT))
    48	#define BWMON_V5_IRQ_STATUS			0x00
    49	#define BWMON_V5_IRQ_CLEAR			0x08
    50	#define BWMON_V5_IRQ_ENABLE			0x0c
    51	
    52	#define BWMON_V4_ENABLE				0x2a0
    53	#define BWMON_V5_ENABLE				0x10
    54	#define BWMON_ENABLE_ENABLE			BIT(0)
    55	
    56	#define BWMON_V4_CLEAR				0x2a4
    57	#define BWMON_V5_CLEAR				0x14
    58	#define BWMON_CLEAR_CLEAR			BIT(0)
    59	
    60	#define BWMON_V4_SAMPLE_WINDOW			0x2a8
    61	#define BWMON_V5_SAMPLE_WINDOW			0x20
    62	
    63	#define BWMON_V4_THRESHOLD_HIGH			0x2ac
    64	#define BWMON_V4_THRESHOLD_MED			0x2b0
    65	#define BWMON_V4_THRESHOLD_LOW			0x2b4
    66	#define BWMON_V5_THRESHOLD_HIGH			0x24
    67	#define BWMON_V5_THRESHOLD_MED			0x28
    68	#define BWMON_V5_THRESHOLD_LOW			0x2c
    69	
    70	#define BWMON_V4_ZONE_ACTIONS			0x2b8
    71	#define BWMON_V5_ZONE_ACTIONS			0x30
    72	/*
    73	 * Actions to perform on some zone 'z' when current zone hits the threshold:
    74	 * Increment counter of zone 'z'
    75	 */
    76	#define BWMON_ZONE_ACTIONS_INCREMENT(z)		(0x2 << ((z) * 2))
    77	/* Clear counter of zone 'z' */
    78	#define BWMON_ZONE_ACTIONS_CLEAR(z)		(0x1 << ((z) * 2))
    79	
    80	/* Zone 0 threshold hit: Clear zone count */
    81	#define BWMON_ZONE_ACTIONS_ZONE0		(BWMON_ZONE_ACTIONS_CLEAR(0))
    82	
    83	/* Zone 1 threshold hit: Increment zone count & clear lower zones */
    84	#define BWMON_ZONE_ACTIONS_ZONE1		(BWMON_ZONE_ACTIONS_INCREMENT(1) | \
    85							 BWMON_ZONE_ACTIONS_CLEAR(0))
    86	
    87	/* Zone 2 threshold hit: Increment zone count & clear lower zones */
    88	#define BWMON_ZONE_ACTIONS_ZONE2		(BWMON_ZONE_ACTIONS_INCREMENT(2) | \
    89							 BWMON_ZONE_ACTIONS_CLEAR(1) | \
    90							 BWMON_ZONE_ACTIONS_CLEAR(0))
    91	
    92	/* Zone 3 threshold hit: Increment zone count & clear lower zones */
    93	#define BWMON_ZONE_ACTIONS_ZONE3		(BWMON_ZONE_ACTIONS_INCREMENT(3) | \
    94							 BWMON_ZONE_ACTIONS_CLEAR(2) | \
    95							 BWMON_ZONE_ACTIONS_CLEAR(1) | \
    96							 BWMON_ZONE_ACTIONS_CLEAR(0))
    97	/* Value for BWMON_ZONE_ACTIONS */
    98	#define BWMON_ZONE_ACTIONS_DEFAULT		(BWMON_ZONE_ACTIONS_ZONE0 | \
    99							 BWMON_ZONE_ACTIONS_ZONE1 << 8 | \
   100							 BWMON_ZONE_ACTIONS_ZONE2 << 16 | \
   101							 BWMON_ZONE_ACTIONS_ZONE3 << 24)
   102	
   103	/*
   104	 * There is no clear documentation/explanation of BWMON_V4_THRESHOLD_COUNT
   105	 * register. Based on observations, this is number of times one threshold has to
   106	 * be reached, to trigger interrupt in given zone.
   107	 *
   108	 * 0xff are maximum values meant to ignore the zones 0 and 2.
   109	 */
   110	#define BWMON_V4_THRESHOLD_COUNT		0x2bc
   111	#define BWMON_V5_THRESHOLD_COUNT		0x34
   112	#define BWMON_THRESHOLD_COUNT_ZONE1_SHIFT	8
   113	#define BWMON_THRESHOLD_COUNT_ZONE2_SHIFT	16
   114	#define BWMON_THRESHOLD_COUNT_ZONE3_SHIFT	24
   115	#define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xff
   116	#define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT	0xff
   117	
   118	#define BWMON_V4_ZONE_MAX			0x2e0
   119	#define BWMON_V5_ZONE_MAX			0x44
   120	#define BWMON_REG_ZONE_MAX(bwmon, zone)		(BWMON_REG((bwmon), zone_max_reg) \
   121							 + 4 * (zone))
   122	
   123	#define BWMON_REG(bwmon, reg)			((bwmon)->base + (bwmon)->data->reg)
   124	
   125	struct icc_bwmon_data {
   126		unsigned int sample_ms;
   127		unsigned int count_unit_kb; /* kbytes */
   128		unsigned int default_highbw_kbps;
   129		unsigned int default_medbw_kbps;
   130		unsigned int default_lowbw_kbps;
   131		u8 zone1_thres_count;
   132		u8 zone3_thres_count;
   133		bool has_global_irq;
   134		u32 global_irq_status_reg;
   135		u32 global_irq_clear_reg;
   136		u32 global_irq_enable_reg;
   137		u32 irq_status_reg;
   138		u32 irq_clear_reg;
   139		u32 irq_enable_reg;
   140		u32 irq_status_mask;
   141		u32 irq_status_shift;
   142		u32 enable_reg;
   143		u32 clear_reg;
   144		u32 sample_window_reg;
   145		u32 threshold_high_reg;
   146		u32 threshold_med_reg;
   147		u32 threshold_low_reg;
   148		u32 threshold_count_reg;
   149		u32 zone_actions_reg;
   150		u32 zone_max_reg;
   151	};
   152	
   153	struct icc_bwmon {
   154		struct device *dev;
   155		const struct icc_bwmon_data *data;
   156		void __iomem *base;
   157		int irq;
   158	
   159		unsigned int max_bw_kbps;
   160		unsigned int min_bw_kbps;
   161		unsigned int target_kbps;
   162		unsigned int current_kbps;
   163	};
   164	
   165	static void bwmon_clear_counters(struct icc_bwmon *bwmon)
   166	{
   167		/*
   168		 * Clear counters. The order and barriers are
   169		 * important. Quoting downstream Qualcomm msm-4.9 tree:
   170		 *
   171		 * The counter clear and IRQ clear bits are not in the same 4KB
   172		 * region. So, we need to make sure the counter clear is completed
   173		 * before we try to clear the IRQ or do any other counter operations.
   174		 */
   175		writel(BWMON_CLEAR_CLEAR, BWMON_REG(bwmon, clear_reg));
   176	}
   177	
   178	static void bwmon_clear_irq(struct icc_bwmon *bwmon)
   179	{
   180		/*
   181		 * Clear zone and global interrupts. The order and barriers are
   182		 * important. Quoting downstream Qualcomm msm-4.9 tree:
   183		 *
   184		 * Synchronize the local interrupt clear in mon_irq_clear()
   185		 * with the global interrupt clear here. Otherwise, the CPU
   186		 * may reorder the two writes and clear the global interrupt
   187		 * before the local interrupt, causing the global interrupt
   188		 * to be retriggered by the local interrupt still being high.
   189		 *
   190		 * Similarly, because the global registers are in a different
   191		 * region than the local registers, we need to ensure any register
   192		 * writes to enable the monitor after this call are ordered with the
   193		 * clearing here so that local writes don't happen before the
   194		 * interrupt is cleared.
   195		 */
 > 196		writel(bwmon->data->irq_mask, BWMON_REG(bwmon, irq_clear_reg));
   197		if (bwmon->data->has_global_irq)
   198			writel(BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE,
   199			       BWMON_REG(bwmon, global_irq_clear_reg));
   200	}
   201	
   202	static void bwmon_disable(struct icc_bwmon *bwmon)
   203	{
   204		/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
   205		if (bwmon->data->has_global_irq)
   206			writel(0x0, BWMON_REG(bwmon, global_irq_enable_reg));
   207		writel(0x0, BWMON_REG(bwmon, irq_enable_reg));
   208	
   209		/*
   210		 * Disable bwmon. Must happen before bwmon_clear_irq() to avoid spurious
   211		 * IRQ.
   212		 */
   213		writel(0x0, BWMON_REG(bwmon, enable_reg));
   214	}
   215	
   216	static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
   217	{
   218		/* Enable interrupts */
   219		if (bwmon->data->has_global_irq)
   220			writel(BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE,
   221			       BWMON_REG(bwmon, global_irq_enable_reg));
   222		writel(irq_enable, BWMON_REG(bwmon, irq_enable_reg));
   223	
   224		/* Enable bwmon */
   225		writel(BWMON_ENABLE_ENABLE, BWMON_REG(bwmon, enable_reg));
   226	}
   227	
   228	static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon, unsigned int kbps)
   229	{
   230		return kbps / bwmon->data->count_unit_kb;
   231	}
   232	
   233	static void bwmon_set_threshold(struct icc_bwmon *bwmon,
   234					volatile void __iomem *addr, unsigned int kbps)
   235	{
   236		unsigned int thres;
   237	
   238		thres = mult_frac(bwmon_kbps_to_count(bwmon, kbps), bwmon->data->sample_ms,
   239				  MSEC_PER_SEC);
   240		writel_relaxed(thres, addr);
   241	}
   242	
   243	static void bwmon_start(struct icc_bwmon *bwmon)
   244	{
   245		const struct icc_bwmon_data *data = bwmon->data;
   246		unsigned int thres_count;
   247		int window;
   248	
   249		bwmon_clear_counters(bwmon);
   250	
   251		window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
   252		/* Maximum sampling window: 0xfffff */
   253		writel_relaxed(window, BWMON_REG(bwmon, sample_window_reg));
   254	
   255		bwmon_set_threshold(bwmon, BWMON_REG(bwmon, threshold_high_reg),
   256				    data->default_highbw_kbps);
   257		bwmon_set_threshold(bwmon, BWMON_REG(bwmon, threshold_med_reg),
   258				    data->default_medbw_kbps);
   259		bwmon_set_threshold(bwmon, BWMON_REG(bwmon, threshold_low_reg),
   260				    data->default_lowbw_kbps);
   261	
   262		thres_count = data->zone3_thres_count << BWMON_THRESHOLD_COUNT_ZONE3_SHIFT |
   263			      BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT << BWMON_THRESHOLD_COUNT_ZONE2_SHIFT |
   264			      data->zone1_thres_count << BWMON_THRESHOLD_COUNT_ZONE1_SHIFT |
   265			      BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT;
   266		writel_relaxed(thres_count,
   267			       BWMON_REG(bwmon, threshold_count_reg));
   268		writel_relaxed(BWMON_ZONE_ACTIONS_DEFAULT,
   269			       BWMON_REG(bwmon, zone_actions_reg));
   270		/* Write barriers in bwmon_clear_irq() */
   271	
   272		bwmon_clear_irq(bwmon);
 > 273		bwmon_enable(bwmon, bwmon->data->irq_mask);
   274	}
   275	
   276	static irqreturn_t bwmon_intr(int irq, void *dev_id)
   277	{
   278		struct icc_bwmon *bwmon = dev_id;
   279		unsigned int status, max;
   280		int zone;
   281	
   282		status = readl(BWMON_REG(bwmon, irq_status_reg));
   283		status &= bwmon->data->irq_mask;
   284		if (!status) {
   285			/*
   286			 * Only zone 1 and zone 3 interrupts are enabled but zone 2
   287			 * threshold could be hit and trigger interrupt even if not
   288			 * enabled.
   289			 * Such spurious interrupt might come with valuable max count or
   290			 * not, so solution would be to always check all
   291			 * BWMON_ZONE_MAX() registers to find the highest value.
   292			 * Such case is currently ignored.
   293			 */
   294			return IRQ_NONE;
   295		}
   296	
   297		bwmon_disable(bwmon);
   298	
 > 299		zone = get_bitmask_order(status >> bwmon->data->irq_shift) - 1;
   300		pr_err("AAA bwmon 0x%x -> zone %d-%d\n", status,
   301		       get_bitmask_order(status >> BWMON_V4_IRQ_STATUS_ZONE_SHIFT), zone);
   302	
   303		/*
   304		 * Zone max bytes count register returns count units within sampling
   305		 * window.  Downstream kernel for BWMONv4 (called BWMON type 2 in
   306		 * downstream) always increments the max bytes count by one.
   307		 */
   308		max = readl(BWMON_REG_ZONE_MAX(bwmon, zone)) + 1;
   309		max *= bwmon->data->count_unit_kb;
   310		bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
   311	
   312		return IRQ_WAKE_THREAD;
   313	}
   314	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
