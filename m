Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670FA576C1F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiGPGGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:06:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7283F01
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657951564; x=1689487564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVQJmvZD4ugZa4TvRGKOUU52CcOALczf3amrSfgIGEE=;
  b=es/HFhBoG0SI0mJDGUggnK5B6iF/0fD4uN4Ukmpon7XbCVi+oRsP/LFd
   QnvUWcKCmWRBJsWn/gLv6E4HWu5m7U4mIR5IjcbncpSb1sxu3A0CVYlwG
   jZW9RQcHiIFvQyuB60amDo+NIK+9/5hIo0/wog1aKXvxMcxAEiigW63X7
   ueAhezkSaN5qXnbozqrC4bYqsiSLu/uMssnEefo+zZAtwzWymd5M/MDdD
   UwTbE5GWrTzuk68TNm87TpWOR5nQkfDLHmsEMcs8v/UuYKErbJVjz3X6X
   jvITYP+y6JJSadcU3p3rfsMoODtMT09lzkAKzODeoxl3awRQRynuNw5sg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="287091370"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="287091370"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="624122850"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2022 23:06:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCawB-0001Cc-Fz;
        Sat, 16 Jul 2022 06:05:59 +0000
Date:   Sat, 16 Jul 2022 14:05:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: drivers/cpufreq/tegra194-cpufreq.c:337:32: sparse: sparse: symbol
 'tegra194_cpufreq_soc' was not declared. Should it be static?
Message-ID: <202207161302.50mELF4P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 0839ed1fd7aca2cc67fbe19b8c6394e8a6e58453 cpufreq: tegra194: add soc data to support multiple soc
date:   3 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220716/202207161302.50mELF4P-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0839ed1fd7aca2cc67fbe19b8c6394e8a6e58453
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0839ed1fd7aca2cc67fbe19b8c6394e8a6e58453
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/cpufreq/tegra194-cpufreq.c:337:32: sparse: sparse: symbol 'tegra194_cpufreq_soc' was not declared. Should it be static?

vim +/tegra194_cpufreq_soc +337 drivers/cpufreq/tegra194-cpufreq.c

   335	
   336	static unsigned int tegra194_get_speed(u32 cpu)
 > 337	{
   338		struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
   339		struct cpufreq_frequency_table *pos;
   340		u32 cpuid, clusterid;
   341		unsigned int rate;
   342		u64 ndiv;
   343		int ret;
   344	
   345		data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
   346	
   347		/* reconstruct actual cpu freq using counters */
   348		rate = tegra194_calculate_speed(cpu);
   349	
   350		/* get last written ndiv value */
   351		ret = data->soc->ops->get_cpu_ndiv(cpu, cpuid, clusterid, &ndiv);
   352		if (WARN_ON_ONCE(ret))
   353			return rate;
   354	
   355		/*
   356		 * If the reconstructed frequency has acceptable delta from
   357		 * the last written value, then return freq corresponding
   358		 * to the last written ndiv value from freq_table. This is
   359		 * done to return consistent value.
   360		 */
   361		cpufreq_for_each_valid_entry(pos, data->tables[clusterid]) {
   362			if (pos->driver_data != ndiv)
   363				continue;
   364	
   365			if (abs(pos->frequency - rate) > 115200) {
   366				pr_warn("cpufreq: cpu%d,cur:%u,set:%u,set ndiv:%llu\n",
   367					cpu, rate, pos->frequency, ndiv);
   368			} else {
   369				rate = pos->frequency;
   370			}
   371			break;
   372		}
   373		return rate;
   374	}
   375	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
