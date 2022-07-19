Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19FB57A6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiGSTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbiGSTI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:08:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4748EAB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658257707; x=1689793707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3Av5xO72EOruDS6cBVL8TND8SzmTNtML/uiFzmVxvuQ=;
  b=cuZzoUMdZeva5a7/K8yXCtUk/q9g3DILwqGgra4CtfhopftH4/tnzFoE
   OAyz8fkpvsDqi4f/xlZ48XsbnbEY8uRhw0g+PuNHZpJvfZr63ksdwB2fw
   Cw2XhGHXOmwJyc9C8naeomb5yBQ8kebz2OdzP3MaxdBzH0sI7B5jaJRhX
   ZIZ53RfY1NggWEfJ1jQhgxbXAGfCDNg53S3P6/dDv7Iqt9mxwx8eSh/oH
   f6z51tnV2el03DxdA9coe4Ih6x3P+3KNXsQbptpLEvZSMzaP6uCrEnESQ
   CEFui9G8Li21BO1nEE3QE1L0kWOCl5skk8pppVZuYuc8Q5E4CkE6X9Aiy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="266352866"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="266352866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="625319329"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2022 12:08:26 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDsa1-0005vh-AQ;
        Tue, 19 Jul 2022 19:08:25 +0000
Date:   Wed, 20 Jul 2022 03:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound-2022-07-04-v1 23/23]
 sound/soc/samsung/s3c2412-i2s.c:186:35: warning: initialization of 'int
 (*)(struct snd_soc_pcm_runtime *, struct snd_soc_dai *)' from 'int' makes
 pointer from integer without a cast
Message-ID: <202207200349.E9SUi7T2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound-2022-07-04-v1
head:   e9efd77b37adcddf8f910f34dd0df06be9d896cb
commit: e9efd77b37adcddf8f910f34dd0df06be9d896cb [23/23] remove
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220720/202207200349.E9SUi7T2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/e9efd77b37adcddf8f910f34dd0df06be9d896cb
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound-2022-07-04-v1
        git checkout e9efd77b37adcddf8f910f34dd0df06be9d896cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/mediatek/mt2701/ sound/soc/mediatek/mt6797/ sound/soc/mediatek/mt8173/ sound/soc/mediatek/mt8183/ sound/soc/mediatek/mt8192/ sound/soc/samsung/ sound/soc/ux500/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/samsung/s3c2412-i2s.c:179:10: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     179 |         .playback = {
         |          ^~~~~~~~
>> sound/soc/samsung/s3c2412-i2s.c:179:9: warning: braces around scalar initializer
     179 |         .playback = {
         |         ^
   sound/soc/samsung/s3c2412-i2s.c:179:9: note: (near initialization for 's3c2412_i2s_dai.compress_new')
   sound/soc/samsung/s3c2412-i2s.c:180:17: error: field name not in record or union initializer
     180 |                 .channels_min   = 2,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:180:17: note: (near initialization for 's3c2412_i2s_dai.compress_new')
>> sound/soc/samsung/s3c2412-i2s.c:180:35: warning: initialization of 'int (*)(struct snd_soc_pcm_runtime *, int)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     180 |                 .channels_min   = 2,
         |                                   ^
   sound/soc/samsung/s3c2412-i2s.c:180:35: note: (near initialization for 's3c2412_i2s_dai.compress_new')
   sound/soc/samsung/s3c2412-i2s.c:181:17: error: field name not in record or union initializer
     181 |                 .channels_max   = 2,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:181:17: note: (near initialization for 's3c2412_i2s_dai.compress_new')
>> sound/soc/samsung/s3c2412-i2s.c:181:35: warning: excess elements in scalar initializer
     181 |                 .channels_max   = 2,
         |                                   ^
   sound/soc/samsung/s3c2412-i2s.c:181:35: note: (near initialization for 's3c2412_i2s_dai.compress_new')
   sound/soc/samsung/s3c2412-i2s.c:182:17: error: field name not in record or union initializer
     182 |                 .rates          = S3C2412_I2S_RATES,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:182:17: note: (near initialization for 's3c2412_i2s_dai.compress_new')
   sound/soc/samsung/s3c2412-i2s.c:168:9: warning: excess elements in scalar initializer
     168 |         (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
         |         ^
   sound/soc/samsung/s3c2412-i2s.c:182:35: note: in expansion of macro 'S3C2412_I2S_RATES'
     182 |                 .rates          = S3C2412_I2S_RATES,
         |                                   ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:168:9: note: (near initialization for 's3c2412_i2s_dai.compress_new')
     168 |         (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
         |         ^
   sound/soc/samsung/s3c2412-i2s.c:182:35: note: in expansion of macro 'S3C2412_I2S_RATES'
     182 |                 .rates          = S3C2412_I2S_RATES,
         |                                   ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:183:17: error: field name not in record or union initializer
     183 |                 .formats        = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:183:17: note: (near initialization for 's3c2412_i2s_dai.compress_new')
   In file included from include/sound/soc.h:23,
                    from sound/soc/samsung/s3c2412-i2s.c:19:
   include/sound/pcm.h:139:41: warning: excess elements in scalar initializer
     139 | #define _SNDRV_PCM_FMTBIT(fmt)          (1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
         |                                         ^
   include/sound/pcm.h:140:41: note: in expansion of macro '_SNDRV_PCM_FMTBIT'
     140 | #define SNDRV_PCM_FMTBIT_S8             _SNDRV_PCM_FMTBIT(S8)
         |                                         ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:183:35: note: in expansion of macro 'SNDRV_PCM_FMTBIT_S8'
     183 |                 .formats        = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
         |                                   ^~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:139:41: note: (near initialization for 's3c2412_i2s_dai.compress_new')
     139 | #define _SNDRV_PCM_FMTBIT(fmt)          (1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
         |                                         ^
   include/sound/pcm.h:140:41: note: in expansion of macro '_SNDRV_PCM_FMTBIT'
     140 | #define SNDRV_PCM_FMTBIT_S8             _SNDRV_PCM_FMTBIT(S8)
         |                                         ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:183:35: note: in expansion of macro 'SNDRV_PCM_FMTBIT_S8'
     183 |                 .formats        = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
         |                                   ^~~~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:185:10: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     185 |         .capture = {
         |          ^~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:185:9: warning: braces around scalar initializer
     185 |         .capture = {
         |         ^
   sound/soc/samsung/s3c2412-i2s.c:185:9: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
   sound/soc/samsung/s3c2412-i2s.c:186:17: error: field name not in record or union initializer
     186 |                 .channels_min   = 2,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:186:17: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
>> sound/soc/samsung/s3c2412-i2s.c:186:35: warning: initialization of 'int (*)(struct snd_soc_pcm_runtime *, struct snd_soc_dai *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     186 |                 .channels_min   = 2,
         |                                   ^
   sound/soc/samsung/s3c2412-i2s.c:186:35: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
   sound/soc/samsung/s3c2412-i2s.c:187:17: error: field name not in record or union initializer
     187 |                 .channels_max   = 2,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:187:17: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
   sound/soc/samsung/s3c2412-i2s.c:187:35: warning: excess elements in scalar initializer
     187 |                 .channels_max   = 2,
         |                                   ^
   sound/soc/samsung/s3c2412-i2s.c:187:35: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
   sound/soc/samsung/s3c2412-i2s.c:188:17: error: field name not in record or union initializer
     188 |                 .rates          = S3C2412_I2S_RATES,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:188:17: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
   sound/soc/samsung/s3c2412-i2s.c:168:9: warning: excess elements in scalar initializer
     168 |         (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
         |         ^
   sound/soc/samsung/s3c2412-i2s.c:188:35: note: in expansion of macro 'S3C2412_I2S_RATES'
     188 |                 .rates          = S3C2412_I2S_RATES,
         |                                   ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:168:9: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
     168 |         (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
         |         ^
   sound/soc/samsung/s3c2412-i2s.c:188:35: note: in expansion of macro 'S3C2412_I2S_RATES'
     188 |                 .rates          = S3C2412_I2S_RATES,
         |                                   ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:189:17: error: field name not in record or union initializer
     189 |                 .formats        = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
         |                 ^
   sound/soc/samsung/s3c2412-i2s.c:189:17: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
   include/sound/pcm.h:139:41: warning: excess elements in scalar initializer
     139 | #define _SNDRV_PCM_FMTBIT(fmt)          (1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
         |                                         ^
   include/sound/pcm.h:140:41: note: in expansion of macro '_SNDRV_PCM_FMTBIT'
     140 | #define SNDRV_PCM_FMTBIT_S8             _SNDRV_PCM_FMTBIT(S8)
         |                                         ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:189:35: note: in expansion of macro 'SNDRV_PCM_FMTBIT_S8'
     189 |                 .formats        = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
         |                                   ^~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:139:41: note: (near initialization for 's3c2412_i2s_dai.pcm_new')
     139 | #define _SNDRV_PCM_FMTBIT(fmt)          (1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
         |                                         ^
   include/sound/pcm.h:140:41: note: in expansion of macro '_SNDRV_PCM_FMTBIT'
     140 | #define SNDRV_PCM_FMTBIT_S8             _SNDRV_PCM_FMTBIT(S8)
         |                                         ^~~~~~~~~~~~~~~~~
   sound/soc/samsung/s3c2412-i2s.c:189:35: note: in expansion of macro 'SNDRV_PCM_FMTBIT_S8'
     189 |                 .formats        = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
         |                                   ^~~~~~~~~~~~~~~~~~~
--
   sound/soc/ux500/ux500_msp_dai.c:720:10: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     720 |         .playback.channels_min = UX500_MSP_MIN_CHANNELS,
         |          ^~~~~~~~
   In file included from sound/soc/ux500/ux500_msp_dai.c:25:
>> sound/soc/ux500/ux500_msp_dai.h:36:41: warning: initialization of 'int (*)(struct snd_soc_dai *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      36 | #define UX500_MSP_MIN_CHANNELS          1
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:720:34: note: in expansion of macro 'UX500_MSP_MIN_CHANNELS'
     720 |         .playback.channels_min = UX500_MSP_MIN_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.h:36:41: note: (near initialization for 'ux500_msp_dai_drv.remove')
      36 | #define UX500_MSP_MIN_CHANNELS          1
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:720:34: note: in expansion of macro 'UX500_MSP_MIN_CHANNELS'
     720 |         .playback.channels_min = UX500_MSP_MIN_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:721:10: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     721 |         .playback.channels_max = UX500_MSP_MAX_CHANNELS,
         |          ^~~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:37:41: warning: initialization of 'int (*)(struct snd_soc_pcm_runtime *, int)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      37 | #define UX500_MSP_MAX_CHANNELS          8
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:721:34: note: in expansion of macro 'UX500_MSP_MAX_CHANNELS'
     721 |         .playback.channels_max = UX500_MSP_MAX_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.h:37:41: note: (near initialization for 'ux500_msp_dai_drv.compress_new')
      37 | #define UX500_MSP_MAX_CHANNELS          8
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:721:34: note: in expansion of macro 'UX500_MSP_MAX_CHANNELS'
     721 |         .playback.channels_max = UX500_MSP_MAX_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:722:10: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     722 |         .playback.rates        = UX500_I2S_RATES,
         |          ^~~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:20:25: warning: initialization of 'int (*)(struct snd_soc_pcm_runtime *, struct snd_soc_dai *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      20 | #define UX500_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |   \
         |                         ^
   sound/soc/ux500/ux500_msp_dai.c:722:34: note: in expansion of macro 'UX500_I2S_RATES'
     722 |         .playback.rates        = UX500_I2S_RATES,
         |                                  ^~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.h:20:25: note: (near initialization for 'ux500_msp_dai_drv.pcm_new')
      20 | #define UX500_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |   \
         |                         ^
   sound/soc/ux500/ux500_msp_dai.c:722:34: note: in expansion of macro 'UX500_I2S_RATES'
     722 |         .playback.rates        = UX500_I2S_RATES,
         |                                  ^~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:723:10: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     723 |         .playback.formats      = UX500_I2S_FORMATS,
         |          ^~~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:23:27: warning: initialization of 'const struct snd_soc_dai_ops *' from 'long long unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      23 | #define UX500_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
         |                           ^
   sound/soc/ux500/ux500_msp_dai.c:723:34: note: in expansion of macro 'UX500_I2S_FORMATS'
     723 |         .playback.formats      = UX500_I2S_FORMATS,
         |                                  ^~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.h:23:27: note: (near initialization for 'ux500_msp_dai_drv.ops')
      23 | #define UX500_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
         |                           ^
   sound/soc/ux500/ux500_msp_dai.c:723:34: note: in expansion of macro 'UX500_I2S_FORMATS'
     723 |         .playback.formats      = UX500_I2S_FORMATS,
         |                                  ^~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:724:10: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     724 |         .capture.channels_min  = UX500_MSP_MIN_CHANNELS,
         |          ^~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:36:41: warning: initialization of 'const struct snd_soc_cdai_ops *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      36 | #define UX500_MSP_MIN_CHANNELS          1
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:724:34: note: in expansion of macro 'UX500_MSP_MIN_CHANNELS'
     724 |         .capture.channels_min  = UX500_MSP_MIN_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.h:36:41: note: (near initialization for 'ux500_msp_dai_drv.cops')
      36 | #define UX500_MSP_MIN_CHANNELS          1
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:724:34: note: in expansion of macro 'UX500_MSP_MIN_CHANNELS'
     724 |         .capture.channels_min  = UX500_MSP_MIN_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:725:10: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     725 |         .capture.channels_max  = UX500_MSP_MAX_CHANNELS,
         |          ^~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:37:41: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      37 | #define UX500_MSP_MAX_CHANNELS          8
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:725:34: note: in expansion of macro 'UX500_MSP_MAX_CHANNELS'
     725 |         .capture.channels_max  = UX500_MSP_MAX_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.h:37:41: note: (near initialization for 'ux500_msp_dai_drv.stream_info[0].stream_name')
      37 | #define UX500_MSP_MAX_CHANNELS          8
         |                                         ^
   sound/soc/ux500/ux500_msp_dai.c:725:34: note: in expansion of macro 'UX500_MSP_MAX_CHANNELS'
     725 |         .capture.channels_max  = UX500_MSP_MAX_CHANNELS,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:726:10: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     726 |         .capture.rates         = UX500_I2S_RATES,
         |          ^~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:20:25: warning: unsigned conversion from 'int' to 'unsigned char:1' changes value from '202' to '0' [-Woverflow]
      20 | #define UX500_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |   \
         |                         ^
   sound/soc/ux500/ux500_msp_dai.c:726:34: note: in expansion of macro 'UX500_I2S_RATES'
     726 |         .capture.rates         = UX500_I2S_RATES,
         |                                  ^~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:727:10: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     727 |         .capture.formats       = UX500_I2S_FORMATS,
         |          ^~~~~~~
>> sound/soc/ux500/ux500_msp_dai.h:23:27: warning: conversion from 'long long unsigned int' to 'unsigned char:1' changes value from '4' to '0' [-Woverflow]
      23 | #define UX500_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
         |                           ^
   sound/soc/ux500/ux500_msp_dai.c:727:34: note: in expansion of macro 'UX500_I2S_FORMATS'
     727 |         .capture.formats       = UX500_I2S_FORMATS,
         |                                  ^~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:728:34: warning: initialized field overwritten [-Woverride-init]
     728 |         .ops                   = ux500_msp_dai_ops,
         |                                  ^~~~~~~~~~~~~~~~~
   sound/soc/ux500/ux500_msp_dai.c:728:34: note: (near initialization for 'ux500_msp_dai_drv.ops')
>> sound/soc/ux500/ux500_msp_dai.c:718:54: warning: missing braces around initializer [-Wmissing-braces]
     718 | static struct snd_soc_dai_driver ux500_msp_dai_drv = {
         |                                                      ^
--
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:552:18: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     552 |                 .playback = {
         |                  ^~~~~~~~
>> sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:552:17: warning: braces around scalar initializer
     552 |                 .playback = {
         |                 ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:552:17: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:553:25: error: field name not in record or union initializer
     553 |                         .stream_name = "DL1",
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:553:25: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
>> sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:553:40: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
     553 |                         .stream_name = "DL1",
         |                                        ^~~~~
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:553:40: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:554:25: error: field name not in record or union initializer
     554 |                         .channels_min = 1,
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:554:25: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
>> sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:554:41: warning: excess elements in scalar initializer
     554 |                         .channels_min = 1,
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:554:41: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:555:25: error: field name not in record or union initializer
     555 |                         .channels_max = 2,
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:555:25: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:555:41: warning: excess elements in scalar initializer
     555 |                         .channels_max = 2,
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:555:41: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:556:25: error: field name not in record or union initializer
     556 |                         .rates = SNDRV_PCM_RATE_8000_192000,
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:556:25: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   In file included from include/sound/soc.h:23,
                    from sound/soc/mediatek/mt2701/mt2701-afe-common.h:12,
                    from sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:19:
   include/sound/pcm.h:134:41: warning: excess elements in scalar initializer
     134 | #define SNDRV_PCM_RATE_8000_192000      (SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:556:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000_192000'
     556 |                         .rates = SNDRV_PCM_RATE_8000_192000,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:134:41: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
     134 | #define SNDRV_PCM_RATE_8000_192000      (SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:556:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000_192000'
     556 |                         .rates = SNDRV_PCM_RATE_8000_192000,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:557:25: error: field name not in record or union initializer
     557 |                         .formats = (SNDRV_PCM_FMTBIT_S16_LE
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:557:25: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:557:36: warning: excess elements in scalar initializer
     557 |                         .formats = (SNDRV_PCM_FMTBIT_S16_LE
         |                                    ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:557:36: note: (near initialization for 'mt2701_afe_pcm_dais[0].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:566:18: error: 'struct snd_soc_dai_driver' has no member named 'playback'
     566 |                 .playback = {
         |                  ^~~~~~~~
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:566:17: warning: braces around scalar initializer
     566 |                 .playback = {
         |                 ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:566:17: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:567:25: error: field name not in record or union initializer
     567 |                         .stream_name = "DLM",
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:567:25: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:567:40: warning: initialization of 'unsigned int' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
     567 |                         .stream_name = "DLM",
         |                                        ^~~~~
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:567:40: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:568:25: error: field name not in record or union initializer
     568 |                         .channels_min = 1,
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:568:25: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:568:41: warning: excess elements in scalar initializer
     568 |                         .channels_min = 1,
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:568:41: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:569:25: error: field name not in record or union initializer
     569 |                         .channels_max = 8,
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:569:25: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:569:41: warning: excess elements in scalar initializer
     569 |                         .channels_max = 8,
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:569:41: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:570:25: error: field name not in record or union initializer
     570 |                         .rates = SNDRV_PCM_RATE_8000_192000,
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:570:25: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   include/sound/pcm.h:134:41: warning: excess elements in scalar initializer
     134 | #define SNDRV_PCM_RATE_8000_192000      (SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:570:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000_192000'
     570 |                         .rates = SNDRV_PCM_RATE_8000_192000,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/sound/pcm.h:134:41: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
     134 | #define SNDRV_PCM_RATE_8000_192000      (SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
         |                                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:570:34: note: in expansion of macro 'SNDRV_PCM_RATE_8000_192000'
     570 |                         .rates = SNDRV_PCM_RATE_8000_192000,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:571:25: error: field name not in record or union initializer
     571 |                         .formats = (SNDRV_PCM_FMTBIT_S16_LE
         |                         ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:571:25: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:571:36: warning: excess elements in scalar initializer
     571 |                         .formats = (SNDRV_PCM_FMTBIT_S16_LE
         |                                    ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:571:36: note: (near initialization for 'mt2701_afe_pcm_dais[1].base')
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:581:18: error: 'struct snd_soc_dai_driver' has no member named 'capture'
     581 |                 .capture = {
         |                  ^~~~~~~
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:581:17: warning: braces around scalar initializer
     581 |                 .capture = {
         |                 ^
   sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:581:17: note: (near initialization for 'mt2701_afe_pcm_dais[2].base')
..


vim +186 sound/soc/samsung/s3c2412-i2s.c

6335d05548eece sound/soc/s3c24xx/s3c2412-i2s.c Eric Miao     2009-03-03  175  
f0fba2ad1b6b53 sound/soc/s3c24xx/s3c2412-i2s.c Liam Girdwood 2010-03-17  176  static struct snd_soc_dai_driver s3c2412_i2s_dai = {
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  177  	.probe		= s3c2412_i2s_probe,
f0fba2ad1b6b53 sound/soc/s3c24xx/s3c2412-i2s.c Liam Girdwood 2010-03-17  178  	.remove	= s3c2412_i2s_remove,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10 @179  	.playback = {
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10 @180  		.channels_min	= 2,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10 @181  		.channels_max	= 2,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  182  		.rates		= S3C2412_I2S_RATES,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  183  		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  184  	},
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10 @185  	.capture = {
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10 @186  		.channels_min	= 2,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  187  		.channels_max	= 2,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  188  		.rates		= S3C2412_I2S_RATES,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  189  		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  190  	},
6335d05548eece sound/soc/s3c24xx/s3c2412-i2s.c Eric Miao     2009-03-03  191  	.ops = &s3c2412_i2s_dai_ops,
49646dfa2ae81e sound/soc/s3c24xx/s3c2412-i2s.c Ben Dooks     2008-01-10  192  };
f0fba2ad1b6b53 sound/soc/s3c24xx/s3c2412-i2s.c Liam Girdwood 2010-03-17  193  

:::::: The code at line 186 was first introduced by commit
:::::: 49646dfa2ae81e770da1c12c4fce227062ce4612 [ALSA] ASoC: S3C2412 IIS driver

:::::: TO: Ben Dooks <ben-linux@fluff.org>
:::::: CC: Jaroslav Kysela <perex@perex.cz>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
