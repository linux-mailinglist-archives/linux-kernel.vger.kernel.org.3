Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE824DEA47
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbiCSTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbiCSTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:04:54 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EC654E;
        Sat, 19 Mar 2022 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647716612; x=1679252612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tOqUZS4zdTzAGKYeAPBuYgTsO4Osp75ylkvGd4dJtlg=;
  b=gzMIJjFccs3mdnnD0PatTT5L32bXhLYuKd2FwE4DZG/MgxDxXu8ynvJk
   PP6INILroQzOREYd92vi+69ToFWH0b6+V9/MbZzM76PNg67xwlGkKeaj1
   quflG7pWWO4hMwTHO7MhEbvQ/s3RggKUEeIZj7Gwz2UY9vUBLyIPDuI32
   FtGJMCG2a/x6z4+5f5tUINqodzW2TIGkkjhSaC8PKtEkfU8iLSF1ZVRV1
   MgheL+b5S1oSJylHLgPtunc3RmwMt+cWkwL1GePXyyJP3HJAQWB0bj6sq
   o91NKYpGkiSisZmSN54k+qSfKc7JtKN/guxoa82+BbFSZoHNo7jFNM+nO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="318029950"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="318029950"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="542607866"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2022 12:03:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVeMK-000GDt-7R; Sat, 19 Mar 2022 19:03:28 +0000
Date:   Sun, 20 Mar 2022 03:03:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [mchehab-media-next:master 314/331] ERROR: modpost:
 "v4l2_create_fwnode_links_to_pad"
 [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
Message-ID: <202203200251.h5kOoPdZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/mchehab/media-next.git master
head:   47aa866f248c89b319b99ac7b21a0a961ed2264a
commit: 63fe3d27b226fe01746bace4d1f1f2164406140d [314/331] media: platform/*/Kconfig: make manufacturer menus more uniform
config: arm-randconfig-r026-20220320 (https://download.01.org/0day-ci/archive/20220320/202203200251.h5kOoPdZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add mchehab-media-next git://linuxtv.org/mchehab/media-next.git
        git fetch --no-tags mchehab-media-next master
        git checkout 63fe3d27b226fe01746bace4d1f1f2164406140d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "v4l2_subdev_link_validate" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_subdev_get_fwnode_pad_1_to_1" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_subdev_init" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_async_unregister_subdev" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_async_nf_cleanup" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_async_nf_unregister" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l_bound_align_image" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_subdev_call_wrappers" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
ERROR: modpost: "v4l2_get_link_freq" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
>> ERROR: modpost: "v4l2_create_fwnode_links_to_pad" [drivers/media/platform/nxp/imx-mipi-csis.ko] undefined!
WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
   Depends on MEDIA_SUPPORT && VIDEO_DEV && MEDIA_CONTROLLER
   Selected by
   - VIDEO_IMX_MIPI_CSIS && MEDIA_SUPPORT && MEDIA_PLATFORM_SUPPORT && MEDIA_PLATFORM_DRIVERS

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
