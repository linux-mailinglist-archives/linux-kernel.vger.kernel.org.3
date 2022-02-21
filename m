Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFC54BEEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiBUXxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:53:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiBUXxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:53:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0812A97
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645487572; x=1677023572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LrxaznrcxycmHWuLMrgEU6HpZt4roAckMSAd3xWs1Ds=;
  b=AauxjPgA7kVdTSvedURvWEu1z1oj4GI16ZpJdIAH03/GZtK/tEUllq8a
   MPg8ZX6gXlLCtvaj3UiJu4vJruODZdKI/bgFiyS4rtBzeRak6JvVlbvT9
   VtaBdNqtg3FHO2lncD8UxLcnMFVPzHoXOpDZOGK8k708x1DYxEVMsUjCL
   HK74Mvf4T13CoFDIpy898zJ6FdoqarSqMDr4pqeIksr88YDwj00Uw82JA
   VJNJx/dWOyGLsS2fujDsOB/oV5TufTdNguMVYE4PilhDlMS1tRyToDOfF
   M184U+rcdNSvk1ftVsFacQawbqLThKe71cxRus+ZHNn1tcKwNBWFDK+nC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250402788"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="250402788"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="776119047"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 15:52:46 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMIU1-00026L-As; Mon, 21 Feb 2022 23:52:45 +0000
Date:   Tue, 22 Feb 2022 07:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 24/39]
 arch/x86/kernel/alternative.c:713:48: error: expected ')' before
 'ANNOTATE_NOENDBR'
Message-ID: <202202220700.IaFMnMm9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   1436dce5f32d577e8cef693e09f4bb1faa0e2692
commit: 691967145f3060050b5628f6863de26cc77ef17e [24/39] x86/ibt: Annotate text references
config: i386-randconfig-r034-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220700.IaFMnMm9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=691967145f3060050b5628f6863de26cc77ef17e
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 691967145f3060050b5628f6863de26cc77ef17e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/alternative.c:713:48: error: expected ')' before 'ANNOTATE_NOENDBR'
     713 | " .pushsection .init.text, \"ax\", @progbits\n"
         |                                                ^
         |                                                )
   ......
     716 |  ANNOTATE_NOENDBR
         |  ~~~~~~~~~~~~~~~~                               
   arch/x86/kernel/alternative.c:712:5: note: to match this '('
     712 | asm (
         |     ^
   arch/x86/kernel/alternative.c: In function 'int3_selftest':
>> arch/x86/kernel/alternative.c:761:16: error: expected string literal before 'ANNOTATE_NOENDBR'
     761 |  asm volatile (ANNOTATE_NOENDBR
         |                ^~~~~~~~~~~~~~~~
--
   arch/x86/lib/retpoline.S: Assembler messages:
>> arch/x86/lib/retpoline.S:15: Error: no such instruction: `annotate_noendbr'


vim +713 arch/x86/kernel/alternative.c

ecc606103837b9 Peter Zijlstra 2019-07-08  711  
ecc606103837b9 Peter Zijlstra 2019-07-08  712  asm (
ecc606103837b9 Peter Zijlstra 2019-07-08 @713  "	.pushsection	.init.text, \"ax\", @progbits\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  714  "	.type		int3_magic, @function\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  715  "int3_magic:\n"
691967145f3060 Peter Zijlstra 2022-02-17  716  	ANNOTATE_NOENDBR
ecc606103837b9 Peter Zijlstra 2019-07-08  717  "	movl	$1, (%" _ASM_ARG1 ")\n"
b17c2baa305ccc Peter Zijlstra 2021-12-04  718  	ASM_RET
ecc606103837b9 Peter Zijlstra 2019-07-08  719  "	.size		int3_magic, .-int3_magic\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  720  "	.popsection\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  721  );
7457c0da024b18 Peter Zijlstra 2019-05-03  722  
7457c0da024b18 Peter Zijlstra 2019-05-03  723  extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
7457c0da024b18 Peter Zijlstra 2019-05-03  724  
7457c0da024b18 Peter Zijlstra 2019-05-03  725  static int __init
7457c0da024b18 Peter Zijlstra 2019-05-03  726  int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
7457c0da024b18 Peter Zijlstra 2019-05-03  727  {
7457c0da024b18 Peter Zijlstra 2019-05-03  728  	struct die_args *args = data;
7457c0da024b18 Peter Zijlstra 2019-05-03  729  	struct pt_regs *regs = args->regs;
7457c0da024b18 Peter Zijlstra 2019-05-03  730  
7457c0da024b18 Peter Zijlstra 2019-05-03  731  	if (!regs || user_mode(regs))
7457c0da024b18 Peter Zijlstra 2019-05-03  732  		return NOTIFY_DONE;
7457c0da024b18 Peter Zijlstra 2019-05-03  733  
7457c0da024b18 Peter Zijlstra 2019-05-03  734  	if (val != DIE_INT3)
7457c0da024b18 Peter Zijlstra 2019-05-03  735  		return NOTIFY_DONE;
7457c0da024b18 Peter Zijlstra 2019-05-03  736  
7457c0da024b18 Peter Zijlstra 2019-05-03  737  	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
7457c0da024b18 Peter Zijlstra 2019-05-03  738  		return NOTIFY_DONE;
7457c0da024b18 Peter Zijlstra 2019-05-03  739  
7457c0da024b18 Peter Zijlstra 2019-05-03  740  	int3_emulate_call(regs, (unsigned long)&int3_magic);
7457c0da024b18 Peter Zijlstra 2019-05-03  741  	return NOTIFY_STOP;
7457c0da024b18 Peter Zijlstra 2019-05-03  742  }
7457c0da024b18 Peter Zijlstra 2019-05-03  743  
7457c0da024b18 Peter Zijlstra 2019-05-03  744  static void __init int3_selftest(void)
7457c0da024b18 Peter Zijlstra 2019-05-03  745  {
7457c0da024b18 Peter Zijlstra 2019-05-03  746  	static __initdata struct notifier_block int3_exception_nb = {
7457c0da024b18 Peter Zijlstra 2019-05-03  747  		.notifier_call	= int3_exception_notify,
7457c0da024b18 Peter Zijlstra 2019-05-03  748  		.priority	= INT_MAX-1, /* last */
7457c0da024b18 Peter Zijlstra 2019-05-03  749  	};
7457c0da024b18 Peter Zijlstra 2019-05-03  750  	unsigned int val = 0;
7457c0da024b18 Peter Zijlstra 2019-05-03  751  
7457c0da024b18 Peter Zijlstra 2019-05-03  752  	BUG_ON(register_die_notifier(&int3_exception_nb));
7457c0da024b18 Peter Zijlstra 2019-05-03  753  
7457c0da024b18 Peter Zijlstra 2019-05-03  754  	/*
7457c0da024b18 Peter Zijlstra 2019-05-03  755  	 * Basically: int3_magic(&val); but really complicated :-)
7457c0da024b18 Peter Zijlstra 2019-05-03  756  	 *
7457c0da024b18 Peter Zijlstra 2019-05-03  757  	 * Stick the address of the INT3 instruction into int3_selftest_ip,
7457c0da024b18 Peter Zijlstra 2019-05-03  758  	 * then trigger the INT3, padded with NOPs to match a CALL instruction
7457c0da024b18 Peter Zijlstra 2019-05-03  759  	 * length.
7457c0da024b18 Peter Zijlstra 2019-05-03  760  	 */
691967145f3060 Peter Zijlstra 2022-02-17 @761  	asm volatile (ANNOTATE_NOENDBR
691967145f3060 Peter Zijlstra 2022-02-17  762  		      "1: int3; nop; nop; nop; nop\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  763  		      ".pushsection .init.data,\"aw\"\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  764  		      ".align " __ASM_SEL(4, 8) "\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  765  		      ".type int3_selftest_ip, @object\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  766  		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  767  		      "int3_selftest_ip:\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  768  		      __ASM_SEL(.long, .quad) " 1b\n\t"
7457c0da024b18 Peter Zijlstra 2019-05-03  769  		      ".popsection\n\t"
ecc606103837b9 Peter Zijlstra 2019-07-08  770  		      : ASM_CALL_CONSTRAINT
ecc606103837b9 Peter Zijlstra 2019-07-08  771  		      : __ASM_SEL_RAW(a, D) (&val)
ecc606103837b9 Peter Zijlstra 2019-07-08  772  		      : "memory");
7457c0da024b18 Peter Zijlstra 2019-05-03  773  
7457c0da024b18 Peter Zijlstra 2019-05-03  774  	BUG_ON(val != 1);
7457c0da024b18 Peter Zijlstra 2019-05-03  775  
7457c0da024b18 Peter Zijlstra 2019-05-03  776  	unregister_die_notifier(&int3_exception_nb);
7457c0da024b18 Peter Zijlstra 2019-05-03  777  }
7457c0da024b18 Peter Zijlstra 2019-05-03  778  

:::::: The code at line 713 was first introduced by commit
:::::: ecc606103837b98a2b665e8f14e533a6c72bbdc0 x86/alternatives: Fix int3_emulate_call() selftest stack corruption

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
