Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3A6472A23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhLMKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:32:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:60373 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241236AbhLMKb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639391517; x=1670927517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/bresTOG99ijwwXpFOUmK7KcLKJVfaL4ajFyHRcfS2U=;
  b=ALzgFWoPlqnxAYSd9Yj4ktRMifi2ZWxAfiZS3JkmzJZJomOXAUHmJNvQ
   5BsjwKpWYbnAEB+dOV+chAZWrQS02UzjNaKToISuyQRPdAkiud+P0x6b6
   aIYp561oilYnMitbxNYlznLk0664Pvw3vVvK81tEwIstcu6srpWoqdzS6
   vpR9YslRhhcP+ENMDZVqt18zVSDBR0k3JflZXT5qgiU8AWF23r4tIXhrE
   I0F/VvwKvap33n7sztoHNvSk/6kM3HgBlXiYnoyk2OhNgFDMugbz+OTc2
   wnGDYS/BtLFMC8HLKLbnQ5+vjrEiQ5iK436jXU9Qgz2Tv2ujMXwKQ5Yz2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="225566644"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="225566644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="517693382"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2021 02:31:43 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwicQ-0006Z0-I5; Mon, 13 Dec 2021 10:31:42 +0000
Date:   Mon, 13 Dec 2021 18:30:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-3-timefunctions 7/7] gcc: error:
 unrecognized command-line option '-mno-space-regs'
Message-ID: <202112131813.XDWpo2SE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-3-timefunctions
head:   d5efc9bf61d8eeab6aa9e84ed00bc84229253238
commit: d5efc9bf61d8eeab6aa9e84ed00bc84229253238 [7/7] parisc: Implement time functions in vDSO
config: parisc-randconfig-r012-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131813.XDWpo2SE-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=d5efc9bf61d8eeab6aa9e84ed00bc84229253238
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-3-timefunctions
        git checkout d5efc9bf61d8eeab6aa9e84ed00bc84229253238
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>> gcc: error: unrecognized command-line option '-mno-space-regs'
   arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/restart_syscall.S:15: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/restart_syscall.S:25: Error: no such instruction: `ldw 0(%sp),%r31'
   arch/parisc/kernel/vdso32/restart_syscall.S:28: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `ldi 0,%r20'
   arch/parisc/kernel/vdso32/restart_syscall.S:31: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/restart_syscall.S:33: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/restart_syscall.S:35: Error: .cfi_endproc without corresponding .cfi_startproc
>> gcc: error: unrecognized command-line option '-mdisable-fpregs'
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
>> gcc: error: unrecognized command-line option '-mschedule=8000'
   arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
   arch/parisc/kernel/vdso32/sigtramp.S:16: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/sigtramp.S:16: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/sigtramp.S:19: Error: no such instruction: `ldi 0,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:20: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:21: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:23: Error: no such instruction: `ldi 1,%r25'
   arch/parisc/kernel/vdso32/sigtramp.S:24: Error: no such instruction: `ble 0x100(%sr2,%r0)'
   arch/parisc/kernel/vdso32/sigtramp.S:25: Error: no such instruction: `ldi 173,%r20'
   arch/parisc/kernel/vdso32/sigtramp.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   arch/parisc/kernel/vdso32/datapage.S: Assembler messages:
   arch/parisc/kernel/vdso32/datapage.S:18: Error: bad or irreducible absolute expression
   arch/parisc/kernel/vdso32/datapage.S:18: Error: junk at end of line, first unrecognized character is `:'
   arch/parisc/kernel/vdso32/datapage.S:23: Error: no such instruction: `bl 1f,%r1'
   arch/parisc/kernel/vdso32/datapage.S:24: Error: no such instruction: `depi 0,31,12,%r1'
   arch/parisc/kernel/vdso32/datapage.S:25: Error: no such instruction: `bv %r0(%r2)'
   arch/parisc/kernel/vdso32/datapage.S:26: Error: no such instruction: `ldw 0(%r1),%r28'
   arch/parisc/kernel/vdso32/datapage.S:28: Error: .cfi_endproc without corresponding .cfi_startproc
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:36: arch/parisc/kernel/vdso32/datapage.o] Error 1
>> gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
>> gcc: error: unrecognized command-line option '-mno-long-calls'
>> gcc: error: unrecognized command-line option '-mlong-calls'
>> gcc: error: unrecognized command-line option '-mno-fast-indirect-calls'; did you mean '-mno-force-indirect-call'?
   make[2]: *** [arch/parisc/kernel/vdso32/Makefile:39: arch/parisc/kernel/vdso32/vdso32_generic.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/parisc/Makefile:186: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
