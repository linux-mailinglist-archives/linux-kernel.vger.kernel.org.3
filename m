Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07AE519CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbiEDKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiEDKaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:30:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB63220ED
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651659986; x=1683195986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G/1h0mmCAHI89NJ6RpqHgx6tx+fF5K9lyD9FgLSW6Fk=;
  b=CBOcyxt8Bl4hvttPi3mRTamaaZaHyj41DWjH2bRcM1tj1uX8ymfp1omd
   gy5quDSuf6GJal8uqs0a9WUlHn3kWdzixhgefHcZEfDPp2uYW9jMVnbTd
   rfgE3Hg5hWELzIlCES8LSWQgI8xf9QekcK+NRj6qEnjvKzF7Paz6ALYNz
   NrPInZtvDcz2HElsL7q5fd4czG9ZULAG4S3UMhjg2HWbreombDFNOLWy1
   SidULxCvFWfc1sTDqqg77IH7w0pd50Xu7X5jyFott7ZEVp4+1T9XCd9U1
   HaXdCexv1cDNjFCFehLG2Q68Vv9EokwJJfX6ceOTHwzUTGfyl0+7Hrn1u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267605550"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="267605550"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 03:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="548586220"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 03:26:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmCD9-000BJB-HE;
        Wed, 04 May 2022 10:26:23 +0000
Date:   Wed, 4 May 2022 18:25:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220502 4/29]
 drivers/gpu/drm/msm/adreno/adreno_gpu.o:(.opd+0x30): multiple definition of
 `msm_dp_wide_bus_enable'; powerpc64-linux-ld: DWARF error: could not find
 abbrev number 175673006
Message-ID: <202205041823.i34hnSbf-lkp@intel.com>
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

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: 8e86e795739e6289d19ee78a32cf28b605a2416f [4/29] drm/msm/dp: enable widebus feature for display port
config: powerpc64-randconfig-r015-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041823.i34hnSbf-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/8e86e795739e6289d19ee78a32cf28b605a2416f
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout 8e86e795739e6289d19ee78a32cf28b605a2416f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/msm_kms.h:14,
                    from drivers/gpu/drm/msm/disp/msm_disp_snapshot.h:27,
                    from drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c:10:
>> drivers/gpu/drm/msm/msm_drv.h:410:6: warning: no previous prototype for 'msm_dp_wide_bus_enable' [-Wmissing-prototypes]
     410 | bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
         |      ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/msm/msm_fence.c:9:
>> drivers/gpu/drm/msm/msm_drv.h:410:6: warning: no previous prototype for 'msm_dp_wide_bus_enable' [-Wmissing-prototypes]
     410 | bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/msm_fence.c: In function 'msm_fence_context_alloc':
   drivers/gpu/drm/msm/msm_fence.c:25:9: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
      25 |         strncpy(fctx->name, name, sizeof(fctx->name));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:17:
>> drivers/gpu/drm/msm/msm_drv.h:410:6: warning: no previous prototype for 'msm_dp_wide_bus_enable' [-Wmissing-prototypes]
     410 | bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: In function 'dpu_encoder_virt_atomic_check':
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:566:40: warning: variable 'mode' set but not used [-Wunused-but-set-variable]
     566 |         const struct drm_display_mode *mode;
         |                                        ^~~~
--
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 2
>> drivers/gpu/drm/msm/adreno/adreno_gpu.o:(.opd+0x30): multiple definition of `msm_dp_wide_bus_enable'; powerpc64-linux-ld: DWARF error: could not find abbrev number 175673006
   drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/adreno_gpu.o: in function `.msm_dp_wide_bus_enable':
>> adreno_gpu.c:(.text+0xc0): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 12301
>> drivers/gpu/drm/msm/adreno/a2xx_gpu.o:(.opd+0xf0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a2xx_gpu.o: in function `.msm_dp_wide_bus_enable':
   a2xx_gpu.c:(.text+0x2700): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 111
   drivers/gpu/drm/msm/adreno/a3xx_gpu.o:(.opd+0xd8): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a3xx_gpu.o: in function `.msm_dp_wide_bus_enable':
   a3xx_gpu.c:(.text+0x35c0): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 78
   drivers/gpu/drm/msm/adreno/a4xx_gpu.o:(.opd+0x150): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a4xx_gpu.o: in function `.msm_dp_wide_bus_enable':
   a4xx_gpu.c:(.text+0x3c00): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 104
   drivers/gpu/drm/msm/adreno/a5xx_gpu.o:(.opd+0x198): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a5xx_gpu.o: in function `.msm_dp_wide_bus_enable':
   a5xx_gpu.c:(.text+0x3740): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 123
   drivers/gpu/drm/msm/adreno/a5xx_power.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a5xx_power.o: in function `.msm_dp_wide_bus_enable':
   a5xx_power.c:(.text+0xf00): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 72
   drivers/gpu/drm/msm/adreno/a5xx_preempt.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a5xx_preempt.o: in function `.msm_dp_wide_bus_enable':
   a5xx_preempt.c:(.text+0x380): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 6620
   drivers/gpu/drm/msm/adreno/a6xx_gpu.o:(.opd+0x2d0): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in function `.msm_dp_wide_bus_enable':
   a6xx_gpu.c:(.text+0x7d00): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 41
   drivers/gpu/drm/msm/adreno/a6xx_gmu.o:(.opd+0x180): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gmu.o: in function `.msm_dp_wide_bus_enable':
   a6xx_gmu.c:(.text+0x4180): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 1301
   drivers/gpu/drm/msm/adreno/a6xx_hfi.o:(.opd+0x90): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_hfi.o: in function `.msm_dp_wide_bus_enable':
   a6xx_hfi.c:(.text+0x1280): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 1479059
   drivers/gpu/drm/msm/hdmi/hdmi.o:(.opd+0x120): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi.o: in function `.msm_dp_wide_bus_enable':
   hdmi.c:(.text+0x1640): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 10140
   drivers/gpu/drm/msm/hdmi/hdmi_audio.o:(.opd+0x18): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_audio.o: in function `.msm_dp_wide_bus_enable':
   hdmi_audio.c:(.text+0x0): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 1574408
   drivers/gpu/drm/msm/hdmi/hdmi_bridge.o:(.opd+0x108): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_bridge.o: in function `.msm_dp_wide_bus_enable':
   hdmi_bridge.c:(.text+0x1440): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 1399925
   drivers/gpu/drm/msm/hdmi/hdmi_hpd.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_hpd.o: in function `.msm_dp_wide_bus_enable':
   hdmi_hpd.c:(.text+0x440): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 3599
   drivers/gpu/drm/msm/hdmi/hdmi_i2c.o:(.opd+0x60): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_i2c.o: in function `.msm_dp_wide_bus_enable':
   hdmi_i2c.c:(.text+0x1080): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 54
   drivers/gpu/drm/msm/hdmi/hdmi_phy.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy.o: in function `.msm_dp_wide_bus_enable':
   hdmi_phy.c:(.text+0x440): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 53
   drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.o: in function `.msm_dp_wide_bus_enable':
   hdmi_phy_8960.c:(.text+0x600): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 53
   drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.o:(.opd+0xd8): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.o: in function `.msm_dp_wide_bus_enable':
   hdmi_phy_8996.c:(.text+0x2e40): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 9665
   drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.o: in function `.msm_dp_wide_bus_enable':
   hdmi_phy_8x60.c:(.text+0xa00): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 7226
   drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.o: in function `.msm_dp_wide_bus_enable':
   hdmi_phy_8x74.c:(.text+0x440): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 13735
   drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.o:(.opd+0x90): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.o: in function `.msm_dp_wide_bus_enable':
   hdmi_pll_8960.c:(.text+0xe40): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 9530
   drivers/gpu/drm/msm/disp/mdp_format.o:(.opd+0x18): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/disp/mdp_format.o: in function `.msm_dp_wide_bus_enable':
   mdp_format.c:(.text+0x0): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 255057774
   drivers/gpu/drm/msm/disp/mdp_kms.o:(.opd+0x48): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/disp/mdp_kms.o: in function `.msm_dp_wide_bus_enable':
   mdp_kms.c:(.text+0x180): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 1723001
   drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.o:(.opd+0x198): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.o: in function `.msm_dp_wide_bus_enable':
   mdp4_crtc.c:(.text+0x2a40): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 81
   drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.o:(.opd+0x78): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.o: in function `.msm_dp_wide_bus_enable':
   mdp4_dtv_encoder.c:(.text+0xd40): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 5
   drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.o:(.opd+0x90): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here
   powerpc64-linux-ld: drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.o: in function `.msm_dp_wide_bus_enable':
   mdp4_lcdc_encoder.c:(.text+0x1740): multiple definition of `.msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:adreno_device.c:(.text+0x7c0): first defined here
   powerpc64-linux-ld: powerpc64-linux-ld: DWARF error: could not find abbrev number 3
   drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.o:(.opd+0x78): multiple definition of `msm_dp_wide_bus_enable'; drivers/gpu/drm/msm/adreno/adreno_device.o:(.opd+0xd8): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
