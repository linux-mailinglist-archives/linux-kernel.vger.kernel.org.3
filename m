Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2430A4E6DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355999AbiCYFxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCYFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:53:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EBB82F2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648187518; x=1679723518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GHFkE2ucb0MgAoFKijKOuZGvLHNY3B+2ApxwjopL5JE=;
  b=d7XP9TvfJNTsffLsPOaKZW9jNhMtsI43woSh05Hwbqv1fU+JI9D7mZfz
   lT6ppPR918B9nxZrR66mwpwc59QOYslvT4jfKh2/KGIJEjQOuqbqohYVQ
   KxejMDvOBfwmTiYlu+5J4VL/IPfepE/tXcPPeIWa2jV8/toq+iLJelNEG
   QkQ0wBJk8Un5zCS0Li2Ds5p/4mwPGImwKCUlyUpr0KRRMns8KagRWLxn4
   QU908hQp15iG2ygZ+xh5xXvYy49I54JES4ZvpD1vKTPNeMVAq153OvaY0
   bTNwPMm6lxo+zE6WntmWWsHCBbKdgzNp4sNjLzLnmEsLCqs7IKXFcma8+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="239164674"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="239164674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 22:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="544952158"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2022 22:51:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXcrc-000LqI-7e; Fri, 25 Mar 2022 05:51:56 +0000
Date:   Fri, 25 Mar 2022 13:50:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-misc:at91sam9g20ek 10/12]
 sound/soc/codecs/wm8731-spi.c:28:48: error: invalid application of 'sizeof'
 to incomplete type 'struct wm8731_priv'
Message-ID: <202203251303.ROlxE3s7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git at91sam9g20ek
head:   3924683a22e84ba06478ea4aaa775319ba02f42c
commit: 5b7214a7b726cbf25aaebfc8a05ede8c53d04d26 [10/12] ASoC: wm8731: Factor out the I2C and SPI bus code into separate modules
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220325/202203251303.ROlxE3s7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=5b7214a7b726cbf25aaebfc8a05ede8c53d04d26
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc at91sam9g20ek
        git checkout 5b7214a7b726cbf25aaebfc8a05ede8c53d04d26
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/wm8731-spi.c: In function 'wm8731_spi_probe':
>> sound/soc/codecs/wm8731-spi.c:28:48: error: invalid application of 'sizeof' to incomplete type 'struct wm8731_priv'
      28 |         wm8731 = devm_kzalloc(&spi->dev, sizeof(*wm8731), GFP_KERNEL);
         |                                                ^
>> sound/soc/codecs/wm8731-spi.c:34:15: error: invalid use of undefined type 'struct wm8731_priv'
      34 |         wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
         |               ^~
>> sound/soc/codecs/wm8731-spi.c:34:26: error: implicit declaration of function 'devm_regmap_init_spi' [-Werror=implicit-function-declaration]
      34 |         wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
         |                          ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/wm8731-spi.c:34:53: error: 'wm8731_regmap' undeclared (first use in this function)
      34 |         wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
         |                                                     ^~~~~~~~~~~~~
   sound/soc/codecs/wm8731-spi.c:34:53: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/wm8731-spi.c:35:26: error: invalid use of undefined type 'struct wm8731_priv'
      35 |         if (IS_ERR(wm8731->regmap)) {
         |                          ^~
   sound/soc/codecs/wm8731-spi.c:36:37: error: invalid use of undefined type 'struct wm8731_priv'
      36 |                 ret = PTR_ERR(wm8731->regmap);
         |                                     ^~
>> sound/soc/codecs/wm8731-spi.c:42:16: error: implicit declaration of function 'wm8731_init' [-Werror=implicit-function-declaration]
      42 |         return wm8731_init(&spi->dev, wm8731);
         |                ^~~~~~~~~~~
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
  > 34		wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
    35		if (IS_ERR(wm8731->regmap)) {
    36			ret = PTR_ERR(wm8731->regmap);
    37			dev_err(&spi->dev, "Failed to allocate register map: %d\n",
    38				ret);
    39			return ret;
    40		}
    41	
  > 42		return wm8731_init(&spi->dev, wm8731);
    43	}
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
