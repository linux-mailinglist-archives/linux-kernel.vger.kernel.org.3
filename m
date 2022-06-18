Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8458E550177
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383769AbiFRArE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiFRArD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:47:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A16A05C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655513222; x=1687049222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Je1y5zy705KJpXaFtnelR3Wqabsngugmqr4TPqyDQ3o=;
  b=awScRf2Mgdef9HeGFIehtSCdCL+DODKMAxBEZSYtzBQ+85Cu75o9PONj
   mclvUDhwGcOGF7mS0MiT5R14v6fh3zFdVXyFQnRir6ZkY/ewZCvHizQ77
   35nMMJ1ZbGaf5C15GW6YMPHIrgxMZUTp1XDvmGwVnzEAQY/QpthmQGLxG
   +04T2fISnNMlTcbCCUVoLdw1IX7PVN+p/igB+C0O+mD5e885taqq6vEJy
   /j5I7CyM9KcTx1aWX+G9O6tG/Bl9c46KxjwPOg6IIcXORz2OQzIbYHcwJ
   v7zD26euwkJRBHqO8xdYFXkQa0K8WYz3BQspAZXvrefbOwB9y87Ha0Vc+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305044761"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305044761"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832248843"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2022 17:47:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Mc7-000Ptd-Vt;
        Sat, 18 Jun 2022 00:46:59 +0000
Date:   Sat, 18 Jun 2022 08:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1457/9999]
 kernel/sched/fair.c:7171 find_energy_efficient_cpu() warn: inconsistent
 indenting
Message-ID: <202206180854.FEljcJix-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: e56a97123c10e6d5ca2ce9a0f1329f02f79f2319 [1457/9999] ANDROID: Add find_best_target to minimise energy calculation overhead
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220618/202206180854.FEljcJix-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/sched/fair.c:7171 find_energy_efficient_cpu() warn: inconsistent indenting

vim +7171 kernel/sched/fair.c

  7092	
  7093	/*
  7094	 * Needs to be called inside rcu_read_lock critical section.
  7095	 * sd is a pointer to the sched domain we wish to use for an
  7096	 * energy-aware placement option.
  7097	 */
  7098	static int find_energy_efficient_cpu(struct sched_domain *sd,
  7099					     struct task_struct *p,
  7100					     int cpu, int prev_cpu,
  7101					     int sync)
  7102	{
  7103		int use_fbt = sched_feat(FIND_BEST_TARGET);
  7104		int cpu_iter, eas_cpu_idx = EAS_CPU_NXT;
  7105		int energy_cpu = prev_cpu;
  7106		struct energy_env *eenv;
  7107	
  7108		if (sysctl_sched_sync_hint_enable && sync) {
  7109			if (cpumask_test_cpu(cpu, &p->cpus_allowed)) {
  7110				return cpu;
  7111			}
  7112		}
  7113	
  7114		/* take ownership of our per-cpu data structure */
  7115		eenv = get_eenv(p, prev_cpu);
  7116		if (eenv->max_cpu_count < 2)
  7117			return energy_cpu;
  7118	
  7119		if(!use_fbt) {
  7120			/*
  7121			 * using this function outside wakeup balance will not supply
  7122			 * an sd ptr. Instead, fetch the highest level with energy data.
  7123			 */
  7124			if (!sd)
  7125				sd = rcu_dereference(per_cpu(sd_ea, prev_cpu));
  7126	
  7127			for_each_cpu_and(cpu_iter, &p->cpus_allowed, sched_domain_span(sd)) {
  7128				unsigned long spare;
  7129	
  7130				/* prev_cpu already in list */
  7131				if (cpu_iter == prev_cpu)
  7132					continue;
  7133	
  7134				spare = capacity_spare_wake(cpu_iter, p);
  7135	
  7136				if (spare * 1024 < capacity_margin * task_util(p))
  7137					continue;
  7138	
  7139				/* Add CPU candidate */
  7140				eenv->cpu[eas_cpu_idx++].cpu_id = cpu_iter;
  7141				eenv->max_cpu_count = eas_cpu_idx;
  7142	
  7143				/* stop adding CPUs if we have no space left */
  7144				if (eas_cpu_idx >= eenv->eenv_cpu_count)
  7145					break;
  7146			}
  7147		} else {
  7148			int boosted = (schedtune_task_boost(p) > 0);
  7149			int prefer_idle;
  7150	
  7151			/*
  7152			 * give compiler a hint that if sched_features
  7153			 * cannot be changed, it is safe to optimise out
  7154			 * all if(prefer_idle) blocks.
  7155			 */
  7156			prefer_idle = sched_feat(EAS_PREFER_IDLE) ?
  7157					(schedtune_prefer_idle(p) > 0) : 0;
  7158	
  7159			eenv->max_cpu_count = EAS_CPU_BKP+1;
  7160	
  7161			/* Find a cpu with sufficient capacity */
  7162			eenv->cpu[EAS_CPU_NXT].cpu_id = find_best_target(p,
  7163					&eenv->cpu[EAS_CPU_BKP].cpu_id,
  7164					boosted, prefer_idle);
  7165	
  7166			/* take note if no backup was found */
  7167			if (eenv->cpu[EAS_CPU_BKP].cpu_id < 0)
  7168				eenv->max_cpu_count = EAS_CPU_BKP;
  7169	
  7170			/* take note if no target was found */
> 7171			 if (eenv->cpu[EAS_CPU_NXT].cpu_id < 0)
  7172				 eenv->max_cpu_count = EAS_CPU_NXT;
  7173		}
  7174	
  7175		if (eenv->max_cpu_count == EAS_CPU_NXT) {
  7176			/*
  7177			 * we did not find any energy-awareness
  7178			 * candidates beyond prev_cpu, so we will
  7179			 * fall-back to the regular slow-path.
  7180			 */
  7181			return energy_cpu;
  7182		}
  7183	
  7184		/* find most energy-efficient CPU */
  7185		eas_cpu_idx = select_energy_cpu_idx(eenv);
  7186		energy_cpu = eenv->cpu[eas_cpu_idx].cpu_id;
  7187	
  7188		return energy_cpu;
  7189	}
  7190	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
