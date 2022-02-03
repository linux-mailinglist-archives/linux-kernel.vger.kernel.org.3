Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AFD4A7F84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347075AbiBCGz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:55:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:36155 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbiBCGz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643871356; x=1675407356;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eyI2/R+yROaV0RHfck1nac7STRkahOPVD6wvBxM7ZBo=;
  b=oGrMXImeBi3EAod0Wtgin+22lBhF04RBSn8Bbj4T+T0kHXTrJA+Od+99
   89xRCh9Nv99uQToFrTgy/Fkvb2oVsEewpaelH3VX+JdWriRpU36qi9+WD
   fEVLn+6BF7STGWZFDDXDWGY94I2vkNMu5dKqjySXgvLRtK6uOUfSwLLYR
   Fc1dLB88Ff00evdvsoK0NDph3myj/9/DLS1ky+4jw/6o5fqM5inGpKReA
   WgjtZ0zKAu8OhD2CmtwFEQz+lrOe2SRJg2nxgiObu3KwUlysxDKawpxL4
   MAJNur1+mf4wtplkk3AItsIDPHxs2N9/297jRBgOjnKcrgPzu1qKdIpF9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228740302"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="228740302"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 22:55:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="523788602"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Feb 2022 22:55:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFW25-000Vm1-Ma; Thu, 03 Feb 2022 06:55:53 +0000
Date:   Thu, 3 Feb 2022 14:55:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mhiramat:kprobes/fprobe 7/10] arch/x86/kernel/rethook.c:14:23:
 warning: no previous prototype for function
 'arch_rethook_trampoline_callback'
Message-ID: <202202031451.vmQ3ciMx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/fprobe
head:   1f4f90c86628a76e7eac24ab732db49fc3a961d6
commit: 806149decce8b0870024d2676b46bb3d295c38b3 [7/10] fprobe: Add exit_handler support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202031451.vmQ3ciMx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=806149decce8b0870024d2676b46bb3d295c38b3
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat kprobes/fprobe
        git checkout 806149decce8b0870024d2676b46bb3d295c38b3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/rethook.c:14:23: warning: no previous prototype for function 'arch_rethook_trampoline_callback' [-Wmissing-prototypes]
   __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
                         ^
   arch/x86/kernel/rethook.c:14:18: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
                    ^
                    static 
   1 warning generated.


vim +/arch_rethook_trampoline_callback +14 arch/x86/kernel/rethook.c

9de3b995c35eb6 Masami Hiramatsu 2022-01-26  10  
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  11  /*
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  12   * Called from arch_rethook_trampoline
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  13   */
9de3b995c35eb6 Masami Hiramatsu 2022-01-26 @14  __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  15  {
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  16  	unsigned long *frame_pointer;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  17  
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  18  	/* fixup registers */
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  19  	regs->cs = __KERNEL_CS;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  20  #ifdef CONFIG_X86_32
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  21  	regs->gs = 0;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  22  #endif
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  23  	regs->ip = (unsigned long)&arch_rethook_trampoline;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  24  	regs->orig_ax = ~0UL;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  25  	regs->sp += sizeof(long);
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  26  	frame_pointer = &regs->sp + 1;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  27  
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  28  	/*
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  29  	 * The return address at 'frame_pointer' is recovered by the
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  30  	 * arch_rethook_fixup_return() which called from this
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  31  	 * rethook_trampoline_handler().
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  32  	 */
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  33  	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  34  
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  35  	/*
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  36  	 * Copy FLAGS to 'pt_regs::sp' so that arch_rethook_trapmoline()
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  37  	 * can do RET right after POPF.
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  38  	 */
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  39  	regs->sp = regs->flags;
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  40  }
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  41  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
9de3b995c35eb6 Masami Hiramatsu 2022-01-26  42  

:::::: The code at line 14 was first introduced by commit
:::::: 9de3b995c35eb68273cf462f30663340ee47f8d6 rethook: x86: Add rethook x86 implementation

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Masami Hiramatsu <mhiramat@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
