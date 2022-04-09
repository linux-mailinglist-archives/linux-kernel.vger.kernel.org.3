Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662B34FAB06
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiDIWAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 18:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiDIWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 18:00:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367991E3E0B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649541506; x=1681077506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GzEHq9J8LjhIRKV2m9DF0vVPuSpnlcZiRGhCdrYqJQ8=;
  b=D90OFlphljtJ/S2StDE1hFdFqPHJON8wALffEWhFPhaKhwJmOhF8jvy+
   UsmPelWSDA6/J6DzCBr2rugpzhqcQCakkKKbwKFM4n10M2e0YyjRCQFR5
   VBcGxrf4sEG4zNLR7os3El8PWnYyi0/c/6gCC6q3zMNz4dFmMBNXuctDx
   /hcm8ps5mFOb3f12Gq0SAlTjKAPUHHZSGezCfDmMWiMzCrmFmbujKWDmW
   7gWxBbYHv8Z2XnN+udWd9strSgb1S0DodhBogVe45XepW2tcLOwE2rXxo
   KWm6JPlJHbix0W5vR+j/MHEPvijtudBA1sRpqSnt5aSqExHG+tHT2gpbq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="348347818"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="348347818"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 14:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="852730176"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2022 14:58:23 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndJ67-0000Qg-5S;
        Sat, 09 Apr 2022 21:58:23 +0000
Date:   Sun, 10 Apr 2022 05:58:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: arch/arm64/kvm/hyp/nvhe/setup.c:133:17: warning: no previous
 prototype for '__pkvm_init_finalise'
Message-ID: <202204100501.3dZ5BTDU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: f320bc742bc23c1d43567712fe2814bf04b19ebc KVM: arm64: Prepare the creation of s1 mappings at EL2
date:   1 year, 1 month ago
config: arm64-randconfig-r002-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100501.3dZ5BTDU-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
