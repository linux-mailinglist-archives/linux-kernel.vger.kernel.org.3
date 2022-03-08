Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1304D22BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiCHUiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiCHUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:38:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28C50E32
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646771832; x=1678307832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D4X3cXuBQ2HH9+lZQvuVEh7PXl9rt0JwqMr/jESf57Y=;
  b=f4tGsUp6Gbk3GR93J5b1j1wxPea1hGh3fuU1JythtwxfZKzmkOIuu4Tt
   JsL+KDbH8Bdg/29TGzjLRFbaqUWB4T/Lm33hpzQaWM+XGvDrQqjxSUkzk
   wg3STwxZLdouU6/ptkxmGuri0K2nCfgwC7DC8CyWjfYDwGd2ddL5J3amx
   yteitzQ4MwS7/oTExg5Z1CiSK6lLywtOXpyLfT+dA6yozIW9VEBoG+Qax
   g1OT3zLaagrCH0YioqMMTqRdGLjRKvaxnjlerfsLHdDVYh0Z3AApK6eHJ
   TUikplwu72BV1WRmhPs5JKOCD7o5lFKAXBGsa6zWo18JcArkLEASEydI9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253637108"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253637108"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="596025403"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2022 12:36:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRgZR-0001wD-9N; Tue, 08 Mar 2022 20:36:37 +0000
Date:   Wed, 9 Mar 2022 04:36:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mhiramat:kprobes/fprobe 8/12] arch/x86/kernel/rethook.c:14:23:
 warning: no previous prototype for function
 'arch_rethook_trampoline_callback'
Message-ID: <202203090445.eMw6Gp37-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/fprobe
head:   0bd36e652ac2be74b19f414d0b20aaef6521ac82
commit: 23f61cf25dd4c1cf50adce7ebe0e2ae65bef5b78 [8/12] fprobe: Add exit_handler support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090445.eMw6Gp37-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 4e115b7d881136947c083e12f62010bc6b1d3f00)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=23f61cf25dd4c1cf50adce7ebe0e2ae65bef5b78
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat kprobes/fprobe
        git checkout 23f61cf25dd4c1cf50adce7ebe0e2ae65bef5b78
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

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

31ffbcef413de8 Masami Hiramatsu 2022-02-09  10  
31ffbcef413de8 Masami Hiramatsu 2022-02-09  11  /*
31ffbcef413de8 Masami Hiramatsu 2022-02-09  12   * Called from arch_rethook_trampoline
31ffbcef413de8 Masami Hiramatsu 2022-02-09  13   */
31ffbcef413de8 Masami Hiramatsu 2022-02-09 @14  __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
31ffbcef413de8 Masami Hiramatsu 2022-02-09  15  {
31ffbcef413de8 Masami Hiramatsu 2022-02-09  16  	unsigned long *frame_pointer;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  17  
31ffbcef413de8 Masami Hiramatsu 2022-02-09  18  	/* fixup registers */
31ffbcef413de8 Masami Hiramatsu 2022-02-09  19  	regs->cs = __KERNEL_CS;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  20  #ifdef CONFIG_X86_32
31ffbcef413de8 Masami Hiramatsu 2022-02-09  21  	regs->gs = 0;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  22  #endif
31ffbcef413de8 Masami Hiramatsu 2022-02-09  23  	regs->ip = (unsigned long)&arch_rethook_trampoline;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  24  	regs->orig_ax = ~0UL;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  25  	regs->sp += sizeof(long);
31ffbcef413de8 Masami Hiramatsu 2022-02-09  26  	frame_pointer = &regs->sp + 1;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  27  
31ffbcef413de8 Masami Hiramatsu 2022-02-09  28  	/*
31ffbcef413de8 Masami Hiramatsu 2022-02-09  29  	 * The return address at 'frame_pointer' is recovered by the
31ffbcef413de8 Masami Hiramatsu 2022-02-09  30  	 * arch_rethook_fixup_return() which called from this
31ffbcef413de8 Masami Hiramatsu 2022-02-09  31  	 * rethook_trampoline_handler().
31ffbcef413de8 Masami Hiramatsu 2022-02-09  32  	 */
31ffbcef413de8 Masami Hiramatsu 2022-02-09  33  	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
31ffbcef413de8 Masami Hiramatsu 2022-02-09  34  
31ffbcef413de8 Masami Hiramatsu 2022-02-09  35  	/*
31ffbcef413de8 Masami Hiramatsu 2022-02-09  36  	 * Copy FLAGS to 'pt_regs::sp' so that arch_rethook_trapmoline()
31ffbcef413de8 Masami Hiramatsu 2022-02-09  37  	 * can do RET right after POPF.
31ffbcef413de8 Masami Hiramatsu 2022-02-09  38  	 */
31ffbcef413de8 Masami Hiramatsu 2022-02-09  39  	regs->sp = regs->flags;
31ffbcef413de8 Masami Hiramatsu 2022-02-09  40  }
31ffbcef413de8 Masami Hiramatsu 2022-02-09  41  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
31ffbcef413de8 Masami Hiramatsu 2022-02-09  42  

:::::: The code at line 14 was first introduced by commit
:::::: 31ffbcef413de82a1b0afc177b5d85364495f0cd rethook: x86: Add rethook x86 implementation

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Masami Hiramatsu <mhiramat@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
