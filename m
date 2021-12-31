Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4CF48260F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 00:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhLaXES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 18:04:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:54008 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhLaXES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 18:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640991857; x=1672527857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OtOfCsv/G+qZJTFQyWe4fIYjAxpBa1hYVEj7lcDTSag=;
  b=aQB5NaCmhquQ8QHr55Pq3wwZyfkB6KJoKAF588kF7bhM3tH8cTG7AyAE
   jnbUNghPoSmU7YVVVlGmogblUH50rKOMledbgt+r4/9gGR7cmxJzzH44V
   VVkwgz90+GkybCnUt+yEybUZ//wa8ncO9BlJ4L/kwL46mMfZmnkPA8+qS
   MwGozdDQ7XURgdiwXCZWmshSZ3EpPBstTYlHT1WSelWmzdP0U5RPmQYOx
   dQylT4bRrq5XYJoWSvAQnL1pMGuY22AA046SKLCPMl9RmYDwhVVUd/vid
   UTS6V3g8/zDxc/Ibn8KzlTy/hbBthajlHH1gMukWcg3MpJSXFNSQ46shX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="302602154"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="302602154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 15:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="619731227"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 15:04:15 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3QwZ-000Bm5-Al; Fri, 31 Dec 2021 23:04:15 +0000
Date:   Sat, 1 Jan 2022 07:04:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: arch/arm64/kvm/hyp/nvhe/setup.c:133:17: warning: no previous
 prototype for '__pkvm_init_finalise'
Message-ID: <202201010637.S574BWhv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b4e3f26f9f7553b260b8aed43967500961448a6
commit: f320bc742bc23c1d43567712fe2814bf04b19ebc KVM: arm64: Prepare the creation of s1 mappings at EL2
date:   10 months ago
config: arm64-randconfig-r035-20211231 (https://download.01.org/0day-ci/archive/20220101/202201010637.S574BWhv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f320bc742bc23c1d43567712fe2814bf04b19ebc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f320bc742bc23c1d43567712fe2814bf04b19ebc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/nvhe/setup.c:133:17: warning: no previous prototype for '__pkvm_init_finalise' [-Wmissing-prototypes]
     133 | void __noreturn __pkvm_init_finalise(void)
         |                 ^~~~~~~~~~~~~~~~~~~~


vim +/__pkvm_init_finalise +133 arch/arm64/kvm/hyp/nvhe/setup.c

   132	
 > 133	void __noreturn __pkvm_init_finalise(void)
   134	{
   135		struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
   136		struct kvm_cpu_context *host_ctxt = &host_data->host_ctxt;
   137		unsigned long nr_pages, reserved_pages, pfn;
   138		int ret;
   139	
   140		/* Now that the vmemmap is backed, install the full-fledged allocator */
   141		pfn = hyp_virt_to_pfn(hyp_pgt_base);
   142		nr_pages = hyp_s1_pgtable_pages();
   143		reserved_pages = hyp_early_alloc_nr_used_pages();
   144		ret = hyp_pool_init(&hpool, pfn, nr_pages, reserved_pages);
   145		if (ret)
   146			goto out;
   147	
   148		pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
   149			.zalloc_page = hyp_zalloc_hyp_page,
   150			.phys_to_virt = hyp_phys_to_virt,
   151			.virt_to_phys = hyp_virt_to_phys,
   152			.get_page = hyp_get_page,
   153			.put_page = hyp_put_page,
   154		};
   155		pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
   156	
   157	out:
   158		/*
   159		 * We tail-called to here from handle___pkvm_init() and will not return,
   160		 * so make sure to propagate the return value to the host.
   161		 */
   162		cpu_reg(host_ctxt, 1) = ret;
   163	
   164		__host_enter(host_ctxt);
   165	}
   166	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
