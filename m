Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA921585A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiG3L3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiG3L3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:29:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597C193F9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659180545; x=1690716545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VIIV6Is++EMkreYgqLsck7xPttucM7frNTgw2Au7VAo=;
  b=fbX+jahlhZ6kuXcs7JTMzg/N+QRQ5EV4C55zXGKE6qVcbK/J9TYiH2RN
   dgz5lsCSPJWuhPnVJPa1LciVAI7A6S32pStus1IieCuq0eAD2bO9u+W/a
   Ie+bA0bKfq7VsGJzRR6/YmfTNNF8Vifmp79HSd1R8ApxLFu2uq8tlRmHw
   6PhRAbe578zSr69XBQUvknFqbFUolmzgFrcV6Ab1NG5hCI+L1a4uwQk6B
   IPRCBMpZfBx1pzh+bPEtfFm3OyltQFnzROhmWcERcYfq+K7VU//Ti9n5b
   ucDqaJQXPiVliEZw+sv6/YPcRQjlc85kuV7P1fm3uF84jvZFPao/M74k/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289679994"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="289679994"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 04:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="577236560"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2022 04:29:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHkeU-000CmB-23;
        Sat, 30 Jul 2022 11:29:02 +0000
Date:   Sat, 30 Jul 2022 19:28:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 144/151]
 drivers/gpu/drm/msm/dp/dp_debug.c:192: undefined reference to
 `dp_panel_tpg_config'
Message-ID: <202207301916.ecD9wbRq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   70f72824f4018e98a9003c3c3107be71a1e5c88b
commit: c1bc1580b0dd297b7749f6353834295155bfbb48 [144/151] drm/msm/dp: Make it possible to enable the test pattern
config: xtensa-randconfig-m031-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301916.ecD9wbRq-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/c1bc1580b0dd297b7749f6353834295155bfbb48
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout c1bc1580b0dd297b7749f6353834295155bfbb48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_test_active_show':
>> drivers/gpu/drm/msm/dp/dp_debug.c:192: undefined reference to `dp_panel_tpg_config'
   xtensa-linux-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_test_active_write':
   drivers/gpu/drm/msm/dp/dp_debug.c:169: undefined reference to `dp_panel_tpg_config'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [y]:
   - QCOM_RPMPD [=y] && PM [=y] && QCOM_SMD_RPM [=y]


vim +192 drivers/gpu/drm/msm/dp/dp_debug.c

de3ee25473ba49 Abhinav Kumar   2020-09-12  176  
de3ee25473ba49 Abhinav Kumar   2020-09-12  177  static int dp_test_active_show(struct seq_file *m, void *data)
de3ee25473ba49 Abhinav Kumar   2020-09-12  178  {
de3ee25473ba49 Abhinav Kumar   2020-09-12  179  	struct dp_debug_private *debug = m->private;
899b2608d8d4b6 Bjorn Andersson 2021-10-15  180  	struct drm_connector *connector = debug->connector;
de3ee25473ba49 Abhinav Kumar   2020-09-12  181  
de3ee25473ba49 Abhinav Kumar   2020-09-12  182  	if (connector->status == connector_status_connected) {
de3ee25473ba49 Abhinav Kumar   2020-09-12  183  		if (debug->panel->video_test)
de3ee25473ba49 Abhinav Kumar   2020-09-12  184  			seq_puts(m, "1");
de3ee25473ba49 Abhinav Kumar   2020-09-12  185  		else
de3ee25473ba49 Abhinav Kumar   2020-09-12  186  			seq_puts(m, "0");
899b2608d8d4b6 Bjorn Andersson 2021-10-15  187  	} else {
de3ee25473ba49 Abhinav Kumar   2020-09-12  188  		seq_puts(m, "0");
de3ee25473ba49 Abhinav Kumar   2020-09-12  189  	}
de3ee25473ba49 Abhinav Kumar   2020-09-12  190  
de3ee25473ba49 Abhinav Kumar   2020-09-12  191  	return 0;
de3ee25473ba49 Abhinav Kumar   2020-09-12 @192  }
de3ee25473ba49 Abhinav Kumar   2020-09-12  193  

:::::: The code at line 192 was first introduced by commit
:::::: de3ee25473ba49f2e785e43b5db5e05cb35aad24 drm/msm/dp: add debugfs nodes for video pattern tests

:::::: TO: Abhinav Kumar <abhinavk@codeaurora.org>
:::::: CC: Rob Clark <robdclark@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
