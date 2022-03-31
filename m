Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C524EE3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiCaWXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbiCaWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:23:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8B247C0D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648765290; x=1680301290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BH6v5PDmqnU4cjORhSnUKlSmZa5zoid+g3+x1UD7jhY=;
  b=eeMZdP2g3nudJFRrNu5X4Hmz3GItMrE38RjyUoIM57TwJsrbppapQZuP
   +UArF7x5V/8KUdwLRAyuRVz63ekyfsKL4pIx5d/zhRMPLzEUKGeg3rAzo
   44JIG9y9Vj31aUpmdu1jpf4TyuYHjE62vObTZl0RGV/P0LIKK1QbvXNe3
   uT165YAblOiMQiNQlg2MRmGdcdZ9xdgGAqVibzJTX8BgU+Drhsc+LlCLl
   5mlT0VVn90XwWwB5CFwC/DMFF8ZHLb9sLYMprzO8TWxpewTzc2ZgV/zWU
   WaziW178IVvT63tDVdr2o7ks/vNZrz66a+ODEDcZHUWb+QZ8gdR1j7OpH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="247477659"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="247477659"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 15:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="695662058"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2022 15:21:28 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na3AV-0000hW-PQ;
        Thu, 31 Mar 2022 22:21:27 +0000
Date:   Fri, 1 Apr 2022 06:20:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     yipechai <YiPeng.Chai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c:27:6: warning: no previous
 prototype for 'amdgpu_hdp_ras_fini'
Message-ID: <202204010647.p5YPbVds-lkp@intel.com>
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

Hi yipechai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e729dbe8ea1c6145ae7b9efd6a00a5613746d3b0
commit: aa8e65dfc75f684cd46d49f71453ea3512a1e770 drm/amdgpu: Remove redundant calls of amdgpu_ras_block_late_fini in hdp ras block
date:   4 weeks ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220401/202204010647.p5YPbVds-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa8e65dfc75f684cd46d49f71453ea3512a1e770
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aa8e65dfc75f684cd46d49f71453ea3512a1e770
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c:27:6: warning: no previous prototype for 'amdgpu_hdp_ras_fini' [-Wmissing-prototypes]
      27 | void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/amdgpu_hdp_ras_fini +27 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c

b11625f56f09f1 Hawking Zhang 2021-04-28  26  
01d468d9a42015 yipechai      2022-02-17 @27  void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
b11625f56f09f1 Hawking Zhang 2021-04-28  28  {
aa8e65dfc75f68 yipechai      2022-02-17  29  

:::::: The code at line 27 was first introduced by commit
:::::: 01d468d9a420152e4a1270992e69a37ea0c98e04 drm/amdgpu: Modify .ras_fini function pointer parameter

:::::: TO: yipechai <YiPeng.Chai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
