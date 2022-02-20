Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91874BD22C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbiBTWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:05:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBTWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:05:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D22DA86
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645394696; x=1676930696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RI/NMBBHuecMHPiz+yMjnwUai41Dse4trg9ZoOraha8=;
  b=PJTqtLibS2kdp12BcR1D+XRLuUMTFX24h/wb+PK9hsvWuuPqfD3KBXbe
   l+5Eqsgp5glloaPTj3ta5sVEBr5bOClB+CFOs9KiFKWBBWbJnSA/ctbWK
   m8+ZSm9tSb8YGQe0qtuQ1fiDPtjr3jnhdVdlvhG6LOneQHdAhxhyLNuI/
   n86gpuiQonsMvLvNGTZWCzTEgbNqdSSQZuTjffXorzwKi84qF7cuv2zAC
   aYB2LxHJtAwIF2A5TraU+72xx440viD+ONDxDFxvbcDElV1M1PaLEemaE
   YiNSw0mo/vxHfXNr4SrYJb0YpyVPdYQ6b3VpQZd7tAMQo80QjzF3UgZoY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="275995341"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="275995341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 14:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="507418150"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2022 14:04:54 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLuK6-0000uf-87; Sun, 20 Feb 2022 22:04:54 +0000
Date:   Mon, 21 Feb 2022 06:04:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ak-misc:lto-5.17-1-wip 51/52] drivers/cpufreq/amd-pstate.c:108:15:
 warning: no previous prototype for function 'do_amd_pstate_enable'
Message-ID: <202202210648.Go90eR5C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git lto-5.17-1-wip
head:   e3a498b1f0eadc0a91ae725fd924588fd660a9af
commit: a06b63a434e176a8ece9d057b89c4bd08a3f32c7 [51/52] cpufreq, amd-pstate, lto: Fix for gcc LTO
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220221/202202210648.Go90eR5C-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git/commit/?id=a06b63a434e176a8ece9d057b89c4bd08a3f32c7
        git remote add ak-misc https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git
        git fetch --no-tags ak-misc lto-5.17-1-wip
        git checkout a06b63a434e176a8ece9d057b89c4bd08a3f32c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:108:15: warning: no previous prototype for function 'do_amd_pstate_enable' [-Wmissing-prototypes]
   __visible int do_amd_pstate_enable(bool enable)
                 ^
   drivers/cpufreq/amd-pstate.c:108:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible int do_amd_pstate_enable(bool enable)
             ^
             static 
>> drivers/cpufreq/amd-pstate.c:133:15: warning: no previous prototype for function 'do_amd_pstate_init_perf' [-Wmissing-prototypes]
   __visible int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
                 ^
   drivers/cpufreq/amd-pstate.c:133:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
             ^
             static 
>> drivers/cpufreq/amd-pstate.c:181:16: warning: no previous prototype for function 'do_amd_pstate_update_perf' [-Wmissing-prototypes]
   __visible void do_amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
                  ^
   drivers/cpufreq/amd-pstate.c:181:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible void do_amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
             ^
             static 
   3 warnings generated.


vim +/do_amd_pstate_enable +108 drivers/cpufreq/amd-pstate.c

   107	
 > 108	__visible int do_amd_pstate_enable(bool enable)
   109	{
   110		return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
   111	}
   112	
   113	static int cppc_enable(bool enable)
   114	{
   115		int cpu, ret = 0;
   116	
   117		for_each_present_cpu(cpu) {
   118			ret = cppc_set_enable(cpu, enable);
   119			if (ret)
   120				return ret;
   121		}
   122	
   123		return ret;
   124	}
   125	
   126	DEFINE_STATIC_CALL(amd_pstate_enable, do_amd_pstate_enable);
   127	
   128	static inline int amd_pstate_enable(bool enable)
   129	{
   130		return static_call(amd_pstate_enable)(enable);
   131	}
   132	
 > 133	__visible int do_amd_pstate_init_perf(struct amd_cpudata *cpudata)
   134	{
   135		u64 cap1;
   136	
   137		int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
   138					     &cap1);
   139		if (ret)
   140			return ret;
   141	
   142		/*
   143		 * TODO: Introduce AMD specific power feature.
   144		 *
   145		 * CPPC entry doesn't indicate the highest performance in some ASICs.
   146		 */
   147		WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
   148	
   149		WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
   150		WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
   151		WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
   152	
   153		return 0;
   154	}
   155	
   156	static int cppc_init_perf(struct amd_cpudata *cpudata)
   157	{
   158		struct cppc_perf_caps cppc_perf;
   159	
   160		int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
   161		if (ret)
   162			return ret;
   163	
   164		WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
   165	
   166		WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
   167		WRITE_ONCE(cpudata->lowest_nonlinear_perf,
   168			   cppc_perf.lowest_nonlinear_perf);
   169		WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
   170	
   171		return 0;
   172	}
   173	
   174	DEFINE_STATIC_CALL(amd_pstate_init_perf, do_amd_pstate_init_perf);
   175	
   176	static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
   177	{
   178		return static_call(amd_pstate_init_perf)(cpudata);
   179	}
   180	
 > 181	__visible void do_amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
   182				       u32 des_perf, u32 max_perf, bool fast_switch)
   183	{
   184		if (fast_switch)
   185			wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
   186		else
   187			wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
   188				      READ_ONCE(cpudata->cppc_req_cached));
   189	}
   190	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
