Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1355B469
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiFZWo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFZWo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:44:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7862BCA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656283494; x=1687819494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ldNtxryiGQA157R36YiyLpP+MEeDc4uJSIYeTMYoMY=;
  b=aQ2CtKBmCxsR+xUVxUM1W6/2HZH7YMwu1jOEQKvkb3mUW9VWtHQAPbsu
   cbb9+ef14BnpZzw5/Vs2337o378eVSNHKED7zwm97Dxa8wzMzh+L1BoUO
   PYBDQWiK6lTKFWgToaX6HyFBtk/xSMSey4G1c9n6QZQiOxycLSisAMFR7
   Rt5JI9du1qwg3Ou/zYH258fvwUKqdd78koscIBTT/GB6qiLT13juxInmC
   LiakjT9KwyvwSIlHyRhqqVIaxmsYu/31yxhd5aC4vQZZflWoB7tkpDHsb
   FgOk9f1H3vUqs/NQ1sE5Se5Ah05mgIG6FYkWwFNCmwKncaeVKHepgKccT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="281359590"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="281359590"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 15:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="589697177"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2022 15:44:52 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5azr-0007up-CL;
        Sun, 26 Jun 2022 22:44:51 +0000
Date:   Mon, 27 Jun 2022 06:44:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, airlied@linux.ie,
        vgannava@xilinx.com,
        Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] drm: xlnx: dsi: Add Xilinx MIPI DSI-Tx subsystem
 driver
Message-ID: <202206270612.vJbBPJ9r-lkp@intel.com>
References: <1655389056-37044-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655389056-37044-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkateshwar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Venkateshwar-Rao-Gannavarapu/Add-Xilinx-DSI-Tx-subsystem-DRM-driver/20220616-222008
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: mips-randconfig-c004-20220626
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/28aa62ffdc1901029bf75961166f4ebba948b9b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Venkateshwar-Rao-Gannavarapu/Add-Xilinx-DSI-Tx-subsystem-DRM-driver/20220616-222008
        git checkout 28aa62ffdc1901029bf75961166f4ebba948b9b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xlnx/xlnx_dsi.c:255:10: error: label at end of compound statement: expected statement
           default: /* define */
                   ^
                    ;
   1 error generated.


vim +255 drivers/gpu/drm/xlnx/xlnx_dsi.c

   227	
   228	#define MAX_INPUT_SEL_FORMATS   3
   229	static u32
   230	*xlnx_dsi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
   231						   struct drm_bridge_state *bridge_state,
   232						   struct drm_crtc_state *crtc_state,
   233						   struct drm_connector_state *conn_state,
   234						   u32 output_fmt,
   235						   unsigned int *num_input_fmts)
   236	{
   237		u32 *input_fmts;
   238		unsigned int i = 0;
   239	
   240		*num_input_fmts = 0;
   241		input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts), GFP_KERNEL);
   242		if (!input_fmts)
   243			return NULL;
   244	
   245		switch (output_fmt) {
   246		case MEDIA_BUS_FMT_FIXED:
   247			input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
   248			break;
   249		case MEDIA_BUS_FMT_RGB666_1X18:
   250			input_fmts[i++] = MEDIA_BUS_FMT_RGB666_1X18;
   251			break;
   252		case MEDIA_BUS_FMT_RGB565_1X16:
   253			input_fmts[i++] = MEDIA_BUS_FMT_RGB565_1X16;
   254			break;
 > 255		default: /* define */
   256		}
   257	
   258		*num_input_fmts = i;
   259		if (*num_input_fmts == 0) {
   260			kfree(input_fmts);
   261			input_fmts = NULL;
   262		}
   263	
   264		return input_fmts;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
