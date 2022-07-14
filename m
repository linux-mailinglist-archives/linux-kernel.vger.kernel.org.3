Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340FE574193
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiGNCyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:53:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AA1EAF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657767237; x=1689303237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uXBr+b7nuMPC6o7bPr1dKJ2/w9t4hZ+yDBweFmqEdiU=;
  b=PaVMvUqu/XaN6uqru4sBURWwWatZVQbOczwYJIPBx1q0/sZ7trlfgC5A
   H1hKir3Z97BaMdTe/lc5cWtcovYPvNUFTwbYqJwsCmNOMJX/8mw6ZLRFy
   /aPyS5ZNd9z/kiSCq0J3ySXEWYi0yRYSFG8ZhdfnXDq8P8b4dY4QJJ3Xe
   iHN8CZu4VoBwiASVdorrjAEnhxohDYZlFAnN6HCcplfLuEVyIW4rB7YEX
   SZqTMIV4KwyHPdeOhhZw+i/C6eBoEMjAcslwQC2py5TuT2OdIha1+qUHB
   VfLmB1LKRq8nUSZR9l5XPUXQvKenN7Ct573QBG/nTy6RETfFIH2F50jMO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265810872"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265810872"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="546093778"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2022 19:53:55 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBozC-00005a-9V;
        Thu, 14 Jul 2022 02:53:54 +0000
Date:   Thu, 14 Jul 2022 10:53:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-bwmon-llcc-manual-regmap 21/21]
 drivers/soc/qcom/icc-bwmon.c:196:22: error: no member named 'irq_mask' in
 'struct icc_bwmon_data'
Message-ID: <202207141006.2vNwc0fD-lkp@intel.com>
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

tree:   https://github.com/krzk/linux n/qcom-bwmon-llcc-manual-regmap
head:   f8c2f9796ac481bfd123096df5dd4d9f570c57b6
commit: f8c2f9796ac481bfd123096df5dd4d9f570c57b6 [21/21] wip
config: hexagon-buildonly-randconfig-r001-20220714 (https://download.01.org/0day-ci/archive/20220714/202207141006.2vNwc0fD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/f8c2f9796ac481bfd123096df5dd4d9f570c57b6
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-bwmon-llcc-manual-regmap
        git checkout f8c2f9796ac481bfd123096df5dd4d9f570c57b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/icc-bwmon.c:196:22: error: no member named 'irq_mask' in 'struct icc_bwmon_data'
           writel(bwmon->data->irq_mask, BWMON_REG(bwmon, irq_clear_reg));
                  ~~~~~~~~~~~  ^
   drivers/soc/qcom/icc-bwmon.c:273:35: error: no member named 'irq_mask' in 'struct icc_bwmon_data'
           bwmon_enable(bwmon, bwmon->data->irq_mask);
                               ~~~~~~~~~~~  ^
   drivers/soc/qcom/icc-bwmon.c:283:25: error: no member named 'irq_mask' in 'struct icc_bwmon_data'
           status &= bwmon->data->irq_mask;
                     ~~~~~~~~~~~  ^
>> drivers/soc/qcom/icc-bwmon.c:299:50: error: no member named 'irq_shift' in 'struct icc_bwmon_data'
           zone = get_bitmask_order(status >> bwmon->data->irq_shift) - 1;
                                              ~~~~~~~~~~~  ^
   drivers/soc/qcom/icc-bwmon.c:344:29: error: no member named 'irq_mask' in 'struct icc_bwmon_data'
                   irq_enable = bwmon->data->irq_mask;
                                ~~~~~~~~~~~  ^
>> drivers/soc/qcom/icc-bwmon.c:445:3: error: field designator 'irq_mask' does not refer to any field in type 'const struct icc_bwmon_data'
           .irq_mask = BWMON_V4_IRQ_ENABLE_MASK,
            ^
>> drivers/soc/qcom/icc-bwmon.c:446:3: error: field designator 'irq_shift' does not refer to any field in type 'const struct icc_bwmon_data'
           .irq_shift = BWMON_V4_IRQ_STATUS_ZONE_SHIFT,
            ^
>> drivers/soc/qcom/icc-bwmon.c:471:14: error: use of undeclared identifier 'BWMON_V5_IRQ_ENABLE_MASK'
           .irq_mask = BWMON_V5_IRQ_ENABLE_MASK,
                       ^
>> drivers/soc/qcom/icc-bwmon.c:472:15: error: use of undeclared identifier 'BWMON_V5_IRQ_STATUS_ZONE_SHIFT'
           .irq_shift = BWMON_V5_IRQ_STATUS_ZONE_SHIFT,
                        ^
   9 errors generated.


vim +196 drivers/soc/qcom/icc-bwmon.c

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
   273		bwmon_enable(bwmon, bwmon->data->irq_mask);
   274	}
   275	
   276	static irqreturn_t bwmon_intr(int irq, void *dev_id)
   277	{
   278		struct icc_bwmon *bwmon = dev_id;
   279		unsigned int status, max;
   280		int zone;
   281	
   282		status = readl(BWMON_REG(bwmon, irq_status_reg));
 > 283		status &= bwmon->data->irq_mask;
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
   315	static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
   316	{
   317		struct icc_bwmon *bwmon = dev_id;
   318		unsigned int irq_enable = 0;
   319		struct dev_pm_opp *opp, *target_opp;
   320		unsigned int bw_kbps, up_kbps, down_kbps;
   321	
   322		bw_kbps = bwmon->target_kbps;
   323	
   324		target_opp = dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_kbps, 0);
   325		if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
   326			target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
   327	
   328		bwmon->target_kbps = bw_kbps;
   329	
   330		bw_kbps--;
   331		opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
   332		if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
   333			down_kbps = bwmon->target_kbps;
   334		else
   335			down_kbps = bw_kbps;
   336	
   337		up_kbps = bwmon->target_kbps + 1;
   338	
   339		if (bwmon->target_kbps >= bwmon->max_bw_kbps)
   340			irq_enable = BIT(BWMON_V4_IRQ_ENABLE_ZONE1_SHIFT);
   341		else if (bwmon->target_kbps <= bwmon->min_bw_kbps)
   342			irq_enable = BIT(BWMON_V4_IRQ_ENABLE_ZONE3_SHIFT);
   343		else
 > 344			irq_enable = bwmon->data->irq_mask;
   345	
   346		bwmon_set_threshold(bwmon, BWMON_REG(bwmon, threshold_high_reg),
   347				    up_kbps);
   348		bwmon_set_threshold(bwmon, BWMON_REG(bwmon, threshold_med_reg),
   349				    down_kbps);
   350		/* Write barriers in bwmon_clear_counters() */
   351		bwmon_clear_counters(bwmon);
   352		bwmon_clear_irq(bwmon);
   353		bwmon_enable(bwmon, irq_enable);
   354	
   355		if (bwmon->target_kbps == bwmon->current_kbps)
   356			goto out;
   357	
   358		dev_pm_opp_set_opp(bwmon->dev, target_opp);
   359		bwmon->current_kbps = bwmon->target_kbps;
   360	
   361	out:
   362		dev_pm_opp_put(target_opp);
   363		if (!IS_ERR(opp))
   364			dev_pm_opp_put(opp);
   365	
   366		return IRQ_HANDLED;
   367	}
   368	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
