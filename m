Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50D515A28
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 05:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382149AbiD3Dd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 23:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiD3Ddy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:33:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E418E11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 20:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651289433; x=1682825433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=puGyqWDS+EPwdusoSES6Hr1WDpzg/Gjhm6GMobKQAqg=;
  b=GOigZ5tLKL/E1A13IN+UaKtjOxpAthwaBAKZzuPJrRwiUvOA8i9ZK/54
   XH1tu8g7eJEhReSyOJcUOQXkBxnBv2jfYdvEp7iLw/QCw1sMqFWUafjxq
   u/PCnQbp5onfj8RJxnt7ukJBAbBYtbA46onLuBhIdJmaRQaCEW33H8cgm
   JR7N6PyvH8DEnbPV9QUl5MF5uezmLkKBcJx1zgd6040fQm0WhVqgsaifp
   JZRv61Rlri9x2uj8f8vfsgf+DA9eIDeUixJvu7jsiVQk6tX11GRpnyWcW
   xMgvDmAcfcROme4rQH0hGbtqe71yLfiWXt5D4VzYN6xq1eXF0YDSlh8Bl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="247383311"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="247383311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 20:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="566408444"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Apr 2022 20:30:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkdoV-0006pn-Nn;
        Sat, 30 Apr 2022 03:30:31 +0000
Date:   Sat, 30 Apr 2022 11:29:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [drm-msm:msm-next-staging 29/32]
 drivers/gpu/drm/msm/dsi/dsi_host.c:918:23: warning: variable 'reg_ctrl' set
 but not used
Message-ID: <202204301130.wdmJpCAP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next-staging
head:   d2dc68276133362f021bc8d429433b5818826c81
commit: 08802f515c3cfea80b48e198de52b4fcbbef27d3 [29/32] drm/msm/dsi: Add support for DSC configuration
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220430/202204301130.wdmJpCAP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add drm-msm https://gitlab.freedesktop.org/drm/msm.git
        git fetch --no-tags drm-msm msm-next-staging
        git checkout 08802f515c3cfea80b48e198de52b4fcbbef27d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dsi/dsi_host.c:918:23: warning: variable 'reg_ctrl' set but not used [-Wunused-but-set-variable]
           u32 reg, intf_width, reg_ctrl, reg_ctrl2;
                                ^
   1 warning generated.


vim +/reg_ctrl +918 drivers/gpu/drm/msm/dsi/dsi_host.c

   914	
   915	static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode, u32 hdisplay)
   916	{
   917		struct msm_display_dsc_config *dsc = msm_host->dsc;
 > 918		u32 reg, intf_width, reg_ctrl, reg_ctrl2;
   919		u32 slice_per_intf, total_bytes_per_intf;
   920		u32 pkt_per_line;
   921		u32 bytes_in_slice;
   922		u32 eol_byte_num;
   923	
   924		/* first calculate dsc parameters and then program
   925		 * compress mode registers
   926		 */
   927		intf_width = hdisplay;
   928		slice_per_intf = DIV_ROUND_UP(intf_width, dsc->drm->slice_width);
   929	
   930		/* If slice_per_pkt is greater than slice_per_intf
   931		 * then default to 1. This can happen during partial
   932		 * update.
   933		 */
   934		if (slice_per_intf > dsc->drm->slice_count)
   935			dsc->drm->slice_count = 1;
   936	
   937		slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->drm->slice_width);
   938		bytes_in_slice = DIV_ROUND_UP(dsc->drm->slice_width * dsc->drm->bits_per_pixel, 8);
   939	
   940		dsc->drm->slice_chunk_size = bytes_in_slice;
   941	
   942		total_bytes_per_intf = bytes_in_slice * slice_per_intf;
   943	
   944		eol_byte_num = total_bytes_per_intf % 3;
   945		pkt_per_line = slice_per_intf / dsc->drm->slice_count;
   946	
   947		if (is_cmd_mode) /* packet data type */
   948			reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
   949		else
   950			reg = DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE(MIPI_DSI_COMPRESSED_PIXEL_STREAM);
   951	
   952		/* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
   953		 * registers have similar offsets, so for below common code use
   954		 * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
   955		 */
   956		reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
   957		reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
   958		reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EN;
   959	
   960		if (is_cmd_mode) {
   961			reg_ctrl = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL);
   962			reg_ctrl2 = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2);
   963	
   964			reg_ctrl |= reg;
   965			reg_ctrl2 |= DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH(bytes_in_slice);
   966	
   967			dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg);
   968			dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
   969		} else {
   970			dsi_write(msm_host, REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
   971		}
   972	}
   973	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
