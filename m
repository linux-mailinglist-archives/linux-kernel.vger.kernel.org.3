Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4A5357D0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiE0Ci4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiE0Ciy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:38:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F0AE52B3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653619133; x=1685155133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yEciXW/qEZbDrq03ZORk1zmLuw0S76ejkbdaY7mm8r0=;
  b=InJ1D1OtqSUcDkAqlddoBas9ZrJLhN+vvpR70s6JhBw0+p0ZpFlZszdv
   Smt10Zk1B+oEtv5uTcFpfp5Ta9+stvjAdT/h+qKmt840AeYTORl4W4F1Y
   /czIDeYoHiKKXfKtegSILWOMvGiU9PtbwsujGAp8e2Tvvpg2FHwaOOyR3
   4o58xfng73kxmIQoAwxH40l8SYxJFpUFPhcob4FsMSDeEOhwLTrdNKgAv
   E6R0VF29VVp7d+a2hM/tBP4ZvnET/xU5lmfdOQK0C8mu7ndYZoD5te+LA
   wwtp1TrWwNinCA8ZCGPjk+wTBDk4e39uVRe5PrkaxSAjDN3n1Bx6a7B0K
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335005059"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335005059"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 19:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="704901463"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 May 2022 19:38:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuPsI-0004L0-FU;
        Fri, 27 May 2022 02:38:50 +0000
Date:   Fri, 27 May 2022 10:37:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Yang Weijiang <weijiang.yang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [rppt:cet/kvm 38/51] arch/x86/kvm/x86.c:6587:3: error: unannotated
 fall-through between switch labels
Message-ID: <202205271056.ub1i6GQ8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   6c13d37e6c4ff3a7f86c5490b3d0f4f12d0a40da
commit: 6189c6f50e022a416cbd8620b5c17b0a88b6a0c7 [38/51] KVM: x86: Report XSS as an MSR to be saved if there are supported features
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220527/202205271056.ub1i6GQ8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6f4644d194da594562027a5d458d9fb7a20ebc39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=6189c6f50e022a416cbd8620b5c17b0a88b6a0c7
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout 6189c6f50e022a416cbd8620b5c17b0a88b6a0c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kvm/x86.c:6587:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
                   case MSR_IA32_XSS:
                   ^
   arch/x86/kvm/x86.c:6587:3: note: insert '__attribute__((fallthrough));' to silence this warning
                   case MSR_IA32_XSS:
                   ^
                   __attribute__((fallthrough)); 
   arch/x86/kvm/x86.c:6587:3: note: insert 'break;' to avoid fall-through
                   case MSR_IA32_XSS:
                   ^
                   break; 
   1 error generated.


vim +6587 arch/x86/kvm/x86.c

  6513	
  6514	static void kvm_init_msr_list(void)
  6515	{
  6516		struct x86_pmu_capability x86_pmu;
  6517		u32 dummy[2];
  6518		unsigned i;
  6519	
  6520		BUILD_BUG_ON_MSG(INTEL_PMC_MAX_FIXED != 4,
  6521				 "Please update the fixed PMCs in msrs_to_saved_all[]");
  6522	
  6523		perf_get_x86_pmu_capability(&x86_pmu);
  6524	
  6525		num_msrs_to_save = 0;
  6526		num_emulated_msrs = 0;
  6527		num_msr_based_features = 0;
  6528	
  6529		for (i = 0; i < ARRAY_SIZE(msrs_to_save_all); i++) {
  6530			if (rdmsr_safe(msrs_to_save_all[i], &dummy[0], &dummy[1]) < 0)
  6531				continue;
  6532	
  6533			/*
  6534			 * Even MSRs that are valid in the host may not be exposed
  6535			 * to the guests in some cases.
  6536			 */
  6537			switch (msrs_to_save_all[i]) {
  6538			case MSR_IA32_BNDCFGS:
  6539				if (!kvm_mpx_supported())
  6540					continue;
  6541				break;
  6542			case MSR_TSC_AUX:
  6543				if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP) &&
  6544				    !kvm_cpu_cap_has(X86_FEATURE_RDPID))
  6545					continue;
  6546				break;
  6547			case MSR_IA32_UMWAIT_CONTROL:
  6548				if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
  6549					continue;
  6550				break;
  6551			case MSR_IA32_RTIT_CTL:
  6552			case MSR_IA32_RTIT_STATUS:
  6553				if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
  6554					continue;
  6555				break;
  6556			case MSR_IA32_RTIT_CR3_MATCH:
  6557				if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
  6558				    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
  6559					continue;
  6560				break;
  6561			case MSR_IA32_RTIT_OUTPUT_BASE:
  6562			case MSR_IA32_RTIT_OUTPUT_MASK:
  6563				if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
  6564					(!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
  6565					 !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
  6566					continue;
  6567				break;
  6568			case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
  6569				if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
  6570					msrs_to_save_all[i] - MSR_IA32_RTIT_ADDR0_A >=
  6571					intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
  6572					continue;
  6573				break;
  6574			case MSR_ARCH_PERFMON_PERFCTR0 ... MSR_ARCH_PERFMON_PERFCTR0 + 17:
  6575				if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_PERFCTR0 >=
  6576				    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
  6577					continue;
  6578				break;
  6579			case MSR_ARCH_PERFMON_EVENTSEL0 ... MSR_ARCH_PERFMON_EVENTSEL0 + 17:
  6580				if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
  6581				    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
  6582					continue;
  6583				break;
  6584			case MSR_IA32_XFD:
  6585			case MSR_IA32_XFD_ERR:
  6586				if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
> 6587			case MSR_IA32_XSS:
  6588				if (!supported_xss)
  6589					continue;
  6590				break;
  6591			default:
  6592				break;
  6593			}
  6594	
  6595			msrs_to_save[num_msrs_to_save++] = msrs_to_save_all[i];
  6596		}
  6597	
  6598		for (i = 0; i < ARRAY_SIZE(emulated_msrs_all); i++) {
  6599			if (!static_call(kvm_x86_has_emulated_msr)(NULL, emulated_msrs_all[i]))
  6600				continue;
  6601	
  6602			emulated_msrs[num_emulated_msrs++] = emulated_msrs_all[i];
  6603		}
  6604	
  6605		for (i = 0; i < ARRAY_SIZE(msr_based_features_all); i++) {
  6606			struct kvm_msr_entry msr;
  6607	
  6608			msr.index = msr_based_features_all[i];
  6609			if (kvm_get_msr_feature(&msr))
  6610				continue;
  6611	
  6612			msr_based_features[num_msr_based_features++] = msr_based_features_all[i];
  6613		}
  6614	}
  6615	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
