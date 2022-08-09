Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7089258E006
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbiHITS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbiHITPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:15:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19B327FD9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660072139; x=1691608139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RteONVSFleu/+l1n/v6eMn2kRB83sVqvdZc3a4R7JhQ=;
  b=S9M2PllwAWB288SZQ7iavzBQpldzi5UCHVaSrO2TceEzRXPN+z6OrHTD
   yujM/hC9CJ6KVu8NUhmjjrJPC7km47XVBaZ7bjHaJMMzFjwkw26mEcjh/
   Te8cQHGidzdjTuXSBSkkx7Vu/49ZWvymkTKkP4BoaGc3J8usSX9tzT79i
   nSsbShFgsFFc/Lro3quBS3XBGkJiWr9/uDFB9N0ytW8lY6HOgpmEx7NKE
   lxYipboaLbovt3QDKj0qmFTCIEu8Q74RQRuixLQjRvToEYESXkIAMDcTy
   e4mZiNgnnY2q7aWDk82G7QcsSJmIThZ/nYJDlHeErO8gvJJEGddvHy0YI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="271297922"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="271297922"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 12:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="580921000"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 12:08:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLUb3-000NCX-0c;
        Tue, 09 Aug 2022 19:08:57 +0000
Date:   Wed, 10 Aug 2022 03:08:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 627/846]
 arch/x86/kvm/mmu/mmu.c:6775:30: error: 'KVM_MEM_ATTR_PRIVATE' undeclared
Message-ID: <202208100315.2ORxWmgi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   6e62680f6e4094d3986229a4145ebd54390dc110
commit: 18114293527217d8d0ccbe394b003089166a35c5 [627/846] KVM: x86/tdp_mmu: implement MapGPA hypercall for TDX
config: i386-randconfig-a001-20220808 (https://download.01.org/0day-ci/archive/20220810/202208100315.2ORxWmgi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/18114293527217d8d0ccbe394b003089166a35c5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 18114293527217d8d0ccbe394b003089166a35c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/ virt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the intel-tdx/kvm-upstream-workaround HEAD 6e62680f6e4094d3986229a4145ebd54390dc110 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_zap_collapsible_spte':
   arch/x86/kvm/mmu/mmu.c:6603:19: warning: variable 'pfn' set but not used [-Wunused-but-set-variable]
    6603 |         kvm_pfn_t pfn;
         |                   ^~~
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_map_gpa':
>> arch/x86/kvm/mmu/mmu.c:6775:30: error: 'KVM_MEM_ATTR_PRIVATE' undeclared (first use in this function)
    6775 |         attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
         |                              ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/mmu/mmu.c:6775:30: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kvm/mmu/mmu.c:6775:53: error: 'KVM_MEM_ATTR_SHARED' undeclared (first use in this function)
    6775 |         attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
         |                                                     ^~~~~~~~~~~~~~~~~~~


vim +/KVM_MEM_ATTR_PRIVATE +6775 arch/x86/kvm/mmu/mmu.c

  6762	
  6763	int kvm_mmu_map_gpa(struct kvm_vcpu *vcpu, gfn_t *startp, gfn_t end,
  6764			    bool map_private)
  6765	{
  6766		struct kvm *kvm = vcpu->kvm;
  6767		gfn_t start = *startp;
  6768		int attr;
  6769		int ret;
  6770	
  6771	
  6772		if (!kvm_gfn_shared_mask(kvm))
  6773			return -EOPNOTSUPP;
  6774	
> 6775		attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
  6776		start = start & ~kvm_gfn_shared_mask(kvm);
  6777		end = end & ~kvm_gfn_shared_mask(kvm);
  6778	
  6779		/*
  6780		 * To make the following kvm_vm_set_mem_attr() success within spinlock
  6781		 * without memory allocation.
  6782		 */
  6783		ret = kvm_vm_reserve_mem_attr(kvm, start, end);
  6784		if (ret)
  6785			return ret;
  6786	
  6787		write_lock(&kvm->mmu_lock);
  6788		if (is_tdp_mmu_enabled(kvm)) {
  6789			gfn_t s = start;
  6790	
  6791			ret = kvm_tdp_mmu_map_gpa(vcpu, &s, end, map_private);
  6792			if (!ret) {
  6793				WARN_ON(kvm_vm_set_mem_attr(kvm, attr, start, end));
  6794			} else if (ret == -EAGAIN) {
  6795				WARN_ON(kvm_vm_set_mem_attr(kvm, attr, start, s));
  6796				start = s;
  6797			}
  6798		} else {
  6799			ret = -EOPNOTSUPP;
  6800		}
  6801		write_unlock(&kvm->mmu_lock);
  6802	
  6803		if (ret == -EAGAIN) {
  6804			if (map_private)
  6805				*startp = kvm_gfn_private(kvm, start);
  6806			else
  6807				*startp = kvm_gfn_shared(kvm, start);
  6808		}
  6809		return ret;
  6810	}
  6811	EXPORT_SYMBOL_GPL(kvm_mmu_map_gpa);
  6812	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
