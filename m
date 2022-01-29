Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FE4A2B70
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiA2DcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:32:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:48301 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241053AbiA2DcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643427143; x=1674963143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mhdD5HHyqMlNNSG85ksnNtIQQC+USBb6A+/glwu7chk=;
  b=V79gBByfJUkkAvVh8daHf7liuoVeSPh0zRqgnzBGH8nIpHDb9RheZdA/
   Sb631XP2QdJuUHSxvstT1ZSm2i3O8Sp+xF752us2kGuM6p7vyXRtdWYNy
   G1Gzmuhdy+oMaeKOH0QKRoToaU2JQUc2xZj5PlM39gj/dKHPTv6jLkF/l
   XAXyQ3yDv2XW2wyao92XSjUbdUNKhXrpK0Uab0pZJUJPE2TOXgdX55+PV
   cOWXuOtbLSn7ztqdClCsDvLJa4TO3vL1yUD/8eydu/j3y/cKVgSCixiXL
   Q1SgaGbnUwk566A0U2kyv3Ky2WMrfhMzOXke+iKc0qixYtjnV9QnP1yBn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="333591604"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="333591604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 19:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="480946584"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2022 19:32:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDeTM-000OhY-JE; Sat, 29 Jan 2022 03:32:20 +0000
Date:   Sat, 29 Jan 2022 11:31:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 16/26]
 arch/arm64/kvm/mmu.c:517:13: warning: no previous prototype for
 'kvm_hyp_debug_uart_set_basep'
Message-ID: <202201291152.MDHD6psp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   b38f2df95cbf61e70bc32017da5318d1cb03e3e3
commit: ed0901f32dbd42aab0cd95a848ea943273062b2f [16/26] [DONOTMERGE] KVM: arm64: Add debug UART hacks at EL2
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201291152.MDHD6psp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=ed0901f32dbd42aab0cd95a848ea943273062b2f
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout ed0901f32dbd42aab0cd95a848ea943273062b2f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/mmu.c:517:13: warning: no previous prototype for 'kvm_hyp_debug_uart_set_basep' [-Wmissing-prototypes]
     517 | void __init kvm_hyp_debug_uart_set_basep(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/kvm_host.h:28,
                    from include/linux/kvm_host.h:43,
                    from arch/arm64/kvm/mmu.c:8:
   arch/arm64/kvm/mmu.c: In function 'kvm_hyp_debug_uart_set_basep':
>> arch/arm64/include/asm/kvm_asm.h:183:29: warning: initialization of 'void *' from 'long unsigned int' makes pointer from integer without a cast [-Wint-conversion]
     183 |                 void *val = (ptr);                                      \
         |                             ^
   arch/arm64/kvm/mmu.c:522:25: note: in expansion of macro 'kvm_ksym_ref'
     522 |         u64 addr = (u64)kvm_ksym_ref(arm64_kvm_hyp_debug_uart_addr);
         |                         ^~~~~~~~~~~~
   arch/arm64/include/asm/kvm_asm.h:183:29: note: (near initialization for 'addr')
     183 |                 void *val = (ptr);                                      \
         |                             ^
   arch/arm64/kvm/mmu.c:522:25: note: in expansion of macro 'kvm_ksym_ref'
     522 |         u64 addr = (u64)kvm_ksym_ref(arm64_kvm_hyp_debug_uart_addr);
         |                         ^~~~~~~~~~~~


vim +/kvm_hyp_debug_uart_set_basep +517 arch/arm64/kvm/mmu.c

   516	
 > 517	void __init kvm_hyp_debug_uart_set_basep(struct alt_instr *alt,
   518						 __le32 *origptr, __le32 *updptr,
   519						 int nr_inst)
   520	{
   521		int i;
   522		u64 addr = (u64)kvm_ksym_ref(arm64_kvm_hyp_debug_uart_addr);
   523	
   524		BUG_ON(nr_inst != 4);
   525	
   526		for (i = 0; i < 4; ++i) {
   527			u32 insn = le32_to_cpu(origptr[i]);
   528	
   529			insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16,
   530							     insn,
   531							     addr & 0xffff);
   532			BUG_ON(insn == AARCH64_BREAK_FAULT);
   533			updptr[i] = cpu_to_le32(insn);
   534			addr >>= 16;
   535		}
   536	}
   537	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
