Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B44E808D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiCZLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiCZLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:16:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4929F20F55
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648293316; x=1679829316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7/v/l2H0A5SuEU2+aIksa57Wkh4b99nPcJKF7mMZtsU=;
  b=OfrFCsoelwxFMljOXz+h5QW3+lU7EZrTeHwWnzDNiHKPVu2emm6+KEUk
   o7Y8bpGyhVaFZ5Wem+iCSI5osHBRQiwO+X+szl0YxmsK505QJxTfjrMzq
   t9VtkGGjoOy+W+p4uRy0gYug4Fsu/gtY9+C72k2kNtvEw8solYoGAP1dl
   MzzBNemQozNOxO0DHFTP2iiZtN18Ol5rdVcoBo7rVazin5qPZ6QVWpK0k
   ED+8FyQfRs4a9cxHyrG0XcYspQUBWcHAUx/uAdkgqxo1ORTnK4zpu2QGF
   9R183+rScLYcC8g1axgt4/+GaeJN5QO9Ep3/xIFmUiki+uIpmtwroInT5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="240931595"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="240931595"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 04:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="718487831"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2022 04:15:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY4O1-000NJV-0O; Sat, 26 Mar 2022 11:15:13 +0000
Date:   Sat, 26 Mar 2022 19:14:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220301 3/27]
 adreno_gpu.c:(.text+0x60): multiple definition of `msm_dp_wide_bus_enable';
 drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4):
 first defined here
Message-ID: <202203261924.hLeu3gUX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301
head:   0289eb1e5447f549241a40b2a0742a796467ecd8
commit: 87ad16647bc8be653328a973b07fb8f71eaedba2 [3/27] drm/msm/dp: enable widebus feature for display port
config: arm64-randconfig-r013-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261924.hLeu3gUX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/87ad16647bc8be653328a973b07fb8f71eaedba2
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301
        git checkout 87ad16647bc8be653328a973b07fb8f71eaedba2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h:11,
                    from drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c:7:
>> drivers/gpu/drm/msm/msm_drv.h:433:6: warning: no previous prototype for 'msm_dp_wide_bus_enable' [-Wmissing-prototypes]
     433 | bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
         |      ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/msm/msm_fence.c:9:
>> drivers/gpu/drm/msm/msm_drv.h:433:6: warning: no previous prototype for 'msm_dp_wide_bus_enable' [-Wmissing-prototypes]
     433 | bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/wait.h:9,
                    from include/linux/dma-fence.h:17,
                    from drivers/gpu/drm/msm/msm_fence.c:7:
   In function 'strncpy',
       inlined from 'msm_fence_context_alloc' at drivers/gpu/drm/msm/msm_fence.c:24:2:
   include/linux/fortify-string.h:52:33: warning: '__builtin_strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
      52 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:73:16: note: in expansion of macro '__underlying_strncpy'
      73 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~
--
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/adreno_gpu.o: in function `msm_dp_wide_bus_enable':
>> adreno_gpu.c:(.text+0x60): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a2xx_gpu.o: in function `msm_dp_wide_bus_enable':
   a2xx_gpu.c:(.text+0xfe0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a3xx_gpu.o: in function `msm_dp_wide_bus_enable':
   a3xx_gpu.c:(.text+0x12e0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a4xx_gpu.o: in function `msm_dp_wide_bus_enable':
   a4xx_gpu.c:(.text+0x15a0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a5xx_gpu.o: in function `msm_dp_wide_bus_enable':
   a5xx_gpu.c:(.text+0x1510): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a5xx_power.o: in function `msm_dp_wide_bus_enable':
   a5xx_power.c:(.text+0x560): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a5xx_preempt.o: in function `msm_dp_wide_bus_enable':
   a5xx_preempt.c:(.text+0x84): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in function `msm_dp_wide_bus_enable':
   a6xx_gpu.c:(.text+0x2ea0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gmu.o: in function `msm_dp_wide_bus_enable':
   a6xx_gmu.c:(.text+0x1af4): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_hfi.o: in function `msm_dp_wide_bus_enable':
   a6xx_hfi.c:(.text+0xa10): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi.o: in function `msm_dp_wide_bus_enable':
   hdmi.c:(.text+0xb00): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_audio.o: in function `msm_dp_wide_bus_enable':
   hdmi_audio.c:(.text+0x0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_bridge.o: in function `msm_dp_wide_bus_enable':
   hdmi_bridge.c:(.text+0x8c4): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_hpd.o: in function `msm_dp_wide_bus_enable':
   hdmi_hpd.c:(.text+0x250): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_i2c.o: in function `msm_dp_wide_bus_enable':
   hdmi_i2c.c:(.text+0x5e0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy.o: in function `msm_dp_wide_bus_enable':
   hdmi_phy.c:(.text+0x1f0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.o: in function `msm_dp_wide_bus_enable':
   hdmi_phy_8960.c:(.text+0x140): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.o: in function `msm_dp_wide_bus_enable':
   hdmi_phy_8996.c:(.text+0x1160): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.o: in function `msm_dp_wide_bus_enable':
   hdmi_phy_8x60.c:(.text+0x210): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.o: in function `msm_dp_wide_bus_enable':
   hdmi_phy_8x74.c:(.text+0xb0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.o: in function `msm_dp_wide_bus_enable':
   hdmi_pll_8960.c:(.text+0x410): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp_format.o: in function `msm_dp_wide_bus_enable':
   mdp_format.c:(.text+0x0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp_kms.o: in function `msm_dp_wide_bus_enable':
   mdp_kms.c:(.text+0xb0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.o: in function `msm_dp_wide_bus_enable':
   mdp4_crtc.c:(.text+0x10c0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.o: in function `msm_dp_wide_bus_enable':
   mdp4_dtv_encoder.c:(.text+0x480): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.o: in function `msm_dp_wide_bus_enable':
   mdp4_lcdc_encoder.c:(.text+0x7f0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.o: in function `msm_dp_wide_bus_enable':
   mdp4_lvds_connector.c:(.text+0x120): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.o: in function `msm_dp_wide_bus_enable':
   mdp4_lvds_pll.c:(.text+0x170): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_irq.o: in function `msm_dp_wide_bus_enable':
   mdp4_irq.c:(.text+0xf0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.o: in function `msm_dp_wide_bus_enable':
   mdp4_kms.c:(.text+0x870): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.o: in function `msm_dp_wide_bus_enable':
   mdp4_plane.c:(.text+0x870): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.o: in function `msm_dp_wide_bus_enable':
   mdp5_cfg.c:(.text+0x0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.o: in function `msm_dp_wide_bus_enable':
   mdp5_ctl.c:(.text+0x264): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.o: in function `msm_dp_wide_bus_enable':
   mdp5_crtc.c:(.text+0x2904): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.o: in function `msm_dp_wide_bus_enable':
   mdp5_encoder.c:(.text+0xe10): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_irq.o: in function `msm_dp_wide_bus_enable':
   mdp5_irq.c:(.text+0x104): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.o: in function `msm_dp_wide_bus_enable':
   mdp5_mdss.c:(.text+0x2e4): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.o: in function `msm_dp_wide_bus_enable':
   mdp5_kms.c:(.text+0x13f4): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.o: in function `msm_dp_wide_bus_enable':
   mdp5_pipe.c:(.text+0x0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.o: in function `msm_dp_wide_bus_enable':
   mdp5_mixer.c:(.text+0x0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.o: in function `msm_dp_wide_bus_enable':
   mdp5_plane.c:(.text+0x3d10): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.o: in function `msm_dp_wide_bus_enable':
   mdp5_smp.c:(.text+0x5c0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.o: in function `msm_dp_wide_bus_enable':
   dpu_core_perf.c:(.text+0x350): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.o: in function `msm_dp_wide_bus_enable':
   dpu_crtc.c:(.text+0x1e50): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.o: in function `msm_dp_wide_bus_enable':
   dpu_encoder.c:(.text+0x1a50): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.o: in function `msm_dp_wide_bus_enable':
   dpu_encoder_phys_cmd.c:(.text+0x17b4): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.o: in function `msm_dp_wide_bus_enable':
   dpu_encoder_phys_vid.c:(.text+0x1994): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_formats.o: in function `msm_dp_wide_bus_enable':
   dpu_formats.c:(.text+0x7d0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.o: in function `msm_dp_wide_bus_enable':
   dpu_hw_catalog.c:(.text+0xa44): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.o: in function `msm_dp_wide_bus_enable':
   dpu_hw_ctl.c:(.text+0xab0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
   aarch64-linux-ld: drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.o: in function `msm_dp_wide_bus_enable':
   dpu_hw_interrupts.c:(.text+0x114): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x2b4): first defined here
--
   In file included from drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:17:
>> drivers/gpu/drm/msm/msm_drv.h:433:6: warning: no previous prototype for 'msm_dp_wide_bus_enable' [-Wmissing-prototypes]
     433 | bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: In function 'dpu_encoder_virt_atomic_check':
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:566:40: warning: variable 'mode' set but not used [-Wunused-but-set-variable]
     566 |         const struct drm_display_mode *mode;
         |                                        ^~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
