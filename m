Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD040467347
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379203AbhLCIf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:35:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:31285 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244052AbhLCIf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:35:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="216958121"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="216958121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 00:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="460807244"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2021 00:32:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt3z7-000HHp-5x; Fri, 03 Dec 2021 08:32:01 +0000
Date:   Fri, 3 Dec 2021 16:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 15/15] vmlinux.o: warning: objtool:
 copy_thread()+0x3c: relocation to !ENDBR: .text+0x1760
Message-ID: <202112031602.fE432NFZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   80bc7f2a129848b0885cf214fda77f623ba2f5f9
commit: 80bc7f2a129848b0885cf214fda77f623ba2f5f9 [15/15] x86/Makefile: Frob IBT objtool pass
config: x86_64-randconfig-r003-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031602.fE432NFZ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=80bc7f2a129848b0885cf214fda77f623ba2f5f9
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 80bc7f2a129848b0885cf214fda77f623ba2f5f9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: copy_thread()+0x3c: relocation to !ENDBR: .text+0x1760
>> vmlinux.o: warning: objtool: syscall_init()+0x2e: relocation to !ENDBR: .entry.text+0x1790
   vmlinux.o: warning: objtool: syscall_init()+0xe7: relocation to !ENDBR: .entry.text+0x1790
>> vmlinux.o: warning: objtool: init_transition_pgtable()+0x7: relocation to !ENDBR: .text+0x54000
>> vmlinux.o: warning: objtool: init_transition_pgtable.cold()+0x2: relocation to !ENDBR: .text+0x54000
>> vmlinux.o: warning: objtool: machine_kexec()+0x41: relocation to !ENDBR: .text+0x54000
>> vmlinux.o: warning: objtool: __kretprobe_trampoline()+0x0: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: arch_prepare_kretprobe()+0x23: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: trampoline_handler()+0x20: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: paravirt_patch()+0x15: relocation to !ENDBR: _paravirt_nop+0x0
>> vmlinux.o: warning: objtool: unwind_next_frame()+0x478: relocation to !ENDBR: __kretprobe_trampoline+0x0
   vmlinux.o: warning: objtool: unwind_next_frame()+0x165: relocation to !ENDBR: __kretprobe_trampoline+0x0
   vmlinux.o: warning: objtool: unwind_next_frame()+0x31a: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: __unwind_start()+0xe0: relocation to !ENDBR: .text+0x1760
>> vmlinux.o: warning: objtool: filter_irq_stacks()+0x20: relocation to !ENDBR: .entry.text+0x1410
>> vmlinux.o: warning: objtool: __kretprobe_find_ret_addr()+0x43: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: kretprobe_find_ret_addr()+0x5c: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: __kretprobe_trampoline_handler()+0x50: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: trace_seq_print_sym()+0x97: relocation to !ENDBR: __kretprobe_trampoline+0x0
   vmlinux.o: warning: objtool: trace_seq_print_sym()+0x3a: relocation to !ENDBR: __kretprobe_trampoline+0x0
>> vmlinux.o: warning: objtool: override_function_with_return()+0xd: relocation to !ENDBR: just_return_func+0x0
>> vmlinux.o: warning: objtool: init_real_mode()+0x14e: relocation to !ENDBR: .head.text+0x40
>> vmlinux.o: warning: objtool: int3_exception_notify()+0x52: relocation to !ENDBR: int3_magic+0x0
>> vmlinux.o: warning: objtool: vmware_platform_setup()+0x171: relocation to !ENDBR: _paravirt_nop+0x0
   vmlinux.o: warning: objtool: .text+0x5411c: relocation to !ENDBR: .text+0x54125
   vmlinux.o: warning: objtool: .head.text+0x80: relocation to !ENDBR: .head.text+0x89
   vmlinux.o: warning: objtool: .head.text+0xf4: relocation to !ENDBR: .head.text+0x107
   vmlinux.o: warning: objtool: .entry.text+0x15b3: relocation to !ENDBR: asm_load_gs_index+0x7
   vmlinux.o: warning: objtool: .entry.text+0x168e: relocation to !ENDBR: .entry.text+0x171d
   vmlinux.o: warning: objtool: .entry.text+0x16e1: relocation to !ENDBR: .entry.text+0x171d
   vmlinux.o: warning: objtool: .entry.text+0x1716: relocation to !ENDBR: .entry.text+0x171d
   vmlinux.o: warning: objtool: .entry.text+0x169c: relocation to !ENDBR: .entry.text+0x1742
   vmlinux.o: warning: objtool: .text+0xc20: unreachable instruction

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
