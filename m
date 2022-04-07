Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3D4F831E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbiDGP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiDGP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:29:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21DD1D7D98
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649345211; x=1680881211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I2AgBjIzWUUoWhMK2O3rm9VvF0pTAWXZ7fwfOcWfDNc=;
  b=d7v+w7uIb/FZpRv31k6cE2uS52uRgcURuAL+51qTB7lf97Oz/4g1FTwc
   +J+cAcpQ3QEEbpb3rMn1ASzpgrmIks5bhZahZX6lv9IXhxDrdI7TEfxgY
   zYq5N259EHyJe+ddWKTPJE81035wy12inQeiGmdUXNSdBazsyxvXGSLB0
   65DgWO4jBgrtGh+u3SRGeyG3ttVXCk6DPB2YCO1jYZ/LEiMWruaP/zNvg
   crxowtn7ChwkYxzY3qiax3ocoNePqCx/KnQ0YJN7MXMQ30eMnq7afe2p/
   tMDWGa4TDaiVf/GgbVyFI0yVS+nJbClL3AKbQAKNsX0rtUBBUdLlLSoAU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243486703"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="243486703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="609366340"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 07 Apr 2022 08:26:49 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncU25-0005X7-6Y;
        Thu, 07 Apr 2022 15:26:49 +0000
Date:   Thu, 7 Apr 2022 23:26:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 50/50] drivers/tty/serial/samsung_tty.c:446:48:
 error: 'xmit' undeclared
Message-ID: <202204072325.RFhfKACA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   100a309b4d75252d31b3ae0e69d6469ac0e0f522
commit: 100a309b4d75252d31b3ae0e69d6469ac0e0f522 [50/50] serial fifo
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220407/202204072325.RFhfKACA-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=100a309b4d75252d31b3ae0e69d6469ac0e0f522
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 100a309b4d75252d31b3ae0e69d6469ac0e0f522
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_start_tx_dma':
>> drivers/tty/serial/samsung_tty.c:446:48: error: 'xmit' undeclared (first use in this function)
     446 |         dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
         |                                                ^~~~
   drivers/tty/serial/samsung_tty.c:446:48: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/samsung_tty.c:439:26: warning: unused variable 'tport' [-Wunused-variable]
     439 |         struct tty_port *tport = &port->state->port;
         |                          ^~~~~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_start_next_tx':
   drivers/tty/serial/samsung_tty.c:477:17: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
     477 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                 ^~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c:477:33: error: 'xmit' undeclared (first use in this function)
     477 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                 ^~~~
   drivers/tty/serial/samsung_tty.c:473:26: warning: unused variable 'tport' [-Wunused-variable]
     473 |         struct tty_port *tport = &port->state->port;
         |                          ^~~~~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_start_tx':
   drivers/tty/serial/samsung_tty.c:495:45: error: 'struct uart_state' has no member named 'xmit'
     495 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/samsung_tty.c:507:22: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
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
   drivers/tty/serial/samsung_tty.c:924:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     924 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/tty/serial/sh-sci.c: In function 'sci_dma_tx_work_fn':
>> drivers/tty/serial/sh-sci.c:1404:16: error: 'xmit' undeclared (first use in this function)
    1404 |         head = xmit->head;
         |                ^~~~
   drivers/tty/serial/sh-sci.c:1404:16: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/kernel.h:26,
                    from include/linux/clk.h:13,
                    from drivers/tty/serial/sh-sci.c:20:
   drivers/tty/serial/sh-sci.c:1408:17: error: implicit declaration of function 'CIRC_CNT' [-Werror=implicit-function-declaration]
    1408 |                 CIRC_CNT(head, tail, UART_XMIT_SIZE),
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
   drivers/tty/serial/sh-sci.c:1407:25: note: in expansion of macro 'min_t'
    1407 |         s->tx_dma_len = min_t(unsigned int,
         |                         ^~~~~
   drivers/tty/serial/sh-sci.c:1409:17: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
    1409 |                 CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
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
   drivers/tty/serial/sh-sci.c:1407:25: note: in expansion of macro 'min_t'
    1407 |         s->tx_dma_len = min_t(unsigned int,
         |                         ^~~~~
   drivers/tty/serial/sh-sci.c:1391:26: warning: unused variable 'tport' [-Wunused-variable]
    1391 |         struct tty_port *tport = &port->state->port;
         |                          ^~~~~
   In file included from drivers/tty/serial/sh-sci.c:26:
   drivers/tty/serial/sh-sci.c: In function 'sci_request_dma':
   drivers/tty/serial/sh-sci.c:1585:60: error: 'struct uart_state' has no member named 'xmit'
    1585 |                                                 port->state->xmit.buf,
         |                                                            ^~
   include/linux/dma-mapping.h:406:60: note: in definition of macro 'dma_map_single'
     406 | #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
         |                                                            ^
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from include/linux/clk.h:13,
                    from drivers/tty/serial/sh-sci.c:20:
   drivers/tty/serial/sh-sci.c:1594:44: error: 'struct uart_state' has no member named 'xmit'
    1594 |                                 port->state->xmit.buf, &s->tx_dma_addr);
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
   drivers/tty/serial/sh-sci.c:1592:25: note: in expansion of macro 'dev_dbg'
    1592 |                         dev_dbg(port->dev, "%s: mapped %lu@%p to %pad\n",
         |                         ^~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/msm_serial.c: In function 'msm_handle_tx_dma':
>> drivers/tty/serial/msm_serial.c:490:21: error: 'xmit' undeclared (first use in this function)
     490 |         cpu_addr = &xmit->buf[xmit->tail];
         |                     ^~~~
   drivers/tty/serial/msm_serial.c:490:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/msm_serial.c: In function 'msm_handle_tx_pio':
   drivers/tty/serial/msm_serial.c:838:45: error: 'struct uart_state' has no member named 'xmit'
     838 |         struct circ_buf *xmit = &port->state->xmit;
         |                                             ^~
   drivers/tty/serial/msm_serial.c:866:38: error: invalid use of undefined type 'struct circ_buf'
     866 |                         buf[i] = xmit->buf[xmit->tail + i];
         |                                      ^~
   drivers/tty/serial/msm_serial.c:866:48: error: invalid use of undefined type 'struct circ_buf'
     866 |                         buf[i] = xmit->buf[xmit->tail + i];
         |                                                ^~
   drivers/tty/serial/msm_serial.c:871:21: error: invalid use of undefined type 'struct circ_buf'
     871 |                 xmit->tail = (xmit->tail + num_chars) & (UART_XMIT_SIZE - 1);
         |                     ^~
   drivers/tty/serial/msm_serial.c:871:35: error: invalid use of undefined type 'struct circ_buf'
     871 |                 xmit->tail = (xmit->tail + num_chars) & (UART_XMIT_SIZE - 1);
         |                                   ^~
   drivers/tty/serial/msm_serial.c:876:13: error: implicit declaration of function 'uart_circ_empty' [-Werror=implicit-function-declaration]
     876 |         if (uart_circ_empty(xmit))
         |             ^~~~~~~~~~~~~~~
   drivers/tty/serial/msm_serial.c:879:13: error: implicit declaration of function 'uart_circ_chars_pending' [-Werror=implicit-function-declaration]
     879 |         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/msm_serial.c: In function 'msm_handle_tx':
   drivers/tty/serial/msm_serial.c:886:54: error: 'struct uart_state' has no member named 'xmit'
     886 |         struct circ_buf *xmit = &msm_port->uart.state->xmit;
         |                                                      ^~
   drivers/tty/serial/msm_serial.c:915:21: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
     915 |         pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                     ^~~~~~~~~~~~~~~
   drivers/tty/serial/msm_serial.c:915:41: error: invalid use of undefined type 'struct circ_buf'
     915 |         pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                         ^~
   drivers/tty/serial/msm_serial.c:915:53: error: invalid use of undefined type 'struct circ_buf'
     915 |         pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                     ^~
   drivers/tty/serial/msm_serial.c:916:41: error: invalid use of undefined type 'struct circ_buf'
     916 |         dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                         ^~
   drivers/tty/serial/msm_serial.c:916:53: error: invalid use of undefined type 'struct circ_buf'
     916 |         dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                                     ^~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/serial-tegra.c: In function 'tegra_uart_start_tx_dma':
>> drivers/tty/serial/serial-tegra.c:544:47: error: 'xmit' undeclared (first use in this function)
     544 |         tx_phys_addr = tup->tx_dma_buf_phys + xmit->tail;
         |                                               ^~~~
   drivers/tty/serial/serial-tegra.c:544:47: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/serial-tegra.c:540:26: warning: unused variable 'tport' [-Wunused-variable]
     540 |         struct tty_port *tport = &tup->uport.state->port;
         |                          ^~~~~
   drivers/tty/serial/serial-tegra.c: In function 'tegra_uart_start_next_tx':
   drivers/tty/serial/serial-tegra.c:575:32: error: 'xmit' undeclared (first use in this function)
     575 |         tail = (unsigned long)&xmit->buf[xmit->tail];
         |                                ^~~~
   drivers/tty/serial/serial-tegra.c:576:17: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
     576 |         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                 ^~~~~~~~~~~~~~~
   drivers/tty/serial/serial-tegra.c:570:26: warning: unused variable 'tport' [-Wunused-variable]
     570 |         struct tty_port *tport = &tup->uport.state->port;
         |                          ^~~~~
   In file included from drivers/tty/serial/serial-tegra.c:16:
   drivers/tty/serial/serial-tegra.c: In function 'tegra_uart_dma_channel_allocate':
   drivers/tty/serial/serial-tegra.c:1170:41: error: 'struct uart_state' has no member named 'xmit'
    1170 |                         tup->uport.state->xmit.buf, UART_XMIT_SIZE,
         |                                         ^~
   include/linux/dma-mapping.h:406:60: note: in definition of macro 'dma_map_single'
     406 | #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
         |                                                            ^
   drivers/tty/serial/serial-tegra.c:1177:43: error: 'struct uart_state' has no member named 'xmit'
    1177 |                 dma_buf = tup->uport.state->xmit.buf;
         |                                           ^~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/tegra-tcu.c: In function 'tegra_tcu_uart_start_tx':
   drivers/tty/serial/tegra-tcu.c:99:25: error: implicit declaration of function 'CIRC_CNT_TO_END' [-Werror=implicit-function-declaration]
      99 |                 count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                         ^~~~~~~~~~~~~~~
>> drivers/tty/serial/tegra-tcu.c:99:41: error: 'xmit' undeclared (first use in this function)
      99 |                 count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
         |                                         ^~~~
   drivers/tty/serial/tegra-tcu.c:99:41: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/tegra-tcu.c:95:26: warning: unused variable 'tport' [-Wunused-variable]
      95 |         struct tty_port *tport = &port->state->port;
         |                          ^~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty/serial/atmel_serial.c: In function 'atmel_tx_dma':
>> drivers/tty/serial/atmel_serial.c:927:41: warning: variable 'part2_len' set but not used [-Wunused-but-set-variable]
     927 |         unsigned int tx_len, part1_len, part2_len, sg_len;
         |                                         ^~~~~~~~~
>> drivers/tty/serial/atmel_serial.c:927:30: warning: variable 'part1_len' set but not used [-Wunused-but-set-variable]
     927 |         unsigned int tx_len, part1_len, part2_len, sg_len;
         |                              ^~~~~~~~~


vim +/xmit +446 drivers/tty/serial/samsung_tty.c

29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  434  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  435  static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  436  				      unsigned int count)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  437  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  438  	struct uart_port *port = &ourport->port;
100a309b4d7525 drivers/tty/serial/samsung_tty.c Jiri Slaby     2022-01-05  439  	struct tty_port *tport = &port->state->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  440  	struct s3c24xx_uart_dma *dma = ourport->dma;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  441  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  442  	if (ourport->tx_mode != S3C24XX_TX_DMA)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  443  		enable_tx_dma(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  444  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  445  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10 @446  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  447  
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams  2021-06-29  448  	dma_sync_single_for_device(dma->tx_chan->device->dev,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams  2021-06-29  449  				   dma->tx_transfer_addr, dma->tx_size,
4fc2d3cd6d3a48 drivers/tty/serial/samsung_tty.c Tamseel Shams  2021-06-29  450  				   DMA_TO_DEVICE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  451  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  452  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  453  				dma->tx_transfer_addr, dma->tx_size,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  454  				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  455  	if (!dma->tx_desc) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  456  		dev_err(ourport->port.dev, "Unable to get desc for Tx\n");
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  457  		return -EIO;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks      2008-07-03  458  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  459  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  460  	dma->tx_desc->callback = s3c24xx_serial_tx_dma_complete;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  461  	dma->tx_desc->callback_param = ourport;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  462  	dma->tx_bytes_requested = dma->tx_size;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  463  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  464  	ourport->tx_in_progress = S3C24XX_TX_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  465  	dma->tx_cookie = dmaengine_submit(dma->tx_desc);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  466  	dma_async_issue_pending(dma->tx_chan);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga 2014-12-10  467  	return 0;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks      2008-07-03  468  }
b497549a035c2a drivers/serial/samsung.c         Ben Dooks      2008-07-03  469  

:::::: The code at line 446 was first introduced by commit
:::::: 29bef79908459d20a7a3db654bceb8f3ce4601dc serial: samsung: add DMA support for TX

:::::: TO: Robert Baldyga <r.baldyga@samsung.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
