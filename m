Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C646547800
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiFLAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiFLAYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:24:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4993C738
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654993493; x=1686529493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s2yd087xkW4KLFMyvGWmmYjBvU3/+pjKWQHoBft3F4Q=;
  b=fyd1KKWPEJPrk+NpWp4ne7APA9cbqTlHcuDI2ja8nP+u7bjhvR8Ye64C
   97FScxkc4sfQOF6JOp69MZejhHzb45SAcvLIgfxYPuKwnNYK5oQDyciYz
   xHR2LjD6MynVEoWQMxxmPVo1XpmOMrYZHrG0z54jSrCQTaQ+3w9AkkGFt
   znfjvgMxqMeMTtDaKAXTXrDsI8g7Q84/n7Q0aihtDwNAn9vxPNEkAoJRM
   IMSnz9fAKGr7OiR2iuV6J+a8LYru7H8Utw5o5VR0c6eB6RsxJ/Vagi08u
   911VJzupmwcd9fyNN4neayVPWtf6xyqDH8Q0kDTo7NaPaG6gIBp1KsyB/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="257793932"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="257793932"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 17:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="725609642"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2022 17:24:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0BPN-000JSg-J0;
        Sun, 12 Jun 2022 00:24:49 +0000
Date:   Sun, 12 Jun 2022 08:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/m68k/68000/ints.c:82:30: error: 'ISR' undeclared
Message-ID: <202206120828.ShiYm445-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0678afa6055d14799c1dc1eee47c8025eba56cab
commit: 6b8be804ff376f6657ccdf6b29974e7c793d88c4 m68knommu: fix 68000 CPU link with no platform selected
date:   3 weeks ago
config: m68k-randconfig-r025-20220612 (https://download.01.org/0day-ci/archive/20220612/202206120828.ShiYm445-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b8be804ff376f6657ccdf6b29974e7c793d88c4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6b8be804ff376f6657ccdf6b29974e7c793d88c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/68000/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/m68k/68000/ints.c:77:6: warning: no previous prototype for 'process_int' [-Wmissing-prototypes]
      77 | void process_int(int vec, struct pt_regs *fp)
         |      ^~~~~~~~~~~
   arch/m68k/68000/ints.c: In function 'process_int':
>> arch/m68k/68000/ints.c:82:30: error: 'ISR' undeclared (first use in this function)
      82 |         unsigned long pend = ISR;
         |                              ^~~
   arch/m68k/68000/ints.c:82:30: note: each undeclared identifier is reported only once for each function it appears in
   arch/m68k/68000/ints.c: In function 'intc_irq_unmask':
>> arch/m68k/68000/ints.c:135:9: error: 'IMR' undeclared (first use in this function)
     135 |         IMR &= ~(1 << d->irq);
         |         ^~~
   arch/m68k/68000/ints.c: In function 'intc_irq_mask':
   arch/m68k/68000/ints.c:140:9: error: 'IMR' undeclared (first use in this function)
     140 |         IMR |= (1 << d->irq);
         |         ^~~
   arch/m68k/68000/ints.c: At top level:
   arch/m68k/68000/ints.c:153:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
     153 | void __init trap_init(void)
         |             ^~~~~~~~~
   arch/m68k/68000/ints.c:172:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     172 | void __init init_IRQ(void)
         |             ^~~~~~~~
   arch/m68k/68000/ints.c: In function 'init_IRQ':
>> arch/m68k/68000/ints.c:176:9: error: 'IVR' undeclared (first use in this function)
     176 |         IVR = 0x40; /* Set DragonBall IVR (interrupt base) to 64 */
         |         ^~~
   arch/m68k/68000/ints.c:179:9: error: 'IMR' undeclared (first use in this function)
     179 |         IMR = ~0;
         |         ^~~


vim +/ISR +82 arch/m68k/68000/ints.c

^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   70  
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   71  /* The 68k family did not have a good way to determine the source
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   72   * of interrupts until later in the family.  The EC000 core does
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   73   * not provide the vector number on the stack, we vector everything
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   74   * into one vector and look in the blasted mask register...
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   75   * This code is designed to be fast, almost constant time, not clean!
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   76   */
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   77  void process_int(int vec, struct pt_regs *fp)
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   78  {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   79  	int irq;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   80  	int mask;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   81  
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  @82  	unsigned long pend = ISR;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   83  
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   84  	while (pend) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   85  		if (pend & 0x0000ffff) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   86  			if (pend & 0x000000ff) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   87  				if (pend & 0x0000000f) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   88  					mask = 0x00000001;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   89  					irq = 0;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   90  				} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   91  					mask = 0x00000010;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   92  					irq = 4;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   93  				}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   94  			} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   95  				if (pend & 0x00000f00) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   96  					mask = 0x00000100;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   97  					irq = 8;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   98  				} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16   99  					mask = 0x00001000;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  100  					irq = 12;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  101  				}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  102  			}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  103  		} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  104  			if (pend & 0x00ff0000) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  105  				if (pend & 0x000f0000) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  106  					mask = 0x00010000;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  107  					irq = 16;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  108  				} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  109  					mask = 0x00100000;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  110  					irq = 20;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  111  				}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  112  			} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  113  				if (pend & 0x0f000000) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  114  					mask = 0x01000000;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  115  					irq = 24;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  116  				} else {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  117  					mask = 0x10000000;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  118  					irq = 28;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  119  				}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  120  			}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  121  		}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  122  
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  123  		while (! (mask & pend)) {
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  124  			mask <<=1;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  125  			irq++;
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  126  		}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  127  
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  128  		do_IRQ(irq, fp);
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  129  		pend &= ~mask;
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  130  	}
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  131  }
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  132  
39a17940abc4d0 arch/m68knommu/platform/68328/ints.c Thomas Gleixner 2011-02-06  133  static void intc_irq_unmask(struct irq_data *d)
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  134  {
39a17940abc4d0 arch/m68knommu/platform/68328/ints.c Thomas Gleixner 2011-02-06 @135  	IMR &= ~(1 << d->irq);
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  136  }
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  137  
39a17940abc4d0 arch/m68knommu/platform/68328/ints.c Thomas Gleixner 2011-02-06  138  static void intc_irq_mask(struct irq_data *d)
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  139  {
39a17940abc4d0 arch/m68knommu/platform/68328/ints.c Thomas Gleixner 2011-02-06  140  	IMR |= (1 << d->irq);
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  141  }
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  142  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  143  static struct irq_chip intc_irq_chip = {
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  144  	.name		= "M68K-INTC",
39a17940abc4d0 arch/m68knommu/platform/68328/ints.c Thomas Gleixner 2011-02-06  145  	.irq_mask	= intc_irq_mask,
39a17940abc4d0 arch/m68knommu/platform/68328/ints.c Thomas Gleixner 2011-02-06  146  	.irq_unmask	= intc_irq_unmask,
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  147  };
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  148  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  149  /*
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  150   * This function should be called during kernel startup to initialize
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  151   * the machine vector table.
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  152   */
622e9472dd723d arch/m68k/platform/68328/ints.c      Greg Ungerer    2011-06-23  153  void __init trap_init(void)
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  154  {
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  155  	int i;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  156  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  157  	/* set up the vectors */
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  158  	for (i = 72; i < 256; ++i)
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  159  		_ramvec[i] = (e_vector) bad_interrupt;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  160  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  161  	_ramvec[32] = system_call;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  162  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  163  	_ramvec[65] = (e_vector) inthandler1;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  164  	_ramvec[66] = (e_vector) inthandler2;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  165  	_ramvec[67] = (e_vector) inthandler3;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  166  	_ramvec[68] = (e_vector) inthandler4;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  167  	_ramvec[69] = (e_vector) inthandler5;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  168  	_ramvec[70] = (e_vector) inthandler6;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  169  	_ramvec[71] = (e_vector) inthandler7;
622e9472dd723d arch/m68k/platform/68328/ints.c      Greg Ungerer    2011-06-23  170  }
622e9472dd723d arch/m68k/platform/68328/ints.c      Greg Ungerer    2011-06-23  171  
622e9472dd723d arch/m68k/platform/68328/ints.c      Greg Ungerer    2011-06-23  172  void __init init_IRQ(void)
622e9472dd723d arch/m68k/platform/68328/ints.c      Greg Ungerer    2011-06-23  173  {
622e9472dd723d arch/m68k/platform/68328/ints.c      Greg Ungerer    2011-06-23  174  	int i;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  175  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01 @176  	IVR = 0x40; /* Set DragonBall IVR (interrupt base) to 64 */
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  177  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  178  	/* turn off all interrupts */
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  179  	IMR = ~0;
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  180  
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  181  	for (i = 0; (i < NR_IRQS); i++) {
0b98b1636cf2e1 arch/m68k/platform/68328/ints.c      Thomas Gleixner 2011-03-28  182  		irq_set_chip(i, &intc_irq_chip);
0b98b1636cf2e1 arch/m68k/platform/68328/ints.c      Thomas Gleixner 2011-03-28  183  		irq_set_handler(i, handle_level_irq);
1985d2538cccdc arch/m68knommu/platform/68328/ints.c Greg Ungerer    2009-05-01  184  	}
^1da177e4c3f41 arch/m68knommu/platform/68328/ints.c Linus Torvalds  2005-04-16  185  }
2502b667ea835e arch/m68knommu/platform/68328/ints.c Greg Ungerer    2007-07-19  186  

:::::: The code at line 82 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
