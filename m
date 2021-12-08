Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11146C86C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbhLHAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:06:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:19374 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242662AbhLHAGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:06:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="224587316"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224587316"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="580341735"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2021 16:01:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mukOa-000N66-Ib; Wed, 08 Dec 2021 00:01:16 +0000
Date:   Wed, 8 Dec 2021 08:00:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest 2/4] arch/x86/kernel/tdx-tests.c:66:12: warning: no
 previous prototype for 'kvm_unit_test_debug_init'
Message-ID: <202112080759.vxdxKodd-lkp@intel.com>
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
config: i386-buildonly-randconfig-r006-20211207 (https://download.01.org/0day-ci/archive/20211208/202112080759.vxdxKodd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/857f6deb3a90f4d3a0ad94433929d017f31e2efd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 857f6deb3a90f4d3a0ad94433929d017f31e2efd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/tdx-tests.c:66:12: warning: no previous prototype for 'kvm_unit_test_debug_init' [-Wmissing-prototypes]
      66 | int __init kvm_unit_test_debug_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tdx-tests.c: Assembler messages:
   arch/x86/kernel/tdx-tests.c:85: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:86: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:87: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:88: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:89: Error: bad register name `%rax'
   arch/x86/kernel/tdx-tests.c:90: Error: bad register name `%rip)'
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


vim +/kvm_unit_test_debug_init +66 arch/x86/kernel/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
