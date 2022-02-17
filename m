Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CED4B9881
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiBQFz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:55:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiBQFz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:55:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B70294110
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645077312; x=1676613312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RdTt6BGShDvUUcAA2iDcdi03DN9Q7l6a/aTqafr1Y2s=;
  b=cwHUWrJcF/IBFGaGaeONlFRPpztWLYCdM8LOe/WUWvb/Cp6pm86SxTda
   wkEKLVsNG0v7sZI5F/63OzoKpq+IcpFhz6pBrWQvm053D4bxo7yprNm2L
   bjiweqrAMe2T6ZmfomXpPTtFzPe9USdfkqOzVh/V3K5WloZ4cs9C+57NC
   0HLumIhu7/C6ZYP6I22fcXjysyMyBiXJiFtLsUFu9iT+PHkLzx4F/P5is
   L+8YR+AoHQGiSwPXZG0o1mWKjExyswf24PFE4DPppGmixOE7yNzuLVXhw
   Q8fLu6WoBWDqntZo83rBD87Mu47uQVTtgtcwmwadf4ooB/WJauSRu7S8K
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250744463"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250744463"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 21:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="503359164"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 21:55:07 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKZks-000BVh-6G; Thu, 17 Feb 2022 05:55:02 +0000
Date:   Thu, 17 Feb 2022 13:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Weijiang <weijiang.yang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [rppt:cet/kvm 38/49] arch/x86/kvm/x86.c:6587:3: warning: unannotated
 fall-through between switch labels
Message-ID: <202202171337.rVd4JM09-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   e2f9808bd7530f44cd5d95332036bb660b66b8db
commit: 6189c6f50e022a416cbd8620b5c17b0a88b6a0c7 [38/49] KVM: x86: Report XSS as an MSR to be saved if there are supported features
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220217/202202171337.rVd4JM09-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=6189c6f50e022a416cbd8620b5c17b0a88b6a0c7
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout 6189c6f50e022a416cbd8620b5c17b0a88b6a0c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/x86.c:6587:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
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
   1 warning generated.


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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
