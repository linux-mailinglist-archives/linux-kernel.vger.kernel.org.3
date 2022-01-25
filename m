Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2149B628
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579097AbiAYOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:23:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:43510 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578293AbiAYOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643120351; x=1674656351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DMZZx473hyKFpxi3QimRs+k6IFab7cQhZ8H/zL3DsAc=;
  b=JpMisOynFx7AEY9xEhiVhC7V+MKDZIrwg6wqkDm7WiLEzMUq0txgus0z
   ZRRGCwENPdax9sTpkOP3+Tw+gfEgPPH5nLuXJpyci6u45SUAiPZCnYC06
   ccUSBwRJGng1jLGgs3ubupwiraLMR53BLQbWquuHCvUO8e4Cz8AXC7lVT
   WA8Un5AGlDKyQAGGON5My5WheEObUP/tttXw6GNG0I98dqnxXWsObLPci
   55eK4UQjIq4Udo8igf0sgAX/87fqc40rzEZUq57mGA0lGsGh66ky/gnd8
   PmAqqpR2M+HzHK5yJmUsJ2we8Mm2nkuAhi1NS4tH8ZUXb/8Ftn3Cq5lCU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246251944"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246251944"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:13:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479503846"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 06:12:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCMZ8-000Jzn-9h; Tue, 25 Jan 2022 14:12:58 +0000
Date:   Tue, 25 Jan 2022 22:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9998/9999] arch/x86/entry/entry_32.S:52:2: warning: DWARF2 only supports one
 section per compilation unit
Message-ID: <202201252238.tTDAQpum-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   e48efff5cb5fd63a687465347bdbb52ef98dad44
commit: ffff118fe157b534c3244f8b300e655231dbd95c [9998/9999] BACKPORT: scripts/Makefile.clang: default to LLVM_IAS=1
config: i386-randconfig-r025-20220124 (https://download.01.org/0day-ci/archive/20220125/202201252238.tTDAQpum-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ffff118fe157b534c3244f8b300e655231dbd95c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout ffff118fe157b534c3244f8b300e655231dbd95c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/entry_32.S:52:2: warning: DWARF2 only supports one section per compilation unit
    .section .entry.text, "ax"
    ^
>> <instantiation>:11:2: warning: DWARF2 only supports one section per compilation unit
    .pushsection .altinstr_replacement,"ax"
    ^
   <instantiation>:1:1: note: while in macro instantiation
   ALTERNATIVE "jmp .Lend_25", "", ( 7*32+11)
   ^
   <instantiation>:4:2: note: while in macro instantiation
    SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
    ^
   <instantiation>:33:2: note: while in macro instantiation
    SWITCH_TO_KERNEL_STACK
    ^
   <instantiation>:4:2: note: while in macro instantiation
    SAVE_ALL switch_stacks=1
    ^
   arch/x86/include/asm/idtentry.h:626:1: note: while in macro instantiation
   idtentry_irq 0xFFFF common_interrupt;
   ^
   arch/x86/entry/entry_32.S:1010:1: warning: DWARF2 only supports one section per compilation unit
   .pushsection .fixup, "ax"
   ^
--
>> arch/x86/kernel/head_32.S:66:1: warning: DWARF2 only supports one section per compilation unit
   .section ".head.text","ax"
   ^
   arch/x86/kernel/head_32.S:340:1: warning: DWARF2 only supports one section per compilation unit
   .section ".init.text","ax"
   ^
--
>> <instantiation>:11:2: warning: DWARF2 only supports one section per compilation unit
    .pushsection .altinstr_replacement,"ax"
    ^
   arch/x86/entry/vdso/vdso32/system_call.S:60:2: note: while in macro instantiation
    ALTERNATIVE "", "movl %esp, %ebp; sysenter", ( 0*32+11)
    ^


vim +52 arch/x86/entry/entry_32.S

afaef01c001537 arch/x86/entry/entry_32.S  Alexander Popov 2018-08-17  51  
ea7145477a461e arch/x86/kernel/entry_32.S Jiri Olsa       2011-03-07 @52  	.section .entry.text, "ax"
ea7145477a461e arch/x86/kernel/entry_32.S Jiri Olsa       2011-03-07  53  

:::::: The code at line 52 was first introduced by commit
:::::: ea7145477a461e09d8d194cac4b996dc4f449107 x86: Separate out entry text section

:::::: TO: Jiri Olsa <jolsa@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
