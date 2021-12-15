Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B48476435
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhLOVGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:06:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:35725 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232391AbhLOVGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639602380; x=1671138380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y4quxCLBCGf2zusvpSQA3hzLPeXbPLNNmvqQlyXb6nI=;
  b=bGfxe2rlF4MK5MUhB6cOmQ2Q31Nziwy18gkX5wSvYwHQVWC1i7nqaC8X
   hQLmbCmZfjfkgA88mlnL2KWFhAblGZZ3Xym/BJmsw83fREsfnd6YjFdcu
   LFNvtqtpT7g/aqUW9PvtNnWifNl7oBSVhS9EQ2zvPox1acsFPhFMBPIUg
   2SYTBvUckB1zSffTJ4AM8st5QLl73Jveal9JqJ0XTabZ+VLyGTCALzPoC
   oR7YjTjjYvY4pe9oCiZiXpoef4Cc2QDrVn48MbgV5PTX5Bj6Mi/Yb3a/i
   UlEqRPjsdtrxYsIoxDtD8U4+uU8RiGjvZ73kxJSzOqMjf7q/PrJcSm+zT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226195049"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="226195049"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 13:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="505998429"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 13:06:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxbTd-0002L1-Sd; Wed, 15 Dec 2021 21:06:17 +0000
Date:   Thu, 16 Dec 2021 05:06:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 21/33] drivers/tty/mxser.c:826:22: error: 'port'
 undeclared; did you mean 'uport'?
Message-ID: <202112160529.SiB1wC6L-lkp@intel.com>
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
config: arc-randconfig-r043-20211214 (https://download.01.org/0day-ci/archive/20211216/202112160529.SiB1wC6L-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=5726d981962bcf45daa931de98923a2aab063487
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 5726d981962bcf45daa931de98923a2aab063487
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/tty_port.h:5,
                    from include/linux/tty.h:12,
                    from drivers/tty/mxser.c:24:
   drivers/tty/mxser.c: In function 'mxser_startup':
>> drivers/tty/mxser.c:826:22: error: 'port' undeclared (first use in this function); did you mean 'uport'?
     826 |         kfifo_reset(&port->xmit_fifo);
         |                      ^~~~
   include/linux/kfifo.h:211:17: note: in definition of macro 'kfifo_reset'
     211 |         typeof((fifo) + 1) __tmp = (fifo); \
         |                 ^~~~
   drivers/tty/mxser.c:826:22: note: each undeclared identifier is reported only once for each function it appears in
     826 |         kfifo_reset(&port->xmit_fifo);
         |                      ^~~~
   include/linux/kfifo.h:211:17: note: in definition of macro 'kfifo_reset'
     211 |         typeof((fifo) + 1) __tmp = (fifo); \
         |                 ^~~~
>> include/linux/kfifo.h:212:14: error: invalid type argument of '->' (have 'int')
     212 |         __tmp->kfifo.in = __tmp->kfifo.out = 0; \
         |              ^~
   drivers/tty/mxser.c:826:9: note: in expansion of macro 'kfifo_reset'
     826 |         kfifo_reset(&port->xmit_fifo);
         |         ^~~~~~~~~~~
   include/linux/kfifo.h:212:32: error: invalid type argument of '->' (have 'int')
     212 |         __tmp->kfifo.in = __tmp->kfifo.out = 0; \
         |                                ^~
   drivers/tty/mxser.c:826:9: note: in expansion of macro 'kfifo_reset'
     826 |         kfifo_reset(&port->xmit_fifo);
         |         ^~~~~~~~~~~
   At top level:
   drivers/tty/mxser.c:1744:30: warning: 'mxser_ops' defined but not used [-Wunused-const-variable=]
    1744 | static const struct uart_ops mxser_ops = {
         |                              ^~~~~~~~~


vim +826 drivers/tty/mxser.c

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
