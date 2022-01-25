Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECF49BDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiAYVU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:20:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:58702 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbiAYVUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643145624; x=1674681624;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1mC3jvFOz6BcF/JErbN9jY4zCH09JH3fVuzVeAT3IJ8=;
  b=IuSCT4+pMNSsjWYxFK7HjJUwopo+y7CxrcBRY+GRMfDAf67OvWExTa/1
   DcykAB6ZH2MEhr4K1tQOOT3rrGNyXTqaNHZmWO5B+WRlWb2TLEPUcYmkh
   Io2P5rOOwVy10dmPRBXm6HWNq8HU1oZ9QiI3Bhm2Tvc1G5ckPi6ia9vPM
   q4eies72tVyf+Xbij1xwXoDfBAIhmx/haeFANzrRoPZ22useb+Vfb4G98
   oEwVNeUMx197fgWZU6Ft3qv3Q9UEt42xoyeb3v+S+nyLxk522GaA54hBW
   SVWVINk6qr7MiqG+kiIzY6LBwe8tUkP65EVGKJMk4iQLwrCF/V2wdaX7L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227092737"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="227092737"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="695991612"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2022 13:20:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCTEj-000KRq-Ms; Tue, 25 Jan 2022 21:20:21 +0000
Date:   Wed, 26 Jan 2022 05:19:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 2/7]
 arch/arm/mach-omap1/ams-delta-fiq-handler.S:272:5: error: expected absolute
 expression
Message-ID: <202201260540.vObCbIBt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
head:   a024fcf01f6ed383d5d22d6784fbba21ac0f4d2a
commit: 18767f88b5593b40e521c45b58af8c0ea7953927 [2/7] linkage: add SYM_{ENTRY,START,END}_AT()
config: arm-omap1_defconfig (https://download.01.org/0day-ci/archive/20220126/202201260540.vObCbIBt-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=18767f88b5593b40e521c45b58af8c0ea7953927
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout 18767f88b5593b40e521c45b58af8c0ea7953927
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/mach-omap1/ams-delta-fiq-handler.S:272:5: error: expected absolute expression
   .if (qwerty_fiqin_end - qwerty_fiqin_start) > (0x200 - 0x1c)
       ^
>> arch/arm/mach-omap1/ams-delta-fiq-handler.S:273:2: error: .err encountered
    .err
    ^


vim +272 arch/arm/mach-omap1/ams-delta-fiq-handler.S

60c3bf3f121545 Janusz Krzysztofik 2010-04-28  167  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  168  	@ r8 still contains GPIO input bits
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  169  	ands r8, r8, #KEYBRD_DATA_MASK		@ is keyboard data line low?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  170  	ldreq r8, [r9, #BUF_KEY]		@ yes - fetch collected so far,
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  171  	orreq r8, r8, r10			@ set 1 at current mask position
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  172  	streq r8, [r9, #BUF_KEY]		@ and save back
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  173  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  174  	mov r10, r10, lsl #1			@ shift mask left
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  175  	bics r10, r10, #0x800			@ have we got all the bits?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  176  	strne r10, [r9, #BUF_MASK]		@ not yet - store the mask
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  177  	bne restart				@ and restart
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  178  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  179  	@ r10 already contains 0, reuse it
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  180  	str r10, [r9, #BUF_STATE]		@ reset state to start
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  181  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  182  	@ Key done - restore interrupt mask
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  183  	ldr r10, [r9, #BUF_GPIO_INT_MASK]	@ fetch saved mask
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  184  	and r11, r11, r10			@ unmask all saved as unmasked
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  185  	str r11, [r12, #OMAP1510_GPIO_INT_MASK]	@ restore into the mask register
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  186  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  187  	@ Try appending the keycode to the circular buffer
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  188  	ldr r10, [r9, #BUF_KEYS_CNT]		@ get saved keystrokes count
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  189  	ldr r8, [r9, #BUF_BUF_LEN]		@ get buffer size
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  190  	cmp r10, r8				@ is buffer full?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  191  	beq hksw				@ yes - key lost, next source
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  192  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  193  	add r10, r10, #1			@ incremet keystrokes counter
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  194  	str r10, [r9, #BUF_KEYS_CNT]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  195  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  196  	ldr r10, [r9, #BUF_TAIL_OFFSET]		@ get buffer tail offset
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  197  	@ r8 already contains buffer size
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  198  	cmp r10, r8				@ end of buffer?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  199  	moveq r10, #0				@ yes - rewind to buffer start
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  200  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  201  	ldr r12, [r9, #BUF_BUFFER_START]	@ get buffer start address
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  202  	add r12, r12, r10, LSL #2		@ calculate buffer tail address
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  203  	ldr r8, [r9, #BUF_KEY]			@ get last keycode
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  204  	str r8, [r12]				@ append it to the buffer tail
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  205  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  206  	add r10, r10, #1			@ increment buffer tail offset
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  207  	str r10, [r9, #BUF_TAIL_OFFSET]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  208  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  209  	ldr r10, [r9, #BUF_CNT_INT_KEY]		@ increment interrupts counter
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  210  	add r10, r10, #1
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  211  	str r10, [r9, #BUF_CNT_INT_KEY]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  212  	@@@@@@@@@@@@@@@@@@@@@@@@
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  213  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  214  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  215  hksw:	@Is hook switch interrupt requested?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  216  	tst r13, #HOOK_SWITCH_MASK 		@ is hook switch status bit set?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  217  	beq mdm					@ no - try next source
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  218  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  219  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  220  	@@@@@@@@@@@@@@@@@@@@@@@@
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  221  	@ Hook switch interrupt FIQ mode simple handler
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  222  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  223  	@ Don't toggle active edge, the switch always bounces
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  224  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  225  	@ Increment hook switch interrupt counter
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  226  	ldr r10, [r9, #BUF_CNT_INT_HSW]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  227  	add r10, r10, #1
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  228  	str r10, [r9, #BUF_CNT_INT_HSW]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  229  	@@@@@@@@@@@@@@@@@@@@@@@@
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  230  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  231  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  232  mdm:	@Is it a modem interrupt?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  233  	tst r13, #MODEM_IRQ_MASK 		@ is modem status bit set?
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  234  	beq irq					@ no - check for next interrupt
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  235  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  236  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  237  	@@@@@@@@@@@@@@@@@@@@@@@@
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  238  	@ Modem FIQ mode interrupt handler stub
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  239  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  240  	@ Increment modem interrupt counter
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  241  	ldr r10, [r9, #BUF_CNT_INT_MDM]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  242  	add r10, r10, #1
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  243  	str r10, [r9, #BUF_CNT_INT_MDM]
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  244  	@@@@@@@@@@@@@@@@@@@@@@@@
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  245  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  246  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  247  irq:	@ Place deferred_fiq interrupt request
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  248  	ldr r12, deferred_fiq_ih_base		@ set pointer to IRQ handler
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  249  	mov r10, #DEFERRED_FIQ_MASK		@ set deferred_fiq bit
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  250  	str r10, [r12, #IRQ_ISR_REG_OFFSET] 	@ place it in the ISR register
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  251  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  252  	ldr r12, omap1510_gpio_base		@ set pointer back to GPIO bank
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  253  	b restart				@ check for next GPIO interrupt
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  254  	@@@@@@@@@@@@@@@@@@@@@@@@@@@
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  255  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  256  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  257  /*
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  258   * Virtual addresses for IO
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  259   */
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  260  omap_ih1_base:
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  261  	.word OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  262  deferred_fiq_ih_base:
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  263  	.word OMAP1_IO_ADDRESS(DEFERRED_FIQ_IH_BASE)
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  264  omap1510_gpio_base:
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  265  	.word OMAP1_IO_ADDRESS(OMAP1510_GPIO_BASE)
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  266  qwerty_fiqin_end:
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  267  
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  268  /*
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  269   * Check the size of the FIQ,
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  270   * it cannot go beyond 0xffff0200, and is copied to 0xffff001c
60c3bf3f121545 Janusz Krzysztofik 2010-04-28  271   */
60c3bf3f121545 Janusz Krzysztofik 2010-04-28 @272  .if (qwerty_fiqin_end - qwerty_fiqin_start) > (0x200 - 0x1c)
60c3bf3f121545 Janusz Krzysztofik 2010-04-28 @273  	.err

:::::: The code at line 272 was first introduced by commit
:::::: 60c3bf3f1215453a4f30f0b91db7fd301d558693 OMAP1: Amstrad Delta: add FIQ handler for serial keyboardport interrupt processing

:::::: TO: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
:::::: CC: Tony Lindgren <tony@atomide.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
