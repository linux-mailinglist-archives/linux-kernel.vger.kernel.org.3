Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA15999A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348217AbiHSKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347904AbiHSKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:15:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE511EED0;
        Fri, 19 Aug 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660904096; x=1692440096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JamywlG2KZ6pHXhHN2aKg0RetQH+YJ6MdCpIgtBFBvc=;
  b=m5mM+U9+Uq3c3/IjZfXX9JuMdaL/HGc/TWccGSuBX9NLTFoGxVOR0iUw
   IiKR29nsLSWBi0xIarMyeTx7Ai36v7OkK9ZLah2RAiM1fD+7vrJiEEfpE
   J1OJtmG7JF/N82TPcDkNOeon8wHolEOnZClYHbAzzaGFwu92syCnip/sv
   GIXcgUly/+7Yz+u8tk+imhD4h+oUBocMyEwyJ4PAZOLA+WQq7NxdqgqUn
   HVpEbNfqoGcQYv0la+TZyQp3qNr2pRZDl/ZZOHaRCvGOpQovDPwkC9S36
   sd6qtgNsKz8XAT68oGZXcYkYJILx+EewEsS7mems8RTYu6iMUQ344nBNM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="379277734"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="379277734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 03:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="697518686"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Aug 2022 03:14:49 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOz1d-0001Kn-0l;
        Fri, 19 Aug 2022 10:14:49 +0000
Date:   Fri, 19 Aug 2022 18:14:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        nfraprado@collabora.com
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        singo.chang@mediatek.com, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v26 2/7] drm/mediatek: add ETHDR support for MT8195
Message-ID: <202208191837.iIwHfovs-lkp@intel.com>
References: <20220819061456.8042-3-nancy.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819061456.8042-3-nancy.lin@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Nancy.Lin",

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[cannot apply to robh/for-next mbgg-mediatek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nancy-Lin/Add-MediaTek-SoC-DRM-vdosys1-support-for-mt8195/20220819-142314
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220819/202208191837.iIwHfovs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ec3724f819412feab6e61118e61e574a86aa4dc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nancy-Lin/Add-MediaTek-SoC-DRM-vdosys1-support-for-mt8195/20220819-142314
        git checkout ec3724f819412feab6e61118e61e574a86aa4dc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_ethdr.c: In function 'mtk_ethdr_layer_config':
>> drivers/gpu/drm/mediatek/mtk_ethdr.c:171:9: error: implicit declaration of function 'mtk_mmsys_mixer_in_config' [-Werror=implicit-function-declaration]
     171 |         mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, alpha_con ? false : true,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/mediatek/mtk_ethdr.c: In function 'mtk_ethdr_config':
>> drivers/gpu/drm/mediatek/mtk_ethdr.c:232:9: error: implicit declaration of function 'mtk_mmsys_hdr_confing'; did you mean 'mtk_mmsys_ddp_connect'? [-Werror=implicit-function-declaration]
     232 |         mtk_mmsys_hdr_confing(priv->mmsys_dev, w / 2, h, cmdq_pkt);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         mtk_mmsys_ddp_connect
>> drivers/gpu/drm/mediatek/mtk_ethdr.c:233:9: error: implicit declaration of function 'mtk_mmsys_mixer_in_channel_swap' [-Werror=implicit-function-declaration]
     233 |         mtk_mmsys_mixer_in_channel_swap(priv->mmsys_dev, 4, 0, cmdq_pkt);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mtk_mmsys_mixer_in_config +171 drivers/gpu/drm/mediatek/mtk_ethdr.c

   146	
   147	void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
   148				    struct mtk_plane_state *state,
   149				    struct cmdq_pkt *cmdq_pkt)
   150	{
   151		struct mtk_ethdr *priv = dev_get_drvdata(dev);
   152		struct mtk_ethdr_comp *mixer = &priv->ethdr_comp[ETHDR_MIXER];
   153		struct mtk_plane_pending_state *pending = &state->pending;
   154		unsigned int offset = (pending->x & 1) << 31 | pending->y << 16 | pending->x;
   155		unsigned int align_width = ALIGN_DOWN(pending->width, 2);
   156		unsigned int alpha_con = 0;
   157	
   158		dev_dbg(dev, "%s+ idx:%d", __func__, idx);
   159	
   160		if (idx >= 4)
   161			return;
   162	
   163		if (!pending->enable) {
   164			mtk_ddp_write(cmdq_pkt, 0, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_SIZE(idx));
   165			return;
   166		}
   167	
   168		if (state->base.fb && state->base.fb->format->has_alpha)
   169			alpha_con = MIXER_ALPHA_AEN | MIXER_ALPHA;
   170	
 > 171		mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, alpha_con ? false : true,
   172					  DEFAULT_9BIT_ALPHA,
   173					  pending->x & 1 ? MIXER_INX_MODE_EVEN_EXTEND :
   174					  MIXER_INX_MODE_BYPASS, align_width / 2 - 1, cmdq_pkt);
   175	
   176		mtk_ddp_write(cmdq_pkt, pending->height << 16 | align_width, &mixer->cmdq_base,
   177			      mixer->regs, MIX_L_SRC_SIZE(idx));
   178		mtk_ddp_write(cmdq_pkt, offset, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_OFFSET(idx));
   179		mtk_ddp_write_mask(cmdq_pkt, alpha_con, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_CON(idx),
   180				   0x1ff);
   181		mtk_ddp_write_mask(cmdq_pkt, BIT(idx), &mixer->cmdq_base, mixer->regs, MIX_SRC_CON,
   182				   BIT(idx));
   183	}
   184	
   185	void mtk_ethdr_config(struct device *dev, unsigned int w,
   186			      unsigned int h, unsigned int vrefresh,
   187			      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
   188	{
   189		struct mtk_ethdr *priv = dev_get_drvdata(dev);
   190		struct mtk_ethdr_comp *vdo_fe0 = &priv->ethdr_comp[ETHDR_VDO_FE0];
   191		struct mtk_ethdr_comp *vdo_fe1 = &priv->ethdr_comp[ETHDR_VDO_FE1];
   192		struct mtk_ethdr_comp *gfx_fe0 = &priv->ethdr_comp[ETHDR_GFX_FE0];
   193		struct mtk_ethdr_comp *gfx_fe1 = &priv->ethdr_comp[ETHDR_GFX_FE1];
   194		struct mtk_ethdr_comp *vdo_be = &priv->ethdr_comp[ETHDR_VDO_BE];
   195		struct mtk_ethdr_comp *mixer = &priv->ethdr_comp[ETHDR_MIXER];
   196	
   197		dev_dbg(dev, "%s-w:%d, h:%d\n", __func__, w, h);
   198	
   199		mtk_ddp_write(cmdq_pkt, HDR_VDO_FE_0804_BYPASS_ALL, &vdo_fe0->cmdq_base,
   200			      vdo_fe0->regs, HDR_VDO_FE_0804_HDR_DM_FE);
   201	
   202		mtk_ddp_write(cmdq_pkt, HDR_VDO_FE_0804_BYPASS_ALL, &vdo_fe1->cmdq_base,
   203			      vdo_fe1->regs, HDR_VDO_FE_0804_HDR_DM_FE);
   204	
   205		mtk_ddp_write(cmdq_pkt, HDR_GFX_FE_0204_BYPASS_ALL, &gfx_fe0->cmdq_base,
   206			      gfx_fe0->regs, HDR_GFX_FE_0204_GFX_HDR_FE);
   207	
   208		mtk_ddp_write(cmdq_pkt, HDR_GFX_FE_0204_BYPASS_ALL, &gfx_fe1->cmdq_base,
   209			      gfx_fe1->regs, HDR_GFX_FE_0204_GFX_HDR_FE);
   210	
   211		mtk_ddp_write(cmdq_pkt, HDR_VDO_BE_0204_BYPASS_ALL, &vdo_be->cmdq_base,
   212			      vdo_be->regs, HDR_VDO_BE_0204_VDO_DM_BE);
   213	
   214		mtk_ddp_write(cmdq_pkt, MIX_FUNC_DCM_ENABLE, &mixer->cmdq_base, mixer->regs, MIX_FUNC_DCM0);
   215		mtk_ddp_write(cmdq_pkt, MIX_FUNC_DCM_ENABLE, &mixer->cmdq_base, mixer->regs, MIX_FUNC_DCM1);
   216		mtk_ddp_write(cmdq_pkt, h << 16 | w, &mixer->cmdq_base, mixer->regs, MIX_ROI_SIZE);
   217		mtk_ddp_write(cmdq_pkt, BGCLR_BLACK, &mixer->cmdq_base, mixer->regs, MIX_ROI_BGCLR);
   218		mtk_ddp_write(cmdq_pkt, NON_PREMULTI_SOURCE, &mixer->cmdq_base, mixer->regs,
   219			      MIX_L_SRC_CON(0));
   220		mtk_ddp_write(cmdq_pkt, NON_PREMULTI_SOURCE, &mixer->cmdq_base, mixer->regs,
   221			      MIX_L_SRC_CON(1));
   222		mtk_ddp_write(cmdq_pkt, NON_PREMULTI_SOURCE, &mixer->cmdq_base, mixer->regs,
   223			      MIX_L_SRC_CON(2));
   224		mtk_ddp_write(cmdq_pkt, NON_PREMULTI_SOURCE, &mixer->cmdq_base, mixer->regs,
   225			      MIX_L_SRC_CON(3));
   226		mtk_ddp_write(cmdq_pkt, 0x0, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_SIZE(0));
   227		mtk_ddp_write(cmdq_pkt, OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY,
   228			      &mixer->cmdq_base, mixer->regs, MIX_DATAPATH_CON);
   229		mtk_ddp_write_mask(cmdq_pkt, MIX_SRC_L0_EN, &mixer->cmdq_base, mixer->regs,
   230				   MIX_SRC_CON, MIX_SRC_L0_EN);
   231	
 > 232		mtk_mmsys_hdr_confing(priv->mmsys_dev, w / 2, h, cmdq_pkt);
 > 233		mtk_mmsys_mixer_in_channel_swap(priv->mmsys_dev, 4, 0, cmdq_pkt);
   234	}
   235	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
