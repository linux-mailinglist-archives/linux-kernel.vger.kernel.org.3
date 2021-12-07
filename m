Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17B846B660
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhLGIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:52:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:47116 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhLGIwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:52:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217556789"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="217556789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 00:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611597255"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 00:48:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muW9a-000MMm-8u; Tue, 07 Dec 2021 08:48:50 +0000
Date:   Tue, 7 Dec 2021 16:48:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 15/15] vmlinux.o: warning: objtool:
 em_bsr_c()+0x18: relocation to !ENDBR: __UNIQUE_ID_nop591+0x0
Message-ID: <202112071601.k9Q3N3Mo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   45ad3360293b4e6b969ad4cf9511794319d6d662
commit: 45ad3360293b4e6b969ad4cf9511794319d6d662 [15/15] x86/Makefile: Frob IBT objtool pass
config: x86_64-randconfig-r003-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071601.k9Q3N3Mo-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=45ad3360293b4e6b969ad4cf9511794319d6d662
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 45ad3360293b4e6b969ad4cf9511794319d6d662
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: em_bsr_c()+0x18: relocation to !ENDBR: __UNIQUE_ID_nop591+0x0
>> vmlinux.o: warning: objtool: em_bsf_c()+0x18: relocation to !ENDBR: __UNIQUE_ID_nop590+0x0
>> vmlinux.o: warning: objtool: em_aad()+0x1d: relocation to !ENDBR: orb_al_dl+0x0
>> vmlinux.o: warning: objtool: em_imul_3op()+0xb: relocation to !ENDBR: __UNIQUE_ID_nop589+0x0
>> vmlinux.o: warning: objtool: em_das()+0x9f: relocation to !ENDBR: orb_al_dl+0x0
   vmlinux.o: warning: objtool: em_das()+0x4c: relocation to !ENDBR: orb_al_dl+0x0
>> vmlinux.o: warning: objtool: em_aam()+0x30: relocation to !ENDBR: orb_al_dl+0x0
>> vmlinux.o: warning: objtool: em_cmpxchg()+0x1d: relocation to !ENDBR: cmpb_al_dl+0x0
>> vmlinux.o: warning: objtool: em_loop()+0xa3: relocation to !ENDBR: seto+0x0
>> vmlinux.o: warning: objtool: x86_emulate_insn()+0xbb1: relocation to !ENDBR: seto+0x0
   vmlinux.o: warning: objtool: x86_emulate_insn()+0xb2e: relocation to !ENDBR: seto+0x0
   vmlinux.o: warning: objtool: x86_emulate_insn()+0xe01: relocation to !ENDBR: seto+0x0
   vmlinux.o: warning: objtool: x86_emulate_insn()+0x187: relocation to !ENDBR: seto+0x0
>> vmlinux.o: warning: objtool: patch_retpoline()+0xe: relocation to !ENDBR: .text.__x86.indirect_thunk+0x0
   vmlinux.o: warning: objtool: copy_thread()+0x46: relocation to !ENDBR: .text+0x14f0
   vmlinux.o: warning: objtool: syscall_init()+0x43: relocation to !ENDBR: .entry.text+0x1920
   vmlinux.o: warning: objtool: syscall_init()+0x109: relocation to !ENDBR: .entry.text+0x1920
   vmlinux.o: warning: objtool: init_transition_pgtable()+0x2: relocation to !ENDBR: .text+0xb3000
   vmlinux.o: warning: objtool: init_transition_pgtable.cold()+0x2: relocation to !ENDBR: .text+0xb3000
   vmlinux.o: warning: objtool: machine_kexec()+0x41: relocation to !ENDBR: .text+0xb3000
   vmlinux.o: warning: objtool: paravirt_patch()+0x15: relocation to !ENDBR: _paravirt_nop+0x0
   vmlinux.o: warning: objtool: __unwind_start()+0xe0: relocation to !ENDBR: .text+0x14f0
   vmlinux.o: warning: objtool: filter_irq_stacks()+0x20: relocation to !ENDBR: .entry.text+0x1490
   vmlinux.o: warning: objtool: init_real_mode()+0xf7: relocation to !ENDBR: .head.text+0x40
   vmlinux.o: warning: objtool: int3_exception_notify()+0x52: relocation to !ENDBR: int3_magic+0x0
   vmlinux.o: warning: objtool: vmware_platform_setup()+0x123: relocation to !ENDBR: _paravirt_nop+0x0
   vmlinux.o: warning: objtool: do_machine_check()+0x9d4: call to queue_task_work() leaves .noinstr.text section
   vmlinux.o: warning: objtool: .text+0xb311c: relocation to !ENDBR: .text+0xb3125
   vmlinux.o: warning: objtool: .head.text+0x80: relocation to !ENDBR: .head.text+0x89
   vmlinux.o: warning: objtool: .head.text+0xf4: relocation to !ENDBR: .head.text+0x107
   vmlinux.o: warning: objtool: .entry.text+0x16e6: relocation to !ENDBR: asm_load_gs_index+0x7
   vmlinux.o: warning: objtool: .entry.text+0x17e3: relocation to !ENDBR: .entry.text+0x1872
   vmlinux.o: warning: objtool: .entry.text+0x1836: relocation to !ENDBR: .entry.text+0x1872
   vmlinux.o: warning: objtool: .entry.text+0x186b: relocation to !ENDBR: .entry.text+0x1872
   vmlinux.o: warning: objtool: .entry.text+0x17f1: relocation to !ENDBR: .entry.text+0x1897

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
