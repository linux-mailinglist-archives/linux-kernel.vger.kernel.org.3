Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3D84E5F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348434AbiCXHQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348415AbiCXHQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:16:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A536646D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648106101; x=1679642101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PmLKrQ4LcC7G2I3J4kn8jkm/O+YfnSYhzjsWxNnXqNU=;
  b=LgKTEPHItDpofbvrPbJ4DR+ylJoBaRvLLpBOSoxhp1wh2YvEVGZ98ZR/
   julJHtpAhAJy1QtBQS1bnrPzl9zmfIB8OdOf3R48jEUKmIX+lTlvbS32b
   tvDR6pCWnp+1My7SgVPFeTXolHFuTE5wgoMCbN7jv4DcYCniT7BUyL1Cv
   afAMXuBw65ZvNRk8M6jm/lSOYV6IC1qyX+5XnppLUrJNCPrs0QpUmXMMM
   +6q7cf9T6TUGA4RsJbI85sFq6Hz1QHj+cligJXc75a+SHCK1ndv2tFjey
   tz5pA58OZRZldUyVe/I9atYA8aEh6svT2rSB4CSzrMpu4t/se1psilfkT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="257134164"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="257134164"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 00:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="717710994"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 00:14:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXHgQ-000Kne-R2; Thu, 24 Mar 2022 07:14:58 +0000
Date:   Thu, 24 Mar 2022 15:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-misc:at91sam9g20ek 3/5]
 sound/soc/atmel/sam9g20_wm8731.c:186:21: error: 'mclk' undeclared; did you
 mean 'clk'?
Message-ID: <202203241508.CAvzBM8m-lkp@intel.com>
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
head:   f30f829ccd41ba76c4e5eae0f4f7ed3c9e4fe36b
commit: f0b540ab33c655cd82cd228652fb47d323584581 [3/5] ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220324/202203241508.CAvzBM8m-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=f0b540ab33c655cd82cd228652fb47d323584581
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc at91sam9g20ek
        git checkout f0b540ab33c655cd82cd228652fb47d323584581
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash sound/soc/atmel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/atmel/sam9g20_wm8731.c: In function 'at91sam9g20ek_audio_probe':
   sound/soc/atmel/sam9g20_wm8731.c:121:21: warning: unused variable 'pllb' [-Wunused-variable]
     121 |         struct clk *pllb;
         |                     ^~~~
   sound/soc/atmel/sam9g20_wm8731.c: In function 'at91sam9g20ek_audio_remove':
>> sound/soc/atmel/sam9g20_wm8731.c:186:21: error: 'mclk' undeclared (first use in this function); did you mean 'clk'?
     186 |         clk_disable(mclk);
         |                     ^~~~
         |                     clk
   sound/soc/atmel/sam9g20_wm8731.c:186:21: note: each undeclared identifier is reported only once for each function it appears in


vim +186 sound/soc/atmel/sam9g20_wm8731.c

5b99e6ccf964e7 Sedji Gaouaou  2008-10-03  181  
71d14ea60ad81a Bill Pemberton 2012-12-07  182  static int at91sam9g20ek_audio_remove(struct platform_device *pdev)
5b99e6ccf964e7 Sedji Gaouaou  2008-10-03  183  {
242b9bb83e458d Bo Shen        2012-10-11  184  	struct snd_soc_card *card = platform_get_drvdata(pdev);
242b9bb83e458d Bo Shen        2012-10-11  185  
151edfc757babd Bo Shen        2013-01-31 @186  	clk_disable(mclk);
5de7f9b2006925 Mark Brown     2009-02-16  187  	mclk = NULL;
151edfc757babd Bo Shen        2013-01-31  188  	snd_soc_unregister_card(card);
151edfc757babd Bo Shen        2013-01-31  189  	atmel_ssc_put_audio(0);
242b9bb83e458d Bo Shen        2012-10-11  190  
242b9bb83e458d Bo Shen        2012-10-11  191  	return 0;
5b99e6ccf964e7 Sedji Gaouaou  2008-10-03  192  }
5b99e6ccf964e7 Sedji Gaouaou  2008-10-03  193  

:::::: The code at line 186 was first introduced by commit
:::::: 151edfc757babd94d8b6c64d84a9ccf8f3c53320 ASoC: sam9g20_wm8731: disable clock and correct sequence when unload

:::::: TO: Bo Shen <voice.shen@atmel.com>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
