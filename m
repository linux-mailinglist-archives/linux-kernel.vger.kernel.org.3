Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7849C7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiAZKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:42:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:21881 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240118AbiAZKmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643193769; x=1674729769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bQNdzWn2Nl40jabR5NuwIKr8kpq4teRdP0iXGQFEO2U=;
  b=SVyqyhb8iuV9cB+wUCTQO7wFmgw9qvCkTAQynlKBgNBYKJHADl3P2R+6
   5A9zNEbSrFPDYt2CWs2LEiGFk3XJ5si2lhMVMjFl4sUdQBZgzxTZHtfSU
   9Trt9WV4+8QBOHWHx/8ZRJ7fX2YhEAlgssf+d6cOu42rS478vgOsrRMTD
   pqnfjm3C3tns0a2Gc8tHnbMLoMCbWMVfq66Tt770x9KjWGVeJhrKZcVxB
   ecbUG+Nm2KmxRCKzK/Ubgc/vKxZBRALqu0S6twwjp2dTeu2ZOrf6F4Zac
   PYUMzhhcygcZsRu/VLun1udmgQCExbfijF14ddAKQE0s4fidyQpLz0/IF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246301492"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="246301492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 02:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="520750827"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2022 02:42:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCflG-000L5h-T2; Wed, 26 Jan 2022 10:42:46 +0000
Date:   Wed, 26 Jan 2022 18:42:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:2022-01-26-v1 15/15] sound/soc/codecs/ak4613.c:429:32:
 error: implicit declaration of function 'AK4613_INTERFACE_MODE'
Message-ID: <202201261854.xQ9EBbEC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux 2022-01-26-v1
head:   05a038a4ac9687be3887060557d4ea520651f286
commit: 05a038a4ac9687be3887060557d4ea520651f286 [15/15] hog
config: arc-randconfig-r024-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261854.xQ9EBbEC-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/05a038a4ac9687be3887060557d4ea520651f286
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto 2022-01-26-v1
        git checkout 05a038a4ac9687be3887060557d4ea520651f286
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/ak4613.c: In function 'ak4613_hw_constraints':
>> sound/soc/codecs/ak4613.c:429:32: error: implicit declaration of function 'AK4613_INTERFACE_MODE' [-Werror=implicit-function-declaration]
     429 |                         mode = AK4613_INTERFACE_MODE(priv);
         |                                ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from sound/soc/codecs/ak4613.c:46:
   sound/soc/codecs/ak4613.c: In function 'ak4613_dai_hw_params':
>> sound/soc/codecs/ak4613.c:579:30: error: too few arguments to function 'ak4613_dai_fmt_matching'
     579 |                         if (!ak4613_dai_fmt_matching(iface, fmt, width))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   sound/soc/codecs/ak4613.c:579:25: note: in expansion of macro 'if'
     579 |                         if (!ak4613_dai_fmt_matching(iface, fmt, width))
         |                         ^~
   sound/soc/codecs/ak4613.c:519:13: note: declared here
     519 | static bool ak4613_dai_fmt_matching(const struct ak4613_interface *iface,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from sound/soc/codecs/ak4613.c:46:
>> sound/soc/codecs/ak4613.c:579:30: error: too few arguments to function 'ak4613_dai_fmt_matching'
     579 |                         if (!ak4613_dai_fmt_matching(iface, fmt, width))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   sound/soc/codecs/ak4613.c:579:25: note: in expansion of macro 'if'
     579 |                         if (!ak4613_dai_fmt_matching(iface, fmt, width))
         |                         ^~
   sound/soc/codecs/ak4613.c:519:13: note: declared here
     519 | static bool ak4613_dai_fmt_matching(const struct ak4613_interface *iface,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from sound/soc/codecs/ak4613.c:46:
>> sound/soc/codecs/ak4613.c:579:30: error: too few arguments to function 'ak4613_dai_fmt_matching'
     579 |                         if (!ak4613_dai_fmt_matching(iface, fmt, width))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   sound/soc/codecs/ak4613.c:579:25: note: in expansion of macro 'if'
     579 |                         if (!ak4613_dai_fmt_matching(iface, fmt, width))
         |                         ^~
   sound/soc/codecs/ak4613.c:519:13: note: declared here
     519 | static bool ak4613_dai_fmt_matching(const struct ak4613_interface *iface,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/ak4613.c:537:22: warning: unused variable 'channel' [-Wunused-variable]
     537 |         unsigned int channel = params_channels(params);
         |                      ^~~~~~~
   cc1: some warnings being treated as errors


vim +/AK4613_INTERFACE_MODE +429 sound/soc/codecs/ak4613.c

   335	
   336	static int ak4613_hw_constraints(struct snd_soc_component *component,
   337					 struct snd_pcm_substream *substream)
   338	{
   339		struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
   340		struct snd_pcm_runtime *runtime = substream->runtime;
   341		static const unsigned int ak4613_rates[] = {
   342			 32000,
   343			 44100,
   344			 48000,
   345			 64000,
   346			 88200,
   347			 96000,
   348			176400,
   349			192000,
   350		};
   351	#define AK4613_CHANNEL_2	 0
   352	#define AK4613_CHANNEL_4	 1
   353	#define AK4613_CHANNEL_8	 2
   354	#define AK4613_CHANNEL_12	 3
   355	#define AK4613_CHANNEL_NONE	-1
   356		static const unsigned int ak4613_channels[] = {
   357			[AK4613_CHANNEL_2]  =  2,
   358			[AK4613_CHANNEL_4]  =  4,
   359			[AK4613_CHANNEL_8]  =  8,
   360			[AK4613_CHANNEL_12] = 12,
   361		};
   362	#define MODE_MAX 4
   363	#define SDT_MAX  4
   364	#define MASK_LIST(mode, c, p1, p2, p3)		\
   365		[AK4613_CONFIG_MODE_##mode] =	{	\
   366			AK4613_CHANNEL_##c,		\
   367			AK4613_CHANNEL_##p1,		\
   368			AK4613_CHANNEL_##p2,		\
   369			AK4613_CHANNEL_##p3}
   370		static const int mask_shift_list[MODE_MAX][SDT_MAX] = {
   371			/*
   372			 * mask shift for
   373			 *	[0] : capture
   374			 *	[1] : playback SDTIx1
   375			 *	[2] : playback SDTIx2
   376			 *	[3] : playback SDTIx3
   377			 */
   378			MASK_LIST(STEREO, 2,  2, NONE, NONE),
   379			MASK_LIST(TDM512, 4, 12, NONE, NONE),
   380			MASK_LIST(TDM256, 4,  8, 12,   NONE),
   381			MASK_LIST(TDM128, 4,  4,  8,     12),
   382		};
   383		struct snd_pcm_hw_constraint_list *constraint;
   384		unsigned int mask;
   385		unsigned int mode;
   386		unsigned int fs;
   387		int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
   388		int i, shift, sdti_num;
   389	
   390		constraint		= &priv->constraint_rates;
   391		constraint->list	= ak4613_rates;
   392		constraint->mask	= 0;
   393		constraint->count	= 0;
   394	
   395		/*
   396		 * Slave Mode
   397		 *	Normal: [32kHz, 48kHz] : 256fs,384fs or 512fs
   398		 *	Double: [64kHz, 96kHz] : 256fs
   399		 *	Quad  : [128kHz,192kHz]: 128fs
   400		 *
   401		 * Master mode
   402		 *	Normal: [32kHz, 48kHz] : 256fs or 512fs
   403		 *	Double: [64kHz, 96kHz] : 256fs
   404		 *	Quad  : [128kHz,192kHz]: 128fs
   405		*/
   406		for (i = 0; i < ARRAY_SIZE(ak4613_rates); i++) {
   407			/* minimum fs on each range */
   408			fs = (ak4613_rates[i] <= 96000) ? 256 : 128;
   409	
   410			if (priv->sysclk >= ak4613_rates[i] * fs)
   411				constraint->count = i + 1;
   412		}
   413	
   414		snd_pcm_hw_constraint_list(runtime, 0,
   415					SNDRV_PCM_HW_PARAM_RATE, constraint);
   416	
   417		/* default : STEREO */
   418		mode	 = AK4613_CONFIG_MODE_STEREO;
   419		mask	 = 0;
   420		sdti_num = AK4613_CONFIG_SDTI_get(priv);
   421	
   422		/* update if board supports TDM mode */
   423		if (AK4613_CONFIG_GET(priv, MODE) != AK4613_CONFIG_MODE_STEREO) {
   424			if (priv->cnt) {
   425				/*
   426				 * If it was already working,
   427				 * the constraint is same as working setting.
   428				 */
 > 429				mode = AK4613_INTERFACE_MODE(priv);
   430			} else {
   431				/*
   432				 * It is not yet working,
   433				 * the constraint is based on board configs.
   434				 */
   435				mode = AK4613_CONFIG_GET(priv, MODE);
   436				mask = (1 << AK4613_CHANNEL_2); /* STEREO is default */
   437			}
   438		}
   439	
   440		if (mode	>= MODE_MAX ||
   441		    sdti_num	>= SDT_MAX)
   442			return -EINVAL;
   443	
   444		shift = mask_shift_list[mode][is_play * sdti_num];
   445		if (shift < 0) /* in case of AK4613_CHANNEL_NONE */
   446			return -EINVAL;
   447	
   448		mask |= 1 << shift;
   449	printk("----mask %x\n", mask);
   450		constraint		= &priv->constraint_channels;
   451		constraint->list	= ak4613_channels;
   452		constraint->mask	= mask;
   453		constraint->count	= sizeof(ak4613_channels);
   454		snd_pcm_hw_constraint_list(runtime, 0,
   455					   SNDRV_PCM_HW_PARAM_CHANNELS, constraint);
   456	
   457		return 0;
   458	}
   459	
   460	static int ak4613_dai_startup(struct snd_pcm_substream *substream,
   461				      struct snd_soc_dai *dai)
   462	{
   463		struct snd_soc_component *component = dai->component;
   464		struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
   465		int ret = 0;
   466	
   467		mutex_lock(&priv->lock);
   468		ret = ak4613_hw_constraints(component, substream);
   469		if (ret == 0)
   470			priv->cnt++;
   471		mutex_unlock(&priv->lock);
   472	
   473		return ret;
   474	}
   475	
   476	static int ak4613_dai_set_sysclk(struct snd_soc_dai *codec_dai,
   477					 int clk_id, unsigned int freq, int dir)
   478	{
   479		struct snd_soc_component *component = codec_dai->component;
   480		struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
   481	
   482		priv->sysclk = freq;
   483	
   484		return 0;
   485	}
   486	
   487	static int ak4613_dai_set_fmt(struct snd_soc_dai *dai, unsigned int format)
   488	{
   489		struct snd_soc_component *component = dai->component;
   490		struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
   491		unsigned int fmt;
   492	
   493		fmt = format & SND_SOC_DAIFMT_FORMAT_MASK;
   494		switch (fmt) {
   495		case SND_SOC_DAIFMT_LEFT_J:
   496		case SND_SOC_DAIFMT_I2S:
   497			priv->fmt = fmt;
   498			break;
   499		default:
   500			return -EINVAL;
   501		}
   502	
   503		fmt = format & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
   504		switch (fmt) {
   505		case SND_SOC_DAIFMT_CBC_CFC:
   506			break;
   507		default:
   508			/*
   509			 * SUPPORTME
   510			 *
   511			 * "clock provider" is not yet supperted
   512			 */
   513			return -EINVAL;
   514		}
   515	
   516		return 0;
   517	}
   518	
   519	static bool ak4613_dai_fmt_matching(const struct ak4613_interface *iface,
   520					    unsigned int fmt, unsigned int width, unsigned int channel)
   521	{
   522		if ((iface->fmt		== fmt) &&
   523		    (iface->width	== width))
   524			return true;
   525	
   526		return false;
   527	}
   528	
   529	static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
   530					struct snd_pcm_hw_params *params,
   531					struct snd_soc_dai *dai)
   532	{
   533		struct snd_soc_component *component = dai->component;
   534		struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
   535		struct device *dev = component->dev;
   536		unsigned int width = params_width(params);
   537		unsigned int channel = params_channels(params);
   538		unsigned int fmt = priv->fmt;
   539		unsigned int rate;
   540		int i, ret;
   541		u8 ctrl2;
   542	
   543		rate = params_rate(params);
   544		switch (rate) {
   545		case 32000:
   546		case 44100:
   547		case 48000:
   548			ctrl2 = DFS_NORMAL_SPEED;
   549			break;
   550		case 64000:
   551		case 88200:
   552		case 96000:
   553			ctrl2 = DFS_DOUBLE_SPEED;
   554			break;
   555		case 176400:
   556		case 192000:
   557			ctrl2 = DFS_QUAD_SPEED;
   558			break;
   559		default:
   560			return -EINVAL;
   561		}
   562		priv->rate = rate;
   563	
   564		/*
   565		 * FIXME
   566		 *
   567		 * It doesn't have all TDM suppert
   568		 */
   569		ret = -EINVAL;
   570	
   571		mutex_lock(&priv->lock);
   572		if (priv->cnt > 1) {
   573			ret = 0;
   574		} else {
   575			const struct ak4613_interface *iface;
   576	
   577			for (i = ARRAY_SIZE(ak4613_iface) - 1; i >= 0; i--) {
   578				iface = ak4613_iface + i;
 > 579				if (!ak4613_dai_fmt_matching(iface, fmt, width))
   580					continue;
   581				priv->ctrl1 = (iface->dif << 3);
   582				ret = 0;
   583				break;
   584			}
   585		}
   586		mutex_unlock(&priv->lock);
   587	
   588		if (ret < 0)
   589			goto hw_params_end;
   590	
   591		snd_soc_component_update_bits(component, CTRL1, FMT_MASK, priv->ctrl1);
   592		snd_soc_component_update_bits(component, CTRL2, DFS_MASK, ctrl2);
   593	
   594		snd_soc_component_update_bits(component, ICTRL, ICTRL_MASK, priv->ic);
   595		snd_soc_component_update_bits(component, OCTRL, OCTRL_MASK, priv->oc);
   596	
   597	hw_params_end:
   598		if (ret < 0)
   599			dev_warn(dev, "unsupported data width/format combination\n");
   600	
   601		return ret;
   602	}
   603	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
