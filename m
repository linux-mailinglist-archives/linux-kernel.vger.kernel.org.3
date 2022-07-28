Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D6583CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiG1LRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiG1LRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:17:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2866B8E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659007031; x=1690543031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DtIM29pjTxa4VPaINN54wUy0i5N0ICSLry3uEWs/U2Q=;
  b=SfJrhAvaBIA3miH/4xWwFE6QXv7BJGmKjwRcYs4yBZdMMKvrSL7Jf96A
   GolO6gRXeNm5iH/q50kULfP51rt9cQD4mbwGiIOcEmZx5a9Zll79O57AL
   TfotQrQtVgUNGQXcmLjbLi6Pg/cNRkt7GrVnNAHpToniSfpNed3sWyz4T
   I01UtBzElpFGsFDb5L9pZBqhoMZJKoTcE4BMuZQrifHw2PPxmOwxMZy8d
   zKpwDNMKJ/n39Q0he+NwnnK2jIkU/9t1Q1qvPeT2JIPYWhWGwOp/dpCTT
   0o5kdVXTeJ0XKYR3l74xDklxkz7PueUp4CyhYpw6W5MkMA2xZefKN0/ij
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="352483186"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="352483186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 04:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="551266936"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 04:17:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH1Vq-0009vO-1j;
        Thu, 28 Jul 2022 11:17:06 +0000
Date:   Thu, 28 Jul 2022 19:16:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 14/141]
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:1535:37: warning: unused
 variable 'sc8280xp_regdma'
Message-ID: <202207281931.tLjk8lkA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   05eac286762272a5a2e5a5cd797ecb08b8e92741
commit: 64ab2ccaef7b7adf21c879bae5090e8c0a60135a [14/141] drm/msm/dpu: Introduce sc8280xp
config: arm64-randconfig-r003-20220728 (https://download.01.org/0day-ci/archive/20220728/202207281931.tLjk8lkA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/steev/linux/commit/64ab2ccaef7b7adf21c879bae5090e8c0a60135a
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout 64ab2ccaef7b7adf21c879bae5090e8c0a60135a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/

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
