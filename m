Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7514659567F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiHPJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiHPJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:32:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF0A543CF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660636492; x=1692172492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TLEuY2/U4pQUDEP/zjo9Z2OPr/WgpzE2RoPctNCb/wQ=;
  b=cIlyonEMoGa+/u9t7cY7fTcz0cSpdgSFnzi18HdYlZ/h0TyxFR+YgAgh
   slk8bkZVHWC7A8IhXa0jL3p6lLYZigq0Aet3kCNlxKxD41rNO1G2moIHN
   cB1lPtlPqSm/k7L5EPaYdoloYb92NeZPFg0dSM2AYQA8KIKVPXTCm2Irh
   rKGdZE59dBn3HARz3Skv03Mwj4BCj7WznKQJXPQ3f2D5TsOjClJEMkqQX
   nvXpICKwuw73XtzV6UpFdWd/lqzYZwNQf3wB/+mOqAnAS8y5GKjxkbWn9
   8dHdSRsNdylt5srOKr2XeCDetpI34itGGhmMp1L2a4yfd7DmJAXeJEMqp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279114878"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279114878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934801940"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 00:54:50 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNrPV-0001bt-34;
        Tue, 16 Aug 2022 07:54:49 +0000
Date:   Tue, 16 Aug 2022 15:54:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [linux-stable-rc:queue/5.10 199/544]
 drivers/gpu/drm/vc4/vc4_dsi.c:617:35: warning: unused variable 'dsi0_regs'
Message-ID: <202208161526.UJs2840c-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   b1f7647ff950714d3eb2ef0f32c7f84050dd6192
commit: 8402723ecfe0a2b2f8d4934794a45b1132689255 [199/544] drm/vc4: dsi: Introduce a variant structure
config: arm64-randconfig-r022-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161526.UJs2840c-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6afcc4a459ead8809a0d6d9b4bf7b64bcc13582b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8402723ecfe0a2b2f8d4934794a45b1132689255
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout 8402723ecfe0a2b2f8d4934794a45b1132689255
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/vc4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vc4/vc4_dsi.c:617:35: warning: unused variable 'dsi0_regs' [-Wunused-const-variable]
   static const struct debugfs_reg32 dsi0_regs[] = {
                                     ^
   1 warning generated.


vim +/dsi0_regs +617 drivers/gpu/drm/vc4/vc4_dsi.c

4078f575714423 Eric Anholt 2017-01-31  616  
3051719af11eb4 Eric Anholt 2019-02-20 @617  static const struct debugfs_reg32 dsi0_regs[] = {
3051719af11eb4 Eric Anholt 2019-02-20  618  	VC4_REG32(DSI0_CTRL),
3051719af11eb4 Eric Anholt 2019-02-20  619  	VC4_REG32(DSI0_STAT),
3051719af11eb4 Eric Anholt 2019-02-20  620  	VC4_REG32(DSI0_HSTX_TO_CNT),
3051719af11eb4 Eric Anholt 2019-02-20  621  	VC4_REG32(DSI0_LPRX_TO_CNT),
3051719af11eb4 Eric Anholt 2019-02-20  622  	VC4_REG32(DSI0_TA_TO_CNT),
3051719af11eb4 Eric Anholt 2019-02-20  623  	VC4_REG32(DSI0_PR_TO_CNT),
3051719af11eb4 Eric Anholt 2019-02-20  624  	VC4_REG32(DSI0_DISP0_CTRL),
3051719af11eb4 Eric Anholt 2019-02-20  625  	VC4_REG32(DSI0_DISP1_CTRL),
3051719af11eb4 Eric Anholt 2019-02-20  626  	VC4_REG32(DSI0_INT_STAT),
3051719af11eb4 Eric Anholt 2019-02-20  627  	VC4_REG32(DSI0_INT_EN),
3051719af11eb4 Eric Anholt 2019-02-20  628  	VC4_REG32(DSI0_PHYC),
3051719af11eb4 Eric Anholt 2019-02-20  629  	VC4_REG32(DSI0_HS_CLT0),
3051719af11eb4 Eric Anholt 2019-02-20  630  	VC4_REG32(DSI0_HS_CLT1),
3051719af11eb4 Eric Anholt 2019-02-20  631  	VC4_REG32(DSI0_HS_CLT2),
3051719af11eb4 Eric Anholt 2019-02-20  632  	VC4_REG32(DSI0_HS_DLT3),
3051719af11eb4 Eric Anholt 2019-02-20  633  	VC4_REG32(DSI0_HS_DLT4),
3051719af11eb4 Eric Anholt 2019-02-20  634  	VC4_REG32(DSI0_HS_DLT5),
3051719af11eb4 Eric Anholt 2019-02-20  635  	VC4_REG32(DSI0_HS_DLT6),
3051719af11eb4 Eric Anholt 2019-02-20  636  	VC4_REG32(DSI0_HS_DLT7),
3051719af11eb4 Eric Anholt 2019-02-20  637  	VC4_REG32(DSI0_PHY_AFEC0),
3051719af11eb4 Eric Anholt 2019-02-20  638  	VC4_REG32(DSI0_PHY_AFEC1),
3051719af11eb4 Eric Anholt 2019-02-20  639  	VC4_REG32(DSI0_ID),
4078f575714423 Eric Anholt 2017-01-31  640  };
4078f575714423 Eric Anholt 2017-01-31  641  

:::::: The code at line 617 was first introduced by commit
:::::: 3051719af11eb48dc8947826cfb66dbe0f281c7d drm/vc4: Use drm_print_regset32() for our debug register dumping.

:::::: TO: Eric Anholt <eric@anholt.net>
:::::: CC: Eric Anholt <eric@anholt.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
