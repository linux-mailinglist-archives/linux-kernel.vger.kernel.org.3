Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8964B7B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbiBOXt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:49:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiBOXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:49:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930AD5F56
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644968957; x=1676504957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W+vFMcGg7+UtOvonHfy+XKPx6Z+T9pOwy4DKfjgprDI=;
  b=DNnc/HCPC1ubs+KbtvkWqfQr5sDIS/lgAFc0ZrZAHl1xt6TMrLgWMfiN
   W9gdd/iC6asxgky2KYcAl8Xd0rafFqbj5Vb8lYWwOtskqYjZKJB50iC5Y
   zIcsqDGhMTUbR0vRHgG3kkrTnBxyRWUVJM1BjiamLZGW0XeyIPr368n/5
   PjC4sSqdq9vhoXl68BoIDMddYU/6NExJlIzt4wttxBcq2b0TDk9kaq3Gm
   Y3U/EKqD41twWAjytvO7uBWBXWS+CbEpvC+NkyKe0a0IBG9kNzrfT8NeO
   msI57uDadhOHm9LCbhR1Zdchdx4Z1f7YPYL9DYr2BNCQZcXP8AE/u08uV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="237889442"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="237889442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 15:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="497732569"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 15:49:15 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK7ZK-000A9g-QB; Tue, 15 Feb 2022 23:49:14 +0000
Date:   Wed, 16 Feb 2022 07:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [deller-fbdev:for-next 51/51]
 drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: error:
 'component_compare_dev' undeclared; did you mean 'component_master_del'?
Message-ID: <202202160743.MUYvzd9B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git for-next
head:   61038027aa13351c63b452a0d48c805bab1d2ce9
commit: 61038027aa13351c63b452a0d48c805bab1d2ce9 [51/51] video: fbdev: omapfb: Make use of the helper component_compare_dev
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202160743.MUYvzd9B-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=61038027aa13351c63b452a0d48c805bab1d2ce9
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev for-next
        git checkout 61038027aa13351c63b452a0d48c805bab1d2ce9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/video/fbdev/omap2/omapfb/dss/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/video/fbdev/omap2/omapfb/dss/dss.c: In function 'dss_add_child_component':
>> drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: error: 'component_compare_dev' undeclared (first use in this function); did you mean 'component_master_del'?
    1209 |         component_match_add(dev->parent, match, component_compare_dev, dev);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~
         |                                                 component_master_del
   drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: note: each undeclared identifier is reported only once for each function it appears in


vim +1209 drivers/video/fbdev/omap2/omapfb/dss/dss.c

  1195	
  1196	static int dss_add_child_component(struct device *dev, void *data)
  1197	{
  1198		struct component_match **match = data;
  1199	
  1200		/*
  1201		 * HACK
  1202		 * We don't have a working driver for rfbi, so skip it here always.
  1203		 * Otherwise dss will never get probed successfully, as it will wait
  1204		 * for rfbi to get probed.
  1205		 */
  1206		if (strstr(dev_name(dev), "rfbi"))
  1207			return 0;
  1208	
> 1209		component_match_add(dev->parent, match, component_compare_dev, dev);
  1210	
  1211		return 0;
  1212	}
  1213	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
