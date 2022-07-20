Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB51457BC53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiGTRIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiGTRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:07:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C16D2DE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658336877; x=1689872877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BkRPC2R3lRW4MvqLxGqye/Yg5/CdZFs/MTh0E/UsGKc=;
  b=Q8F+5L8b8N8rwBdVk9Ltki+s9M4v3di23qr6DuqTC+TSzKh8ATkyI7H6
   l+O6HxN+p9XopTERDpOAGjIpeNv1A0cTNfwGP0fzCOLQEduq88h7PtwCo
   /vZMntkNLC3Ozm1wEhLzexxpbu3V90fztv/1aVKSlvQm0mzKT8ePM0rVU
   cwMI1TqrNnl3omLhbZ56izmbIWTzx8Rw02r06z6zxCX4eknK+I1fDA9BF
   b24zSzNMV8Kpok0OKLzQHZ10plle6AuJRTVzL+WeU/0ElEKFwQQNMmrQN
   R6B0CItvU/PG0SB5PmLs6CF1qU0obsjy39d9X4Kw96NkMBKeTaGEhuK/Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="286844137"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="286844137"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 10:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="665943054"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 10:07:55 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEDAw-0000jj-Oh;
        Wed, 20 Jul 2022 17:07:54 +0000
Date:   Thu, 21 Jul 2022 01:06:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound-2022-07-04-v1 15/23]
 sound/soc/codecs/cs4271.c:359:54: warning: passing argument 2 of
 'snd_soc_dai_stream_active' makes pointer from integer without a cast
Message-ID: <202207210041.v4r4dWxB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound-2022-07-04-v1
head:   e9efd77b37adcddf8f910f34dd0df06be9d896cb
commit: 2aa8bfec7e0ff4ab531a688f8fd43150ad78ae23 [15/23] ASoC: count activity via TX/RX base instead of Playback/Capture.
config: alpha-buildonly-randconfig-r006-20220719 (https://download.01.org/0day-ci/archive/20220721/202207210041.v4r4dWxB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/2aa8bfec7e0ff4ab531a688f8fd43150ad78ae23
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound-2022-07-04-v1
        git checkout 2aa8bfec7e0ff4ab531a688f8fd43150ad78ae23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/iio/adc/ drivers/staging/greybus/ sound/soc/atmel/ sound/soc/codecs/ sound/soc/fsl/ sound/soc/qcom/ sound/soc/sh/ sound/soc/sunxi/ sound/soc/ti/ sound/soc/uniphier/ sound/soc/xilinx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/codecs/cs4271.c: In function 'cs4271_hw_params':
   sound/soc/codecs/cs4271.c:359:49: error: passing argument 1 of 'snd_soc_dai_stream_active' from incompatible pointer type [-Werror=incompatible-pointer-types]
     359 |                      !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE)) ||
         |                                                 ^~~
         |                                                 |
         |                                                 struct snd_soc_dai *
   In file included from include/sound/soc.h:1350,
                    from sound/soc/codecs/cs4271.c:22:
   include/sound/soc-dai.h:605:55: note: expected 'struct snd_soc_pcm_runtime *' but argument is of type 'struct snd_soc_dai *'
     605 | snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> sound/soc/codecs/cs4271.c:359:54: warning: passing argument 2 of 'snd_soc_dai_stream_active' makes pointer from integer without a cast [-Wint-conversion]
     359 |                      !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE)) ||
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                      |
         |                                                      int
   include/sound/soc-dai.h:605:80: note: expected 'struct snd_soc_dai *' but argument is of type 'int'
     605 | snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
         |                                                            ~~~~~~~~~~~~~~~~~~~~^~~
   sound/soc/codecs/cs4271.c:359:23: error: too few arguments to function 'snd_soc_dai_stream_active'
     359 |                      !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE)) ||
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/soc-dai.h:605:1: note: declared here
     605 | snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/cs4271.c:361:49: error: passing argument 1 of 'snd_soc_dai_stream_active' from incompatible pointer type [-Werror=incompatible-pointer-types]
     361 |                      !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_PLAYBACK))) {
         |                                                 ^~~
         |                                                 |
         |                                                 struct snd_soc_dai *
   include/sound/soc-dai.h:605:55: note: expected 'struct snd_soc_pcm_runtime *' but argument is of type 'struct snd_soc_dai *'
     605 | snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   sound/soc/codecs/cs4271.c:361:23: error: too few arguments to function 'snd_soc_dai_stream_active'
     361 |                      !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_PLAYBACK))) {
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/soc-dai.h:605:1: note: declared here
     605 | snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/snd_soc_dai_stream_active +359 sound/soc/codecs/cs4271.c

5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  338  
67b22517d8e48a Alexander Sverdlin 2011-01-19  339  static int cs4271_hw_params(struct snd_pcm_substream *substream,
67b22517d8e48a Alexander Sverdlin 2011-01-19  340  			    struct snd_pcm_hw_params *params,
67b22517d8e48a Alexander Sverdlin 2011-01-19  341  			    struct snd_soc_dai *dai)
67b22517d8e48a Alexander Sverdlin 2011-01-19  342  {
cac308fcd767a0 Kuninori Morimoto  2018-01-29  343  	struct snd_soc_component *component = dai->component;
cac308fcd767a0 Kuninori Morimoto  2018-01-29  344  	struct cs4271_private *cs4271 = snd_soc_component_get_drvdata(component);
0d42e6e77f8b87 Alexander Sverdlin 2011-01-21  345  	int i, ret;
0d42e6e77f8b87 Alexander Sverdlin 2011-01-21  346  	unsigned int ratio, val;
67b22517d8e48a Alexander Sverdlin 2011-01-19  347  
fd23fb9f6bfd43 Daniel Mack        2012-12-10  348  	if (cs4271->enable_soft_reset) {
fd23fb9f6bfd43 Daniel Mack        2012-12-10  349  		/*
fd23fb9f6bfd43 Daniel Mack        2012-12-10  350  		 * Put the codec in soft reset and back again in case it's not
fd23fb9f6bfd43 Daniel Mack        2012-12-10  351  		 * currently streaming data. This way of bringing the codec in
fd23fb9f6bfd43 Daniel Mack        2012-12-10  352  		 * sync to the current clocks is not explicitly documented in
fd23fb9f6bfd43 Daniel Mack        2012-12-10  353  		 * the data sheet, but it seems to work fine, and in contrast
fd23fb9f6bfd43 Daniel Mack        2012-12-10  354  		 * to a read hardware reset, we don't have to sync back all
fd23fb9f6bfd43 Daniel Mack        2012-12-10  355  		 * registers every time.
fd23fb9f6bfd43 Daniel Mack        2012-12-10  356  		 */
fd23fb9f6bfd43 Daniel Mack        2012-12-10  357  
fd23fb9f6bfd43 Daniel Mack        2012-12-10  358  		if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
5e518eddd11e8f Kuninori Morimoto  2020-05-15 @359  		     !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE)) ||
fd23fb9f6bfd43 Daniel Mack        2012-12-10  360  		    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
5e518eddd11e8f Kuninori Morimoto  2020-05-15  361  		     !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_PLAYBACK))) {
1b1861ead4f9fd Daniel Mack        2013-03-07  362  			ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
fd23fb9f6bfd43 Daniel Mack        2012-12-10  363  						 CS4271_MODE2_PDN,
fd23fb9f6bfd43 Daniel Mack        2012-12-10  364  						 CS4271_MODE2_PDN);
fd23fb9f6bfd43 Daniel Mack        2012-12-10  365  			if (ret < 0)
fd23fb9f6bfd43 Daniel Mack        2012-12-10  366  				return ret;
fd23fb9f6bfd43 Daniel Mack        2012-12-10  367  
1b1861ead4f9fd Daniel Mack        2013-03-07  368  			ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
fd23fb9f6bfd43 Daniel Mack        2012-12-10  369  						 CS4271_MODE2_PDN, 0);
fd23fb9f6bfd43 Daniel Mack        2012-12-10  370  			if (ret < 0)
fd23fb9f6bfd43 Daniel Mack        2012-12-10  371  				return ret;
fd23fb9f6bfd43 Daniel Mack        2012-12-10  372  		}
fd23fb9f6bfd43 Daniel Mack        2012-12-10  373  	}
fd23fb9f6bfd43 Daniel Mack        2012-12-10  374  
67b22517d8e48a Alexander Sverdlin 2011-01-19  375  	cs4271->rate = params_rate(params);
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  376  
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  377  	/* Configure DAC */
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  378  	if (cs4271->rate < 50000)
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  379  		val = CS4271_MODE1_MODE_1X;
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  380  	else if (cs4271->rate < 100000)
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  381  		val = CS4271_MODE1_MODE_2X;
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  382  	else
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  383  		val = CS4271_MODE1_MODE_4X;
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  384  
67b22517d8e48a Alexander Sverdlin 2011-01-19  385  	ratio = cs4271->mclk / cs4271->rate;
0c03e37af47efc Christophe JAILLET 2019-07-24  386  	for (i = 0; i < CS4271_NR_RATIOS; i++)
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  387  		if ((cs4271_clk_tab[i].master == cs4271->master) &&
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  388  		    (cs4271_clk_tab[i].speed_mode == val) &&
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  389  		    (cs4271_clk_tab[i].ratio == ratio))
67b22517d8e48a Alexander Sverdlin 2011-01-19  390  			break;
67b22517d8e48a Alexander Sverdlin 2011-01-19  391  
0c03e37af47efc Christophe JAILLET 2019-07-24  392  	if (i == CS4271_NR_RATIOS) {
cac308fcd767a0 Kuninori Morimoto  2018-01-29  393  		dev_err(component->dev, "Invalid sample rate\n");
67b22517d8e48a Alexander Sverdlin 2011-01-19  394  		return -EINVAL;
67b22517d8e48a Alexander Sverdlin 2011-01-19  395  	}
67b22517d8e48a Alexander Sverdlin 2011-01-19  396  
5c3a12e96c9f31 Alexander Sverdlin 2011-03-07  397  	val |= cs4271_clk_tab[i].ratio_mask;
67b22517d8e48a Alexander Sverdlin 2011-01-19  398  
1b1861ead4f9fd Daniel Mack        2013-03-07  399  	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE1,
67b22517d8e48a Alexander Sverdlin 2011-01-19  400  		CS4271_MODE1_MODE_MASK | CS4271_MODE1_DIV_MASK, val);
0d42e6e77f8b87 Alexander Sverdlin 2011-01-21  401  	if (ret < 0)
0d42e6e77f8b87 Alexander Sverdlin 2011-01-21  402  		return ret;
67b22517d8e48a Alexander Sverdlin 2011-01-19  403  
cac308fcd767a0 Kuninori Morimoto  2018-01-29  404  	return cs4271_set_deemph(component);
67b22517d8e48a Alexander Sverdlin 2011-01-19  405  }
67b22517d8e48a Alexander Sverdlin 2011-01-19  406  

:::::: The code at line 359 was first introduced by commit
:::::: 5e518eddd11e8f71aaffc954dc7ee9572fc59808 ASoC: codecs: use snd_soc_xxx_active()

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
