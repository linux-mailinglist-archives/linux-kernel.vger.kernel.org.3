Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674024FAFA0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiDJTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiDJTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:01:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310647AC8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649617157; x=1681153157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T71qbFdqFG92pViJvacOnrBv3zga4Sk9oewjiHUKL4I=;
  b=DKZEkVW/pwxmz9G/ozT3oYIBA+RiZ2vMDJRInjPckh7YtKGWrU91B+iV
   oU8MYKm0uUDEfIkq13WeFExO7/3DiS5B6UTZvILr8xPlSYx3/zf7AmxND
   gk3OYPKEzpR5dQ/sOEDzuBlV1/DbPgRzijEf83Y1E7alWDxG8ahS37GyC
   BxKwmPfqtqph9hn86B1ohDDIwJE3BlwT/Fdc4eFIkJHWVH1RrQO286XUh
   j+cFh525xbetkxHL7/HFyw1mPmVGoV5pg6hVGtg+1usQIB8VGN4sC8EKR
   VJQK2sbgIvNvH/pqll3Ftask9KaLbI8c5JN38JPqjjngfh5FWt5aaIh0G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="249269505"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="249269505"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 11:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="571803601"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Apr 2022 11:59:14 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndcmH-00012h-VJ;
        Sun, 10 Apr 2022 18:59:13 +0000
Date:   Mon, 11 Apr 2022 02:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brent Lu <brent.lu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i' set
 but not used
Message-ID: <202204110240.lp5uPnQY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ea3c6425269d33da53c79d539ce9554117cf4d4
commit: 2fe14ff61bd6d4fabe313435dd378b5a38eb6102 ASoC: Intel: sof_ssp_amp: rename driver and support cs35l41 amplifier
date:   6 weeks ago
config: x86_64-randconfig-a002-20220411 (https://download.01.org/0day-ci/archive/20220411/202204110240.lp5uPnQY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2fe14ff61bd6d4fabe313435dd378b5a38eb6102
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2fe14ff61bd6d4fabe313435dd378b5a38eb6102
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/intel/boards/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
           int i = 0;
               ^
   1 warning generated.


vim +/i +97 sound/soc/intel/boards/sof_ssp_amp.c

    89	
    90	static int sof_card_late_probe(struct snd_soc_card *card)
    91	{
    92		struct sof_card_private *ctx = snd_soc_card_get_drvdata(card);
    93		struct snd_soc_component *component = NULL;
    94		char jack_name[NAME_SIZE];
    95		struct sof_hdmi_pcm *pcm;
    96		int err;
  > 97		int i = 0;
    98	
    99		if (!(sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT))
   100			return 0;
   101	
   102		/* HDMI is not supported by SOF on Baytrail/CherryTrail */
   103		if (!ctx->idisp_codec)
   104			return 0;
   105	
   106		if (list_empty(&ctx->hdmi_pcm_list))
   107			return -EINVAL;
   108	
   109		if (ctx->common_hdmi_codec_drv) {
   110			pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm,
   111					       head);
   112			component = pcm->codec_dai->component;
   113			return hda_dsp_hdmi_build_controls(card, component);
   114		}
   115	
   116		list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
   117			component = pcm->codec_dai->component;
   118			snprintf(jack_name, sizeof(jack_name),
   119				 "HDMI/DP, pcm=%d Jack", pcm->device);
   120			err = snd_soc_card_jack_new(card, jack_name,
   121						    SND_JACK_AVOUT, &pcm->sof_hdmi,
   122						    NULL, 0);
   123	
   124			if (err)
   125				return err;
   126	
   127			err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
   128						  &pcm->sof_hdmi);
   129			if (err < 0)
   130				return err;
   131	
   132			i++;
   133		}
   134	
   135		return hdac_hdmi_jack_port_init(component, &card->dapm);
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
