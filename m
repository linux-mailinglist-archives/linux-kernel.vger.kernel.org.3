Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEE47CD93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhLVHel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:34:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:20638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243018AbhLVHej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640158479; x=1671694479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=83WKMpgmd2Hu6tY0NSHF4KKHcftxqykMjMZPEZ1Wo/c=;
  b=UckiTL7e3LBVBMvErsJ0EeYYP18PzY+NXzeJTfIGp+nS/V31pc3PAh5v
   zG6nsP7TTdyByG59jfVfbS4gNPLfd5vtxVMAC80G3qneK/WUC1SriApe8
   p9qHm5GBBlRh+dxrEbr+fRY+H9hi6Po/UGy9Tb3J3m/Yrjjfr+In5lY+/
   Jv1eM/CLBazPsM964CaRnabnGoh+OrW0cecwjjdeubDyuR9dJRrf+AkLF
   emUpA//oJNoa2ogx38ue+LpK05h5HeRbBi0SvMNzSs1PG2GH9SEGKlpMv
   /sIiIbKZ1eBdMzQF44dZOQx/bz1V/dzA2UTSAu68lgOyC/m/n/lYk2P91
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="239317303"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="239317303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 23:34:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="684933256"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 23:34:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzw8z-0000FN-12; Wed, 22 Dec 2021 07:34:37 +0000
Date:   Wed, 22 Dec 2021 15:34:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211215 24/35]
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1040:37: warning: unused
 variable 'sm8350_regdma'
Message-ID: <202112221505.c3wIxSKR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211215
head:   525164cde506e9a9353b07816e50e26685e57fe4
commit: 54ccddafd25a1a96ca276ffe86c96c41fcc98b80 [24/35] drm/msm/dpu: Fix typo in sm8350 hw_catalog
config: hexagon-randconfig-r041-20211222 (https://download.01.org/0day-ci/archive/20211222/202112221505.c3wIxSKR-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/54ccddafd25a1a96ca276ffe86c96c41fcc98b80
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211215
        git checkout 54ccddafd25a1a96ca276ffe86c96c41fcc98b80
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1040:37: warning: unused variable 'sm8350_regdma' [-Wunused-const-variable]
   static const struct dpu_reg_dma_cfg sm8350_regdma = {
                                       ^
   1 warning generated.


vim +/sm8350_regdma +1040 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

af776a3e1c304bf Jonathan Marek 2020-07-10  1039  
2fee5af852f1b5e Robert Foss    2021-06-16 @1040  static const struct dpu_reg_dma_cfg sm8350_regdma = {
2fee5af852f1b5e Robert Foss    2021-06-16  1041  	.base = 0x0,
2fee5af852f1b5e Robert Foss    2021-06-16  1042  	.version = 0x00020000,
2fee5af852f1b5e Robert Foss    2021-06-16  1043  	.trigger_sel_off = 0x119c,
2fee5af852f1b5e Robert Foss    2021-06-16  1044  	.xin_id = 7,
2fee5af852f1b5e Robert Foss    2021-06-16  1045  	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
2fee5af852f1b5e Robert Foss    2021-06-16  1046  };
2fee5af852f1b5e Robert Foss    2021-06-16  1047  

:::::: The code at line 1040 was first introduced by commit
:::::: 2fee5af852f1b5e0cfacae8782b09c0a888b3488 drm/msm/dpu: Add SM8350 to hw catalog

:::::: TO: Robert Foss <robert.foss@linaro.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
