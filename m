Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFC4DAD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354908AbiCPJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbiCPJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:31:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445965425
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647423045; x=1678959045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gELtbsuxhyiadS/SrJkG63DGbYDmBqqwCv7CdIWVuIg=;
  b=NZDB7TTMxkOj6iwGVdymwY/E0lDtA4W6Al14RkLraozlwDwcS27EmVz0
   8OTeCJVIC7Z/PzQC+CbyA4hJHyzWpSZsP6UMEqsfYfUZXVNAflDJIEG2j
   B0pcMIJPeqhnLvvGgKY3coyc26lVHg5H+gLxmuf1AaSSVAUXGpFbEBOPK
   2sMvh6D1e7mfrHj4OW9qM8Bqg8/0F+kUFw9Llgtia00UhatzrNP0feYYU
   qi03KE18Noqzikzw0aOjhR3JB7dxcPqEU7t1Wr64Jlg3fBCZZLOnZqhgB
   hN5Yhi6Shd3DbcoK4qTBXLw8vkv5zF/xwnKM0kf2MK+R7EK9QBTKP4vKr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243987946"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="243987946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 02:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="580842136"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 02:30:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUPzO-000CCz-JG; Wed, 16 Mar 2022 09:30:42 +0000
Date:   Wed, 16 Mar 2022 17:30:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Fabiano Rosas <farosas@linux.ibm.com>
Subject: [linuxppc:topic/ppc-kvm 25/25] arch/powerpc/kvm/powerpc.c:716:29:
 error: implicit declaration of function 'kvmhv_on_pseries'
Message-ID: <202203161748.qlx3DIuD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/linuxppc/linux topic/ppc-kvm
head:   f771b55731fc82b1e8e9ef123f6f1b8d8c92bc63
commit: f771b55731fc82b1e8e9ef123f6f1b8d8c92bc63 [25/25] KVM: PPC: Use KVM_CAP_PPC_AIL_MODE_3
config: powerpc-randconfig-c004-20220314 (https://download.01.org/0day-ci/archive/20220316/202203161748.qlx3DIuD-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linuxppc/linux/commit/f771b55731fc82b1e8e9ef123f6f1b8d8c92bc63
        git remote add linuxppc https://github.com/linuxppc/linux
        git fetch --no-tags linuxppc topic/ppc-kvm
        git checkout f771b55731fc82b1e8e9ef123f6f1b8d8c92bc63
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kvm/powerpc.c: In function 'kvm_vm_ioctl_check_extension':
>> arch/powerpc/kvm/powerpc.c:716:29: error: implicit declaration of function 'kvmhv_on_pseries' [-Werror=implicit-function-declaration]
     716 |                         if (kvmhv_on_pseries()) {
         |                             ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/kvmhv_on_pseries +716 arch/powerpc/kvm/powerpc.c

   593	
   594		case KVM_CAP_PPC_ALLOC_HTAB:
   595			r = hv_enabled;
   596			break;
   597	#endif /* CONFIG_PPC_BOOK3S_64 */
   598	#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
   599		case KVM_CAP_PPC_SMT:
   600			r = 0;
   601			if (kvm) {
   602				if (kvm->arch.emul_smt_mode > 1)
   603					r = kvm->arch.emul_smt_mode;
   604				else
   605					r = kvm->arch.smt_mode;
   606			} else if (hv_enabled) {
   607				if (cpu_has_feature(CPU_FTR_ARCH_300))
   608					r = 1;
   609				else
   610					r = threads_per_subcore;
   611			}
   612			break;
   613		case KVM_CAP_PPC_SMT_POSSIBLE:
   614			r = 1;
   615			if (hv_enabled) {
   616				if (!cpu_has_feature(CPU_FTR_ARCH_300))
   617					r = ((threads_per_subcore << 1) - 1);
   618				else
   619					/* P9 can emulate dbells, so allow any mode */
   620					r = 8 | 4 | 2 | 1;
   621			}
   622			break;
   623		case KVM_CAP_PPC_RMA:
   624			r = 0;
   625			break;
   626		case KVM_CAP_PPC_HWRNG:
   627			r = kvmppc_hwrng_present();
   628			break;
   629		case KVM_CAP_PPC_MMU_RADIX:
   630			r = !!(hv_enabled && radix_enabled());
   631			break;
   632		case KVM_CAP_PPC_MMU_HASH_V3:
   633			r = !!(hv_enabled && kvmppc_hv_ops->hash_v3_possible &&
   634			       kvmppc_hv_ops->hash_v3_possible());
   635			break;
   636		case KVM_CAP_PPC_NESTED_HV:
   637			r = !!(hv_enabled && kvmppc_hv_ops->enable_nested &&
   638			       !kvmppc_hv_ops->enable_nested(NULL));
   639			break;
   640	#endif
   641		case KVM_CAP_SYNC_MMU:
   642	#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
   643			r = hv_enabled;
   644	#elif defined(KVM_ARCH_WANT_MMU_NOTIFIER)
   645			r = 1;
   646	#else
   647			r = 0;
   648	#endif
   649			break;
   650	#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
   651		case KVM_CAP_PPC_HTAB_FD:
   652			r = hv_enabled;
   653			break;
   654	#endif
   655		case KVM_CAP_NR_VCPUS:
   656			/*
   657			 * Recommending a number of CPUs is somewhat arbitrary; we
   658			 * return the number of present CPUs for -HV (since a host
   659			 * will have secondary threads "offline"), and for other KVM
   660			 * implementations just count online CPUs.
   661			 */
   662			if (hv_enabled)
   663				r = min_t(unsigned int, num_present_cpus(), KVM_MAX_VCPUS);
   664			else
   665				r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
   666			break;
   667		case KVM_CAP_MAX_VCPUS:
   668			r = KVM_MAX_VCPUS;
   669			break;
   670		case KVM_CAP_MAX_VCPU_ID:
   671			r = KVM_MAX_VCPU_IDS;
   672			break;
   673	#ifdef CONFIG_PPC_BOOK3S_64
   674		case KVM_CAP_PPC_GET_SMMU_INFO:
   675			r = 1;
   676			break;
   677		case KVM_CAP_SPAPR_MULTITCE:
   678			r = 1;
   679			break;
   680		case KVM_CAP_SPAPR_RESIZE_HPT:
   681			r = !!hv_enabled;
   682			break;
   683	#endif
   684	#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
   685		case KVM_CAP_PPC_FWNMI:
   686			r = hv_enabled;
   687			break;
   688	#endif
   689	#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
   690		case KVM_CAP_PPC_HTM:
   691			r = !!(cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM) ||
   692			     (hv_enabled && cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST));
   693			break;
   694	#endif
   695	#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
   696		case KVM_CAP_PPC_SECURE_GUEST:
   697			r = hv_enabled && kvmppc_hv_ops->enable_svm &&
   698				!kvmppc_hv_ops->enable_svm(NULL);
   699			break;
   700		case KVM_CAP_PPC_DAWR1:
   701			r = !!(hv_enabled && kvmppc_hv_ops->enable_dawr1 &&
   702			       !kvmppc_hv_ops->enable_dawr1(NULL));
   703			break;
   704		case KVM_CAP_PPC_RPT_INVALIDATE:
   705			r = 1;
   706			break;
   707	#endif
   708		case KVM_CAP_PPC_AIL_MODE_3:
   709			r = 0;
   710			/*
   711			 * KVM PR, POWER7, and some POWER9s don't support AIL=3 mode.
   712			 * The POWER9s can support it if the guest runs in hash mode,
   713			 * but QEMU doesn't necessarily query the capability in time.
   714			 */
   715			if (hv_enabled) {
 > 716				if (kvmhv_on_pseries()) {
   717					if (pseries_reloc_on_exception())
   718						r = 1;
   719				} else if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
   720					  !cpu_has_feature(CPU_FTR_P9_RADIX_PREFETCH_BUG)) {
   721					r = 1;
   722				}
   723			}
   724			break;
   725		default:
   726			r = 0;
   727			break;
   728		}
   729		return r;
   730	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
