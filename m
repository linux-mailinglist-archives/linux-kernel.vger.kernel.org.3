Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB094ECE78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351197AbiC3VCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbiC3VCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:02:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303EB28E07;
        Wed, 30 Mar 2022 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648674019; x=1680210019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8FC2FPhKtM0mTtO05j8fjDdgfsYLuSdSZPWEuv5HJBk=;
  b=G+p8rObvSJ/MT8DTmBGGNeA6XJ0SnBnB1uHGC/pN/siDQMKDYobBZMPm
   pqgG505RlDRsuYdiWIVIDYiCataao4dXWxGX9WoqaoNDPgHGJmfvEXj4X
   mOQz0KGxItlt3w64sw1b8aOrMqjVIpf5AQqOcsn85VYD7PBs+3I3lGbSN
   RRBSGZrtY1vE2ebkOgiczAHywOhzfhxCyKQVXZqLc4vGKY/TzLH6wLEud
   DpJUuApi8+QB9WJG/quWodMG6GW+teC7Dp9gq7RDQr+ACspeLRMeZm5bc
   IRzs3znUnMOnjl5mvup1F5P8GMm9NmpZwm8HTkkB6ZEhxiaCxYvMND9W7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259618385"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259618385"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="503460985"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 14:00:15 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZfQN-0000V2-4A;
        Wed, 30 Mar 2022 21:00:15 +0000
Date:   Thu, 31 Mar 2022 04:59:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h:35:6:
 warning: no previous prototype for function
 'fimc_isp_video_device_unregister'
Message-ID: <202203310447.czIadBgz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: 238c84f71120f41c45301359902a912a19370f3d media: platform: rename exynos4-is/ to samsung/exynos4-is/
date:   13 days ago
config: riscv-randconfig-r003-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310447.czIadBgz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=238c84f71120f41c45301359902a912a19370f3d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 238c84f71120f41c45301359902a912a19370f3d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/samsung/exynos4-is/fimc-isp.c:25:
>> drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h:35:6: warning: no previous prototype for function 'fimc_isp_video_device_unregister' [-Wmissing-prototypes]
   void fimc_isp_video_device_unregister(struct fimc_isp *isp,
        ^
   drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h:35:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void fimc_isp_video_device_unregister(struct fimc_isp *isp,
   ^
   static 
   1 warning generated.


vim +/fimc_isp_video_device_unregister +35 drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h

34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20  34  
34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20 @35  void fimc_isp_video_device_unregister(struct fimc_isp *isp,
34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20  36  				enum v4l2_buf_type type)
34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20  37  {
34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20  38  }
34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20  39  #endif /* !CONFIG_VIDEO_EXYNOS4_ISP_DMA_CAPTURE */
34947b8aebe3f2 drivers/media/platform/exynos4-is/fimc-isp-video.h Sylwester Nawrocki 2013-12-20  40  

:::::: The code at line 35 was first introduced by commit
:::::: 34947b8aebe3f2d4eceb65fceafa92bf8dc97d96 [media] exynos4-is: Add the FIMC-IS ISP capture DMA driver

:::::: TO: Sylwester Nawrocki <s.nawrocki@samsung.com>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
