Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF25AF841
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIFXJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIFXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:09:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E123A487
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662505792; x=1694041792;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x0NFdyvYM+FwF1hzAD4Ppd12hSABIkyJcT/FBDj+im0=;
  b=dX3lHFFrDhIukMvT8qaw7+QmSIbSWRMJd129jLXAZL+MkrAMGdoYOc6G
   V9fJzVIp9vqILhY1g4xoeCmMhguOO3ONQBLq1lupSbrjOPXYLLFBVBGnm
   CJ15ArO18ZbGi6tY37dm0cwlACR0pmb475KYZ407HoT9sS3f55ilgyRxo
   vddkj2SF+jVxbZDPD7FqaRifcaAPuCjlZ5Cd21JcaL2pCo9FX3gJ5QtxB
   NJ54TFBdRlki48MASkVyxzzAiqU341ZEnFCZdr0LM+ZE/ze+znqBAoMLL
   ucKq2rkoPdgKgFxbiNWxFGqcYS/VPc3ViXpJ/ydXqVb5eOh2fxzANLDcI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296731864"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296731864"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 16:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942655304"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 16:09:50 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVhhW-0005l1-0p;
        Tue, 06 Sep 2022 23:09:50 +0000
Date:   Wed, 7 Sep 2022 07:09:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mbgg-mediatek:v6.0-dev/svs-dev 21/23]
 drivers/soc/mediatek/mtk-svs-mt8183.c:5:5: warning: no previous prototype
 for function 'svs_mt8183_efuse_thermal_parsing'
Message-ID: <202209070624.eshq44iE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mbgg/linux-mediatek v6.0-dev/svs-dev
head:   996cb88cbd46222249a50da47fb7dc9fbe39623c
commit: 4fd7359457bb8c5e904f9ec22b465b5b188dc575 [21/23] soc: mtk-svs: mt8183: Move thermal parsing in new function
config: hexagon-randconfig-r002-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070624.eshq44iE-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mbgg/linux-mediatek/commit/4fd7359457bb8c5e904f9ec22b465b5b188dc575
        git remote add mbgg-mediatek https://github.com/mbgg/linux-mediatek
        git fetch --no-tags mbgg-mediatek v6.0-dev/svs-dev
        git checkout 4fd7359457bb8c5e904f9ec22b465b5b188dc575
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/mediatek/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/mediatek/mtk-svs-mt8183.c:5:5: warning: no previous prototype for function 'svs_mt8183_efuse_thermal_parsing' [-Wmissing-prototypes]
   int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
       ^
   drivers/soc/mediatek/mtk-svs-mt8183.c:5:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
   ^
   static 
   1 warning generated.


vim +/svs_mt8183_efuse_thermal_parsing +5 drivers/soc/mediatek/mtk-svs-mt8183.c

     4	
   > 5	int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
     6	{
     7		struct svs_bank *svsb;
     8		int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
     9		int adc_ge_t, adc_oe_t, ge, oe, gain, degc_cali, adc_cali_en_t;
    10		int o_slope, o_slope_sign, ts_id;
    11		u32 idx, i, mts, temp0, temp1, temp2;
    12	
    13		adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
    14		adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
    15	
    16		o_vtsmcu[0] = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
    17		o_vtsmcu[1] = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
    18		o_vtsmcu[2] = svsp->tefuse[1] & GENMASK(8, 0);
    19		o_vtsmcu[3] = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
    20		o_vtsmcu[4] = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
    21		o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
    22	
    23		degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
    24		adc_cali_en_t = svsp->tefuse[0] & BIT(0);
    25		o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
    26	
    27		ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
    28		o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
    29	
    30		if (adc_cali_en_t == 1) {
    31			if (!ts_id)
    32				o_slope = 0;
    33	
    34			if (adc_ge_t < 265 || adc_ge_t > 758 ||
    35			    adc_oe_t < 265 || adc_oe_t > 758 ||
    36			    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
    37			    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
    38			    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
    39			    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
    40			    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
    41			    o_vtsabb < -8 || o_vtsabb > 484 ||
    42			    degc_cali < 1 || degc_cali > 63) {
    43				dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
    44				return -1;
    45			}
    46		} else {
    47			dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
    48			return -1;
    49		}
    50	
    51		ge = ((adc_ge_t - 512) * 10000) / 4096;
    52		oe = (adc_oe_t - 512);
    53		gain = (10000 + ge);
    54	
    55		format[0] = (o_vtsmcu[0] + 3350 - oe);
    56		format[1] = (o_vtsmcu[1] + 3350 - oe);
    57		format[2] = (o_vtsmcu[2] + 3350 - oe);
    58		format[3] = (o_vtsmcu[3] + 3350 - oe);
    59		format[4] = (o_vtsmcu[4] + 3350 - oe);
    60		format[5] = (o_vtsabb + 3350 - oe);
    61	
    62		for (i = 0; i < 6; i++)
    63			x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / gain;
    64	
    65		temp0 = (10000 * 100000 / gain) * 15 / 18;
    66	
    67		if (!o_slope_sign)
    68			mts = (temp0 * 10) / (1534 + o_slope * 10);
    69		else
    70			mts = (temp0 * 10) / (1534 - o_slope * 10);
    71	
    72		for (idx = 0; idx < svsp->bank_max; idx++) {
    73			svsb = &svsp->banks[idx];
    74			svsb->mts = mts;
    75	
    76			switch (svsb->sw_id) {
    77			case SVSB_CPU_LITTLE:
    78				tb_roomt = x_roomt[3];
    79				break;
    80			case SVSB_CPU_BIG:
    81				tb_roomt = x_roomt[4];
    82				break;
    83			case SVSB_CCI:
    84				tb_roomt = x_roomt[3];
    85				break;
    86			case SVSB_GPU:
    87				tb_roomt = x_roomt[1];
    88				break;
    89			default:
    90				dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
    91				return -1;
    92			}
    93	
    94			temp0 = (degc_cali * 10 / 2);
    95			temp1 = ((10000 * 100000 / 4096 / gain) *
    96				 oe + tb_roomt * 10) * 15 / 18;
    97	
    98			if (!o_slope_sign)
    99				temp2 = temp1 * 100 / (1534 + o_slope * 10);
   100			else
   101				temp2 = temp1 * 100 / (1534 - o_slope * 10);
   102	
   103			svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
   104		}
   105	
   106		return 0;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
