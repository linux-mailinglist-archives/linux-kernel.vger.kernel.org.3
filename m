Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446514E7CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiCYUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiCYUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:23:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F59A62A1E;
        Fri, 25 Mar 2022 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648239731; x=1679775731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c+Jo2f9qa8wqIGXPx9eITTauJDs5OOtXfRCmPSXzDLY=;
  b=HWiaKIkq1uCSvEZ5+6YZk/rHoysxNAhkwUNpAhgBp9yx9+SzhdCKbaSC
   U95Pbs0FUIcRakwOOImZh7n8pKqKoW5B8ESk1dfuuNCCeQ6TT7xMv6fOK
   V84Hx8QfQPbxWi++auPIzuG//+Rjicj/VVBmr4bQiF6JUm7GKiKgLpiOd
   vOvnKeZURBMFmAJ/TamlJMaxtZDzU8weqqZrhbKglnetCrAQcFl9bdF8Z
   hnK8PPd01VllCkhmflRV4luyBvEao1jt1G6YFxy6OAMcK+UreqYANNo1b
   iyzJnNdTOTskLNzSg1bEMrPYoDzeXycVjw2BPRREhb6hEUoJhcD6l+rIA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="246198366"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="246198366"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="545212190"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2022 13:22:09 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXqRl-000MZR-7R; Fri, 25 Mar 2022 20:22:09 +0000
Date:   Sat, 26 Mar 2022 04:21:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h:35:6:
 warning: no previous prototype for 'fimc_isp_video_device_unregister'
Message-ID: <202203260407.3uIXrNn4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aa5b537b0ecc16992577b013f11112d54c7ce869
commit: 238c84f71120f41c45301359902a912a19370f3d media: platform: rename exynos4-is/ to samsung/exynos4-is/
date:   8 days ago
config: nios2-buildonly-randconfig-r006-20220325 (https://download.01.org/0day-ci/archive/20220326/202203260407.3uIXrNn4-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=238c84f71120f41c45301359902a912a19370f3d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 238c84f71120f41c45301359902a912a19370f3d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/samsung/exynos4-is/fimc-isp.c:25:
>> drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h:35:6: warning: no previous prototype for 'fimc_isp_video_device_unregister' [-Wmissing-prototypes]
      35 | void fimc_isp_video_device_unregister(struct fimc_isp *isp,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
