Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF8569088
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGFRVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiGFRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:21:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341241D326
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657128077; x=1688664077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LhXrWWvYnUqkX7TzLt9/skPJ6SEYWxFlcnGeYF3kcN0=;
  b=f3wNavEz04UmvF6pfonC3Geer+ZOkrNbEPeaPMl97H8nBt7/aF4hIQBc
   6o4ep/wbPwvmBvtkSh2wo5VHOhlxJH1WiHmAyT+dpWm3miNDqXuAb9Qkc
   K7toDdPLxAnR7lpslsXxh44hAskMBRKDeVSHjFtWWRyMZN7YlTnm5m5wT
   +Ei9ooV8qlIvDxyXHbOXKNkn3W3f1tsK2NcuPcfUuTE6XmQNOnhrwYmuJ
   cP6X9Tvx/eJ7eCz4CLJBBJNOB8Qx9JxnhBVnohLjHGkpn73bVOGRLyNAn
   JLW3wmWXDMyDnsygdav4IX4IkVjIFj71u16gyCN7oBPAN0baoT383obDc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347802033"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="347802033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="735651861"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2022 10:21:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o98iA-000Kpx-Er;
        Wed, 06 Jul 2022 17:21:14 +0000
Date:   Thu, 7 Jul 2022 01:21:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:350
 msm_dsi_dphy_timing_calc_v3() warn: inconsistent indenting
Message-ID: <202207070115.5JsGmGry-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e35e5b6f695d241ffb1d223207da58a1fbcdff4b
commit: b3ed524f84f573ece1aa2f26e9db3c34a593e0d1 drm/msm: allow compile_test on !ARM
date:   9 months ago
config: csky-randconfig-m031-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070115.5JsGmGry-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:350 msm_dsi_dphy_timing_calc_v3() warn: inconsistent indenting
drivers/gpu/drm/msm/dsi/dsi_host.c:2380 msm_dsi_host_power_on() warn: missing error code 'ret'

Old smatch warnings:
drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:812 msm_dsi_phy_enable() warn: variable dereferenced before check 'phy' (see line 809)

vim +350 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c

a4df68fa232e97 Hai Li        2017-01-03  260  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  261  int msm_dsi_dphy_timing_calc_v3(struct msm_dsi_dphy_timing *timing,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  262  	struct msm_dsi_phy_clk_request *clk_req)
f1fa7ff4405697 Abhinav Kumar 2018-04-17  263  {
f1fa7ff4405697 Abhinav Kumar 2018-04-17  264  	const unsigned long bit_rate = clk_req->bitclk_rate;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  265  	const unsigned long esc_rate = clk_req->escclk_rate;
7264af3ed8d409 zhengbin      2019-10-10  266  	s32 ui, ui_x8;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  267  	s32 tmax, tmin;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  268  	s32 pcnt0 = 50;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  269  	s32 pcnt1 = 50;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  270  	s32 pcnt2 = 10;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  271  	s32 pcnt3 = 30;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  272  	s32 pcnt4 = 10;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  273  	s32 pcnt5 = 2;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  274  	s32 coeff = 1000; /* Precision, should avoid overflow */
f1fa7ff4405697 Abhinav Kumar 2018-04-17  275  	s32 hb_en, hb_en_ckln;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  276  	s32 temp;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  277  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  278  	if (!bit_rate || !esc_rate)
f1fa7ff4405697 Abhinav Kumar 2018-04-17  279  		return -EINVAL;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  280  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  281  	timing->hs_halfbyte_en = 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  282  	hb_en = 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  283  	timing->hs_halfbyte_en_ckln = 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  284  	hb_en_ckln = 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  285  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  286  	ui = mult_frac(NSEC_PER_MSEC, coeff, bit_rate / 1000);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  287  	ui_x8 = ui << 3;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  288  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  289  	temp = S_DIV_ROUND_UP(38 * coeff, ui_x8);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  290  	tmin = max_t(s32, temp, 0);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  291  	temp = (95 * coeff) / ui_x8;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  292  	tmax = max_t(s32, temp, 0);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  293  	timing->clk_prepare = linear_inter(tmax, tmin, pcnt0, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  294  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  295  	temp = 300 * coeff - (timing->clk_prepare << 3) * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  296  	tmin = S_DIV_ROUND_UP(temp, ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  297  	tmax = (tmin > 255) ? 511 : 255;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  298  	timing->clk_zero = linear_inter(tmax, tmin, pcnt5, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  299  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  300  	tmin = DIV_ROUND_UP(60 * coeff + 3 * ui, ui_x8);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  301  	temp = 105 * coeff + 12 * ui - 20 * coeff;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  302  	tmax = (temp + 3 * ui) / ui_x8;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  303  	timing->clk_trail = linear_inter(tmax, tmin, pcnt3, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  304  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  305  	temp = S_DIV_ROUND_UP(40 * coeff + 4 * ui, ui_x8);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  306  	tmin = max_t(s32, temp, 0);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  307  	temp = (85 * coeff + 6 * ui) / ui_x8;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  308  	tmax = max_t(s32, temp, 0);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  309  	timing->hs_prepare = linear_inter(tmax, tmin, pcnt1, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  310  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  311  	temp = 145 * coeff + 10 * ui - (timing->hs_prepare << 3) * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  312  	tmin = S_DIV_ROUND_UP(temp, ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  313  	tmax = 255;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  314  	timing->hs_zero = linear_inter(tmax, tmin, pcnt4, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  315  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  316  	tmin = DIV_ROUND_UP(60 * coeff + 4 * ui, ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  317  	temp = 105 * coeff + 12 * ui - 20 * coeff;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  318  	tmax = (temp / ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  319  	timing->hs_trail = linear_inter(tmax, tmin, pcnt3, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  320  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  321  	temp = 50 * coeff + ((hb_en << 2) - 8) * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  322  	timing->hs_rqst = S_DIV_ROUND_UP(temp, ui_x8);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  323  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  324  	tmin = DIV_ROUND_UP(100 * coeff, ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  325  	tmax = 255;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  326  	timing->hs_exit = linear_inter(tmax, tmin, pcnt2, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  327  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  328  	temp = 50 * coeff + ((hb_en_ckln << 2) - 8) * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  329  	timing->hs_rqst_ckln = S_DIV_ROUND_UP(temp, ui_x8);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  330  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  331  	temp = 60 * coeff + 52 * ui - 43 * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  332  	tmin = DIV_ROUND_UP(temp, ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  333  	tmax = 63;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  334  	timing->shared_timings.clk_post =
f1fa7ff4405697 Abhinav Kumar 2018-04-17  335  		linear_inter(tmax, tmin, pcnt2, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  336  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  337  	temp = 8 * ui + (timing->clk_prepare << 3) * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  338  	temp += (((timing->clk_zero + 3) << 3) + 11) * ui;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  339  	temp += hb_en_ckln ? (((timing->hs_rqst_ckln << 3) + 4) * ui) :
f1fa7ff4405697 Abhinav Kumar 2018-04-17  340  		(((timing->hs_rqst_ckln << 3) + 8) * ui);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  341  	tmin = S_DIV_ROUND_UP(temp, ui_x8) - 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  342  	tmax = 63;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  343  	if (tmin > tmax) {
f1fa7ff4405697 Abhinav Kumar 2018-04-17  344  		temp = linear_inter(tmax << 1, tmin, pcnt2, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  345  		timing->shared_timings.clk_pre = temp >> 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  346  		timing->shared_timings.clk_pre_inc_by_2 = 1;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  347  	} else {
f1fa7ff4405697 Abhinav Kumar 2018-04-17  348  		timing->shared_timings.clk_pre =
f1fa7ff4405697 Abhinav Kumar 2018-04-17  349  			linear_inter(tmax, tmin, pcnt2, 0, false);
f1fa7ff4405697 Abhinav Kumar 2018-04-17 @350  			timing->shared_timings.clk_pre_inc_by_2 = 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  351  	}
f1fa7ff4405697 Abhinav Kumar 2018-04-17  352  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  353  	timing->ta_go = 3;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  354  	timing->ta_sure = 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  355  	timing->ta_get = 4;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  356  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  357  	DBG("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d",
f1fa7ff4405697 Abhinav Kumar 2018-04-17  358  		timing->shared_timings.clk_pre, timing->shared_timings.clk_post,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  359  		timing->shared_timings.clk_pre_inc_by_2, timing->clk_zero,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  360  		timing->clk_trail, timing->clk_prepare, timing->hs_exit,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  361  		timing->hs_zero, timing->hs_prepare, timing->hs_trail,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  362  		timing->hs_rqst, timing->hs_rqst_ckln, timing->hs_halfbyte_en,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  363  		timing->hs_halfbyte_en_ckln, timing->hs_prep_dly,
f1fa7ff4405697 Abhinav Kumar 2018-04-17  364  		timing->hs_prep_dly_ckln);
f1fa7ff4405697 Abhinav Kumar 2018-04-17  365  
f1fa7ff4405697 Abhinav Kumar 2018-04-17  366  	return 0;
f1fa7ff4405697 Abhinav Kumar 2018-04-17  367  }
f1fa7ff4405697 Abhinav Kumar 2018-04-17  368  

:::::: The code at line 350 was first introduced by commit
:::::: f1fa7ff4405697603f5e3901623533c54091f130 drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY

:::::: TO: Abhinav Kumar <abhinavk@codeaurora.org>
:::::: CC: Rob Clark <robdclark@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
