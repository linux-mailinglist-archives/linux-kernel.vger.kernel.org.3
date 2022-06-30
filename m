Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C75561887
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiF3Kru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiF3Krr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:47:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14A10E0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656586066; x=1688122066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1VfU8SRjKjsTdI2pN2BKb6S9TF8HBN5Cif6Hblidadk=;
  b=KFusy9cUbSkcBJ7teqG0eSBI9YaLa0A9lr6gmieg13C9QrIxxG23ug6/
   NzI2Dp0luG0czBkIBP7vORaILtZB9RNhlXYIfbNRQLFQOXCNd+jElDYjY
   cIYmF91h29yiZ4M/FQUm5ucnBI5twWnRChI7wJixwe85naLhtduflcdHU
   uHbvPyqUmQUCOKH6Sp0qLFheP0heVfVsYUspYIgW8gmsifjTCsDusxl/p
   Odp+ayNXOuiQLlehpAz5Wr0wyzwJMVUJDFKQxRW+SPzwE6HVr/EB/C19t
   IjN4KiDgUJVv7WorR57vXlcnhHCkLaLN522KphhNvjFF26fDCkLDFPzKc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279859634"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="279859634"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="694005410"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 03:47:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6ri4-000CcW-88;
        Thu, 30 Jun 2022 10:47:44 +0000
Date:   Thu, 30 Jun 2022 18:47:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound-2022-06-30-v3 19/19]
 sound/soc/codecs/jz4770.c:768:10: error: 'struct snd_soc_dai_driver' has no
 member named 'playback'
Message-ID: <202206301824.JlMLdHKl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound-2022-06-30-v3
head:   fc6f65d23a318462b8e17cdf7db622dfc7719ac7
commit: fc6f65d23a318462b8e17cdf7db622dfc7719ac7 [19/19] remove
config: sparc-randconfig-r011-20220629 (https://download.01.org/0day-ci/archive/20220630/202206301824.JlMLdHKl-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/fc6f65d23a318462b8e17cdf7db622dfc7719ac7
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound-2022-06-30-v3
        git checkout fc6f65d23a318462b8e17cdf7db622dfc7719ac7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash sound/soc/codecs/ sound/soc/sh/ sound/soc/stm/ sound/soc/uniphier/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/codecs/jz4770.c:768:10: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     768 |         .playback = {
         |          ^~~~~~~~
   sound/soc/codecs/jz4770.c:768:9: warning: braces around scalar initializer
     768 |         .playback = {
         |         ^
   sound/soc/codecs/jz4770.c:768:9: note: (near initialization for 'jz4770_codec_dai.id')
>> sound/soc/codecs/jz4770.c:769:17: error: field name not in record or union initializer
     769 |                 .stream_name = "Playback",
         |                 ^
   sound/soc/codecs/jz4770.c:769:17: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:769:32: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
     769 |                 .stream_name = "Playback",
         |                                ^~~~~~~~~~
   sound/soc/codecs/jz4770.c:769:32: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:770:17: error: field name not in record or union initializer
     770 |                 .channels_min = 2,
         |                 ^
   sound/soc/codecs/jz4770.c:770:17: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:770:33: warning: excess elements in scalar initializer
     770 |                 .channels_min = 2,
         |                                 ^
   sound/soc/codecs/jz4770.c:770:33: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:771:17: error: field name not in record or union initializer
     771 |                 .channels_max = 2,
         |                 ^
   sound/soc/codecs/jz4770.c:771:17: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:771:33: warning: excess elements in scalar initializer
     771 |                 .channels_max = 2,
         |                                 ^
   sound/soc/codecs/jz4770.c:771:33: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:772:17: error: field name not in record or union initializer
     772 |                 .rates = SNDRV_PCM_RATE_8000_96000,
         |                 ^
   sound/soc/codecs/jz4770.c:772:17: note: (near initialization for 'jz4770_codec_dai.id')
   In file included from include/sound/pcm_params.h:10,
                    from sound/soc/codecs/jz4770.c:15:
   include/sound/pcm.h:132:41: warning: excess elements in scalar initializer
     132 | #define SNDRV_PCM_RATE_8000_96000       (SNDRV_PCM_RATE_8000_48000|SNDRV_PCM_RATE_64000|\
         |                                         ^
   sound/soc/codecs/jz4770.c:772:26: note: in expansion of macro 'SNDRV_PCM_RATE_8000_96000'
     772 |                 .rates = SNDRV_PCM_RATE_8000_96000,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:132:41: note: (near initialization for 'jz4770_codec_dai.id')
     132 | #define SNDRV_PCM_RATE_8000_96000       (SNDRV_PCM_RATE_8000_48000|SNDRV_PCM_RATE_64000|\
         |                                         ^
   sound/soc/codecs/jz4770.c:772:26: note: in expansion of macro 'SNDRV_PCM_RATE_8000_96000'
     772 |                 .rates = SNDRV_PCM_RATE_8000_96000,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/jz4770.c:773:17: error: field name not in record or union initializer
     773 |                 .formats = JZ_CODEC_FORMATS,
         |                 ^
   sound/soc/codecs/jz4770.c:773:17: note: (near initialization for 'jz4770_codec_dai.id')
   sound/soc/codecs/jz4770.c:761:26: warning: excess elements in scalar initializer
     761 | #define JZ_CODEC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  | \
         |                          ^
   sound/soc/codecs/jz4770.c:773:28: note: in expansion of macro 'JZ_CODEC_FORMATS'
     773 |                 .formats = JZ_CODEC_FORMATS,
         |                            ^~~~~~~~~~~~~~~~
   sound/soc/codecs/jz4770.c:761:26: note: (near initialization for 'jz4770_codec_dai.id')
     761 | #define JZ_CODEC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  | \
         |                          ^
   sound/soc/codecs/jz4770.c:773:28: note: in expansion of macro 'JZ_CODEC_FORMATS'
     773 |                 .formats = JZ_CODEC_FORMATS,
         |                            ^~~~~~~~~~~~~~~~
>> sound/soc/codecs/jz4770.c:775:10: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     775 |         .capture = {
         |          ^~~~~~~
   sound/soc/codecs/jz4770.c:775:9: warning: braces around scalar initializer
     775 |         .capture = {
         |         ^
   sound/soc/codecs/jz4770.c:775:9: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:776:17: error: field name not in record or union initializer
     776 |                 .stream_name = "Capture",
         |                 ^
   sound/soc/codecs/jz4770.c:776:17: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:776:32: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
     776 |                 .stream_name = "Capture",
         |                                ^~~~~~~~~
   sound/soc/codecs/jz4770.c:776:32: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:777:17: error: field name not in record or union initializer
     777 |                 .channels_min = 2,
         |                 ^
   sound/soc/codecs/jz4770.c:777:17: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:777:33: warning: excess elements in scalar initializer
     777 |                 .channels_min = 2,
         |                                 ^
   sound/soc/codecs/jz4770.c:777:33: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:778:17: error: field name not in record or union initializer
     778 |                 .channels_max = 2,
         |                 ^
   sound/soc/codecs/jz4770.c:778:17: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:778:33: warning: excess elements in scalar initializer
     778 |                 .channels_max = 2,
         |                                 ^
   sound/soc/codecs/jz4770.c:778:33: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:779:17: error: field name not in record or union initializer
     779 |                 .rates = SNDRV_PCM_RATE_8000_96000,
         |                 ^
   sound/soc/codecs/jz4770.c:779:17: note: (near initialization for 'jz4770_codec_dai.base')
   In file included from include/sound/pcm_params.h:10,
                    from sound/soc/codecs/jz4770.c:15:
   include/sound/pcm.h:132:41: warning: excess elements in scalar initializer
     132 | #define SNDRV_PCM_RATE_8000_96000       (SNDRV_PCM_RATE_8000_48000|SNDRV_PCM_RATE_64000|\
         |                                         ^
   sound/soc/codecs/jz4770.c:779:26: note: in expansion of macro 'SNDRV_PCM_RATE_8000_96000'
     779 |                 .rates = SNDRV_PCM_RATE_8000_96000,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:132:41: note: (near initialization for 'jz4770_codec_dai.base')
     132 | #define SNDRV_PCM_RATE_8000_96000       (SNDRV_PCM_RATE_8000_48000|SNDRV_PCM_RATE_64000|\
         |                                         ^
   sound/soc/codecs/jz4770.c:779:26: note: in expansion of macro 'SNDRV_PCM_RATE_8000_96000'
     779 |                 .rates = SNDRV_PCM_RATE_8000_96000,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/jz4770.c:780:17: error: field name not in record or union initializer
     780 |                 .formats = JZ_CODEC_FORMATS,
         |                 ^
   sound/soc/codecs/jz4770.c:780:17: note: (near initialization for 'jz4770_codec_dai.base')
   sound/soc/codecs/jz4770.c:761:26: warning: excess elements in scalar initializer
     761 | #define JZ_CODEC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  | \
         |                          ^
   sound/soc/codecs/jz4770.c:780:28: note: in expansion of macro 'JZ_CODEC_FORMATS'
     780 |                 .formats = JZ_CODEC_FORMATS,
         |                            ^~~~~~~~~~~~~~~~
   sound/soc/codecs/jz4770.c:761:26: note: (near initialization for 'jz4770_codec_dai.base')
     761 | #define JZ_CODEC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  | \
         |                          ^
   sound/soc/codecs/jz4770.c:780:28: note: in expansion of macro 'JZ_CODEC_FORMATS'
     780 |                 .formats = JZ_CODEC_FORMATS,
         |                            ^~~~~~~~~~~~~~~~
--
>> sound/soc/codecs/mt6359.c:2587:18: error: 'struct snd_soc_dai_driver' has no member named 'playback'
    2587 |                 .playback = {
         |                  ^~~~~~~~
   sound/soc/codecs/mt6359.c:2587:17: warning: braces around scalar initializer
    2587 |                 .playback = {
         |                 ^
   sound/soc/codecs/mt6359.c:2587:17: note: (near initialization for 'mt6359_dai_driver[0].id')
>> sound/soc/codecs/mt6359.c:2588:25: error: field name not in record or union initializer
    2588 |                         .stream_name = "AIF1 Playback",
         |                         ^
   sound/soc/codecs/mt6359.c:2588:25: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2588:40: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
    2588 |                         .stream_name = "AIF1 Playback",
         |                                        ^~~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2588:40: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2589:25: error: field name not in record or union initializer
    2589 |                         .channels_min = 1,
         |                         ^
   sound/soc/codecs/mt6359.c:2589:25: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2589:41: warning: excess elements in scalar initializer
    2589 |                         .channels_min = 1,
         |                                         ^
   sound/soc/codecs/mt6359.c:2589:41: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2590:25: error: field name not in record or union initializer
    2590 |                         .channels_max = 2,
         |                         ^
   sound/soc/codecs/mt6359.c:2590:25: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2590:41: warning: excess elements in scalar initializer
    2590 |                         .channels_max = 2,
         |                                         ^
   sound/soc/codecs/mt6359.c:2590:41: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2591:25: error: field name not in record or union initializer
    2591 |                         .rates = SNDRV_PCM_RATE_8000_48000 |
         |                         ^
   sound/soc/codecs/mt6359.c:2591:25: note: (near initialization for 'mt6359_dai_driver[0].id')
   In file included from include/sound/soc.h:23,
                    from sound/soc/codecs/mt6359.c:16:
   include/sound/pcm.h:131:41: warning: excess elements in scalar initializer
     131 | #define SNDRV_PCM_RATE_8000_48000       (SNDRV_PCM_RATE_8000_44100|SNDRV_PCM_RATE_48000)
         |                                         ^
   sound/soc/codecs/mt6359.c:2591:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000_48000'
    2591 |                         .rates = SNDRV_PCM_RATE_8000_48000 |
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:131:41: note: (near initialization for 'mt6359_dai_driver[0].id')
     131 | #define SNDRV_PCM_RATE_8000_48000       (SNDRV_PCM_RATE_8000_44100|SNDRV_PCM_RATE_48000)
         |                                         ^
   sound/soc/codecs/mt6359.c:2591:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000_48000'
    2591 |                         .rates = SNDRV_PCM_RATE_8000_48000 |
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2594:25: error: field name not in record or union initializer
    2594 |                         .formats = MT6359_FORMATS,
         |                         ^
   sound/soc/codecs/mt6359.c:2594:25: note: (near initialization for 'mt6359_dai_driver[0].id')
   sound/soc/codecs/mt6359.c:2579:24: warning: excess elements in scalar initializer
    2579 | #define MT6359_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE |\
         |                        ^
   sound/soc/codecs/mt6359.c:2594:36: note: in expansion of macro 'MT6359_FORMATS'
    2594 |                         .formats = MT6359_FORMATS,
         |                                    ^~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2579:24: note: (near initialization for 'mt6359_dai_driver[0].id')
    2579 | #define MT6359_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE |\
         |                        ^
   sound/soc/codecs/mt6359.c:2594:36: note: in expansion of macro 'MT6359_FORMATS'
    2594 |                         .formats = MT6359_FORMATS,
         |                                    ^~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2587:29: warning: initialized field overwritten [-Woverride-init]
    2587 |                 .playback = {
         |                             ^
   sound/soc/codecs/mt6359.c:2587:29: note: (near initialization for 'mt6359_dai_driver[0].id')
>> sound/soc/codecs/mt6359.c:2596:18: error: 'struct snd_soc_dai_driver' has no member named 'capture'
    2596 |                 .capture = {
         |                  ^~~~~~~
   sound/soc/codecs/mt6359.c:2596:17: warning: braces around scalar initializer
    2596 |                 .capture = {
         |                 ^
   sound/soc/codecs/mt6359.c:2596:17: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2597:25: error: field name not in record or union initializer
    2597 |                         .stream_name = "AIF1 Capture",
         |                         ^
   sound/soc/codecs/mt6359.c:2597:25: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2597:40: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
    2597 |                         .stream_name = "AIF1 Capture",
         |                                        ^~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2597:40: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2598:25: error: field name not in record or union initializer
    2598 |                         .channels_min = 1,
         |                         ^
   sound/soc/codecs/mt6359.c:2598:25: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2598:41: warning: excess elements in scalar initializer
    2598 |                         .channels_min = 1,
         |                                         ^
   sound/soc/codecs/mt6359.c:2598:41: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2599:25: error: field name not in record or union initializer
    2599 |                         .channels_max = 2,
         |                         ^
   sound/soc/codecs/mt6359.c:2599:25: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2599:41: warning: excess elements in scalar initializer
    2599 |                         .channels_max = 2,
         |                                         ^
   sound/soc/codecs/mt6359.c:2599:41: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2600:25: error: field name not in record or union initializer
    2600 |                         .rates = SNDRV_PCM_RATE_8000 |
         |                         ^
   sound/soc/codecs/mt6359.c:2600:25: note: (near initialization for 'mt6359_dai_driver[0].base')
   In file included from include/sound/soc.h:23,
                    from sound/soc/codecs/mt6359.c:16:
   include/sound/pcm.h:110:41: warning: excess elements in scalar initializer
     110 | #define SNDRV_PCM_RATE_8000             (1<<1)          /* 8000Hz */
         |                                         ^
   sound/soc/codecs/mt6359.c:2600:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000'
    2600 |                         .rates = SNDRV_PCM_RATE_8000 |
         |                                  ^~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:110:41: note: (near initialization for 'mt6359_dai_driver[0].base')
     110 | #define SNDRV_PCM_RATE_8000             (1<<1)          /* 8000Hz */
         |                                         ^
   sound/soc/codecs/mt6359.c:2600:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000'
    2600 |                         .rates = SNDRV_PCM_RATE_8000 |
         |                                  ^~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2606:25: error: field name not in record or union initializer
    2606 |                         .formats = MT6359_FORMATS,
         |                         ^
   sound/soc/codecs/mt6359.c:2606:25: note: (near initialization for 'mt6359_dai_driver[0].base')
   sound/soc/codecs/mt6359.c:2579:24: warning: excess elements in scalar initializer
    2579 | #define MT6359_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE |\
         |                        ^
   sound/soc/codecs/mt6359.c:2606:36: note: in expansion of macro 'MT6359_FORMATS'
    2606 |                         .formats = MT6359_FORMATS,
         |                                    ^~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2579:24: note: (near initialization for 'mt6359_dai_driver[0].base')
    2579 | #define MT6359_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE |\
         |                        ^
   sound/soc/codecs/mt6359.c:2606:36: note: in expansion of macro 'MT6359_FORMATS'
    2606 |                         .formats = MT6359_FORMATS,
         |                                    ^~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2613:18: error: 'struct snd_soc_dai_driver' has no member named 'playback'
    2613 |                 .playback = {
         |                  ^~~~~~~~
   sound/soc/codecs/mt6359.c:2613:17: warning: braces around scalar initializer
    2613 |                 .playback = {
         |                 ^
   sound/soc/codecs/mt6359.c:2613:17: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2614:25: error: field name not in record or union initializer
    2614 |                         .stream_name = "AIF2 Playback",
         |                         ^
   sound/soc/codecs/mt6359.c:2614:25: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2614:40: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
    2614 |                         .stream_name = "AIF2 Playback",
         |                                        ^~~~~~~~~~~~~~~
   sound/soc/codecs/mt6359.c:2614:40: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2615:25: error: field name not in record or union initializer
    2615 |                         .channels_min = 1,
         |                         ^
   sound/soc/codecs/mt6359.c:2615:25: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2615:41: warning: excess elements in scalar initializer
    2615 |                         .channels_min = 1,
         |                                         ^
   sound/soc/codecs/mt6359.c:2615:41: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2616:25: error: field name not in record or union initializer
    2616 |                         .channels_max = 2,
         |                         ^
   sound/soc/codecs/mt6359.c:2616:25: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2616:41: warning: excess elements in scalar initializer
    2616 |                         .channels_max = 2,
         |                                         ^
   sound/soc/codecs/mt6359.c:2616:41: note: (near initialization for 'mt6359_dai_driver[1].id')
   sound/soc/codecs/mt6359.c:2617:25: error: field name not in record or union initializer
    2617 |                         .rates = SNDRV_PCM_RATE_8000_48000 |
         |                         ^
   sound/soc/codecs/mt6359.c:2617:25: note: (near initialization for 'mt6359_dai_driver[1].id')
   In file included from include/sound/soc.h:23,
..


vim +768 sound/soc/codecs/jz4770.c

2159a6810e96c3 Paul Cercueil 2019-12-24  760  
2159a6810e96c3 Paul Cercueil 2019-12-24  761  #define JZ_CODEC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  | \
2159a6810e96c3 Paul Cercueil 2019-12-24  762  			  SNDRV_PCM_FMTBIT_S18_3LE | \
2159a6810e96c3 Paul Cercueil 2019-12-24  763  			  SNDRV_PCM_FMTBIT_S20_3LE | \
2159a6810e96c3 Paul Cercueil 2019-12-24  764  			  SNDRV_PCM_FMTBIT_S24_3LE)
2159a6810e96c3 Paul Cercueil 2019-12-24  765  
2159a6810e96c3 Paul Cercueil 2019-12-24  766  static struct snd_soc_dai_driver jz4770_codec_dai = {
2159a6810e96c3 Paul Cercueil 2019-12-24  767  	.name = "jz4770-hifi",
2159a6810e96c3 Paul Cercueil 2019-12-24 @768  	.playback = {
2159a6810e96c3 Paul Cercueil 2019-12-24 @769  		.stream_name = "Playback",
2159a6810e96c3 Paul Cercueil 2019-12-24  770  		.channels_min = 2,
2159a6810e96c3 Paul Cercueil 2019-12-24  771  		.channels_max = 2,
2159a6810e96c3 Paul Cercueil 2019-12-24  772  		.rates = SNDRV_PCM_RATE_8000_96000,
2159a6810e96c3 Paul Cercueil 2019-12-24 @773  		.formats = JZ_CODEC_FORMATS,
2159a6810e96c3 Paul Cercueil 2019-12-24  774  	},
2159a6810e96c3 Paul Cercueil 2019-12-24 @775  	.capture = {
2159a6810e96c3 Paul Cercueil 2019-12-24  776  		.stream_name = "Capture",
2159a6810e96c3 Paul Cercueil 2019-12-24  777  		.channels_min = 2,
2159a6810e96c3 Paul Cercueil 2019-12-24  778  		.channels_max = 2,
2159a6810e96c3 Paul Cercueil 2019-12-24  779  		.rates = SNDRV_PCM_RATE_8000_96000,
2159a6810e96c3 Paul Cercueil 2019-12-24  780  		.formats = JZ_CODEC_FORMATS,
2159a6810e96c3 Paul Cercueil 2019-12-24  781  	},
2159a6810e96c3 Paul Cercueil 2019-12-24  782  	.ops = &jz4770_codec_dai_ops,
2159a6810e96c3 Paul Cercueil 2019-12-24  783  };
2159a6810e96c3 Paul Cercueil 2019-12-24  784  

:::::: The code at line 768 was first introduced by commit
:::::: 2159a6810e96c38a469c39df8e109edb7232d3c9 ASoC: codecs: Add jz4770-codec driver

:::::: TO: Paul Cercueil <paul@crapouillou.net>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
