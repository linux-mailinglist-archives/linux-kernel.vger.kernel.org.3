Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7442A4727A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhLMKD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:03:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:41565 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238231AbhLMJ6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639389520; x=1670925520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+/4xlnDNBl3s2ZjVJapL69WpuuVvP+heoZqnSWzE+Dk=;
  b=dZKkgW2Q8uNcCE3NtGdNo/ADZr16K3gCcSKLidc2MZg1AE9s6971itKC
   TOfivzk3dlEDhhZzakJibAF48nGJwZw3ItrKyDUWmRO8yl+KzSlKyNHWq
   awwHcH7Kyh66GspvOo3KIRShwp7otEtqcU50TcieWEIpD7MogNOcld7Sk
   XsgH6BkXtsZgUa07wh0rGVirbCjj4VttAWPH9CdK4EOJ0pyWobWIHwnwJ
   2s/R2DQb6AJKYk3jAJkSLgqDWNhP1fPBvwJUg7SdxhAUK1I7htd8ZQkJU
   kJjIJn0fK1tPf+qWm2lo6iDPEJRDAoHJQemH48kIrgwDmy+X5cMoSoxXu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="237435636"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="237435636"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 01:50:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="504839929"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 01:50:42 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwhyk-0006XI-0V; Mon, 13 Dec 2021 09:50:42 +0000
Date:   Mon, 13 Dec 2021 17:50:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-3-timefunctions 1/7]
 arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible
 absolute expression
Message-ID: <202112131748.2n6YKYLW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-3-timefunctions
head:   d5efc9bf61d8eeab6aa9e84ed00bc84229253238
commit: 1e4b26c042645773fa45cc09eb7cfe59917969e3 [1/7] initial vDSO implementation
config: parisc-randconfig-r012-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131748.2n6YKYLW-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=1e4b26c042645773fa45cc09eb7cfe59917969e3
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-3-timefunctions
        git checkout 1e4b26c042645773fa45cc09eb7cfe59917969e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:25: FORCE prerequisite is missing
   arch/parisc/kernel/vdso32/gettimeofday.S: Assembler messages:
   arch/parisc/kernel/vdso32/gettimeofday.S:18: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/gettimeofday.S:18: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/gettimeofday.S:23: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/gettimeofday.S:24: Error: no such instruction: `ldi __NR__gettimeofday,%r20'
   arch/parisc/kernel/vdso32/gettimeofday.S:46: Error: .cfi_endproc without corresponding .cfi_startproc
   arch/parisc/kernel/vdso32/gettimeofday.S:55: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/gettimeofday.S:55: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/gettimeofday.S:58: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/gettimeofday.S:59: Error: no such instruction: `ldi __NR__clock_gettime,%r20'
   arch/parisc/kernel/vdso32/gettimeofday.S:61: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:29: arch/parisc/kernel/vdso32/gettimeofday.o] Error 1
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
>> arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/restart_syscall.S:25: Error: no such instruction: `ldw 0(%sp),%r31'
>> arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction: `ble 0x100(%sr2,%r0)'
>> arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `ldi 0,%r20'
>> arch/parisc/kernel/vdso32/restart_syscall.S:31: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:33: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/restart_syscall.S:35: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:29: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   arch/parisc/kernel/vdso32/datapage.S: arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
   Assembler messages:
>> arch/parisc/kernel/vdso32/datapage.S:17: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/sigtramp.S:16: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/datapage.S:17: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/sigtramp.S:16: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/datapage.S:22: Error: no such instruction: `bl 1f,%r1'
>> arch/parisc/kernel/vdso32/datapage.S:23: Error: no such instruction: `depi 0,31,2,%r1'
   arch/parisc/kernel/vdso32/datapage.S:25: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/datapage.S:25: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/sigtramp.S:19: Error: no such instruction: `ldi 0,%r25'
>> arch/parisc/kernel/vdso32/sigtramp.S:20: Error: no such instruction: `ble 0x100(%sr2,%r0)'
>> arch/parisc/kernel/vdso32/sigtramp.S:21: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/datapage.S:28: Error: no such instruction: `bv %r0(%r2)'
   arch/parisc/kernel/vdso32/sigtramp.S:23: Error: no such instruction: `ldi 1,%r25'
>> arch/parisc/kernel/vdso32/datapage.S:29: Error: no such instruction: `ldw 0(%r1),%r28'
   arch/parisc/kernel/vdso32/sigtramp.S:24: Error: no such instruction: `ble 0x100(%sr2,%r0)'
>> arch/parisc/kernel/vdso32/datapage.S:31: Error: .cfi_endproc without corresponding .cfi_startproc
   arch/parisc/kernel/vdso32/sigtramp.S:25: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/sigtramp.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:29: arch/parisc/kernel/vdso32/datapage.o] Error 1
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:29: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:186: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +15 arch/parisc/kernel/vdso32/restart_syscall.S

    12	
    13		.text
    14	
  > 15	ENTRY_CFI(__kernel_restart_syscall)
    16		/*
    17		 * Setup a trampoline to restart the syscall
    18		 * with __NR_restart_syscall
    19		 */
    20	
    21		/* load return pointer */
    22	#if defined(__VDSO64__)
    23		ldd	0(%sp), %r31
    24	#elif defined(__VDSO32__)
  > 25		ldw	0(%sp), %r31
    26	#endif
    27	
  > 28		ble	0x100(%sr2, %r0)
  > 29		ldi	__NR_restart_syscall, %r20
    30	
  > 31		ldi	1, %r25			/* (in_syscall=1) */
    32		ble	0x100(%sr2, %r0)
    33		ldi	__NR_rt_sigreturn, %r20
    34	
  > 35	ENDPROC_CFI(__kernel_restart_syscall)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
