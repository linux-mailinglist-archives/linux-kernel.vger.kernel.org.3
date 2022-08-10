Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156058F3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiHJVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHJVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:34:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FE52FFC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660167249; x=1691703249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XzwZRCK3Msht0B3mQkc/mvfGvn3IO+oJNFaL4GQwUE4=;
  b=UfaXe1pHEblchdyGAh661cJZgY73yP+kAQ6g2CR2P0FfaMXuXjGWKb5z
   q12QfAiBOz1u1pZOaMiMCdZ5CQ+iTTE4JSrYyx8o3M4kh+6sWNiwsjRbQ
   s8TzqDHdNZRGsUGHr6OaJmRIemweIqyP8Hy061DFIrj/cKMKcsFPble8L
   7eZW7p4fgoQAcNTsTwGMIJdclx8k964R6SdpCptzen19Co0GBE10pKmdb
   wKJ86zdlE/3SIKOVo6cJ7wGJ3cOyZ8V78hRT3ZDQ+c2aO1XpF30LkYGMn
   1bvBlJg0tmTecl55jPy2oYfmjnYq4iX2OT9VPV0kXiPAqdf3tLO5/suXo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="274253556"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="274253556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581401432"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2022 14:34:07 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLtL5-0000k4-0B;
        Wed, 10 Aug 2022 21:34:07 +0000
Date:   Thu, 11 Aug 2022 05:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Khelik <mkhelik@cisco.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:hdcp 4/4] drivers/media/i2c/adv7604.c:2884:38:
 warning: 'adv7604_ctrl_hdcp_auth' defined but not used
Message-ID: <202208110550.PpJJO7J3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git hdcp
head:   da521c491aa5d01b7a920ef66c8d9aef36f14a02
commit: da521c491aa5d01b7a920ef66c8d9aef36f14a02 [4/4] Added HDCP support for ADV7604
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220811/202208110550.PpJJO7J3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree hdcp
        git checkout da521c491aa5d01b7a920ef66c8d9aef36f14a02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/adv7604.c:2884:38: warning: 'adv7604_ctrl_hdcp_auth' defined but not used [-Wunused-const-variable=]
    2884 | static const struct v4l2_ctrl_config adv7604_ctrl_hdcp_auth = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~


vim +/adv7604_ctrl_hdcp_auth +2884 drivers/media/i2c/adv7604.c

  2883	
> 2884	static const struct v4l2_ctrl_config adv7604_ctrl_hdcp_auth = {
  2885		.ops = NULL,
  2886		.id = V4L2_CID_DV_HDCP_RX_AUTH,
  2887		.name = "HDCP Authentication Status",
  2888		.type = V4L2_CTRL_TYPE_BITMASK,
  2889		.min = 0,
  2890		.max = 1,
  2891		.step = 0,
  2892		.def = 0,
  2893		.flags = V4L2_CTRL_FLAG_READ_ONLY
  2894	};
  2895	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
