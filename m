Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0071488245
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiAHIUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:20:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:7726 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbiAHIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641630046; x=1673166046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5HBCDTBD70B8hvWV8es++Kj5gDgmY+mHVNllC79NFgU=;
  b=bQJyXx8LMWAl/t34lmpHOjc9jt4f7H01YTAhYfiy93jgnSB1q5bPE57D
   Bts6xtyyORAYElKCDtadpC46ymTwI+W3EphemXmRj5CTMPRDRVikwQMPU
   8VC3rQwKFrJY47iSuYaHAFkm9rcyAC002NcwM+4H7r/1FLkmGYV9vTKzg
   AWqb3zb6tryJI8m7lB/xi5G7R0DGNxUT9meR9bCxWY5hLXZeOHwRRPUhc
   gqtZMLJ6ISnWi8itMeAbqjzlDUBdEGnb3kegP1r+yFM2ar0zbhg6uo5hA
   vVVEVxuMX0Zdhgq76p8yoBM2AO2XxsUTxTzG4g3lJXOr1ZRfLv0aHSQaG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="241810925"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="241810925"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 00:20:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="612407479"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2022 00:20:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n66xw-0000PQ-0T; Sat, 08 Jan 2022 08:20:44 +0000
Date:   Sat, 8 Jan 2022 16:20:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1880/2372]
 arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for
 'sysenter_setup'
Message-ID: <202201081616.RgCtvCvQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: f4fe8ddb47d3a44bc202157766c5c2ef631785a2 [1880/2372] headers/deps: x86/elf: Optimize <asm/elf.h> dependencies, split out <asm/elf_api.h>
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220108/202201081616.RgCtvCvQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f4fe8ddb47d3a44bc202157766c5c2ef631785a2
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f4fe8ddb47d3a44bc202157766c5c2ef631785a2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/vdso/ kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vdso/vdso32-setup.c:55:12: warning: no previous prototype for 'sysenter_setup' [-Wmissing-prototypes]
      55 | int __init sysenter_setup(void)
         |            ^~~~~~~~~~~~~~


vim +/sysenter_setup +55 arch/x86/entry/vdso/vdso32-setup.c

^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  54  
a6c4e076ee4c1e arch/i386/kernel/sysenter.c        Jeremy Fitzhardinge 2007-05-02 @55  int __init sysenter_setup(void)
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  56  {
0a6d1fa0d2b48f arch/x86/entry/vdso/vdso32-setup.c Andy Lutomirski     2015-10-05  57  	init_vdso_image(&vdso_image_32);
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  58  
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  59  	return 0;
^1da177e4c3f41 arch/i386/kernel/sysenter.c        Linus Torvalds      2005-04-16  60  }
e6e5494cb23d19 arch/i386/kernel/sysenter.c        Ingo Molnar         2006-06-27  61  

:::::: The code at line 55 was first introduced by commit
:::::: a6c4e076ee4c1ea670e4faa55814e63dd08e3f29 [PATCH] i386: clean up identify_cpu

:::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
:::::: CC: Andi Kleen <andi@basil.nowhere.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
