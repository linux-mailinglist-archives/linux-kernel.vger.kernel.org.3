Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA09488426
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiAHPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:10:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:47642 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233385AbiAHPJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641654599; x=1673190599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CJilAerfRZhcXXnt1yg6f6koWah7zPu52nlLgcvI9gU=;
  b=VBZJTLvjPPMzlKcNl3HQwprpfIQAxsekUHpFa+bv9XsGUTNoXSeMaeE1
   ZbJh26x972r+lRkRSVauXhWow2YKrjOCP6UTzxqfVvFq0PVxJWOYR8hG5
   OXGeBUxTcMBu1H7r6KQW9goy3F+9a/Dzr80fNAXMM+itw9cyPhl4wZaAu
   DLvcklkaeg3uE3nbi3MEdxMg9GXs5ee2dqdJonFA8StS3rBQilYHv6+52
   i1p0aWjeGOUtqhrIsvEeJjpMv/xFaidCO2NTsRu1IAMu5JccbJrXJKj9G
   TpkiNa5hxECAmsqrjlGNVhmfxg4qqQuTuxTKxLdQOnEJJcFV69pQCunSw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240569968"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240569968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 07:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="557557729"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2022 07:09:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6DLx-0000j2-JU; Sat, 08 Jan 2022 15:09:57 +0000
Date:   Sat, 8 Jan 2022 23:09:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1860/2375]
 arch/x86/entry/vsyscall/vsyscall_64.c:323:24: warning: no previous prototype
 for 'get_gate_vma'
Message-ID: <202201082310.slydQa2F-lkp@intel.com>
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
config: x86_64-randconfig-a012-20220108 (https://download.01.org/0day-ci/archive/20220108/202201082310.slydQa2F-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f09977356680cc3b264d9598e1eebf2c74258586
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f09977356680cc3b264d9598e1eebf2c74258586
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vsyscall/vsyscall_64.c:323:24: warning: no previous prototype for 'get_gate_vma' [-Wmissing-prototypes]
     323 | struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
         |                        ^~~~~~~~~~~~
>> arch/x86/entry/vsyscall/vsyscall_64.c:334:5: warning: no previous prototype for 'in_gate_area' [-Wmissing-prototypes]
     334 | int in_gate_area(struct mm_struct *mm, unsigned long addr)
         |     ^~~~~~~~~~~~
>> arch/x86/entry/vsyscall/vsyscall_64.c:349:5: warning: no previous prototype for 'in_gate_area_no_mm' [-Wmissing-prototypes]
     349 | int in_gate_area_no_mm(unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~


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
