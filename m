Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB3585AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiG3OXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiG3OXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 10:23:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B126ED
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659190992; x=1690726992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v48dWDmofiDc0b3Xl6nQRMlsUqhCRrAcMEGIqFTPk3s=;
  b=MAL04LE8CVaj6TkzB7GauCp9OuMkFu4p13o5mUxPwuRZUcZtm3KcO04R
   rtgTMVoc9MKZnWjMvwyY6HkL85X7F0LnQ37cJSuJdrnIlWMPpvivWx3lQ
   fcvutqk3yLSvv3mjR0qMZLiiC7fl7/pEo4sMgFz9e5FCKtBoGfOpZivOw
   EcmhSjNtuOBaP11PFI3m1YQTsiNNhL21LPxc3VVMz5GbHXtgB8iCv0DTh
   kkzwXt1wXzFDaiewOxktUcEtGAnoI2YWUyxS94/tcb/JRM8Q2qHXaeUtp
   yL+1vstRSY5I2DJ5BYcvOiHcxWxTuj6tQRko+szYcHk14K6ChiNY6gfnn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="286476331"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="286476331"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 07:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="669555901"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 07:23:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHnMz-000CtX-2r;
        Sat, 30 Jul 2022 14:23:09 +0000
Date:   Sat, 30 Jul 2022 22:22:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-2022-07-28-v1 40/51]
 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:196:8: error: no member named
 'playback_widget' in 'struct snd_soc_dai'
Message-ID: <202207302255.7Ex5FrZf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-2022-07-28-v1
head:   c42e1fe957372fd9252332c31579f684e9b3a4a4
commit: 963a70b0034020ab469f6b114e92ab53b644e4cb [40/51] ASoC: soc-dai.h: cleanup Playback/Capture data for snd_soc_dai
config: arm64-randconfig-r025-20220729 (https://download.01.org/0day-ci/archive/20220730/202207302255.7Ex5FrZf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/morimoto/linux/commit/963a70b0034020ab469f6b114e92ab53b644e4cb
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound2-2022-07-28-v1
        git checkout 963a70b0034020ab469f6b114e92ab53b644e4cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:196:8: error: no member named 'playback_widget' in 'struct snd_soc_dai'
                   dai->playback_widget->active,
                   ~~~  ^
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                          ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
>> sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:197:8: error: no member named 'capture_widget' in 'struct snd_soc_dai'
                   dai->capture_widget->active);
                   ~~~  ^
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                          ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:199:11: error: no member named 'playback_widget' in 'struct snd_soc_dai'
           if (dai->playback_widget->active || dai->capture_widget->active)
               ~~~  ^
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:199:43: error: no member named 'capture_widget' in 'struct snd_soc_dai'
           if (dai->playback_widget->active || dai->capture_widget->active)
                                               ~~~  ^
   4 errors generated.
--
>> sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:286:9: error: no member named 'playback_widget' in 'struct snd_soc_dai'
                    dai->playback_widget->active,
                    ~~~  ^
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                            ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
>> sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:287:9: error: no member named 'capture_widget' in 'struct snd_soc_dai'
                    dai->capture_widget->active);
                    ~~~  ^
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                            ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:289:11: error: no member named 'playback_widget' in 'struct snd_soc_dai'
           if (dai->playback_widget->active || dai->capture_widget->active)
               ~~~  ^
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:289:43: error: no member named 'capture_widget' in 'struct snd_soc_dai'
           if (dai->playback_widget->active || dai->capture_widget->active)
                                               ~~~  ^
   4 errors generated.


vim +196 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c

a94aec035a122b Shunli Wang 2019-01-22  179  
a94aec035a122b Shunli Wang 2019-01-22  180  /* dai ops */
a94aec035a122b Shunli Wang 2019-01-22  181  static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
a94aec035a122b Shunli Wang 2019-01-22  182  				 struct snd_pcm_hw_params *params,
a94aec035a122b Shunli Wang 2019-01-22  183  				 struct snd_soc_dai *dai)
a94aec035a122b Shunli Wang 2019-01-22  184  {
a94aec035a122b Shunli Wang 2019-01-22  185  	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
a94aec035a122b Shunli Wang 2019-01-22  186  	unsigned int rate = params_rate(params);
a94aec035a122b Shunli Wang 2019-01-22  187  	unsigned int rate_reg = mt8183_rate_transform(afe->dev, rate, dai->id);
a94aec035a122b Shunli Wang 2019-01-22  188  	unsigned int pcm_con = 0;
a94aec035a122b Shunli Wang 2019-01-22  189  
a94aec035a122b Shunli Wang 2019-01-22  190  	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
a94aec035a122b Shunli Wang 2019-01-22  191  		__func__,
a94aec035a122b Shunli Wang 2019-01-22  192  		dai->id,
a94aec035a122b Shunli Wang 2019-01-22  193  		substream->stream,
a94aec035a122b Shunli Wang 2019-01-22  194  		rate,
a94aec035a122b Shunli Wang 2019-01-22  195  		rate_reg,
a94aec035a122b Shunli Wang 2019-01-22 @196  		dai->playback_widget->active,
a94aec035a122b Shunli Wang 2019-01-22 @197  		dai->capture_widget->active);
a94aec035a122b Shunli Wang 2019-01-22  198  
a94aec035a122b Shunli Wang 2019-01-22  199  	if (dai->playback_widget->active || dai->capture_widget->active)
a94aec035a122b Shunli Wang 2019-01-22  200  		return 0;
a94aec035a122b Shunli Wang 2019-01-22  201  
a94aec035a122b Shunli Wang 2019-01-22  202  	switch (dai->id) {
a94aec035a122b Shunli Wang 2019-01-22  203  	case MT8183_DAI_PCM_1:
a94aec035a122b Shunli Wang 2019-01-22  204  		pcm_con |= AUD_BCLK_OUT_INV_NO_INVERSE << PCM_BCLK_OUT_INV_SFT;
a94aec035a122b Shunli Wang 2019-01-22  205  		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM_TX_LCH_RPT_SFT;
a94aec035a122b Shunli Wang 2019-01-22  206  		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM_VBT_16K_MODE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  207  		pcm_con |= AUD_EXT_MODEM_SELECT_INTERNAL << PCM_EXT_MODEM_SFT;
a94aec035a122b Shunli Wang 2019-01-22  208  		pcm_con |= 0 << PCM_SYNC_LENGTH_SFT;
a94aec035a122b Shunli Wang 2019-01-22  209  		pcm_con |= AUD_PCM_ONE_BCK_CYCLE_SYNC << PCM_SYNC_TYPE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  210  		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM_BT_MODE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  211  		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM_BYP_ASRC_SFT;
a94aec035a122b Shunli Wang 2019-01-22  212  		pcm_con |= AUD_PCM_CLOCK_SLAVE_MODE << PCM_SLAVE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  213  		pcm_con |= rate_reg << PCM_MODE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  214  		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM_FMT_SFT;
a94aec035a122b Shunli Wang 2019-01-22  215  
a94aec035a122b Shunli Wang 2019-01-22  216  		regmap_update_bits(afe->regmap, PCM_INTF_CON1,
a94aec035a122b Shunli Wang 2019-01-22  217  				   0xfffffffe, pcm_con);
a94aec035a122b Shunli Wang 2019-01-22  218  		break;
a94aec035a122b Shunli Wang 2019-01-22  219  	case MT8183_DAI_PCM_2:
a94aec035a122b Shunli Wang 2019-01-22  220  		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM2_TX_LCH_RPT_SFT;
a94aec035a122b Shunli Wang 2019-01-22  221  		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM2_VBT_16K_MODE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  222  		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM2_BT_MODE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  223  		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM2_AFIFO_SFT;
a94aec035a122b Shunli Wang 2019-01-22  224  		pcm_con |= AUD_PCM_WLEN_PCM_32_BCK_CYCLES << PCM2_WLEN_SFT;
a94aec035a122b Shunli Wang 2019-01-22  225  		pcm_con |= rate_reg << PCM2_MODE_SFT;
a94aec035a122b Shunli Wang 2019-01-22  226  		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM2_FMT_SFT;
a94aec035a122b Shunli Wang 2019-01-22  227  
a94aec035a122b Shunli Wang 2019-01-22  228  		regmap_update_bits(afe->regmap, PCM2_INTF_CON,
a94aec035a122b Shunli Wang 2019-01-22  229  				   0xfffffffe, pcm_con);
a94aec035a122b Shunli Wang 2019-01-22  230  		break;
a94aec035a122b Shunli Wang 2019-01-22  231  	default:
a94aec035a122b Shunli Wang 2019-01-22  232  		dev_warn(afe->dev, "%s(), id %d not support\n",
a94aec035a122b Shunli Wang 2019-01-22  233  			 __func__, dai->id);
a94aec035a122b Shunli Wang 2019-01-22  234  		return -EINVAL;
a94aec035a122b Shunli Wang 2019-01-22  235  	}
a94aec035a122b Shunli Wang 2019-01-22  236  
a94aec035a122b Shunli Wang 2019-01-22  237  	return 0;
a94aec035a122b Shunli Wang 2019-01-22  238  }
a94aec035a122b Shunli Wang 2019-01-22  239  

:::::: The code at line 196 was first introduced by commit
:::::: a94aec035a122bf6d1a05b14f02f34c34b99506a ASoC: mediatek: mt8183: add platform driver

:::::: TO: Shunli Wang <shunli.wang@mediatek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
