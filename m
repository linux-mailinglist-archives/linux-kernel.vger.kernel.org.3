Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36414EE63A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiDACrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiDACrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:47:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA76195D93
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648781157; x=1680317157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ndinEXXOHNGpGQlprrrDXd/7g7WQ+qlsYIVKR04pRU=;
  b=BtyITbb5b3SUWCCo8LzRxxCP0Q3GMcYm18wHYEcng9GFWNCZFC7F7Jty
   LpPhYA7bFnYmhyjylbaM7RGlL1cVR42AzHquYxXiCaEv5pqBFL2ivLnrQ
   D6A3jQ+5pFHQqRRqdBru2HHr5lGJaNpCvVs3AC1evFvLZYmkP6laGUMnl
   fdhIE7vUerXzaXAqd37PC/dknRp0wWGUPNZ60fhnovQzxxs1RKdlfK0U3
   o1rcMfEBzPngRf74jnuQngwVXJpLG8Ana37l1eju+AoLKtBG1nqvn0vNo
   fJqHeMDGEH0fDI6MDAvYijJ27KSbfhoAdBeSqbJ6CFDn8scJT6bNU2dlL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="284953851"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="284953851"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 19:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="547614251"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2022 19:45:54 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na7IP-0000rc-So;
        Fri, 01 Apr 2022 02:45:53 +0000
Date:   Fri, 1 Apr 2022 10:45:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Yan <michael.yan@starfivetech.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>
Subject: [esmil:visionfive 46/62] sound/soc/starfive/pwmdac-pcm.c:84:6:
 warning: variable 'substream' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202204011048.3Gw5aqvg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walker,

FYI, the error/warning still remains.

tree:   https://github.com/esmil/linux visionfive
head:   6c7cd35771680c033c40b4af48cbe7e3093eab3d
commit: 7c3b27a272448a123087494f7ade3e84a92543c6 [46/62] ASoC: starfive: Add StarFive JH7100 audio drivers
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220401/202204011048.3Gw5aqvg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/esmil/linux/commit/7c3b27a272448a123087494f7ade3e84a92543c6
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 7c3b27a272448a123087494f7ade3e84a92543c6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/ sound/soc/starfive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/starfive/pwmdac-pcm.c:84:6: warning: variable 'substream' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (push)
               ^~~~
   sound/soc/starfive/pwmdac-pcm.c:87:11: note: uninitialized use occurs here
           active = substream && snd_pcm_running(substream);
                    ^~~~~~~~~
   sound/soc/starfive/pwmdac-pcm.c:84:2: note: remove the 'if' if its condition is always true
           if (push)
           ^~~~~~~~~
   sound/soc/starfive/pwmdac-pcm.c:80:37: note: initialize the variable 'substream' to silence this warning
           struct snd_pcm_substream *substream;
                                              ^
                                               = NULL
>> sound/soc/starfive/pwmdac-pcm.c:92:7: warning: variable 'period_elapsed' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (push) {
                       ^~~~
   sound/soc/starfive/pwmdac-pcm.c:99:7: note: uninitialized use occurs here
                   if (period_elapsed)
                       ^~~~~~~~~~~~~~
   sound/soc/starfive/pwmdac-pcm.c:92:3: note: remove the 'if' if its condition is always true
                   if (push) {
                   ^~~~~~~~~~
   sound/soc/starfive/pwmdac-pcm.c:81:29: note: initialize the variable 'period_elapsed' to silence this warning
           bool active, period_elapsed;
                                      ^
                                       = 0
>> sound/soc/starfive/pwmdac-pcm.c:202:6: warning: variable 'pos' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/starfive/pwmdac-pcm.c:205:9: note: uninitialized use occurs here
           return pos < runtime->buffer_size ? pos : 0;
                  ^~~
   sound/soc/starfive/pwmdac-pcm.c:202:2: note: remove the 'if' if its condition is always true
           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/starfive/pwmdac-pcm.c:200:23: note: initialize the variable 'pos' to silence this warning
           snd_pcm_uframes_t pos;
                                ^
                                 = 0
   3 warnings generated.


vim +84 sound/soc/starfive/pwmdac-pcm.c

    77	
    78	static void sf_pcm_transfer(struct sf_pwmdac_dev *dev, bool push)
    79	{
    80		struct snd_pcm_substream *substream;
    81		bool active, period_elapsed;
    82	
    83		rcu_read_lock();
  > 84		if (push)
    85			substream = rcu_dereference(dev->tx_substream);
    86	
    87		active = substream && snd_pcm_running(substream);
    88		if (active) {
    89			unsigned int ptr;
    90			unsigned int new_ptr;
    91	
  > 92			if (push) {
    93				ptr = READ_ONCE(dev->tx_ptr);
    94				new_ptr = dev->tx_fn(dev, substream->runtime, ptr,
    95						&period_elapsed);
    96				cmpxchg(&dev->tx_ptr, ptr, new_ptr);
    97			}
    98	
    99			if (period_elapsed)
   100				snd_pcm_period_elapsed(substream);
   101		}
   102		rcu_read_unlock();
   103	}
   104	
   105	void sf_pwmdac_pcm_push_tx(struct sf_pwmdac_dev *dev)
   106	{
   107		sf_pcm_transfer(dev, true);
   108	}
   109	
   110	
   111	static int sf_pcm_open(struct snd_soc_component *component,
   112				struct snd_pcm_substream *substream)
   113	{
   114		struct snd_pcm_runtime *runtime = substream->runtime;
   115		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
   116		struct sf_pwmdac_dev *dev = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
   117	
   118		snd_soc_set_runtime_hwparams(substream, &sf_pcm_hardware);
   119		snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
   120		runtime->private_data = dev;
   121	
   122		return 0;
   123	}
   124	
   125	
   126	static int sf_pcm_close(struct snd_soc_component *component,
   127				struct snd_pcm_substream *substream)
   128	{
   129		synchronize_rcu();
   130		return 0;
   131	}
   132	
   133	static int sf_pcm_hw_params(struct snd_soc_component *component,
   134				struct snd_pcm_substream *substream,
   135				struct snd_pcm_hw_params *hw_params)
   136	{
   137		struct snd_pcm_runtime *runtime = substream->runtime;
   138		struct sf_pwmdac_dev *dev = runtime->private_data;
   139	
   140		switch (params_channels(hw_params)) {
   141		case 2:
   142			break;
   143		default:
   144			dev_err(dev->dev, "invalid channels number\n");
   145			return -EINVAL;
   146		}
   147	
   148		switch (params_format(hw_params)) {
   149		case SNDRV_PCM_FORMAT_U8:
   150		case SNDRV_PCM_FORMAT_S8:
   151			dev->tx_fn = sf_pwmdac_pcm_tx_8;
   152			break;
   153		case SNDRV_PCM_FORMAT_S16_LE:
   154			dev->tx_fn = sf_pwmdac_pcm_tx_16;
   155			break;
   156		default:
   157			dev_err(dev->dev, "invalid format\n");
   158			return -EINVAL;
   159		}
   160	
   161			return 0;
   162	}
   163	
   164	
   165	static int sf_pcm_trigger(struct snd_soc_component *component,
   166				struct snd_pcm_substream *substream, int cmd)
   167	{
   168		struct snd_pcm_runtime *runtime = substream->runtime;
   169		struct sf_pwmdac_dev *dev = runtime->private_data;
   170		int ret = 0;
   171	
   172		switch (cmd) {
   173		case SNDRV_PCM_TRIGGER_START:
   174		case SNDRV_PCM_TRIGGER_RESUME:
   175		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
   176			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
   177				WRITE_ONCE(dev->tx_ptr, 0);
   178				rcu_assign_pointer(dev->tx_substream, substream);
   179			}
   180			break;
   181		case SNDRV_PCM_TRIGGER_STOP:
   182		case SNDRV_PCM_TRIGGER_SUSPEND:
   183		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
   184			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
   185				rcu_assign_pointer(dev->tx_substream, NULL);
   186			break;
   187		default:
   188			ret = -EINVAL;
   189			break;
   190		}
   191	
   192		return ret;
   193	}
   194	
   195	static snd_pcm_uframes_t sf_pcm_pointer(struct snd_soc_component *component,
   196				struct snd_pcm_substream *substream)
   197	{
   198		struct snd_pcm_runtime *runtime = substream->runtime;
   199		struct sf_pwmdac_dev *dev = runtime->private_data;
   200		snd_pcm_uframes_t pos;
   201	
 > 202		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
   203			pos = READ_ONCE(dev->tx_ptr);
   204	
   205		return pos < runtime->buffer_size ? pos : 0;
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
