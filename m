Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169304FFF79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiDMTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDMTl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:41:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B529DF3F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649878775; x=1681414775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Unbq9wvs3stZpFFAlOqO54M0np3+hySwkxR+G8fbUvc=;
  b=PNHLEZBUxtREXIjUHBIcB7e7Vff0iHu5Xypaa5fW18WJKvBctnK5FEWg
   D30V6GOvlyC43Eb7gyT1k6inAQvj6thonZu8odNBzSFY1fXAk6jIFtzMM
   t4rr4pz5EBvHqMeM37z6tAM3cbUxQ1pt+KnJp4yb2i12faOwVC54YTwqD
   cXWM3Ymmvi2uxlviMsxnq1udP/TpvLh9815Y5X7K2e9tVVj45to30clrk
   BlxlFPvKcRkzN8JLerIaHmVRIOI6orETxS63g+OeteQ25j6GNA2uw7Ohm
   PgGVznITPzcdLKkyEilNbUAmvreURmO86ye0+7QjA+W1z23xlGktzqL+h
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262508925"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262508925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="854913635"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2022 12:39:33 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neipw-0000YY-Ar;
        Wed, 13 Apr 2022 19:39:32 +0000
Date:   Thu, 14 Apr 2022 03:39:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/4] rcar_du_drv.c:(.text+0x130): multiple
 definition of `kallsyms_lookup_names';
 drivers/gpu/drm/rcar-du/rcar_du_crtc.o:rcar_du_crtc.c:(.text+0xb7a): first
 defined here
Message-ID: <202204140323.azvyw7PV-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   ba203a35f44376540c3c5dd72bf9ba0b9cfc4473
commit: c42ec4e0334aacc783148e3571f3e0db53e4220a [1/4] kallsyms: Add kallsyms_lookup_names function
config: arm-randconfig-c002-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140323.azvyw7PV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c42ec4e0334aacc783148e3571f3e0db53e4220a
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout c42ec4e0334aacc783148e3571f3e0db53e4220a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_drv.o: in function `kallsyms_lookup_names':
>> rcar_du_drv.c:(.text+0x130): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/rcar-du/rcar_du_crtc.o:rcar_du_crtc.c:(.text+0xb7a): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_encoder.o: in function `kallsyms_lookup_names':
   rcar_du_encoder.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/rcar-du/rcar_du_crtc.o:rcar_du_crtc.c:(.text+0xb7a): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_group.o: in function `kallsyms_lookup_names':
   rcar_du_group.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/rcar-du/rcar_du_crtc.o:rcar_du_crtc.c:(.text+0xb7a): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_kms.o: in function `kallsyms_lookup_names':
   rcar_du_kms.c:(.text+0x430): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/rcar-du/rcar_du_crtc.o:rcar_du_crtc.c:(.text+0xb7a): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_plane.o: in function `kallsyms_lookup_names':
   rcar_du_plane.c:(.text+0x560): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/rcar-du/rcar_du_crtc.o:rcar_du_crtc.c:(.text+0xb7a): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/i2c/ch7006_mode.o: in function `kallsyms_lookup_names':
>> ch7006_mode.c:(.text+0x9e): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/i2c/ch7006_drv.o:ch7006_drv.c:(.text+0x834): first defined here
--
   arm-linux-gnueabi-ld: drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.o: in function `kallsyms_lookup_names':
>> mvpp2_prs.c:(.text+0xe7c): multiple definition of `kallsyms_lookup_names'; drivers/net/ethernet/marvell/mvpp2/mvpp2_main.o:mvpp2_main.c:(.text+0x3034): first defined here
   arm-linux-gnueabi-ld: drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.o: in function `kallsyms_lookup_names':
   mvpp2_cls.c:(.text+0x588): multiple definition of `kallsyms_lookup_names'; drivers/net/ethernet/marvell/mvpp2/mvpp2_main.o:mvpp2_main.c:(.text+0x3034): first defined here
   arm-linux-gnueabi-ld: drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.o: in function `kallsyms_lookup_names':
   mvpp2_debugfs.c:(.text+0x8a8): multiple definition of `kallsyms_lookup_names'; drivers/net/ethernet/marvell/mvpp2/mvpp2_main.o:mvpp2_main.c:(.text+0x3034): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.o: in function `kallsyms_lookup_names':
>> atmel_hlcdc_dc.c:(.text+0x378): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.o:atmel_hlcdc_crtc.c:(.text+0x5a6): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.o: in function `kallsyms_lookup_names':
   atmel_hlcdc_output.c:(.text+0x11c): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.o:atmel_hlcdc_crtc.c:(.text+0x5a6): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.o: in function `kallsyms_lookup_names':
   atmel_hlcdc_plane.c:(.text+0x924): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.o:atmel_hlcdc_crtc.c:(.text+0x5a6): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/shmobile/shmob_drm_crtc.o: in function `kallsyms_lookup_names':
>> shmob_drm_crtc.c:(.text+0x8cc): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/shmobile/shmob_drm_backlight.o:shmob_drm_backlight.c:(.text+0x68): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/shmobile/shmob_drm_drv.o: in function `kallsyms_lookup_names':
   shmob_drm_drv.c:(.text+0x258): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/shmobile/shmob_drm_backlight.o:shmob_drm_backlight.c:(.text+0x68): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/shmobile/shmob_drm_kms.o: in function `kallsyms_lookup_names':
   shmob_drm_kms.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/shmobile/shmob_drm_backlight.o:shmob_drm_backlight.c:(.text+0x68): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/shmobile/shmob_drm_plane.o: in function `kallsyms_lookup_names':
   shmob_drm_plane.c:(.text+0x350): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/shmobile/shmob_drm_backlight.o:shmob_drm_backlight.c:(.text+0x68): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_framebuffer.o: in function `kallsyms_lookup_names':
>> sun4i_framebuffer.c:(.text+0x30): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_drv.o:sun4i_drv.c:(.text+0x464): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_dotclock.o: in function `kallsyms_lookup_names':
>> sun4i_dotclock.c:(.text+0x22c): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_crtc.o:sun4i_crtc.c:(.text+0x28c): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_lvds.o: in function `kallsyms_lookup_names':
   sun4i_lvds.c:(.text+0x168): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_crtc.o:sun4i_crtc.c:(.text+0x28c): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_tcon.o: in function `kallsyms_lookup_names':
   sun4i_tcon.c:(.text+0x10b4): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_crtc.o:sun4i_crtc.c:(.text+0x28c): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_rgb.o: in function `kallsyms_lookup_names':
   sun4i_rgb.c:(.text+0x31c): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_crtc.o:sun4i_crtc.c:(.text+0x28c): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_hdmi_enc.o: in function `kallsyms_lookup_names':
>> sun4i_hdmi_enc.c:(.text+0x824): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.o:sun4i_hdmi_ddc_clk.c:(.text+0x14a): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.o: in function `kallsyms_lookup_names':
   sun4i_hdmi_i2c.c:(.text+0x6c4): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.o:sun4i_hdmi_ddc_clk.c:(.text+0x14a): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.o: in function `kallsyms_lookup_names':
   sun4i_hdmi_tmds_clk.c:(.text+0x25e): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.o:sun4i_hdmi_ddc_clk.c:(.text+0x14a): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun8i_hdmi_phy.o: in function `kallsyms_lookup_names':
>> sun8i_hdmi_phy.c:(.text+0x7b0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun8i_dw_hdmi.o:sun8i_dw_hdmi.c:(.text+0x3d2): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.o: in function `kallsyms_lookup_names':
   sun8i_hdmi_phy_clk.c:(.text+0x1ae): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun8i_dw_hdmi.o:sun8i_dw_hdmi.c:(.text+0x3d2): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun8i_ui_layer.o: in function `kallsyms_lookup_names':
>> sun8i_ui_layer.c:(.text+0x518): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun8i_mixer.o:sun8i_mixer.c:(.text+0x4c8): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/sun4i/sun8i_vi_layer.o: in function `kallsyms_lookup_names':
   sun8i_vi_layer.c:(.text+0x730): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/sun4i/sun8i_mixer.o:sun8i_mixer.c:(.text+0x4c8): first defined here
--
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/uapi.o: in function `kallsyms_lookup_names':
>> uapi.c:(.text+0x70): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/submit.o: in function `kallsyms_lookup_names':
   submit.c:(.text+0x9e8): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/firewall.o: in function `kallsyms_lookup_names':
   firewall.c:(.text+0xde): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/gem.o: in function `kallsyms_lookup_names':
   gem.c:(.text+0x6c8): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/fb.o: in function `kallsyms_lookup_names':
   fb.c:(.text+0x0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/dp.o: in function `kallsyms_lookup_names':
   dp.c:(.text+0x294): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/hub.o: in function `kallsyms_lookup_names':
   hub.c:(.text+0xd48): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/plane.o: in function `kallsyms_lookup_names':
   plane.c:(.text+0x460): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/dc.o: in function `kallsyms_lookup_names':
   dc.c:(.text+0x1f20): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/output.o: in function `kallsyms_lookup_names':
   output.c:(.text+0x56): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/rgb.o: in function `kallsyms_lookup_names':
   rgb.c:(.text+0x14c): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/hdmi.o: in function `kallsyms_lookup_names':
   hdmi.c:(.text+0x1370): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/dsi.o: in function `kallsyms_lookup_names':
   dsi.c:(.text+0x13d0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/sor.o: in function `kallsyms_lookup_names':
   sor.c:(.text+0x2b34): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/dpaux.o: in function `kallsyms_lookup_names':
   dpaux.c:(.text+0x7c8): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/gr2d.o: in function `kallsyms_lookup_names':
   gr2d.c:(.text+0x42c): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/gr3d.o: in function `kallsyms_lookup_names':
   gr3d.c:(.text+0x5cc): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/falcon.o: in function `kallsyms_lookup_names':
   falcon.c:(.text+0xc0): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/vic.o: in function `kallsyms_lookup_names':
   vic.c:(.text+0x574): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
   arm-linux-gnueabi-ld: drivers/gpu/drm/tegra/nvdec.o: in function `kallsyms_lookup_names':
   nvdec.c:(.text+0x49e): multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/tegra/drm.o:drm.c:(.text+0x638): first defined here
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
