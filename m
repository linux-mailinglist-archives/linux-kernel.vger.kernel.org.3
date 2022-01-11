Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586D148AD48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiAKMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:05:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:36355 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239371AbiAKMF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641902726; x=1673438726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Pl3Yr1VoyfWZ0FytrVKMJG0yxKQVlWzUrX+IHTcq3o=;
  b=goczb2hXG1uWtRrgTqEw2xoaQG2ytJlhZYG3OmuQ65gF1K9HmfCnF1Gu
   qBvcdtmho3M1+DNCpeoDwpfMcWLpuouLYtEkT/zgJ7AFx/CVXwJz2Vm2j
   Prp8kITVxy1tPqaff5p1z3IxrpB3M0hJV8QM5LE0oCu52yMOAF5mWJRu/
   ivJfY+d2mEzo9uCv1G0FPTFk9YgoILP7eoCKlKA7SOlYRUQcvLzS/Lfoz
   gsb68L+1Kws3+6XmfaNklnu9ddy98nl1O94FaLT0WIL/veGxGVGbNR8Xa
   AItQJdhDU1HlJ+tNTjCZGwmrN2U1PFDqhllfR0X7uFEfyV10XQbTmC1vd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306821468"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="306821468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 04:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="558340056"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Jan 2022 04:05:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7Fty-0004qx-FT; Tue, 11 Jan 2022 12:05:22 +0000
Date:   Tue, 11 Jan 2022 20:04:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 26/28] drivers/tty/serial/bcm63xx_uart.c:321:28:
 error: 'struct uart_state' has no member named 'xmit'
Message-ID: <202201111941.4kV1TQCj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   cbecb229fb3c6579d6cb05972974c1b8bab2c2c6
commit: f299889e2a33e2adcc167a30482852a9a1ce9ea2 [26/28] tty: serial, use kfifo
config: arm-randconfig-c002-20220111 (https://download.01.org/0day-ci/archive/20220111/202201111941.4kV1TQCj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=f299889e2a33e2adcc167a30482852a9a1ce9ea2
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout f299889e2a33e2adcc167a30482852a9a1ce9ea2
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/bcm63xx_uart.c: In function 'bcm_uart_do_tx':
>> drivers/tty/serial/bcm63xx_uart.c:321:28: error: 'struct uart_state' has no member named 'xmit'
     321 |         xmit = &port->state->xmit;
         |                            ^~
>> drivers/tty/serial/bcm63xx_uart.c:322:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     322 |         if (uart_circ_empty(xmit))
         |             ^~~~~~~~~~~~~~~
>> drivers/tty/serial/bcm63xx_uart.c:332:25: error: invalid use of undefined type 'struct circ_buf'
     332 |                 c = xmit->buf[xmit->tail];
         |                         ^~
   drivers/tty/serial/bcm63xx_uart.c:332:35: error: invalid use of undefined type 'struct circ_buf'
     332 |                 c = xmit->buf[xmit->tail];
         |                                   ^~
   drivers/tty/serial/bcm63xx_uart.c:334:21: error: invalid use of undefined type 'struct circ_buf'
     334 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/bcm63xx_uart.c:334:35: error: invalid use of undefined type 'struct circ_buf'
     334 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                   ^~
>> drivers/tty/serial/bcm63xx_uart.c:340:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     340 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/sccnxp.c: In function 'sccnxp_handle_tx':
>> drivers/tty/serial/sccnxp.c:443:45: error: 'struct uart_state' has no member named 'xmit'
     443 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/sccnxp.c:453:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     453 |         if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
         |             ^~~~~~~~~~~~~~~
>> drivers/tty/serial/sccnxp.c:470:61: error: invalid use of undefined type 'struct circ_buf'
     470 |                 sccnxp_port_write(port, SCCNXP_THR_REG, xmit->buf[xmit->tail]);
         |                                                             ^~
   drivers/tty/serial/sccnxp.c:470:71: error: invalid use of undefined type 'struct circ_buf'
     470 |                 sccnxp_port_write(port, SCCNXP_THR_REG, xmit->buf[xmit->tail]);
         |                                                                       ^~
   drivers/tty/serial/sccnxp.c:471:21: error: invalid use of undefined type 'struct circ_buf'
     471 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/sccnxp.c:471:35: error: invalid use of undefined type 'struct circ_buf'
     471 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                   ^~
>> drivers/tty/serial/sccnxp.c:475:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     475 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/uartlite.c: In function 'ulite_transmit':
>> drivers/tty/serial/uartlite.c:190:46: error: 'struct uart_state' has no member named 'xmit'
     190 |         struct circ_buf *xmit  = &port->state->xmit;
         |                                              ^~
>> drivers/tty/serial/uartlite.c:202:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     202 |         if (uart_circ_empty(xmit) || uart_tx_stopped(port))
         |             ^~~~~~~~~~~~~~~
>> drivers/tty/serial/uartlite.c:205:24: error: invalid use of undefined type 'struct circ_buf'
     205 |         uart_out32(xmit->buf[xmit->tail], ULITE_TX, port);
         |                        ^~
   drivers/tty/serial/uartlite.c:205:34: error: invalid use of undefined type 'struct circ_buf'
     205 |         uart_out32(xmit->buf[xmit->tail], ULITE_TX, port);
         |                                  ^~
   drivers/tty/serial/uartlite.c:206:13: error: invalid use of undefined type 'struct circ_buf'
     206 |         xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
         |             ^~
   drivers/tty/serial/uartlite.c:206:27: error: invalid use of undefined type 'struct circ_buf'
     206 |         xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
         |                           ^~
>> drivers/tty/serial/uartlite.c:210:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     210 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/altera_jtaguart.c: In function 'altera_jtaguart_tx_chars':
>> drivers/tty/serial/altera_jtaguart.c:140:45: error: 'struct uart_state' has no member named 'xmit'
     140 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/altera_jtaguart.c:151:19: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     151 |         pending = uart_circ_chars_pending(xmit);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/arm/include/uapi/asm/byteorder.h:22,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arm/include/asm/bitops.h:267,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from drivers/tty/serial/altera_jtaguart.c:12:
>> drivers/tty/serial/altera_jtaguart.c:161:44: error: invalid use of undefined type 'struct circ_buf'
     161 |                                 writel(xmit->buf[xmit->tail],
         |                                            ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   arch/arm/include/asm/io.h:311:47: note: in expansion of macro 'writel_relaxed'
     311 | #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
         |                                               ^~~~~~~~~~~~~~
   drivers/tty/serial/altera_jtaguart.c:161:33: note: in expansion of macro 'writel'
     161 |                                 writel(xmit->buf[xmit->tail],
         |                                 ^~~~~~
   drivers/tty/serial/altera_jtaguart.c:161:54: error: invalid use of undefined type 'struct circ_buf'
     161 |                                 writel(xmit->buf[xmit->tail],
         |                                                      ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   arch/arm/include/asm/io.h:311:47: note: in expansion of macro 'writel_relaxed'
     311 | #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
         |                                               ^~~~~~~~~~~~~~
   drivers/tty/serial/altera_jtaguart.c:161:33: note: in expansion of macro 'writel'
     161 |                                 writel(xmit->buf[xmit->tail],
         |                                 ^~~~~~
   drivers/tty/serial/altera_jtaguart.c:163:37: error: invalid use of undefined type 'struct circ_buf'
     163 |                                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                     ^~
   drivers/tty/serial/altera_jtaguart.c:163:51: error: invalid use of undefined type 'struct circ_buf'
     163 |                                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                                   ^~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/rp2.c: In function 'rp2_tx_chars':
>> drivers/tty/serial/rp2.c:432:48: error: 'struct uart_state' has no member named 'xmit'
     432 |         struct circ_buf *xmit = &up->port.state->xmit;
         |                                                ^~
>> drivers/tty/serial/rp2.c:446:21: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     446 |                 if (uart_circ_empty(xmit)) {
         |                     ^~~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from drivers/tty/serial/rp2.c:23:
>> drivers/tty/serial/rp2.c:450:28: error: invalid use of undefined type 'struct circ_buf'
     450 |                 writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
         |                            ^~
   arch/arm/include/asm/io.h:301:46: note: in definition of macro 'writeb_relaxed'
     301 | #define writeb_relaxed(v,c)     __raw_writeb(v,c)
         |                                              ^
   drivers/tty/serial/rp2.c:450:17: note: in expansion of macro 'writeb'
     450 |                 writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
         |                 ^~~~~~
   drivers/tty/serial/rp2.c:450:38: error: invalid use of undefined type 'struct circ_buf'
     450 |                 writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
         |                                      ^~
   arch/arm/include/asm/io.h:301:46: note: in definition of macro 'writeb_relaxed'
     301 | #define writeb_relaxed(v,c)     __raw_writeb(v,c)
         |                                              ^
   drivers/tty/serial/rp2.c:450:17: note: in expansion of macro 'writeb'
     450 |                 writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
         |                 ^~~~~~
   drivers/tty/serial/rp2.c:451:21: error: invalid use of undefined type 'struct circ_buf'
     451 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/rp2.c:451:35: error: invalid use of undefined type 'struct circ_buf'
     451 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                   ^~
>> drivers/tty/serial/rp2.c:455:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     455 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/tty/serial/fsl_lpuart.c:275:33: error: field 'rx_ring' has incomplete type
     275 |         struct circ_buf         rx_ring;
         |                                 ^~~~~~~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart_dma_tx':
>> drivers/tty/serial/fsl_lpuart.c:471:51: error: 'struct uart_state' has no member named 'xmit'
     471 |         struct circ_buf *xmit = &sport->port.state->xmit;
         |                                                   ^~
>> drivers/tty/serial/fsl_lpuart.c:480:31: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     480 |         sport->dma_tx_bytes = uart_circ_chars_pending(xmit);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/fsl_lpuart.c:482:17: error: invalid use of undefined type 'struct circ_buf'
     482 |         if (xmit->tail < xmit->head || xmit->head == 0) {
         |                 ^~
   drivers/tty/serial/fsl_lpuart.c:482:30: error: invalid use of undefined type 'struct circ_buf'
     482 |         if (xmit->tail < xmit->head || xmit->head == 0) {
         |                              ^~
   drivers/tty/serial/fsl_lpuart.c:482:44: error: invalid use of undefined type 'struct circ_buf'
     482 |         if (xmit->tail < xmit->head || xmit->head == 0) {
         |                                            ^~
   drivers/tty/serial/fsl_lpuart.c:484:38: error: invalid use of undefined type 'struct circ_buf'
     484 |                 sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
         |                                      ^~
   drivers/tty/serial/fsl_lpuart.c:484:50: error: invalid use of undefined type 'struct circ_buf'
     484 |                 sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
         |                                                  ^~
   drivers/tty/serial/fsl_lpuart.c:488:37: error: invalid use of undefined type 'struct circ_buf'
     488 |                 sg_set_buf(sgl, xmit->buf + xmit->tail,
         |                                     ^~
   drivers/tty/serial/fsl_lpuart.c:488:49: error: invalid use of undefined type 'struct circ_buf'
     488 |                 sg_set_buf(sgl, xmit->buf + xmit->tail,
         |                                                 ^~
   drivers/tty/serial/fsl_lpuart.c:489:54: error: invalid use of undefined type 'struct circ_buf'
     489 |                                 UART_XMIT_SIZE - xmit->tail);
         |                                                      ^~
   drivers/tty/serial/fsl_lpuart.c:490:41: error: invalid use of undefined type 'struct circ_buf'
     490 |                 sg_set_buf(sgl + 1, xmit->buf, xmit->head);
         |                                         ^~
   drivers/tty/serial/fsl_lpuart.c:490:52: error: invalid use of undefined type 'struct circ_buf'
     490 |                 sg_set_buf(sgl + 1, xmit->buf, xmit->head);
         |                                                    ^~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart_stopped_or_empty':
>> drivers/tty/serial/fsl_lpuart.c:519:16: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     519 |         return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
         |                ^~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_lpuart.c:519:44: error: 'struct uart_state' has no member named 'xmit'
     519 |         return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
         |                                            ^~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart_dma_tx_complete':
   drivers/tty/serial/fsl_lpuart.c:526:51: error: 'struct uart_state' has no member named 'xmit'
     526 |         struct circ_buf *xmit = &sport->port.state->xmit;
         |                                                   ^~
   drivers/tty/serial/fsl_lpuart.c:539:13: error: invalid use of undefined type 'struct circ_buf'
     539 |         xmit->tail = (xmit->tail + sport->dma_tx_bytes) & (UART_XMIT_SIZE - 1);
         |             ^~
   drivers/tty/serial/fsl_lpuart.c:539:27: error: invalid use of undefined type 'struct circ_buf'
     539 |         xmit->tail = (xmit->tail + sport->dma_tx_bytes) & (UART_XMIT_SIZE - 1);
         |                           ^~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart_transmit_buffer':
   drivers/tty/serial/fsl_lpuart.c:746:51: error: 'struct uart_state' has no member named 'xmit'
     746 |         struct circ_buf *xmit = &sport->port.state->xmit;
         |                                                   ^~
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from drivers/tty/serial/fsl_lpuart.c:11:
   drivers/tty/serial/fsl_lpuart.c:762:28: error: invalid use of undefined type 'struct circ_buf'
     762 |                 writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
         |                            ^~
   arch/arm/include/asm/io.h:301:46: note: in definition of macro 'writeb_relaxed'
     301 | #define writeb_relaxed(v,c)     __raw_writeb(v,c)
         |                                              ^
   drivers/tty/serial/fsl_lpuart.c:762:17: note: in expansion of macro 'writeb'
     762 |                 writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
         |                 ^~~~~~
   drivers/tty/serial/fsl_lpuart.c:762:38: error: invalid use of undefined type 'struct circ_buf'
     762 |                 writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
         |                                      ^~
   arch/arm/include/asm/io.h:301:46: note: in definition of macro 'writeb_relaxed'
     301 | #define writeb_relaxed(v,c)     __raw_writeb(v,c)
         |                                              ^
   drivers/tty/serial/fsl_lpuart.c:762:17: note: in expansion of macro 'writeb'
     762 |                 writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
         |                 ^~~~~~
   drivers/tty/serial/fsl_lpuart.c:763:21: error: invalid use of undefined type 'struct circ_buf'
     763 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/fsl_lpuart.c:763:35: error: invalid use of undefined type 'struct circ_buf'
     763 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                   ^~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart32_transmit_buffer':
   drivers/tty/serial/fsl_lpuart.c:776:51: error: 'struct uart_state' has no member named 'xmit'
     776 |         struct circ_buf *xmit = &sport->port.state->xmit;
         |                                                   ^~
   drivers/tty/serial/fsl_lpuart.c:795:50: error: invalid use of undefined type 'struct circ_buf'
     795 |                 lpuart32_write(&sport->port, xmit->buf[xmit->tail], UARTDATA);
         |                                                  ^~
   drivers/tty/serial/fsl_lpuart.c:795:60: error: invalid use of undefined type 'struct circ_buf'
     795 |                 lpuart32_write(&sport->port, xmit->buf[xmit->tail], UARTDATA);
         |                                                            ^~
   drivers/tty/serial/fsl_lpuart.c:796:21: error: invalid use of undefined type 'struct circ_buf'
     796 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/fsl_lpuart.c:796:35: error: invalid use of undefined type 'struct circ_buf'
     796 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                   ^~
   drivers/tty/serial/fsl_lpuart.c: In function 'lpuart_handle_sysrq':
   drivers/tty/serial/fsl_lpuart.c:1096:17: error: invalid use of undefined type 'struct circ_buf'
    1096 |         if (ring->head < ring->tail) {
         |                 ^~
   drivers/tty/serial/fsl_lpuart.c:1096:30: error: invalid use of undefined type 'struct circ_buf'
    1096 |         if (ring->head < ring->tail) {
         |                              ^~
   drivers/tty/serial/fsl_lpuart.c:1097:52: error: invalid use of undefined type 'struct circ_buf'
    1097 |                 count = sport->rx_sgl.length - ring->tail;
         |                                                    ^~
   drivers/tty/serial/fsl_lpuart.c:1099:47: error: invalid use of undefined type 'struct circ_buf'
    1099 |                                           ring->buf + ring->tail, count);
         |                                               ^~
   drivers/tty/serial/fsl_lpuart.c:1099:59: error: invalid use of undefined type 'struct circ_buf'
    1099 |                                           ring->buf + ring->tail, count);
         |                                                           ^~
   drivers/tty/serial/fsl_lpuart.c:1100:21: error: invalid use of undefined type 'struct circ_buf'
    1100 |                 ring->tail = 0;
         |                     ^~
   drivers/tty/serial/fsl_lpuart.c:1103:17: error: invalid use of undefined type 'struct circ_buf'
    1103 |         if (ring->head > ring->tail) {
         |                 ^~
   drivers/tty/serial/fsl_lpuart.c:1103:30: error: invalid use of undefined type 'struct circ_buf'
    1103 |         if (ring->head > ring->tail) {
         |                              ^~
   drivers/tty/serial/fsl_lpuart.c:1104:29: error: invalid use of undefined type 'struct circ_buf'
    1104 |                 count = ring->head - ring->tail;
         |                             ^~
   drivers/tty/serial/fsl_lpuart.c:1104:42: error: invalid use of undefined type 'struct circ_buf'
    1104 |                 count = ring->head - ring->tail;
         |                                          ^~
   drivers/tty/serial/fsl_lpuart.c:1106:47: error: invalid use of undefined type 'struct circ_buf'
    1106 |                                           ring->buf + ring->tail, count);
         |                                               ^~
   drivers/tty/serial/fsl_lpuart.c:1106:59: error: invalid use of undefined type 'struct circ_buf'
    1106 |                                           ring->buf + ring->tail, count);
         |                                                           ^~
   drivers/tty/serial/fsl_lpuart.c:1107:21: error: invalid use of undefined type 'struct circ_buf'
--
   drivers/tty/serial/8250/8250_exar.c: In function 'exar_shutdown':
>> drivers/tty/serial/8250/8250_exar.c:200:45: error: 'struct uart_state' has no member named 'xmit'
     200 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/8250/8250_exar.c:210:19: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     210 |         } while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
         |                   ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +321 drivers/tty/serial/bcm63xx_uart.c

9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  299  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  300  /*
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  301   * fill tx fifo with chars to send, stop when fifo is about to be full
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  302   * or when all chars have been sent.
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  303   */
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  304  static void bcm_uart_do_tx(struct uart_port *port)
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  305  {
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  306  	struct circ_buf *xmit;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  307  	unsigned int val, max_count;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  308  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  309  	if (port->x_char) {
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  310  		bcm_uart_writel(port, port->x_char, UART_FIFO_REG);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  311  		port->icount.tx++;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  312  		port->x_char = 0;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  313  		return;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  314  	}
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  315  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  316  	if (uart_tx_stopped(port)) {
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  317  		bcm_uart_stop_tx(port);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  318  		return;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  319  	}
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  320  
b037179f7a4fff drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-11-15 @321  	xmit = &port->state->xmit;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18 @322  	if (uart_circ_empty(xmit))
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  323  		goto txq_empty;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  324  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  325  	val = bcm_uart_readl(port, UART_MCTL_REG);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  326  	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  327  	max_count = port->fifosize - val;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  328  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  329  	while (max_count--) {
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  330  		unsigned int c;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  331  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18 @332  		c = xmit->buf[xmit->tail];
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  333  		bcm_uart_writel(port, c, UART_FIFO_REG);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  334  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  335  		port->icount.tx++;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  336  		if (uart_circ_empty(xmit))
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  337  			break;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  338  	}
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  339  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18 @340  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  341  		uart_write_wakeup(port);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  342  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  343  	if (uart_circ_empty(xmit))
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  344  		goto txq_empty;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  345  	return;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  346  
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  347  txq_empty:
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  348  	/* nothing to send, disable transmit interrupt */
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  349  	val = bcm_uart_readl(port, UART_IR_REG);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  350  	val &= ~UART_TX_INT_MASK;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  351  	bcm_uart_writel(port, val, UART_IR_REG);
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  352  	return;
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  353  }
9fcd66e572b949 drivers/serial/bcm63xx_uart.c Maxime Bizon 2009-09-18  354  

:::::: The code at line 321 was first introduced by commit
:::::: b037179f7a4fff7bd8279b0568a7dc663ebc9d15 bcm63xx_uart: Fix serial driver compile breakage.

:::::: TO: Maxime Bizon <mbizon@freebox.fr>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
