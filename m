Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFA24B9532
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiBQBAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:00:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBQBAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:00:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1C279935
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645059598; x=1676595598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1py1ETgH6vdXC+fQo1aB0kCE0g8ZxxwGKkqAWYdxe/c=;
  b=RtQd8AlhqY0tB6ncQx96ZS94QYWNsdshGbAMjIR0z6P/RelNwJzocHkM
   lxBUIBMOc6xjDzZI7K/oQOeKC3ffKxsokgUOI8qj0x6PgA0B/29OmA1F7
   q9kWCLdE/QriGkoTUz+NOkUHH0QKERLkj5VEg9uKNOyNMQiPNoIDrN1gR
   1t/pewMk+9BAh5kQKxPnGvBaNKinIo8eRAPbFuZFqmXb4bTU+Zj/rq4c6
   j9ldYzISwdVbzwJdyAK35+6j5BsHg0qnRgJSrDx0s0FxBvqwYv5Dmrqz2
   Zf59q0tuX08vk/TaEVpHmkDljX5E2BSXQNYSpuGzpjjYzyfOQV7mcgY+k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275345034"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="275345034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503277165"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 16:59:55 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKV9G-000BHB-JH; Thu, 17 Feb 2022 00:59:54 +0000
Date:   Thu, 17 Feb 2022 08:58:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [tip:sched/core 27/28] kernel/sched/topology.c:2284:39: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202202170853.9vofgC3O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   3624ba7b5e2acc02b01301ea5fd3534971eb9896
commit: e496132ebedd870b67f1f6d2428f9bb9d7ae27fd [27/28] sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220217/202202170853.9vofgC3O-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e496132ebedd870b67f1f6d2428f9bb9d7ae27fd
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout e496132ebedd870b67f1f6d2428f9bb9d7ae27fd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/topology.c:461:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct perf_domain *pd @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:461:19: sparse:     expected struct perf_domain *pd
   kernel/sched/topology.c:461:19: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:623:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:623:49: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:623:49: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:694:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:694:50: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:694:50: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:701:55: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child @@     got struct sched_domain *[assigned] tmp @@
   kernel/sched/topology.c:701:55: sparse:     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child
   kernel/sched/topology.c:701:55: sparse:     got struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:711:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:711:29: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:711:29: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:716:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:716:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:716:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:737:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *sd @@
   kernel/sched/topology.c:737:13: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:737:13: sparse:     got struct sched_domain [noderef] __rcu *sd
   kernel/sched/topology.c:899:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:899:70: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:899:70: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:928:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:928:59: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:928:59: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:974:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:974:57: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:974:57: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:976:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:976:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:976:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:984:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:984:55: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:984:55: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:986:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:986:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:986:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1056:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1056:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1056:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1160:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1160:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1160:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1571:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1571:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1571:43: sparse:     got struct sched_domain *child
   kernel/sched/topology.c:2130:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2130:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2130:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2233:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2233:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2233:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2254:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2254:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2254:56: sparse:     got struct sched_domain [noderef] __rcu *child
>> kernel/sched/topology.c:2284:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *top_p @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2284:39: sparse:     expected struct sched_domain *top_p
   kernel/sched/topology.c:2284:39: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/topology.c:2286:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] top @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2286:45: sparse:     expected struct sched_domain *[assigned] top
   kernel/sched/topology.c:2286:45: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2287:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *top_p @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2287:47: sparse:     expected struct sched_domain *top_p
   kernel/sched/topology.c:2287:47: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2253:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2253:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2253:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2303:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2303:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2303:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c: note: in included file:
   kernel/sched/sched.h:1744:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1744:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1744:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1757:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1757:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1757:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1744:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1744:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1744:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1757:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1757:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1757:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:929:31: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1592:19: sparse: sparse: dereference of noderef expression

vim +2284 kernel/sched/topology.c

  2186	
  2187	/*
  2188	 * Build sched domains for a given set of CPUs and attach the sched domains
  2189	 * to the individual CPUs
  2190	 */
  2191	static int
  2192	build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *attr)
  2193	{
  2194		enum s_alloc alloc_state = sa_none;
  2195		struct sched_domain *sd;
  2196		struct s_data d;
  2197		struct rq *rq = NULL;
  2198		int i, ret = -ENOMEM;
  2199		bool has_asym = false;
  2200	
  2201		if (WARN_ON(cpumask_empty(cpu_map)))
  2202			goto error;
  2203	
  2204		alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
  2205		if (alloc_state != sa_rootdomain)
  2206			goto error;
  2207	
  2208		/* Set up domains for CPUs specified by the cpu_map: */
  2209		for_each_cpu(i, cpu_map) {
  2210			struct sched_domain_topology_level *tl;
  2211	
  2212			sd = NULL;
  2213			for_each_sd_topology(tl) {
  2214	
  2215				if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
  2216					goto error;
  2217	
  2218				sd = build_sched_domain(tl, cpu_map, attr, sd, i);
  2219	
  2220				has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
  2221	
  2222				if (tl == sched_domain_topology)
  2223					*per_cpu_ptr(d.sd, i) = sd;
  2224				if (tl->flags & SDTL_OVERLAP)
  2225					sd->flags |= SD_OVERLAP;
  2226				if (cpumask_equal(cpu_map, sched_domain_span(sd)))
  2227					break;
  2228			}
  2229		}
  2230	
  2231		/* Build the groups for the domains */
  2232		for_each_cpu(i, cpu_map) {
  2233			for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
  2234				sd->span_weight = cpumask_weight(sched_domain_span(sd));
  2235				if (sd->flags & SD_OVERLAP) {
  2236					if (build_overlap_sched_groups(sd, i))
  2237						goto error;
  2238				} else {
  2239					if (build_sched_groups(sd, i))
  2240						goto error;
  2241				}
  2242			}
  2243		}
  2244	
  2245		/*
  2246		 * Calculate an allowed NUMA imbalance such that LLCs do not get
  2247		 * imbalanced.
  2248		 */
  2249		for_each_cpu(i, cpu_map) {
  2250			unsigned int imb = 0;
  2251			unsigned int imb_span = 1;
  2252	
  2253			for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
  2254				struct sched_domain *child = sd->child;
  2255	
  2256				if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
  2257				    (child->flags & SD_SHARE_PKG_RESOURCES)) {
  2258					struct sched_domain *top, *top_p;
  2259					unsigned int nr_llcs;
  2260	
  2261					/*
  2262					 * For a single LLC per node, allow an
  2263					 * imbalance up to 25% of the node. This is an
  2264					 * arbitrary cutoff based on SMT-2 to balance
  2265					 * between memory bandwidth and avoiding
  2266					 * premature sharing of HT resources and SMT-4
  2267					 * or SMT-8 *may* benefit from a different
  2268					 * cutoff.
  2269					 *
  2270					 * For multiple LLCs, allow an imbalance
  2271					 * until multiple tasks would share an LLC
  2272					 * on one node while LLCs on another node
  2273					 * remain idle.
  2274					 */
  2275					nr_llcs = sd->span_weight / child->span_weight;
  2276					if (nr_llcs == 1)
  2277						imb = sd->span_weight >> 2;
  2278					else
  2279						imb = nr_llcs;
  2280					sd->imb_numa_nr = imb;
  2281	
  2282					/* Set span based on the first NUMA domain. */
  2283					top = sd;
> 2284					top_p = top->parent;
  2285					while (top_p && !(top_p->flags & SD_NUMA)) {
> 2286						top = top->parent;
  2287						top_p = top->parent;
  2288					}
  2289					imb_span = top_p ? top_p->span_weight : sd->span_weight;
  2290				} else {
  2291					int factor = max(1U, (sd->span_weight / imb_span));
  2292	
  2293					sd->imb_numa_nr = imb * factor;
  2294				}
  2295			}
  2296		}
  2297	
  2298		/* Calculate CPU capacity for physical packages and nodes */
  2299		for (i = nr_cpumask_bits-1; i >= 0; i--) {
  2300			if (!cpumask_test_cpu(i, cpu_map))
  2301				continue;
  2302	
  2303			for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
  2304				claim_allocations(i, sd);
  2305				init_sched_groups_capacity(i, sd);
  2306			}
  2307		}
  2308	
  2309		/* Attach the domains */
  2310		rcu_read_lock();
  2311		for_each_cpu(i, cpu_map) {
  2312			rq = cpu_rq(i);
  2313			sd = *per_cpu_ptr(d.sd, i);
  2314	
  2315			/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
  2316			if (rq->cpu_capacity_orig > READ_ONCE(d.rd->max_cpu_capacity))
  2317				WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
  2318	
  2319			cpu_attach_domain(sd, d.rd, i);
  2320		}
  2321		rcu_read_unlock();
  2322	
  2323		if (has_asym)
  2324			static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
  2325	
  2326		if (rq && sched_debug_verbose) {
  2327			pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
  2328				cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
  2329		}
  2330	
  2331		ret = 0;
  2332	error:
  2333		__free_domain_allocs(&d, alloc_state, cpu_map);
  2334	
  2335		return ret;
  2336	}
  2337	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
