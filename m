Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D72480C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhL1SfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:35:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:60616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233454AbhL1SfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640716523; x=1672252523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v4zzcfN7sQhyZT3co6CaedBCucOFAvbgEStNpCQ8DfM=;
  b=eB39+bvOKSbB2mbBtzmW90etsQYiWId1CcdLRbp4FVeq/aQ+IOSxZx/A
   hCML2GbSFVcNcmMqr6IZo57HnNYEZwIkUL4vwrTN1cDsHoMi12U69lrUK
   8WSYGT1uVSuKWkqVIzn9UHz28PYJsUwOiKetnbNGRNUkkR5EZKyTo/Pxv
   Ybofi4WkBG0niRHNOKlC67S/Uy8/1QN1ulvpX8YAGTWu9WR7Ps+MY+Pm2
   OBwkxG9ZjbqGNf/AbMiSavOMXKATwPV/EjEeNYw/jXUtNvDw5mpnHp32X
   PMmEE2BbJiCH9/1bMtncZ/MKaIta3J2MHla1RKuWe/nqnk2t/DWr/J/20
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241619382"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="241619382"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 10:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="523719644"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Dec 2021 10:35:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2HJh-0007w4-4d; Tue, 28 Dec 2021 18:35:21 +0000
Date:   Wed, 29 Dec 2021 02:34:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-5 1/2]
 arch/parisc/kernel/vdso32/sigtramp.S:13: Error: bad or irreducible absolute
 expression
Message-ID: <202112290200.ECEsaeNw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-5
head:   345322aa7eb8a94f47f17a7a2805378e9b74a6e7
commit: 31c51d49e3f587cdcdf22b313b5bbce80b31405f [1/2] add testing vDSO support (v5)
config: parisc-randconfig-r013-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290200.ECEsaeNw-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=31c51d49e3f587cdcdf22b313b5bbce80b31405f
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-5
        git checkout 31c51d49e3f587cdcdf22b313b5bbce80b31405f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
   arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>> arch/parisc/kernel/vdso32/sigtramp.S:13: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/sigtramp.S:13: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/sigtramp.S:15: Error: no such instruction: `ldi 0,%r25'
>> arch/parisc/kernel/vdso32/sigtramp.S:16: Error: no such instruction: `ldi 173,%r20'
>> arch/parisc/kernel/vdso32/sigtramp.S:17: Error: no such instruction: `be,l 0x100(%sr2,%r0),%sr0,%r31'
>> arch/parisc/kernel/vdso32/sigtramp.S:19: Error: no such instruction: `b,n 3f'
   arch/parisc/kernel/vdso32/sigtramp.S:21: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:22: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:23: Error: no such instruction: `be,l 0x100(%sr2,%r0),%sr0,%r31'
>> arch/parisc/kernel/vdso32/sigtramp.S:30: Error: no such instruction: `ldw 0(%sp),%r31'
>> arch/parisc/kernel/vdso32/sigtramp.S:33: Error: no such instruction: `be 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:34: Error: no such instruction: `ldi 0,%r20'
>> arch/parisc/kernel/vdso32/sigtramp.S:36: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   arch/parisc/kernel/vdso32/datapage.S: Assembler messages:
>> arch/parisc/kernel/vdso32/datapage.S:18: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/datapage.S:18: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/datapage.S:23: Error: no such instruction: `bl 1f,%r1'
>> arch/parisc/kernel/vdso32/datapage.S:24: Error: no such instruction: `depi 0,31,12,%r1'
>> arch/parisc/kernel/vdso32/datapage.S:25: Error: no such instruction: `bv %r0(%r2)'
>> arch/parisc/kernel/vdso32/datapage.S:26: Error: no such instruction: `ldw 0(%r1),%r28'
>> arch/parisc/kernel/vdso32/datapage.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/datapage.o] Error 1
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
>> arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible absolute expression
>> arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: junk at end of line, first unrecognized character is `:'
>> arch/parisc/kernel/vdso32/restart_syscall.S:25: Error: no such instruction: `ldw 0(%sp),%r31'
>> arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction: `be 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `ldi 0,%r20'
   arch/parisc/kernel/vdso32/restart_syscall.S:31: Error: .cfi_endproc without corresponding .cfi_startproc
   gcc: error: unrecognized command-line option '-mno-space-regs'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   gcc: error: unrecognized command-line option '-mdisable-fpregs'
   gcc: error: unrecognized command-line option '-mschedule=8000'
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   gcc: error: unrecognized command-line option '-mno-long-calls'
   gcc: error: unrecognized command-line option '-mlong-calls'
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:39: arch/parisc/kernel/vdso32/vdso32_generic.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:188: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +13 arch/parisc/kernel/vdso32/sigtramp.S

    10	
    11		.text
    12	
  > 13	ENTRY_CFI(__kernel_sigtramp_rt)
    14	
  > 15	0:	ldi	0, %r25			/* (in_syscall=0) */
  > 16		ldi	__NR_rt_sigreturn, %r20
  > 17		be,l	0x100(%sr2,%r0),%sr0,%r31
    18		nop
  > 19		b,n	3f
    20	
    21	1:	ldi	1, %r25			/* (in_syscall=1) */
    22		ldi	__NR_rt_sigreturn, %r20
    23		be,l	0x100(%sr2,%r0),%sr0,%r31
    24		nop
    25	
    26	3:	/* load return pointer */
    27	#if defined(__VDSO64__)
    28		ldd	0(%sp), %r31
    29	#elif defined(__VDSO32__)
  > 30		ldw	0(%sp), %r31
    31	#endif
    32	
  > 33		be	0x100(%sr2, %r0)
    34		ldi	__NR_restart_syscall, %r20
    35	
  > 36	ENDPROC_CFI(__kernel_sigtramp_rt)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
