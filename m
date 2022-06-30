Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38BD56152B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiF3Ieo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiF3Iem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:34:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660CE22BFB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656578081; x=1688114081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HH6yHBUqSoYMpvQuTV30SXj3EOtgimWgAWCzTDqfIxE=;
  b=S0N8nQGTK6GtWnURdMSTqDNi47iRWy+7dehhQsCb8ArkHloHmi+5Klht
   21uNmJDae0xuLgBJ/9jBK7lYW7j4rtJxb0/9Xqj4eSf/jSAWWaYKF6HMl
   jDa7PjMG4p5/kNhVTjT0EpwaqeZ9kq/jSPip0qeHtp8Zrrv9qQ/b5h765
   N2OwpS+lgUilkCNhtUBgh6fuMtiDSSpcBJ/rtd+nqN9G77hFZ1vd9tZuG
   tA1BVaYubPInF3x7zobISAH6gOKbETv1til9GO48Fg9LhuoRAtogyIk/M
   DW20EMQtOjghKw1lybLdBd0hEMI7QLRWi6k5n8UuxQ8ulBnpHpuxHD5LO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368601115"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="368601115"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 01:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="917963053"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 01:34:39 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6pdH-000CUY-AG;
        Thu, 30 Jun 2022 08:34:39 +0000
Date:   Thu, 30 Jun 2022 16:34:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morimoto:sound-2022-06-30-v3 11/19]
 sound/soc/codecs/cs4271.c:359:64: error: too few arguments to function call,
 expected 3, have 2
Message-ID: <202206301643.dem6nEiG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound-2022-06-30-v3
head:   fc6f65d23a318462b8e17cdf7db622dfc7719ac7
commit: 13230e877cbc275ad58da98eca3f64ae9775afb9 [11/19] ASoC: count activity via TX/RX base instead of Playback/Capture.
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220630/202206301643.dem6nEiG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/13230e877cbc275ad58da98eca3f64ae9775afb9
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound-2022-06-30-v3
        git checkout 13230e877cbc275ad58da98eca3f64ae9775afb9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/codecs/cs4271.c:359:64: error: too few arguments to function call, expected 3, have 2
                        !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE)) ||
                         ~~~~~~~~~~~~~~~~~~~~~~~~~                              ^
   include/sound/soc-dai.h:606:1: note: 'snd_soc_dai_stream_active' declared here
   snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
   ^
   sound/soc/codecs/cs4271.c:361:65: error: too few arguments to function call, expected 3, have 2
                        !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_PLAYBACK))) {
                         ~~~~~~~~~~~~~~~~~~~~~~~~~                               ^
   include/sound/soc-dai.h:606:1: note: 'snd_soc_dai_stream_active' declared here
   snd_soc_dai_stream_active(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai, int stream)
   ^
   2 errors generated.


vim +359 sound/soc/codecs/cs4271.c

5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  338  
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  339  static int cs4271_hw_params(struct snd_pcm_substream *substream,
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  340  			    struct snd_pcm_hw_params *params,
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  341  			    struct snd_soc_dai *dai)
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  342  {
cac308fcd767a07 Kuninori Morimoto  2018-01-29  343  	struct snd_soc_component *component = dai->component;
cac308fcd767a07 Kuninori Morimoto  2018-01-29  344  	struct cs4271_private *cs4271 = snd_soc_component_get_drvdata(component);
0d42e6e77f8b872 Alexander Sverdlin 2011-01-21  345  	int i, ret;
0d42e6e77f8b872 Alexander Sverdlin 2011-01-21  346  	unsigned int ratio, val;
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  347  
fd23fb9f6bfd43a Daniel Mack        2012-12-10  348  	if (cs4271->enable_soft_reset) {
fd23fb9f6bfd43a Daniel Mack        2012-12-10  349  		/*
fd23fb9f6bfd43a Daniel Mack        2012-12-10  350  		 * Put the codec in soft reset and back again in case it's not
fd23fb9f6bfd43a Daniel Mack        2012-12-10  351  		 * currently streaming data. This way of bringing the codec in
fd23fb9f6bfd43a Daniel Mack        2012-12-10  352  		 * sync to the current clocks is not explicitly documented in
fd23fb9f6bfd43a Daniel Mack        2012-12-10  353  		 * the data sheet, but it seems to work fine, and in contrast
fd23fb9f6bfd43a Daniel Mack        2012-12-10  354  		 * to a read hardware reset, we don't have to sync back all
fd23fb9f6bfd43a Daniel Mack        2012-12-10  355  		 * registers every time.
fd23fb9f6bfd43a Daniel Mack        2012-12-10  356  		 */
fd23fb9f6bfd43a Daniel Mack        2012-12-10  357  
fd23fb9f6bfd43a Daniel Mack        2012-12-10  358  		if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
5e518eddd11e8f7 Kuninori Morimoto  2020-05-15 @359  		     !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_CAPTURE)) ||
fd23fb9f6bfd43a Daniel Mack        2012-12-10  360  		    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
5e518eddd11e8f7 Kuninori Morimoto  2020-05-15  361  		     !snd_soc_dai_stream_active(dai, SNDRV_PCM_STREAM_PLAYBACK))) {
1b1861ead4f9fd7 Daniel Mack        2013-03-07  362  			ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
fd23fb9f6bfd43a Daniel Mack        2012-12-10  363  						 CS4271_MODE2_PDN,
fd23fb9f6bfd43a Daniel Mack        2012-12-10  364  						 CS4271_MODE2_PDN);
fd23fb9f6bfd43a Daniel Mack        2012-12-10  365  			if (ret < 0)
fd23fb9f6bfd43a Daniel Mack        2012-12-10  366  				return ret;
fd23fb9f6bfd43a Daniel Mack        2012-12-10  367  
1b1861ead4f9fd7 Daniel Mack        2013-03-07  368  			ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
fd23fb9f6bfd43a Daniel Mack        2012-12-10  369  						 CS4271_MODE2_PDN, 0);
fd23fb9f6bfd43a Daniel Mack        2012-12-10  370  			if (ret < 0)
fd23fb9f6bfd43a Daniel Mack        2012-12-10  371  				return ret;
fd23fb9f6bfd43a Daniel Mack        2012-12-10  372  		}
fd23fb9f6bfd43a Daniel Mack        2012-12-10  373  	}
fd23fb9f6bfd43a Daniel Mack        2012-12-10  374  
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  375  	cs4271->rate = params_rate(params);
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  376  
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  377  	/* Configure DAC */
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  378  	if (cs4271->rate < 50000)
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  379  		val = CS4271_MODE1_MODE_1X;
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  380  	else if (cs4271->rate < 100000)
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  381  		val = CS4271_MODE1_MODE_2X;
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  382  	else
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  383  		val = CS4271_MODE1_MODE_4X;
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  384  
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  385  	ratio = cs4271->mclk / cs4271->rate;
0c03e37af47efcb Christophe JAILLET 2019-07-24  386  	for (i = 0; i < CS4271_NR_RATIOS; i++)
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  387  		if ((cs4271_clk_tab[i].master == cs4271->master) &&
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  388  		    (cs4271_clk_tab[i].speed_mode == val) &&
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  389  		    (cs4271_clk_tab[i].ratio == ratio))
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  390  			break;
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  391  
0c03e37af47efcb Christophe JAILLET 2019-07-24  392  	if (i == CS4271_NR_RATIOS) {
cac308fcd767a07 Kuninori Morimoto  2018-01-29  393  		dev_err(component->dev, "Invalid sample rate\n");
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  394  		return -EINVAL;
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  395  	}
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  396  
5c3a12e96c9f315 Alexander Sverdlin 2011-03-07  397  	val |= cs4271_clk_tab[i].ratio_mask;
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  398  
1b1861ead4f9fd7 Daniel Mack        2013-03-07  399  	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE1,
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  400  		CS4271_MODE1_MODE_MASK | CS4271_MODE1_DIV_MASK, val);
0d42e6e77f8b872 Alexander Sverdlin 2011-01-21  401  	if (ret < 0)
0d42e6e77f8b872 Alexander Sverdlin 2011-01-21  402  		return ret;
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  403  
cac308fcd767a07 Kuninori Morimoto  2018-01-29  404  	return cs4271_set_deemph(component);
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  405  }
67b22517d8e48a9 Alexander Sverdlin 2011-01-19  406  

:::::: The code at line 359 was first introduced by commit
:::::: 5e518eddd11e8f71aaffc954dc7ee9572fc59808 ASoC: codecs: use snd_soc_xxx_active()

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
