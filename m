Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3EC4DBD32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355507AbiCQCpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiCQCpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:45:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFC65E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647485073; x=1679021073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xcmTqJewBK1TOKX2Kt1rps3pYppbIlB3gYQ0u4Egax8=;
  b=Md0rAi2H7JjR4Ct86cCgFj3nqMQfY8obwZXGWU3w5/v9khtohC/pFlw6
   oCRYvZ2FcCI2rsewoyDf09ytAaxcFT8BBKjk7dF22Fs9cLx2Wtjs4CO1j
   W1yVH5u70V+9U3oLV5GbJLoBUP8K6lelf7iyCRIKKVCX/95zg5eIjVX5F
   7rsLJra3zjXvzkfUKlHKnE5kPWBhSJXEfItDHLxiiIiSl0xumxFsfaWiw
   UgEz+p9ke3eKvKI8Civ6F+sXRTwOjAW0qcciRXK4du9R+XQuYBqWzoOJm
   9DVgqOGmgAnVZPFPA8snsYMqwtW6j2+QVYulGaw5Sq9XcUyICYH8AkLLO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237373000"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237373000"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 19:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581144020"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 19:44:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUg7r-000DDJ-50; Thu, 17 Mar 2022 02:44:31 +0000
Date:   Thu, 17 Mar 2022 10:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1818/2335]
 arch/x86/entry/vsyscall/vsyscall_64.c:323:24: warning: no previous prototype
 for function 'get_gate_vma'
Message-ID: <202203171029.K0aYoh84-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 096bc34f1420485efd9a03c318ab7c44487eb8b4 [1818/2335] headers/deps: mm: Optimize <linux/mm_api.h>, remove the <linux/mm_api_gate_area.h> header
config: x86_64-randconfig-a011-20220314 (https://download.01.org/0day-ci/archive/20220317/202203171029.K0aYoh84-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=096bc34f1420485efd9a03c318ab7c44487eb8b4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 096bc34f1420485efd9a03c318ab7c44487eb8b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ kernel/trace/

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

b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  322  
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23 @323  struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  324  {
c338867d0e42247 arch/x86/entry/vsyscall/vsyscall_64.c Brian Gerst             2015-06-22  325  #ifdef CONFIG_COMPAT
ff170cd0595398a arch/x86/entry/vsyscall/vsyscall_64.c Gabriel Krisman Bertazi 2020-10-03  326  	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  327  		return NULL;
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  328  #endif
87983c66bc02c9c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-10-29  329  	if (vsyscall_mode == NONE)
87983c66bc02c9c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-10-29  330  		return NULL;
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  331  	return &gate_vma;
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  332  }
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  333  
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23 @334  int in_gate_area(struct mm_struct *mm, unsigned long addr)
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  335  {
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  336  	struct vm_area_struct *vma = get_gate_vma(mm);
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  337  
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  338  	if (!vma)
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  339  		return 0;
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  340  
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  341  	return (addr >= vma->vm_start) && (addr < vma->vm_end);
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  342  }
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  343  
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  344  /*
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  345   * Use this when you have no reliable mm, typically from interrupt
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  346   * context. It is less reliable than using a task's mm and may give
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  347   * false positives.
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  348   */
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23 @349  int in_gate_area_no_mm(unsigned long addr)
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  350  {
87983c66bc02c9c arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-10-29  351  	return vsyscall_mode != NONE && (addr & PAGE_MASK) == VSYSCALL_ADDR;
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  352  }
b93590901a01a6d arch/x86/kernel/vsyscall_64.c         Andy Lutomirski         2014-09-23  353  

:::::: The code at line 323 was first introduced by commit
:::::: b93590901a01a6d036b3b7c856bcc5724fdb9911 x86_64/vsyscall: Move all of the gate_area code to vsyscall_64.c

:::::: TO: Andy Lutomirski <luto@amacapital.net>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
