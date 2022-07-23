Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1F57F0BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiGWRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiGWRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:46:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D88167CA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658598402; x=1690134402;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=byfy1VmXoGDD6JStp+2Iq80m79qfFIRVQK/Usn6OZDs=;
  b=KYTJvDWbt3oGvdYUuW/v0ryKtZeQ9MUr6OZc4Pzhq01ALuRKhamLcHBt
   Pc1iL91h6YEiwRU6Ur6qkbriPzENkeqg9xTQSAG4+O7QInbkhWjntiQh0
   Z3Pw5qqPBFSmVaJGj50SU5gDqaKQzKF1VQhFMU7vyHmFvLzmxJrg9ASzX
   IeFnpJZT9KKhnj1d/gBBrVdZ75PjzBorpES9trq61gP/CiGd3hHeRNF5b
   Mzfh5EN6HXUg7FrBAyfV0x43jEkJmjXMdJKX0tk417FLAw0552oKhuSCH
   STfaAhED8iL2iItEx2eWFE1KF9Ax52vfz+vifcH1LJqJ1dvqcyLiypOSb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="373789563"
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="373789563"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 10:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="549501718"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jul 2022 10:46:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFJD5-0002un-2Z;
        Sat, 23 Jul 2022 17:46:39 +0000
Date:   Sun, 24 Jul 2022 01:46:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: [avpatel:riscv_sbi_dbcn_v1 8/44] arch/arm64/kvm/mmu.c:789:55: error:
 incompatible pointer to integer conversion initializing 'gfp_t' (aka
 'unsigned int') with an expression of type 'void *'
Message-ID: <202207240129.rZlQmb0J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_sbi_dbcn_v1
head:   1b3aaa127f01dc1a35b6595c628a38b92832488d
commit: beca2348d03ad05136b6c2fd20d2fde9b5b0239e [8/44] KVM: Add gfp_custom flag in struct kvm_mmu_memory_cache
config: arm64-randconfig-r024-20220721 (https://download.01.org/0day-ci/archive/20220724/202207240129.rZlQmb0J-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/avpatel/linux/commit/beca2348d03ad05136b6c2fd20d2fde9b5b0239e
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_sbi_dbcn_v1
        git checkout beca2348d03ad05136b6c2fd20d2fde9b5b0239e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kvm/mmu.c:789:55: error: incompatible pointer to integer conversion initializing 'gfp_t' (aka 'unsigned int') with an expression of type 'void *' [-Wint-conversion]
           struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
                                                                ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   1 error generated.


vim +789 arch/arm64/kvm/mmu.c

d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  774  
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  775  /**
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  776   * kvm_phys_addr_ioremap - map a device range to guest IPA
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  777   *
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  778   * @kvm:	The KVM pointer
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  779   * @guest_ipa:	The IPA at which to insert the mapping
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  780   * @pa:		The physical address of the device
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  781   * @size:	The size of the mapping
c9c0279cc02b4e arch/arm64/kvm/mmu.c Xiaofei Tan         2020-09-17  782   * @writable:   Whether or not to create a writable mapping
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  783   */
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  784  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
c40f2f8ff833ed arch/arm/kvm/mmu.c   Ard Biesheuvel      2014-09-17  785  			  phys_addr_t pa, unsigned long size, bool writable)
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  786  {
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  787  	phys_addr_t addr;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  788  	int ret = 0;
c1a33aebe91d49 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02 @789  	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  790  	struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  791  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  792  				     KVM_PGTABLE_PROT_R |
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  793  				     (writable ? KVM_PGTABLE_PROT_W : 0);
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  794  
bff01cb6b1bf68 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  795  	if (is_protected_kvm_enabled())
bff01cb6b1bf68 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  796  		return -EPERM;
bff01cb6b1bf68 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  797  
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  798  	size += offset_in_page(guest_ipa);
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  799  	guest_ipa &= PAGE_MASK;
c40f2f8ff833ed arch/arm/kvm/mmu.c   Ard Biesheuvel      2014-09-17  800  
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  801  	for (addr = guest_ipa; addr < guest_ipa + size; addr += PAGE_SIZE) {
c1a33aebe91d49 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  802  		ret = kvm_mmu_topup_memory_cache(&cache,
61ffb3a50c4402 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  803  						 kvm_mmu_cache_min_pages(kvm));
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  804  		if (ret)
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  805  			break;
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  806  
fcc5bf89635a05 arch/arm64/kvm/mmu.c Jing Zhang          2022-01-18  807  		write_lock(&kvm->mmu_lock);
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  808  		ret = kvm_pgtable_stage2_map(pgt, addr, PAGE_SIZE, pa, prot,
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  809  					     &cache);
fcc5bf89635a05 arch/arm64/kvm/mmu.c Jing Zhang          2022-01-18  810  		write_unlock(&kvm->mmu_lock);
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  811  		if (ret)
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  812  			break;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  813  
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  814  		pa += PAGE_SIZE;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  815  	}
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  816  
c1a33aebe91d49 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  817  	kvm_mmu_free_memory_cache(&cache);
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  818  	return ret;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  819  }
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  820  

:::::: The code at line 789 was first introduced by commit
:::::: c1a33aebe91d49c958df1648b2a84db96c403075 KVM: arm64: Use common KVM implementation of MMU memory caches

:::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
