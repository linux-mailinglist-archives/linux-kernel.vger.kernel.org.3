Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104B5AC145
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiICUBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:01:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CEB5464B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662235266; x=1693771266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QCNt9tPUCtvhDMkrf/gPorUSVH7r0IizXYpggqk9B6w=;
  b=L/VxD58OBIX+QTHtyDTrKdyXWdZFGQTMPyHIOEXhI89xtcMYF5SC3mYq
   nTE6npf8P+jhxZ8UeIJDj8QhXDdVDwRRWXLUucQAiN1QTwZjPzR7zqllG
   NpuO6y8ClPfnP+O+OZj2d/xjf/f49NjS5S5xUTkEiPDIvybKEWilQ0mS7
   HRQpHSdBveUaQJkzIUbEP2b2/s9TSxBlYUz4Tu2HG10wzctqRE0jCu/hu
   0SVZ5NBUkjIonB1CI2adYeYImu64PPi6v4mFGY2oqZPDmZF0AZUlyCBv8
   OdIXNGMHLMP7n1hYqGGN33gGvfIFldp/sIqjjen/Nq0WJe7LIu+b5MrD8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="294923950"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="294923950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 13:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="643327928"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 13:01:04 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUZKC-00028g-0S;
        Sat, 03 Sep 2022 20:01:04 +0000
Date:   Sun, 4 Sep 2022 04:00:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thierryreding:for-5.21/work 120/125]
 drivers/cpufreq/cppc_cpufreq.c:625:32: error: 'cppc_get_cpu_power'
 undeclared
Message-ID: <202209040311.MTIju8YW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.21/work
head:   52ddba5b7001206107d4587c706be62369d71240
commit: 80a1856c0cbc57c7ecee8571cd34b76b5542bbd1 [120/125] WIP
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209040311.MTIju8YW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/thierryreding/linux/commit/80a1856c0cbc57c7ecee8571cd34b76b5542bbd1
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.21/work
        git checkout 80a1856c0cbc57c7ecee8571cd34b76b5542bbd1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from drivers/cpufreq/cppc_cpufreq.c:17:
   drivers/cpufreq/cppc_cpufreq.c: In function 'cppc_cpufreq_register_em':
>> drivers/cpufreq/cppc_cpufreq.c:625:32: error: 'cppc_get_cpu_power' undeclared (first use in this function)
     625 |                 EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
         |                                ^~~~~~~~~~~~~~~~~~
   include/linux/energy_model.h:164:27: note: in definition of macro 'EM_ADV_DATA_CB'
     164 |         { .active_power = _active_power_cb,             \
         |                           ^~~~~~~~~~~~~~~~
   drivers/cpufreq/cppc_cpufreq.c:625:32: note: each undeclared identifier is reported only once for each function it appears in
     625 |                 EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
         |                                ^~~~~~~~~~~~~~~~~~
   include/linux/energy_model.h:164:27: note: in definition of macro 'EM_ADV_DATA_CB'
     164 |         { .active_power = _active_power_cb,             \
         |                           ^~~~~~~~~~~~~~~~
>> drivers/cpufreq/cppc_cpufreq.c:625:52: error: 'cppc_get_cpu_cost' undeclared (first use in this function)
     625 |                 EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
         |                                                    ^~~~~~~~~~~~~~~~~
   include/linux/energy_model.h:165:23: note: in definition of macro 'EM_ADV_DATA_CB'
     165 |           .get_cost = _cost_cb }
         |                       ^~~~~~~~


vim +/cppc_get_cpu_power +625 drivers/cpufreq/cppc_cpufreq.c

d3c3db41df7e1b Pierre Gondois 2022-04-25  620  
740fcdc2c20ecf Pierre Gondois 2022-04-25  621  static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
740fcdc2c20ecf Pierre Gondois 2022-04-25  622  {
740fcdc2c20ecf Pierre Gondois 2022-04-25  623  	struct cppc_cpudata *cpu_data;
740fcdc2c20ecf Pierre Gondois 2022-04-25  624  	struct em_data_callback em_cb =
740fcdc2c20ecf Pierre Gondois 2022-04-25 @625  		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
740fcdc2c20ecf Pierre Gondois 2022-04-25  626  
740fcdc2c20ecf Pierre Gondois 2022-04-25  627  	cpu_data = policy->driver_data;
740fcdc2c20ecf Pierre Gondois 2022-04-25  628  	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
740fcdc2c20ecf Pierre Gondois 2022-04-25  629  			get_perf_level_count(policy), &em_cb,
740fcdc2c20ecf Pierre Gondois 2022-04-25  630  			cpu_data->shared_cpu_map, 0);
740fcdc2c20ecf Pierre Gondois 2022-04-25  631  }
740fcdc2c20ecf Pierre Gondois 2022-04-25  632  

:::::: The code at line 625 was first introduced by commit
:::::: 740fcdc2c20ecf855b36b919d7fa1b872b5a7eae cpufreq: CPPC: Register EM based on efficiency class information

:::::: TO: Pierre Gondois <Pierre.Gondois@arm.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
