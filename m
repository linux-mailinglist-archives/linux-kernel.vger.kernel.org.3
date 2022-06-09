Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E745442FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiFIFOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFIFOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:14:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61991A812
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654751659; x=1686287659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bPpSNM0qfRRWhttHTWjo22wS6kp4t8cjz8VxzjjV24U=;
  b=e8PWIfMAktgEJFBbNY0X0B06KhCmb1elL7BkKAxwIm42P7u+iqfehdod
   +H0zoaRfVu+AOZ6uT+cAp46HfPpKXgRujP1xWQn7PXfxZ2h4bSOw2j1vL
   8CHgZILUiaWC5QM1OuQwtLZ3/nMULiDCKMAH77U8tOy7fezUkBmvPoj9e
   36c5V9gQ3MO9EyOl0FPvtjDQQ0vbhkpkfiQ/DQ1AlMk5TSMkeNsavJMFd
   oWww22ig37CL75idzUjZEEm5AXOWGqW+O6P5HbkTpPBphtGC0SnFztWxJ
   imwQDd8KgKQU1OCnG7uNO8RKq9SOTfyoNdH6rtqOqnD1G+9tfEmcBRUI9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="257580362"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257580362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 22:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="580401803"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2022 22:14:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzAUr-000FX3-Er;
        Thu, 09 Jun 2022 05:14:17 +0000
Date:   Thu, 9 Jun 2022 13:14:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 23/52] arch/arm64/kvm/mmu.c:789:55:
 warning: incompatible pointer to integer conversion initializing 'gfp_t'
 (aka 'unsigned int') with an expression of type 'void *'
Message-ID: <202206091204.G88SVhNb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: 60d5692b8457cf198520e9f19a51922545bfba6a [23/52] RISC-V: KVM: Add G-stage ioremap() and iounmap() functions
config: arm64-buildonly-randconfig-r003-20220608 (https://download.01.org/0day-ci/archive/20220609/202206091204.G88SVhNb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/avpatel/linux/commit/60d5692b8457cf198520e9f19a51922545bfba6a
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout 60d5692b8457cf198520e9f19a51922545bfba6a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/mmu.c:789:55: warning: incompatible pointer to integer conversion initializing 'gfp_t' (aka 'unsigned int') with an expression of type 'void *' [-Wint-conversion]
           struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
                                                                ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   1 warning generated.


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
