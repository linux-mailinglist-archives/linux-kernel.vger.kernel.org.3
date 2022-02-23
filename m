Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49B44C0B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiBWFLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiBWFKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:10:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA7674E1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645593019; x=1677129019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VkIlCTKu/Ajt9hsKrHvbW/AW/3dptdRZcGy7KrznaWs=;
  b=kAEEVdyUqFgXNwmuV6V50CbosnxoVAQoST7vZYro3AQ79qE/qjiJ1/LA
   7fGwhMx/8AjEg8HXilQlRPJ9HlexdgR+khsPmxXin4MBTBGhLkpDuccQD
   In3NklfnnMi6XF8SQTu65pZAdlXmJ+GxDNtbW5Vel0A4w/tb7DJ58G6Cw
   3lxT1+0BXwS9XUu/oziwWhx4YL/omoiuORU8VayeJtehtv+Um2k+F3W3p
   Zu9GX1UYvPXNT2IG7Kv0brCUMV9F7o6wSxtiKNN/pFRQCUk6WFyv+s66q
   jb4BPHKwPi5EYm+PG80l/00Z6unlzcvmM14KBB4UFRN4ElYqMSSdCvrx2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252076128"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="252076128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 21:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532531609"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 21:10:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMjup-00010C-It; Wed, 23 Feb 2022 05:10:15 +0000
Date:   Wed, 23 Feb 2022 13:10:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2000/2324]
 arch/mips/kernel/irq-msc01.c:29:40: warning: declaration of 'struct
 irq_data' will not be visible outside of this function
Message-ID: <202202231337.vXRfwNhS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   7d9efc989eceed6a8fa475a186880ec4a1ad54a3
commit: 59438ff3251170bd7d1c9795532bd3dcc127e3f2 [2000/2324] headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/hardirq.h>
config: mips-malta_kvm_defconfig (https://download.01.org/0day-ci/archive/20220223/202202231337.vXRfwNhS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=59438ff3251170bd7d1c9795532bd3dcc127e3f2
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 59438ff3251170bd7d1c9795532bd3dcc127e3f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ arch/mips/mti-malta/ arch/mips/pci/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/irq-msc01.c:29:40: warning: declaration of 'struct irq_data' will not be visible outside of this function [-Wvisibility]
   static inline void mask_msc_irq(struct irq_data *d)
                                          ^
   arch/mips/kernel/irq-msc01.c:31:22: error: incomplete definition of type 'struct irq_data'
           unsigned int irq = d->irq;
                              ~^
   arch/mips/kernel/irq-msc01.c:29:40: note: forward declaration of 'struct irq_data'
   static inline void mask_msc_irq(struct irq_data *d)
                                          ^
   arch/mips/kernel/irq-msc01.c:40:42: warning: declaration of 'struct irq_data' will not be visible outside of this function [-Wvisibility]
   static inline void unmask_msc_irq(struct irq_data *d)
                                            ^
   arch/mips/kernel/irq-msc01.c:42:22: error: incomplete definition of type 'struct irq_data'
           unsigned int irq = d->irq;
                              ~^
   arch/mips/kernel/irq-msc01.c:40:42: note: forward declaration of 'struct irq_data'
   static inline void unmask_msc_irq(struct irq_data *d)
                                            ^
   arch/mips/kernel/irq-msc01.c:53:47: warning: declaration of 'struct irq_data' will not be visible outside of this function [-Wvisibility]
   static void level_mask_and_ack_msc_irq(struct irq_data *d)
                                                 ^
   arch/mips/kernel/irq-msc01.c:55:15: error: incompatible pointer types passing 'struct irq_data *' to parameter of type 'struct irq_data *' [-Werror,-Wincompatible-pointer-types]
           mask_msc_irq(d);
                        ^
   arch/mips/kernel/irq-msc01.c:29:50: note: passing argument to parameter 'd' here
   static inline void mask_msc_irq(struct irq_data *d)
                                                    ^
   arch/mips/kernel/irq-msc01.c:63:46: warning: declaration of 'struct irq_data' will not be visible outside of this function [-Wvisibility]
   static void edge_mask_and_ack_msc_irq(struct irq_data *d)
                                                ^
   arch/mips/kernel/irq-msc01.c:65:22: error: incomplete definition of type 'struct irq_data'
           unsigned int irq = d->irq;
                              ~^
   arch/mips/kernel/irq-msc01.c:63:46: note: forward declaration of 'struct irq_data'
   static void edge_mask_and_ack_msc_irq(struct irq_data *d)
                                                ^
   arch/mips/kernel/irq-msc01.c:67:15: error: incompatible pointer types passing 'struct irq_data *' to parameter of type 'struct irq_data *' [-Werror,-Wincompatible-pointer-types]
           mask_msc_irq(d);
                        ^
   arch/mips/kernel/irq-msc01.c:29:50: note: passing argument to parameter 'd' here
   static inline void mask_msc_irq(struct irq_data *d)
                                                    ^
   arch/mips/kernel/irq-msc01.c:100:24: error: variable has incomplete type 'struct irq_chip'
   static struct irq_chip msc_levelirq_type = {
                          ^
   arch/mips/kernel/irq-msc01.c:100:15: note: forward declaration of 'struct irq_chip'
   static struct irq_chip msc_levelirq_type = {
                 ^
   arch/mips/kernel/irq-msc01.c:109:24: error: variable has incomplete type 'struct irq_chip'
   static struct irq_chip msc_edgeirq_type = {
                          ^
   arch/mips/kernel/irq-msc01.c:100:15: note: forward declaration of 'struct irq_chip'
   static struct irq_chip msc_levelirq_type = {
                 ^
   arch/mips/kernel/irq-msc01.c:133:4: error: implicit declaration of function 'irq_set_chip_and_handler_name' [-Werror,-Wimplicit-function-declaration]
                           irq_set_chip_and_handler_name(irqbase + n,
                           ^
   arch/mips/kernel/irq-msc01.c:135:13: error: use of undeclared identifier 'handle_edge_irq'
                                                         handle_edge_irq,
                                                         ^
   arch/mips/kernel/irq-msc01.c:145:13: error: use of undeclared identifier 'handle_level_irq'
                                                         handle_level_irq,
                                                         ^
   4 warnings and 10 errors generated.


vim +29 arch/mips/kernel/irq-msc01.c

^1da177e4c3f415 Linus Torvalds  2005-04-16  27  
^1da177e4c3f415 Linus Torvalds  2005-04-16  28  /* mask off an interrupt */
e15883da8a8b83c Thomas Gleixner 2011-03-23 @29  static inline void mask_msc_irq(struct irq_data *d)
^1da177e4c3f415 Linus Torvalds  2005-04-16  30  {
e15883da8a8b83c Thomas Gleixner 2011-03-23  31  	unsigned int irq = d->irq;
e15883da8a8b83c Thomas Gleixner 2011-03-23  32  
^1da177e4c3f415 Linus Torvalds  2005-04-16  33  	if (irq < (irq_base + 32))
^1da177e4c3f415 Linus Torvalds  2005-04-16  34  		MSCIC_WRITE(MSC01_IC_DISL, 1<<(irq - irq_base));
^1da177e4c3f415 Linus Torvalds  2005-04-16  35  	else
^1da177e4c3f415 Linus Torvalds  2005-04-16  36  		MSCIC_WRITE(MSC01_IC_DISH, 1<<(irq - irq_base - 32));
^1da177e4c3f415 Linus Torvalds  2005-04-16  37  }
^1da177e4c3f415 Linus Torvalds  2005-04-16  38  

:::::: The code at line 29 was first introduced by commit
:::::: e15883da8a8b83c73bf1ba030cddeb2cfd92a555 MIPS: MSC01: Convert to new irq_chip functions

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
