Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299353B5AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiFBJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiFBJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:05:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF992A80E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654160719; x=1685696719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ilmt4Fm8s1QBR+6vnBRDQ+CLdtVCUOH9xxFb/70YhU8=;
  b=lfrhiKc/Mg2vJkYezXdYufbpnRXTWPvHtXQQ3BEAAGSDN/l1baboRO6C
   GNhdITGJmzLnUjbokejYrA70AFFqtlWjETMftfb4jEJ4YRr6dW8AP0oGh
   uluGzEnoZjZAPRKXrYwkx57WLUYlaYOWEQnK85AFlBtJxcFIRtYio+w8H
   9JzAQHaVlrPqI19QylfzBNPF5px32ne3Jj9pHXtNg4xqubXnsFyVKRwW1
   X3QlaMsPeZmrhJbLJyB5NCu9jbMNjMFREcKgN7WwgcJX9d7ASycB32u5D
   Ao0U73gIrrVR+vte1pxHaAK5gpgztLdyWfq1z4+7QiEMo6TUrdZNRddfs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263522301"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="263522301"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 02:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="824161601"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2022 02:05:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwglZ-0004th-0t;
        Thu, 02 Jun 2022 09:05:17 +0000
Date:   Thu, 2 Jun 2022 17:04:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.umcg 2/11] arch/x86/kernel/traps.c:1406:9:
 error: implicit declaration of function 'cond_local_irq_enable'; did you
 mean 'arch_local_irq_enable'?
Message-ID: <202206021753.rwgEkzAb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.umcg
head:   94cca2af15f72fefda55447b66fa685cbcad20bb
commit: b01fb2d35fa2e5a84dbec6816d87ad494d792e0b [2/11] entry,x86: Create common IRQ operations for exceptions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220602/202206021753.rwgEkzAb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b01fb2d35fa2e5a84dbec6816d87ad494d792e0b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.umcg
        git checkout b01fb2d35fa2e5a84dbec6816d87ad494d792e0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/traps.c: In function '__exc_virtualization_exception':
>> arch/x86/kernel/traps.c:1406:9: error: implicit declaration of function 'cond_local_irq_enable'; did you mean 'arch_local_irq_enable'? [-Werror=implicit-function-declaration]
    1406 |         cond_local_irq_enable(regs);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         arch_local_irq_enable
>> arch/x86/kernel/traps.c:1415:9: error: implicit declaration of function 'cond_local_irq_disable'; did you mean 'arch_local_irq_disable'? [-Werror=implicit-function-declaration]
    1415 |         cond_local_irq_disable(regs);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         arch_local_irq_disable
   cc1: some warnings being treated as errors


vim +1406 arch/x86/kernel/traps.c

9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1351  
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1352  /*
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1353   * Virtualization Exceptions (#VE) are delivered to TDX guests due to
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1354   * specific guest actions which may happen in either user space or the
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1355   * kernel:
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1356   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1357   *  * Specific instructions (WBINVD, for example)
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1358   *  * Specific MSR accesses
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1359   *  * Specific CPUID leaf accesses
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1360   *  * Access to specific guest physical addresses
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1361   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1362   * In the settings that Linux will run in, virtualization exceptions are
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1363   * never generated on accesses to normal, TD-private memory that has been
7dbde763162989 Kirill A. Shutemov 2022-04-06  1364   * accepted (by BIOS or with tdx_enc_status_changed()).
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1365   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1366   * Syscall entry code has a critical window where the kernel stack is not
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1367   * yet set up. Any exception in this window leads to hard to debug issues
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1368   * and can be exploited for privilege escalation. Exceptions in the NMI
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1369   * entry code also cause issues. Returning from the exception handler with
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1370   * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1371   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1372   * For these reasons, the kernel avoids #VEs during the syscall gap and
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1373   * the NMI entry code. Entry code paths do not access TD-shared memory,
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1374   * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1375   * that might generate #VE. VMM can remove memory from TD at any point,
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1376   * but access to unaccepted (or missing) private memory leads to VM
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1377   * termination, not to #VE.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1378   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1379   * Similarly to page faults and breakpoints, #VEs are allowed in NMI
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1380   * handlers once the kernel is ready to deal with nested NMIs.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1381   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1382   * During #VE delivery, all interrupts, including NMIs, are blocked until
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1383   * TDGETVEINFO is called. It prevents #VE nesting until the kernel reads
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1384   * the VE info.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1385   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1386   * If a guest kernel action which would normally cause a #VE occurs in
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1387   * the interrupt-disabled region before TDGETVEINFO, a #DF (fault
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1388   * exception) is delivered to the guest which will result in an oops.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1389   *
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1390   * The entry code has been audited carefully for following these expectations.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1391   * Changes in the entry code have to be audited for correctness vs. this
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1392   * aspect. Similarly to #PF, #VE in these places will expose kernel to
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1393   * privilege escalation or may lead to random crashes.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1394   */
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1395  DEFINE_IDTENTRY(exc_virtualization_exception)
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1396  {
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1397  	struct ve_info ve;
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1398  
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1399  	/*
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1400  	 * NMIs/Machine-checks/Interrupts will be in a disabled state
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1401  	 * till TDGETVEINFO TDCALL is executed. This ensures that VE
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1402  	 * info cannot be overwritten by a nested #VE.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1403  	 */
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1404  	tdx_get_ve_info(&ve);
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1405  
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06 @1406  	cond_local_irq_enable(regs);
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1407  
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1408  	/*
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1409  	 * If tdx_handle_virt_exception() could not process
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1410  	 * it successfully, treat it as #GP(0) and handle it.
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1411  	 */
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1412  	if (!tdx_handle_virt_exception(regs, &ve))
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1413  		ve_raise_fault(regs, 0);
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1414  
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06 @1415  	cond_local_irq_disable(regs);
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1416  }
9a22bf6debbf51 Kirill A. Shutemov 2022-04-06  1417  

:::::: The code at line 1406 was first introduced by commit
:::::: 9a22bf6debbf5169f750af53c7f86eb4e3cd6712 x86/traps: Add #VE support for TDX guest

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Dave Hansen <dave.hansen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
