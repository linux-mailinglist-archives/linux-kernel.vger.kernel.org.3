Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91705558AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiFWVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFWVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:37:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F734F459
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656020265; x=1687556265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E8wB6O69E2hwNJsBuwQVf0rnXqcBJCCWtVbyLuzM2uY=;
  b=L4/Ih2KsRdDrog9r/pFo9pmjI6h8PE4OYmCQZwgueLeVWiP5HXWWCKiX
   5VpIYmLbdLTkQpDYxxI4+XwoWvQDKzspabI3BKLK0IdB2ufoqngsifoCF
   kGTKWFUfmc0eL4cqDyR4ZlguEYnFx1NRC2/Qi3R+w2rMpiW4+OEij+L7N
   ENQu4FTKffd/FHInwJzIH0RVzALQPeyM5mIYdrSwmMZcKLSElbUbss1ya
   CqTwcOg1/ep29150VXcM7h/n/Ar9pHJ58aABygdqkyAgGYgyL8TmIly2J
   tKDGFOXb1EEaHaTJPmRozOOSwrsQgEFT5d5MsYHG++mdO5LZwsp7ys2u5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269574035"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="269574035"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 14:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678246115"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 14:37:43 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4UWE-0003C1-GO;
        Thu, 23 Jun 2022 21:37:42 +0000
Date:   Fri, 24 Jun 2022 05:37:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 40/45] drivers/cpufreq/amd-pstate.c:127:15: warning:
 no previous prototype for 'do_amd_pstate_enable'
Message-ID: <202206240521.RzAbNYZb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   8047611082d70c5263114fabce8c80a4c3d251fa
commit: d6c599165eddb7f2b0f4caa0b5be6c3913bf5cfb [40/45] cpufreq, amd-pstate, lto: Fix for gcc LTO
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220624/202206240521.RzAbNYZb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=d6c599165eddb7f2b0f4caa0b5be6c3913bf5cfb
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout d6c599165eddb7f2b0f4caa0b5be6c3913bf5cfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:127:15: warning: no previous prototype for 'do_amd_pstate_enable' [-Wmissing-prototypes]
     127 | __visible int do_amd_pstate_enable(bool enable)
         |               ^~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/amd-pstate.c:152:15: warning: no previous prototype for 'do_amd_pstate_init_perf' [-Wmissing-prototypes]
     152 | __visible int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
         |               ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/amd-pstate.c:200:16: warning: no previous prototype for 'do_amd_pstate_update_perf' [-Wmissing-prototypes]
     200 | __visible void do_amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/do_amd_pstate_enable +127 drivers/cpufreq/amd-pstate.c

   126	
 > 127	__visible int do_amd_pstate_enable(bool enable)
   128	{
   129		return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
   130	}
   131	
   132	static int cppc_enable(bool enable)
   133	{
   134		int cpu, ret = 0;
   135	
   136		for_each_present_cpu(cpu) {
   137			ret = cppc_set_enable(cpu, enable);
   138			if (ret)
   139				return ret;
   140		}
   141	
   142		return ret;
   143	}
   144	
   145	DEFINE_STATIC_CALL(amd_pstate_enable, do_amd_pstate_enable);
   146	
   147	static inline int amd_pstate_enable(bool enable)
   148	{
   149		return static_call(amd_pstate_enable)(enable);
   150	}
   151	
 > 152	__visible int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
   153	{
   154		u64 cap1;
   155	
   156		int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
   157					     &cap1);
   158		if (ret)
   159			return ret;
   160	
   161		/*
   162		 * TODO: Introduce AMD specific power feature.
   163		 *
   164		 * CPPC entry doesn't indicate the highest performance in some ASICs.
   165		 */
   166		WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
   167	
   168		WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
   169		WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
   170		WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
   171	
   172		return 0;
   173	}
   174	
   175	static int cppc_init_perf(struct amd_cpudata *cpudata)
   176	{
   177		struct cppc_perf_caps cppc_perf;
   178	
   179		int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
   180		if (ret)
   181			return ret;
   182	
   183		WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
   184	
   185		WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
   186		WRITE_ONCE(cpudata->lowest_nonlinear_perf,
   187			   cppc_perf.lowest_nonlinear_perf);
   188		WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
   189	
   190		return 0;
   191	}
   192	
   193	DEFINE_STATIC_CALL(amd_pstate_init_perf, do_amd_pstate_init_perf);
   194	
   195	static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
   196	{
   197		return static_call(amd_pstate_init_perf)(cpudata);
   198	}
   199	
 > 200	__visible void do_amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
   201				       u32 des_perf, u32 max_perf, bool fast_switch)
   202	{
   203		if (fast_switch)
   204			wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
   205		else
   206			wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
   207				      READ_ONCE(cpudata->cppc_req_cached));
   208	}
   209	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
