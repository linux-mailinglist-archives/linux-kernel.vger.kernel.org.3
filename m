Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083B4FC1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348547AbiDKQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbiDKQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:12:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B53D1CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649693376; x=1681229376;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OLci2HLkgvtNLraSOE6x66701yZnLmVewModuX72G/M=;
  b=LiqgELdB/B2cAsi/vPi2Mz1IZn6mcYEsz6/UQ9ZJbg34RS9YN41A6gvb
   eFe1pemZvQBeuZ5FquiPtjyFl3CR8pu6LM3QpIlM2VHLp+Nt2D2mgKEEA
   /htrV2ehJ2dL/urRRkPI/wx9c6q7kP7fMD9ar5YEoDCrNT2Mg+QRcKJ1l
   GLzPBO0d32CGTe+ZwBgRYvBUGhDz03vy1EwnTKT2Ew3hMaEfM3GJyuuMb
   BPU2C0OKt4km6x88HFLV37jKAPnA4aNGSmjPcTB1PbtXJtRbd840xbLhI
   WZkYg95CfKCmyAU9ecAAqUKmugXFLg2ncwwzM4rJ0QVeBAy4jtFqoIpYQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261591422"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261591422"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="526036677"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 09:09:31 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndwba-0001xn-CI;
        Mon, 11 Apr 2022 16:09:30 +0000
Date:   Tue, 12 Apr 2022 00:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 48/48] drivers/tty/serial/max310x.c:750:45: error:
 'struct uart_state' has no member named 'xmit'
Message-ID: <202204120057.UCJiKzhW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   c196e3b15cddb539135de6a3c6bcf32b89213b4c
commit: c196e3b15cddb539135de6a3c6bcf32b89213b4c [48/48] tty: serial, use kfifo
config: parisc-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120057.UCJiKzhW-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=c196e3b15cddb539135de6a3c6bcf32b89213b4c
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout c196e3b15cddb539135de6a3c6bcf32b89213b4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/max310x.c: In function 'max310x_handle_tx':
>> drivers/tty/serial/max310x.c:750:45: error: 'struct uart_state' has no member named 'xmit'
     750 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/max310x.c:760:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     760 |         if (uart_circ_empty(xmit) || uart_tx_stopped(port))
         |             ^~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:764:19: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     764 |         to_send = uart_circ_chars_pending(xmit);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:765:21: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
     765 |         until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                     ^~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:765:41: error: invalid use of undefined type 'struct circ_buf'
     765 |         until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                         ^~
   drivers/tty/serial/max310x.c:765:53: error: invalid use of undefined type 'struct circ_buf'
     765 |         until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                     ^~
   drivers/tty/serial/max310x.c:775:55: error: invalid use of undefined type 'struct circ_buf'
     775 |                         max310x_batch_write(port, xmit->buf + xmit->tail, until_end);
         |                                                       ^~
   drivers/tty/serial/max310x.c:775:67: error: invalid use of undefined type 'struct circ_buf'
     775 |                         max310x_batch_write(port, xmit->buf + xmit->tail, until_end);
         |                                                                   ^~
   drivers/tty/serial/max310x.c:776:55: error: invalid use of undefined type 'struct circ_buf'
     776 |                         max310x_batch_write(port, xmit->buf, to_send - until_end);
         |                                                       ^~
   drivers/tty/serial/max310x.c:778:55: error: invalid use of undefined type 'struct circ_buf'
     778 |                         max310x_batch_write(port, xmit->buf + xmit->tail, to_send);
         |                                                       ^~
   drivers/tty/serial/max310x.c:778:67: error: invalid use of undefined type 'struct circ_buf'
     778 |                         max310x_batch_write(port, xmit->buf + xmit->tail, to_send);
         |                                                                   ^~
   drivers/tty/serial/max310x.c:783:21: error: invalid use of undefined type 'struct circ_buf'
     783 |                 xmit->tail = (xmit->tail + to_send) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/max310x.c:783:35: error: invalid use of undefined type 'struct circ_buf'
     783 |                 xmit->tail = (xmit->tail + to_send) & (UART_XMIT_SIZE - 1);
         |                                   ^~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/men_z135_uart.c: In function 'men_z135_handle_tx':
>> drivers/tty/serial/men_z135_uart.c:296:45: error: 'struct uart_state' has no member named 'xmit'
     296 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/men_z135_uart.c:306:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     306 |         if (uart_circ_empty(xmit))
         |             ^~~~~~~~~~~~~~~
>> drivers/tty/serial/men_z135_uart.c:316:16: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     316 |         qlen = uart_circ_chars_pending(xmit);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/men_z135_uart.c:348:20: error: invalid use of undefined type 'struct circ_buf'
     348 |         head = xmit->head & (UART_XMIT_SIZE - 1);
         |                    ^~
   drivers/tty/serial/men_z135_uart.c:349:20: error: invalid use of undefined type 'struct circ_buf'
     349 |         tail = xmit->tail & (UART_XMIT_SIZE - 1);
         |                    ^~
   drivers/tty/serial/men_z135_uart.c:354:59: error: invalid use of undefined type 'struct circ_buf'
     354 |         memcpy_toio(port->membase + MEN_Z135_TX_RAM, &xmit->buf[xmit->tail], n);
         |                                                           ^~
   drivers/tty/serial/men_z135_uart.c:354:69: error: invalid use of undefined type 'struct circ_buf'
     354 |         memcpy_toio(port->membase + MEN_Z135_TX_RAM, &xmit->buf[xmit->tail], n);
         |                                                                     ^~
   drivers/tty/serial/men_z135_uart.c:355:13: error: invalid use of undefined type 'struct circ_buf'
     355 |         xmit->tail = (xmit->tail + n) & (UART_XMIT_SIZE - 1);
         |             ^~
   drivers/tty/serial/men_z135_uart.c:355:27: error: invalid use of undefined type 'struct circ_buf'
     355 |         xmit->tail = (xmit->tail + n) & (UART_XMIT_SIZE - 1);
         |                           ^~
   cc1: some warnings being treated as errors


vim +750 drivers/tty/serial/max310x.c

f65444187a66bf Alexander Shiyan 2012-08-06  747  
10d8b34a421716 Alexander Shiyan 2013-06-29  748  static void max310x_handle_tx(struct uart_port *port)
f65444187a66bf Alexander Shiyan 2012-08-06  749  {
10d8b34a421716 Alexander Shiyan 2013-06-29 @750  	struct circ_buf *xmit = &port->state->xmit;
d584b65c0ddf20 Jan Kundrát      2017-12-13  751  	unsigned int txlen, to_send, until_end;
f65444187a66bf Alexander Shiyan 2012-08-06  752  
10d8b34a421716 Alexander Shiyan 2013-06-29  753  	if (unlikely(port->x_char)) {
10d8b34a421716 Alexander Shiyan 2013-06-29  754  		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
10d8b34a421716 Alexander Shiyan 2013-06-29  755  		port->icount.tx++;
10d8b34a421716 Alexander Shiyan 2013-06-29  756  		port->x_char = 0;
f65444187a66bf Alexander Shiyan 2012-08-06  757  		return;
f65444187a66bf Alexander Shiyan 2012-08-06  758  	}
f65444187a66bf Alexander Shiyan 2012-08-06  759  
10d8b34a421716 Alexander Shiyan 2013-06-29 @760  	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
f65444187a66bf Alexander Shiyan 2012-08-06  761  		return;
f65444187a66bf Alexander Shiyan 2012-08-06  762  
f65444187a66bf Alexander Shiyan 2012-08-06  763  	/* Get length of data pending in circular buffer */
f65444187a66bf Alexander Shiyan 2012-08-06 @764  	to_send = uart_circ_chars_pending(xmit);
d584b65c0ddf20 Jan Kundrát      2017-12-13 @765  	until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
f65444187a66bf Alexander Shiyan 2012-08-06  766  	if (likely(to_send)) {
f65444187a66bf Alexander Shiyan 2012-08-06  767  		/* Limit to size of TX FIFO */
10d8b34a421716 Alexander Shiyan 2013-06-29  768  		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
10d8b34a421716 Alexander Shiyan 2013-06-29  769  		txlen = port->fifosize - txlen;
f65444187a66bf Alexander Shiyan 2012-08-06  770  		to_send = (to_send > txlen) ? txlen : to_send;
f65444187a66bf Alexander Shiyan 2012-08-06  771  
d584b65c0ddf20 Jan Kundrát      2017-12-13  772  		if (until_end < to_send) {
d584b65c0ddf20 Jan Kundrát      2017-12-13  773  			/* It's a circ buffer -- wrap around.
d584b65c0ddf20 Jan Kundrát      2017-12-13  774  			 * We could do that in one SPI transaction, but meh. */
d584b65c0ddf20 Jan Kundrát      2017-12-13  775  			max310x_batch_write(port, xmit->buf + xmit->tail, until_end);
d584b65c0ddf20 Jan Kundrát      2017-12-13  776  			max310x_batch_write(port, xmit->buf, to_send - until_end);
d584b65c0ddf20 Jan Kundrát      2017-12-13  777  		} else {
d584b65c0ddf20 Jan Kundrát      2017-12-13  778  			max310x_batch_write(port, xmit->buf + xmit->tail, to_send);
d584b65c0ddf20 Jan Kundrát      2017-12-13  779  		}
d584b65c0ddf20 Jan Kundrát      2017-12-13  780  
f65444187a66bf Alexander Shiyan 2012-08-06  781  		/* Add data to send */
10d8b34a421716 Alexander Shiyan 2013-06-29  782  		port->icount.tx += to_send;
d584b65c0ddf20 Jan Kundrát      2017-12-13  783  		xmit->tail = (xmit->tail + to_send) & (UART_XMIT_SIZE - 1);
f65444187a66bf Alexander Shiyan 2012-08-06  784  	}
f65444187a66bf Alexander Shiyan 2012-08-06  785  
f65444187a66bf Alexander Shiyan 2012-08-06  786  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
10d8b34a421716 Alexander Shiyan 2013-06-29  787  		uart_write_wakeup(port);
f65444187a66bf Alexander Shiyan 2012-08-06  788  }
f65444187a66bf Alexander Shiyan 2012-08-06  789  

:::::: The code at line 750 was first introduced by commit
:::::: 10d8b34a421716d55a4ff7c2d427c35e88b8fd60 serial: max310x: Driver rework

:::::: TO: Alexander Shiyan <shc_work@mail.ru>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
