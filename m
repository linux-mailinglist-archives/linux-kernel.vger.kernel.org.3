Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8676948126A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbhL2MEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:04:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:49656 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhL2MEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640779444; x=1672315444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hQaJLp8uFm1ljNZnHsRrYMj7qZnqJQjNTYeg7eToGPw=;
  b=R+MuQAPLpZFpC47Y1Fguno+OpP3uNKG3sZETe9egLKk6Nx9qNYTr6lzP
   eBHHoH4RkOA0ci8Tb0JgAQYd7MGdG8oOc+foxwgDV6n2a5jpdkGjYtqDv
   s9wxrVOKuWjLHrVQ/E+fRtCcU/3S/BkAwWPV1j7NMUPK3RLTGSg77utde
   VbPJF7J4pwzKqr/2PwELBWAUDmTsIDN5/K4t6FuSsmrDSIKpIL35iL7GA
   qS/o3jky5gDuXw55B21BJ4ZBIDJK64UlvFaSxUQ2EiuNyp7JTpl+VvQNb
   KTBnMdfBQeh0DKyXELePJFK5zV1wPoud+w2nkjwMrg9WwDG1d5+ygF4zd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="265745657"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="265745657"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 04:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="470327422"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 04:04:00 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2XgW-0008sw-3D; Wed, 29 Dec 2021 12:04:00 +0000
Date:   Wed, 29 Dec 2021 20:03:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-4 1/1]
 arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction:
 `ble 0x100(%sr2,%r0)'
Message-ID: <202112291925.2s8Los6m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-4
head:   e3fcbe26abfbb6cc1a99ebbdbeb5673f17141e7b
commit: e3fcbe26abfbb6cc1a99ebbdbeb5673f17141e7b [1/1] add testing vDSO support
config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/archive/20211229/202112291925.2s8Los6m-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=e3fcbe26abfbb6cc1a99ebbdbeb5673f17141e7b
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-4
        git checkout e3fcbe26abfbb6cc1a99ebbdbeb5673f17141e7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
   gcc: error: unrecognized command-line option '-mno-space-regs'
   gcc: error: unrecognized command-line option '-mdisable-fpregs'
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/restart_syscall.S:25: Error: no such instruction: `ldw 0(%sp),%r31'
>> arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `ldi 0,%r20'
   arch/parisc/kernel/vdso32/restart_syscall.S:31: Error: .cfi_endproc without corresponding .cfi_startproc
   gcc: error: unrecognized command-line option '-mschedule=8000'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
   arch/parisc/kernel/vdso32/datapage.S: Assembler messages:
   arch/parisc/kernel/vdso32/datapage.S:18: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/datapage.S:18: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/datapage.S:23: Error: no such instruction: `bl 1f,%r1'
   arch/parisc/kernel/vdso32/datapage.S:24: Error: no such instruction: `depi 0,31,12,%r1'
   arch/parisc/kernel/vdso32/datapage.S:25: Error: no such instruction: `bv %r0(%r2)'
   arch/parisc/kernel/vdso32/datapage.S:26: Error: no such instruction: `ldw 0(%r1),%r28'
   arch/parisc/kernel/vdso32/datapage.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/datapage.o] Error 1
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
   arch/parisc/kernel/vdso32/sigtramp.S:13: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/sigtramp.S:13: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/sigtramp.S:15: Error: no such instruction: `ldi 0,%r25'
>> arch/parisc/kernel/vdso32/sigtramp.S:16: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:17: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:19: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:20: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:21: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:23: Error: .cfi_endproc without corresponding .cfi_startproc
   gcc: error: unrecognized command-line option '-mno-long-calls'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   gcc: error: unrecognized command-line option '-mlong-calls'
   gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:39: arch/parisc/kernel/vdso32/vdso32_generic.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:186: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +28 arch/parisc/kernel/vdso32/restart_syscall.S

    27	
  > 28		ble	0x100(%sr2, %r0)
    29		ldi	__NR_restart_syscall, %r20
    30	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
