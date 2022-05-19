Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A552DF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbiESVyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiESVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:54:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CAF53707
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652997278; x=1684533278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IgYYUw6Bz1zf1EN3rBhLQSelRU/yLFG8etbQ6nJeHY0=;
  b=fV/K0RX2hB1RKmryOkENy+BSwtwV5VNVr/+VNGJ29PjwYIcT0p5TQWi1
   7cviUcNoJM+i6JXCrkpDzBx2rRfHAVtIWjLcFNO1JVX0VB2VRr/Hn+8p0
   FxOmqwjMbUWqVLvcxc37WQUVHNiBYbZWtOjJS/vqi2L7NYjnJAPG6hLyd
   4BIUBy5l3NVCRW/InQB60eBimoh/nuD5bUrENjllTUfsEAK6hSq1TC1sK
   E0JhJznhvSKNpQ+BJWd/CcfIphvOYNlOVRdFEhcioI1NRGgxNiWfEILob
   T2ZtvsAWtyDbwp3R1P4MRMODpPtoxt9fL7BQssMtGxSK8j2kUF5Mnm2ZX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="335440876"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="335440876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570448166"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 14:54:37 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nro6O-0003yk-Fi;
        Thu, 19 May 2022 21:54:36 +0000
Date:   Fri, 20 May 2022 05:54:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 9/12] net/netfilter/core.c:130:26:
 warning: variable 'hook_bpf_prog' set but not used
Message-ID: <202205200540.Em86BBF9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   4456ac35299c131e2ac26b4dc025b257d810277b
commit: 11b2910d788799e8c68df305994260fd79a61e10 [9/12] netfilter: add bpf base hook program generator
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220520/202205200540.Em86BBF9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=11b2910d788799e8c68df305994260fd79a61e10
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 11b2910d788799e8c68df305994260fd79a61e10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/netfilter/core.c: In function 'nf_hook_entries_grow':
>> net/netfilter/core.c:130:26: warning: variable 'hook_bpf_prog' set but not used [-Wunused-but-set-variable]
     130 |         struct bpf_prog *hook_bpf_prog;
         |                          ^~~~~~~~~~~~~
   net/netfilter/core.c: In function '__nf_hook_entries_try_shrink':
>> net/netfilter/core.c:269:26: warning: unused variable 'hook_bpf_prog' [-Wunused-variable]
     269 |         struct bpf_prog *hook_bpf_prog = NULL;
         |                          ^~~~~~~~~~~~~


vim +/hook_bpf_prog +130 net/netfilter/core.c

   123	
   124	static struct nf_hook_entries *
   125	nf_hook_entries_grow(const struct nf_hook_entries *old,
   126			     const struct nf_hook_ops *reg)
   127	{
   128		unsigned int i, alloc_entries, nhooks, old_entries;
   129		struct nf_hook_ops **orig_ops = NULL;
 > 130		struct bpf_prog *hook_bpf_prog;
   131		struct nf_hook_ops **new_ops;
   132		struct nf_hook_entries *new;
   133		bool inserted = false;
   134	
   135		alloc_entries = 1;
   136		old_entries = old ? old->num_hook_entries : 0;
   137	
   138		if (old) {
   139			orig_ops = nf_hook_entries_get_hook_ops(old);
   140	
   141			for (i = 0; i < old_entries; i++) {
   142				if (orig_ops[i] != &dummy_ops)
   143					alloc_entries++;
   144			}
   145		}
   146	
   147		if (alloc_entries > MAX_HOOK_COUNT)
   148			return ERR_PTR(-E2BIG);
   149	
   150		new = allocate_hook_entries_size(alloc_entries);
   151		if (!new)
   152			return ERR_PTR(-ENOMEM);
   153	
   154		new_ops = nf_hook_entries_get_hook_ops(new);
   155	
   156		i = 0;
   157		nhooks = 0;
   158		while (i < old_entries) {
   159			if (orig_ops[i] == &dummy_ops) {
   160				++i;
   161				continue;
   162			}
   163	
   164			if (inserted || reg->priority > orig_ops[i]->priority) {
   165				new_ops[nhooks] = (void *)orig_ops[i];
   166				new->hooks[nhooks] = old->hooks[i];
   167				i++;
   168			} else {
   169				new_ops[nhooks] = (void *)reg;
   170				new->hooks[nhooks].hook = reg->hook;
   171				new->hooks[nhooks].priv = reg->priv;
   172				inserted = true;
   173			}
   174			nhooks++;
   175		}
   176	
   177		if (!inserted) {
   178			new_ops[nhooks] = (void *)reg;
   179			new->hooks[nhooks].hook = reg->hook;
   180			new->hooks[nhooks].priv = reg->priv;
   181		}
   182	
   183		hook_bpf_prog = nf_hook_bpf_create(new);
   184	
   185		/* allocate_hook_entries_size() pre-inits ->hook_prog
   186		 * to a fallback program that calls nf_hook_slow().
   187		 *
   188		 * Alternatively we could have nf_hook_entries_grow()
   189		 * return an error here.
   190		 */
   191	#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
   192		if (hook_bpf_prog) {
   193			struct bpf_prog *old_prog = NULL;
   194	
   195			new->hook_prog = hook_bpf_prog;
   196	
   197			if (old)
   198				old_prog = old->hook_prog;
   199	
   200			nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base),
   201						old_prog, hook_bpf_prog);
   202		}
   203	#endif
   204		return new;
   205	}
   206	
   207	static void hooks_validate(const struct nf_hook_entries *hooks)
   208	{
   209	#ifdef CONFIG_DEBUG_MISC
   210		struct nf_hook_ops **orig_ops;
   211		int prio = INT_MIN;
   212		size_t i = 0;
   213	
   214		orig_ops = nf_hook_entries_get_hook_ops(hooks);
   215	
   216		for (i = 0; i < hooks->num_hook_entries; i++) {
   217			if (orig_ops[i] == &dummy_ops)
   218				continue;
   219	
   220			WARN_ON(orig_ops[i]->priority < prio);
   221	
   222			if (orig_ops[i]->priority > prio)
   223				prio = orig_ops[i]->priority;
   224		}
   225	#endif
   226	}
   227	
   228	int nf_hook_entries_insert_raw(struct nf_hook_entries __rcu **pp,
   229					const struct nf_hook_ops *reg)
   230	{
   231		struct nf_hook_entries *new_hooks;
   232		struct nf_hook_entries *p;
   233	
   234		p = rcu_dereference_raw(*pp);
   235		new_hooks = nf_hook_entries_grow(p, reg);
   236		if (IS_ERR(new_hooks))
   237			return PTR_ERR(new_hooks);
   238	
   239		hooks_validate(new_hooks);
   240	
   241		rcu_assign_pointer(*pp, new_hooks);
   242	
   243		BUG_ON(p == new_hooks);
   244		nf_hook_entries_free(p);
   245		return 0;
   246	}
   247	EXPORT_SYMBOL_GPL(nf_hook_entries_insert_raw);
   248	
   249	/*
   250	 * __nf_hook_entries_try_shrink - try to shrink hook array
   251	 *
   252	 * @old -- current hook blob at @pp
   253	 * @pp -- location of hook blob
   254	 *
   255	 * Hook unregistration must always succeed, so to-be-removed hooks
   256	 * are replaced by a dummy one that will just move to next hook.
   257	 *
   258	 * This counts the current dummy hooks, attempts to allocate new blob,
   259	 * copies the live hooks, then replaces and discards old one.
   260	 *
   261	 * return values:
   262	 *
   263	 * Returns address to free, or NULL.
   264	 */
   265	static void *__nf_hook_entries_try_shrink(struct nf_hook_entries *old,
   266						  struct nf_hook_entries __rcu **pp)
   267	{
   268		unsigned int i, j, skip = 0, hook_entries;
 > 269		struct bpf_prog *hook_bpf_prog = NULL;
   270		struct nf_hook_entries *new = NULL;
   271		struct nf_hook_ops **orig_ops;
   272		struct nf_hook_ops **new_ops;
   273	
   274		if (WARN_ON_ONCE(!old))
   275			return NULL;
   276	
   277		orig_ops = nf_hook_entries_get_hook_ops(old);
   278		for (i = 0; i < old->num_hook_entries; i++) {
   279			if (orig_ops[i] == &dummy_ops)
   280				skip++;
   281		}
   282	
   283		/* if skip == hook_entries all hooks have been removed */
   284		hook_entries = old->num_hook_entries;
   285		if (skip == hook_entries)
   286			goto out_assign;
   287	
   288		if (skip == 0)
   289			return NULL;
   290	
   291		hook_entries -= skip;
   292		new = allocate_hook_entries_size(hook_entries);
   293		if (!new) {
   294	#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
   295			struct bpf_prog *old_prog = old->hook_prog;
   296	
   297			WRITE_ONCE(old->hook_prog, fallback_nf_hook_slow);
   298			nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base), old_prog, NULL);
   299	#endif
   300			return NULL;
   301		}
   302	
   303		new_ops = nf_hook_entries_get_hook_ops(new);
   304		for (i = 0, j = 0; i < old->num_hook_entries; i++) {
   305			if (orig_ops[i] == &dummy_ops)
   306				continue;
   307			new->hooks[j] = old->hooks[i];
   308			new_ops[j] = (void *)orig_ops[i];
   309			j++;
   310		}
   311		hooks_validate(new);
   312	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
