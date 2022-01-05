Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9264851DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbiAELdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:33:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:10510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239715AbiAELdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641382420; x=1672918420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cAxGsIBNZn2sLHu95NdTtck000wWK6pCJC67f6Tcaks=;
  b=U3mAt/xQkxcDilwAwvuxn4DqO7rUedVfj5lkTJdIFFh60FAZvHuQehO9
   kW+aGHSG942Q0IkYGz6KV3fm3m060gnj7Mx5pXqp87gVtdlo2yL1g9j9t
   pCA3zFmWwW1LB9+ySMWw2Y17OfyzDdv9jygm3GJBEgFxPdPFXq3aIRL5r
   DeXf4eTA0ZMK5h1dui8q21UhbF58Hn0H0NTZLIJ+NLr8hZ8STpmeFVUVh
   4iPCtoPbiqSPBMAywgQFdWFA9+sQB/HhN8fVG8MmWNX+4y8FUw5pHC2Tn
   PcUfhQQHrBvYnqRxXuJRepqu5WG4DbZFrNfB4Zt+XpneG0HXVj96UPLji
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242628970"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="242628970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 03:33:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="526491466"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 03:33:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n54Xx-000GYG-4k; Wed, 05 Jan 2022 11:33:37 +0000
Date:   Wed, 5 Jan 2022 19:33:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [l1k:rs485_fixes 8/8] drivers/tty/serial/8250/8250_omap.c:327:2:
 error: implicit declaration of function 'serial8250_set_mctrl'
Message-ID: <202201051919.S2AM5Jqq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux rs485_fixes
head:   5545dfa04324da44dd044c03e7c13a7d6066f47e
commit: 5545dfa04324da44dd044c03e7c13a7d6066f47e [8/8] serial: 8250: 8250_omap: Avoid rs485 RTS glitch on set_termios
config: riscv-buildonly-randconfig-r002-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051919.S2AM5Jqq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/l1k/linux/commit/5545dfa04324da44dd044c03e7c13a7d6066f47e
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k rs485_fixes
        git checkout 5545dfa04324da44dd044c03e7c13a7d6066f47e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/8250/8250_omap.c:13:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/tty/serial/8250/8250_omap.c:13:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/tty/serial/8250/8250_omap.c:13:
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
>> drivers/tty/serial/8250/8250_omap.c:327:2: error: implicit declaration of function 'serial8250_set_mctrl' [-Werror,-Wimplicit-function-declaration]
           serial8250_set_mctrl(&up->port, up->port.mctrl);
           ^
   drivers/tty/serial/8250/8250_omap.c:327:2: note: did you mean 'serial8250_do_set_mctrl'?
   include/linux/serial_8250.h:167:13: note: 'serial8250_do_set_mctrl' declared here
   extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
               ^
   7 warnings and 1 error generated.


vim +/serial8250_set_mctrl +327 drivers/tty/serial/8250/8250_omap.c

   290	
   291	static void omap8250_restore_regs(struct uart_8250_port *up)
   292	{
   293		struct omap8250_priv *priv = up->port.private_data;
   294		struct uart_8250_dma	*dma = up->dma;
   295	
   296		if (dma && dma->tx_running) {
   297			/*
   298			 * TCSANOW requests the change to occur immediately however if
   299			 * we have a TX-DMA operation in progress then it has been
   300			 * observed that it might stall and never complete. Therefore we
   301			 * delay DMA completes to prevent this hang from happen.
   302			 */
   303			priv->delayed_restore = 1;
   304			return;
   305		}
   306	
   307		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
   308		serial_out(up, UART_EFR, UART_EFR_ECB);
   309	
   310		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
   311		serial8250_out_MCR(up, serial8250_in_MCR(up) | UART_MCR_TCRTLR);
   312		serial_out(up, UART_FCR, up->fcr);
   313	
   314		omap8250_update_scr(up, priv);
   315	
   316		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
   317	
   318		serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_RESTORE(16) |
   319				OMAP_UART_TCR_HALT(52));
   320		serial_out(up, UART_TI752_TLR,
   321			   TRIGGER_TLR_MASK(priv->tx_trigger) << UART_TI752_TLR_TX |
   322			   TRIGGER_TLR_MASK(priv->rx_trigger) << UART_TI752_TLR_RX);
   323	
   324		serial_out(up, UART_LCR, 0);
   325	
   326		/* drop TCR + TLR access, we setup XON/XOFF later */
 > 327		serial8250_set_mctrl(&up->port, up->port.mctrl);
   328		serial_out(up, UART_IER, up->ier);
   329	
   330		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
   331		serial_dl_write(up, priv->quot);
   332	
   333		serial_out(up, UART_EFR, priv->efr);
   334	
   335		/* Configure flow control */
   336		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
   337		serial_out(up, UART_XON1, priv->xon);
   338		serial_out(up, UART_XOFF1, priv->xoff);
   339	
   340		serial_out(up, UART_LCR, up->lcr);
   341	
   342		omap8250_update_mdr1(up, priv);
   343	}
   344	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
