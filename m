Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6472E4D500E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiCJRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbiCJRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:17:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD0186220
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932578; x=1678468578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fVZsvmb82GS0Iv0yg4l8ewIuqEqo2Ggefjg74tzsImc=;
  b=U9SAuJP1vC6FJPZU1AiZAnKFkmIFYP8sCLT9OJaxYptsTkyYxX3QEbFQ
   IqFWK9ralLFGeoLheH/jADxf2M9YnvcCyWsS1LhQ6Mt0756JJrLk/tr/w
   3hlBUbjvQi2qmzF9/lVejPTqtmEtr1au2vlCMphw742jg0ObMXih2fpSF
   slXzbKeKnuA498yV9eZVFEnqGVxVuMD4jVfjfnXORXaqkEPYtn7O00Ma8
   mtvqWfeC1xb9fQdcOukGlc1LUwDHDsYkWMXeRFs1thEm3mhx+yyOg1L8m
   fLufMTS12xtqbAVJjFaxsXKa2doJLxs48MW3T1eQ5sjYIh2WNpkBLx30G
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318534812"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="318534812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="510980863"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2022 09:15:32 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSMNw-0005CH-1G; Thu, 10 Mar 2022 17:15:32 +0000
Date:   Fri, 11 Mar 2022 01:15:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Connor O'Brien <connoro@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 241/9999] kernel/bpf/cgroup.c:195:6: warning: variable 'old_flags' set but
 not used
Message-ID: <202203110118.cEBHu9dR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   cb5d0103b1f8fc3aa997a696472fd774c67a1b1f
commit: 9e61c87b1f47b4dc3d48de83d85e9f17c320f91e [241/9999] UPSTREAM: bpf: multi program support for cgroup+bpf
config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20220311/202203110118.cEBHu9dR-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/9e61c87b1f47b4dc3d48de83d85e9f17c320f91e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout 9e61c87b1f47b4dc3d48de83d85e9f17c320f91e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/cgroup.c: In function '__cgroup_bpf_attach':
>> kernel/bpf/cgroup.c:195:6: warning: variable 'old_flags' set but not used [-Wunused-but-set-variable]
     u32 old_flags;
         ^~~~~~~~~


vim +/old_flags +195 kernel/bpf/cgroup.c

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
