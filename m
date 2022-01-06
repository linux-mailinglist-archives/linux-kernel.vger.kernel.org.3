Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32E6486120
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiAFHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:49:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:30416 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235603AbiAFHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641455352; x=1672991352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z76HLmMWgPv2sngcLho3m1fyMUtOrl07VgzjC7cEFrI=;
  b=WkepuwcMB3ix3LpChd+y0FSckKhN+28lPtS7gN9Syb63tXGFrH8oTiES
   YuqC+Hbg7YrJw9kPYxFewyEMSxS+6QfWrxVTy1K2KLpJ0HhRdIgxPeteY
   0mIYDZE6bcEd96ucsFFCgEuVVBBBbuxDFv3TWWoL1gMwR88PxN4pKGphA
   KBc+Hz9cJtXYoW53ySKMTG5x09wN4/5pQx+jC0bIR/7vRxqU4xpOy/5+L
   Ft+MRDlNLxfuTqGFqJnznizIVJIgMHlInlgfcV8ohE9JRIHFlf0PYUJP+
   I04WKJItwLHYmsYDXQ9tlHTSgJssJRhQcfN+fKqyZMYpoaObWAvJ4cRBj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328960103"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="328960103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 23:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="526878144"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 23:49:09 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5NWG-000HSn-RD; Thu, 06 Jan 2022 07:49:08 +0000
Date:   Thu, 6 Jan 2022 15:48:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 22/31] drivers/tty/mxser.c:771:34: error: use of
 undeclared identifier 'flags'
Message-ID: <202201061517.idmER6xz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   be0ceaad1e9d19def7c3344c8af61e80785f4326
commit: 8ffc6c8c0af9b2365bcd837ea4faed75bcecdaa8 [22/31] mxser: switch to uart_driver
config: i386-randconfig-r021-20220105 (https://download.01.org/0day-ci/archive/20220106/202201061517.idmER6xz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=8ffc6c8c0af9b2365bcd837ea4faed75bcecdaa8
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 8ffc6c8c0af9b2365bcd837ea4faed75bcecdaa8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/mxser.c:771:34: error: use of undeclared identifier 'flags'
           spin_lock_irqsave(&uport->lock, flags);
                                           ^
>> drivers/tty/mxser.c:771:34: error: use of undeclared identifier 'flags'
   drivers/tty/mxser.c:774:40: error: use of undeclared identifier 'flags'
                   spin_unlock_irqrestore(&uport->lock, flags);
                                                        ^
   drivers/tty/mxser.c:790:40: error: use of undeclared identifier 'flags'
                   spin_unlock_irqrestore(&uport->lock, flags);
                                                        ^
   drivers/tty/mxser.c:828:39: error: use of undeclared identifier 'flags'
           spin_unlock_irqrestore(&uport->lock, flags);
                                                ^
>> drivers/tty/mxser.c:878:25: error: use of undeclared identifier 'port'; did you mean 'uport'?
           tty_port_free_xmit_buf(port);
                                  ^~~~
                                  uport
   drivers/tty/mxser.c:852:46: note: 'uport' declared here
   static void mxser_shutdown(struct uart_port *uport)
                                                ^
   6 errors generated.


vim +/flags +771 drivers/tty/mxser.c

ee7e5e66f2d4fa drivers/tty/mxser.c  Jiri Slaby     2021-09-22  763  
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  764  static int mxser_startup(struct uart_port *uport)
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  765  {
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  766  	struct mxser_port *info = to_mport(uport);
373f755a1748c2 drivers/tty/mxser.c  Jiri Slaby     2021-12-16  767  	int ret;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  768  
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  769  	BUG_ON("we use kfifo");
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  770  
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10 @771  	spin_lock_irqsave(&uport->lock, flags);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  772  
83eaabf7a151de drivers/tty/mxser.c  Jiri Slaby     2021-12-10  773  	if (!uport->type) {
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  774  		spin_unlock_irqrestore(&uport->lock, flags);
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  775  		return -EINVAL;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  776  	}
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
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  789  	if (inb(uport->iobase + UART_LSR) == 0xff) {
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  790  		spin_unlock_irqrestore(&uport->lock, flags);
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  791  		return -ENODEV;
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  792  	}
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  793  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  794  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  795  	 * Clear the interrupt registers.
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  796  	 */
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  797  	(void) inb(uport->iobase + UART_LSR);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  798  	(void) inb(uport->iobase + UART_RX);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  799  	(void) inb(uport->iobase + UART_IIR);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  800  	(void) inb(uport->iobase + UART_MSR);
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  801  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  802  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  803  	 * Now, initialize the UART
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  804  	 */
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  805  	outb(UART_LCR_WLEN8, uport->iobase + UART_LCR);	/* reset DLAB */
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  806  	info->MCR = UART_MCR_DTR | UART_MCR_RTS;
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  807  	outb(info->MCR, uport->iobase + UART_MCR);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  808  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  809  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  810  	 * Finally, enable interrupts
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  811  	 */
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  812  	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  813  
292955a7c011e2 drivers/tty/mxser.c  Jiri Slaby     2021-06-18  814  	if (info->board->must_hwid)
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  815  		info->IER |= MOXA_MUST_IER_EGDAI;
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  816  	outb(info->IER, uport->iobase + UART_IER);	/* enable interrupts */
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  817  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  818  	/*
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  819  	 * And clear the interrupt registers again for luck.
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  820  	 */
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  821  	(void) inb(uport->iobase + UART_LSR);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  822  	(void) inb(uport->iobase + UART_RX);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  823  	(void) inb(uport->iobase + UART_IIR);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  824  	(void) inb(uport->iobase + UART_MSR);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  825  
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  826  	//kfifo_reset(&port->xmit_fifo);
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  827  	BUG_ON("kfifo_reset");
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  828  	spin_unlock_irqrestore(&uport->lock, flags);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  829  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  830  	return 0;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  831  }
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  832  
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  833  /*
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  834   * To stop accepting input, we disable the receive line status interrupts, and
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  835   * tell the interrupt driver to stop checking the data ready bit in the line
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  836   * status register.
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  837   */
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  838  static void mxser_stop_rx(struct uart_port *uport)
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  839  {
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  840  	struct mxser_port *info = to_mport(uport);
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  841  
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  842  	info->IER &= ~UART_IER_RLSI;
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  843  	if (info->board->must_hwid)
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  844  		info->IER &= ~MOXA_MUST_RECV_ISR;
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  845  
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  846  	outb(info->IER, uport->iobase + UART_IER);
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  847  }
47b722d473824e drivers/tty/mxser.c  Jiri Slaby     2021-11-18  848  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  849  /*
6769140d304731 drivers/char/mxser.c Alan Cox       2009-11-30  850   * This routine will shutdown a serial port
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  851   */
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  852  static void mxser_shutdown(struct uart_port *uport)
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  853  {
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  854  	struct mxser_port *info = to_mport(uport);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  855  	unsigned long flags;
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  856  
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  857  	spin_lock_irqsave(&uport->lock, flags);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  858  
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  859  	BUG_ON("we use kfifo");
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  860  	info->IER = 0;
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  861  	outb(0x00, uport->iobase + UART_IER);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  862  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  863  	/* clear Rx/Tx FIFO's */
ee7e5e66f2d4fa drivers/tty/mxser.c  Jiri Slaby     2021-09-22  864  	mxser_disable_and_clear_FIFO(info);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  865  
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  866  	/* read data port to reset things */
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  867  	(void) inb(uport->iobase + UART_RX);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  868  
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  869  
292955a7c011e2 drivers/tty/mxser.c  Jiri Slaby     2021-06-18  870  	if (info->board->must_hwid)
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  871  		mxser_must_no_sw_flow_control(uport->iobase);
1c45607ad3eb73 drivers/char/mxser.c Jiri Slaby     2008-02-07  872  
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  873  	spin_unlock_irqrestore(&uport->lock, flags);
eca514dff1f0d6 drivers/tty/mxser.c  Jiri Slaby     2021-12-15  874  
eca514dff1f0d6 drivers/tty/mxser.c  Jiri Slaby     2021-12-15  875  	/* make sure ISR is not running while we free the buffer */
eca514dff1f0d6 drivers/tty/mxser.c  Jiri Slaby     2021-12-15  876  	synchronize_irq(info->board->irq);
eca514dff1f0d6 drivers/tty/mxser.c  Jiri Slaby     2021-12-15  877  
eca514dff1f0d6 drivers/tty/mxser.c  Jiri Slaby     2021-12-15 @878  	tty_port_free_xmit_buf(port);
^1da177e4c3f41 drivers/char/mxser.c Linus Torvalds 2005-04-16  879  }
8ffc6c8c0af9b2 drivers/tty/mxser.c  Jiri Slaby     2021-12-01  880  #ifdef OLD
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  881  static void mxser_flush_buffer(struct tty_struct *tty)
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  882  {
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  883  	struct mxser_port *info = tty->driver_data;
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  884  	struct uart_port *uport = &info->uport;
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  885  	unsigned long flags;
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  886  
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  887  	spin_lock_irqsave(&uport->lock, flags);
eca514dff1f0d6 drivers/tty/mxser.c  Jiri Slaby     2021-12-15  888  	kfifo_reset(&info->port.xmit_fifo);
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  889  
d249e662c3e4a9 drivers/tty/mxser.c  Jiri Slaby     2021-09-22  890  	outb(info->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
e07871afd5d4cd drivers/tty/mxser.c  Jiri Slaby     2021-12-10  891  		uport->iobase + UART_FCR);
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  892  
06ce2597d9cf82 drivers/tty/mxser.c  Jiri Slaby     2021-12-10  893  	spin_unlock_irqrestore(&uport->lock, flags);
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  894  
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  895  	tty_wakeup(tty);
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  896  }
978e595f88a1fb drivers/char/mxser.c Alan Cox       2008-04-30  897  

:::::: The code at line 771 was first introduced by commit
:::::: 06ce2597d9cf82d60bb9871edad91d75e53b10cd mxser: use lock from uart_port

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Jiri Slaby <jslaby@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
