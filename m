Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281954D458E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiCJLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiCJLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:19:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7A8AE57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646911136; x=1678447136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dsW0j/sIpHjN8S+oDTjReBWOqeVvM7grh7Y/5Yy1ouk=;
  b=DXUHyH+9kCh9GKu4pkiXADXH8HMt2xBn+3WweVZByBKqICi5aF7yIaZJ
   EKWhAtmFeFwE5/IOyXDxEZBEu2RsbCVID2cqZ3/8lJzBNYIRn3h+i2tIS
   6NDskHPprflKpKaoOK4aG83p2gml9g9EmrYn2Z1LkL+sRpYfKV5uD+c2B
   Dc8vhE7R6vDTIjur3lxOVrRwAE46+8lF2Z9Ss2KFFBdS2hqD55UWpXaEz
   Tl+mrGb1jEYShcV+C6J+NikUc+HamuwyIDTgTdgW7IMQM66LItC1guDmw
   7HjLD5LhD2opFxZp+WrLtKGbwcXU02Bh24DPAL+w87LBh/AN0F1CoeSW6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255417542"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="255417542"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 03:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="632955802"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2022 03:18:54 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSGoo-0004q3-63; Thu, 10 Mar 2022 11:18:54 +0000
Date:   Thu, 10 Mar 2022 19:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: arch/arm64/kvm/hyp/nvhe/setup.c:133:17: warning: no previous
 prototype for function '__pkvm_init_finalise'
Message-ID: <202203101914.nXeIxgaM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b
commit: f320bc742bc23c1d43567712fe2814bf04b19ebc KVM: arm64: Prepare the creation of s1 mappings at EL2
date:   12 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220310/202203101914.nXeIxgaM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f320bc742bc23c1d43567712fe2814bf04b19ebc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f320bc742bc23c1d43567712fe2814bf04b19ebc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ arch/arm64/kvm/ drivers/gpu/drm/tegra/ drivers/usb/host/ kernel/debug/kdb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/nvhe/setup.c:133:17: warning: no previous prototype for function '__pkvm_init_finalise' [-Wmissing-prototypes]
   void __noreturn __pkvm_init_finalise(void)
                   ^
   arch/arm64/kvm/hyp/nvhe/setup.c:133:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __noreturn __pkvm_init_finalise(void)
   ^
   static 
   1 warning generated.


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
