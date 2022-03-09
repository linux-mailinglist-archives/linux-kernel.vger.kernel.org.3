Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743B4D28B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiCIGK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCIGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:10:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8D6101F2B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646806196; x=1678342196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BkddJwLaNHbRkIM03fEcB7GswNwAmU2E4YNG/vlpmOA=;
  b=NS72C315K4FsYSEGVFNkNN8SXvHPpytVYEQt/+6wj1QOkRhWlxWmTCtV
   Uvj7rDgxF+WKF8Rpe+BecgO+cyjxttgw1MWIjRehx2yFgzQtxol3fS+AI
   BiEo7CZAD81zJNKL56rMmKlsGOfqBcoXxHl+Dtoc9y1zHz6v/3QR6sTBX
   yh8aPGNyFANtU/aA3zwB9Zl8vC4aeTHs8SwCWRJGx1vjp4/NvjzXVg9Ka
   Arz5tHxufPSZPD/LpP4kEvWMqgcllGelFOyGem2ZlO4+pbpGI5/7uA6Za
   tjTWtYyh8VYYaDwEAUgtOwkSmpFLNbj7R1UsC9jdeHtormncMb/fjRl8j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279621733"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="279621733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="596161489"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2022 22:09:55 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRpWE-0002i7-BG; Wed, 09 Mar 2022 06:09:54 +0000
Date:   Wed, 9 Mar 2022 14:09:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:tuxsuite 33/42]
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1405:37: warning: unused
 variable 'sm8350_regdma'
Message-ID: <202203091451.k8xPf3xI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel tuxsuite
head:   d1c9502cfe160da3c09a0f379147f16d559e4ab7
commit: 263030b81c7535a746e774fd5fcba7b5e30b3180 [33/42] drm/msm/dpu: Fix typo in sm8350 hw_catalog
config: riscv-randconfig-r042-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091451.k8xPf3xI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/andersson/kernel/commit/263030b81c7535a746e774fd5fcba7b5e30b3180
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson tuxsuite
        git checkout 263030b81c7535a746e774fd5fcba7b5e30b3180
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/ drivers/dma/ drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1405:37: warning: unused variable 'sm8350_regdma' [-Wunused-const-variable]
   static const struct dpu_reg_dma_cfg sm8350_regdma = {
                                       ^
   1 warning generated.


vim +/sm8350_regdma +1405 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

af776a3e1c304bf Jonathan Marek 2020-07-10  1404  
b3a92bed29f97a8 Robert Foss    2021-06-16 @1405  static const struct dpu_reg_dma_cfg sm8350_regdma = {
b3a92bed29f97a8 Robert Foss    2021-06-16  1406  	.base = 0x0,
b3a92bed29f97a8 Robert Foss    2021-06-16  1407  	.version = 0x00020000,
b3a92bed29f97a8 Robert Foss    2021-06-16  1408  	.trigger_sel_off = 0x119c,
b3a92bed29f97a8 Robert Foss    2021-06-16  1409  	.xin_id = 7,
b3a92bed29f97a8 Robert Foss    2021-06-16  1410  	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
b3a92bed29f97a8 Robert Foss    2021-06-16  1411  };
b3a92bed29f97a8 Robert Foss    2021-06-16  1412  

:::::: The code at line 1405 was first introduced by commit
:::::: b3a92bed29f97a812160786819bf18c2cc590cc9 drm/msm/dpu: Add SM8350 to hw catalog

:::::: TO: Robert Foss <robert.foss@linaro.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
