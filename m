Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4D4BCFB9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiBTQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:03:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiBTQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:03:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834B21E12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645372963; x=1676908963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9NwTRpNDu/tHD2XIwBr3TAhromGmgxkpOIaxlQGO8Cw=;
  b=f/gikxoaoIZnK4FT/hm41pRFB+Ia5B0LlmYyBoOucrxpk7BmqEtkOAbh
   Rf1BH4/elvdtX/LCVCMRUR1HlsKsqPnEye3qp0Yv7/9WB1F1fVMpi53Up
   yFrLSY9tEepPR4Y8ySoIKhQd27KAHo061c94LtrCn/hRrJjZqTiefI+Q4
   Jdl39RMt2uugWSe/zbgogrQT8vBSXNiFBC6Xdj6vYQggXc7Ws6CygfeSh
   FMZ3l7MQPwAfZnbQ0ZV4axCWT/nr4JxoOCqJJabDdNHVDA19kdZ/vO7Ko
   nd6QwYG0j8S/KVBCn7sPgYIk9Ww5pUFs00IlXH6vg2SBeIFhWRc2hcJCP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="231353985"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="231353985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 08:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="682973476"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 08:02:42 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLofZ-0000RQ-GN; Sun, 20 Feb 2022 16:02:41 +0000
Date:   Mon, 21 Feb 2022 00:02:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 19/31]
 arch/x86/kernel/alternative.c:761:16: error: expected string literal in
 'asm'
Message-ID: <202202202357.ldfBr75W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   fecdb8a84191710ffe01c9492fceb34a15f1576a
commit: 97e04204b3c4f0515f956be22a19229878b9253e [19/31] x86/ibt: Annotate text references
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220220/202202202357.ldfBr75W-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=97e04204b3c4f0515f956be22a19229878b9253e
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 97e04204b3c4f0515f956be22a19229878b9253e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/alternative.c:716:2: error: expected ')'
           ANNOTATE_NOENDBR
           ^
   arch/x86/kernel/alternative.c:712:5: note: to match this '('
   asm (
       ^
>> arch/x86/kernel/alternative.c:761:16: error: expected string literal in 'asm'
           asm volatile (ANNOTATE_NOENDBR
                         ^
   2 errors generated.


vim +/asm +761 arch/x86/kernel/alternative.c

   743	
   744	static void __init int3_selftest(void)
   745	{
   746		static __initdata struct notifier_block int3_exception_nb = {
   747			.notifier_call	= int3_exception_notify,
   748			.priority	= INT_MAX-1, /* last */
   749		};
   750		unsigned int val = 0;
   751	
   752		BUG_ON(register_die_notifier(&int3_exception_nb));
   753	
   754		/*
   755		 * Basically: int3_magic(&val); but really complicated :-)
   756		 *
   757		 * Stick the address of the INT3 instruction into int3_selftest_ip,
   758		 * then trigger the INT3, padded with NOPs to match a CALL instruction
   759		 * length.
   760		 */
 > 761		asm volatile (ANNOTATE_NOENDBR
   762			      "1: int3; nop; nop; nop; nop\n\t"
   763			      ".pushsection .init.data,\"aw\"\n\t"
   764			      ".align " __ASM_SEL(4, 8) "\n\t"
   765			      ".type int3_selftest_ip, @object\n\t"
   766			      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
   767			      "int3_selftest_ip:\n\t"
   768			      __ASM_SEL(.long, .quad) " 1b\n\t"
   769			      ".popsection\n\t"
   770			      : ASM_CALL_CONSTRAINT
   771			      : __ASM_SEL_RAW(a, D) (&val)
   772			      : "memory");
   773	
   774		BUG_ON(val != 1);
   775	
   776		unregister_die_notifier(&int3_exception_nb);
   777	}
   778	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
