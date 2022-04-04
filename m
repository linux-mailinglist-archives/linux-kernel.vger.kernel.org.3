Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E744F1FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiDDXKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiDDXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:09:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E618213F81
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649112236; x=1680648236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5e39dNMdImcnXbZ2CwzasEyjKU2yhmpc1+hsC4TnQSc=;
  b=bnoWDxmfpMtU89y79vo3Tul5RJd2M2mzsQfYK7XeOZ5UkuuNQh03PxFc
   ueTOAjMQea44PJd/RDm+hx9R3S+NHiHF2n1veGywmX/m5guRQIolRGCiV
   3naeed4FMHzD9GPBOAwqCThTOEPvidEYHDVXtqW7rgwTFZ0smekjhdstU
   qqBHAZA3fSAEIzIpcNsydb4uhFp1Rx5SocQT7uX7VrRmIwuTIl5JkWWiV
   mGCzVj2gApsqV8k49050k5o4dKdmB49uOco+CiKllPfnLmiWEEPd4pxsC
   M60QcMWsiSi3wsT0Y1aIpVvgUvb5nKcU6OdHEGCsY578pJhyKXZVhX4dQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="240559089"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="240559089"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 15:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="641392286"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2022 15:43:36 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbVQ7-0002Pj-RP;
        Mon, 04 Apr 2022 22:43:35 +0000
Date:   Tue, 5 Apr 2022 06:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: arch/x86/events/core.c:1869:25: warning: Local variable 'pmu'
 shadows outer variable [shadowVariable]
Message-ID: <202204050659.ScGUNmKk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: a9c81ccdf52dd73a20178c40bca34cf52991fdea perf/x86: Add structures for the attributes of Hybrid PMUs
date:   12 months ago
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
                                         ^
   arch/x86/events/core.c:766:20: note: Using pointer that is a temporary.
    if (WARN_ON_ONCE(!cpuc->pmu))
                      ^
>> arch/x86/events/core.c:1869:25: warning: Local variable 'pmu' shadows outer variable [shadowVariable]
    struct x86_hybrid_pmu *pmu;
                           ^
   arch/x86/events/core.c:48:19: note: Shadowed declaration
   static struct pmu pmu;
                     ^
   arch/x86/events/core.c:1869:25: note: Shadow variable
    struct x86_hybrid_pmu *pmu;
                           ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

                                         ^
   arch/x86/events/core.c:766:20: note: Using pointer that is a temporary.
    if (WARN_ON_ONCE(!cpuc->pmu))
                      ^
   arch/x86/events/core.c:769:9: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
    return cpuc->pmu;
           ^
   arch/x86/events/core.c:760:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:766:18: note: Assuming condition is false
    if (WARN_ON_ONCE(!cpuc->pmu))
                    ^
   arch/x86/events/core.c:760:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:769:9: note: Using pointer that is a temporary.
    return cpuc->pmu;
           ^
   arch/x86/events/core.c:1561:56: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
    pr_info("CPU#%d: active:     %016llxn", cpu, *(u64 *)cpuc->active_mask);
                                                          ^
   arch/x86/events/core.c:1529:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1536:6: note: Assuming condition is false
    if (!num_counters)
        ^
   arch/x86/events/core.c:1529:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1561:56: note: Using pointer that is a temporary.
    pr_info("CPU#%d: active:     %016llxn", cpu, *(u64 *)cpuc->active_mask);
                                                          ^
   arch/x86/events/core.c:1577:35: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     if (fixed_counter_disabled(idx, cpuc->pmu))
                                     ^
   arch/x86/events/core.c:1529:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1536:6: note: Assuming condition is false
    if (!num_counters)
        ^
   arch/x86/events/core.c:1529:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1577:35: note: Using pointer that is a temporary.
     if (fixed_counter_disabled(idx, cpuc->pmu))
                                     ^
   arch/x86/events/core.c:1760:3: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:1756:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1756:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1760:3: note: Using pointer that is a temporary.
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:1779:9: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     kfree(cpuc->kfree_on_online[i]);
           ^
   arch/x86/events/core.c:1775:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1775:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1779:9: note: Using pointer that is a temporary.
     kfree(cpuc->kfree_on_online[i]);
           ^
   arch/x86/events/core.c:1780:3: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:1775:31: note: Address of variable taken here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                 ^
   arch/x86/events/core.c:1775:39: note: Temporary created here.
    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
                                         ^
   arch/x86/events/core.c:1780:3: note: Using pointer that is a temporary.
     cpuc->kfree_on_online[i] = NULL;
     ^
   arch/x86/events/core.c:2113:3: warning: Same expression on both sides of '-'. [duplicateExpression]
     __EVENT_CONSTRAINT(0, (1ULL << x86_pmu.num_counters) - 1,
     ^
   arch/x86/events/core.c:2163:26: warning: Local variable 'hybrid_pmu' shadows outer function [shadowFunction]
     struct x86_hybrid_pmu *hybrid_pmu;
                            ^
   arch/x86/events/perf_event.h:660:47: note: Shadowed declaration
   static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
                                                 ^
   arch/x86/events/core.c:2163:26: note: Shadow variable
     struct x86_hybrid_pmu *hybrid_pmu;
                            ^

vim +/pmu +1869 arch/x86/events/core.c

  1862	
  1863	ssize_t events_hybrid_sysfs_show(struct device *dev,
  1864					 struct device_attribute *attr,
  1865					 char *page)
  1866	{
  1867		struct perf_pmu_events_hybrid_attr *pmu_attr =
  1868			container_of(attr, struct perf_pmu_events_hybrid_attr, attr);
> 1869		struct x86_hybrid_pmu *pmu;
  1870		const char *str, *next_str;
  1871		int i;
  1872	
  1873		if (hweight64(pmu_attr->pmu_type) == 1)
  1874			return sprintf(page, "%s", pmu_attr->event_str);
  1875	
  1876		/*
  1877		 * Hybrid PMUs may support the same event name, but with different
  1878		 * event encoding, e.g., the mem-loads event on an Atom PMU has
  1879		 * different event encoding from a Core PMU.
  1880		 *
  1881		 * The event_str includes all event encodings. Each event encoding
  1882		 * is divided by ";". The order of the event encodings must follow
  1883		 * the order of the hybrid PMU index.
  1884		 */
  1885		pmu = container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
  1886	
  1887		str = pmu_attr->event_str;
  1888		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
  1889			if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
  1890				continue;
  1891			if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
  1892				next_str = strchr(str, ';');
  1893				if (next_str)
  1894					return snprintf(page, next_str - str + 1, "%s", str);
  1895				else
  1896					return sprintf(page, "%s", str);
  1897			}
  1898			str = strchr(str, ';');
  1899			str++;
  1900		}
  1901	
  1902		return 0;
  1903	}
  1904	EXPORT_SYMBOL_GPL(events_hybrid_sysfs_show);
  1905	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
