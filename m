Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1343D5A74BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiHaER7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiHaER4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:17:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1DA9241
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661919474; x=1693455474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hn/bzboso38gQHLjCAsdbbAHbI424QyH2rYe4F8ADtA=;
  b=UeoC9FkkVyOJ71NI12+eiA+GmB+64AAwa+pDUTPZUJ1iblMlIjyfV0io
   PPk2ZyJflo0gcbDxtz2U4x81jIDGDz12BW863DqPCVao3oR+G2r3D4RSs
   7n0DR7VqBW50nXWJOVPYsKYErhmQNkDODvVo0HXPMBj9ET4KFtl10Vg7M
   hgknyrAUjSsHvn7bj5ugrL014l6IfcNQWAWR/HVFVHrkH0Kkmy7CYgBUz
   tkH94WTCpHAZ4Lvx7Dg5XIvSsmWfvrf56ClVxGZgV53ZMURTA3GjenOja
   wt6WpR4oixaxiYgF6U2HDJPUALMaoHg9AVClhyxZIhHRCYcFZPiIMICBU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357086422"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357086422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 21:17:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="611967435"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2022 21:17:52 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTFAl-0000zT-2Q;
        Wed, 31 Aug 2022 04:17:51 +0000
Date:   Wed, 31 Aug 2022 12:17:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Like Xu <likexu@tencent.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: arch/x86/include/asm/kvm-x86-pmu-ops.h:15 kvm_pmu_ops_update() warn:
 inconsistent indenting
Message-ID: <202208311209.kCoWLT0o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcf8e5633e2e69ad60b730ab5905608b756a032f
commit: 1921f3aa9263977f6c31b1c3eb2814bff2e84a12 KVM: x86: Use static calls to reduce kvm_pmu_ops overhead
date:   5 months ago
config: x86_64-randconfig-m001-20220829 (https://download.01.org/0day-ci/archive/20220831/202208311209.kCoWLT0o-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/x86/include/asm/kvm-x86-pmu-ops.h:15 kvm_pmu_ops_update() warn: inconsistent indenting

vim +15 arch/x86/include/asm/kvm-x86-pmu-ops.h

     5	
     6	/*
     7	 * KVM_X86_PMU_OP() and KVM_X86_PMU_OP_OPTIONAL() are used to help generate
     8	 * both DECLARE/DEFINE_STATIC_CALL() invocations and
     9	 * "static_call_update()" calls.
    10	 *
    11	 * KVM_X86_PMU_OP_OPTIONAL() can be used for those functions that can have
    12	 * a NULL definition, for example if "static_call_cond()" will be used
    13	 * at the call sites.
    14	 */
  > 15	KVM_X86_PMU_OP(pmc_perf_hw_id)
    16	KVM_X86_PMU_OP(pmc_is_enabled)
    17	KVM_X86_PMU_OP(pmc_idx_to_pmc)
    18	KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
    19	KVM_X86_PMU_OP(msr_idx_to_pmc)
    20	KVM_X86_PMU_OP(is_valid_rdpmc_ecx)
    21	KVM_X86_PMU_OP(is_valid_msr)
    22	KVM_X86_PMU_OP(get_msr)
    23	KVM_X86_PMU_OP(set_msr)
    24	KVM_X86_PMU_OP(refresh)
    25	KVM_X86_PMU_OP(init)
    26	KVM_X86_PMU_OP(reset)
    27	KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
    28	KVM_X86_PMU_OP_OPTIONAL(cleanup)
    29	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
