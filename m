Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6EA577689
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiGQOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiGQOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:01:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476714D25
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658066510; x=1689602510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E0H8x16ZtkUh7HKuyxtMp3bpxA/5g97+f/oNs2kkqRo=;
  b=ODOgr9yV74LcqqK0w05swCSrY/++MqdgkwHNneLv/8NPhCvFUVGbQfpN
   70FClltHIgkOKiPkjr0434qcXe9XBMx+Y3sxIwi1Rp8kO+GDoViFS+deC
   x1iEVuRP2CcFUa5yXadlObKBCXxort7tYyZvf0jnPs7lIeYHjd6WPutFj
   YNM/eEHOOBeEVts//TwwE14EKGtCV04iEn5HkJKY1JmyuQalckcKPK9V6
   pzab+x2O6A9+XD4GZN3y7B5MysNt7HYFHwsXq0d9J+nol59rDtqw2jdQE
   W4iye5LgJvpbfazIvPaOJE1gzVu1l/I5gNIBgLmmPrtE53DuPwEnQqa5e
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="265848960"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="265848960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 07:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="739180396"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2022 07:01:49 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD4qC-0003LA-S2;
        Sun, 17 Jul 2022 14:01:48 +0000
Date:   Sun, 17 Jul 2022 22:00:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 10/37] arch/arm64/kvm/mmu.c:789:62:
 sparse: sparse: incorrect type in initializer (different base types)
Message-ID: <202207172101.43doHRB4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   c69e408948f99c2a874b010718a0fca5128db40f
commit: 2152b4ea3a941a7d4463dba2bcaeb3918b378d77 [10/37] KVM: Add gfp_custom flag in struct kvm_mmu_memory_cache
config: arm64-randconfig-s051-20220717 (https://download.01.org/0day-ci/archive/20220717/202207172101.43doHRB4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/avpatel/linux/commit/2152b4ea3a941a7d4463dba2bcaeb3918b378d77
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 2152b4ea3a941a7d4463dba2bcaeb3918b378d77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/mmu.c:789:62: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted gfp_t [usertype] gfp_custom @@     got void * @@
   arch/arm64/kvm/mmu.c:789:62: sparse:     expected restricted gfp_t [usertype] gfp_custom
   arch/arm64/kvm/mmu.c:789:62: sparse:     got void *

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
