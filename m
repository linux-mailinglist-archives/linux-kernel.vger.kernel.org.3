Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A12574ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbiGNNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiGNNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:15:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE65072D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657804520; x=1689340520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QQjS//iBPfYrLcrK7gc8rM18OwgKqFp6qRHJtrlCYdY=;
  b=UJV2zno9nhyaiPQ+Ws6Jykh5SkyBD/QcdRJ3HZw07JxtaB6Q1FBEBdMn
   TIcIpW/HBdoj2wDQlMNHrGcSqqKKr/FehiB5wimTyXBvVnBIglk5a9Xxc
   6EWaFFjcY39NYZexxQcvnJsssXN/bP7dAtKtqRexPxlSlXvPl3H65tZzP
   PKgl3+dWqcCMdJS82VFUhMi/VUj9T5N9CedPCX4OqBc+qG+RjSS+IefMz
   idtgCwFAXRdd4wvPFhmvbtcNq2oLOiV4uVG0AoZmtmlzHHUIKiGexbva0
   ED6nCeh/rX9UJmYZsSMyAbK8tL+Eh/M1c9PW43ERBUVW8YnaemTI8sk6v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371819881"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="371819881"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="685566215"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2022 06:15:19 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBygZ-0000hC-1X;
        Thu, 14 Jul 2022 13:15:19 +0000
Date:   Thu, 14 Jul 2022 21:14:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:depthtracking 31/38] arch/x86/entry/entry_64.S:265:
 Error: no such instruction: `call_thunks_debug_inc_ctxsw'
Message-ID: <202207142159.djfGNExM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git depthtracking
head:   81d2c1b17a61bfeca4b92a5d6e1fb6f5ff464826
commit: 2732d9924d0ab04682c6cbc252e688e3e54b7847 [31/38] x86/calldepth: Add ret/call counting for debug
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220714/202207142159.djfGNExM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=2732d9924d0ab04682c6cbc252e688e3e54b7847
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel depthtracking
        git checkout 2732d9924d0ab04682c6cbc252e688e3e54b7847
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/entry/entry_64.S: Assembler messages:
>> arch/x86/entry/entry_64.S:265: Error: no such instruction: `call_thunks_debug_inc_ctxsw'


vim +265 arch/x86/entry/entry_64.S

1eeb207f870f74 arch/x86/kernel/entry_64.S Denys Vlasenko  2015-02-26  257  
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  258  	/*
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  259  	 * When switching from a shallower to a deeper call stack
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  260  	 * the RSB may either underflow or use entries populated
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  261  	 * with userspace addresses. On CPUs where those concerns
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  262  	 * exist, overwrite the RSB with entries which capture
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  263  	 * speculative execution to prevent attack.
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  264  	 */
d1c99108af3c59 arch/x86/entry/entry_64.S  David Woodhouse 2018-02-19 @265  	FILL_RETURN_BUFFER %r12, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
c995efd5a740d9 arch/x86/entry/entry_64.S  David Woodhouse 2018-01-12  266  
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  267  	/* restore callee-saved registers */
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  268  	popq	%r15
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  269  	popq	%r14
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  270  	popq	%r13
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  271  	popq	%r12
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  272  	popq	%rbx
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  273  	popq	%rbp
1eeb207f870f74 arch/x86/kernel/entry_64.S Denys Vlasenko  2015-02-26  274  
0100301bfdf56a arch/x86/entry/entry_64.S  Brian Gerst     2016-08-13  275  	jmp	__switch_to
96c64806b4bf35 arch/x86/entry/entry_64.S  Josh Poimboeuf  2020-04-25  276  SYM_FUNC_END(__switch_to_asm)
b9f6976bfb9491 arch/x86/entry/entry_64.S  Thomas Gleixner 2020-03-25  277  .popsection
1eeb207f870f74 arch/x86/kernel/entry_64.S Denys Vlasenko  2015-02-26  278  

:::::: The code at line 265 was first introduced by commit
:::::: d1c99108af3c5992640aa2afa7d2e88c3775c06e Revert "x86/retpoline: Simplify vmexit_fill_RSB()"

:::::: TO: David Woodhouse <dwmw@amazon.co.uk>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
