Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7569746CB38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhLHC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:59:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:58639 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234660AbhLHC7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:59:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="236483023"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="236483023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 18:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="563919825"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2021 18:56:22 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mun82-000NJT-7v; Wed, 08 Dec 2021 02:56:22 +0000
Date:   Wed, 8 Dec 2021 10:55:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest 2/4] arch/x86/kernel/tdx-tests.c:85: Error: bad
 register name `%rax'
Message-ID: <202112081039.hxR5noCJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   99ee592fd433c9c999684d873636c3764019dd08
commit: 857f6deb3a90f4d3a0ad94433929d017f31e2efd [2/4] x86/tdx-tests: Add a port of a kvm unit test
config: i386-buildonly-randconfig-r006-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081039.hxR5noCJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/857f6deb3a90f4d3a0ad94433929d017f31e2efd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 857f6deb3a90f4d3a0ad94433929d017f31e2efd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/tdx-tests.c:66:12: warning: no previous prototype for 'kvm_unit_test_debug_init' [-Wmissing-prototypes]
      66 | int __init kvm_unit_test_debug_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tdx-tests.c: Assembler messages:
>> arch/x86/kernel/tdx-tests.c:85: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:86: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:87: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:88: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:89: Error: bad register name `%rax'
>> arch/x86/kernel/tdx-tests.c:90: Error: bad register name `%rip)'
   arch/x86/kernel/tdx-tests.c:111: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:112: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:113: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:114: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:115: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:116: Error: bad register name `%rip)'
   arch/x86/kernel/tdx-tests.c:118: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:133: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:134: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:135: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:136: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:137: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:138: Error: bad register name `%rip)'


vim +85 arch/x86/kernel/tdx-tests.c

    65	
    66	int __init kvm_unit_test_debug_init(void)
    67	{
    68		unsigned long start;
    69	
    70		register_die_notifier(&kvm_unit_test_debug_notifier);
    71	
    72		/*
    73		 * cpuid and rdmsr (among others) trigger VM exits and are then
    74		 * emulated. Test that single stepping works on emulated instructions.
    75		 * 
    76		 * With TDX, there are 2 possibilities: instruction is either emulated
    77		 * by the TDX module or the #VE handler. In the former case, it's the
    78		 * job of the TDX module to raise #DB.
    79		 */
    80		n = 0;
    81	
    82		set_debugreg(0, 6);
    83		/* First, test #VE emulated instructions: CPUID 0x5 and RDMSR 0x8b */
    84		asm volatile(
  > 85			"pushf\n\t"
    86			"pop %%rax\n\t"
    87			"and $~(1<<8),%%rax\n\t"
    88			"push %%rax\n\t"
    89			"or $(1<<8),%%rax\n\t"
  > 90			"push %%rax\n\t"

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
