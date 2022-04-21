Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8695097E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385115AbiDUGpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385056AbiDUGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:44:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418C13F93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523312; x=1682059312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kjxm7bmTXROoEp5qjjuHC1mfS0kgObAooQ6XtDzjCoc=;
  b=DgbhPm5QAHbiKMvX9Lbyv+MWI9Z2QHSmGbEQF6zAkW3V1Ee3iDS5GJ8q
   kgBYt5dooqfrptCtonG053APo6qK7RD4Ev9MpWyXRZedFffS+a7dYm+ne
   DDd4x0y4fFymMLO9gNgURbpkh3q7x44mFhfWcPN5tioB1Le42Q9vhRlQN
   r5AkeM/18zVtwZj/whFCx2KLUVHOvi1dk/+7XgikT2RP8DbYp2MjZDvH0
   d/IhtE7fqpwqV0De2x/VeevV9K91Sbyn0DiPQ+Yc5XN175s8JKQztQWHn
   gjMJ0LiniB4+1qcR8O+X5Y1SIMQbMFTXKiiynDfqHZMPEazX2ckESxraM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246151200"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246151200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="510917686"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2022 23:41:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQVh-0007yR-Pl;
        Thu, 21 Apr 2022 06:41:49 +0000
Date:   Thu, 21 Apr 2022 14:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Yan <michael.yan@starfivetech.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>
Subject: [esmil:visionfive 39/54] sound/soc/starfive/pwmdac.h:145:6: warning:
 no previous prototype for 'sf_pwmdac_pcm_push_tx'
Message-ID: <202204202206.ZXx9bPpx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   68fe13e37af4c8331cdd40841353c9725cb65925
commit: bd837079985c8fbf12bd972a21ddacef9d4c4121 [39/54] ASoC: starfive: Add StarFive JH7100 audio drivers
config: csky-randconfig-r004-20220420 (https://download.01.org/0day-ci/archive/20220420/202204202206.ZXx9bPpx-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/bd837079985c8fbf12bd972a21ddacef9d4c4121
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout bd837079985c8fbf12bd972a21ddacef9d4c4121
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from sound/soc/starfive/pwmdac.c:19:
>> sound/soc/starfive/pwmdac.h:145:6: warning: no previous prototype for 'sf_pwmdac_pcm_push_tx' [-Wmissing-prototypes]
     145 | void sf_pwmdac_pcm_push_tx(struct sf_pwmdac_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/pwmdac.h:146:6: warning: no previous prototype for 'sf_pwmdac_pcm_pop_rx' [-Wmissing-prototypes]
     146 | void sf_pwmdac_pcm_pop_rx(struct sf_pwmdac_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/pwmdac.h:147:5: warning: no previous prototype for 'sf_pwmdac_pcm_register' [-Wmissing-prototypes]
     147 | int sf_pwmdac_pcm_register(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/sf_pwmdac_pcm_push_tx +145 sound/soc/starfive/pwmdac.h

   137	
   138	
   139	
   140	#if IS_ENABLED(CONFIG_SND_STARFIVE_PWMDAC_PCM)
   141	void sf_pwmdac_pcm_push_tx(struct sf_pwmdac_dev *dev);
   142	void sf_pwmdac_pcm_pop_rx(struct sf_pwmdac_dev *dev);
   143	int sf_pwmdac_pcm_register(struct platform_device *pdev);
   144	#else
 > 145	void sf_pwmdac_pcm_push_tx(struct sf_pwmdac_dev *dev) { }
 > 146	void sf_pwmdac_pcm_pop_rx(struct sf_pwmdac_dev *dev) { }
 > 147	int sf_pwmdac_pcm_register(struct platform_device *pdev)
   148	{
   149		return -EINVAL;
   150	}
   151	#endif
   152	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
