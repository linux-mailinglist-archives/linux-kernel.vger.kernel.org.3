Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457C475435
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbhLOIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:22:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:29856 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240783AbhLOIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639556575; x=1671092575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oR+0SggQqeogjDaEzcrbVs73HRYE9buRrrUqMyQJwDU=;
  b=RadIV3rSKraH3jzT33b36KkqRySaMhtYZHm5lwTXhVQoHTn6t3w8prrp
   /WX/173L/HQC3JGzWxTuSC36caKh7J5N+mTSkLanZ/BnzzDN2qM9hfuVL
   TSwEElbsHE5yryXS7lhI+o/5uzD5uHqEhhdpdk6KA4sjDc24fbgjBk5N5
   E1Vt6YVt6P7rZUH+oH3DkBfOH5AnsKaf+RgkgyZA/yRe1uPvWz5MTX1dD
   lMPGQMmpHecitFu9ksewlPamvw9HuZW2lst96AnNzPuaX7IxNzKYMXkOO
   18BJQUV/DcG0WhQvuw/Tc2TnA5q+12g0D730GjsmHJDqO+zsOO7qmL05V
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226035794"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226035794"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 00:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614625549"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 00:22:53 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxPYq-0001Tz-Sh; Wed, 15 Dec 2021 08:22:52 +0000
Date:   Wed, 15 Dec 2021 16:22:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: drivers/gpu/drm/rockchip/cdn-dp-core.c:54:34: warning: unused
 variable 'cdn_dp_dt_ids'
Message-ID: <202112151637.BKx0hSTS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: b4ceb4a5359ed1c9ba4a20acf3a70d4bbead3248 iommu: Tidy up Kconfig for SoC IOMMUs
date:   1 year, 5 months ago
config: x86_64-buildonly-randconfig-r004-20211215 (https://download.01.org/0day-ci/archive/20211215/202112151637.BKx0hSTS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4ceb4a5359ed1c9ba4a20acf3a70d4bbead3248
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b4ceb4a5359ed1c9ba4a20acf3a70d4bbead3248
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/rockchip/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/cdn-dp-core.c:54:34: warning: unused variable 'cdn_dp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id cdn_dp_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/cdn_dp_dt_ids +54 drivers/gpu/drm/rockchip/cdn-dp-core.c

1a0f7ed3abe29c Chris Zhong 2017-02-05  53  
1a0f7ed3abe29c Chris Zhong 2017-02-05 @54  static const struct of_device_id cdn_dp_dt_ids[] = {
1a0f7ed3abe29c Chris Zhong 2017-02-05  55  	{ .compatible = "rockchip,rk3399-cdn-dp",
1a0f7ed3abe29c Chris Zhong 2017-02-05  56  		.data = (void *)&rk3399_cdn_dp },
1a0f7ed3abe29c Chris Zhong 2017-02-05  57  	{}
1a0f7ed3abe29c Chris Zhong 2017-02-05  58  };
1a0f7ed3abe29c Chris Zhong 2017-02-05  59  

:::::: The code at line 54 was first introduced by commit
:::::: 1a0f7ed3abe29cff8e652c69a8ad89aec2c40f00 drm/rockchip: cdn-dp: add cdn DP support for rk3399

:::::: TO: Chris Zhong <zyw@rock-chips.com>
:::::: CC: Mark Yao <mark.yao@rock-chips.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
