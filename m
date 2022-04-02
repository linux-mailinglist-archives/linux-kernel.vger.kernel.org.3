Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C814F0482
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357319AbiDBPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiDBPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:43:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EB14DFDF;
        Sat,  2 Apr 2022 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648914114; x=1680450114;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XQmDJiTlLNfhWiTkfL125Khdv5hFj6Xq/8G/UCpojLw=;
  b=lcN7vQh1h3zAOLOA3+oh+PjlJavR8QU98xbOrWSttS3jdLp/ZVVRkfKn
   dGPpQ7A/MHTU6Mh9OFOP95AAXvNYfiDuhU+z4yBo1YXcKqL44aSzHs+Vr
   uGrAhlQ6BH4W1jYpbNEtilJTPozcnDs5+9sK6ZWCFsM8RSPm1uZd6/Es+
   7ppf8I3r1ik9Nf3B7sLGI3D138plmDORI9u/5wXU3rF6wBPCrgYGimDEK
   HWcz3Qp67CPQU5BAwptEJU32r8y+rrLNHWTLytceSrFLDieFs2L+hMiHC
   cWk+5KZjpR0pCffEW0oWcZSDHkTW/fvbJII3TIpzEuekjI11z/2lWh15c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="240896378"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="240896378"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 08:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="656476882"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2022 08:41:52 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nafst-0000ED-8n;
        Sat, 02 Apr 2022 15:41:51 +0000
Date:   Sat, 2 Apr 2022 23:41:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: nios2-linux-ld: imx-mipi-csis.c:undefined reference to
 `v4l2_async_nf_cleanup'
Message-ID: <202204022330.h5GGZlNk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: 9958d30f38b96fb763a10d44d18ddad39127d5f4 media: Kconfig: cleanup VIDEO_DEV dependencies
date:   2 weeks ago
config: nios2-randconfig-r033-20220401 (https://download.01.org/0day-ci/archive/20220402/202204022330.h5GGZlNk-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9958d30f38b96fb763a10d44d18ddad39127d5f4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9958d30f38b96fb763a10d44d18ddad39127d5f4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_notify_bound':
   imx-mipi-csis.c:(.text+0x374): undefined reference to `v4l2_create_fwnode_links_to_pad'
   imx-mipi-csis.c:(.text+0x374): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_create_fwnode_links_to_pad'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
   imx-mipi-csis.c:(.text+0x56c): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x570): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x5a4): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x5a8): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x60c): undefined reference to `v4l2_get_link_freq'
   imx-mipi-csis.c:(.text+0x60c): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_get_link_freq'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x6e4): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x6e8): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x788): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x78c): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_remove':
   imx-mipi-csis.c:(.text+0x874): undefined reference to `v4l2_async_nf_unregister'
   imx-mipi-csis.c:(.text+0x874): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_async_nf_unregister'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0x87c): undefined reference to `v4l2_async_nf_cleanup'
   imx-mipi-csis.c:(.text+0x87c): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_async_nf_cleanup'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0x884): undefined reference to `v4l2_async_unregister_subdev'
   imx-mipi-csis.c:(.text+0x884): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_async_unregister_subdev'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_probe':
   imx-mipi-csis.c:(.text+0xcc0): undefined reference to `v4l2_subdev_init'
   imx-mipi-csis.c:(.text+0xcc0): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_subdev_init'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0xd9c): undefined reference to `v4l2_async_nf_init'
   imx-mipi-csis.c:(.text+0xd9c): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_async_nf_init'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0xdd0): undefined reference to `v4l2_fwnode_endpoint_parse'
   imx-mipi-csis.c:(.text+0xdd0): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_fwnode_endpoint_parse'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0xe40): undefined reference to `__v4l2_async_nf_add_fwnode_remote'
   imx-mipi-csis.c:(.text+0xe40): relocation truncated to fit: R_NIOS2_CALL26 against `__v4l2_async_nf_add_fwnode_remote'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0xe70): undefined reference to `v4l2_async_subdev_nf_register'
   imx-mipi-csis.c:(.text+0xe70): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_async_subdev_nf_register'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0xe80): undefined reference to `v4l2_async_register_subdev'
   imx-mipi-csis.c:(.text+0xe80): additional relocation overflows omitted from the output
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0xf94): undefined reference to `v4l2_async_nf_unregister'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0xf9c): undefined reference to `v4l2_async_nf_cleanup'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0xfa4): undefined reference to `v4l2_async_unregister_subdev'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_set_fmt':
   imx-mipi-csis.c:(.text+0x146c): undefined reference to `v4l_bound_align_image'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x348): undefined reference to `v4l2_subdev_get_fwnode_pad_1_to_1'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x350): undefined reference to `v4l2_subdev_link_validate'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
