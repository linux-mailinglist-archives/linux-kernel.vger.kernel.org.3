Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0932653D775
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiFDPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiFDPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:20:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239938BFB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654356043; x=1685892043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3UQHi9s/Mb4hUv0hjwovhOXp771ivsYDkdrEEQElHqU=;
  b=GRB6YajK7B+KDUrpsUf85oOX54jzk28Fo00E2UhkGRobStIDBlbrfRas
   MK4CSXNRZ6gW15yA46jDGSXwSMTCGPexoxhbyP31QNMTwhGt9GlXQNCIy
   vCD3jOn4p70Lq04z9BrD5Fix6hdJxj2E7DLZWW1SKFxiG/7wOkKW2b4rY
   vsMkivQuTXS1G5bYd7ne4LooTQmqGBBY28knquVWB4y/i21ZGo4H+CFwc
   WYylMpZfaPntf5/eMoUipZdwi72RGdisD7thYpa48BIXzO/r2b94QwcNO
   OQnpCHj9N+wi+JY6OvVmCr5CF4oTWeUAXPI547m6NqmaMYkQhZrYgZMGd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276211339"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="276211339"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 08:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="613674934"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2022 08:20:41 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxVZw-000Azr-Ox;
        Sat, 04 Jun 2022 15:20:40 +0000
Date:   Sat, 4 Jun 2022 23:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: arch/arm64/kvm/vmid.c:62 flush_context() warn: inconsistent indenting
Message-ID: <202206042312.ffdERGjt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 3248136b3637e1671e4fa46e32e2122f9ec4bc3d KVM: arm64: Align the VMID allocation with the arm64 ASID
date:   4 months ago
config: arm64-randconfig-m031-20220530 (https://download.01.org/0day-ci/archive/20220604/202206042312.ffdERGjt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/arm64/kvm/vmid.c:62 flush_context() warn: inconsistent indenting

vim +62 arch/arm64/kvm/vmid.c

417838392f2e65 Shameer Kolothum 2021-11-22  34  
417838392f2e65 Shameer Kolothum 2021-11-22  35  #define vmid_gen_match(vmid) \
417838392f2e65 Shameer Kolothum 2021-11-22  36  	(!(((vmid) ^ atomic64_read(&vmid_generation)) >> kvm_arm_vmid_bits))
417838392f2e65 Shameer Kolothum 2021-11-22  37  
417838392f2e65 Shameer Kolothum 2021-11-22  38  static void flush_context(void)
417838392f2e65 Shameer Kolothum 2021-11-22  39  {
417838392f2e65 Shameer Kolothum 2021-11-22  40  	int cpu;
417838392f2e65 Shameer Kolothum 2021-11-22  41  	u64 vmid;
417838392f2e65 Shameer Kolothum 2021-11-22  42  
417838392f2e65 Shameer Kolothum 2021-11-22  43  	bitmap_clear(vmid_map, 0, NUM_USER_VMIDS);
417838392f2e65 Shameer Kolothum 2021-11-22  44  
417838392f2e65 Shameer Kolothum 2021-11-22  45  	for_each_possible_cpu(cpu) {
417838392f2e65 Shameer Kolothum 2021-11-22  46  		vmid = atomic64_xchg_relaxed(&per_cpu(active_vmids, cpu), 0);
417838392f2e65 Shameer Kolothum 2021-11-22  47  
417838392f2e65 Shameer Kolothum 2021-11-22  48  		/* Preserve reserved VMID */
417838392f2e65 Shameer Kolothum 2021-11-22  49  		if (vmid == 0)
417838392f2e65 Shameer Kolothum 2021-11-22  50  			vmid = per_cpu(reserved_vmids, cpu);
417838392f2e65 Shameer Kolothum 2021-11-22  51  		__set_bit(vmid2idx(vmid), vmid_map);
417838392f2e65 Shameer Kolothum 2021-11-22  52  		per_cpu(reserved_vmids, cpu) = vmid;
417838392f2e65 Shameer Kolothum 2021-11-22  53  	}
417838392f2e65 Shameer Kolothum 2021-11-22  54  
417838392f2e65 Shameer Kolothum 2021-11-22  55  	/*
417838392f2e65 Shameer Kolothum 2021-11-22  56  	 * Unlike ASID allocator, we expect less frequent rollover in
417838392f2e65 Shameer Kolothum 2021-11-22  57  	 * case of VMIDs. Hence, instead of marking the CPU as
417838392f2e65 Shameer Kolothum 2021-11-22  58  	 * flush_pending and issuing a local context invalidation on
417838392f2e65 Shameer Kolothum 2021-11-22  59  	 * the next context-switch, we broadcast TLB flush + I-cache
417838392f2e65 Shameer Kolothum 2021-11-22  60  	 * invalidation over the inner shareable domain on rollover.
417838392f2e65 Shameer Kolothum 2021-11-22  61  	 */
417838392f2e65 Shameer Kolothum 2021-11-22 @62  	 kvm_call_hyp(__kvm_flush_vm_context);
417838392f2e65 Shameer Kolothum 2021-11-22  63  }
417838392f2e65 Shameer Kolothum 2021-11-22  64  

:::::: The code at line 62 was first introduced by commit
:::::: 417838392f2e657ee25cc30e373ff4c35a0faa90 KVM: arm64: Introduce a new VMID allocator for KVM

:::::: TO: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
:::::: CC: Marc Zyngier <maz@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
