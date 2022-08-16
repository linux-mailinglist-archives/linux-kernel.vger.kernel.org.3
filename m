Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7465952F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiHPGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiHPGtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:49:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828AE4AD48
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660615005; x=1692151005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IQGWVtZVGNHTSSRPBnh+eqzTn1r9EIxOkjywjWhv9IA=;
  b=ShSUgjYQEZV+ess+pobMR6ytvE9iL2HGizUSAPrLV54Yv/80ToFB7HHJ
   L5E5NaWsm9QJUUNXmEwBKquOUteNKzAkMRYifV1WyJ16zHu2+VB9DEbBe
   r4n5MnwIrR1zguvCZRM4UNmtJtJMyQHGjPdYUKM2mrVo7l8HMn9cpVGy8
   C8jf+p8BZUESaEEZDiED3jMn+nNKmO3i+Pt9vZZVlvr7dkkoD5VnHXq0H
   JkbYQ3mTPLP1+MKHV4It44xblxB68qQ0ljxIS+8oJLsL8Uoq+A+zzcu0S
   HLF2ASMO+t94MNCLA2Bg1FFd0vYOaS7J2X5gzPrtHyxbWB+DP3rjFM+Wd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="271872228"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="271872228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 18:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="557514555"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 18:56:43 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNlow-0001M4-1a;
        Tue, 16 Aug 2022 01:56:42 +0000
Date:   Tue, 16 Aug 2022 09:56:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 6780/7990]
 drivers/gpu/drm/msm/dp/dp_display.c:523:26: warning: variable 'hpd' set but
 not used
Message-ID: <202208160913.aFS2WTCD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   71f2154ac93f2d6cf536292c7c72b410e05c8041
commit: acf76125bb2b247d27cb4ca57fda772c8a691fe9 [6780/7990] drm/msm/dp: fix connect/disconnect handled at irq_hpd
config: arm64-buildonly-randconfig-r006-20220815 (https://download.01.org/0day-ci/archive/20220816/202208160913.aFS2WTCD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=acf76125bb2b247d27cb4ca57fda772c8a691fe9
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout acf76125bb2b247d27cb4ca57fda772c8a691fe9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/msm/dp/dp_display.c: In function 'dp_display_usbpd_attention_cb':
>> drivers/gpu/drm/msm/dp/dp_display.c:523:26: warning: variable 'hpd' set but not used [-Wunused-but-set-variable]
     523 |         struct dp_usbpd *hpd;
         |                          ^~~


vim +/hpd +523 drivers/gpu/drm/msm/dp/dp_display.c

c943b4948b5848 Chandan Uddaraju 2020-08-27  517  
c943b4948b5848 Chandan Uddaraju 2020-08-27  518  static int dp_display_usbpd_attention_cb(struct device *dev)
c943b4948b5848 Chandan Uddaraju 2020-08-27  519  {
c943b4948b5848 Chandan Uddaraju 2020-08-27  520  	int rc = 0;
61f8f4034c0423 Kuogee Hsieh     2020-11-03  521  	u32 sink_request;
c943b4948b5848 Chandan Uddaraju 2020-08-27  522  	struct dp_display_private *dp;
61f8f4034c0423 Kuogee Hsieh     2020-11-03 @523  	struct dp_usbpd *hpd;
c943b4948b5848 Chandan Uddaraju 2020-08-27  524  
c943b4948b5848 Chandan Uddaraju 2020-08-27  525  	if (!dev) {
c943b4948b5848 Chandan Uddaraju 2020-08-27  526  		DRM_ERROR("invalid dev\n");
c943b4948b5848 Chandan Uddaraju 2020-08-27  527  		return -EINVAL;
c943b4948b5848 Chandan Uddaraju 2020-08-27  528  	}
c943b4948b5848 Chandan Uddaraju 2020-08-27  529  
061eb621fc2780 Abhinav Kumar    2020-09-12  530  	dp = container_of(g_dp_display,
061eb621fc2780 Abhinav Kumar    2020-09-12  531  			struct dp_display_private, dp_display);
c943b4948b5848 Chandan Uddaraju 2020-08-27  532  	if (!dp) {
c943b4948b5848 Chandan Uddaraju 2020-08-27  533  		DRM_ERROR("no driver data found\n");
c943b4948b5848 Chandan Uddaraju 2020-08-27  534  		return -ENODEV;
c943b4948b5848 Chandan Uddaraju 2020-08-27  535  	}
c943b4948b5848 Chandan Uddaraju 2020-08-27  536  
61f8f4034c0423 Kuogee Hsieh     2020-11-03  537  	hpd = dp->usbpd;
61f8f4034c0423 Kuogee Hsieh     2020-11-03  538  
c943b4948b5848 Chandan Uddaraju 2020-08-27  539  	/* check for any test request issued by sink */
8ede2ecc3e5ee3 Kuogee Hsieh     2020-09-11  540  	rc = dp_link_process_request(dp->link);
61f8f4034c0423 Kuogee Hsieh     2020-11-03  541  	if (!rc) {
61f8f4034c0423 Kuogee Hsieh     2020-11-03  542  		sink_request = dp->link->sink_request;
acf76125bb2b24 Kuogee Hsieh     2020-11-18  543  		if (sink_request & DS_PORT_STATUS_CHANGED)
acf76125bb2b24 Kuogee Hsieh     2020-11-18  544  			rc = dp_display_handle_port_ststus_changed(dp);
acf76125bb2b24 Kuogee Hsieh     2020-11-18  545  		else
61f8f4034c0423 Kuogee Hsieh     2020-11-03  546  			rc = dp_display_handle_irq_hpd(dp);
61f8f4034c0423 Kuogee Hsieh     2020-11-03  547  	}
c943b4948b5848 Chandan Uddaraju 2020-08-27  548  
8ede2ecc3e5ee3 Kuogee Hsieh     2020-09-11  549  	return rc;
c943b4948b5848 Chandan Uddaraju 2020-08-27  550  }
c943b4948b5848 Chandan Uddaraju 2020-08-27  551  

:::::: The code at line 523 was first introduced by commit
:::::: 61f8f4034c04231148e7580ae51a2a74171c04a0 drm/msm/dp: promote irq_hpd handle to handle link training correctly

:::::: TO: Kuogee Hsieh <khsieh@codeaurora.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
