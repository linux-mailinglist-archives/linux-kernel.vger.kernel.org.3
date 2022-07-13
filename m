Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A11572ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiGMBVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiGMBVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:21:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D657260
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657675302; x=1689211302;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kmvMLS/LL4cqnso4j5W94X1i3xyjPavi0Ddm8lsIVCU=;
  b=beh0CLKTPVamqTm8H6JqjW/09hGucMz7pJ+NqJzEoATy6t/iPUCnLbIW
   bU4j25b6612eGR4gZ9jw0cBhHxrDZ5bBcdJTeQHrmf9Oo8iiRtZ6D7hGU
   FSmAS1GR1o0i6e6WnVDTVRPqMMcs0HR5/i2TtAQMtCIakAJD+6AfXhMI7
   Rjg09m3bhPvBOisegyih5YodgwM3cDvNJnZZ2ry5UXPR8QAqv7mWB/gRx
   4aaz22gmdnh7cO17pRgUORRpUFvs+BcnxHDsI4qJnNz5yOynrWl5VQzPr
   HxN7jxQlv5GbIClc3zLEn1Ja92+6mz3EAhUcmA2mq4GQ6ZK4rrNUNaXaq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="282634062"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="282634062"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 18:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="545646122"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2022 18:21:40 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBR4N-0002up-St;
        Wed, 13 Jul 2022 01:21:39 +0000
Date:   Wed, 13 Jul 2022 09:21:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raphael-Xu <13691752556@139.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-next 368/430]
 sound/soc/codecs/tas2780.c:160:14: sparse: sparse: restricted
 snd_pcm_format_t degrades to integer
Message-ID: <202207130922.q9gFKYnC-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   f1416233aa125b29375bc2980e225e77b11d79f4
commit: eae9f9ce181be4f47dcba1ee93185b71cac3f312 [368/430] ASoC: add tas2780 driver
config: arm-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207130922.q9gFKYnC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/eae9f9ce181be4f47dcba1ee93185b71cac3f312
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout eae9f9ce181be4f47dcba1ee93185b71cac3f312
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/tas2780.c:160:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/codecs/tas2780.c:167:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/codecs/tas2780.c:174:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/codecs/tas2780.c:288:58: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int bitwidth @@     got restricted snd_pcm_format_t @@
   sound/soc/codecs/tas2780.c:288:58: sparse:     expected int bitwidth
   sound/soc/codecs/tas2780.c:288:58: sparse:     got restricted snd_pcm_format_t

vim +160 sound/soc/codecs/tas2780.c

   150	
   151	static int tas2780_set_bitwidth(struct tas2780_priv *tas2780, int bitwidth)
   152	{
   153		struct snd_soc_component *component = tas2780->component;
   154		int sense_en;
   155		int val;
   156		int ret;
   157		int slot_size;
   158	
   159		switch (bitwidth) {
 > 160		case SNDRV_PCM_FORMAT_S16_LE:
   161			ret = snd_soc_component_update_bits(component,
   162				TAS2780_TDM_CFG2,
   163				TAS2780_TDM_CFG2_RXW_MASK,
   164				TAS2780_TDM_CFG2_RXW_16BITS);
   165			slot_size = TAS2780_TDM_CFG2_RXS_16BITS;
   166			break;
   167		case SNDRV_PCM_FORMAT_S24_LE:
   168			ret = snd_soc_component_update_bits(component,
   169				TAS2780_TDM_CFG2,
   170				TAS2780_TDM_CFG2_RXW_MASK,
   171				TAS2780_TDM_CFG2_RXW_24BITS);
   172			slot_size = TAS2780_TDM_CFG2_RXS_24BITS;
   173			break;
   174		case SNDRV_PCM_FORMAT_S32_LE:
   175			ret = snd_soc_component_update_bits(component,
   176				TAS2780_TDM_CFG2,
   177				TAS2780_TDM_CFG2_RXW_MASK,
   178				TAS2780_TDM_CFG2_RXW_32BITS);
   179			slot_size = TAS2780_TDM_CFG2_RXS_32BITS;
   180			break;
   181	
   182		default:
   183			ret = -EINVAL;
   184		}
   185	
   186		if (ret < 0) {
   187			dev_err(tas2780->dev, "%s:errCode:0x%x set bitwidth error\n",
   188				__func__, ret);
   189			goto err;
   190		}
   191	
   192		ret = snd_soc_component_update_bits(component, TAS2780_TDM_CFG2,
   193			TAS2780_TDM_CFG2_RXS_MASK, slot_size);
   194		if (ret < 0) {
   195			dev_err(tas2780->dev,
   196				"%s:errCode:0x%x set RX slot size error\n",
   197				__func__, ret);
   198			goto err;
   199		}
   200	
   201		val = snd_soc_component_read(tas2780->component, TAS2780_PWR_CTRL);
   202		if (val < 0) {
   203			dev_err(tas2780->dev, "%s:errCode:0x%x read PWR_CTRL error\n",
   204				__func__, val);
   205			ret = val;
   206			goto err;
   207		}
   208	
   209		if (val & (1 << TAS2780_VSENSE_POWER_EN))
   210			sense_en = 0;
   211		else
   212			sense_en = TAS2780_TDM_CFG5_VSNS_ENABLE;
   213	
   214		ret = snd_soc_component_update_bits(tas2780->component,
   215			TAS2780_TDM_CFG5, TAS2780_TDM_CFG5_VSNS_ENABLE, sense_en);
   216		if (ret < 0) {
   217			dev_err(tas2780->dev, "%s:errCode:0x%x enable vSNS error\n",
   218				__func__, ret);
   219			goto err;
   220		}
   221	
   222		if (val & (1 << TAS2780_ISENSE_POWER_EN))
   223			sense_en = 0;
   224		else
   225			sense_en = TAS2780_TDM_CFG6_ISNS_ENABLE;
   226	
   227		ret = snd_soc_component_update_bits(tas2780->component,
   228			TAS2780_TDM_CFG6, TAS2780_TDM_CFG6_ISNS_ENABLE, sense_en);
   229		if (ret < 0) {
   230			dev_err(tas2780->dev, "%s:errCode:0x%x enable iSNS error\n",
   231				__func__, ret);
   232			goto err;
   233		}
   234		ret = 0;
   235	err:
   236		return ret;
   237	}
   238	
   239	static int tas2780_set_samplerate(
   240		struct tas2780_priv *tas2780, int samplerate)
   241	{
   242		struct snd_soc_component *component = tas2780->component;
   243		int ramp_rate_val;
   244		int ret;
   245	
   246		switch (samplerate) {
   247		case 48000:
   248			ramp_rate_val = TAS2780_TDM_CFG0_SMP_48KHZ |
   249					TAS2780_TDM_CFG0_44_1_48KHZ;
   250			break;
   251		case 44100:
   252			ramp_rate_val = TAS2780_TDM_CFG0_SMP_44_1KHZ |
   253					TAS2780_TDM_CFG0_44_1_48KHZ;
   254			break;
   255		case 96000:
   256			ramp_rate_val = TAS2780_TDM_CFG0_SMP_48KHZ |
   257					TAS2780_TDM_CFG0_88_2_96KHZ;
   258			break;
   259		case 88200:
   260			ramp_rate_val = TAS2780_TDM_CFG0_SMP_44_1KHZ |
   261					TAS2780_TDM_CFG0_88_2_96KHZ;
   262			break;
   263		default:
   264			return -EINVAL;
   265		}
   266		ret = snd_soc_component_update_bits(component, TAS2780_TDM_CFG0,
   267			TAS2780_TDM_CFG0_SMP_MASK | TAS2780_TDM_CFG0_MASK,
   268			ramp_rate_val);
   269		if (ret < 0) {
   270			dev_err(tas2780->dev,
   271				"%s:errCode:0x%x Failed to set ramp_rate_val\n",
   272				__func__, ret);
   273			goto err;
   274		}
   275		ret = 0;
   276	err:
   277		return ret;
   278	}
   279	
   280	static int tas2780_hw_params(struct snd_pcm_substream *substream,
   281		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
   282	{
   283		struct snd_soc_component *component = dai->component;
   284		struct tas2780_priv *tas2780 =
   285			snd_soc_component_get_drvdata(component);
   286		int ret;
   287	
 > 288		ret = tas2780_set_bitwidth(tas2780, params_format(params));
   289		if (ret < 0)
   290			return ret;
   291	
   292		return tas2780_set_samplerate(tas2780, params_rate(params));
   293	}
   294	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
