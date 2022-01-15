Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D648F698
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiAOLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:49:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:13358 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiAOLtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642247395; x=1673783395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JsiERj0g8ROw4vXv4LGluQgqYSxg4cq67AV0Kbmirzk=;
  b=BJ8Qq1WS2okRNhAMZbC2Tewoc5x0YuvuB1mo0x40vomL43xGze25tlfw
   uPNJLYWjh3hbu4vGZ4+Ze2wKt+OsOQjAqZECXXCTHpJsIreKLWfo2Ox+N
   ua5LFapav86AabIAw7Y+jW5FxyJ+Jd8l1q5mMeKP4pcuHczYpndAfxeGF
   pXDTOZVvtKOn2aJFMTd+7TC9db6fCRQZwvmSRDSoODvxvrKojezHiuFY3
   YkcIdUk4riUeZiZaC8sCJaYv4QqqQR4x0ZVeuissxxBLxODHe+2/o5ZBL
   y8skVDjdhenNUPXth7srSttJTqeYaMUkRHu/IraAmNS4/46iprgMYo8Dc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305138536"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="305138536"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 03:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="516726297"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2022 03:49:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8hZB-0009j8-49; Sat, 15 Jan 2022 11:49:53 +0000
Date:   Sat, 15 Jan 2022 19:49:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Rui <ray.huang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: {standard input}:1381: Error: Insn slot not set in unwind record.
Message-ID: <202201151944.siKQX7w9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
commit: bf67014d6bda16a72deea11dbbff2a97c705ca92 drm/amdgpu: introduce new amdgpu_fence object to indicate the job embedded fence
date:   4 weeks ago
config: ia64-randconfig-r033-20220114 (https://download.01.org/0day-ci/archive/20220115/202201151944.siKQX7w9-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf67014d6bda16a72deea11dbbff2a97c705ca92
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bf67014d6bda16a72deea11dbbff2a97c705ca92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/seq_file.h:12,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:31:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:1381: Error: Insn slot not set in unwind record.
   {standard input}:1381: Fatal error: Section switching in code is not supported.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
