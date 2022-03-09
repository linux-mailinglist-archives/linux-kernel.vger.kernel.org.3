Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE74D3681
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiCIRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiCIRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:11:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29749549A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646845431; x=1678381431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HOmDKk/DNrN7aBjthi1FUjW7CrepgbXivAjIJAfp/Kg=;
  b=QENyO+/yvlTxeyDrlpSUksIM/3O0IxLmtALV1tDf/cF/wl6lHb/XG2Oj
   fAEVbxqePgVrnHKtiDVM0KFgrp8WynBMuzVXiFO3iW8uNiH37I2ourz3E
   w+rAXFL20EhKG9OC5IZhkQRDUdcpOSt1AxiWL3WzHzQ8sQIUgeepYbrF2
   +ATSEkztHwxpbno/qY1fFohvXOCldqV94W0csH32MabhOSFodXar8jkjy
   kQgxazdFPKjT04+bmY/CmVxa+Jsoj2HfxFHMTos/BkpltfS3lZ5J8kUrj
   bHl9QSHGSJhUafmO68d8bQFuhPnIVp3KFZ9DEPYTTIbNZ/SrzshuX+lWE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252599499"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="252599499"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 08:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="611421476"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2022 08:51:17 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRzWu-0003ZV-G9; Wed, 09 Mar 2022 16:51:16 +0000
Date:   Thu, 10 Mar 2022 00:50:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm/kernel/entry-common.S:166: Error: co-processor register
 expected -- `mcr p15,0,r0,c7,r5,4'
Message-ID: <202203100022.bfK7WDH2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: b9baf5c8c5c356757f4f9d8180b5e9d234065bc3 ARM: Spectre-BHB workaround
date:   4 days ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220310/202203100022.bfK7WDH2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9baf5c8c5c356757f4f9d8180b5e9d234065bc3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b9baf5c8c5c356757f4f9d8180b5e9d234065bc3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/kernel/entry-common.S: Assembler messages:
>> arch/arm/kernel/entry-common.S:166: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/kernel/entry-common.S:175: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/kernel/entry-armv.S: Assembler messages:
>> arch/arm/kernel/entry-armv.S:1090: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/kernel/entry-armv.S:1113: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/kernel/entry-armv.S:1136: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/kernel/entry-armv.S:1159: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/kernel/entry-armv.S:1198: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/kernel/hyp-stub.S: Assembler messages:
>> arch/arm/kernel/hyp-stub.S:173: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mm/cache-v7.S: Assembler messages:
>> arch/arm/mm/cache-v7.S:42: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mm/cache-v7.S:69: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mm/cache-v7.S:142: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mm/cache-v7.S:179: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mm/cache-v7.S:312: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mm/tlb-v7.S: Assembler messages:
>> arch/arm/mm/tlb-v7.S:85: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mm/proc-v7-2level.S: Assembler messages:
>> arch/arm/mm/proc-v7-2level.S:55: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mm/proc-v7-2level.S:57: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
>> arch/arm/mm/proc-v7.S:59: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mm/proc-v7.S:183: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/common/secure_cntvoff.S: Assembler messages:
>> arch/arm/common/secure_cntvoff.S:24: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/common/secure_cntvoff.S:27: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/common/secure_cntvoff.S:29: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mach-imx/suspend-imx6.S: Assembler messages:
>> arch/arm/mach-imx/suspend-imx6.S:315: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mach-omap2/sleep34xx.S: Assembler messages:
>> arch/arm/mach-omap2/sleep34xx.S:174: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mach-omap2/sleep34xx.S:308: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mach-omap2/sleep33xx.S: Assembler messages:
>> arch/arm/mach-omap2/sleep33xx.S:58: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mach-omap2/sleep33xx.S:125: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mach-omap2/sleep33xx.S:192: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
--
   arch/arm/mach-omap2/sleep43xx.S: Assembler messages:
>> arch/arm/mach-omap2/sleep43xx.S:98: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
   arch/arm/mach-omap2/sleep43xx.S:320: Error: co-processor register expected -- `mcr p15,0,r0,c7,r5,4'
..


vim +166 arch/arm/kernel/entry-common.S

   150	
   151	/*=============================================================================
   152	 * SWI handler
   153	 *-----------------------------------------------------------------------------
   154	 */
   155	
   156		.align	5
   157	#ifdef CONFIG_HARDEN_BRANCH_HISTORY
   158	ENTRY(vector_bhb_loop8_swi)
   159		sub	sp, sp, #PT_REGS_SIZE
   160		stmia	sp, {r0 - r12}
   161		mov	r8, #8
   162	1:	b	2f
   163	2:	subs	r8, r8, #1
   164		bne	1b
   165		dsb
 > 166		isb
   167		b	3f
   168	ENDPROC(vector_bhb_loop8_swi)
   169	
   170		.align	5
   171	ENTRY(vector_bhb_bpiall_swi)
   172		sub	sp, sp, #PT_REGS_SIZE
   173		stmia	sp, {r0 - r12}
   174		mcr	p15, 0, r8, c7, c5, 6	@ BPIALL
   175		isb
   176		b	3f
   177	ENDPROC(vector_bhb_bpiall_swi)
   178	#endif
   179		.align	5
   180	ENTRY(vector_swi)
   181	#ifdef CONFIG_CPU_V7M
   182		v7m_exception_entry
   183	#else
   184		sub	sp, sp, #PT_REGS_SIZE
   185		stmia	sp, {r0 - r12}			@ Calling r0 - r12
   186	3:
   187	 ARM(	add	r8, sp, #S_PC		)
   188	 ARM(	stmdb	r8, {sp, lr}^		)	@ Calling sp, lr
   189	 THUMB(	mov	r8, sp			)
   190	 THUMB(	store_user_sp_lr r8, r10, S_SP	)	@ calling sp, lr
   191		mrs	saved_psr, spsr			@ called from non-FIQ mode, so ok.
   192	 TRACE(	mov	saved_pc, lr		)
   193		str	saved_pc, [sp, #S_PC]		@ Save calling PC
   194		str	saved_psr, [sp, #S_PSR]		@ Save CPSR
   195		str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
   196	#endif
   197		reload_current r10, ip
   198		zero_fp
   199		alignment_trap r10, ip, __cr_alignment
   200		asm_trace_hardirqs_on save=0
   201		enable_irq_notrace
   202		ct_user_exit save=0
   203	
   204		/*
   205		 * Get the system call number.
   206		 */
   207	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
