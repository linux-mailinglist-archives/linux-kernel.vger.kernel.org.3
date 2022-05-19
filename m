Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665652DF83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiESVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245236AbiESVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:42:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D817A469
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652996561; x=1684532561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cKE7z5cBnsKz33Z/vCu6bCobEgHUw+DmoLjlmMxmAkk=;
  b=JvbOp13PIymAwDDP1tRa/1sRxQFnuLMQAt+lULseXjvICNUY0Rq6jACI
   4KXCUi6/3TWPRrdJWOr3KKn+375I6Fj7GlYmW1jMBZES3JdDAnqeBEG9v
   eYAVxWJSwn99Oiax7e0/Jh3BQBzSjbfrA7u7a+cy9UyC6JvbU2voDvnSa
   H5f1MCXtaI9c8qMuAsIxYm7y3VEOTtOs5UcSqYcuAYwFqFm1xEcqrpi11
   LIm2SAmkW9HG22VodJewBzTwXCgPTzhh7zqH3Qt1Tmtya1Q0ND03+Z7Rg
   vofbNqEFk6N8TG+AA92nWTY5LZnaZGyTTmNKOsRUlVxovWIDScGTdXRyb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="358798148"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="358798148"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="715202960"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 14:42:36 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrnum-0003y9-6J;
        Thu, 19 May 2022 21:42:36 +0000
Date:   Fri, 20 May 2022 05:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 9/12] net/netfilter/core.c:130:26:
 warning: variable 'hook_bpf_prog' set but not used
Message-ID: <202205200503.Y3uqHqTF-lkp@intel.com>
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
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220520/202205200503.Y3uqHqTF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=11b2910d788799e8c68df305994260fd79a61e10
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 11b2910d788799e8c68df305994260fd79a61e10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/netfilter/core.c: In function 'nf_hook_entries_grow':
>> net/netfilter/core.c:130:26: warning: variable 'hook_bpf_prog' set but not used [-Wunused-but-set-variable]
     130 |         struct bpf_prog *hook_bpf_prog;
         |                          ^~~~~~~~~~~~~
   net/netfilter/core.c: In function '__nf_hook_entries_try_shrink':
   net/netfilter/core.c:269:26: warning: unused variable 'hook_bpf_prog' [-Wunused-variable]
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
