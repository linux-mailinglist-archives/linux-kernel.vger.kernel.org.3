Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B597F4F015B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiDBMJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbiDBMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:09:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC116F046;
        Sat,  2 Apr 2022 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648901270; x=1680437270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bJbkV0yP0o7Uzyp7JV7V0B8dWDAEl1KQjkKRLWU0B4M=;
  b=gNxam4lSe0s9ZKGhaU+5qibx3VHfiiwo+6Yd7LPjLdFnlPmNjQOTdU/Z
   pVJY5o52rcxbLR159msvb9yGzfSropBxRY9/ZEnbnnqnnk3t2We5Rg5Vl
   xasH+Xn4rjXmoO9BgOM+ek6kVFEl64LSA/SVZLBXM35DR/YzqhRwwrvT5
   RzRA2pBoAFlvVY51cEU3QmFhEOaLWSS5deb4o3UHM2V+BwWisNtRLyyuI
   HeabIapZ1vyuHogVNum51ejpXWFLYpn+ko56P/3C+OUJWuhYh47G4mbma
   Zfs9KTgB3CnGCy1OWQHbMGWm4Q/QUqI5XvBtYVchevTQxjHGyPM+M7a5f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259125935"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="259125935"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 05:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="656375369"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2022 05:07:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nacXj-00007N-Re;
        Sat, 02 Apr 2022 12:07:47 +0000
Date:   Sat, 2 Apr 2022 20:07:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: undefined reference to `v4l2_device_unregister_subdev'
Message-ID: <202204021912.687fL7yR-lkp@intel.com>
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
commit: 63fe3d27b226fe01746bace4d1f1f2164406140d media: platform/*/Kconfig: make manufacturer menus more uniform
date:   2 weeks ago
config: nios2-randconfig-r033-20220401 (https://download.01.org/0day-ci/archive/20220402/202204021912.687fL7yR-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63fe3d27b226fe01746bace4d1f1f2164406140d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63fe3d27b226fe01746bace4d1f1f2164406140d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/media/v4l2-core/v4l2-async.o: in function `match_i2c':
   v4l2-async.c:(.text+0x2c0): undefined reference to `i2c_verify_client'
   v4l2-async.c:(.text+0x2c0): relocation truncated to fit: R_NIOS2_CALL26 against `i2c_verify_client'
   nios2-linux-ld: drivers/media/v4l2-core/v4l2-async.o: in function `v4l2_async_nf_unbind_all_subdevs':
   v4l2-async.c:(.text+0xc00): undefined reference to `v4l2_device_unregister_subdev'
   v4l2-async.c:(.text+0xc00): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_device_unregister_subdev'
   nios2-linux-ld: drivers/media/v4l2-core/v4l2-async.o: in function `v4l2_async_match_notify':
   v4l2-async.c:(.text+0xdb4): undefined reference to `v4l2_device_register_subdev'
   v4l2-async.c:(.text+0xdb4): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_device_register_subdev'
   nios2-linux-ld: v4l2-async.c:(.text+0xee8): undefined reference to `v4l2_device_unregister_subdev'
   v4l2-async.c:(.text+0xee8): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_device_unregister_subdev'
   nios2-linux-ld: drivers/media/v4l2-core/v4l2-async.o: in function `v4l2_async_register_subdev':
>> (.text+0x1160): undefined reference to `v4l2_device_unregister_subdev'
   (.text+0x1160): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_device_unregister_subdev'
   nios2-linux-ld: drivers/media/v4l2-core/v4l2-async.o: in function `v4l2_async_unregister_subdev':
   (.text+0x1570): undefined reference to `v4l2_device_unregister_subdev'
   (.text+0x1570): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_device_unregister_subdev'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_notify_bound':
   imx-mipi-csis.c:(.text+0x374): undefined reference to `v4l2_create_fwnode_links_to_pad'
   imx-mipi-csis.c:(.text+0x374): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_create_fwnode_links_to_pad'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
   imx-mipi-csis.c:(.text+0x56c): undefined reference to `v4l2_subdev_call_wrappers'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0x570): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x5a4): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x5a8): undefined reference to `v4l2_subdev_call_wrappers'
>> nios2-linux-ld: imx-mipi-csis.c:(.text+0x60c): undefined reference to `v4l2_get_link_freq'
   imx-mipi-csis.c:(.text+0x60c): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_get_link_freq'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x6e4): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x6e8): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x788): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: imx-mipi-csis.c:(.text+0x78c): undefined reference to `v4l2_subdev_call_wrappers'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_probe':
   imx-mipi-csis.c:(.text+0xcc0): undefined reference to `v4l2_subdev_init'
   imx-mipi-csis.c:(.text+0xcc0): relocation truncated to fit: R_NIOS2_CALL26 against `v4l2_subdev_init'
   nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_set_fmt':
   imx-mipi-csis.c:(.text+0x146c): undefined reference to `v4l_bound_align_image'
   imx-mipi-csis.c:(.text+0x146c): relocation truncated to fit: R_NIOS2_CALL26 against `v4l_bound_align_image'
>> nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x348): undefined reference to `v4l2_subdev_get_fwnode_pad_1_to_1'
>> nios2-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x350): undefined reference to `v4l2_subdev_link_validate'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
