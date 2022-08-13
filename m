Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F508591C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbiHMSgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiHMSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:36:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4C10572
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660415789; x=1691951789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z9vmo3oouOg13TEelcgv+Ek1MmzLAcDcfCyaj5ae2hg=;
  b=j7/IGJXZDxRt4BehcvG3JeQVGvTBKytlg4L5pnDiszTi6sqWSCCKuybR
   2CyM4InFjszzo3NOQ0FckD5jtwHgd0KxGs2PKkV7SzmLs+E0HYiZ8Yv7J
   RTL9dDtRTSuZeL99uiCNLQNvEV4Q+cq6HyYtJS54cVqBLp0RgYzHCrHx8
   C2SvLar0JmpBIta4cOsm5oct+DKHlT1p5Cu0oYb+yvxjbU2vTYo12HOr0
   t+cd3Jj6/m+ur8jGQ6xaOamapVZi5taTZLGDX5jzSoDqC/15RXA9FxfQV
   QkEDLpNcgm7go6ybpIU0Wdz9P9mOL5nO0xArHG6hsoW9FHegeml/Ct56o
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="378060861"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="378060861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 11:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="635018771"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2022 11:36:27 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMvzn-0001zF-0O;
        Sat, 13 Aug 2022 18:36:27 +0000
Date:   Sun, 14 Aug 2022 02:35:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8280xp-next-20220720-nonworking-gpu 9/143]
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1535:37: warning: unused
 variable 'sc8280xp_regdma'
Message-ID: <202208140224.llj1D2O5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8280xp-next-20220720-nonworking-gpu
head:   50749fc985b5eb2036a6139b10182a05e42ce4b0
commit: 4dc0d00149b8260bcbe5fd583b44ff1b1bbac3cd [9/143] drm/msm/dpu: Introduce sc8280xp
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220814/202208140224.llj1D2O5-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/andersson/kernel/commit/4dc0d00149b8260bcbe5fd583b44ff1b1bbac3cd
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8280xp-next-20220720-nonworking-gpu
        git checkout 4dc0d00149b8260bcbe5fd583b44ff1b1bbac3cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1535:37: warning: unused variable 'sc8280xp_regdma' [-Wunused-const-variable]
   static const struct dpu_reg_dma_cfg sc8280xp_regdma = {
                                       ^
   1 warning generated.


vim +/sc8280xp_regdma +1535 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

  1534	
> 1535	static const struct dpu_reg_dma_cfg sc8280xp_regdma = {
  1536		.base = 0x0,
  1537		.version = 0x00020000,
  1538		.trigger_sel_off = 0x119c,
  1539		.xin_id = 7,
  1540		.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
  1541	};
  1542	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
