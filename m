Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F9596592
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiHPWjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHPWjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:39:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67F75CFD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660689546; x=1692225546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m7c7Fs6R5py4GXf86x8msd14LwMwnR43UjaTVq7j+9g=;
  b=f9wujHaa+QvadfGRXGAsly6M9z5KHuaQTnCOzeQVWKx7qNm5OSxxCPlj
   mXklpg5gy/M1+jjqXKrlcT3vOB0jWPrVSOUm+Uz+JRxBsVKwWp7CPkzn5
   mMnBDTUIaGZzi0rcLBcpwkkvsG0MLPgeCO014Z8eQP4+4Qq2ley0q2hUR
   bK2i/u5z8A1hUM7kUoSJFxkyBGyM0TxXqjh0peBPF1IA4GugJnvz+Cy66
   50l8xL9lglIMaLInvuoASjNna44jOjdNo1VlSK02A4nWk0zUl/4HGbNFq
   t/LU+/ceE16n8ui/nRLvGXtozhRssgqhwDgTWZJoGgchuKMR2oe5KlkWj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318345573"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="318345573"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696546767"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2022 15:39:03 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO5DC-0000ID-2H;
        Tue, 16 Aug 2022 22:39:02 +0000
Date:   Wed, 17 Aug 2022 06:38:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 12/16] sound/soc/codecs/cs42l84.c:264:3:
 error: field designator 'non_legacy_dai_naming' does not refer to any field
 in type 'const struct snd_soc_component_driver'; did you mean
 'legacy_dai_naming'?
Message-ID: <202208170629.HwT2PwG2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   51024ef467ff6c288e679bc72d0e3fcdd54d9b39
commit: a97f70c444c0cb9842bc778c3c1def0142b2b8bf [12/16] wip: ASoC: cs42l84: Start new codec driver
config: arm-randconfig-r033-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170629.HwT2PwG2-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/AsahiLinux/linux/commit/a97f70c444c0cb9842bc778c3c1def0142b2b8bf
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout a97f70c444c0cb9842bc778c3c1def0142b2b8bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> sound/soc/codecs/cs42l84.c:244:5: warning: no previous prototype for function 'cs42l84_component_probe' [-Wmissing-prototypes]
   int cs42l84_component_probe(struct snd_soc_component *component)
       ^
   sound/soc/codecs/cs42l84.c:244:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int cs42l84_component_probe(struct snd_soc_component *component)
   ^
   static 
>> sound/soc/codecs/cs42l84.c:264:3: error: field designator 'non_legacy_dai_naming' does not refer to any field in type 'const struct snd_soc_component_driver'; did you mean 'legacy_dai_naming'?
           .non_legacy_dai_naming  = 1,
            ^~~~~~~~~~~~~~~~~~~~~
            legacy_dai_naming
   include/sound/soc-component.h:182:15: note: 'legacy_dai_naming' declared here
           unsigned int legacy_dai_naming:1;
                        ^
>> sound/soc/codecs/cs42l84.c:328:3: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   FIELD_PREP(CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO, fsync & 0x7f));
                   ^
   sound/soc/codecs/cs42l84.c:517:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                                                           CS42L84_CCM_CTL1_RCO);
                                                                           ^
   sound/soc/codecs/cs42l84.h:59:3: note: expanded from macro 'CS42L84_CCM_CTL1_RCO'
           (FIELD_PREP(CS42L84_CCM_CTL1_MCLK_SRC, CS42L84_CCM_CTL1_MCLK_SRC_RCO) \
            ^
   sound/soc/codecs/cs42l84.c:563:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                           FIELD_PREP(CS42L84_CCM_CTL1_MCLK_SRC, CS42L84_CCM_CTL1_MCLK_SRC_PLL)
                                           ^
   sound/soc/codecs/cs42l84.c:570:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                           FIELD_PREP(CS42L84_CCM_CTL1_MCLK_SRC, CS42L84_CCM_CTL1_MCLK_SRC_BCLK)
                                           ^
   sound/soc/codecs/cs42l84.c:637:3: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   FIELD_PREP(CS42L84_MISC_DET_CTL_HSBIAS_CTL, 3) | /* 2.7 V */
                   ^
   sound/soc/codecs/cs42l84.c:713:3: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   FIELD_PREP(CS42L84_MISC_DET_CTL_HSBIAS_CTL, 1) | /* 0.0 V */
                   ^
   sound/soc/codecs/cs42l84.c:823:4: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           FIELD_PREP(CS42L84_TIP_SENSE_CTL2_MODE, CS42L84_TIP_SENSE_CTL2_MODE_SHORT_DET));
                           ^
   1 warning and 8 errors generated.


vim +264 sound/soc/codecs/cs42l84.c

   243	
 > 244	int cs42l84_component_probe(struct snd_soc_component *component)
   245	{
   246		snd_soc_component_update_bits(component, CS42L84_ASP_CTL,
   247					      CS42L84_ASP_CTL_TDM_MODE, 0);
   248		snd_soc_component_update_bits(component, CS42L84_HP_VOL_CTL,
   249					      CS42L84_HP_VOL_CTL_SOFT | CS42L84_HP_VOL_CTL_ZERO_CROSS,
   250					      CS42L84_HP_VOL_CTL_ZERO_CROSS);
   251	
   252		return 0;
   253	}
   254	
   255	static const struct snd_soc_component_driver soc_component_dev_cs42l84 = {
   256		.probe			= cs42l84_component_probe,
   257		.controls			= cs42l84_snd_controls,
   258		.num_controls		= ARRAY_SIZE(cs42l84_snd_controls),
   259		.dapm_widgets		= cs42l84_dapm_widgets,
   260		.num_dapm_widgets	= ARRAY_SIZE(cs42l84_dapm_widgets),
   261		.dapm_routes		= cs42l84_audio_map,
   262		.num_dapm_routes	= ARRAY_SIZE(cs42l84_audio_map),
   263		.endianness		= 1,
 > 264		.non_legacy_dai_naming	= 1,
   265	};
   266	
   267	struct cs42l84_pll_params {
   268		u32 bclk;
   269		u8 mclk_src_sel;
   270		u8 bclk_prediv;
   271		u8 pll_div_int;
   272		u32 pll_div_frac;
   273		u8 pll_mode;
   274		u8 pll_divout;
   275		u32 mclk_int;
   276	};
   277	
   278	/*
   279	 * Common PLL Settings for given BCLK
   280	 */
   281	static const struct cs42l84_pll_params pll_ratio_table[] = {
   282		{  3072000, 1, 0, 0x40, 0x000000, 0x03, 0x10, 12288000},
   283		{  6144000, 1, 1, 0x40, 0x000000, 0x03, 0x10, 12288000},
   284		{ 12288000, 0, 0, 0, 0, 0, 0,                 12288000},
   285		{ 24576000, 1, 3, 0x40, 0x000000, 0x03, 0x10, 12288000},
   286	};
   287	
   288	static int cs42l84_pll_config(struct snd_soc_component *component)
   289	{
   290		struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
   291		int i;
   292		u32 clk;
   293		u32 fsync;
   294	
   295		clk = cs42l84->bclk;
   296	
   297		/* Don't reconfigure if there is an audio stream running */
   298		if (cs42l84->stream_use) {
   299			if (pll_ratio_table[cs42l84->pll_config].bclk == clk)
   300				return 0;
   301			else
   302				return -EBUSY;
   303		}
   304	
   305		for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
   306			if (pll_ratio_table[i].bclk == clk) {
   307				cs42l84->pll_config = i;
   308				break;
   309			}
   310		}
   311	
   312		if (i == ARRAY_SIZE(pll_ratio_table))
   313			return -EINVAL;
   314	
   315		/* Set up the LRCLK */
   316		fsync = clk / cs42l84->srate;
   317		if (((fsync * cs42l84->srate) != clk)
   318				|| ((fsync % 2) != 0)) {
   319			dev_err(component->dev,
   320				"Unsupported bclk %d/sample rate %d\n",
   321				clk, cs42l84->srate);
   322			return -EINVAL;
   323		}
   324	
   325		/* Set the LRCLK period */
   326		snd_soc_component_update_bits(component, CS42L84_ASP_FSYNC_CTL2,
   327			CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO,
 > 328			FIELD_PREP(CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO, fsync & 0x7f));
   329		snd_soc_component_update_bits(component, CS42L84_ASP_FSYNC_CTL3,
   330			CS42L84_ASP_FSYNC_CTL3_BCLK_PERIOD_HI,
   331			FIELD_PREP(CS42L84_ASP_FSYNC_CTL3_BCLK_PERIOD_HI, fsync >> 7));
   332	
   333		/* Save what the MCLK will be */
   334		switch (pll_ratio_table[i].mclk_int) {
   335		case 12000000:
   336			cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_12MHZ;
   337			break;
   338		case 12288000:
   339			cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_12_288KHZ;
   340			break;
   341		case 24000000:
   342			cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_24MHZ;
   343			break;
   344		case 24576000:
   345			cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_24_576KHZ;
   346			break;
   347		}
   348	
   349		if (pll_ratio_table[i].mclk_src_sel) {
   350			/* Configure PLL */
   351			snd_soc_component_update_bits(component,
   352				CS42L84_CCM_CTL3, CS42L84_CCM_CTL3_REFCLK_DIV,
   353				FIELD_PREP(CS42L84_CCM_CTL3_REFCLK_DIV, pll_ratio_table[i].bclk_prediv));
   354			snd_soc_component_write(component,
   355				CS42L84_PLL_DIV_INT,
   356				pll_ratio_table[i].pll_div_int);
   357			snd_soc_component_write(component,
   358				CS42L84_PLL_DIV_FRAC0,
   359				pll_ratio_table[i].pll_div_frac);
   360			snd_soc_component_write(component,
   361				CS42L84_PLL_DIV_FRAC1,
   362				pll_ratio_table[i].pll_div_frac >> 8);
   363			snd_soc_component_write(component,
   364				CS42L84_PLL_DIV_FRAC2,
   365				pll_ratio_table[i].pll_div_frac >> 16);
   366			snd_soc_component_update_bits(component,
   367				CS42L84_PLL_CTL1, CS42L84_PLL_CTL1_MODE,
   368				FIELD_PREP(CS42L84_PLL_CTL1_MODE, pll_ratio_table[i].pll_mode));
   369			snd_soc_component_write(component,
   370				CS42L84_PLL_DIVOUT,
   371				pll_ratio_table[i].pll_divout);
   372	
   373			snd_soc_component_update_bits(component,
   374				CS42L84_PLL_CTL1, CS42L84_PLL_CTL1_EN,
   375				CS42L84_PLL_CTL1_EN);
   376		}
   377	
   378		return 0;
   379	}
   380	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
