Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52B4855AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbiAEPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:18:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:10213 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241250AbiAEPSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641395887; x=1672931887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MWiSuCJpagYqhavigSaG/LFF8iuYmhjSKs9hnJmB200=;
  b=mTl1PJ0wtKMJl8P+bQ1JIVfWNG1/AWxKvfNuhIPvpJC6hxEmylBZxO9C
   C17xvHfLMzo5FIuPHnLf+L7Ycz0IvJJ0wrK/Ts4fDG66NQEofH4JwwnjM
   kUmL/DJlJSmCVsqVC3dWuCFa/iUQhQ0XH8N1saCwqhmRaojJSkMjgCcDE
   QYBQT4A0FQumvH/KXBzYnpyL30QTf9xq2/NTbWmCUCTJURP86j50K/9b5
   EgHsZI7WnRBwdgkpidDt6tXqjLyNHUpL2dY4UPeTSu/deqcQj0Qm7SEFk
   XUMH24n1Umrp0MemWxAZlyRyh1brgIkHWYXKawxzPhfy8rF5FEO+7jXus
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266742488"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="266742488"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="488603895"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2022 07:17:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n582p-000Gml-VX; Wed, 05 Jan 2022 15:17:43 +0000
Date:   Wed, 5 Jan 2022 23:17:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 22/31] drivers/tty/mxser.c:771:34: error: use of
 undeclared identifier 'flags'
Message-ID: <202201052300.9n7DrKZ8-lkp@intel.com>
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
config: riscv-buildonly-randconfig-r005-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052300.9n7DrKZ8-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=8ffc6c8c0af9b2365bcd837ea4faed75bcecdaa8
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 8ffc6c8c0af9b2365bcd837ea4faed75bcecdaa8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/mxser.c:23:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/tty/mxser.c:23:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/tty/mxser.c:23:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
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
   drivers/tty/mxser.c:878:25: error: use of undeclared identifier 'port'; did you mean 'uport'?
           tty_port_free_xmit_buf(port);
                                  ^~~~
                                  uport
   drivers/tty/mxser.c:852:46: note: 'uport' declared here
   static void mxser_shutdown(struct uart_port *uport)
                                                ^
   7 warnings and 6 errors generated.


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

:::::: The code at line 771 was first introduced by commit
:::::: 06ce2597d9cf82d60bb9871edad91d75e53b10cd mxser: use lock from uart_port

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Jiri Slaby <jslaby@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
