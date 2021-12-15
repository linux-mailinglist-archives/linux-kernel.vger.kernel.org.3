Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFA24766CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhLOX71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:59:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:51354 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhLOX70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639612766; x=1671148766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RiY1ihhZKdu+YcvMfbiNQ1cZB6IklN5zMWxNq+cHgPo=;
  b=X/VyzY6SyAL8rsGf2FDd0hmfqoPTCBVkrK9HtPk/+zzgyFRAh5sZAmlq
   +gGqfVeDQvKgIY7hZzfjB1cXxon3Aj/+LyzKQRl8Q3MUXJKYMXw1DVVE+
   ew4UHAZDi2R04pWsHKztlOqL5J0sTmOH+g/AlRHbot4bdwOyTQFyVWcri
   VTsgtU7levZIP8Ri7eDB6TZB///OuPLofVsQCK7WC0qHEN/kx5jPwvxxN
   9TkFpjAkEubRAB+Wuqg92aCO7FA5mgkvij5fiaTzgoFHqzH7h1yGrwIRi
   AeI9hCyLaqxpmEco5gwK5rRpmxPtalk8W2Ysk8sFeL1pPYHXIuebASdJr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226221969"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="226221969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 15:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="682710342"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2021 15:59:24 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxeB9-0002VM-FR; Wed, 15 Dec 2021 23:59:23 +0000
Date:   Thu, 16 Dec 2021 07:59:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 21/33] drivers/tty/mxser.c:826:15: error: use of
 undeclared identifier 'port'
Message-ID: <202112160704.5dKPWYFQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   d61595c5423534810c1a3c0d4a88dd2fd81d750c
commit: 5726d981962bcf45daa931de98923a2aab063487 [21/33] mxser: switch to uart_driver
config: i386-randconfig-a013-20211214 (https://download.01.org/0day-ci/archive/20211216/202112160704.5dKPWYFQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=5726d981962bcf45daa931de98923a2aab063487
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 5726d981962bcf45daa931de98923a2aab063487
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/mxser.c:826:15: error: use of undeclared identifier 'port'
           kfifo_reset(&port->xmit_fifo);
                        ^
>> drivers/tty/mxser.c:826:15: error: use of undeclared identifier 'port'
   2 errors generated.


vim +/port +826 drivers/tty/mxser.c

ee7e5e66f2d4fa drivers/tty/mxser.c  Jiri Slaby     2021-09-22  763  
5726d981962bcf drivers/tty/mxser.c  Jiri Slaby     2021-12-01  764  static int mxser_startup(struct uart_port *uport)
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  765  {
5726d981962bcf drivers/tty/mxser.c  Jiri Slaby     2021-12-01  766  	struct mxser_port *info = to_mport(uport);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  767  	unsigned long flags;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  768  
22d394f9712b7c drivers/tty/mxser.c  Jiri Slaby     2021-12-10  769  	spin_lock_irqsave(&uport->lock, flags);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  770  
e13da5a8a148c0 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  771  	if (!uport->type) {
22d394f9712b7c drivers/tty/mxser.c  Jiri Slaby     2021-12-10  772  		spin_unlock_irqrestore(&uport->lock, flags);
5726d981962bcf drivers/tty/mxser.c  Jiri Slaby     2021-12-01  773  		return -EINVAL;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  774  	}
94c7e3efe3b70b drivers/tty/mxser.c  Jiri Slaby     2021-12-15  775  
5726d981962bcf drivers/tty/mxser.c  Jiri Slaby     2021-12-01  776  	BUG_ON("we use kfifo");
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  777  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  778  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  779  	 * Clear the FIFO buffers and disable them
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  780  	 * (they will be reenabled in mxser_change_speed())
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  781  	 */
ee7e5e66f2d4fa drivers/tty/mxser.c  Jiri Slaby     2021-09-22  782  	mxser_disable_and_clear_FIFO(info);
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  783  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  784  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  785  	 * At this point there's no way the LSR could still be 0xFF;
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  786  	 * if it is, then bail out, because there's likely no UART
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  787  	 * here.
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  788  	 */
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  789  	if (inb(uport->iobase + UART_LSR) == 0xff) {
22d394f9712b7c drivers/tty/mxser.c  Jiri Slaby     2021-12-10  790  		spin_unlock_irqrestore(&uport->lock, flags);
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  791  		return -ENODEV;
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  792  	}
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  793  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  794  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  795  	 * Clear the interrupt registers.
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  796  	 */
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  797  	(void) inb(uport->iobase + UART_LSR);
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  798  	(void) inb(uport->iobase + UART_RX);
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  799  	(void) inb(uport->iobase + UART_IIR);
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  800  	(void) inb(uport->iobase + UART_MSR);
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  801  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  802  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  803  	 * Now, initialize the UART
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  804  	 */
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  805  	outb(UART_LCR_WLEN8, uport->iobase + UART_LCR);	/* reset DLAB */
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  806  	info->MCR = UART_MCR_DTR | UART_MCR_RTS;
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  807  	outb(info->MCR, uport->iobase + UART_MCR);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  808  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  809  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  810  	 * Finally, enable interrupts
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  811  	 */
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  812  	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  813  
292955a7c011e2 drivers/tty/mxser.c  Jiri Slaby     2021-06-18  814  	if (info->board->must_hwid)
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  815  		info->IER |= MOXA_MUST_IER_EGDAI;
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  816  	outb(info->IER, uport->iobase + UART_IER);	/* enable interrupts */
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  817  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  818  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  819  	 * And clear the interrupt registers again for luck.
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  820  	 */
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  821  	(void) inb(uport->iobase + UART_LSR);
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  822  	(void) inb(uport->iobase + UART_RX);
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  823  	(void) inb(uport->iobase + UART_IIR);
ea78327711f406 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  824  	(void) inb(uport->iobase + UART_MSR);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  825  
94c7e3efe3b70b drivers/tty/mxser.c  Jiri Slaby     2021-12-15 @826  	kfifo_reset(&port->xmit_fifo);
22d394f9712b7c drivers/tty/mxser.c  Jiri Slaby     2021-12-10  827  	spin_unlock_irqrestore(&uport->lock, flags);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  828  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  829  	return 0;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  830  }
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  831  

:::::: The code at line 826 was first introduced by commit
:::::: 94c7e3efe3b70b291054ac2344013c35b314ffe6 mxser: switch from xmit_buf to kfifo

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Jiri Slaby <jslaby@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
