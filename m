Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67224B4013
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiBNDIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:08:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiBNDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:08:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9F47AF1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644808107; x=1676344107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w3ioHYYYc2bA6RCkwSSNL72+qrbvjxnJ+T7RAA7tGv8=;
  b=E7fxzk19f8phHjIX9BMVj8uUiofSwZqY/6EnPBOf8L+4rGEulAlWCz69
   D8enDlohSBnCY+W5P7+sNqj7OLkLTRDBG65m0lTslTdzKsZ0AFlL9IK42
   MrTU13kv3A0A6bVRi0TvsmXCWKcQkRCVGABF5QFidJmzPMnY+qmvRv8h3
   S6RKl4isfQviT0HXbthGNiKkRc9+4la+FqOE4zxcSA/uRIluFFCwNg2m+
   GuVapj2+ro1tEdcGyrAsnfOjbQJOafKtX7SDBH/PcpDmjg2okYyBJBhvU
   CgD7o8b5SCOxF1NxjG5KthAtKB86jIHR+7yz+cZEsExE9eItcPj15CuAt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="229963139"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="229963139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 19:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="495050540"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Feb 2022 19:08:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJRiy-000881-9Q; Mon, 14 Feb 2022 03:08:24 +0000
Date:   Mon, 14 Feb 2022 11:07:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/gpu/drm/tegra/vic.c:326:12: error: 'vic_runtime_suspend'
 defined but not used
Message-ID: <202202141114.QJqYTOhN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: 1e15f5b911d6a1b4a5677e88527610946bd314dd drm/tegra: vic: Stop channel on suspend
date:   9 weeks ago
config: arm-randconfig-r016-20220213 (https://download.01.org/0day-ci/archive/20220214/202202141114.QJqYTOhN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e15f5b911d6a1b4a5677e88527610946bd314dd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1e15f5b911d6a1b4a5677e88527610946bd314dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/tegra/vic.c:326:12: error: 'vic_runtime_suspend' defined but not used [-Werror=unused-function]
     326 | static int vic_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tegra/vic.c:292:12: error: 'vic_runtime_resume' defined but not used [-Werror=unused-function]
     292 | static int vic_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/vic_runtime_suspend +326 drivers/gpu/drm/tegra/vic.c

77a0b09dd993c8 Thierry Reding  2019-02-01  290  
9916612311a777 Mikko Perttunen 2021-06-10  291  
9916612311a777 Mikko Perttunen 2021-06-10 @292  static int vic_runtime_resume(struct device *dev)
0ae797a8ba05a2 Arto Merilainen 2016-12-14  293  {
9916612311a777 Mikko Perttunen 2021-06-10  294  	struct vic *vic = dev_get_drvdata(dev);
0ae797a8ba05a2 Arto Merilainen 2016-12-14  295  	int err;
0ae797a8ba05a2 Arto Merilainen 2016-12-14  296  
9916612311a777 Mikko Perttunen 2021-06-10  297  	err = clk_prepare_enable(vic->clk);
0ae797a8ba05a2 Arto Merilainen 2016-12-14  298  	if (err < 0)
0ae797a8ba05a2 Arto Merilainen 2016-12-14  299  		return err;
0ae797a8ba05a2 Arto Merilainen 2016-12-14  300  
9916612311a777 Mikko Perttunen 2021-06-10  301  	usleep_range(10, 20);
9916612311a777 Mikko Perttunen 2021-06-10  302  
9916612311a777 Mikko Perttunen 2021-06-10  303  	err = reset_control_deassert(vic->rst);
9916612311a777 Mikko Perttunen 2021-06-10  304  	if (err < 0)
9916612311a777 Mikko Perttunen 2021-06-10  305  		goto disable;
9916612311a777 Mikko Perttunen 2021-06-10  306  
9916612311a777 Mikko Perttunen 2021-06-10  307  	usleep_range(10, 20);
9916612311a777 Mikko Perttunen 2021-06-10  308  
77a0b09dd993c8 Thierry Reding  2019-02-01  309  	err = vic_load_firmware(vic);
77a0b09dd993c8 Thierry Reding  2019-02-01  310  	if (err < 0)
9916612311a777 Mikko Perttunen 2021-06-10  311  		goto assert;
77a0b09dd993c8 Thierry Reding  2019-02-01  312  
0ae797a8ba05a2 Arto Merilainen 2016-12-14  313  	err = vic_boot(vic);
77a0b09dd993c8 Thierry Reding  2019-02-01  314  	if (err < 0)
9916612311a777 Mikko Perttunen 2021-06-10  315  		goto assert;
0ae797a8ba05a2 Arto Merilainen 2016-12-14  316  
9916612311a777 Mikko Perttunen 2021-06-10  317  	return 0;
9916612311a777 Mikko Perttunen 2021-06-10  318  
9916612311a777 Mikko Perttunen 2021-06-10  319  assert:
9916612311a777 Mikko Perttunen 2021-06-10  320  	reset_control_assert(vic->rst);
9916612311a777 Mikko Perttunen 2021-06-10  321  disable:
9916612311a777 Mikko Perttunen 2021-06-10  322  	clk_disable_unprepare(vic->clk);
9916612311a777 Mikko Perttunen 2021-06-10  323  	return err;
0ae797a8ba05a2 Arto Merilainen 2016-12-14  324  }
0ae797a8ba05a2 Arto Merilainen 2016-12-14  325  
9916612311a777 Mikko Perttunen 2021-06-10 @326  static int vic_runtime_suspend(struct device *dev)
9916612311a777 Mikko Perttunen 2021-06-10  327  {
9916612311a777 Mikko Perttunen 2021-06-10  328  	struct vic *vic = dev_get_drvdata(dev);
9916612311a777 Mikko Perttunen 2021-06-10  329  	int err;
9916612311a777 Mikko Perttunen 2021-06-10  330  
1e15f5b911d6a1 Dmitry Osipenko 2021-12-01  331  	host1x_channel_stop(vic->channel);
1e15f5b911d6a1 Dmitry Osipenko 2021-12-01  332  
9916612311a777 Mikko Perttunen 2021-06-10  333  	err = reset_control_assert(vic->rst);
9916612311a777 Mikko Perttunen 2021-06-10  334  	if (err < 0)
9916612311a777 Mikko Perttunen 2021-06-10  335  		return err;
9916612311a777 Mikko Perttunen 2021-06-10  336  
9916612311a777 Mikko Perttunen 2021-06-10  337  	usleep_range(2000, 4000);
9916612311a777 Mikko Perttunen 2021-06-10  338  
9916612311a777 Mikko Perttunen 2021-06-10  339  	clk_disable_unprepare(vic->clk);
9916612311a777 Mikko Perttunen 2021-06-10  340  
0ae797a8ba05a2 Arto Merilainen 2016-12-14  341  	return 0;
9916612311a777 Mikko Perttunen 2021-06-10  342  }
77a0b09dd993c8 Thierry Reding  2019-02-01  343  

:::::: The code at line 326 was first introduced by commit
:::::: 9916612311a777cdf15a53491243589ea4fcc4e7 drm/tegra: Boot VIC during runtime PM resume

:::::: TO: Mikko Perttunen <mperttunen@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
