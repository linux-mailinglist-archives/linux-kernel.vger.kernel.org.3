Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539F8550CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiFSUXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFSUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:23:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79977B7D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655670193; x=1687206193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nB9OYzZCGLOSbqtNqa13c0xfbPhjrhu42diJidC/3/4=;
  b=ZnfJJaGciPjSTFUuXzySIENaEBnQpoaF7EJ6q1jnNz/q5+OMzZAiuMHa
   8YVfQs2UA6mHLa7EVA1l5lpFGBWnA4pCePFHMzGMBt1GqXyO4DaHRR5E3
   0wU3VMXScHwH/msbLvvNxE9orUxrS4esy8MsrROnnoV8L2D6GDGbRCmFT
   fLvlZzY/CTVfdolsL7RDnlizpV0uliy1sh9mbF+u1G+ZUu5+tVzA9+NjI
   CCLWayQ8Cu7tuOjHP28mo91XysO8a5K5EdhnpEF5+TPUA4Wk0M73BmEdc
   ofapBOIk6FvyjJlBozLtdBPQBDL+3aiiTtmoIP+/zz4zjn8iHdS8ZiOUW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268477136"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268477136"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 13:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="714383803"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2022 13:23:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o31Rt-000RX5-Px;
        Sun, 19 Jun 2022 20:23:09 +0000
Date:   Mon, 20 Jun 2022 04:22:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 98/146]
 drivers/platform/mpam/mpam_devices.c:240:17: warning: result of comparison
 of constant 18446744073709551615 with expression of type 'u32' (aka
 'unsigned int') is always false
Message-ID: <202206200439.A8h6zahb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: 6e089af1ca40d30c3002cda7363110e63baf4803 [98/146] arm_mpam: Add the class and component structures for ris firmware described
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220620/202206200439.A8h6zahb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=6e089af1ca40d30c3002cda7363110e63baf4803
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout 6e089af1ca40d30c3002cda7363110e63baf4803
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/ drivers/platform/mpam/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mpam/mpam_devices.c:240:17: warning: result of comparison of constant 18446744073709551615 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                           if (cache_id == ~0UL) {
                               ~~~~~~~~ ^  ~~~~
   drivers/platform/mpam/mpam_devices.c:404:14: warning: variable 'cache' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   } else if (of_device_is_compatible(np->parent, "cache")) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:426:14: note: uninitialized use occurs here
           of_node_put(cache);
                       ^~~~~
   drivers/platform/mpam/mpam_devices.c:404:10: note: remove the 'if' if its condition is always true
                   } else if (of_device_is_compatible(np->parent, "cache")) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:395:27: note: initialize the variable 'cache' to silence this warning
           struct device_node *cache;
                                    ^
                                     = NULL
   2 warnings generated.


vim +240 drivers/platform/mpam/mpam_devices.c

   204	
   205	/*
   206	 * The cacheinfo structures are only populated when CPUs are online.
   207	 * This helper walks the device tree to include offline CPUs too.
   208	 */
   209	static int get_cpumask_from_cache_id(u32 cache_id, u32 cache_level,
   210					     cpumask_t *affinity)
   211	{
   212		int cpu, err;
   213		u32 iter_level;
   214		int iter_cache_id;
   215		struct device_node *iter;
   216	
   217		if (!acpi_disabled)
   218			return acpi_pptt_get_cpumask_from_cache_id(cache_id, affinity);
   219	
   220		for_each_possible_cpu(cpu) {
   221			iter = of_get_cpu_node(cpu, NULL);
   222			if (!iter) {
   223				pr_err("Failed to find cpu%d device node\n", cpu);
   224				return -ENOENT;
   225			}
   226	
   227			while ((iter = of_find_next_cache_node(iter))) {
   228				err = of_property_read_u32(iter, "cache-level",
   229							   &iter_level);
   230				if (err || (iter_level != cache_level)) {
   231					of_node_put(iter);
   232					continue;
   233				}
   234	
   235				/*
   236				 * get_cpu_cacheinfo_id() isn't ready until sometime
   237				 * during device_initcall(). Use cache_of_get_id().
   238				 */
   239				iter_cache_id = cache_of_get_id(iter);
 > 240				if (cache_id == ~0UL) {
   241					of_node_put(iter);
   242					continue;
   243				}
   244	
   245				if (iter_cache_id == cache_id)
   246					cpumask_set_cpu(cpu, affinity);
   247	
   248				of_node_put(iter);
   249			}
   250		}
   251	
   252		return 0;
   253	}
   254	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
