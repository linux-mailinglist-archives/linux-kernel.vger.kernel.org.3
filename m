Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5348D813
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiAMMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:36:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:47731 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbiAMMgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642077408; x=1673613408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dxeaPvLMQZuES5mWRWKns9k9FbKfdkFxWaE03snuP94=;
  b=ZX+imUZzW+4MHc8FMvTEOnuUn2wEAoNEZk2u8DOm6pT2VnwaGyMa1FXQ
   STyjqcaWc8s9TKp5+HylemKBNgxRzgzlouqAtXXyBbmBUh9Ak3f3uwSRC
   6F60PeN6e62IsW8M01ehVbpThSm9NRDow2oK9OLkF6xqtbTbFGmM6gHeS
   6JfWFJ2vl7XDWEVPPefn1FjGN8FPyC0XXlgzHFGuHhtXZI8JhjPCadQHK
   ilFU+rfk5JTafq2sn9imS98AZQFigy/UKDgq7l9f71gy8UNvUI81udthn
   CvOeFXcIpw0dpBsp4q8PMChdCsP6Ok8LohBgy0kR3FcM+ET13+Zf/qG9S
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330346487"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="330346487"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 04:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="763247855"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2022 04:36:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7zLR-0007Bg-Uv; Thu, 13 Jan 2022 12:36:45 +0000
Date:   Thu, 13 Jan 2022 20:36:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 9986/9999] arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no
 previous prototype for '__x64_sys_process_mrelease'
Message-ID: <202201132036.zLX4pFMK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   87a74496ed4a51378b6b01606639d71113b040e5
commit: fe50dcab7ae21c88bdde199e04978903b3ebff4d [9986/9999] UPSTREAM: mm: wire up syscall process_mrelease
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220113/202201132036.zLX4pFMK-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/fe50dcab7ae21c88bdde199e04978903b3ebff4d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout fe50dcab7ae21c88bdde199e04978903b3ebff4d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:279:1: note: in expansion of macro 'COND_SYSCALL'
     279 | COND_SYSCALL(mlockall);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_munlockall' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:280:1: note: in expansion of macro 'COND_SYSCALL'
     280 | COND_SYSCALL(munlockall);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_munlockall' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:280:1: note: in expansion of macro 'COND_SYSCALL'
     280 | COND_SYSCALL(munlockall);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_mincore' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:281:1: note: in expansion of macro 'COND_SYSCALL'
     281 | COND_SYSCALL(mincore);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_mincore' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:281:1: note: in expansion of macro 'COND_SYSCALL'
     281 | COND_SYSCALL(mincore);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_madvise' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:282:1: note: in expansion of macro 'COND_SYSCALL'
     282 | COND_SYSCALL(madvise);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_madvise' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:282:1: note: in expansion of macro 'COND_SYSCALL'
     282 | COND_SYSCALL(madvise);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_process_madvise' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:283:1: note: in expansion of macro 'COND_SYSCALL'
     283 | COND_SYSCALL(process_madvise);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_process_madvise' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:283:1: note: in expansion of macro 'COND_SYSCALL'
     283 | COND_SYSCALL(process_madvise);
         | ^~~~~~~~~~~~
>> arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_process_mrelease' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:284:1: note: in expansion of macro 'COND_SYSCALL'
     284 | COND_SYSCALL(process_mrelease);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_process_mrelease' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:284:1: note: in expansion of macro 'COND_SYSCALL'
     284 | COND_SYSCALL(process_mrelease);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_remap_file_pages' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:285:1: note: in expansion of macro 'COND_SYSCALL'
     285 | COND_SYSCALL(remap_file_pages);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_remap_file_pages' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:285:1: note: in expansion of macro 'COND_SYSCALL'
     285 | COND_SYSCALL(remap_file_pages);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_mbind' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
     256 |  __X64_COND_SYSCALL(name)     \
         |  ^~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:286:1: note: in expansion of macro 'COND_SYSCALL'
     286 | COND_SYSCALL(mbind);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_mbind' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
     120 |  __COND_SYSCALL(ia32, sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
     257 |  __IA32_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:286:1: note: in expansion of macro 'COND_SYSCALL'
     286 | COND_SYSCALL(mbind);
         | ^~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_compat_sys_mbind' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:148:2: note: in expansion of macro '__COND_SYSCALL'
     148 |  __COND_SYSCALL(ia32, compat_sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:218:2: note: in expansion of macro '__IA32_COMPAT_COND_SYSCALL'
     218 |  __IA32_COMPAT_COND_SYSCALL(name)    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:287:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
     287 | COND_SYSCALL_COMPAT(mbind);
         | ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x32_compat_sys_mbind' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:175:2: note: in expansion of macro '__COND_SYSCALL'
     175 |  __COND_SYSCALL(x32, compat_sys_##name)
         |  ^~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:219:2: note: in expansion of macro '__X32_COMPAT_COND_SYSCALL'
     219 |  __X32_COMPAT_COND_SYSCALL(name)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sys_ni.c:287:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
     287 | COND_SYSCALL_COMPAT(mbind);
         | ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_get_mempolicy' [-Wmissing-prototypes]
      83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
     100 |  __COND_SYSCALL(x64, sys_##name)


vim +/__x64_sys_process_mrelease +83 arch/x86/include/asm/syscall_wrapper.h

cc42c045af1ff4 Brian Gerst       2020-03-13  13  
25c619e59b395a Brian Gerst       2020-03-13  14  /*
25c619e59b395a Brian Gerst       2020-03-13  15   * Instead of the generic __SYSCALL_DEFINEx() definition, the x86 version takes
25c619e59b395a Brian Gerst       2020-03-13  16   * struct pt_regs *regs as the only argument of the syscall stub(s) named as:
25c619e59b395a Brian Gerst       2020-03-13  17   * __x64_sys_*()         - 64-bit native syscall
25c619e59b395a Brian Gerst       2020-03-13  18   * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
25c619e59b395a Brian Gerst       2020-03-13  19   * __ia32_compat_sys_*() - 32-bit compat syscall
25c619e59b395a Brian Gerst       2020-03-13  20   * __x32_compat_sys_*()  - 64-bit X32 compat syscall
25c619e59b395a Brian Gerst       2020-03-13  21   *
25c619e59b395a Brian Gerst       2020-03-13  22   * The registers are decoded according to the ABI:
25c619e59b395a Brian Gerst       2020-03-13  23   * 64-bit: RDI, RSI, RDX, R10, R8, R9
25c619e59b395a Brian Gerst       2020-03-13  24   * 32-bit: EBX, ECX, EDX, ESI, EDI, EBP
25c619e59b395a Brian Gerst       2020-03-13  25   *
25c619e59b395a Brian Gerst       2020-03-13  26   * The stub then passes the decoded arguments to the __se_sys_*() wrapper to
25c619e59b395a Brian Gerst       2020-03-13  27   * perform sign-extension (omitted for zero-argument syscalls).  Finally the
25c619e59b395a Brian Gerst       2020-03-13  28   * arguments are passed to the __do_sys_*() function which is the actual
25c619e59b395a Brian Gerst       2020-03-13  29   * syscall.  These wrappers are marked as inline so the compiler can optimize
25c619e59b395a Brian Gerst       2020-03-13  30   * the functions where appropriate.
25c619e59b395a Brian Gerst       2020-03-13  31   *
25c619e59b395a Brian Gerst       2020-03-13  32   * Example assembly (slightly re-ordered for better readability):
25c619e59b395a Brian Gerst       2020-03-13  33   *
25c619e59b395a Brian Gerst       2020-03-13  34   * <__x64_sys_recv>:		<-- syscall with 4 parameters
25c619e59b395a Brian Gerst       2020-03-13  35   *	callq	<__fentry__>
25c619e59b395a Brian Gerst       2020-03-13  36   *
25c619e59b395a Brian Gerst       2020-03-13  37   *	mov	0x70(%rdi),%rdi	<-- decode regs->di
25c619e59b395a Brian Gerst       2020-03-13  38   *	mov	0x68(%rdi),%rsi	<-- decode regs->si
25c619e59b395a Brian Gerst       2020-03-13  39   *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
25c619e59b395a Brian Gerst       2020-03-13  40   *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
25c619e59b395a Brian Gerst       2020-03-13  41   *
25c619e59b395a Brian Gerst       2020-03-13  42   *	xor	%r9d,%r9d	<-- clear %r9
25c619e59b395a Brian Gerst       2020-03-13  43   *	xor	%r8d,%r8d	<-- clear %r8
25c619e59b395a Brian Gerst       2020-03-13  44   *
25c619e59b395a Brian Gerst       2020-03-13  45   *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
25c619e59b395a Brian Gerst       2020-03-13  46   *				    which takes 6 arguments
25c619e59b395a Brian Gerst       2020-03-13  47   *
25c619e59b395a Brian Gerst       2020-03-13  48   *	cltq			<-- extend return value to 64-bit
25c619e59b395a Brian Gerst       2020-03-13  49   *	retq			<-- return
25c619e59b395a Brian Gerst       2020-03-13  50   *
25c619e59b395a Brian Gerst       2020-03-13  51   * This approach avoids leaking random user-provided register content down
25c619e59b395a Brian Gerst       2020-03-13  52   * the call chain.
25c619e59b395a Brian Gerst       2020-03-13  53   */
25c619e59b395a Brian Gerst       2020-03-13  54  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  55  /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  56  #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  57  	__MAP(x,__SC_ARGS						\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  58  		,,regs->di,,regs->si,,regs->dx				\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  59  		,,regs->r10,,regs->r8,,regs->r9)			\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  60  
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  61  /* Mapping of registers to parameters for syscalls on i386 */
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  62  #define SC_IA32_REGS_TO_ARGS(x, ...)					\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  63  	__MAP(x,__SC_ARGS						\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  64  	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  65  	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  66  	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
ebeb8c82ffaf94 Dominik Brodowski 2018-04-05  67  
d2b5de495ee983 Brian Gerst       2020-03-13  68  #define __SYS_STUB0(abi, name)						\
0f78ff17112d8b Brian Gerst       2020-03-13  69  	long __##abi##_##name(const struct pt_regs *regs);		\
d2b5de495ee983 Brian Gerst       2020-03-13  70  	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
0f78ff17112d8b Brian Gerst       2020-03-13  71  	long __##abi##_##name(const struct pt_regs *regs)		\
d2b5de495ee983 Brian Gerst       2020-03-13  72  		__alias(__do_##name);
d2b5de495ee983 Brian Gerst       2020-03-13  73  
4399e0cf494f73 Brian Gerst       2020-03-13  74  #define __SYS_STUBx(abi, name, ...)					\
0f78ff17112d8b Brian Gerst       2020-03-13  75  	long __##abi##_##name(const struct pt_regs *regs);		\
4399e0cf494f73 Brian Gerst       2020-03-13  76  	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
0f78ff17112d8b Brian Gerst       2020-03-13  77  	long __##abi##_##name(const struct pt_regs *regs)		\
4399e0cf494f73 Brian Gerst       2020-03-13  78  	{								\
4399e0cf494f73 Brian Gerst       2020-03-13  79  		return __se_##name(__VA_ARGS__);			\
4399e0cf494f73 Brian Gerst       2020-03-13  80  	}
4399e0cf494f73 Brian Gerst       2020-03-13  81  
6cc8d2b286d9e7 Brian Gerst       2020-03-13  82  #define __COND_SYSCALL(abi, name)					\
0f78ff17112d8b Brian Gerst       2020-03-13 @83  	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
6cc8d2b286d9e7 Brian Gerst       2020-03-13  84  	{								\
6cc8d2b286d9e7 Brian Gerst       2020-03-13  85  		return sys_ni_syscall();				\
6cc8d2b286d9e7 Brian Gerst       2020-03-13  86  	}
6cc8d2b286d9e7 Brian Gerst       2020-03-13  87  

:::::: The code at line 83 was first introduced by commit
:::::: 0f78ff17112d8b3469b805ff4ea9780cc1e5c93b x86/entry: Drop asmlinkage from syscalls

:::::: TO: Brian Gerst <brgerst@gmail.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
