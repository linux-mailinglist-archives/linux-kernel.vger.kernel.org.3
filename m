Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EE548DDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiAMS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:27:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:63222 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbiAMS1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642098438; x=1673634438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xmMxOhuDgDR80zFi6/Sqos4w73CoL3keesfZU0Ro/DA=;
  b=eMLlfGikrgCYQUofNjc+GHCHCxxls2hPfc4lFd6LTeGnbBxZ9AjdOUt9
   N/6o0EgaPoObk28TWLQUMvTVqj0+am4vwCLyyjRrzGqwGymE151d9LaBx
   zXeTlsJp6aDHujcIcSXadVWlgftxrxXPQ2/W/0uqZtCBmcGGJUCrFNOmP
   toNsDQoXF/CF6qbzFiAVzMlZu1NEzhAkj61LdZzb9r1kf+2jFTF1/Rq60
   r0xgNjmMlPGkwOrCdygI6CCEF8b8oxleG7V1rReG59OztYzdRN921/ZJz
   xLTc9lVBRy7WvbDn5NiNiwdc2IfXcZmJYYVUqEKI6hGc3rxtvPLGQl+tf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224773433"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="224773433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="623951642"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2022 10:24:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n84mR-0007XE-3m; Thu, 13 Jan 2022 18:24:59 +0000
Date:   Fri, 14 Jan 2022 02:24:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1863/2382]
 arch/x86/entry/vsyscall/vsyscall_64.c:323:24: warning: no previous prototype
 for 'get_gate_vma'
Message-ID: <202201140224.O4rqby5c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 8c564323537ccfe86a2423a4b98a423ab2182c9e [1863/2382] headers/deps: mm: Optimize <linux/mm_api.h>, remove the <linux/mm_api_gate_area.h> header
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220114/202201140224.O4rqby5c-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8c564323537ccfe86a2423a4b98a423ab2182c9e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 8c564323537ccfe86a2423a4b98a423ab2182c9e
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
