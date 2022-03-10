Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17344D42AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiCJIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCJIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:36:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B58DCE20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646901346; x=1678437346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TOmmHXBy4Vw8h+IYfazTSOkCfXOokZJIGk+zAXH08VY=;
  b=CRqmWzwiUMXqxSOCkKn9FCE2l0QtwDahElZku8h0X36d21xuhE2GgBUr
   /sQjFzkzhQbpMuc9epuafSAOenI95onasnhTZ1MaB7ctgki5FCMQ/oziZ
   V2tSpUVHNBhr/wBxDDRAgVlfDwNFXzv5Odjv09mn+sFDRqzbIcpIJESzy
   ymiRQ5RiujKPECnm9sAZai4cNaSY0t6HVgq4B3AQdvzkVDxp0nXX6N3JX
   RuGoiwL+fTjHeiR3okXX31NCs4UaATIaBCxzspzN4hjbZVW/0T+sbLuBD
   BUWRPcH8LanJkIRHgNtV1bf/dtLD6hTA0EQvPZAic1tawaou8oeX0iZTd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255381100"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255381100"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="712277523"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2022 00:35:44 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSEGt-0004eX-LL; Thu, 10 Mar 2022 08:35:43 +0000
Date:   Thu, 10 Mar 2022 16:34:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mm/proc-v7-bugs.c:111:15: warning: more '%' conversions
 than data arguments
Message-ID: <202203101629.dia0kbU5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b
commit: 9dd78194a3722fa6712192cdd4f7032d45112a9a ARM: report Spectre v2 status through sysfs
date:   5 days ago
config: arm-randconfig-r035-20220310 (https://download.01.org/0day-ci/archive/20220310/202203101629.dia0kbU5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9dd78194a3722fa6712192cdd4f7032d45112a9a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9dd78194a3722fa6712192cdd4f7032d45112a9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mm/proc-v7-bugs.c:111:15: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
           pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n");
                       ~^
   include/linux/printk.h:523:26: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ^~~
   include/linux/printk.h:340:21: note: expanded from macro 'pr_fmt'
   #define pr_fmt(fmt) fmt
                       ^~~
   include/linux/printk.h:450:53: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ^~~
   include/linux/printk.h:422:11: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ^~~~
   arch/arm/mm/proc-v7-bugs.c:205:6: warning: no previous prototype for function 'cpu_v7_ca8_ibe' [-Wmissing-prototypes]
   void cpu_v7_ca8_ibe(void)
        ^
   arch/arm/mm/proc-v7-bugs.c:205:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cpu_v7_ca8_ibe(void)
   ^
   static 
   arch/arm/mm/proc-v7-bugs.c:211:6: warning: no previous prototype for function 'cpu_v7_ca15_ibe' [-Wmissing-prototypes]
   void cpu_v7_ca15_ibe(void)
        ^
   arch/arm/mm/proc-v7-bugs.c:211:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cpu_v7_ca15_ibe(void)
   ^
   static 
   arch/arm/mm/proc-v7-bugs.c:217:6: warning: no previous prototype for function 'cpu_v7_bugs_init' [-Wmissing-prototypes]
   void cpu_v7_bugs_init(void)
        ^
   arch/arm/mm/proc-v7-bugs.c:217:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cpu_v7_bugs_init(void)
   ^
   static 
   4 warnings generated.


vim +111 arch/arm/mm/proc-v7-bugs.c

    65	
    66	static unsigned int spectre_v2_install_workaround(unsigned int method)
    67	{
    68		const char *spectre_v2_method = NULL;
    69		int cpu = smp_processor_id();
    70	
    71		if (per_cpu(harden_branch_predictor_fn, cpu))
    72			return SPECTRE_MITIGATED;
    73	
    74		switch (method) {
    75		case SPECTRE_V2_METHOD_BPIALL:
    76			per_cpu(harden_branch_predictor_fn, cpu) =
    77				harden_branch_predictor_bpiall;
    78			spectre_v2_method = "BPIALL";
    79			break;
    80	
    81		case SPECTRE_V2_METHOD_ICIALLU:
    82			per_cpu(harden_branch_predictor_fn, cpu) =
    83				harden_branch_predictor_iciallu;
    84			spectre_v2_method = "ICIALLU";
    85			break;
    86	
    87		case SPECTRE_V2_METHOD_HVC:
    88			per_cpu(harden_branch_predictor_fn, cpu) =
    89				call_hvc_arch_workaround_1;
    90			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
    91			spectre_v2_method = "hypervisor";
    92			break;
    93	
    94		case SPECTRE_V2_METHOD_SMC:
    95			per_cpu(harden_branch_predictor_fn, cpu) =
    96				call_smc_arch_workaround_1;
    97			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
    98			spectre_v2_method = "firmware";
    99			break;
   100		}
   101	
   102		if (spectre_v2_method)
   103			pr_info("CPU%u: Spectre v2: using %s workaround\n",
   104				smp_processor_id(), spectre_v2_method);
   105	
   106		return SPECTRE_MITIGATED;
   107	}
   108	#else
   109	static unsigned int spectre_v2_install_workaround(unsigned int method)
   110	{
 > 111		pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n");
   112	
   113		return SPECTRE_VULNERABLE;
   114	}
   115	#endif
   116	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
