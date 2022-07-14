Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB1574AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGNKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiGNKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:32:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCD4B0C2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657794731; x=1689330731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yo7mHXa8ACWejIPnoJF/sf4fb1keyZ0xdJia58Ph6xQ=;
  b=VfvvJuu+Wekydaz4KHzK6d+gE0bYTgMQqoJKePQXjzSecJDpxuHbpagf
   9uulJnZ0P1Ttzb+auUOXapjrE+TMrVpcJGX71reSwSS1j5sq3RJrTsXhT
   NwJHxPolXmV3wajuVXpIW9WaL542CNZtwxtEWryvWRKm3gd+s6oED6YxD
   ZM7/pf7u62QCxEPgyAGCMIJitkyjmuRtzumFB/zR4zdE/UAJxaIsrnpRH
   hMjBEWggsv0yaj/94pTTeZ/iX5Xo5t91j8ACSsTAeBh4kUtgXEac194iD
   qp3WLqdVsehUZBsChoVwrP67ARi8TT9UG4LPVxfba6fTD1liNWQ7E0I6v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265887086"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265887086"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 03:32:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="571022391"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 03:32:09 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBw8e-0000S7-GY;
        Thu, 14 Jul 2022 10:32:08 +0000
Date:   Thu, 14 Jul 2022 18:31:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morimoto:sound-2022-07-04-v1 15/23]
 sound/soc/intel/avs/boards/nau8825.c:279:17: error: no member named
 'stream_active' in 'struct snd_soc_dai'
Message-ID: <202207141847.favaONji-lkp@intel.com>
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

tree:   https://github.com/morimoto/linux sound-2022-07-04-v1
head:   e9efd77b37adcddf8f910f34dd0df06be9d896cb
commit: 2aa8bfec7e0ff4ab531a688f8fd43150ad78ae23 [15/23] ASoC: count activity via TX/RX base instead of Playback/Capture.
config: mips-randconfig-r011-20220714 (https://download.01.org/0day-ci/archive/20220714/202207141847.favaONji-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/morimoto/linux/commit/2aa8bfec7e0ff4ab531a688f8fd43150ad78ae23
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound-2022-07-04-v1
        git checkout 2aa8bfec7e0ff4ab531a688f8fd43150ad78ae23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash sound/soc/atmel/ sound/soc/codecs/ sound/soc/fsl/ sound/soc/intel/avs/ sound/soc/mxs/ sound/soc/qcom/qdsp6/ sound/soc/samsung/ sound/soc/ti/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/intel/avs/boards/nau8825.c:279:17: error: no member named 'stream_active' in 'struct snd_soc_dai'
           if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
               ~~~~~~~~~  ^
   1 error generated.


vim +279 sound/soc/intel/avs/boards/nau8825.c

32ee40b5590081 Cezary Rojewski 2022-05-11  268  
32ee40b5590081 Cezary Rojewski 2022-05-11  269  static int avs_card_resume_post(struct snd_soc_card *card)
32ee40b5590081 Cezary Rojewski 2022-05-11  270  {
32ee40b5590081 Cezary Rojewski 2022-05-11  271  	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
32ee40b5590081 Cezary Rojewski 2022-05-11  272  	struct snd_soc_jack *jack = snd_soc_card_get_drvdata(card);
32ee40b5590081 Cezary Rojewski 2022-05-11  273  
32ee40b5590081 Cezary Rojewski 2022-05-11  274  	if (!codec_dai) {
32ee40b5590081 Cezary Rojewski 2022-05-11  275  		dev_err(card->dev, "Codec dai not found\n");
32ee40b5590081 Cezary Rojewski 2022-05-11  276  		return -EINVAL;
32ee40b5590081 Cezary Rojewski 2022-05-11  277  	}
32ee40b5590081 Cezary Rojewski 2022-05-11  278  
32ee40b5590081 Cezary Rojewski 2022-05-11 @279  	if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
32ee40b5590081 Cezary Rojewski 2022-05-11  280  	    codec_dai->playback_widget->active)
32ee40b5590081 Cezary Rojewski 2022-05-11  281  		snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0, SND_SOC_CLOCK_IN);
32ee40b5590081 Cezary Rojewski 2022-05-11  282  
32ee40b5590081 Cezary Rojewski 2022-05-11  283  	return avs_card_set_jack(card, jack);
32ee40b5590081 Cezary Rojewski 2022-05-11  284  }
32ee40b5590081 Cezary Rojewski 2022-05-11  285  

:::::: The code at line 279 was first introduced by commit
:::::: 32ee40b5590081a6b38a55e4ab16b47085f93afe ASoC: Intel: avs: Add nau8825 machine board

:::::: TO: Cezary Rojewski <cezary.rojewski@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
