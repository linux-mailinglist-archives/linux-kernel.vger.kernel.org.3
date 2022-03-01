Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8F4C9085
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiCAQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiCAQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:38:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E560ED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646152667; x=1677688667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yNhyQZTm5LbgfUUzw9qmxOPOKbxnTIn546lGvObaqdk=;
  b=NYymSOr/GKrUBccWvvT/GFVfFlDixhL5lOzzs5eNUmYzUb1+bFZVsrmd
   8s0gvLeh4fNtnTI6P1YmCV2rFJFWKcLM2GXpajaPguyfY1nAg4KE+DWrb
   3kLtJ/8uF9vR43rv4hZ19GhZM03fx/LHDNy9NuWXJLqybtQXimHvxATg/
   2iwWyxsdlDKxRih0+b4gWvu+3aflg91sDo5k4uNi9VCKwRvVnVN9efcqt
   Xo7QNflba6M/aArsVkovWBFx3yBWjywLo2TVoCaDT80ywIlUQBoEIV1jB
   nZrfErSFaEd0oivcHZvBuL9MyBMul8nbOLXOBt++OpZhgr6yUNA5YtNcf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="250756789"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250756789"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="575760558"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2022 08:37:44 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP5VP-0000ix-9C; Tue, 01 Mar 2022 16:37:43 +0000
Date:   Wed, 2 Mar 2022 00:37:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 91/284]
 arch/x86/kernel/cpu/mshyperv.c:349: undefined reference to `cc_init'
Message-ID: <202203020008.SIGKbNCs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   f6d152644b6c7b3d6786075dcf924402e4d3f66a
commit: cbb5c73599cf1d3d27f675c38e8f078accc4665e [91/284] x86/coco: Add API to handle encryption mask
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220302/202203020008.SIGKbNCs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/cbb5c73599cf1d3d27f675c38e8f078accc4665e
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout cbb5c73599cf1d3d27f675c38e8f078accc4665e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/cpu/mshyperv.o: in function `ms_hyperv_init_platform':
>> arch/x86/kernel/cpu/mshyperv.c:349: undefined reference to `cc_init'


vim +349 arch/x86/kernel/cpu/mshyperv.c

   267	
   268		/*
   269		 * Extract the features and hints
   270		 */
   271		ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
   272		ms_hyperv.priv_high = cpuid_ebx(HYPERV_CPUID_FEATURES);
   273		ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
   274		ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
   275	
   276		hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
   277	
   278		pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
   279			ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
   280			ms_hyperv.misc_features);
   281	
   282		ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
   283		ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
   284	
   285		pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
   286			 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
   287	
   288		/*
   289		 * Check CPU management privilege.
   290		 *
   291		 * To mirror what Windows does we should extract CPU management
   292		 * features and use the ReservedIdentityBit to detect if Linux is the
   293		 * root partition. But that requires negotiating CPU management
   294		 * interface (a process to be finalized).
   295		 *
   296		 * For now, use the privilege flag as the indicator for running as
   297		 * root.
   298		 */
   299		if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
   300			hv_root_partition = true;
   301			pr_info("Hyper-V: running as root partition\n");
   302		}
   303	
   304		/*
   305		 * Extract host information.
   306		 */
   307		if (hv_max_functions_eax >= HYPERV_CPUID_VERSION) {
   308			hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
   309			hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
   310			hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
   311			hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
   312	
   313			pr_info("Hyper-V Host Build:%d-%d.%d-%d-%d.%d\n",
   314				hv_host_info_eax, hv_host_info_ebx >> 16,
   315				hv_host_info_ebx & 0xFFFF, hv_host_info_ecx,
   316				hv_host_info_edx >> 24, hv_host_info_edx & 0xFFFFFF);
   317		}
   318	
   319		if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
   320		    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
   321			x86_platform.calibrate_tsc = hv_get_tsc_khz;
   322			x86_platform.calibrate_cpu = hv_get_tsc_khz;
   323		}
   324	
   325		if (ms_hyperv.priv_high & HV_ISOLATION) {
   326			ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
   327			ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
   328			ms_hyperv.shared_gpa_boundary =
   329				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
   330	
   331			pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
   332				ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
   333	
   334			if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
   335				static_branch_enable(&isolation_type_snp);
   336	#ifdef CONFIG_SWIOTLB
   337				swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
   338	#endif
   339			}
   340	
   341	#ifdef CONFIG_SWIOTLB
   342			/*
   343			 * Enable swiotlb force mode in Isolation VM to
   344			 * use swiotlb bounce buffer for dma transaction.
   345			 */
   346			swiotlb_force = SWIOTLB_FORCE;
   347	#endif
   348			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
 > 349				cc_init(CC_VENDOR_HYPERV, 0);
   350		}
   351	
   352		if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
   353			ms_hyperv.nested_features =
   354				cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
   355			pr_info("Hyper-V: Nested features: 0x%x\n",
   356				ms_hyperv.nested_features);
   357		}
   358	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
