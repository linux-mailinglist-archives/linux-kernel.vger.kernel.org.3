Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9151A550C97
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiFSSnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiFSSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:43:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF29FC2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655664190; x=1687200190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bJ9DQNoxuiGc4MSaXCZIH9Pcmy8Rno+hSDAD0GsBYfg=;
  b=MEBVsixMwo4IcbW86mML9EAt2iQEHwzbSg+HZ9n8sZjWpxXQZ1oTzFc0
   s0rRpZXN4hn3dGDQcUfy8UxJSnyCpW9Qu4WyU8vfCxlNw1+WQ9OXdnwP0
   8MFA1p15pU4dHQF68C1QKLNYeKCk57JgCRCIAnrMsqAEO+A/R5x4yWhqR
   YYyjmBwuZ/iHCPnf9zChMqf54xh3XLy0MIrKtIrtSqxAamC2o5Qfx/4Nv
   BoQ+XO5qqK8aic6Rcf6FqrYtuP4FdLuUgact0GIC+pqbAy0X3LRpaCAsz
   pWK5Mn4wZlERMgbSJlGuotmb89jK76W33lhSUlZSlYsDWANG8USHw7LI/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279803503"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279803503"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 11:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="561679708"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2022 11:43:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2zt5-000RU9-T3;
        Sun, 19 Jun 2022 18:43:07 +0000
Date:   Mon, 20 Jun 2022 02:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 97/146]
 drivers/platform/mpam/mpam_devices.c:71:14: warning: variable 'cache' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202206200258.OlfMsjF6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: 49e55977a0ed88794b6abe4c959e3e28ccd54913 [97/146] arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220620/202206200258.OlfMsjF6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=49e55977a0ed88794b6abe4c959e3e28ccd54913
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout 49e55977a0ed88794b6abe4c959e3e28ccd54913
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/ drivers/platform/mpam/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mpam/mpam_devices.c:71:14: warning: variable 'cache' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   } else if (of_device_is_compatible(np->parent, "cache")) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:93:14: note: uninitialized use occurs here
           of_node_put(cache);
                       ^~~~~
   drivers/platform/mpam/mpam_devices.c:71:10: note: remove the 'if' if its condition is always true
                   } else if (of_device_is_compatible(np->parent, "cache")) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:62:27: note: initialize the variable 'cache' to silence this warning
           struct device_node *cache;
                                    ^
                                     = NULL
   1 warning generated.


vim +71 drivers/platform/mpam/mpam_devices.c

    55	
    56	static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
    57					  u32 ris_idx)
    58	{
    59		int err = 0;
    60		u32 level = 0;
    61		unsigned long cache_id;
    62		struct device_node *cache;
    63	
    64		do {
    65			if (of_device_is_compatible(np, "arm,mpam-cache")) {
    66				cache = of_parse_phandle(np, "arm,mpam-device", 0);
    67				if (!cache) {
    68					pr_err("Failed to read phandle\n");
    69					break;
    70				}
  > 71			} else if (of_device_is_compatible(np->parent, "cache")) {
    72				cache = np->parent;
    73			} else {
    74				pr_err("Not a cache\n");
    75				break;
    76			}
    77	
    78			err = of_property_read_u32(cache, "cache-level", &level);
    79			if (err) {
    80				pr_err("Failed to read cache-level\n");
    81				break;
    82			}
    83	
    84			cache_id = cache_of_get_id(cache);
    85			if (cache_id == ~0UL) {
    86				err = -ENOENT;
    87				break;
    88			}
    89	
    90			err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
    91					      cache_id);
    92		} while (0);
    93		of_node_put(cache);
    94	
    95		return err;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
