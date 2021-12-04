Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F3D468233
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384173AbhLDDy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 22:54:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:57829 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344410AbhLDDy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 22:54:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="261109528"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="261109528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 19:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="501417031"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2021 19:51:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtM5B-000IQq-T5; Sat, 04 Dec 2021 03:51:29 +0000
Date:   Sat, 4 Dec 2021 11:50:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.sls 5/5]
 arch/x86/um/../lib/atomic64_386_32.S:31: warning: "RET" redefined
Message-ID: <202112041135.yWAi9LKU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.sls
head:   6e193eea4eb731c1da2764591f0ced73ca9f326b
commit: 6e193eea4eb731c1da2764591f0ced73ca9f326b [5/5] x86: Add straight-line-speculation mitigation
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211204/202112041135.yWAi9LKU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=6e193eea4eb731c1da2764591f0ced73ca9f326b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.sls
        git checkout 6e193eea4eb731c1da2764591f0ced73ca9f326b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/um/../lib/atomic64_386_32.S:31: warning: "RET" redefined
      31 | #define RET \
         | 
   In file included from include/linux/linkage.h:8,
                    from arch/x86/um/../lib/atomic64_386_32.S:8:
   arch/x86/include/asm/linkage.h:24: note: this is the location of the previous definition
      24 | #define RET ret
         | 


vim +/RET +31 arch/x86/um/../lib/atomic64_386_32.S

417484d47e1157 Luca Barbieri  2010-08-12  30  
30246557a06bb2 Luca Barbieri  2010-08-06 @31  #define RET \
30246557a06bb2 Luca Barbieri  2010-08-06  32  	UNLOCK v; \
fac0bf5b834b04 Peter Zijlstra 2021-12-03  33  	RET
a7e926abc3adfb Luca Barbieri  2010-02-24  34  

:::::: The code at line 31 was first introduced by commit
:::::: 30246557a06bb20618bed906a06d1e1e0faa8bb4 x86, asm: Refactor atomic64_386_32.S to support old binutils and be cleaner

:::::: TO: Luca Barbieri <luca@luca-barbieri.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
