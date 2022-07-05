Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7D566145
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiGEChl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiGEChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:37:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D55F51
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656988659; x=1688524659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gRasXpWVBWOzANKB6NYcf8TprgXRXiewk8G0d3fRN24=;
  b=Lx19deFE+SpOevAqAUd1JtYmqcQi721FvqHGmC2cRri/wmXR3yM6D/bj
   DEj67JDbwD2PqLBDWEJs8v7Ku0QpYiWtMzhyhT9b9TwhyTPd+Ca/aegFw
   riCUOyJZiMrJoqAVSPovio4pWJQs1yACAWBxo5uFLscVadv2f5m0ttd6R
   2pVj7sGyuQECUZlBpMlygEvjeXw3obqSO7H4IKVrSp/LTzKnl69qEr9Oj
   +DcSD3zEBQdFv/kYcRWrRxIdqNHM/yCInr3wp+1x011w0uLYEF5uNtetS
   2usmthxPmcFN+xOPqN+yGii+1c2DIC/NgKUsLkJ7VXeWRADnEp2LpvJMD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="308771318"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="308771318"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="625282710"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2022 19:37:37 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8YRV-000IcR-54;
        Tue, 05 Jul 2022 02:37:37 +0000
Date:   Tue, 5 Jul 2022 10:37:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:for-v5.20f 14/17] kismet: WARNING: unmet direct
 dependencies detected for PHY_SUN6I_MIPI_DPHY when selected by
 VIDEO_SUN6I_MIPI_CSI2
Message-ID: <202207051037.gCATtCq9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.20f
head:   f34a9ffc3788274a3ba1365b00f27ae00fb5a940
commit: e5718aac9b18c597afe00d455c038d874ee1908e [14/17] media: sunxi: Add support for the A31 MIPI CSI-2 controller
config: (https://download.01.org/0day-ci/archive/20220705/202207051037.gCATtCq9-lkp@intel.com/config)
reproduce:
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.20f
        git checkout e5718aac9b18c597afe00d455c038d874ee1908e
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_PHY_SUN6I_MIPI_DPHY --selectors CONFIG_VIDEO_SUN6I_MIPI_CSI2 -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY when selected by VIDEO_SUN6I_MIPI_CSI2
   
   WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY
     Depends on [n]: (ARCH_SUNXI [=n] || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=n]
     Selected by [y]:
     - VIDEO_SUN6I_MIPI_CSI2 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_SUNXI [=n] || COMPILE_TEST [=y]) && PM [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
