Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBD49B495
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382317AbiAYNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:04:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:21069 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575013AbiAYNBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643115666; x=1674651666;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X1fyuPAYh4vf5QxrIufXZDZkc0gZM2IUh5SxBY0dqsY=;
  b=LpRup+gQ53xiZz2YouwLWY8qlSoslHr2wMTOpQcSi32nNRqDoYoVdeIy
   jRaeJbbpArKJfzcyHgknMXhNWNnjA2dryyYE/bP21Yd7POAe1AutJ+ha9
   Xy6Q0mVNc9j/rmVmnByMWRsraJgQfc7rL+pwFKftjIpUEWvnI8f2lWguh
   PpMot4mbR8gCAGWds5pqitKLrYV7KYso4L6GYUNKuI8PUAQ0hlGVg0M+j
   uzZfKTnBqP1Gx7kM7Vo+yXif1f81e8pfHmUGk2wWX+ea1VaS1n0BcbBiN
   DJTaT+AgllsSWo5pQHlp7c7d5Yxp+gWU8mMsBvf1Ipa0CYSNxr+loqDhF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332646477"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="332646477"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:00:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="627919516"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2022 05:00:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCLRN-000JuO-N1; Tue, 25 Jan 2022 13:00:53 +0000
Date:   Tue, 25 Jan 2022 21:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:2022-01-25-v1 14/14] sound/soc/codecs/ak4613.c:368:22:
 warning: variable 'mode' set but not used
Message-ID: <202201252035.TZSfGzJd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux 2022-01-25-v1
head:   017a564213d399374d186cdb1e80233243ad113a
commit: 017a564213d399374d186cdb1e80233243ad113a [14/14] hog
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220125/202201252035.TZSfGzJd-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/017a564213d399374d186cdb1e80233243ad113a
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto 2022-01-25-v1
        git checkout 017a564213d399374d186cdb1e80233243ad113a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/codecs/ak4613.c: In function 'ak4613_hw_constraints':
>> sound/soc/codecs/ak4613.c:368:22: warning: variable 'mode' set but not used [-Wunused-but-set-variable]
     368 |         unsigned int mode;
         |                      ^~~~


vim +/mode +368 sound/soc/codecs/ak4613.c

   340	
   341	static void ak4613_hw_constraints(struct snd_soc_component *component,
   342					  struct snd_pcm_substream *substream)
   343	{
   344		struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
   345		struct snd_pcm_runtime *runtime = substream->runtime;
   346		static const unsigned int ak4613_rates[] = {
   347			 32000,
   348			 44100,
   349			 48000,
   350			 64000,
   351			 88200,
   352			 96000,
   353			176400,
   354			192000,
   355		};
   356	#define AK4613_CHANNEL_2	0
   357	#define AK4613_CHANNEL_4	1
   358	#define AK4613_CHANNEL_8	2
   359	#define AK4613_CHANNEL_12	3
   360		static const unsigned int ak4613_channels[] = {
   361			[AK4613_CHANNEL_2]  =  2,
   362			[AK4613_CHANNEL_4]  =  4,
   363			[AK4613_CHANNEL_8]  =  8,
   364			[AK4613_CHANNEL_12] = 12,
   365		};
   366		struct snd_pcm_hw_constraint_list *constraint;
   367		unsigned int mask;
 > 368		unsigned int mode;
   369		unsigned int fs;
   370		int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
   371		int i;
   372	
   373		constraint = &priv->constraint_rates;
   374		constraint->list	= ak4613_rates;
   375		constraint->mask	= 0;
   376		constraint->count	= 0;
   377	
   378		/*
   379		 * Slave Mode
   380		 *	Normal: [32kHz, 48kHz] : 256fs,384fs or 512fs
   381		 *	Double: [64kHz, 96kHz] : 256fs
   382		 *	Quad  : [128kHz,192kHz]: 128fs
   383		 *
   384		 * Master mode
   385		 *	Normal: [32kHz, 48kHz] : 256fs or 512fs
   386		 *	Double: [64kHz, 96kHz] : 256fs
   387		 *	Quad  : [128kHz,192kHz]: 128fs
   388		 */
   389		for (i = 0; i < ARRAY_SIZE(ak4613_rates); i++) {
   390			/* minimum fs on each range */
   391			fs = (ak4613_rates[i] <= 96000) ? 256 : 128;
   392	
   393			if (priv->sysclk >= ak4613_rates[i] * fs)
   394				constraint->count = i + 1;
   395		}
   396	
   397		snd_pcm_hw_constraint_list(runtime, 0,
   398					SNDRV_PCM_HW_PARAM_RATE, constraint);
   399	
   400		mode = 0;
   401		if (AK4613_CONFIG_GET(priv, MODE) == AK4613_CONFIG_MODE_STEREO) {
   402			/*
   403			 * If board supports STEREO only
   404			 */
   405			mode = mask = (1 << AK4613_CHANNEL_2);
   406		} else {
   407			/*
   408			 * If board supports TDM
   409			 */
   410			unsigned int mode = 0;
   411			int sdti_num = AK4613_CONFIG_SDTI_num(priv);
   412	
   413			if (priv->cnt) {
   414				/*
   415				 * If it was already working,
   416				 * the constraint is same as working setting.
   417				 */
   418				mode = AK4613_INTERFACE_MODE(priv);
   419				mask = 0; /* no default */
   420			} else {
   421				/*
   422				 * It is not yet working,
   423				 * the constraint is based on board configs.
   424				 */
   425				mode = AK4613_CONFIG_GET(priv, MODE);
   426				mask = (1 << AK4613_CHANNEL_2); /* STEREO is default */
   427			}
   428	
   429			/* FIXME: not yet full support */
   430			switch(mode) {
   431			case AK4613_CONFIG_MODE_STEREO:
   432				mask |= (1 << AK4613_CHANNEL_2);
   433				break;
   434			case AK4613_CONFIG_MODE_TDM256:
   435				if (is_play) {
   436					switch (sdti_num) {
   437					case 1:
   438						mask |= (1 << AK4613_CHANNEL_8);
   439						break;
   440					case 2:
   441						/* NOT TESTED */
   442						mask |= (1 << AK4613_CHANNEL_12);
   443						WARN_ON(1);
   444						break;
   445					default:
   446						BUG();
   447						break;
   448					}
   449				} else {
   450					mask |= (1 << AK4613_CHANNEL_4);
   451				}
   452				break;
   453			/* NOT SUPPORTED */
   454			case AK4613_CONFIG_MODE_TDM512:
   455			case AK4613_CONFIG_MODE_TDM128:
   456			default:
   457				BUG();
   458			}
   459		}
   460	
   461		constraint = &priv->constraint_channels;
   462	
   463		constraint->list	= ak4613_channels;
   464		constraint->mask	= mask;
   465		constraint->count	= sizeof(ak4613_channels);
   466		snd_pcm_hw_constraint_list(runtime, 0,
   467					   SNDRV_PCM_HW_PARAM_CHANNELS, constraint);
   468	}
   469	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
