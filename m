Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564D57A9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiGSWUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiGSWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:20:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DF33E21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658269238; x=1689805238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zbrkXOgCa8ruZ88VGIuTk5CSgBO953ZEAJHT9RF4Zhg=;
  b=GNDZQaTG7GIu/woMgkKqX13yxmnPbdRLdLDMe2WZzMVvdgLyl+k1Xb5S
   Lbcyx6Sc2E+j4b2IoNHnMD+SoMyiobeR3MsBrpS9AUpzyvkLo1GFHFU42
   1v4lwZlwb6nlofTaGRqDf+/UGZgarmnsbyryoZSkujHT0NC9z90SraKmK
   ZWql+GhZB6je0hLiFm68l6irKP1yfVhc1fhIL6q90fStkC+ZWorbel+J+
   RQAAifYxynPRS4wG9rGJZ8MmtYpaJ9Ow3VERZ7C6SPKUeu4Qhh+zWhQDT
   ywpKc9L/7GuabPSPU3PY0cvte2lFoCNT3uhq9bvP8y98xE9mfvHIx4K1f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="287777616"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="287777616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="548095000"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2022 15:20:36 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDvZz-0006A8-Tq;
        Tue, 19 Jul 2022 22:20:35 +0000
Date:   Wed, 20 Jul 2022 06:20:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-2022-07-08-v1 9/18] sound/soc/soc-core.c:966:5:
 warning: no previous prototype for '__snd_soc_add_pcm_runtime'
Message-ID: <202207200605.fs9SeJdA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-2022-07-08-v1
head:   b5e8d2766050dfd3452dcdcdff072121984c9a31
commit: 525984dfed23d3f036e4c9bd8f8a72bec3823ffb [9/18] ASoC: force to use DPCM on normal connection
config: loongarch-randconfig-r034-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200605.fs9SeJdA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/525984dfed23d3f036e4c9bd8f8a72bec3823ffb
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound2-2022-07-08-v1
        git checkout 525984dfed23d3f036e4c9bd8f8a72bec3823ffb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/soc-core.c:966:5: warning: no previous prototype for '__snd_soc_add_pcm_runtime' [-Wmissing-prototypes]
     966 | int __snd_soc_add_pcm_runtime(struct snd_soc_card *card,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__snd_soc_add_pcm_runtime +966 sound/soc/soc-core.c

   954	
   955	/**
   956	 * snd_soc_add_pcm_runtime - Add a pcm_runtime dynamically via dai_link
   957	 * @card: The ASoC card to which the pcm_runtime is added
   958	 * @dai_link: The DAI link to find pcm_runtime
   959	 *
   960	 * This function adds a pcm_runtime ASoC card by using dai_link.
   961	 *
   962	 * Note: Topology can use this API to add pcm_runtime when probing the
   963	 * topology component. And machine drivers can still define static
   964	 * DAI links in dai_link array.
   965	 */
 > 966	int __snd_soc_add_pcm_runtime(struct snd_soc_card *card,
   967				    struct snd_soc_dai_link *dai_link)
   968	{
   969		struct snd_soc_pcm_runtime *rtd;
   970		struct snd_soc_dai_link_component *codec, *platform, *cpu;
   971		struct snd_soc_component *component;
   972		int i, ret;
   973	
   974		lockdep_assert_held(&client_mutex);
   975	
   976		/*
   977		 * Notify the machine driver for extra initialization
   978		 */
   979		ret = snd_soc_card_add_dai_link(card, dai_link);
   980		if (ret < 0)
   981			return ret;
   982	
   983		if (dai_link->ignore)
   984			return 0;
   985	
   986		dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
   987	
   988		ret = soc_dai_link_sanity_check(card, dai_link);
   989		if (ret < 0)
   990			return ret;
   991	
   992		rtd = soc_new_pcm_runtime(card, dai_link);
   993		if (!rtd)
   994			return -ENOMEM;
   995	
   996		for_each_link_cpus(dai_link, i, cpu) {
   997			asoc_rtd_to_cpu(rtd, i) = snd_soc_find_dai(cpu);
   998			if (!asoc_rtd_to_cpu(rtd, i)) {
   999				dev_info(card->dev, "ASoC: CPU DAI %s not registered\n",
  1000					 cpu->dai_name);
  1001				goto _err_defer;
  1002			}
  1003			snd_soc_rtd_add_component(rtd, asoc_rtd_to_cpu(rtd, i)->component);
  1004		}
  1005	
  1006		/* Find CODEC from registered CODECs */
  1007		for_each_link_codecs(dai_link, i, codec) {
  1008			asoc_rtd_to_codec(rtd, i) = snd_soc_find_dai(codec);
  1009			if (!asoc_rtd_to_codec(rtd, i)) {
  1010				dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
  1011					 codec->dai_name);
  1012				goto _err_defer;
  1013			}
  1014	
  1015			snd_soc_rtd_add_component(rtd, asoc_rtd_to_codec(rtd, i)->component);
  1016		}
  1017	
  1018		/* Find PLATFORM from registered PLATFORMs */
  1019		for_each_link_platforms(dai_link, i, platform) {
  1020			for_each_component(component) {
  1021				if (!snd_soc_is_matching_component(platform, component))
  1022					continue;
  1023	
  1024				snd_soc_rtd_add_component(rtd, component);
  1025			}
  1026		}
  1027	
  1028		return 0;
  1029	
  1030	_err_defer:
  1031		snd_soc_remove_pcm_runtime(card, rtd);
  1032		return -EPROBE_DEFER;
  1033	}
  1034	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
