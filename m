Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8F4D2A63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiCIIPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiCIIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:15:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3F4E02C7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646813641; x=1678349641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kPfFJUUUjlCsexJdOicJgo8/WKxLoFygDITCohZkCDc=;
  b=P/msNM4zmTAnvZKIk2Zoab7Ccie6aQjCf0aO7CGYM92dYB6sutFQVu/a
   Zn/pzsNPc+DuTcdyQ1LYo7DJSAWKptzBKzKY5EcoXHGOJRQSwn96roysP
   MQI7/AUMLDI8/Ex9pbCo6zSPRYa8awifk3UPib340IgX0klbJLP/kOSIS
   0Dobn4JkKqYLyMHYQqZ9sN7GqccEcXjyMptSYwhYi51gBr86u/O2VnlsR
   JeXn8M2nTZXbuCC6LR6BzfKq34ccT+HjTTSh3skbjMYrHfrl4t9Ig2Bef
   C0zwDbO6K0ugnLtbQyKWVdEKXJLdxn5q9D56//WXEG6LbknEb/y7//yoD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252488193"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="252488193"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:14:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="643959005"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2022 00:13:59 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRrSI-0002u5-DM; Wed, 09 Mar 2022 08:13:58 +0000
Date:   Wed, 9 Mar 2022 16:13:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "sw.multimedia" <sw.multimedia@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        "jack.zhu" <jack.zhu@starfivetech.com>,
        "keith.zhao" <keith.zhao@starfivetech.com>
Subject: [esmil:visionfive 47/61]
 drivers/gpu/drm/starfive/starfive_drm_crtc.c:216:13: warning: variable 'ret'
 set but not used
Message-ID: <202203091609.CXcUV5hY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   b75fcbba0e03fd9655bc4c8854422d51474664d3
commit: e9eb272297e1c4a48b53b76bf382053e5e518f37 [47/61] drm/starfive: Add StarFive drm driver
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203091609.CXcUV5hY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/e9eb272297e1c4a48b53b76bf382053e5e518f37
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout e9eb272297e1c4a48b53b76bf382053e5e518f37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/starfive/starfive_drm_crtc.c: In function 'starfive_crtc_atomic_flush':
>> drivers/gpu/drm/starfive/starfive_drm_crtc.c:216:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     216 |         int ret;
         |             ^~~
   drivers/gpu/drm/starfive/starfive_drm_crtc.c: In function 'starfive_crtc_atomic_enable':
   drivers/gpu/drm/starfive/starfive_drm_crtc.c:233:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     233 |         int ret;
         |             ^~~
   drivers/gpu/drm/starfive/starfive_drm_crtc.c: At top level:
>> drivers/gpu/drm/starfive/starfive_drm_crtc.c:284:5: warning: no previous prototype for 'starfive_crtc_create' [-Wmissing-prototypes]
     284 | int starfive_crtc_create(struct drm_device *drm_dev,
         |     ^~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/starfive/starfive_drm_vpp.c: In function 'vpp1_isr_handler':
>> drivers/gpu/drm/starfive/starfive_drm_vpp.c:598:13: warning: variable 'intr_status' set but not used [-Wunused-but-set-variable]
     598 |         u32 intr_status = 0;
         |             ^~~~~~~~~~~


vim +/ret +216 drivers/gpu/drm/starfive/starfive_drm_crtc.c

   211	
   212	static void starfive_crtc_atomic_flush(struct drm_crtc *crtc,
   213					       struct drm_atomic_state *old_crtc_state)
   214	{
   215		struct starfive_crtc *crtcp = to_starfive_crtc(crtc);
 > 216		int ret;
   217	
   218		//starfive_flush_dcache(crtcp->dma_addr, 1920*1080*2);
   219		DRM_DEBUG_DRIVER("ddr_format_change [%d], dma_addr_change [%d]\n",
   220				crtcp->ddr_format_change, crtcp->dma_addr_change);
   221		if (crtcp->ddr_format_change || crtcp->dma_addr_change) {
   222			ret = ddrfmt_to_ppfmt(crtcp);
   223			starfive_pp_update(crtcp);
   224		} else {
   225			DRM_DEBUG_DRIVER("%s with no change\n", __func__);
   226		}
   227	}
   228	
   229	static void starfive_crtc_atomic_enable(struct drm_crtc *crtc,
   230						struct drm_atomic_state *state)
   231	{
   232		struct starfive_crtc *crtcp = to_starfive_crtc(crtc);
   233		int ret;
   234	
   235	// enable crtc HW
   236	#ifdef CONFIG_DRM_STARFIVE_MIPI_DSI
   237		dsitx_vout_init(crtcp);
   238		lcdc_dsi_sel(crtcp);
   239	#else
   240		vout_reset(crtcp);
   241	#endif
   242		ret = ddrfmt_to_ppfmt(crtcp);
   243		starfive_pp_enable(crtcp);
   244		starfive_lcdc_enable(crtcp);
   245		crtcp->is_enabled = true;  // should before
   246	}
   247	
   248	static void starfive_crtc_atomic_disable(struct drm_crtc *crtc,
   249						 struct drm_atomic_state *state)
   250	{
   251		struct starfive_crtc *crtcp = to_starfive_crtc(crtc);
   252		int pp_id;
   253	
   254		for (pp_id = 0; pp_id < PP_NUM; pp_id++) {
   255			if (crtcp->pp[pp_id].inited == 1) {
   256				pp_disable_intr(crtcp, pp_id);
   257				vout_disable(crtcp); // disable crtc HW
   258			}
   259		}
   260		crtcp->is_enabled = false;
   261	}
   262	
   263	static enum drm_mode_status starfive_crtc_mode_valid(struct drm_crtc *crtc,
   264							     const struct drm_display_mode *mode)
   265	{
   266		int refresh = drm_mode_vrefresh(mode);
   267	
   268		if (refresh > 60) //lcdc miss support 60+ fps
   269			return MODE_BAD;
   270		else
   271			return MODE_OK;
   272	}
   273	
   274	static const struct drm_crtc_helper_funcs starfive_crtc_helper_funcs = {
   275		.mode_fixup = starfive_crtc_mode_fixup,
   276		.atomic_check = starfive_crtc_atomic_check,
   277		.atomic_begin = starfive_crtc_atomic_begin,
   278		.atomic_flush = starfive_crtc_atomic_flush,
   279		.atomic_enable = starfive_crtc_atomic_enable,
   280		.atomic_disable = starfive_crtc_atomic_disable,
   281		.mode_valid = starfive_crtc_mode_valid,
   282	};
   283	
 > 284	int starfive_crtc_create(struct drm_device *drm_dev,
   285				 struct starfive_crtc *starfive_crtc,
   286				 const struct drm_crtc_funcs *crtc_funcs,
   287				 const struct drm_crtc_helper_funcs *crtc_helper_funcs)
   288	{
   289		struct drm_crtc *crtc = &starfive_crtc->crtc;
   290		struct device *dev = drm_dev->dev;
   291		struct device_node *port;
   292		int ret;
   293	
   294		starfive_crtc->planes = devm_kzalloc(dev, sizeof(struct drm_plane), GFP_KERNEL);
   295		ret = starfive_plane_init(drm_dev, starfive_crtc, DRM_PLANE_TYPE_PRIMARY);
   296		if (ret) {
   297			dev_err(drm_dev->dev, "failed to construct primary plane\n");
   298			return ret;
   299		}
   300	
   301		drm_crtc_init_with_planes(drm_dev, crtc, starfive_crtc->planes, NULL,
   302				crtc_funcs, NULL);
   303		drm_crtc_helper_add(crtc, crtc_helper_funcs);
   304		port = of_get_child_by_name(starfive_crtc->dev->of_node, "port");
   305		if (!port) {
   306			DRM_ERROR("no port node found in %s\n", dev->of_node->full_name);
   307			ret = -ENOENT;
   308		}
   309	
   310		crtc->port = port;
   311		return 0;
   312	}
   313	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
