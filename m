Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC74F010A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354644AbiDBL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiDBL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:28:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9F1A6E56;
        Sat,  2 Apr 2022 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648898809; x=1680434809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BRnv69DO2+dbPWklauQlsMw88d2pUSSJu9MmnqEjmKc=;
  b=MlYQx2yCu1YYJVUst9JExZv/iLuYcvY6001a3vC6MMelCugGhuBDIlD4
   /dVjqvuQweRzmkY6Acp+U/t/Cm3jTfpKO/0ReDgcd5b6+vgb+BBO3PWaH
   KzV2/TUILeak3cCiETVMPzBTuKyylWYDhNLSJz2sj4c0dL3cnkQBY6Inw
   EnmWFSgp6pa78gntLDK4E8R+kq9OYTrNOJiK5GcWbHIyhwWGc1UFBg3uD
   PCjnxFxls3f5uCfgpOzv+Uc0bevxXmCWdpcH4Sd+giWtW98NVh8cdC453
   oXwc1igxh4+mqtEoNEAaZHRmYklGUs8c1E4vSpw/qJJ+ITZofamrwGsBI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="242438433"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="242438433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 04:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="568187259"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2022 04:26:47 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nabu2-000057-CL;
        Sat, 02 Apr 2022 11:26:46 +0000
Date:   Sat, 2 Apr 2022 19:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:undefined
 reference to `v4l2_subdev_link_validate'
Message-ID: <202204021936.aWjDwNSD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: 63fe3d27b226fe01746bace4d1f1f2164406140d media: platform/*/Kconfig: make manufacturer menus more uniform
date:   2 weeks ago
config: csky-randconfig-r006-20220401 (https://download.01.org/0day-ci/archive/20220402/202204021936.aWjDwNSD-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63fe3d27b226fe01746bace4d1f1f2164406140d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63fe3d27b226fe01746bace4d1f1f2164406140d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_calculate_params':
   imx-mipi-csis.c:(.text+0x4fe): undefined reference to `v4l2_get_link_freq'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x648): undefined reference to `v4l2_get_link_freq'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_async_register':
   imx-mipi-csis.c:(.text+0x750): undefined reference to `v4l2_async_nf_init'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x78c): undefined reference to `v4l2_fwnode_endpoint_parse'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x88e): undefined reference to `__v4l2_async_nf_add_fwnode_remote'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x8b8): undefined reference to `v4l2_async_nf_init'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x8c8): undefined reference to `v4l2_fwnode_endpoint_parse'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x900): undefined reference to `__v4l2_async_nf_add_fwnode_remote'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x928): undefined reference to `v4l2_async_subdev_nf_register'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x948): undefined reference to `v4l2_async_register_subdev'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_notify_bound':
   imx-mipi-csis.c:(.text+0x97c): undefined reference to `v4l2_create_fwnode_links_to_pad'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_dump_regs_open':
   imx-mipi-csis.c:(.text+0x9b0): undefined reference to `v4l2_async_subdev_nf_register'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x9b4): undefined reference to `v4l2_async_register_subdev'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x9bc): undefined reference to `v4l2_create_fwnode_links_to_pad'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_set_fmt':
   imx-mipi-csis.c:(.text+0xf80): undefined reference to `v4l_bound_align_image'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_enum_mbus_code':
   imx-mipi-csis.c:(.text+0x10c4): undefined reference to `v4l_bound_align_image'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_probe':
   imx-mipi-csis.c:(.text+0x1484): undefined reference to `v4l2_subdev_init'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x154c): undefined reference to `v4l2_subdev_init'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x166c): undefined reference to `v4l2_async_nf_unregister'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1676): undefined reference to `v4l2_async_nf_cleanup'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1680): undefined reference to `v4l2_async_unregister_subdev'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_stop_stream':
   imx-mipi-csis.c:(.text+0x1720): undefined reference to `v4l2_async_nf_unregister'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1724): undefined reference to `v4l2_async_nf_cleanup'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1728): undefined reference to `v4l2_async_unregister_subdev'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
   imx-mipi-csis.c:(.text+0x18b4): undefined reference to `v4l2_subdev_call_wrappers'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x19f8): undefined reference to `v4l2_subdev_call_wrappers'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_remove':
   imx-mipi-csis.c:(.text+0x1b14): undefined reference to `v4l2_async_nf_unregister'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1b1e): undefined reference to `v4l2_async_nf_cleanup'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1b28): undefined reference to `v4l2_async_unregister_subdev'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1b7c): undefined reference to `v4l2_subdev_call_wrappers'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1b9c): undefined reference to `v4l2_async_nf_unregister'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1ba0): undefined reference to `v4l2_async_nf_cleanup'
   csky-linux-ld: imx-mipi-csis.c:(.text+0x1ba4): undefined reference to `v4l2_async_unregister_subdev'
   csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x36c): undefined reference to `v4l2_subdev_get_fwnode_pad_1_to_1'
>> csky-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x374): undefined reference to `v4l2_subdev_link_validate'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
   Depends on MEDIA_SUPPORT && VIDEO_DEV && MEDIA_CONTROLLER
   Selected by
   - VIDEO_IMX_MIPI_CSIS && MEDIA_SUPPORT && MEDIA_PLATFORM_SUPPORT && MEDIA_PLATFORM_DRIVERS

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
