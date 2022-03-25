Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24C4E743D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354224AbiCYNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiCYNdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:33:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1165425DD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648215138; x=1679751138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mPC1C2ietXppq3zIknanuSqd4hdecI2kxbzpJGDnNSo=;
  b=bLL1B/e0pfalyHTa6oqsGD6HE8VC+wsaFq52h/p1+JP8rAZALTDqRM5Q
   lhvQVOx277aWYu4OoHLneL29SOKSPcMd3q68yh6RIwxjqUHAc27Ra3z+g
   o+mv4JDAHQeC7Yg28r7C+mxvwMB1TdVM5y9h7HyN4++1LlFIXrzxlDBLA
   MBzk+HD7zWOLPCbZn8t5nc+Csde8CBgfGAVjQ2MbYIqSWsdk79BWSi+LS
   kV28PhGklvWDHjLXURgET02/NDmSeLeI3lJdTs/4rcpI/s3tsyYGBy9rJ
   4hLKkLzg0D+NjcJdXpBjEd9E7txFYY3AUQGv/S9/twz8fy8cRyieBMkTU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238574229"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="238574229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="545081154"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2022 06:32:16 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXk35-000MFn-GC; Fri, 25 Mar 2022 13:32:15 +0000
Date:   Fri, 25 Mar 2022 21:31:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-misc:at91sam9g20ek 10/12]
 sound/soc/codecs/wm8731-spi.c:28:42: error: dereferencing pointer to
 incomplete type 'struct wm8731_priv'
Message-ID: <202203252118.msEIfy1L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git at91sam9g20ek
head:   3924683a22e84ba06478ea4aaa775319ba02f42c
commit: 5b7214a7b726cbf25aaebfc8a05ede8c53d04d26 [10/12] ASoC: wm8731: Factor out the I2C and SPI bus code into separate modules
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220325/202203252118.msEIfy1L-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=5b7214a7b726cbf25aaebfc8a05ede8c53d04d26
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc at91sam9g20ek
        git checkout 5b7214a7b726cbf25aaebfc8a05ede8c53d04d26
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/wm8731-spi.c: In function 'wm8731_spi_probe':
>> sound/soc/codecs/wm8731-spi.c:28:42: error: dereferencing pointer to incomplete type 'struct wm8731_priv'
      28 |  wm8731 = devm_kzalloc(&spi->dev, sizeof(*wm8731), GFP_KERNEL);
         |                                          ^~~~~~~
   sound/soc/codecs/wm8731-spi.c:34:19: error: implicit declaration of function 'devm_regmap_init_spi' [-Werror=implicit-function-declaration]
      34 |  wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
         |                   ^~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/wm8731-spi.c:34:46: error: 'wm8731_regmap' undeclared (first use in this function)
      34 |  wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
         |                                              ^~~~~~~~~~~~~
   sound/soc/codecs/wm8731-spi.c:34:46: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/wm8731-spi.c:42:9: error: implicit declaration of function 'wm8731_init' [-Werror=implicit-function-declaration]
      42 |  return wm8731_init(&spi->dev, wm8731);
         |         ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +28 sound/soc/codecs/wm8731-spi.c

    22	
    23	static int wm8731_spi_probe(struct spi_device *spi)
    24	{
    25		struct wm8731_priv *wm8731;
    26		int ret;
    27	
  > 28		wm8731 = devm_kzalloc(&spi->dev, sizeof(*wm8731), GFP_KERNEL);
    29		if (wm8731 == NULL)
    30			return -ENOMEM;
    31	
    32		spi_set_drvdata(spi, wm8731);
    33	
    34		wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
    35		if (IS_ERR(wm8731->regmap)) {
    36			ret = PTR_ERR(wm8731->regmap);
    37			dev_err(&spi->dev, "Failed to allocate register map: %d\n",
    38				ret);
    39			return ret;
    40		}
    41	
    42		return wm8731_init(&spi->dev, wm8731);
    43	}
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
