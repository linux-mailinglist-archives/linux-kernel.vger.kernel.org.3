Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D052CA22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiESDNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiESDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:12:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15347540
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652929971; x=1684465971;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yjFgt2KecvSMbv6FYNuU2HpWpeojXewuGqtubk1UJBM=;
  b=hJXaM0zz0Hy+Xoqk9joUqGoV7LGQ0lE3hb1T3bhTrvD40g4X66cVqR1W
   TX1DI3wye1OXf0DGDEAqRMpdqKTPgJ1qmzK4Nl6QUSN6Hk/DtxXgTP0Yp
   15uhhwuo/0IeG26v2o7M/Eh3bYx7+7R21D68p0Ckjvcdf4zKAcwLSgWai
   xVpAmhmgSk9gq1lvjWZSKmxy10burYHTs5SUK+FXNGwQyq8kHe14Tpr5C
   v+hsMEbxgt+L0A89yKsHrq4ve3st7NVomFm52Xm4cJbXaJelilOlRa8Zn
   bOU2/BDPqhs4T9KAP/hfG8v0ZePHzxCRpgn5C1dBn3jKb2v4VHaZvojc0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="269579824"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="269579824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 20:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="545845973"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2022 20:12:49 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrWam-0002yv-V2;
        Thu, 19 May 2022 03:12:48 +0000
Date:   Thu, 19 May 2022 11:12:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 9/12] net/netfilter/core.c:194:20: error:
 'struct nf_hook_entries' has no member named 'hook_prog'
Message-ID: <202205191154.ESiaNSSv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   40bcb3243ee8b8ffbd93213c51c3ca11981aa92a
commit: d6058f935b80dfd90272cda816756fe23f9fd969 [9/12] netfilter: add bpf base hook program generator
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220519/202205191154.ESiaNSSv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=d6058f935b80dfd90272cda816756fe23f9fd969
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout d6058f935b80dfd90272cda816756fe23f9fd969
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/netfilter/core.c: In function 'nf_hook_entries_grow':
>> net/netfilter/core.c:194:20: error: 'struct nf_hook_entries' has no member named 'hook_prog'
     194 |                 new->hook_prog = hook_bpf_prog;
         |                    ^~
>> net/netfilter/core.c:197:39: error: 'const struct nf_hook_entries' has no member named 'hook_prog'
     197 |                         old_prog = old->hook_prog;
         |                                       ^~
   In file included from include/linux/filter.h:9,
                    from include/linux/netfilter.h:5,
                    from net/netfilter/core.c:10:
>> include/linux/bpf.h:895:36: error: 'bpf_dispatcher_nf_hook_base' undeclared (first use in this function); did you mean 'bpf_dispatcher_nop_func'?
     895 | #define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
         |                                    ^~~~~~~~~~~~~~~
   net/netfilter/core.c:199:41: note: in expansion of macro 'BPF_DISPATCHER_PTR'
     199 |                 nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base),
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:895:36: note: each undeclared identifier is reported only once for each function it appears in
     895 | #define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
         |                                    ^~~~~~~~~~~~~~~
   net/netfilter/core.c:199:41: note: in expansion of macro 'BPF_DISPATCHER_PTR'
     199 |                 nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base),
         |                                         ^~~~~~~~~~~~~~~~~~
   net/netfilter/core.c: In function '__nf_hook_entries_try_shrink':
>> include/linux/bpf.h:895:36: error: 'bpf_dispatcher_nf_hook_base' undeclared (first use in this function); did you mean 'bpf_dispatcher_nop_func'?
     895 | #define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
         |                                    ^~~~~~~~~~~~~~~
   net/netfilter/core.c:319:33: note: in expansion of macro 'BPF_DISPATCHER_PTR'
     319 |         nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base),
         |                                 ^~~~~~~~~~~~~~~~~~
   net/netfilter/core.c:320:42: error: 'struct nf_hook_entries' has no member named 'hook_prog'
     320 |                                 old ? old->hook_prog : NULL, hook_bpf_prog);
         |                                          ^~


vim +194 net/netfilter/core.c

   123	
   124	static struct nf_hook_entries *
   125	nf_hook_entries_grow(const struct nf_hook_entries *old,
   126			     const struct nf_hook_ops *reg)
   127	{
   128		unsigned int i, alloc_entries, nhooks, old_entries;
   129		struct nf_hook_ops **orig_ops = NULL;
   130		struct bpf_prog *hook_bpf_prog;
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
   191		if (hook_bpf_prog) {
   192			struct bpf_prog *old_prog = NULL;
   193	
 > 194			new->hook_prog = hook_bpf_prog;
   195	
   196			if (old)
 > 197				old_prog = old->hook_prog;
   198	
   199			nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base),
   200						old_prog, hook_bpf_prog);
   201		}
   202	
   203		return new;
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
