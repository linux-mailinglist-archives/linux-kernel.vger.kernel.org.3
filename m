Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25975749A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiGNJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiGNJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:51:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB74D164
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657792277; x=1689328277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WBUTw7tz+k6O2goVYiYebYBag5C/B83mURXLeuUbsu0=;
  b=Bcofn7GSZLpviDdHZvKqh9fmm3OOmmRs/09CGH5Gwr7KnzODP4Oib5ON
   yHVMjhjtO8cMvqMKqBiKDvnd08J5ErUqE3xv21tyqryKlkQiNssK9kJjf
   MprxJ7zJDzL0euZmh8DK9985DZW5aL04Jarj804XPkVi5qmEZ/9mxq8La
   S45py14iPMVYFxvUF9B8snFdNtr06L7b7jWLPZjmBVcqDocGuOuwiw6/i
   aWwxkvoIYK9YIYsH00fDsB3Sz5FfjG2bxBmouRi6sG4dPQa2cMJpfRL6N
   2nVB6YkrouC6AYmpRw/AOb+rPNpcQQG5j6NCFkG6irj5JrP22kTPMBrVs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265256148"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265256148"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 02:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="596036079"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2022 02:51:07 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBvUx-0000PQ-3j;
        Thu, 14 Jul 2022 09:51:07 +0000
Date:   Thu, 14 Jul 2022 17:50:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morimoto:sound-2022-07-04-v1 23/23]
 sound/soc/codecs/wcd9335.c:2070:4: error: field designator 'playback' does
 not refer to any field in type 'struct snd_soc_dai_driver'
Message-ID: <202207141741.fIItLaEd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound-2022-07-04-v1
head:   e9efd77b37adcddf8f910f34dd0df06be9d896cb
commit: e9efd77b37adcddf8f910f34dd0df06be9d896cb [23/23] remove
config: arm64-randconfig-r001-20220714 (https://download.01.org/0day-ci/archive/20220714/202207141741.fIItLaEd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/morimoto/linux/commit/e9efd77b37adcddf8f910f34dd0df06be9d896cb
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound-2022-07-04-v1
        git checkout e9efd77b37adcddf8f910f34dd0df06be9d896cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/codecs/wcd9335.c:2070:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
>> sound/soc/codecs/wcd9335.c:2085:4: error: field designator 'capture' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .capture = {
                    ^
   sound/soc/codecs/wcd9335.c:2099:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
   sound/soc/codecs/wcd9335.c:2114:4: error: field designator 'capture' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .capture = {
                    ^
   sound/soc/codecs/wcd9335.c:2128:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
   sound/soc/codecs/wcd9335.c:2143:4: error: field designator 'capture' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .capture = {
                    ^
   sound/soc/codecs/wcd9335.c:2157:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
>> sound/soc/codecs/wcd9335.c:4930:13: error: invalid application of 'sizeof' to an incomplete type 'struct snd_soc_dai_driver[]'
                                                  ARRAY_SIZE(wcd9335_slim_dais));
                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   8 errors generated.
--
>> sound/soc/codecs/wcd934x.c:2022:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
>> sound/soc/codecs/wcd934x.c:2036:4: error: field designator 'capture' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .capture = {
                    ^
   sound/soc/codecs/wcd934x.c:2050:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
   sound/soc/codecs/wcd934x.c:2064:4: error: field designator 'capture' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .capture = {
                    ^
   sound/soc/codecs/wcd934x.c:2078:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
   sound/soc/codecs/wcd934x.c:2092:4: error: field designator 'capture' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .capture = {
                    ^
   sound/soc/codecs/wcd934x.c:2106:4: error: field designator 'playback' does not refer to any field in type 'struct snd_soc_dai_driver'
                   .playback = {
                    ^
>> sound/soc/codecs/wcd934x.c:5949:13: error: invalid application of 'sizeof' to an incomplete type 'struct snd_soc_dai_driver[]'
                                                  ARRAY_SIZE(wcd934x_slim_dais));
                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   8 errors generated.


vim +2070 sound/soc/codecs/wcd9335.c

20aedafdf4926e Srinivas Kandagatla 2019-01-28  2065  
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2066  static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2067  	[0] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2068  		.name = "wcd9335_rx1",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2069  		.id = AIF1_PB,
20aedafdf4926e Srinivas Kandagatla 2019-01-28 @2070  		.playback = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2071  			.stream_name = "AIF1 Playback",
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2072  			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2073  				 SNDRV_PCM_RATE_384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2074  			.formats = WCD9335_FORMATS_S16_S24_LE,
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2075  			.rate_max = 384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2076  			.rate_min = 8000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2077  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2078  			.channels_max = 2,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2079  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2080  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2081  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2082  	[1] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2083  		.name = "wcd9335_tx1",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2084  		.id = AIF1_CAP,
20aedafdf4926e Srinivas Kandagatla 2019-01-28 @2085  		.capture = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2086  			.stream_name = "AIF1 Capture",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2087  			.rates = WCD9335_RATES_MASK,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2088  			.formats = SNDRV_PCM_FMTBIT_S16_LE,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2089  			.rate_min = 8000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2090  			.rate_max = 192000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2091  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2092  			.channels_max = 4,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2093  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2094  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2095  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2096  	[2] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2097  		.name = "wcd9335_rx2",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2098  		.id = AIF2_PB,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2099  		.playback = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2100  			.stream_name = "AIF2 Playback",
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2101  			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2102  				 SNDRV_PCM_RATE_384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2103  			.formats = WCD9335_FORMATS_S16_S24_LE,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2104  			.rate_min = 8000,
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2105  			.rate_max = 384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2106  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2107  			.channels_max = 2,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2108  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2109  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2110  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2111  	[3] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2112  		.name = "wcd9335_tx2",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2113  		.id = AIF2_CAP,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2114  		.capture = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2115  			.stream_name = "AIF2 Capture",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2116  			.rates = WCD9335_RATES_MASK,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2117  			.formats = SNDRV_PCM_FMTBIT_S16_LE,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2118  			.rate_min = 8000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2119  			.rate_max = 192000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2120  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2121  			.channels_max = 4,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2122  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2123  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2124  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2125  	[4] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2126  		.name = "wcd9335_rx3",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2127  		.id = AIF3_PB,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2128  		.playback = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2129  			.stream_name = "AIF3 Playback",
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2130  			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2131  				 SNDRV_PCM_RATE_384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2132  			.formats = WCD9335_FORMATS_S16_S24_LE,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2133  			.rate_min = 8000,
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2134  			.rate_max = 384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2135  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2136  			.channels_max = 2,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2137  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2138  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2139  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2140  	[5] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2141  		.name = "wcd9335_tx3",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2142  		.id = AIF3_CAP,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2143  		.capture = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2144  			.stream_name = "AIF3 Capture",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2145  			.rates = WCD9335_RATES_MASK,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2146  			.formats = SNDRV_PCM_FMTBIT_S16_LE,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2147  			.rate_min = 8000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2148  			.rate_max = 192000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2149  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2150  			.channels_max = 4,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2151  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2152  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2153  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2154  	[6] = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2155  		.name = "wcd9335_rx4",
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2156  		.id = AIF4_PB,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2157  		.playback = {
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2158  			.stream_name = "AIF4 Playback",
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2159  			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2160  				 SNDRV_PCM_RATE_384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2161  			.formats = WCD9335_FORMATS_S16_S24_LE,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2162  			.rate_min = 8000,
a8a652bfac7f4a Srinivas Kandagatla 2019-08-22  2163  			.rate_max = 384000,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2164  			.channels_min = 1,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2165  			.channels_max = 2,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2166  		},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2167  		.ops = &wcd9335_dai_ops,
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2168  	},
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2169  };
20aedafdf4926e Srinivas Kandagatla 2019-01-28  2170  

:::::: The code at line 2070 was first introduced by commit
:::::: 20aedafdf4926e7a957f8b302a18c8fb75c7e332 ASoC: wcd9335: add support to wcd9335 codec

:::::: TO: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
