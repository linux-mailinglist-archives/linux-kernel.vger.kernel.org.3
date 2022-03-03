Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271D4CB55E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiCCDNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiCCDNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:13:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C181285
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646277166; x=1677813166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r0ensSs5ySRW5lz8loxIF6hfPqVHuqF4BZcxXQo9MfQ=;
  b=iJZdjl77u1tNhUMAYPDJ74KgFKxK5fw4QOU6vnFgtJX/0Kul4Xk66J0n
   jZbLo8FSuDEpPm2EYhcNu/DxZnTdELByT9DYSFAMRFgZFvTuHKkVKG2rb
   ne+w4kR/BDzcqm3oBPr2J1wkF65sDfy93kII0PzeK9q/Yim744X09lS+7
   o10PNbsTT0u1tjTJc3cM5N9JesO2+IjsnsfUVDB6K7JvzYlK8M2VctDTN
   3m8K9ielv0VyML2YsR44uDmv9lPaLXrUk8Hah95qNjStcSphqBRhvPa7l
   EEN9mIWq8ccJXmtr/cIneJ8TbBhH2pHTCSxSCgPoHiOGxURToFDPoKFwW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="314283234"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="314283234"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 19:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="594236908"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 19:12:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPbtS-00004R-1m; Thu, 03 Mar 2022 03:12:42 +0000
Date:   Thu, 3 Mar 2022 11:12:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Connor O'Brien <connoro@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.9-q
 3282/9999] kernel/bpf/cgroup.c:195:6: warning: variable 'old_flags' set but
 not used
Message-ID: <202203031029.hx0D5KhJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.9-q
head:   47d16afdb18e1fe9883c09a16f34d69b3e72898a
commit: 148f111e986ba49e7e264fd798329aaa636300f3 [3282/9999] BACKPORT: bpf: multi program support for cgroup+bpf
config: i386-randconfig-r034-20211122 (https://download.01.org/0day-ci/archive/20220303/202203031029.hx0D5KhJ-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/148f111e986ba49e7e264fd798329aaa636300f3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.9-q
        git checkout 148f111e986ba49e7e264fd798329aaa636300f3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cgroup.h:11:0,
                    from kernel/bpf/cgroup.c:13:
   include/linux/sched.h:1201:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   kernel/bpf/cgroup.c: In function '__cgroup_bpf_attach':
>> kernel/bpf/cgroup.c:195:6: warning: variable 'old_flags' set but not used [-Wunused-but-set-variable]
     u32 old_flags;
         ^~~~~~~~~


vim +/old_flags +195 kernel/bpf/cgroup.c

  > 13	#include <linux/cgroup.h>
    14	#include <linux/slab.h>
    15	#include <linux/bpf.h>
    16	#include <linux/bpf-cgroup.h>
    17	#include <net/sock.h>
    18	
    19	DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
    20	EXPORT_SYMBOL(cgroup_bpf_enabled_key);
    21	
    22	/**
    23	 * cgroup_bpf_put() - put references of all bpf programs
    24	 * @cgrp: the cgroup to modify
    25	 */
    26	void cgroup_bpf_put(struct cgroup *cgrp)
    27	{
    28		unsigned int type;
    29	
    30		for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
    31			struct list_head *progs = &cgrp->bpf.progs[type];
    32			struct bpf_prog_list *pl, *tmp;
    33	
    34			list_for_each_entry_safe(pl, tmp, progs, node) {
    35				list_del(&pl->node);
    36				bpf_prog_put(pl->prog);
    37				kfree(pl);
    38				static_branch_dec(&cgroup_bpf_enabled_key);
    39			}
    40			bpf_prog_array_free(cgrp->bpf.effective[type]);
    41		}
    42	}
    43	
    44	/* count number of elements in the list.
    45	 * it's slow but the list cannot be long
    46	 */
    47	static u32 prog_list_length(struct list_head *head)
    48	{
    49		struct bpf_prog_list *pl;
    50		u32 cnt = 0;
    51	
    52		list_for_each_entry(pl, head, node) {
    53			if (!pl->prog)
    54				continue;
    55			cnt++;
    56		}
    57		return cnt;
    58	}
    59	
    60	/* if parent has non-overridable prog attached,
    61	 * disallow attaching new programs to the descendent cgroup.
    62	 * if parent has overridable or multi-prog, allow attaching
    63	 */
    64	static bool hierarchy_allows_attach(struct cgroup *cgrp,
    65					    enum bpf_attach_type type,
    66					    u32 new_flags)
    67	{
    68		struct cgroup *p;
    69	
    70		p = cgroup_parent(cgrp);
    71		if (!p)
    72			return true;
    73		do {
    74			u32 flags = p->bpf.flags[type];
    75			u32 cnt;
    76	
    77			if (flags & BPF_F_ALLOW_MULTI)
    78				return true;
    79			cnt = prog_list_length(&p->bpf.progs[type]);
    80			WARN_ON_ONCE(cnt > 1);
    81			if (cnt == 1)
    82				return !!(flags & BPF_F_ALLOW_OVERRIDE);
    83			p = cgroup_parent(p);
    84		} while (p);
    85		return true;
    86	}
    87	
    88	/* compute a chain of effective programs for a given cgroup:
    89	 * start from the list of programs in this cgroup and add
    90	 * all parent programs.
    91	 * Note that parent's F_ALLOW_OVERRIDE-type program is yielding
    92	 * to programs in this cgroup
    93	 */
    94	static int compute_effective_progs(struct cgroup *cgrp,
    95					   enum bpf_attach_type type,
    96					   struct bpf_prog_array __rcu **array)
    97	{
    98		struct bpf_prog_array __rcu *progs;
    99		struct bpf_prog_list *pl;
   100		struct cgroup *p = cgrp;
   101		int cnt = 0;
   102	
   103		/* count number of effective programs by walking parents */
   104		do {
   105			if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
   106				cnt += prog_list_length(&p->bpf.progs[type]);
   107			p = cgroup_parent(p);
   108		} while (p);
   109	
   110		progs = bpf_prog_array_alloc(cnt, GFP_KERNEL);
   111		if (!progs)
   112			return -ENOMEM;
   113	
   114		/* populate the array with effective progs */
   115		cnt = 0;
   116		p = cgrp;
   117		do {
   118			if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
   119				list_for_each_entry(pl,
   120						    &p->bpf.progs[type], node) {
   121					if (!pl->prog)
   122						continue;
   123					rcu_dereference_protected(progs, 1)->
   124						progs[cnt++] = pl->prog;
   125				}
   126			p = cgroup_parent(p);
   127		} while (p);
   128	
   129		*array = progs;
   130		return 0;
   131	}
   132	
   133	static void activate_effective_progs(struct cgroup *cgrp,
   134					     enum bpf_attach_type type,
   135					     struct bpf_prog_array __rcu *array)
   136	{
   137		struct bpf_prog_array __rcu *old_array;
   138	
   139		old_array = xchg(&cgrp->bpf.effective[type], array);
   140		/* free prog array after grace period, since __cgroup_bpf_run_*()
   141		 * might be still walking the array
   142		 */
   143		bpf_prog_array_free(old_array);
   144	}
   145	
   146	/**
   147	 * cgroup_bpf_inherit() - inherit effective programs from parent
   148	 * @cgrp: the cgroup to modify
   149	 */
   150	int cgroup_bpf_inherit(struct cgroup *cgrp)
   151	{
   152	/* has to use marco instead of const int, since compiler thinks
   153	 * that array below is variable length
   154	 */
   155	#define	NR ARRAY_SIZE(cgrp->bpf.effective)
   156		struct bpf_prog_array __rcu *arrays[NR] = {};
   157		int i;
   158	
   159		for (i = 0; i < NR; i++)
   160			INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
   161	
   162		for (i = 0; i < NR; i++)
   163			if (compute_effective_progs(cgrp, i, &arrays[i]))
   164				goto cleanup;
   165	
   166		for (i = 0; i < NR; i++)
   167			activate_effective_progs(cgrp, i, arrays[i]);
   168	
   169		return 0;
   170	cleanup:
   171		for (i = 0; i < NR; i++)
   172			bpf_prog_array_free(arrays[i]);
   173		return -ENOMEM;
   174	}
   175	
   176	#define BPF_CGROUP_MAX_PROGS 64
   177	
   178	/**
   179	 * __cgroup_bpf_attach() - Attach the program to a cgroup, and
   180	 *                         propagate the change to descendants
   181	 * @cgrp: The cgroup which descendants to traverse
   182	 * @prog: A program to attach
   183	 * @type: Type of attach operation
   184	 *
   185	 * Must be called with cgroup_mutex held.
   186	 */
   187	int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
   188				enum bpf_attach_type type, u32 flags)
   189	{
   190		struct list_head *progs = &cgrp->bpf.progs[type];
   191		struct bpf_prog *old_prog = NULL;
   192		struct cgroup_subsys_state *css;
   193		struct bpf_prog_list *pl;
   194		bool pl_was_allocated;
 > 195		u32 old_flags;
   196		int err;
   197	
   198		if ((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI))
   199			/* invalid combination */
   200			return -EINVAL;
   201	
   202		if (!hierarchy_allows_attach(cgrp, type, flags))
   203			return -EPERM;
   204	
   205		if (!list_empty(progs) && cgrp->bpf.flags[type] != flags)
   206			/* Disallow attaching non-overridable on top
   207			 * of existing overridable in this cgroup.
   208			 * Disallow attaching multi-prog if overridable or none
   209			 */
   210			return -EPERM;
   211	
   212		if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
   213			return -E2BIG;
   214	
   215		if (flags & BPF_F_ALLOW_MULTI) {
   216			list_for_each_entry(pl, progs, node)
   217				if (pl->prog == prog)
   218					/* disallow attaching the same prog twice */
   219					return -EINVAL;
   220	
   221			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
   222			if (!pl)
   223				return -ENOMEM;
   224			pl_was_allocated = true;
   225			pl->prog = prog;
   226			list_add_tail(&pl->node, progs);
   227		} else {
   228			if (list_empty(progs)) {
   229				pl = kmalloc(sizeof(*pl), GFP_KERNEL);
   230				if (!pl)
   231					return -ENOMEM;
   232				pl_was_allocated = true;
   233				list_add_tail(&pl->node, progs);
   234			} else {
   235				pl = list_first_entry(progs, typeof(*pl), node);
   236				old_prog = pl->prog;
   237				pl_was_allocated = false;
   238			}
   239			pl->prog = prog;
   240		}
   241	
   242		old_flags = cgrp->bpf.flags[type];
   243		cgrp->bpf.flags[type] = flags;
   244	
   245		/* allocate and recompute effective prog arrays */
   246		css_for_each_descendant_pre(css, &cgrp->self) {
   247			struct cgroup *desc = container_of(css, struct cgroup, self);
   248	
   249			err = compute_effective_progs(desc, type, &desc->bpf.inactive);
   250			if (err)
   251				goto cleanup;
   252		}
   253	
   254		/* all allocations were successful. Activate all prog arrays */
   255		css_for_each_descendant_pre(css, &cgrp->self) {
   256			struct cgroup *desc = container_of(css, struct cgroup, self);
   257	
   258			activate_effective_progs(desc, type, desc->bpf.inactive);
   259			desc->bpf.inactive = NULL;
   260		}
   261	
   262		static_branch_inc(&cgroup_bpf_enabled_key);
   263		if (old_prog) {
   264			bpf_prog_put(old_prog);
   265			static_branch_dec(&cgroup_bpf_enabled_key);
   266		}
   267		return 0;
   268	
   269	cleanup:
   270		/* oom while computing effective. Free all computed effective arrays
   271		 * since they were not activated
   272		 */
   273		css_for_each_descendant_pre(css, &cgrp->self) {
   274			struct cgroup *desc = container_of(css, struct cgroup, self);
   275	
   276			bpf_prog_array_free(desc->bpf.inactive);
   277			desc->bpf.inactive = NULL;
   278		}
   279	
   280		/* and cleanup the prog list */
   281		pl->prog = old_prog;
   282		if (pl_was_allocated) {
   283			list_del(&pl->node);
   284			kfree(pl);
   285		}
   286		return err;
   287	}
   288	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
