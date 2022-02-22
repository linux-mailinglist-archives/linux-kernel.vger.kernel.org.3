Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7EF4BF230
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiBVGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:43:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBVGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:43:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C21110A7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645512176; x=1677048176;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=voJ0cCZC0eL2orT94+vc9vUjmlp6DZeqEERqkUOzhTM=;
  b=JH/9eXc9vmKn+akL4UmUfLX3aTOepE+8SLL/ilH5S2yBHtchvxDQo8Ec
   duO0ylqntAH6b/eta+cX0BX1foLg7vsJu38OMRBAIiF/YM2ws57slyDl3
   mqdt8epT8SZYcZPJckIJCpmmPVQTH7fjChhnDGULI2eGp8IRegMqI07Rk
   GoHVwRrhxXgX38St1BaHy5zQ9+pv7WIRab2OzGxxqipvWI6l1Agrxd+c+
   I1rjJdAycf5/5PD5OfE222iqn9+CZI61/Zp3ioiaHUTJtIG1M1CDjxitN
   Lf6khOe7TWyMTH8HrVQ8ifFl1Jogs9Ijxo+/0WHNv2b2yfzqbusGsDuI7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276222263"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276222263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="606588599"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2022 22:42:55 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMOsw-0002Pq-Kw; Tue, 22 Feb 2022 06:42:54 +0000
Date:   Tue, 22 Feb 2022 14:41:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 31/39] arch/x86/xen/enlighten_pv.c:627:2:
 error: use of undeclared identifier 'asm_exc_control_protection'; did you
 mean 'asm_exc_general_protection'?
Message-ID: <202202221419.DMC8nDHf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   1436dce5f32d577e8cef693e09f4bb1faa0e2692
commit: 3c80adbe1204e92a048cb149b966c2a990c89ec6 [31/39] x86/ibt,xen: Annotate away warnings
config: x86_64-randconfig-a011-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221419.DMC8nDHf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=3c80adbe1204e92a048cb149b966c2a990c89ec6
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 3c80adbe1204e92a048cb149b966c2a990c89ec6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/xen/enlighten_pv.c:627:2: error: use of undeclared identifier 'asm_exc_control_protection'; did you mean 'asm_exc_general_protection'?
           TRAP_ENTRY(exc_control_protection,              false ),
           ^
   arch/x86/xen/enlighten_pv.c:592:11: note: expanded from macro 'TRAP_ENTRY'
           .orig           = asm_##func,                   \
                             ^
   <scratch space>:77:1: note: expanded from here
   asm_exc_control_protection
   ^
   arch/x86/include/asm/idtentry.h:564:1: note: 'asm_exc_general_protection' declared here
   DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP, exc_general_protection);
   ^
   arch/x86/include/asm/idtentry.h:83:18: note: expanded from macro 'DECLARE_IDTENTRY_ERRORCODE'
           asmlinkage void asm_##func(void);                               \
                           ^
   <scratch space>:35:1: note: expanded from here
   asm_exc_general_protection
   ^
>> arch/x86/xen/enlighten_pv.c:627:2: error: use of undeclared identifier 'xen_asm_exc_control_protection'; did you mean 'xen_asm_exc_general_protection'?
           TRAP_ENTRY(exc_control_protection,              false ),
           ^
   arch/x86/xen/enlighten_pv.c:593:10: note: expanded from macro 'TRAP_ENTRY'
           .xen            = xen_asm_##func,               \
                             ^
   <scratch space>:78:1: note: expanded from here
   xen_asm_exc_control_protection
   ^
   arch/x86/include/asm/idtentry.h:564:1: note: 'xen_asm_exc_general_protection' declared here
   DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP, exc_general_protection);
   ^
   arch/x86/include/asm/idtentry.h:84:18: note: expanded from macro 'DECLARE_IDTENTRY_ERRORCODE'
           asmlinkage void xen_asm_##func(void);                           \
                           ^
   <scratch space>:36:1: note: expanded from here
   xen_asm_exc_general_protection
   ^
   arch/x86/xen/enlighten_pv.c:1184:34: warning: no previous prototype for function 'xen_start_kernel' [-Wmissing-prototypes]
   asmlinkage __visible void __init xen_start_kernel(void)
                                    ^
   arch/x86/xen/enlighten_pv.c:1184:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void __init xen_start_kernel(void)
                        ^
                        static 
   1 warning and 2 errors generated.


vim +627 arch/x86/xen/enlighten_pv.c

   590	
   591	#define TRAP_ENTRY(func, ist_ok) {			\
   592		.orig		= asm_##func,			\
   593		.xen		= xen_asm_##func,		\
   594		.ist_okay	= ist_ok }
   595	
   596	#define TRAP_ENTRY_REDIR(func, ist_ok) {		\
   597		.orig		= asm_##func,			\
   598		.xen		= xen_asm_xenpv_##func,		\
   599		.ist_okay	= ist_ok }
   600	
   601	static struct trap_array_entry trap_array[] = {
   602		TRAP_ENTRY_REDIR(exc_debug,			true  ),
   603		TRAP_ENTRY_REDIR(exc_double_fault,		true  ),
   604	#ifdef CONFIG_X86_MCE
   605		TRAP_ENTRY_REDIR(exc_machine_check,		true  ),
   606	#endif
   607		TRAP_ENTRY_REDIR(exc_nmi,			true  ),
   608		TRAP_ENTRY(exc_int3,				false ),
   609		TRAP_ENTRY(exc_overflow,			false ),
   610	#ifdef CONFIG_IA32_EMULATION
   611		{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
   612	#endif
   613		TRAP_ENTRY(exc_page_fault,			false ),
   614		TRAP_ENTRY(exc_divide_error,			false ),
   615		TRAP_ENTRY(exc_bounds,				false ),
   616		TRAP_ENTRY(exc_invalid_op,			false ),
   617		TRAP_ENTRY(exc_device_not_available,		false ),
   618		TRAP_ENTRY(exc_coproc_segment_overrun,		false ),
   619		TRAP_ENTRY(exc_invalid_tss,			false ),
   620		TRAP_ENTRY(exc_segment_not_present,		false ),
   621		TRAP_ENTRY(exc_stack_segment,			false ),
   622		TRAP_ENTRY(exc_general_protection,		false ),
   623		TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
   624		TRAP_ENTRY(exc_coprocessor_error,		false ),
   625		TRAP_ENTRY(exc_alignment_check,			false ),
   626		TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
 > 627		TRAP_ENTRY(exc_control_protection,		false ),
   628	};
   629	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
