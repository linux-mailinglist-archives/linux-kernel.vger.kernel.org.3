Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56659B14B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 04:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiHUCOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiHUCO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 22:14:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D61CB39
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 19:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661048068; x=1692584068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xmlQeiiEnoc+lUAWnQmldCWp4mLOcAHkktlrScaBRQs=;
  b=H83BUKyS9l3TfKF/xKhLbMPU4pSW35oLh2wTSAMospCIBl+y1at9fWtP
   yiYe7ANyRl6z+IsHQwk3rkZomchZAwuI64UABDjnRoQQSvRvCBMgi2+g2
   t5UoUXm6nBskSjkg278GiCFnWzsXiPzsQHvv3mZ5GGGVsQxls3L5vxGos
   B4zb0hoO+LoShTpM6DOi8WplVvf0TasM0wkWgd3SdSdxTfqCr/jiJdDZD
   8LTtVNKSttzNE+lkx8jyYnxXszvNKZVl766mSDx61miTZ1wJu0jNo4b5V
   iALm4LPDNNFMLYw3YondKs4YKyyXmzuiZrLlTA89cQWViJvXjmTqcvXI4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="357196219"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="357196219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 19:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637723660"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2022 19:14:26 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPaTq-0003WN-0R;
        Sun, 21 Aug 2022 02:14:26 +0000
Date:   Sun, 21 Aug 2022 10:13:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 12/16] sound/soc/codecs/cs42l84.c:264:10:
 error: 'const struct snd_soc_component_driver' has no member named
 'non_legacy_dai_naming'; did you mean 'legacy_dai_naming'?
Message-ID: <202208211004.6evbkKfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   51024ef467ff6c288e679bc72d0e3fcdd54d9b39
commit: a97f70c444c0cb9842bc778c3c1def0142b2b8bf [12/16] wip: ASoC: cs42l84: Start new codec driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220821/202208211004.6evbkKfp-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/a97f70c444c0cb9842bc778c3c1def0142b2b8bf
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout a97f70c444c0cb9842bc778c3c1def0142b2b8bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/cs42l84.c:244:5: warning: no previous prototype for 'cs42l84_component_probe' [-Wmissing-prototypes]
     244 | int cs42l84_component_probe(struct snd_soc_component *component)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/cs42l84.c:264:10: error: 'const struct snd_soc_component_driver' has no member named 'non_legacy_dai_naming'; did you mean 'legacy_dai_naming'?
     264 |         .non_legacy_dai_naming  = 1,
         |          ^~~~~~~~~~~~~~~~~~~~~
         |          legacy_dai_naming
   sound/soc/codecs/cs42l84.c: In function 'cs42l84_pll_config':
   sound/soc/codecs/cs42l84.c:328:17: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     328 |                 FIELD_PREP(CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO, fsync & 0x7f));
         |                 ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +264 sound/soc/codecs/cs42l84.c

   254	
   255	static const struct snd_soc_component_driver soc_component_dev_cs42l84 = {
   256		.probe			= cs42l84_component_probe,
   257		.controls			= cs42l84_snd_controls,
   258		.num_controls		= ARRAY_SIZE(cs42l84_snd_controls),
   259		.dapm_widgets		= cs42l84_dapm_widgets,
   260		.num_dapm_widgets	= ARRAY_SIZE(cs42l84_dapm_widgets),
   261		.dapm_routes		= cs42l84_audio_map,
   262		.num_dapm_routes	= ARRAY_SIZE(cs42l84_audio_map),
   263		.endianness		= 1,
 > 264		.non_legacy_dai_naming	= 1,
   265	};
   266	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
