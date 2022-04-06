Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED974F5DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiDFMV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiDFMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:21:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7206210FF2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649231996; x=1680767996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ywGwlkckCN7UGTUw1A/e8GRc5m3Hyogc5HQDdEy5kE=;
  b=afnYAeRzLHKlOR+rsi9CHUXLc+CvNjFmvPAGXPRgxrCjA30oxJw6M3RM
   lvlxvtUV08Oc9gDz+Blp/xNOmO4qrmM/gM8g+rWeq945G33/Q1LZNIPmt
   YRoS2STVSGsrit509oaY11Ptoe/Px6Vzdv7iEExPtdKlvGTp2414lFvsg
   SbzNcfROuMthFJag/yXM2aTBMZqHYqSBS2y9kCD4ravvtMFvWk4n6wpkF
   2+JOat8TypW/Taqdr53dizTdbhyeqmzCypkhsRjPSBI6sOKXXPW+7sf+z
   49NPIMT0ZSeBqe+AfOybJJGYYgL54ZvtkoB4DkZ2jB15qd/B/Dl785AJN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240913753"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="240913753"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 00:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="524366809"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 00:59:53 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc0a1-0004CD-3x;
        Wed, 06 Apr 2022 07:59:53 +0000
Date:   Wed, 6 Apr 2022 15:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/unaligned.c:205 emulate_ldd() warn: inconsistent
 indenting
Message-ID: <202204061554.lmz58xtf-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e732ebf7316ac83e8562db7e64cc68aec390a18
commit: d1434e03b2913c28d85e429eea20c53993fbe1af parisc/unaligned: Use EFAULT fixup handler in unaligned handlers
date:   4 weeks ago
config: parisc-randconfig-m031-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061554.lmz58xtf-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/parisc/kernel/unaligned.c:205 emulate_ldd() warn: inconsistent indenting
arch/parisc/kernel/unaligned.c:350 emulate_std() warn: inconsistent indenting

vim +205 arch/parisc/kernel/unaligned.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  141  
^1da177e4c3f415 Linus Torvalds 2005-04-16  142  static int emulate_ldw(struct pt_regs *regs, int toreg, int flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  143  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  144  	unsigned long saddr = regs->ior;
^1da177e4c3f415 Linus Torvalds 2005-04-16  145  	unsigned long val = 0;
d1434e03b2913c2 Helge Deller   2022-02-19  146  	ASM_EXCEPTIONTABLE_VAR(ret);
^1da177e4c3f415 Linus Torvalds 2005-04-16  147  
^1da177e4c3f415 Linus Torvalds 2005-04-16  148  	DPRINTF("load " RFMT ":" RFMT " to r%d for 4 bytes\n", 
^1da177e4c3f415 Linus Torvalds 2005-04-16  149  		regs->isr, regs->ior, toreg);
^1da177e4c3f415 Linus Torvalds 2005-04-16  150  
^1da177e4c3f415 Linus Torvalds 2005-04-16  151  	__asm__ __volatile__  (
^1da177e4c3f415 Linus Torvalds 2005-04-16  152  "	zdep	%3,28,2,%%r19\n"		/* r19=(ofs&3)*8 */
^1da177e4c3f415 Linus Torvalds 2005-04-16  153  "	mtsp	%4, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  154  "	depw	%%r0,31,2,%3\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  155  "1:	ldw	0(%%sr1,%3),%0\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  156  "2:	ldw	4(%%sr1,%3),%%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  157  "	subi	32,%%r19,%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  158  "	mtctl	%%r19,11\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  159  "	vshd	%0,%%r20,%0\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  160  "3:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  161  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  162  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  163  	: "=r" (val), "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  164  	: "0" (val), "r" (saddr), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  165  	: "r19", "r20" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  166  
^1da177e4c3f415 Linus Torvalds 2005-04-16  167  	DPRINTF("val = 0x" RFMT "\n", val);
^1da177e4c3f415 Linus Torvalds 2005-04-16  168  
^1da177e4c3f415 Linus Torvalds 2005-04-16  169  	if (flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  170  		((__u32*)(regs->fr))[toreg] = val;
^1da177e4c3f415 Linus Torvalds 2005-04-16  171  	else if (toreg)
^1da177e4c3f415 Linus Torvalds 2005-04-16  172  		regs->gr[toreg] = val;
^1da177e4c3f415 Linus Torvalds 2005-04-16  173  
^1da177e4c3f415 Linus Torvalds 2005-04-16  174  	return ret;
^1da177e4c3f415 Linus Torvalds 2005-04-16  175  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  176  static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  177  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  178  	unsigned long saddr = regs->ior;
^1da177e4c3f415 Linus Torvalds 2005-04-16  179  	__u64 val = 0;
d1434e03b2913c2 Helge Deller   2022-02-19  180  	ASM_EXCEPTIONTABLE_VAR(ret);
^1da177e4c3f415 Linus Torvalds 2005-04-16  181  
^1da177e4c3f415 Linus Torvalds 2005-04-16  182  	DPRINTF("load " RFMT ":" RFMT " to r%d for 8 bytes\n", 
^1da177e4c3f415 Linus Torvalds 2005-04-16  183  		regs->isr, regs->ior, toreg);
^1da177e4c3f415 Linus Torvalds 2005-04-16  184  
d1434e03b2913c2 Helge Deller   2022-02-19  185  	if (!IS_ENABLED(CONFIG_64BIT) && !flop)
d1434e03b2913c2 Helge Deller   2022-02-19  186  		return ERR_NOTHANDLED;
d1434e03b2913c2 Helge Deller   2022-02-19  187  
d1434e03b2913c2 Helge Deller   2022-02-19  188  #ifdef CONFIG_64BIT
^1da177e4c3f415 Linus Torvalds 2005-04-16  189  	__asm__ __volatile__  (
^1da177e4c3f415 Linus Torvalds 2005-04-16  190  "	depd,z	%3,60,3,%%r19\n"		/* r19=(ofs&7)*8 */
^1da177e4c3f415 Linus Torvalds 2005-04-16  191  "	mtsp	%4, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  192  "	depd	%%r0,63,3,%3\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  193  "1:	ldd	0(%%sr1,%3),%0\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  194  "2:	ldd	8(%%sr1,%3),%%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  195  "	subi	64,%%r19,%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  196  "	mtsar	%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  197  "	shrpd	%0,%%r20,%%sar,%0\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  198  "3:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  199  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  200  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  201  	: "=r" (val), "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  202  	: "0" (val), "r" (saddr), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  203  	: "r19", "r20" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  204  #else
^1da177e4c3f415 Linus Torvalds 2005-04-16 @205      {
^1da177e4c3f415 Linus Torvalds 2005-04-16  206  	unsigned long valh=0,vall=0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  207  	__asm__ __volatile__  (
^1da177e4c3f415 Linus Torvalds 2005-04-16  208  "	zdep	%5,29,2,%%r19\n"		/* r19=(ofs&3)*8 */
^1da177e4c3f415 Linus Torvalds 2005-04-16  209  "	mtsp	%6, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  210  "	dep	%%r0,31,2,%5\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  211  "1:	ldw	0(%%sr1,%5),%0\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  212  "2:	ldw	4(%%sr1,%5),%1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  213  "3:	ldw	8(%%sr1,%5),%%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  214  "	subi	32,%%r19,%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  215  "	mtsar	%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  216  "	vshd	%0,%1,%0\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  217  "	vshd	%1,%%r20,%1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  218  "4:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  219  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 4b)
d1434e03b2913c2 Helge Deller   2022-02-19  220  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 4b)
d1434e03b2913c2 Helge Deller   2022-02-19  221  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b)
d1434e03b2913c2 Helge Deller   2022-02-19  222  	: "=r" (valh), "=r" (vall), "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  223  	: "0" (valh), "1" (vall), "r" (saddr), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  224  	: "r19", "r20" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  225  	val=((__u64)valh<<32)|(__u64)vall;
^1da177e4c3f415 Linus Torvalds 2005-04-16  226      }
^1da177e4c3f415 Linus Torvalds 2005-04-16  227  #endif
^1da177e4c3f415 Linus Torvalds 2005-04-16  228  
^1da177e4c3f415 Linus Torvalds 2005-04-16  229  	DPRINTF("val = 0x%llx\n", val);
^1da177e4c3f415 Linus Torvalds 2005-04-16  230  
^1da177e4c3f415 Linus Torvalds 2005-04-16  231  	if (flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  232  		regs->fr[toreg] = val;
^1da177e4c3f415 Linus Torvalds 2005-04-16  233  	else if (toreg)
^1da177e4c3f415 Linus Torvalds 2005-04-16  234  		regs->gr[toreg] = val;
^1da177e4c3f415 Linus Torvalds 2005-04-16  235  
^1da177e4c3f415 Linus Torvalds 2005-04-16  236  	return ret;
^1da177e4c3f415 Linus Torvalds 2005-04-16  237  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  238  
^1da177e4c3f415 Linus Torvalds 2005-04-16  239  static int emulate_sth(struct pt_regs *regs, int frreg)
^1da177e4c3f415 Linus Torvalds 2005-04-16  240  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  241  	unsigned long val = regs->gr[frreg];
d1434e03b2913c2 Helge Deller   2022-02-19  242  	ASM_EXCEPTIONTABLE_VAR(ret);
^1da177e4c3f415 Linus Torvalds 2005-04-16  243  
^1da177e4c3f415 Linus Torvalds 2005-04-16  244  	if (!frreg)
^1da177e4c3f415 Linus Torvalds 2005-04-16  245  		val = 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  246  
^1da177e4c3f415 Linus Torvalds 2005-04-16  247  	DPRINTF("store r%d (0x" RFMT ") to " RFMT ":" RFMT " for 2 bytes\n", frreg, 
^1da177e4c3f415 Linus Torvalds 2005-04-16  248  		val, regs->isr, regs->ior);
^1da177e4c3f415 Linus Torvalds 2005-04-16  249  
^1da177e4c3f415 Linus Torvalds 2005-04-16  250  	__asm__ __volatile__ (
^1da177e4c3f415 Linus Torvalds 2005-04-16  251  "	mtsp %3, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  252  "	extrw,u %1, 23, 8, %%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  253  "1:	stb %1, 1(%%sr1, %2)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  254  "2:	stb %%r19, 0(%%sr1, %2)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  255  "3:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  256  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  257  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  258  	: "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  259  	: "r" (val), "r" (regs->ior), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  260  	: "r19" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  261  
^1da177e4c3f415 Linus Torvalds 2005-04-16  262  	return ret;
^1da177e4c3f415 Linus Torvalds 2005-04-16  263  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  264  
^1da177e4c3f415 Linus Torvalds 2005-04-16  265  static int emulate_stw(struct pt_regs *regs, int frreg, int flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  266  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  267  	unsigned long val;
d1434e03b2913c2 Helge Deller   2022-02-19  268  	ASM_EXCEPTIONTABLE_VAR(ret);
^1da177e4c3f415 Linus Torvalds 2005-04-16  269  
^1da177e4c3f415 Linus Torvalds 2005-04-16  270  	if (flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  271  		val = ((__u32*)(regs->fr))[frreg];
^1da177e4c3f415 Linus Torvalds 2005-04-16  272  	else if (frreg)
^1da177e4c3f415 Linus Torvalds 2005-04-16  273  		val = regs->gr[frreg];
^1da177e4c3f415 Linus Torvalds 2005-04-16  274  	else
^1da177e4c3f415 Linus Torvalds 2005-04-16  275  		val = 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  276  
^1da177e4c3f415 Linus Torvalds 2005-04-16  277  	DPRINTF("store r%d (0x" RFMT ") to " RFMT ":" RFMT " for 4 bytes\n", frreg, 
^1da177e4c3f415 Linus Torvalds 2005-04-16  278  		val, regs->isr, regs->ior);
^1da177e4c3f415 Linus Torvalds 2005-04-16  279  
^1da177e4c3f415 Linus Torvalds 2005-04-16  280  
^1da177e4c3f415 Linus Torvalds 2005-04-16  281  	__asm__ __volatile__ (
^1da177e4c3f415 Linus Torvalds 2005-04-16  282  "	mtsp %3, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  283  "	zdep	%2, 28, 2, %%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  284  "	dep	%%r0, 31, 2, %2\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  285  "	mtsar	%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  286  "	depwi,z	-2, %%sar, 32, %%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  287  "1:	ldw	0(%%sr1,%2),%%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  288  "2:	ldw	4(%%sr1,%2),%%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  289  "	vshd	%%r0, %1, %%r22\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  290  "	vshd	%1, %%r0, %%r1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  291  "	and	%%r20, %%r19, %%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  292  "	andcm	%%r21, %%r19, %%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  293  "	or	%%r22, %%r20, %%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  294  "	or	%%r1, %%r21, %%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  295  "	stw	%%r20,0(%%sr1,%2)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  296  "	stw	%%r21,4(%%sr1,%2)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  297  "3:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  298  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  299  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b)
d1434e03b2913c2 Helge Deller   2022-02-19  300  	: "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  301  	: "r" (val), "r" (regs->ior), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  302  	: "r19", "r20", "r21", "r22", "r1" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  303  
a97279836867b1c Helge Deller   2022-02-18  304  	return ret;
^1da177e4c3f415 Linus Torvalds 2005-04-16  305  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  306  static int emulate_std(struct pt_regs *regs, int frreg, int flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  307  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  308  	__u64 val;
d1434e03b2913c2 Helge Deller   2022-02-19  309  	ASM_EXCEPTIONTABLE_VAR(ret);
^1da177e4c3f415 Linus Torvalds 2005-04-16  310  
^1da177e4c3f415 Linus Torvalds 2005-04-16  311  	if (flop)
^1da177e4c3f415 Linus Torvalds 2005-04-16  312  		val = regs->fr[frreg];
^1da177e4c3f415 Linus Torvalds 2005-04-16  313  	else if (frreg)
^1da177e4c3f415 Linus Torvalds 2005-04-16  314  		val = regs->gr[frreg];
^1da177e4c3f415 Linus Torvalds 2005-04-16  315  	else
^1da177e4c3f415 Linus Torvalds 2005-04-16  316  		val = 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  317  
^1da177e4c3f415 Linus Torvalds 2005-04-16  318  	DPRINTF("store r%d (0x%016llx) to " RFMT ":" RFMT " for 8 bytes\n", frreg, 
^1da177e4c3f415 Linus Torvalds 2005-04-16  319  		val,  regs->isr, regs->ior);
^1da177e4c3f415 Linus Torvalds 2005-04-16  320  
d1434e03b2913c2 Helge Deller   2022-02-19  321  	if (!IS_ENABLED(CONFIG_64BIT) && !flop)
d1434e03b2913c2 Helge Deller   2022-02-19  322  		return ERR_NOTHANDLED;
d1434e03b2913c2 Helge Deller   2022-02-19  323  
d1434e03b2913c2 Helge Deller   2022-02-19  324  #ifdef CONFIG_64BIT
^1da177e4c3f415 Linus Torvalds 2005-04-16  325  	__asm__ __volatile__ (
^1da177e4c3f415 Linus Torvalds 2005-04-16  326  "	mtsp %3, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  327  "	depd,z	%2, 60, 3, %%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  328  "	depd	%%r0, 63, 3, %2\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  329  "	mtsar	%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  330  "	depdi,z	-2, %%sar, 64, %%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  331  "1:	ldd	0(%%sr1,%2),%%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  332  "2:	ldd	8(%%sr1,%2),%%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  333  "	shrpd	%%r0, %1, %%sar, %%r22\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  334  "	shrpd	%1, %%r0, %%sar, %%r1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  335  "	and	%%r20, %%r19, %%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  336  "	andcm	%%r21, %%r19, %%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  337  "	or	%%r22, %%r20, %%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  338  "	or	%%r1, %%r21, %%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  339  "3:	std	%%r20,0(%%sr1,%2)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  340  "4:	std	%%r21,8(%%sr1,%2)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  341  "5:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  342  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 5b)
d1434e03b2913c2 Helge Deller   2022-02-19  343  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 5b)
d1434e03b2913c2 Helge Deller   2022-02-19  344  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 5b)
d1434e03b2913c2 Helge Deller   2022-02-19  345  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(4b, 5b)
d1434e03b2913c2 Helge Deller   2022-02-19  346  	: "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  347  	: "r" (val), "r" (regs->ior), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  348  	: "r19", "r20", "r21", "r22", "r1" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  349  #else
^1da177e4c3f415 Linus Torvalds 2005-04-16 @350      {
^1da177e4c3f415 Linus Torvalds 2005-04-16  351  	unsigned long valh=(val>>32),vall=(val&0xffffffffl);
^1da177e4c3f415 Linus Torvalds 2005-04-16  352  	__asm__ __volatile__ (
^1da177e4c3f415 Linus Torvalds 2005-04-16  353  "	mtsp	%4, %%sr1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  354  "	zdep	%2, 29, 2, %%r19\n"
dd2288f4a020d69 Helge Deller   2022-02-18  355  "	dep	%%r0, 31, 2, %3\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  356  "	mtsar	%%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  357  "	zvdepi	-2, 32, %%r19\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  358  "1:	ldw	0(%%sr1,%3),%%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  359  "2:	ldw	8(%%sr1,%3),%%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  360  "	vshd	%1, %2, %%r1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  361  "	vshd	%%r0, %1, %1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  362  "	vshd	%2, %%r0, %2\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  363  "	and	%%r20, %%r19, %%r20\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  364  "	andcm	%%r21, %%r19, %%r21\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  365  "	or	%1, %%r20, %1\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  366  "	or	%2, %%r21, %2\n"
dd2288f4a020d69 Helge Deller   2022-02-18  367  "3:	stw	%1,0(%%sr1,%3)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  368  "4:	stw	%%r1,4(%%sr1,%3)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  369  "5:	stw	%2,8(%%sr1,%3)\n"
^1da177e4c3f415 Linus Torvalds 2005-04-16  370  "6:	\n"
d1434e03b2913c2 Helge Deller   2022-02-19  371  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 6b)
d1434e03b2913c2 Helge Deller   2022-02-19  372  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 6b)
d1434e03b2913c2 Helge Deller   2022-02-19  373  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 6b)
d1434e03b2913c2 Helge Deller   2022-02-19  374  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(4b, 6b)
d1434e03b2913c2 Helge Deller   2022-02-19  375  	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(5b, 6b)
d1434e03b2913c2 Helge Deller   2022-02-19  376  	: "+r" (ret)
^1da177e4c3f415 Linus Torvalds 2005-04-16  377  	: "r" (valh), "r" (vall), "r" (regs->ior), "r" (regs->isr)
d1434e03b2913c2 Helge Deller   2022-02-19  378  	: "r19", "r20", "r21", "r1" );
^1da177e4c3f415 Linus Torvalds 2005-04-16  379      }
^1da177e4c3f415 Linus Torvalds 2005-04-16  380  #endif
^1da177e4c3f415 Linus Torvalds 2005-04-16  381  
^1da177e4c3f415 Linus Torvalds 2005-04-16  382  	return ret;
^1da177e4c3f415 Linus Torvalds 2005-04-16  383  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  384  

:::::: The code at line 205 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
