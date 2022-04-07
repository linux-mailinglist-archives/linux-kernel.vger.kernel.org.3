Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711E74F820F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbiDGOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344227AbiDGOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:47:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3C3633BC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649342749; x=1680878749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nJkhNo1oiuZU12X/5IdZ4okFvTStU8rkhCEs84uPq00=;
  b=Bdgcnaei5wsvwuNfsc6DLzV2d3uf5gCwAceAtllxwQpA8VN54+DRR/q2
   y0ATjFxK7LeD22INjsp9JhD8CCtKWB867VwG+RfaivGpirEnukMEq026S
   8J4D+KmrgrwNZWVc8sWUmDo/Tddqt18jI+NdJwqlTfQKk9N/RuCtbY/xx
   pOGZIhUUpZcR2fyRopO91kkkeh4oe4o1Ip3rXma1TFrnXidMtz9d58M2h
   bjmXQNpvCufywnNBn+gKmPE9jOg43NgIcqhwawXXfcRT5hpwVNJAGaLmN
   BR63Ofey5EYVd7nsrL2rOACamFItI+2WL8SiO9828XtXHBXXLtOhsiP+7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="248869139"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="248869139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 07:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571081139"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Apr 2022 07:45:47 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncTOM-0005Vm-O8;
        Thu, 07 Apr 2022 14:45:46 +0000
Date:   Thu, 7 Apr 2022 22:45:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 45/50] drivers/tty/serial/samsung_tty.c:285:45:
 error: 'struct uart_state' has no member named 'xmit'
Message-ID: <202204072258.fsF8e9At-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   100a309b4d75252d31b3ae0e69d6469ac0e0f522
commit: 977858b1b952395763e2a47a94e69dd0b2f22a42 [45/50] tty: serial, use kfifo
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220407/202204072258.fsF8e9At-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=977858b1b952395763e2a47a94e69dd0b2f22a42
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 977858b1b952395763e2a47a94e69dd0b2f22a42
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_stop_tx':
>> drivers/tty/serial/samsung_tty.c:285:45: error: 'struct uart_state' has no member named 'xmit'
     285 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/samsung_tty.c:313:21: error: invalid use of undefined type 'struct circ_buf'
     313 |                 xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/samsung_tty.c:313:35: error: invalid use of undefined type 'struct circ_buf'
     313 |                 xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
         |                                   ^~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_tx_dma_complete':
   drivers/tty/serial/samsung_tty.c:332:45: error: 'struct uart_state' has no member named 'xmit'
     332 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/samsung_tty.c:348:13: error: invalid use of undefined type 'struct circ_buf'
     348 |         xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
         |             ^~
   drivers/tty/serial/samsung_tty.c:348:27: error: invalid use of undefined type 'struct circ_buf'
     348 |         xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
         |                           ^~
>> drivers/tty/serial/samsung_tty.c:352:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     352 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_start_tx_dma':
   drivers/tty/serial/samsung_tty.c:439:45: error: 'struct uart_state' has no member named 'xmit'
     439 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/samsung_tty.c:446:52: error: invalid use of undefined type 'struct circ_buf'
     446 |         dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
         |                                                    ^~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_start_next_tx':
   drivers/tty/serial/samsung_tty.c:473:45: error: 'struct uart_state' has no member named 'xmit'
     473 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/samsung_tty.c:477:17: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
     477 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                 ^~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c:477:37: error: invalid use of undefined type 'struct circ_buf'
     477 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                     ^~
   drivers/tty/serial/samsung_tty.c:477:49: error: invalid use of undefined type 'struct circ_buf'
     477 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                 ^~
   drivers/tty/serial/samsung_tty.c:486:17: error: invalid use of undefined type 'struct circ_buf'
     486 |             xmit->tail & (dma_get_cache_alignment() - 1))
         |                 ^~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_start_tx':
   drivers/tty/serial/samsung_tty.c:495:45: error: 'struct uart_state' has no member named 'xmit'
     495 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/samsung_tty.c:507:22: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     507 |                 if (!uart_circ_empty(xmit) && !ourport->tx_in_progress)
         |                      ^~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_tx_chars':
   drivers/tty/serial/samsung_tty.c:871:45: error: 'struct uart_state' has no member named 'xmit'
     871 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/samsung_tty.c:874:37: error: invalid use of undefined type 'struct circ_buf'
     874 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                     ^~
   drivers/tty/serial/samsung_tty.c:874:49: error: invalid use of undefined type 'struct circ_buf'
     874 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                 ^~
   drivers/tty/serial/samsung_tty.c:879:30: error: invalid use of undefined type 'struct circ_buf'
     879 |                         (xmit->tail & (dma_get_cache_alignment() - 1));
         |                              ^~
   drivers/tty/serial/samsung_tty.c:913:48: error: invalid use of undefined type 'struct circ_buf'
     913 |                 wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
         |                                                ^~
   drivers/tty/serial/samsung_tty.c:913:58: error: invalid use of undefined type 'struct circ_buf'
     913 |                 wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
         |                                                          ^~
   drivers/tty/serial/samsung_tty.c:914:21: error: invalid use of undefined type 'struct circ_buf'
     914 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/samsung_tty.c:914:35: error: invalid use of undefined type 'struct circ_buf'
     914 |                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                   ^~
   In file included from drivers/tty/serial/samsung_tty.c:25:
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_request_dma':
   drivers/tty/serial/samsung_tty.c:1115:52: error: 'struct uart_state' has no member named 'xmit'
    1115 |                                       p->port.state->xmit.buf, UART_XMIT_SIZE,
         |                                                    ^~
   include/linux/dma-mapping.h:406:60: note: in definition of macro 'dma_map_single'
     406 | #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
         |                                                            ^
   cc1: some warnings being treated as errors
--
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
   drivers/tty/serial/sh-sci.c: In function 'sci_start_tx':
   drivers/tty/serial/sh-sci.c:588:28: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     588 |         if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
         |                            ^~~~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:588:58: error: 'struct uart_state' has no member named 'xmit'
     588 |         if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
         |                                                          ^~
   drivers/tty/serial/sh-sci.c: In function 'sci_transmit_chars':
   drivers/tty/serial/sh-sci.c:807:45: error: 'struct uart_state' has no member named 'xmit'
     807 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/sh-sci.c:833:33: error: invalid use of undefined type 'struct circ_buf'
     833 |                         c = xmit->buf[xmit->tail];
         |                                 ^~
   drivers/tty/serial/sh-sci.c:833:43: error: invalid use of undefined type 'struct circ_buf'
     833 |                         c = xmit->buf[xmit->tail];
         |                                           ^~
   drivers/tty/serial/sh-sci.c:834:29: error: invalid use of undefined type 'struct circ_buf'
     834 |                         xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                             ^~
   drivers/tty/serial/sh-sci.c:834:43: error: invalid use of undefined type 'struct circ_buf'
     834 |                         xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
         |                                           ^~
   drivers/tty/serial/sh-sci.c:846:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     846 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c: In function 'sci_dma_tx_complete':
   drivers/tty/serial/sh-sci.c:1177:45: error: 'struct uart_state' has no member named 'xmit'
    1177 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/sh-sci.c:1184:13: error: invalid use of undefined type 'struct circ_buf'
    1184 |         xmit->tail += s->tx_dma_len;
         |             ^~
   drivers/tty/serial/sh-sci.c:1185:13: error: invalid use of undefined type 'struct circ_buf'
    1185 |         xmit->tail &= UART_XMIT_SIZE - 1;
         |             ^~
   drivers/tty/serial/sh-sci.c: In function 'sci_dma_tx_work_fn':
   drivers/tty/serial/sh-sci.c:1395:45: error: 'struct uart_state' has no member named 'xmit'
    1395 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/sh-sci.c:1408:20: error: invalid use of undefined type 'struct circ_buf'
    1408 |         head = xmit->head;
         |                    ^~
   drivers/tty/serial/sh-sci.c:1409:20: error: invalid use of undefined type 'struct circ_buf'
    1409 |         tail = xmit->tail;
         |                    ^~
   In file included from include/linux/kernel.h:26,
                    from include/linux/clk.h:13,
                    from drivers/tty/serial/sh-sci.c:20:
>> drivers/tty/serial/sh-sci.c:1412:17: error: implicit declaration of function 'CIRC_CNT' [-Werror=implicit-function-declaration]
    1412 |                 CIRC_CNT(head, tail, UART_XMIT_SIZE),
         |                 ^~~~~~~~
   include/linux/minmax.h:20:28: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                            ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:104:33: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
         |                                 ^~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1411:25: note: in expansion of macro 'min_t'
    1411 |         s->tx_dma_len = min_t(unsigned int,
         |                         ^~~~~
>> drivers/tty/serial/sh-sci.c:1413:17: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
    1413 |                 CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
         |                 ^~~~~~~~~~~~~~~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:104:33: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
         |                                 ^~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1411:25: note: in expansion of macro 'min_t'
    1411 |         s->tx_dma_len = min_t(unsigned int,
         |                         ^~~~~
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from include/linux/clk.h:13,
                    from drivers/tty/serial/sh-sci.c:20:
   drivers/tty/serial/sh-sci.c:1443:31: error: invalid use of undefined type 'struct circ_buf'
    1443 |                 __func__, xmit->buf, tail, head, s->cookie_tx);
         |                               ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1442:9: note: in expansion of macro 'dev_dbg'
    1442 |         dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
         |         ^~~~~~~
   In file included from drivers/tty/serial/sh-sci.c:26:
   drivers/tty/serial/sh-sci.c: In function 'sci_request_dma':
   drivers/tty/serial/sh-sci.c:1589:60: error: 'struct uart_state' has no member named 'xmit'
    1589 |                                                 port->state->xmit.buf,
         |                                                            ^~
   include/linux/dma-mapping.h:406:60: note: in definition of macro 'dma_map_single'
     406 | #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
         |                                                            ^
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from include/linux/clk.h:13,
                    from drivers/tty/serial/sh-sci.c:20:
   drivers/tty/serial/sh-sci.c:1598:44: error: 'struct uart_state' has no member named 'xmit'
    1598 |                                 port->state->xmit.buf, &s->tx_dma_addr);
         |                                            ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:1596:25: note: in expansion of macro 'dev_dbg'
    1596 |                         dev_dbg(port->dev, "%s: mapped %lu@%p to %pad\n",
         |                         ^~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/msm_serial.c: In function 'msm_complete_tx_dma':
>> drivers/tty/serial/msm_serial.c:437:45: error: 'struct uart_state' has no member named 'xmit'
     437 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
>> drivers/tty/serial/msm_serial.c:467:13: error: invalid use of undefined type 'struct circ_buf'
     467 |         xmit->tail += count;
         |             ^~
   drivers/tty/serial/msm_serial.c:468:13: error: invalid use of undefined type 'struct circ_buf'
     468 |         xmit->tail &= UART_XMIT_SIZE - 1;
         |             ^~
>> drivers/tty/serial/msm_serial.c:474:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     474 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/msm_serial.c: In function 'msm_handle_tx_dma':
   drivers/tty/serial/msm_serial.c:484:54: error: 'struct uart_state' has no member named 'xmit'
     484 |         struct circ_buf *xmit = &msm_port->uart.state->xmit;
         |                                                      ^~
   drivers/tty/serial/msm_serial.c:491:25: error: invalid use of undefined type 'struct circ_buf'
     491 |         cpu_addr = &xmit->buf[xmit->tail];
         |                         ^~
   drivers/tty/serial/msm_serial.c:491:35: error: invalid use of undefined type 'struct circ_buf'
     491 |         cpu_addr = &xmit->buf[xmit->tail];
         |                                   ^~
   drivers/tty/serial/msm_serial.c: In function 'msm_handle_tx_pio':
   drivers/tty/serial/msm_serial.c:839:45: error: 'struct uart_state' has no member named 'xmit'
     839 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/msm_serial.c:867:38: error: invalid use of undefined type 'struct circ_buf'
     867 |                         buf[i] = xmit->buf[xmit->tail + i];
         |                                      ^~
   drivers/tty/serial/msm_serial.c:867:48: error: invalid use of undefined type 'struct circ_buf'
     867 |                         buf[i] = xmit->buf[xmit->tail + i];
         |                                                ^~
   drivers/tty/serial/msm_serial.c:872:21: error: invalid use of undefined type 'struct circ_buf'
     872 |                 xmit->tail = (xmit->tail + num_chars) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/msm_serial.c:872:35: error: invalid use of undefined type 'struct circ_buf'
     872 |                 xmit->tail = (xmit->tail + num_chars) & (UART_XMIT_SIZE - 1);
         |                                   ^~
>> drivers/tty/serial/msm_serial.c:877:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     877 |         if (uart_circ_empty(xmit))
         |             ^~~~~~~~~~~~~~~
   drivers/tty/serial/msm_serial.c: In function 'msm_handle_tx':
   drivers/tty/serial/msm_serial.c:887:54: error: 'struct uart_state' has no member named 'xmit'
     887 |         struct circ_buf *xmit = &msm_port->uart.state->xmit;
         |                                                      ^~
>> drivers/tty/serial/msm_serial.c:916:21: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
     916 |         pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/msm_serial.c:916:41: error: invalid use of undefined type 'struct circ_buf'
     916 |         pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                         ^~
   drivers/tty/serial/msm_serial.c:916:53: error: invalid use of undefined type 'struct circ_buf'
     916 |         pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                     ^~
   drivers/tty/serial/msm_serial.c:917:41: error: invalid use of undefined type 'struct circ_buf'
     917 |         dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                         ^~
   drivers/tty/serial/msm_serial.c:917:53: error: invalid use of undefined type 'struct circ_buf'
     917 |         dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                     ^~
   cc1: some warnings being treated as errors
..


vim +285 drivers/tty/serial/samsung_tty.c

b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  280  
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  281  static void s3c24xx_serial_stop_tx(struct uart_port *port)
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  282  {
b73c289cc90138 drivers/serial/samsung.c         Ben Dooks           2008-10-21  283  	struct s3c24xx_uart_port *ourport = to_ourport(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  284  	struct s3c24xx_uart_dma *dma = ourport->dma;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @285  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  286  	struct dma_tx_state state;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  287  	int count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  288  
8336240ebb248b drivers/tty/serial/samsung_tty.c Greg Kroah-Hartman  2019-12-17  289  	if (!ourport->tx_enabled)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  290  		return;
b73c289cc90138 drivers/serial/samsung.c         Ben Dooks           2008-10-21  291  
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  292  	switch (ourport->info->type) {
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  293  	case TYPE_S3C6400:
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  294  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  295  		break;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  296  	case TYPE_APPLE_S5L:
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  297  		s3c24xx_clear_bit(port, APPLE_S5L_UCON_TXTHRESH_ENA, S3C2410_UCON);
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  298  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  299  	default:
41609ff43005de drivers/serial/samsung.c         Mark Brown          2009-04-14  300  		disable_irq_nosync(ourport->tx_irq);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  301  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  302  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  303  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  304  	if (dma && dma->tx_chan && ourport->tx_in_progress == S3C24XX_TX_DMA) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  305  		dmaengine_pause(dma->tx_chan);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  306  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  307  		dmaengine_terminate_all(dma->tx_chan);
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  308  		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  309  					dma->tx_transfer_addr, dma->tx_size,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  310  					DMA_TO_DEVICE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  311  		async_tx_ack(dma->tx_desc);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  312  		count = dma->tx_bytes_requested - state.residue;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @313  		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  314  		port->icount.tx += count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  315  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  316  
8336240ebb248b drivers/tty/serial/samsung_tty.c Greg Kroah-Hartman  2019-12-17  317  	ourport->tx_enabled = 0;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  318  	ourport->tx_in_progress = 0;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  319  
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  320  	if (port->flags & UPF_CONS_FLOW)
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  321  		s3c24xx_serial_rx_enable(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  322  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  323  	ourport->tx_mode = 0;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  324  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  325  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  326  static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  327  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  328  static void s3c24xx_serial_tx_dma_complete(void *args)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  329  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  330  	struct s3c24xx_uart_port *ourport = args;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  331  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @332  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  333  	struct s3c24xx_uart_dma *dma = ourport->dma;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  334  	struct dma_tx_state state;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  335  	unsigned long flags;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  336  	int count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  337  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  338  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  339  	count = dma->tx_bytes_requested - state.residue;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  340  	async_tx_ack(dma->tx_desc);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  341  
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  342  	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  343  				dma->tx_transfer_addr, dma->tx_size,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  344  				DMA_TO_DEVICE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  345  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  346  	spin_lock_irqsave(&port->lock, flags);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  347  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  348  	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  349  	port->icount.tx += count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  350  	ourport->tx_in_progress = 0;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  351  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @352  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  353  		uart_write_wakeup(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  354  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  355  	s3c24xx_serial_start_next_tx(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  356  	spin_unlock_irqrestore(&port->lock, flags);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  357  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  358  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  359  static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  360  {
bb1d98187b09d4 drivers/tty/serial/samsung_tty.c Krzysztof Kozlowski 2022-03-08  361  	const struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  362  	u32 ucon;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  363  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  364  	/* Mask Tx interrupt */
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  365  	switch (ourport->info->type) {
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  366  	case TYPE_S3C6400:
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  367  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  368  		break;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  369  	case TYPE_APPLE_S5L:
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  370  		WARN_ON(1); // No DMA
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  371  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  372  	default:
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  373  		disable_irq_nosync(ourport->tx_irq);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  374  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  375  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  376  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  377  	/* Enable tx dma mode */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  378  	ucon = rd_regl(port, S3C2410_UCON);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  379  	ucon &= ~(S3C64XX_UCON_TXBURST_MASK | S3C64XX_UCON_TXMODE_MASK);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  380  	ucon |= (dma_get_cache_alignment() >= 16) ?
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  381  		S3C64XX_UCON_TXBURST_16 : S3C64XX_UCON_TXBURST_1;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  382  	ucon |= S3C64XX_UCON_TXMODE_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  383  	wr_regl(port,  S3C2410_UCON, ucon);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  384  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  385  	ourport->tx_mode = S3C24XX_TX_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  386  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  387  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  388  static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  389  {
bb1d98187b09d4 drivers/tty/serial/samsung_tty.c Krzysztof Kozlowski 2022-03-08  390  	const struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  391  	u32 ucon, ufcon;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  392  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  393  	/* Set ufcon txtrig */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  394  	ourport->tx_in_progress = S3C24XX_TX_PIO;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  395  	ufcon = rd_regl(port, S3C2410_UFCON);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  396  	wr_regl(port,  S3C2410_UFCON, ufcon);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  397  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  398  	/* Enable tx pio mode */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  399  	ucon = rd_regl(port, S3C2410_UCON);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  400  	ucon &= ~(S3C64XX_UCON_TXMODE_MASK);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  401  	ucon |= S3C64XX_UCON_TXMODE_CPU;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  402  	wr_regl(port,  S3C2410_UCON, ucon);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  403  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  404  	/* Unmask Tx interrupt */
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  405  	switch (ourport->info->type) {
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  406  	case TYPE_S3C6400:
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  407  		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  408  				  S3C64XX_UINTM);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  409  		break;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  410  	case TYPE_APPLE_S5L:
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  411  		ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  412  		wr_regl(port, S3C2410_UCON, ucon);
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  413  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  414  	default:
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  415  		enable_irq(ourport->tx_irq);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  416  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  417  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  418  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  419  	ourport->tx_mode = S3C24XX_TX_PIO;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  420  
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  421  	/*
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  422  	 * The Apple version only has edge triggered TX IRQs, so we need
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  423  	 * to kick off the process by sending some characters here.
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  424  	 */
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  425  	if (ourport->info->type == TYPE_APPLE_S5L)
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  426  		s3c24xx_serial_tx_chars(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  427  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  428  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  429  static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  430  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  431  	if (ourport->tx_mode != S3C24XX_TX_PIO)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  432  		enable_tx_pio(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  433  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  434  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  435  static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  436  				      unsigned int count)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  437  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  438  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  439  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  440  	struct s3c24xx_uart_dma *dma = ourport->dma;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  441  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  442  	if (ourport->tx_mode != S3C24XX_TX_DMA)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  443  		enable_tx_dma(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  444  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  445  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @446  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  447  
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  448  	dma_sync_single_for_device(dma->tx_chan->device->dev,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  449  				   dma->tx_transfer_addr, dma->tx_size,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-29  450  				   DMA_TO_DEVICE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  451  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  452  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  453  				dma->tx_transfer_addr, dma->tx_size,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  454  				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  455  	if (!dma->tx_desc) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  456  		dev_err(ourport->port.dev, "Unable to get desc for Tx\n");
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  457  		return -EIO;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  458  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  459  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  460  	dma->tx_desc->callback = s3c24xx_serial_tx_dma_complete;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  461  	dma->tx_desc->callback_param = ourport;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  462  	dma->tx_bytes_requested = dma->tx_size;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  463  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  464  	ourport->tx_in_progress = S3C24XX_TX_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  465  	dma->tx_cookie = dmaengine_submit(dma->tx_desc);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  466  	dma_async_issue_pending(dma->tx_chan);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  467  	return 0;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  468  }
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  469  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  470  static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  471  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  472  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  473  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  474  	unsigned long count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  475  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  476  	/* Get data size up to the end of buffer */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @477  	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  478  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  479  	if (!count) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  480  		s3c24xx_serial_stop_tx(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  481  		return;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  482  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  483  
81ccb2a69f76b8 drivers/tty/serial/samsung.c     Marek Szyprowski    2015-07-31  484  	if (!ourport->dma || !ourport->dma->tx_chan ||
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga      2015-07-31  485  	    count < ourport->min_dma_size ||
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga      2015-07-31  486  	    xmit->tail & (dma_get_cache_alignment() - 1))
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  487  		s3c24xx_serial_start_tx_pio(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  488  	else
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  489  		s3c24xx_serial_start_tx_dma(ourport, count);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  490  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  491  

:::::: The code at line 285 was first introduced by commit
:::::: 29bef79908459d20a7a3db654bceb8f3ce4601dc serial: samsung: add DMA support for TX

:::::: TO: Robert Baldyga <r.baldyga@samsung.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
