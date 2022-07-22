Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E56F57D918
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiGVDzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGVDzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:55:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F24BF40
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658462116; x=1689998116;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7z5nj5Hl6Cb/u3BHldn2O/bewa5VXdNPLRWd+FrPkM8=;
  b=CPFZ7Aqy8LqM9e06XnatalMsOZAs5ZT3zc3GhTaTdZetYevZPrF0eRz8
   D9ndcq57uBUIfWQ32CX+BnC/ZoAxlrOdS9sbkr4nVtqdb1vFyUh90y7oj
   tan2LT2kgpi57IY3YPUHwQ6tuf27Lgwr3DzVXRNnDc7ZQThBgLGHK9pEw
   OH4cAkt+hTf0XiNjvN4GDPdjp2rEk/zk+9jGUlVC/GkCxYZFVekvZRw/a
   VLjQfoxtVzCLGNq2T8r/kr3fMBRzPyYgMQDX9V7Tn0dAta4dHsZYmlDi8
   9pzQUejvjJYfPFTAUkqH8cnQ/vbGRRMqKolXEGDS3fvsRSxNcogffHFQ2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287985301"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287985301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 20:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="549030793"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 20:55:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEjku-0000vc-2t;
        Fri, 22 Jul 2022 03:55:12 +0000
Date:   Fri, 22 Jul 2022 11:55:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-2022-07-21-v2 39/47]
 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:196:20: error: 'struct
 snd_soc_dai' has no member named 'playback_widget'
Message-ID: <202207221149.LWvHKdaI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-2022-07-21-v2
head:   9a531dde39dc408ec83ad303735743e9401be154
commit: edfaee6a8d77201fc905f3f4a15b9b7642eefc3c [39/47] ASoC: soc-dai.h: cleanup Playback/Capture data for snd_soc_dai
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220722/202207221149.LWvHKdaI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/edfaee6a8d77201fc905f3f4a15b9b7642eefc3c
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound2-2022-07-21-v2
        git checkout edfaee6a8d77201fc905f3f4a15b9b7642eefc3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:584,
                    from include/linux/kernel.h:29,
                    from include/linux/rbtree.h:22,
                    from include/linux/regmap.h:14,
                    from sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:8:
   sound/soc/mediatek/mt6797/mt6797-dai-pcm.c: In function 'mtk_dai_pcm_hw_params':
>> sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:196:20: error: 'struct snd_soc_dai' has no member named 'playback_widget'
     196 |                 dai->playback_widget->active,
         |                    ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:190:9: note: in expansion of macro 'dev_dbg'
     190 |         dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
         |         ^~~~~~~
>> sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:197:20: error: 'struct snd_soc_dai' has no member named 'capture_widget'
     197 |                 dai->capture_widget->active);
         |                    ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:190:9: note: in expansion of macro 'dev_dbg'
     190 |         dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
         |         ^~~~~~~
   sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:199:16: error: 'struct snd_soc_dai' has no member named 'playback_widget'
     199 |         if (dai->playback_widget->active || dai->capture_widget->active)
         |                ^~
   sound/soc/mediatek/mt6797/mt6797-dai-pcm.c:199:48: error: 'struct snd_soc_dai' has no member named 'capture_widget'
     199 |         if (dai->playback_widget->active || dai->capture_widget->active)
         |                                                ^~
--
   In file included from include/linux/printk.h:584,
                    from include/linux/kernel.h:29,
                    from include/linux/rbtree.h:22,
                    from include/linux/regmap.h:14,
                    from sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:8:
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c: In function 'mtk_dai_pcm_hw_params':
>> sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:196:20: error: 'struct snd_soc_dai' has no member named 'playback_widget'
     196 |                 dai->playback_widget->active,
         |                    ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:190:9: note: in expansion of macro 'dev_dbg'
     190 |         dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
         |         ^~~~~~~
>> sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:197:20: error: 'struct snd_soc_dai' has no member named 'capture_widget'
     197 |                 dai->capture_widget->active);
         |                    ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:190:9: note: in expansion of macro 'dev_dbg'
     190 |         dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
         |         ^~~~~~~
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:199:16: error: 'struct snd_soc_dai' has no member named 'playback_widget'
     199 |         if (dai->playback_widget->active || dai->capture_widget->active)
         |                ^~
   sound/soc/mediatek/mt8183/mt8183-dai-pcm.c:199:48: error: 'struct snd_soc_dai' has no member named 'capture_widget'
     199 |         if (dai->playback_widget->active || dai->capture_widget->active)
         |                                                ^~
--
   In file included from include/linux/device.h:15,
                    from include/linux/pm_qos.h:17,
                    from include/sound/pcm.h:17,
                    from include/sound/pcm_params.h:10,
                    from sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:10:
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c: In function 'mtk_dai_pcm_hw_params':
>> sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:286:21: error: 'struct snd_soc_dai' has no member named 'playback_widget'
     286 |                  dai->playback_widget->active,
         |                     ^~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:280:9: note: in expansion of macro 'dev_info'
     280 |         dev_info(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
         |         ^~~~~~~~
>> sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:287:21: error: 'struct snd_soc_dai' has no member named 'capture_widget'
     287 |                  dai->capture_widget->active);
         |                     ^~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:280:9: note: in expansion of macro 'dev_info'
     280 |         dev_info(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
         |         ^~~~~~~~
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:289:16: error: 'struct snd_soc_dai' has no member named 'playback_widget'
     289 |         if (dai->playback_widget->active || dai->capture_widget->active)
         |                ^~
   sound/soc/mediatek/mt8192/mt8192-dai-pcm.c:289:48: error: 'struct snd_soc_dai' has no member named 'capture_widget'
     289 |         if (dai->playback_widget->active || dai->capture_widget->active)
         |                                                ^~


vim +196 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c

314b355f55b53b Kai Chieh Chuang 2018-05-31  179  
314b355f55b53b Kai Chieh Chuang 2018-05-31  180  /* dai ops */
314b355f55b53b Kai Chieh Chuang 2018-05-31  181  static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
314b355f55b53b Kai Chieh Chuang 2018-05-31  182  				 struct snd_pcm_hw_params *params,
314b355f55b53b Kai Chieh Chuang 2018-05-31  183  				 struct snd_soc_dai *dai)
314b355f55b53b Kai Chieh Chuang 2018-05-31  184  {
314b355f55b53b Kai Chieh Chuang 2018-05-31  185  	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
314b355f55b53b Kai Chieh Chuang 2018-05-31  186  	unsigned int rate = params_rate(params);
314b355f55b53b Kai Chieh Chuang 2018-05-31  187  	unsigned int rate_reg = mt6797_rate_transform(afe->dev, rate, dai->id);
314b355f55b53b Kai Chieh Chuang 2018-05-31  188  	unsigned int pcm_con = 0;
314b355f55b53b Kai Chieh Chuang 2018-05-31  189  
314b355f55b53b Kai Chieh Chuang 2018-05-31  190  	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
314b355f55b53b Kai Chieh Chuang 2018-05-31  191  		__func__,
314b355f55b53b Kai Chieh Chuang 2018-05-31  192  		dai->id,
314b355f55b53b Kai Chieh Chuang 2018-05-31  193  		substream->stream,
314b355f55b53b Kai Chieh Chuang 2018-05-31  194  		rate,
314b355f55b53b Kai Chieh Chuang 2018-05-31  195  		rate_reg,
314b355f55b53b Kai Chieh Chuang 2018-05-31 @196  		dai->playback_widget->active,
314b355f55b53b Kai Chieh Chuang 2018-05-31 @197  		dai->capture_widget->active);
314b355f55b53b Kai Chieh Chuang 2018-05-31  198  
314b355f55b53b Kai Chieh Chuang 2018-05-31  199  	if (dai->playback_widget->active || dai->capture_widget->active)
314b355f55b53b Kai Chieh Chuang 2018-05-31  200  		return 0;
314b355f55b53b Kai Chieh Chuang 2018-05-31  201  
314b355f55b53b Kai Chieh Chuang 2018-05-31  202  	switch (dai->id) {
314b355f55b53b Kai Chieh Chuang 2018-05-31  203  	case MT6797_DAI_PCM_1:
314b355f55b53b Kai Chieh Chuang 2018-05-31  204  		pcm_con |= AUD_BCLK_OUT_INV_NO_INVERSE << PCM_BCLK_OUT_INV_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  205  		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM_TX_LCH_RPT_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  206  		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM_VBT_16K_MODE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  207  		pcm_con |= AUD_EXT_MODEM_SELECT_INTERNAL << PCM_EXT_MODEM_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  208  		pcm_con |= 0 << PCM_SYNC_LENGTH_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  209  		pcm_con |= AUD_PCM_ONE_BCK_CYCLE_SYNC << PCM_SYNC_TYPE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  210  		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM_BT_MODE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  211  		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM_BYP_ASRC_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  212  		pcm_con |= AUD_PCM_CLOCK_SLAVE_MODE << PCM_SLAVE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  213  		pcm_con |= rate_reg << PCM_MODE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  214  		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM_FMT_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  215  
314b355f55b53b Kai Chieh Chuang 2018-05-31  216  		regmap_update_bits(afe->regmap, PCM_INTF_CON1,
314b355f55b53b Kai Chieh Chuang 2018-05-31  217  				   0xfffffffe, pcm_con);
314b355f55b53b Kai Chieh Chuang 2018-05-31  218  		break;
314b355f55b53b Kai Chieh Chuang 2018-05-31  219  	case MT6797_DAI_PCM_2:
314b355f55b53b Kai Chieh Chuang 2018-05-31  220  		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM2_TX_LCH_RPT_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  221  		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM2_VBT_16K_MODE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  222  		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM2_BT_MODE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  223  		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM2_AFIFO_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  224  		pcm_con |= AUD_PCM_WLEN_PCM_32_BCK_CYCLES << PCM2_WLEN_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  225  		pcm_con |= rate_reg << PCM2_MODE_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  226  		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM2_FMT_SFT;
314b355f55b53b Kai Chieh Chuang 2018-05-31  227  
314b355f55b53b Kai Chieh Chuang 2018-05-31  228  		regmap_update_bits(afe->regmap, PCM2_INTF_CON,
314b355f55b53b Kai Chieh Chuang 2018-05-31  229  				   0xfffffffe, pcm_con);
314b355f55b53b Kai Chieh Chuang 2018-05-31  230  		break;
314b355f55b53b Kai Chieh Chuang 2018-05-31  231  	default:
314b355f55b53b Kai Chieh Chuang 2018-05-31  232  		dev_warn(afe->dev, "%s(), id %d not support\n",
314b355f55b53b Kai Chieh Chuang 2018-05-31  233  			 __func__, dai->id);
314b355f55b53b Kai Chieh Chuang 2018-05-31  234  		return -EINVAL;
314b355f55b53b Kai Chieh Chuang 2018-05-31  235  	}
314b355f55b53b Kai Chieh Chuang 2018-05-31  236  
314b355f55b53b Kai Chieh Chuang 2018-05-31  237  	return 0;
314b355f55b53b Kai Chieh Chuang 2018-05-31  238  }
314b355f55b53b Kai Chieh Chuang 2018-05-31  239  

:::::: The code at line 196 was first introduced by commit
:::::: 314b355f55b53bc3cfc0380b46192dafb5893fcb ASoC: mt6797: add PCM interface

:::::: TO: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
