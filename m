Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A6587500
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiHBBPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiHBBPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:15:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2763ED4C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659402900; x=1690938900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OZXhPBn9vpiv0ww0MnLmMIWNJZyX7Dvtmhzvm8JB3i4=;
  b=IgMtFH0yBZNgDOi22eYqjBgScZAZXnDxf9AevMALma3t5vAyLLo++0sQ
   tHjdu0sk2cu7cav+dMT25XrmXPrUWj0LRn3IBMRVmSfisrwfgU1wYl4lX
   WgPNvTRMlouYcI754ROL1Zrwv6q6fPM+N2PGjwj/jkK50NC3lQdhfFwpX
   jcWq7dsQIbYv8z7crMGlcDwHac3L82ConHFkSRxRx7FjjiUl5I5b0j/Iz
   PUXxa/1YvasIk+EQWoSImtKYmPxcLFMWp4N2uyDO+gJmxjImnWin9bk90
   m6V+IhUel6uDlvyJ/9CAXMs5bNzV9Zg8EiJZnjhkzS/hbv2ixaEOnlF7X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269672253"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="269672253"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="578007463"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2022 18:14:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIgUr-000FXb-0Z;
        Tue, 02 Aug 2022 01:14:57 +0000
Date:   Tue, 2 Aug 2022 09:14:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brent Lu <brent.lu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i' set
 but not used
Message-ID: <202208020937.s1Een9WX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brent,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9de1f9c8ca5100a02a2e271bdbde36202e251b4b
commit: 2fe14ff61bd6d4fabe313435dd378b5a38eb6102 ASoC: Intel: sof_ssp_amp: rename driver and support cs35l41 amplifier
date:   5 months ago
config: x86_64-randconfig-r006-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020937.s1Een9WX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2fe14ff61bd6d4fabe313435dd378b5a38eb6102
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2fe14ff61bd6d4fabe313435dd378b5a38eb6102
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/intel/boards/

If you fix the issue, kindly add following tag where applicable
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
