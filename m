Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABD74F629C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiDFPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiDFPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:09:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39F472F07
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649246650; x=1680782650;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uEpWVDG9mHAzC3vQt8/6DshQkU5+A/w706L6sIKCmZ4=;
  b=Wbo+Z5XO48d1xnJXvfuaF9Ew3HN9KKbRGwSeqCDE5SC+gRzfLuHDjslQ
   rO0TgXP1ZRWVAMlXTUk9CSyhST1CzYjOhXlWswSbGZi9s2gmYHOqoJoKM
   HAOHjdpODydczu6xYKYnFzG74d1SR6XNATIhMFPC+hKP+Ue5gFE+mv0TU
   hbOMQ4jICPF+M8Ae2TONoAlUQc9vzS5BfANfsuBRuqXI4syZXhyvuY1wk
   S0PLleJy8eFWbakFc3MZpRIFEO/6X0ILqrdPjaSvxX/oM5iskvMYloB7K
   lmoTsw+zPmRn7Lv91UROVHHzLTeJ8+f4lBrDmdxk4RV4H5UgGsKBvmMM5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240958360"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="240958360"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="722484316"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2022 04:54:00 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc4Ea-0004NR-32;
        Wed, 06 Apr 2022 11:54:00 +0000
Date:   Wed, 6 Apr 2022 19:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Yan <michael.yan@starfivetech.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>
Subject: [esmil:visionfive 39/55] sound/soc/starfive/pwmdac.h:145:6: warning:
 no previous prototype for 'sf_pwmdac_pcm_push_tx'
Message-ID: <202204061929.5OKjyPph-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   7ff84520cb688edd6028a4ac3de3ed684eb22794
commit: 46f456a9a328b4f2904920484bb3cf5afb654cdc [39/55] ASoC: starfive: Add StarFive JH7100 audio drivers
config: h8300-randconfig-r004-20220406 (https://download.01.org/0day-ci/archive/20220406/202204061929.5OKjyPph-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/46f456a9a328b4f2904920484bb3cf5afb654cdc
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 46f456a9a328b4f2904920484bb3cf5afb654cdc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from sound/soc/starfive/pwmdac.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:160:9: note: in expansion of macro 'BUG_ON'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:160:17: note: in expansion of macro 'virt_addr_valid'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   In file included from sound/soc/starfive/pwmdac.c:19:
   sound/soc/starfive/pwmdac.h: At top level:
>> sound/soc/starfive/pwmdac.h:145:6: warning: no previous prototype for 'sf_pwmdac_pcm_push_tx' [-Wmissing-prototypes]
     145 | void sf_pwmdac_pcm_push_tx(struct sf_pwmdac_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/pwmdac.h:146:6: warning: no previous prototype for 'sf_pwmdac_pcm_pop_rx' [-Wmissing-prototypes]
     146 | void sf_pwmdac_pcm_pop_rx(struct sf_pwmdac_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/pwmdac.h:147:5: warning: no previous prototype for 'sf_pwmdac_pcm_register' [-Wmissing-prototypes]
     147 | int sf_pwmdac_pcm_register(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


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
