Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AA520020
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiEIOqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiEIOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:46:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECC16549E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652107344; x=1683643344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DHlcBA0CsTUYg84TRsyQ8DN9VxCsiBrS8QOCtYMhX4I=;
  b=kDmPAEnPfY2hGZGaDKRYyOPneXsKEXU4iOBbA5nrpzD5zQWVa0H34TXA
   J5ZL5X+lKHO1BqtwLSTHQdfbxyVaDTcpEiiETx+/J6W3A71HNa/bc03Xr
   fEY8AmhL6stXtwuSJoIgYlqmpNmxRv+2PLIsiimMIZjGKR4GAcTuPYWuD
   AsnieXa8DIDtIdbfoLC5T3Vt7EuVU68Ptcj4Wz/w7T6DLJCSWi7FxU7In
   SaxQs1PFIzJRTkRtgmnMMVHZ4oVx9pOUM2DG/YLLPbJ6EoabhtNsf+u4T
   l2CA4XXA1E9Vw/FwOyLfjBIiUATaeKIge51esaWE1m9lRHAOeiGvDQ+Yn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269206790"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="269206790"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="570192833"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2022 07:42:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no4ab-000GaK-AW;
        Mon, 09 May 2022 14:42:21 +0000
Date:   Mon, 9 May 2022 22:42:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 29/35] arch/arm64/kvm/mmu.c:767:62:
 sparse: sparse: incorrect type in initializer (different base types)
Message-ID: <202205092247.ZMWPjju8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   2622f5aa2f4ccb93fdd771e7503ca364c6a290d4
commit: a2b56ba6112a814d70545ec5e5c1c04da0bfa83a [29/35] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-randconfig-s031-20220509 (https://download.01.org/0day-ci/archive/20220509/202205092247.ZMWPjju8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/avpatel/linux/commit/a2b56ba6112a814d70545ec5e5c1c04da0bfa83a
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout a2b56ba6112a814d70545ec5e5c1c04da0bfa83a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/mmu.c:767:62: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted gfp_t [usertype] gfp_atomic @@     got void * @@
   arch/arm64/kvm/mmu.c:767:62: sparse:     expected restricted gfp_t [usertype] gfp_atomic
   arch/arm64/kvm/mmu.c:767:62: sparse:     got void *

vim +767 arch/arm64/kvm/mmu.c

d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  752  
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  753  /**
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  754   * kvm_phys_addr_ioremap - map a device range to guest IPA
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  755   *
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  756   * @kvm:	The KVM pointer
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  757   * @guest_ipa:	The IPA at which to insert the mapping
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  758   * @pa:		The physical address of the device
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  759   * @size:	The size of the mapping
c9c0279cc02b4e arch/arm64/kvm/mmu.c Xiaofei Tan         2020-09-17  760   * @writable:   Whether or not to create a writable mapping
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  761   */
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  762  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
c40f2f8ff833ed arch/arm/kvm/mmu.c   Ard Biesheuvel      2014-09-17  763  			  phys_addr_t pa, unsigned long size, bool writable)
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  764  {
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  765  	phys_addr_t addr;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  766  	int ret = 0;
c1a33aebe91d49 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02 @767  	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  768  	struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  769  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  770  				     KVM_PGTABLE_PROT_R |
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  771  				     (writable ? KVM_PGTABLE_PROT_W : 0);
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  772  
bff01cb6b1bf68 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  773  	if (is_protected_kvm_enabled())
bff01cb6b1bf68 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  774  		return -EPERM;
bff01cb6b1bf68 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  775  
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  776  	size += offset_in_page(guest_ipa);
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  777  	guest_ipa &= PAGE_MASK;
c40f2f8ff833ed arch/arm/kvm/mmu.c   Ard Biesheuvel      2014-09-17  778  
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  779  	for (addr = guest_ipa; addr < guest_ipa + size; addr += PAGE_SIZE) {
c1a33aebe91d49 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  780  		ret = kvm_mmu_topup_memory_cache(&cache,
61ffb3a50c4402 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  781  						 kvm_mmu_cache_min_pages(kvm));
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  782  		if (ret)
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  783  			break;
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  784  
fcc5bf89635a05 arch/arm64/kvm/mmu.c Jing Zhang          2022-01-18  785  		write_lock(&kvm->mmu_lock);
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  786  		ret = kvm_pgtable_stage2_map(pgt, addr, PAGE_SIZE, pa, prot,
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  787  					     &cache);
fcc5bf89635a05 arch/arm64/kvm/mmu.c Jing Zhang          2022-01-18  788  		write_unlock(&kvm->mmu_lock);
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  789  		if (ret)
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  790  			break;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  791  
02bbd374ce4a8a arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  792  		pa += PAGE_SIZE;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  793  	}
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  794  
c1a33aebe91d49 arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  795  	kvm_mmu_free_memory_cache(&cache);
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  796  	return ret;
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  797  }
d5d8184d35c990 arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  798  

:::::: The code at line 767 was first introduced by commit
:::::: c1a33aebe91d49c958df1648b2a84db96c403075 KVM: arm64: Use common KVM implementation of MMU memory caches

:::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
