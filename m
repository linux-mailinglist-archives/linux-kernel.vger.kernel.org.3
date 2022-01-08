Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAF488488
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiAHQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:31:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:33380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbiAHQbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641659473; x=1673195473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j3fWbRXUi/kYwRK/t3Dnce1UbCwALle6DniDJcdVWBY=;
  b=JFgEY2GwwjPjkPNCodMmcZXPlklbqlzNiADsLufVmK6R+7AdqjJjzmz1
   /H+BO6Fuf6L2FWqs4aiu/7noWF3E9DFa6NZWTOXQVxIhFDVwX9ApOiyiA
   zk5i2kdaGsCsoWQSuruCiGu8EcWXBmK3RgRSeBF7JWcql9IU1TlUMr61D
   hpFm5cLtIhsc0MKGaLwVUStS5tzbiQK8dnWjiTdmvIxoNA5QM6TDfq/27
   8L4CxiNZKcWeWSfvSlS5lWwBG+VjISjeB85/IpKiDwp1/0WOZpb62bDnQ
   AKw71DqoVSF7uvah4P46BU9KuNUWh8zNJ89VqdT6Edsc3PHZNfsQCx+ro
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240575551"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240575551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 08:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="471625325"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 08:31:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6EcO-0000oH-5F; Sat, 08 Jan 2022 16:31:00 +0000
Date:   Sun, 9 Jan 2022 00:30:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1860/2375]
 arch/x86/entry/vsyscall/vsyscall_64.c:323:24: warning: no previous prototype
 for function 'get_gate_vma'
Message-ID: <202201090022.G97ulrJ2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: f09977356680cc3b264d9598e1eebf2c74258586 [1860/2375] headers/deps: mm: Optimize <linux/mm_api.h>, remove the <linux/mm_api_gate_area.h> header
config: x86_64-randconfig-r032-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090022.G97ulrJ2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f09977356680cc3b264d9598e1eebf2c74258586
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f09977356680cc3b264d9598e1eebf2c74258586
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vsyscall/vsyscall_64.c:323:24: warning: no previous prototype for function 'get_gate_vma' [-Wmissing-prototypes]
   struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
                          ^
   arch/x86/entry/vsyscall/vsyscall_64.c:323:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
   ^
   static 
>> arch/x86/entry/vsyscall/vsyscall_64.c:334:5: warning: no previous prototype for function 'in_gate_area' [-Wmissing-prototypes]
   int in_gate_area(struct mm_struct *mm, unsigned long addr)
       ^
   arch/x86/entry/vsyscall/vsyscall_64.c:334:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int in_gate_area(struct mm_struct *mm, unsigned long addr)
   ^
   static 
>> arch/x86/entry/vsyscall/vsyscall_64.c:349:5: warning: no previous prototype for function 'in_gate_area_no_mm' [-Wmissing-prototypes]
   int in_gate_area_no_mm(unsigned long addr)
       ^
   arch/x86/entry/vsyscall/vsyscall_64.c:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int in_gate_area_no_mm(unsigned long addr)
   ^
   static 
   3 warnings generated.


vim +/get_gate_vma +323 arch/x86/entry/vsyscall/vsyscall_64.c

b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  322  
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23 @323  struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  324  {
c338867d0e4224 arch/x86/entry/vsyscall/vsyscall_64.c Brian Gerst             2015-06-22  325  #ifdef CONFIG_COMPAT
ff170cd0595398 arch/x86/entry/vsyscall/vsyscall_64.c Gabriel Krisman Bertazi 2020-10-03  326  	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  327  		return NULL;
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  328  #endif
87983c66bc02c9 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-10-29  329  	if (vsyscall_mode == NONE)
87983c66bc02c9 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-10-29  330  		return NULL;
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  331  	return &gate_vma;
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  332  }
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  333  
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23 @334  int in_gate_area(struct mm_struct *mm, unsigned long addr)
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  335  {
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  336  	struct vm_area_struct *vma = get_gate_vma(mm);
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  337  
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  338  	if (!vma)
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  339  		return 0;
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  340  
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  341  	return (addr >= vma->vm_start) && (addr < vma->vm_end);
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  342  }
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  343  
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  344  /*
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  345   * Use this when you have no reliable mm, typically from interrupt
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  346   * context. It is less reliable than using a task's mm and may give
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  347   * false positives.
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  348   */
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23 @349  int in_gate_area_no_mm(unsigned long addr)
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  350  {
87983c66bc02c9 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-10-29  351  	return vsyscall_mode != NONE && (addr & PAGE_MASK) == VSYSCALL_ADDR;
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  352  }
b93590901a01a6 arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  353  

:::::: The code at line 323 was first introduced by commit
:::::: b93590901a01a6d036b3b7c856bcc5724fdb9911 x86_64/vsyscall: Move all of the gate_area code to vsyscall_64.c

:::::: TO: Andy Lutomirski <luto@amacapital.net>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
