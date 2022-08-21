Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07D59B182
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiHUEHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHUEHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:07:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D0625586
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661054853; x=1692590853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b3IDgkwBaCi9+3cSqx4dzk4m4r8nbLRcncOe7pYq3BE=;
  b=fKmPgRY72ih15pb8Qnx9Tfx+9roj2yrk+VESBV0ue8skadjQkh7ggYdg
   JxeHFus2Wtt00MzBbeYanbM3Rl8GWicNeCKJHm5hcmBMg9puR1A2lDUHT
   PvDZwd77veoIP9qbvv3Q2UBKIuWcnT8lomz8v44tZ1Izi17d2O7P947Nm
   81rH9DuR7bA2YgIp/9i7jLg+D0gkvpAS9oItO9jj3C5XRZdFNZyjsUGYk
   BGOVZaQ5Q+6FNBpVQ6GM7NQbtqoIWE2YWc0Lm49hNfyXcWkITFDl4JBg3
   XLw7rh/WgswHikXbOugRNFepHnxhXNigqLYpGFcQZsYiWH3vG+iS4KD8C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="280186956"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280186956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 21:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="641658329"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2022 21:07:31 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPcFG-0003cS-12;
        Sun, 21 Aug 2022 04:07:30 +0000
Date:   Sun, 21 Aug 2022 12:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 9324/9817] vc4_dsi.c:undefined
 reference to `devm_drm_of_get_bridge'
Message-ID: <202208211218.dB0ZAtSG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   decfb75fa34c3fc79f494f44b36d56d1d744edd5
commit: 3d722c01d628d17a37cf2820195f15cfc9a6a332 [9324/9817] drm/vc4: Use of_device_get_match_data()
config: xtensa-randconfig-r001-20220821 (https://download.01.org/0day-ci/archive/20220821/202208211218.dB0ZAtSG-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=3d722c01d628d17a37cf2820195f15cfc9a6a332
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 3d722c01d628d17a37cf2820195f15cfc9a6a332
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/gpu/drm/vc4/vc4_dsi.o: in function `vc4_dsi_irq_handler':
>> vc4_dsi.c:(.text+0x13b4): undefined reference to `devm_drm_of_get_bridge'
   xtensa-linux-ld: drivers/gpu/drm/vc4/vc4_dsi.o: in function `vc4_dsi_bind':
   vc4_dsi.c:(.text+0x165a): undefined reference to `devm_drm_of_get_bridge'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
