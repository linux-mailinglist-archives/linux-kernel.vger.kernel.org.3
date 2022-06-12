Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37B547A65
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiFLNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFLNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:40:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014784AE03
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655041210; x=1686577210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UGM/ADNUwmGyFflTyjWzM7h6423qH4hEnlmOb9hXOPk=;
  b=nwcrEzrDDtp6pbXJACNQKHCiy4hjScbTEQ9AShWfPcdbyopCL8EhXDrm
   8DMXJtqWaWmaAd6ciPfttGvqiXTejakWRgasfOrcc4M9YNtKcmOs8Uh4S
   eaNb+YT9fxXhQhvVg2k7v2SeXPJBy/W1mx7eOIc2zifj+2AjxwhgdVfXe
   mYY89MwkktwH4jYmSuTerCV2PVUN27+fjC1HG6Qjnwp6FBx4KNGzt0lL6
   JbiY0MUcg6pntJpt0WyIK5GwCXOsOLN4qqElWfL65VRzQyL7vOrB474Ej
   HwH4tRhEjcYn5uLzic+0gSZOtAVSQf+cpv1t512Gt23i0oOVq6yye6gYe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258486303"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="258486303"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 06:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="639188705"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2022 06:40:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0Np2-000Jwv-4h;
        Sun, 12 Jun 2022 13:40:08 +0000
Date:   Sun, 12 Jun 2022 21:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [drm-misc:for-linux-next 9/10]
 drivers/gpu/drm/msm/dp/dp_parser.c:110:5: error: use of undeclared
 identifier 'data_lane_property'
Message-ID: <202206122125.gkajULO7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   d643daaf1694b7565fbe3982b630e1c7b95f1600
commit: 185443efa26a62b7d1401c89b83c89a1a2601350 [9/10] drm/msm: Convert to drm_of_get_data_lanes_count
config: hexagon-randconfig-r045-20220612 (https://download.01.org/0day-ci/archive/20220612/202206122125.gkajULO7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout 185443efa26a62b7d1401c89b83c89a1a2601350
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_parser.c:110:5: error: use of undeclared identifier 'data_lane_property'
                                   data_lane_property, DP_MAX_NUM_DP_LANES);
                                   ^
   1 error generated.
--
>> drivers/gpu/drm/msm/dsi/dsi_host.c:1676:14: error: call to undeclared function 'drm_of_get_data_lanes_count'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           num_lanes = drm_of_get_data_lanes_count(ep, 1, 4);
                       ^
   1 error generated.


vim +/data_lane_property +110 drivers/gpu/drm/msm/dp/dp_parser.c

c943b4948b5848 Chandan Uddaraju 2020-08-27  101  
c943b4948b5848 Chandan Uddaraju 2020-08-27  102  static int dp_parser_misc(struct dp_parser *parser)
c943b4948b5848 Chandan Uddaraju 2020-08-27  103  {
c943b4948b5848 Chandan Uddaraju 2020-08-27  104  	struct device_node *of_node = parser->pdev->dev.of_node;
185443efa26a62 Marek Vasut      2022-05-24  105  	int len;
c943b4948b5848 Chandan Uddaraju 2020-08-27  106  
185443efa26a62 Marek Vasut      2022-05-24  107  	len = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
c943b4948b5848 Chandan Uddaraju 2020-08-27  108  	if (len < 0) {
c943b4948b5848 Chandan Uddaraju 2020-08-27  109  		DRM_WARN("Invalid property %s, default max DP lanes = %d\n",
c943b4948b5848 Chandan Uddaraju 2020-08-27 @110  				data_lane_property, DP_MAX_NUM_DP_LANES);
c943b4948b5848 Chandan Uddaraju 2020-08-27  111  		len = DP_MAX_NUM_DP_LANES;
c943b4948b5848 Chandan Uddaraju 2020-08-27  112  	}
c943b4948b5848 Chandan Uddaraju 2020-08-27  113  
c943b4948b5848 Chandan Uddaraju 2020-08-27  114  	parser->max_dp_lanes = len;
c943b4948b5848 Chandan Uddaraju 2020-08-27  115  	return 0;
c943b4948b5848 Chandan Uddaraju 2020-08-27  116  }
c943b4948b5848 Chandan Uddaraju 2020-08-27  117  

:::::: The code at line 110 was first introduced by commit
:::::: c943b4948b5848fc0e07f875edbd35a973879e22 drm/msm/dp: add displayPort driver support

:::::: TO: Chandan Uddaraju <chandanu@codeaurora.org>
:::::: CC: Rob Clark <robdclark@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
