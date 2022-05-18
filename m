Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B452B72C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiERKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiERKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:09:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73222529
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652868570; x=1684404570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7h4PkmW8j+2py30FeekqxnlsQQgjNvCuSk/Ux7/eyS0=;
  b=P0rvWHQ7x+/G/kb7gbw4lpj92zuaKxSMWaBdzzVa66xUXLr5GpIP7Gvo
   tfexsrGPG1oTzrokOUBpfOiuNgOiCEkXwr3uJ4rIrfd9AlM0UV2AvZvAm
   5K4fiODuLdntJn8XKPsoET+dJsxVuVs1JczTWVVXvIF5UrdyXw5vmJf+T
   ydVsY17M3ZS/HThTyL57gcM3nz05CGMiV5Jfy+kREpP9WrW3fMSqkKcbP
   EfonP3UjO6ncvBZEUlevt9OcgYU5226dCTg1FSu+qmvsnH1ggf23m6CAH
   0PdgzoLdnk8MrU4w34tjs6Kb6bhUSRj+18jnsRP2Qv3zP6C75juS0YPPb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332211749"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="332211749"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 03:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="742250765"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2022 03:09:29 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrGcS-000233-Oq;
        Wed, 18 May 2022 10:09:28 +0000
Date:   Wed, 18 May 2022 18:08:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 8/11] net/netfilter/nf_hook_bpf.c:378:18:
 warning: no previous prototype for 'nf_hook_bpf_create_fb'
Message-ID: <202205181839.Zgp0r4lh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   d8a22b0067851629c08b1094c3341b4058758041
commit: c80ff016f9fc9439c07633f45e4567bb8b098657 [8/11] netfilter: add bpf base hook program generator
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205181839.Zgp0r4lh-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=c80ff016f9fc9439c07633f45e4567bb8b098657
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout c80ff016f9fc9439c07633f45e4567bb8b098657
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/netfilter/nf_hook_bpf.c:378:18: warning: no previous prototype for 'nf_hook_bpf_create_fb' [-Wmissing-prototypes]
     378 | struct bpf_prog *nf_hook_bpf_create_fb(void)
         |                  ^~~~~~~~~~~~~~~~~~~~~
>> net/netfilter/nf_hook_bpf.c:400:18: warning: no previous prototype for 'nf_hook_bpf_create' [-Wmissing-prototypes]
     400 | struct bpf_prog *nf_hook_bpf_create(const struct nf_hook_entries *new)
         |                  ^~~~~~~~~~~~~~~~~~
>> net/netfilter/nf_hook_bpf.c:420:6: warning: no previous prototype for 'nf_hook_bpf_change_prog' [-Wmissing-prototypes]
     420 | void nf_hook_bpf_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from, struct bpf_prog *to)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/nf_hook_bpf_create_fb +378 net/netfilter/nf_hook_bpf.c

   372	
   373	/* fallback program, invokes nf_hook_slow interpreter.
   374	 *
   375	 * Used when a hook is unregsitered and new program cannot
   376	 * be compiled for some reason.
   377	 */
 > 378	struct bpf_prog *nf_hook_bpf_create_fb(void)
   379	{
   380		struct bpf_prog *prog;
   381		struct nf_hook_prog p;
   382		int err;
   383	
   384		err = nf_hook_prog_init(&p);
   385		if (err)
   386			return NULL;
   387	
   388		if (!do_prologue(&p))
   389			goto err;
   390	
   391		if (!emit_nf_hook_slow(&p))
   392			goto err;
   393	
   394		prog = nf_hook_jit_compile(p.insns, p.pos);
   395	err:
   396		nf_hook_prog_free(&p);
   397		return prog;
   398	}
   399	
 > 400	struct bpf_prog *nf_hook_bpf_create(const struct nf_hook_entries *new)
   401	{
   402		struct bpf_prog *prog;
   403		struct nf_hook_prog p;
   404		int err;
   405	
   406		err = nf_hook_prog_init(&p);
   407		if (err)
   408			return NULL;
   409	
   410		err = xlate_base_hooks(&p, new);
   411		if (err)
   412			goto err;
   413	
   414		prog = nf_hook_jit_compile(p.insns, p.pos);
   415	err:
   416		nf_hook_prog_free(&p);
   417		return prog;
   418	}
   419	
 > 420	void nf_hook_bpf_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from, struct bpf_prog *to)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
