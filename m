Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211AF59B61D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiHUTRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUTRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:17:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4F1CFCB
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661109422; x=1692645422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5NJ8o8+SYvbkE7X+zH7scp8eC/6SaY1fD2BrW7tjQB8=;
  b=RBC2WqGzwMsENg0x15AwDMvrqNWFPl9+xEMvSs+sVt98VKZn092sCzz3
   LwzarMu8juXSSIfQzwkKiAFRnqrWAKSkyjVCG3TAfUiy5p3jkpthJRSZJ
   EMJbf35pu+piPPpnpCEmiFbVQTDrkdwm5/scIILTVn5WRqzBZyRLYCmzx
   y3AjUz43go2NLE2ghfpA8HOCAFJ7BKk+BdQxSnjGZAVoIlpgHzIcLc7V2
   hhsxVzFczd78ltBVJvK+7avxUC36uGEe5hxmirK0Xxdetj3WwtYq6iM9I
   W3ABsmOEh3fZVYvgKQIkoAfylrpuLAkKXjNXtvkd+IRS+22ivPyvJlz9Z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="290830114"
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="290830114"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 12:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="676971911"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2022 12:17:00 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPqRP-0004PD-2S;
        Sun, 21 Aug 2022 19:16:59 +0000
Date:   Mon, 22 Aug 2022 03:16:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:for-next 7/7] arch/parisc/kernel/head.S:120: Error:
 Invalid operands
Message-ID: <202208220359.HUa8gjtt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
head:   7655e47e87da9635d0b6f48022cddca69f6f5176
commit: 7655e47e87da9635d0b6f48022cddca69f6f5176 [7/7] parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines
config: parisc-randconfig-r003-20220821 (https://download.01.org/0day-ci/archive/20220822/202208220359.HUa8gjtt-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=7655e47e87da9635d0b6f48022cddca69f6f5176
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next
        git checkout 7655e47e87da9635d0b6f48022cddca69f6f5176
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc64 SHELL=/bin/bash arch/parisc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/kernel/head.S: Assembler messages:
>> arch/parisc/kernel/head.S:120: Error: Invalid operands 
   arch/parisc/kernel/head.S:131: Error: Invalid operands 
   arch/parisc/kernel/head.S:154: Error: Invalid operands 
   arch/parisc/kernel/head.S:187: Error: Invalid operands 
   arch/parisc/kernel/head.S:242: Error: Invalid operands 
   arch/parisc/kernel/head.S:246: Error: Invalid operands 
   arch/parisc/kernel/head.S:248: Error: Invalid operands 
>> arch/parisc/kernel/head.S:250: Error: Field out of range [0..31] (512).
   arch/parisc/kernel/head.S:250: Error: Invalid operands 
   arch/parisc/kernel/head.S:266: Error: Invalid operands 
   arch/parisc/kernel/head.S:382: Error: Invalid operands 
   arch/parisc/kernel/head.S:384: Error: Invalid operands 
   arch/parisc/kernel/head.S:386: Error: Field out of range [0..31] (512).
   arch/parisc/kernel/head.S:386: Error: Invalid operands 
   arch/parisc/kernel/head.S:392: Error: Invalid operands 
   arch/parisc/kernel/head.S:395: Error: Invalid operands 


vim +120 arch/parisc/kernel/head.S

7655e47e87da96 Helge Deller       2022-08-21  111  
332b42e4eb6e95 Helge Deller       2015-11-20  112  	/* Initialize startup VM. Just map first 16/32 MB of memory */
^1da177e4c3f41 Linus Torvalds     2005-04-16  113  	load32		PA(swapper_pg_dir),%r4
^1da177e4c3f41 Linus Torvalds     2005-04-16  114  	mtctl		%r4,%cr24	/* Initialize kernel root pointer */
^1da177e4c3f41 Linus Torvalds     2005-04-16  115  	mtctl		%r4,%cr25	/* Initialize user root pointer */
^1da177e4c3f41 Linus Torvalds     2005-04-16  116  
f24ffde4323775 Kirill A. Shutemov 2015-04-14  117  #if CONFIG_PGTABLE_LEVELS == 3
^1da177e4c3f41 Linus Torvalds     2005-04-16  118  	/* Set pmd in pgd */
^1da177e4c3f41 Linus Torvalds     2005-04-16  119  	load32		PA(pmd0),%r5
^1da177e4c3f41 Linus Torvalds     2005-04-16 @120  	shrd            %r5,PxD_VALUE_SHIFT,%r3	
^1da177e4c3f41 Linus Torvalds     2005-04-16  121  	ldo		(PxD_FLAG_PRESENT+PxD_FLAG_VALID)(%r3),%r3
^1da177e4c3f41 Linus Torvalds     2005-04-16  122  	stw		%r3,ASM_PGD_ENTRY*ASM_PGD_ENTRY_SIZE(%r4)
^1da177e4c3f41 Linus Torvalds     2005-04-16  123  	ldo		ASM_PMD_ENTRY*ASM_PMD_ENTRY_SIZE(%r5),%r4
^1da177e4c3f41 Linus Torvalds     2005-04-16  124  #else
^1da177e4c3f41 Linus Torvalds     2005-04-16  125  	/* 2-level page table, so pmd == pgd */
^1da177e4c3f41 Linus Torvalds     2005-04-16  126  	ldo		ASM_PGD_ENTRY*ASM_PGD_ENTRY_SIZE(%r4),%r4
^1da177e4c3f41 Linus Torvalds     2005-04-16  127  #endif
^1da177e4c3f41 Linus Torvalds     2005-04-16  128  
^1da177e4c3f41 Linus Torvalds     2005-04-16  129  	/* Fill in pmd with enough pte directories */
^1da177e4c3f41 Linus Torvalds     2005-04-16  130  	load32		PA(pg0),%r1
^1da177e4c3f41 Linus Torvalds     2005-04-16  131  	SHRREG		%r1,PxD_VALUE_SHIFT,%r3
^1da177e4c3f41 Linus Torvalds     2005-04-16  132  	ldo		(PxD_FLAG_PRESENT+PxD_FLAG_VALID)(%r3),%r3
^1da177e4c3f41 Linus Torvalds     2005-04-16  133  
^1da177e4c3f41 Linus Torvalds     2005-04-16  134  	ldi		ASM_PT_INITIAL,%r1
^1da177e4c3f41 Linus Torvalds     2005-04-16  135  
^1da177e4c3f41 Linus Torvalds     2005-04-16  136  1:
^1da177e4c3f41 Linus Torvalds     2005-04-16  137  	stw		%r3,0(%r4)
80af0876991093 Kyle McMartin      2007-10-18  138  	ldo		(PAGE_SIZE >> PxD_VALUE_SHIFT)(%r3),%r3
^1da177e4c3f41 Linus Torvalds     2005-04-16  139  	addib,>		-1,%r1,1b
f24ffde4323775 Kirill A. Shutemov 2015-04-14  140  #if CONFIG_PGTABLE_LEVELS == 3
^1da177e4c3f41 Linus Torvalds     2005-04-16  141  	ldo             ASM_PMD_ENTRY_SIZE(%r4),%r4
^1da177e4c3f41 Linus Torvalds     2005-04-16  142  #else
^1da177e4c3f41 Linus Torvalds     2005-04-16  143  	ldo             ASM_PGD_ENTRY_SIZE(%r4),%r4
^1da177e4c3f41 Linus Torvalds     2005-04-16  144  #endif
^1da177e4c3f41 Linus Torvalds     2005-04-16  145  
^1da177e4c3f41 Linus Torvalds     2005-04-16  146  
d7dd2ff11b7fcd James Bottomley    2011-04-14  147  	/* Now initialize the PTEs themselves.  We use RWX for
d7dd2ff11b7fcd James Bottomley    2011-04-14  148  	 * everything ... it will get remapped correctly later */
d7dd2ff11b7fcd James Bottomley    2011-04-14  149  	ldo		0+_PAGE_KERNEL_RWX(%r0),%r3 /* Hardwired 0 phys addr start */
332b42e4eb6e95 Helge Deller       2015-11-20  150  	load32		(1<<(KERNEL_INITIAL_ORDER-PAGE_SHIFT)),%r11 /* PFN count */
^1da177e4c3f41 Linus Torvalds     2005-04-16  151  	load32		PA(pg0),%r1
^1da177e4c3f41 Linus Torvalds     2005-04-16  152  
^1da177e4c3f41 Linus Torvalds     2005-04-16  153  $pgt_fill_loop:
^1da177e4c3f41 Linus Torvalds     2005-04-16  154  	STREGM          %r3,ASM_PTE_ENTRY_SIZE(%r1)
2fd83038160531 Helge Deller       2006-04-20  155  	ldo		(1<<PFN_PTE_SHIFT)(%r3),%r3 /* add one PFN */
2fd83038160531 Helge Deller       2006-04-20  156  	addib,>		-1,%r11,$pgt_fill_loop
^1da177e4c3f41 Linus Torvalds     2005-04-16  157  	nop
^1da177e4c3f41 Linus Torvalds     2005-04-16  158  
^1da177e4c3f41 Linus Torvalds     2005-04-16  159  	/* Load the return address...er...crash 'n burn */
^1da177e4c3f41 Linus Torvalds     2005-04-16  160  	copy		%r0,%r2
^1da177e4c3f41 Linus Torvalds     2005-04-16  161  
^1da177e4c3f41 Linus Torvalds     2005-04-16  162  	/* And the RFI Target address too */
089d55289db5d5 Kyle McMartin      2008-07-29  163  	load32		start_parisc,%r11
^1da177e4c3f41 Linus Torvalds     2005-04-16  164  
^1da177e4c3f41 Linus Torvalds     2005-04-16  165  	/* And the initial task pointer */
2214c0e77259b4 Helge Deller       2021-10-15  166  	load32		init_task,%r6
^1da177e4c3f41 Linus Torvalds     2005-04-16  167  	mtctl           %r6,%cr30
^1da177e4c3f41 Linus Torvalds     2005-04-16  168  
^1da177e4c3f41 Linus Torvalds     2005-04-16  169  	/* And the stack pointer too */
2214c0e77259b4 Helge Deller       2021-10-15  170  	load32		init_stack,%sp
2214c0e77259b4 Helge Deller       2021-10-15  171  	tophys_r1	%sp
366dd4ea9d5f0e Helge Deller       2016-04-13  172  #if defined(CONFIG_64BIT) && defined(CONFIG_FUNCTION_TRACER)
366dd4ea9d5f0e Helge Deller       2016-04-13  173  	.import _mcount,data
366dd4ea9d5f0e Helge Deller       2016-04-13  174  	/* initialize mcount FPTR */
366dd4ea9d5f0e Helge Deller       2016-04-13  175  	/* Get the global data pointer */
366dd4ea9d5f0e Helge Deller       2016-04-13  176  	loadgp
366dd4ea9d5f0e Helge Deller       2016-04-13  177  	load32		PA(_mcount), %r10
366dd4ea9d5f0e Helge Deller       2016-04-13  178  	std		%dp,0x18(%r10)
366dd4ea9d5f0e Helge Deller       2016-04-13  179  #endif
366dd4ea9d5f0e Helge Deller       2016-04-13  180  
0ed1fe4ad394e5 Helge Deller       2018-01-12  181  #ifdef CONFIG_64BIT
0ed1fe4ad394e5 Helge Deller       2018-01-12  182  	/* Get PDCE_PROC for monarch CPU. */
0ed1fe4ad394e5 Helge Deller       2018-01-12  183  #define MEM_PDC_LO 0x388
0ed1fe4ad394e5 Helge Deller       2018-01-12  184  #define MEM_PDC_HI 0x35C
0ed1fe4ad394e5 Helge Deller       2018-01-12  185  	ldw             MEM_PDC_LO(%r0),%r3
0ed1fe4ad394e5 Helge Deller       2018-01-12  186  	ldw             MEM_PDC_HI(%r0),%r10
0ed1fe4ad394e5 Helge Deller       2018-01-12  187  	depd            %r10, 31, 32, %r3        /* move to upper word */
0ed1fe4ad394e5 Helge Deller       2018-01-12  188  #endif
0ed1fe4ad394e5 Helge Deller       2018-01-12  189  
0ed1fe4ad394e5 Helge Deller       2018-01-12  190  
^1da177e4c3f41 Linus Torvalds     2005-04-16  191  #ifdef CONFIG_SMP
25985edcedea63 Lucas De Marchi    2011-03-30  192  	/* Set the smp rendezvous address into page zero.
^1da177e4c3f41 Linus Torvalds     2005-04-16  193  	** It would be safer to do this in init_smp_config() but
^1da177e4c3f41 Linus Torvalds     2005-04-16  194  	** it's just way easier to deal with here because
^1da177e4c3f41 Linus Torvalds     2005-04-16  195  	** of 64-bit function ptrs and the address is local to this file.
^1da177e4c3f41 Linus Torvalds     2005-04-16  196  	*/
^1da177e4c3f41 Linus Torvalds     2005-04-16  197  	load32		PA(smp_slave_stext),%r10
^1da177e4c3f41 Linus Torvalds     2005-04-16  198  	stw		%r10,0x10(%r0)	/* MEM_RENDEZ */
^1da177e4c3f41 Linus Torvalds     2005-04-16  199  	stw		%r0,0x28(%r0)	/* MEM_RENDEZ_HI - assume addr < 4GB */
^1da177e4c3f41 Linus Torvalds     2005-04-16  200  
^1da177e4c3f41 Linus Torvalds     2005-04-16  201  	/* FALLTHROUGH */
^1da177e4c3f41 Linus Torvalds     2005-04-16  202  	.procend
^1da177e4c3f41 Linus Torvalds     2005-04-16  203  
ca45ec3cb44aab Helge Deller       2022-03-25  204  #ifdef CONFIG_HOTPLUG_CPU
ca45ec3cb44aab Helge Deller       2022-03-25  205  	/* common_stext is far away in another section... jump there */
ca45ec3cb44aab Helge Deller       2022-03-25  206  	load32		PA(common_stext), %rp
ca45ec3cb44aab Helge Deller       2022-03-25  207  	bv,n		(%rp)
ca45ec3cb44aab Helge Deller       2022-03-25  208  
ca45ec3cb44aab Helge Deller       2022-03-25  209  	/* common_stext and smp_slave_stext needs to be in text section */
ca45ec3cb44aab Helge Deller       2022-03-25  210  	.text
ca45ec3cb44aab Helge Deller       2022-03-25  211  #endif
ca45ec3cb44aab Helge Deller       2022-03-25  212  
^1da177e4c3f41 Linus Torvalds     2005-04-16  213  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  214  	** Code Common to both Monarch and Slave processors.
^1da177e4c3f41 Linus Torvalds     2005-04-16  215  	** Entry:
^1da177e4c3f41 Linus Torvalds     2005-04-16  216  	**
^1da177e4c3f41 Linus Torvalds     2005-04-16  217  	**  1.1:	
^1da177e4c3f41 Linus Torvalds     2005-04-16  218  	**    %r11 must contain RFI target address.
^1da177e4c3f41 Linus Torvalds     2005-04-16  219  	**    %r25/%r26 args to pass to target function
^1da177e4c3f41 Linus Torvalds     2005-04-16  220  	**    %r2  in case rfi target decides it didn't like something
^1da177e4c3f41 Linus Torvalds     2005-04-16  221  	**
^1da177e4c3f41 Linus Torvalds     2005-04-16  222  	**  2.0w:
^1da177e4c3f41 Linus Torvalds     2005-04-16  223  	**    %r3  PDCE_PROC address
^1da177e4c3f41 Linus Torvalds     2005-04-16  224  	**    %r11 RFI target address
^1da177e4c3f41 Linus Torvalds     2005-04-16  225  	**
^1da177e4c3f41 Linus Torvalds     2005-04-16  226  	** Caller must init: SR4-7, %sp, %r10, %cr24/25, 
^1da177e4c3f41 Linus Torvalds     2005-04-16  227  	*/
^1da177e4c3f41 Linus Torvalds     2005-04-16  228  common_stext:
^1da177e4c3f41 Linus Torvalds     2005-04-16  229  	.proc
^1da177e4c3f41 Linus Torvalds     2005-04-16  230  	.callinfo
^1da177e4c3f41 Linus Torvalds     2005-04-16  231  #else
^1da177e4c3f41 Linus Torvalds     2005-04-16  232  	/* Clear PDC entry point - we won't use it */
^1da177e4c3f41 Linus Torvalds     2005-04-16  233  	stw		%r0,0x10(%r0)	/* MEM_RENDEZ */
^1da177e4c3f41 Linus Torvalds     2005-04-16  234  	stw		%r0,0x28(%r0)	/* MEM_RENDEZ_HI */
^1da177e4c3f41 Linus Torvalds     2005-04-16  235  #endif /*CONFIG_SMP*/
^1da177e4c3f41 Linus Torvalds     2005-04-16  236  
413059f28e9949 Grant Grundler     2005-10-21  237  #ifdef CONFIG_64BIT
2214c0e77259b4 Helge Deller       2021-10-15  238  	mfctl		%cr30,%r6		/* PCX-W2 firmware bug */
2214c0e77259b4 Helge Deller       2021-10-15  239  	tophys_r1	%r6
^1da177e4c3f41 Linus Torvalds     2005-04-16  240  
^1da177e4c3f41 Linus Torvalds     2005-04-16  241  	/* Save the rfi target address */
2214c0e77259b4 Helge Deller       2021-10-15  242  	STREG		%r11,  TASK_PT_GR11(%r6)
^1da177e4c3f41 Linus Torvalds     2005-04-16  243  	/* Switch to wide mode Superdome doesn't support narrow PDC
^1da177e4c3f41 Linus Torvalds     2005-04-16  244  	** calls.
^1da177e4c3f41 Linus Torvalds     2005-04-16  245  	*/
^1da177e4c3f41 Linus Torvalds     2005-04-16  246  1:	mfia            %rp             /* clear upper part of pcoq */
^1da177e4c3f41 Linus Torvalds     2005-04-16  247  	ldo             2f-1b(%rp),%rp
^1da177e4c3f41 Linus Torvalds     2005-04-16  248  	depdi           0,31,32,%rp
^1da177e4c3f41 Linus Torvalds     2005-04-16  249  	bv              (%rp)
^1da177e4c3f41 Linus Torvalds     2005-04-16 @250  	ssm             PSW_SM_W,%r0
^1da177e4c3f41 Linus Torvalds     2005-04-16  251  
^1da177e4c3f41 Linus Torvalds     2005-04-16  252          /* Set Wide mode as the "Default" (eg for traps)
^1da177e4c3f41 Linus Torvalds     2005-04-16  253          ** First trap occurs *right* after (or part of) rfi for slave CPUs.
^1da177e4c3f41 Linus Torvalds     2005-04-16  254          ** Someday, palo might not do this for the Monarch either.
^1da177e4c3f41 Linus Torvalds     2005-04-16  255          */
^1da177e4c3f41 Linus Torvalds     2005-04-16  256  2:
54e181e073fc14 Helge Deller       2013-10-26  257  
^1da177e4c3f41 Linus Torvalds     2005-04-16  258  	ldo             PDC_PSW(%r0),%arg0              /* 21 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  259  	ldo             PDC_PSW_SET_DEFAULTS(%r0),%arg1 /* 2 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  260  	ldo             PDC_PSW_WIDE_BIT(%r0),%arg2     /* 2 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  261  	load32          PA(stext_pdc_ret), %rp
^1da177e4c3f41 Linus Torvalds     2005-04-16  262  	bv              (%r3)
^1da177e4c3f41 Linus Torvalds     2005-04-16  263  	copy            %r0,%arg3
^1da177e4c3f41 Linus Torvalds     2005-04-16  264  
^1da177e4c3f41 Linus Torvalds     2005-04-16  265  stext_pdc_ret:
2214c0e77259b4 Helge Deller       2021-10-15  266  	LDREG		TASK_PT_GR11(%r6), %r11
2214c0e77259b4 Helge Deller       2021-10-15  267  	tovirt_r1	%r6
54e181e073fc14 Helge Deller       2013-10-26  268  	mtctl		%r6,%cr30		/* restore task thread info */
^1da177e4c3f41 Linus Torvalds     2005-04-16  269  #endif
^1da177e4c3f41 Linus Torvalds     2005-04-16  270  	
^1da177e4c3f41 Linus Torvalds     2005-04-16  271  	/* PARANOID: clear user scratch/user space SR's */
^1da177e4c3f41 Linus Torvalds     2005-04-16  272  	mtsp	%r0,%sr0
^1da177e4c3f41 Linus Torvalds     2005-04-16  273  	mtsp	%r0,%sr1
^1da177e4c3f41 Linus Torvalds     2005-04-16  274  	mtsp	%r0,%sr2
^1da177e4c3f41 Linus Torvalds     2005-04-16  275  	mtsp	%r0,%sr3
^1da177e4c3f41 Linus Torvalds     2005-04-16  276  
^1da177e4c3f41 Linus Torvalds     2005-04-16  277  	/* Initialize Protection Registers */
^1da177e4c3f41 Linus Torvalds     2005-04-16  278  	mtctl	%r0,%cr8
^1da177e4c3f41 Linus Torvalds     2005-04-16  279  	mtctl	%r0,%cr9
^1da177e4c3f41 Linus Torvalds     2005-04-16  280  	mtctl	%r0,%cr12
^1da177e4c3f41 Linus Torvalds     2005-04-16  281  	mtctl	%r0,%cr13
^1da177e4c3f41 Linus Torvalds     2005-04-16  282  
^1da177e4c3f41 Linus Torvalds     2005-04-16  283  	/* Initialize the global data pointer */
^1da177e4c3f41 Linus Torvalds     2005-04-16  284  	loadgp
^1da177e4c3f41 Linus Torvalds     2005-04-16  285  
^1da177e4c3f41 Linus Torvalds     2005-04-16  286  	/* Set up our interrupt table.  HPMCs might not work after this! 
^1da177e4c3f41 Linus Torvalds     2005-04-16  287  	 *
^1da177e4c3f41 Linus Torvalds     2005-04-16  288  	 * We need to install the correct iva for PA1.1 or PA2.0. The
^1da177e4c3f41 Linus Torvalds     2005-04-16  289  	 * following short sequence of instructions can determine this
^1da177e4c3f41 Linus Torvalds     2005-04-16  290  	 * (without being illegal on a PA1.1 machine).
^1da177e4c3f41 Linus Torvalds     2005-04-16  291  	 */
413059f28e9949 Grant Grundler     2005-10-21  292  #ifndef CONFIG_64BIT
^1da177e4c3f41 Linus Torvalds     2005-04-16  293  	ldi		32,%r10
^1da177e4c3f41 Linus Torvalds     2005-04-16  294  	mtctl		%r10,%cr11
^1da177e4c3f41 Linus Torvalds     2005-04-16  295  	.level 2.0
^1da177e4c3f41 Linus Torvalds     2005-04-16  296  	mfctl,w		%cr11,%r10
^1da177e4c3f41 Linus Torvalds     2005-04-16  297  	.level 1.1
^1da177e4c3f41 Linus Torvalds     2005-04-16  298  	comib,<>,n	0,%r10,$is_pa20
^1da177e4c3f41 Linus Torvalds     2005-04-16  299  	ldil		L%PA(fault_vector_11),%r10
^1da177e4c3f41 Linus Torvalds     2005-04-16  300  	b		$install_iva
^1da177e4c3f41 Linus Torvalds     2005-04-16  301  	ldo		R%PA(fault_vector_11)(%r10),%r10
^1da177e4c3f41 Linus Torvalds     2005-04-16  302  

:::::: The code at line 120 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
