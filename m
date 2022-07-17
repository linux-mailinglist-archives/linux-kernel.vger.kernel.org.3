Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B1577289
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 02:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiGQAMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 20:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGQAMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 20:12:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552719C3F;
        Sat, 16 Jul 2022 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658016722; x=1689552722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HFHgTs6YcSEEVWfkRgiSn0j5/xmOi9Hqq1hD2gQcRO8=;
  b=NLYVH6sHvE4f4xwSAwFpgI+jZBR342jA1m7ImtYAYL0+RDwklwjtQ6Jh
   OjOtBUHIHclaoNUyD/0wgnvNW7SPf4gKe0jl79vjTdhRt90G+hjzmBpQ6
   ioxGglMN+onHUjWATg27I/hS9XnfVI8iZngpHVmXnTtxsWXrE4IWjpBFx
   CH59v8g5IJPZukfb5vlidsEcY18oJHGo56OlGQ5gM8C6+MQmuskgl7qBw
   qmQTYNnoh43/CjrTpae3gtw86x/QeZRIaCar3AfJDl3J/lWOGVJ+7kVQN
   Itjw6uPp5Ogv+jFaiEHf7zDRPTYG+kz6WZzP+uzuBYaJyBu/qxPXmy+2S
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="266422036"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="266422036"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 17:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="547067558"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 17:12:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCrt9-0002L8-96;
        Sun, 17 Jul 2022 00:11:59 +0000
Date:   Sun, 17 Jul 2022 08:11:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3126:34:
 warning: unused variable 'samsung_jpeg_match'
Message-ID: <202207170810.jqfLUIpt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   972a278fe60c361eb8f37619f562f092e8786d7c
commit: f4104b7851a8d8b9a70899dcbecdb393eb16cd8a media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/
date:   4 months ago
config: hexagon-buildonly-randconfig-r005-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170810.jqfLUIpt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4104b7851a8d8b9a70899dcbecdb393eb16cd8a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f4104b7851a8d8b9a70899dcbecdb393eb16cd8a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/samsung/s5p-jpeg/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3126:34: warning: unused variable 'samsung_jpeg_match' [-Wunused-const-variable]
   static const struct of_device_id samsung_jpeg_match[] = {
                                    ^
   1 warning generated.


vim +/samsung_jpeg_match +3126 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c

6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3125  
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18 @3126  static const struct of_device_id samsung_jpeg_match[] = {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3127  	{
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3128  		.compatible = "samsung,s5pv210-jpeg",
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3129  		.data = &s5p_jpeg_drvdata,
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3130  	}, {
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3131  		.compatible = "samsung,exynos3250-jpeg",
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3132  		.data = &exynos3250_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3133  	}, {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3134  		.compatible = "samsung,exynos4210-jpeg",
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3135  		.data = &exynos4_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3136  	}, {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3137  		.compatible = "samsung,exynos4212-jpeg",
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3138  		.data = &exynos4_jpeg_drvdata,
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3139  	}, {
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3140  		.compatible = "samsung,exynos5420-jpeg",
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3141  		.data = &exynos5420_jpeg_drvdata,
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3142  	}, {
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3143  		.compatible = "samsung,exynos5433-jpeg",
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3144  		.data = &exynos5433_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3145  	},
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3146  	{},
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3147  };
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3148  

:::::: The code at line 3126 was first introduced by commit
:::::: 80529ae5c13725e12ba0377e29b2160794ba6b25 [media] s5p-jpeg:  JPEG codec

:::::: TO: Jacek Anaszewski <j.anaszewski@samsung.com>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
