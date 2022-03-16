Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060A04DB906
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbiCPTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiCPTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:50:04 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556CB5AEFA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647460128; x=1678996128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AQmhkNekX7a5TUZZ/G5mXI5zHkY52A3CggUt8MKCEzA=;
  b=TwJ04k93b8jGUBbolp7so8CVsbmjCBbxCloG50YhaUm0an9naz/0tF2c
   LtGbIPeOAsOW/i1jaAOY2RJqyFosBmb0seM0Xmm0NAEHGI1l3zXRg8/dY
   44yDMyiEEXA+RbOirDy+Vw9BuBAAICH4em4eawX5bBku2j2qvrXHucWwA
   CycUOmHRCvwHLfnkD0my1yurE73piofgOFmvMSqD5y4O2IgU0XnSxVxeF
   T6pmI0YJYYxzH42mq1TlwBO2nnKM389OASPQVQlwsCPe3KuN7HX1wNu2R
   d0KytlpipMpctvpXopFBMExSQ23a1RY+T4M1HeqEpd4kUrFeyGX65lADD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317418313"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317418313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="498568611"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2022 12:48:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUZdT-000CpH-Vk; Wed, 16 Mar 2022 19:48:43 +0000
Date:   Thu, 17 Mar 2022 03:47:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 32/38] arch/arm64/kvm/mmu.c:768:55:
 warning: incompatible pointer to integer conversion initializing 'gfp_t'
 (aka 'unsigned int') with an expression of type 'void *'
Message-ID: <202203170328.blnyldnz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   1f93371b93e3d215381b1ebcecacb9f2e54b270f
commit: ef83a194815d993203e117d8a83e591f0a0c288e [32/38] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-randconfig-r013-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170328.blnyldnz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/avpatel/linux/commit/ef83a194815d993203e117d8a83e591f0a0c288e
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout ef83a194815d993203e117d8a83e591f0a0c288e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/mmu.c:768:55: warning: incompatible pointer to integer conversion initializing 'gfp_t' (aka 'unsigned int') with an expression of type 'void *' [-Wint-conversion]
           struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
                                                                ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   1 warning generated.


vim +768 arch/arm64/kvm/mmu.c

d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  753  
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  754  /**
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  755   * kvm_phys_addr_ioremap - map a device range to guest IPA
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  756   *
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  757   * @kvm:	The KVM pointer
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  758   * @guest_ipa:	The IPA at which to insert the mapping
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  759   * @pa:		The physical address of the device
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  760   * @size:	The size of the mapping
c9c0279cc02b4e1 arch/arm64/kvm/mmu.c Xiaofei Tan         2020-09-17  761   * @writable:   Whether or not to create a writable mapping
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  762   */
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  763  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
c40f2f8ff833edd arch/arm/kvm/mmu.c   Ard Biesheuvel      2014-09-17  764  			  phys_addr_t pa, unsigned long size, bool writable)
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  765  {
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  766  	phys_addr_t addr;
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  767  	int ret = 0;
c1a33aebe91d49c arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02 @768  	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  769  	struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  770  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  771  				     KVM_PGTABLE_PROT_R |
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  772  				     (writable ? KVM_PGTABLE_PROT_W : 0);
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  773  
bff01cb6b1bf680 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  774  	if (is_protected_kvm_enabled())
bff01cb6b1bf680 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  775  		return -EPERM;
bff01cb6b1bf680 arch/arm64/kvm/mmu.c Quentin Perret      2021-12-08  776  
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  777  	size += offset_in_page(guest_ipa);
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  778  	guest_ipa &= PAGE_MASK;
c40f2f8ff833edd arch/arm/kvm/mmu.c   Ard Biesheuvel      2014-09-17  779  
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  780  	for (addr = guest_ipa; addr < guest_ipa + size; addr += PAGE_SIZE) {
c1a33aebe91d49c arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  781  		ret = kvm_mmu_topup_memory_cache(&cache,
61ffb3a50c4402e arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  782  						 kvm_mmu_cache_min_pages(kvm));
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  783  		if (ret)
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  784  			break;
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  785  
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  786  		spin_lock(&kvm->mmu_lock);
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  787  		ret = kvm_pgtable_stage2_map(pgt, addr, PAGE_SIZE, pa, prot,
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  788  					     &cache);
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  789  		spin_unlock(&kvm->mmu_lock);
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  790  		if (ret)
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  791  			break;
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  792  
02bbd374ce4a8aa arch/arm64/kvm/mmu.c Will Deacon         2020-09-11  793  		pa += PAGE_SIZE;
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  794  	}
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  795  
c1a33aebe91d49c arch/arm64/kvm/mmu.c Sean Christopherson 2020-07-02  796  	kvm_mmu_free_memory_cache(&cache);
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  797  	return ret;
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  798  }
d5d8184d35c990b arch/arm/kvm/mmu.c   Christoffer Dall    2013-01-20  799  

:::::: The code at line 768 was first introduced by commit
:::::: c1a33aebe91d49c958df1648b2a84db96c403075 KVM: arm64: Use common KVM implementation of MMU memory caches

:::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
