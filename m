Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299025636BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiGAPQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGAPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:15:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B63057F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656688556; x=1688224556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IisrVhGQr3wsDyXfA3p/+ZgwhBa3ZkRjgDDNl9MnuGg=;
  b=QtM09OPCXn50bwpuN6YQoVzbQWyTcCMB6LUMY/nYdE5/NAGLMvEiHjhS
   kdtyz2iqhk6j3d/0fWGOfzVVHAvzyc2u6Xh/pQpmA5MzxK43Ybk753iGM
   PkvMPvoXIodkK7TfRR1XLgtK1QbZpAyOdnPhRz1EkX8Id2ob4QjY3GW6T
   Fd7z48LpPsdyc4ELXl5LW+n7Y0iu4A9g0PncJBBbc0Dq5d9ZDVquTl+Na
   7muDzgjHmBNLJY5FrubbfJ37idwmSYhwTWynHSF5WrxTdhLZy+B+xyJcf
   spzwwTNb1qvR80VbZf8sXVjHnZKg9dcD4290Uqg8NcCpALnapNHiMu1lW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="346659260"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="346659260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 08:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="648379650"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2022 08:15:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7IN3-000E4k-Gr;
        Fri, 01 Jul 2022 15:15:49 +0000
Date:   Fri, 1 Jul 2022 23:15:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 6/10] net/netfilter/core.c:271:26:
 warning: unused variable 'hook_bpf_prog'
Message-ID: <202207012311.c24zBDoa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   60925d2446cda41b60e41b29c2b4bb2c2b362901
commit: 05ec4cfd58a3b43c47a56f39127dc0c7d1a1ce79 [6/10] netfilter: add bpf base hook program generator
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220701/202207012311.c24zBDoa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=05ec4cfd58a3b43c47a56f39127dc0c7d1a1ce79
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 05ec4cfd58a3b43c47a56f39127dc0c7d1a1ce79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/netfilter/core.c: In function '__nf_hook_entries_try_shrink':
>> net/netfilter/core.c:271:26: warning: unused variable 'hook_bpf_prog' [-Wunused-variable]
     271 |         struct bpf_prog *hook_bpf_prog = NULL;
         |                          ^~~~~~~~~~~~~


vim +/hook_bpf_prog +271 net/netfilter/core.c

   250	
   251	/*
   252	 * __nf_hook_entries_try_shrink - try to shrink hook array
   253	 *
   254	 * @old -- current hook blob at @pp
   255	 * @pp -- location of hook blob
   256	 *
   257	 * Hook unregistration must always succeed, so to-be-removed hooks
   258	 * are replaced by a dummy one that will just move to next hook.
   259	 *
   260	 * This counts the current dummy hooks, attempts to allocate new blob,
   261	 * copies the live hooks, then replaces and discards old one.
   262	 *
   263	 * return values:
   264	 *
   265	 * Returns address to free, or NULL.
   266	 */
   267	static void *__nf_hook_entries_try_shrink(struct nf_hook_entries *old,
   268						  struct nf_hook_entries __rcu **pp)
   269	{
   270		unsigned int i, j, skip = 0, hook_entries;
 > 271		struct bpf_prog *hook_bpf_prog = NULL;
   272		struct nf_hook_entries *new = NULL;
   273		struct nf_hook_ops **orig_ops;
   274		struct nf_hook_ops **new_ops;
   275	
   276		if (WARN_ON_ONCE(!old))
   277			return NULL;
   278	
   279		orig_ops = nf_hook_entries_get_hook_ops(old);
   280		for (i = 0; i < old->num_hook_entries; i++) {
   281			if (orig_ops[i] == &dummy_ops)
   282				skip++;
   283		}
   284	
   285		/* if skip == hook_entries all hooks have been removed */
   286		hook_entries = old->num_hook_entries;
   287		if (skip == hook_entries)
   288			goto out_assign;
   289	
   290		if (skip == 0)
   291			return NULL;
   292	
   293		hook_entries -= skip;
   294		new = allocate_hook_entries_size(hook_entries);
   295		if (!new) {
   296	#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
   297			struct bpf_prog *old_prog = old->hook_prog;
   298	
   299			WRITE_ONCE(old->hook_prog, fallback_nf_hook_slow);
   300			nf_hook_bpf_change_prog(BPF_DISPATCHER_PTR(nf_hook_base), old_prog, NULL);
   301	#endif
   302			return NULL;
   303		}
   304	
   305		new_ops = nf_hook_entries_get_hook_ops(new);
   306		for (i = 0, j = 0; i < old->num_hook_entries; i++) {
   307			if (orig_ops[i] == &dummy_ops)
   308				continue;
   309			new->hooks[j] = old->hooks[i];
   310			new_ops[j] = (void *)orig_ops[i];
   311			j++;
   312		}
   313		hooks_validate(new);
   314	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
