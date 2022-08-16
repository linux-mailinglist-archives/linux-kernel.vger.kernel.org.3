Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F765953B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiHPH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiHPH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:26:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3983D5B6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660621788; x=1692157788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KAiP5iJJgb/6Yq3FQ4Ggw1JqWJUBeDH9aBpsqpWyr3s=;
  b=OEBAHOZyGdgPFZd3DLaXz0B416vGj1Xdm5NC5DcYvPkjnZdDJsaaBfXh
   ypnUqF2sRbCqA4w3qIFB6GjX5U7f3f/IWMAyFnCUV7QIb3rPrXyJoZUCn
   yRgqMai2uYIi+slBCX0wCp4QFbW/80crNdi93PIcwEbJfZQIaCWpFoMCl
   eAm5NnYbORFfvE1hpQewHaJgHca4+BsULmo+D0+pF10kVMN90+Gx6GkQq
   8rDh+Fbg0U5m/R+IFBcizv/QhRWrqkozevt1jW2cXAI1slY8Va9D3J7qk
   gij+WXwWvbCqy07aLDj2HvvKI62yq4NLuRgaTwGwdGa/KQOjXndane7kS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="275170928"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="275170928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 20:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="583137550"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 20:49:45 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNnaK-0001QS-1l;
        Tue, 16 Aug 2022 03:49:44 +0000
Date:   Tue, 16 Aug 2022 11:49:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 9/16] sound/soc/apple/macaudio.c:627:15:
 error: too many arguments to function call, expected 4, have 6
Message-ID: <202208161128.ck05kP2v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   54b20e361303307d4ed9f2903ad7b1f41caf8bea
commit: ca97cfa4728cf208e9d53e17f5ff54cc08e804b3 [9/16] ASoC: apple: Add macaudio machine driver
config: arm64-randconfig-r015-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161128.ck05kP2v-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/ca97cfa4728cf208e9d53e17f5ff54cc08e804b3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout ca97cfa4728cf208e9d53e17f5ff54cc08e804b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/apple/macaudio.c:627:15: error: too many arguments to function call, expected 4, have 6
                           &ma->jack, &ma->pin, 1);
                                      ^~~~~~~~~~~
   include/sound/soc-card.h:18:5: note: 'snd_soc_card_jack_new' declared here
   int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
       ^
   1 error generated.


vim +627 sound/soc/apple/macaudio.c

   614	
   615	static int macaudio_probe(struct snd_soc_card *card)
   616	{
   617		struct macaudio_snd_data *ma = snd_soc_card_get_drvdata(card);
   618		int ret;
   619	
   620		ma->pin.pin = "Headphones";
   621		ma->pin.mask = SND_JACK_HEADSET | SND_JACK_HEADPHONE;
   622		ret = snd_soc_card_jack_new(card, ma->pin.pin,
   623				SND_JACK_HEADSET |
   624				SND_JACK_HEADPHONE |
   625				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
   626				SND_JACK_BTN_2 | SND_JACK_BTN_3,
 > 627				&ma->jack, &ma->pin, 1);
   628	
   629		if (ret < 0) {
   630			dev_err(card->dev, "jack creation failed: %d\n", ret);
   631			return ret;
   632		}
   633	
   634		snd_soc_jack_notifier_register(&ma->jack, &macaudio_jack_nb);
   635	
   636		return ret;
   637	}
   638	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
