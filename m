Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64BB4EE284
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiCaUVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiCaUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:21:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872FE151D1E;
        Thu, 31 Mar 2022 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648757959; x=1680293959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MXUSK1PVwUNaWyUiYVc58/+ip8yg9wyFZf8YT5pVNzw=;
  b=ZVMuL7JugyH3W6DRi6QIDVXBlLjzG6PGCxxNZYW/ooTWa73d73Ul202/
   yJlaUit7aSYs4q4FR6MxMlHMe1XH5Pz5pBAprKCdGQ9/O4uYJS3SlMiqu
   lw2zfm60pWS/FBkq5fdoFKTs9g2kYl9YSRTXphLaGD+XvCo0D4BoSsqoV
   e9Iub+gipXgmAf4ombir6HaweA95oLeVIVpNNZnxzUYfD/sVfDNW8XdhL
   PQghSVM9o2yCHswnS4P8X0uetQFoX2pvF7Edz2dT6OvUoantrjhWcLlPM
   NdwpQjKpqnKDpuAtGHXhY01xfUIx9g8ehiFr5kmuYSnI22jHxzid8HnZM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259659874"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259659874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 13:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="655055449"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 13:19:17 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na1GG-0000cw-L0;
        Thu, 31 Mar 2022 20:19:16 +0000
Date:   Fri, 1 Apr 2022 04:18:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: imx-mipi-csis.c:undefined reference to `v4l2_async_nf_init'
Message-ID: <202204010422.J1IKoQX0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: 63fe3d27b226fe01746bace4d1f1f2164406140d media: platform/*/Kconfig: make manufacturer menus more uniform
date:   2 weeks ago
config: arm64-randconfig-r035-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010422.J1IKoQX0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63fe3d27b226fe01746bace4d1f1f2164406140d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63fe3d27b226fe01746bace4d1f1f2164406140d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: Entry trampoline text too big
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_calculate_params':
   imx-mipi-csis.c:(.text+0x2fc): undefined reference to `v4l2_get_link_freq'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_async_register':
>> imx-mipi-csis.c:(.text+0x474): undefined reference to `v4l2_async_nf_init'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x49c): undefined reference to `v4l2_fwnode_endpoint_parse'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x548): undefined reference to `__v4l2_async_nf_add_fwnode_remote'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x57c): undefined reference to `v4l2_async_subdev_nf_register'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x58c): undefined reference to `v4l2_async_register_subdev'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_notify_bound':
   imx-mipi-csis.c:(.text+0x5f8): undefined reference to `v4l2_create_fwnode_links_to_pad'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_probe':
   imx-mipi-csis.c:(.text+0x10fc): undefined reference to `v4l2_subdev_init'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x11bc): undefined reference to `v4l2_async_nf_unregister'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x11c4): undefined reference to `v4l2_async_nf_cleanup'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x11cc): undefined reference to `v4l2_async_unregister_subdev'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_set_fmt':
   imx-mipi-csis.c:(.text+0x13c8): undefined reference to `v4l_bound_align_image'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
>> imx-mipi-csis.c:(.text+0x154c): undefined reference to `v4l2_subdev_call_wrappers'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `v4l2_subdev_call_wrappers' which may bind externally can not be used when making a shared object; recompile with -fPIC
   imx-mipi-csis.c:(.text+0x154c): dangerous relocation: unsupported relocation
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1550): undefined reference to `v4l2_subdev_call_wrappers'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x16b4): undefined reference to `v4l2_subdev_call_wrappers'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `v4l2_subdev_call_wrappers' which may bind externally can not be used when making a shared object; recompile with -fPIC
   imx-mipi-csis.c:(.text+0x16b4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x16b8): undefined reference to `v4l2_subdev_call_wrappers'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1760): undefined reference to `v4l2_subdev_call_wrappers'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `v4l2_subdev_call_wrappers' which may bind externally can not be used when making a shared object; recompile with -fPIC
   imx-mipi-csis.c:(.text+0x1760): dangerous relocation: unsupported relocation
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:imx-mipi-csis.c:(.text+0x1764): more undefined references to `v4l2_subdev_call_wrappers' follow
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `v4l2_subdev_call_wrappers' which may bind externally can not be used when making a shared object; recompile with -fPIC
   drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
   imx-mipi-csis.c:(.text+0x17c4): dangerous relocation: unsupported relocation
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_remove':
   imx-mipi-csis.c:(.text+0x1904): undefined reference to `v4l2_async_nf_unregister'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x190c): undefined reference to `v4l2_async_nf_cleanup'
   aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1914): undefined reference to `v4l2_async_unregister_subdev'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x4c0): undefined reference to `v4l2_subdev_link_validate'
   aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x4c8): undefined reference to `v4l2_subdev_get_fwnode_pad_1_to_1'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
