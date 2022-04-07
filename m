Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84704F831B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiDGP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiDGP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:28:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA51D7D97
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649345211; x=1680881211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VbYykRIwappfpRNrt3o6O1ku6astoaWsyhEOz9gfjes=;
  b=jDzJwaQ3b8FcTtjkrgjSLSqxa/HCl6kbwP9/4ZXOxE2j5NLy1DW50cYQ
   UzWtlyf3x/8p/XCZKWhq8suRjVwEUv3LgcyIxrOJSeS9eyjYLHfL8WNrW
   5ijB3+LfBOJmlEk4aANcWMr1zRc+jGEE42spwQcuXersBexVSUQiWYqSX
   8TKCcgUFGsbwYcJ5lpAy41MweDWuk4/13V+T3B6/zm9uO1GayqPA8143J
   yFRWq2NOXNVkaSsB+VtIEdBBIPNSt7zXxgaK4WVQ6zMj5xr4csd5kPi6U
   65WQz2/hNX8ihkgqLGRGgeIttV5XpByO96i9Ozcs34W4lnvsH13e+g+lj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347793817"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="347793817"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="723007166"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2022 08:26:49 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncU25-0005X1-0t;
        Thu, 07 Apr 2022 15:26:49 +0000
Date:   Thu, 7 Apr 2022 23:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 45/50] drivers/tty/serial/men_z135_uart.c:296:40:
 error: no member named 'xmit' in 'struct uart_state'
Message-ID: <202204072341.za6cIui8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   100a309b4d75252d31b3ae0e69d6469ac0e0f522
commit: 977858b1b952395763e2a47a94e69dd0b2f22a42 [45/50] tty: serial, use kfifo
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220407/202204072341.za6cIui8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=977858b1b952395763e2a47a94e69dd0b2f22a42
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 977858b1b952395763e2a47a94e69dd0b2f22a42
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/men_z135_uart.c:296:40: error: no member named 'xmit' in 'struct uart_state'
           struct circ_buf *xmit = &port->state->xmit;
                                    ~~~~~~~~~~~  ^
>> drivers/tty/serial/men_z135_uart.c:306:6: error: implicit declaration of function 'uart_circ_empty' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (uart_circ_empty(xmit))
               ^
>> drivers/tty/serial/men_z135_uart.c:316:9: error: implicit declaration of function 'uart_circ_chars_pending' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           qlen = uart_circ_chars_pending(xmit);
                  ^
>> drivers/tty/serial/men_z135_uart.c:348:13: error: incomplete definition of type 'struct circ_buf'
           head = xmit->head & (UART_XMIT_SIZE - 1);
                  ~~~~^
   drivers/tty/serial/men_z135_uart.c:296:9: note: forward declaration of 'struct circ_buf'
           struct circ_buf *xmit = &port->state->xmit;
                  ^
   drivers/tty/serial/men_z135_uart.c:349:13: error: incomplete definition of type 'struct circ_buf'
           tail = xmit->tail & (UART_XMIT_SIZE - 1);
                  ~~~~^
   drivers/tty/serial/men_z135_uart.c:296:9: note: forward declaration of 'struct circ_buf'
           struct circ_buf *xmit = &port->state->xmit;
                  ^
   drivers/tty/serial/men_z135_uart.c:354:52: error: incomplete definition of type 'struct circ_buf'
           memcpy_toio(port->membase + MEN_Z135_TX_RAM, &xmit->buf[xmit->tail], n);
                                                         ~~~~^
   drivers/tty/serial/men_z135_uart.c:296:9: note: forward declaration of 'struct circ_buf'
           struct circ_buf *xmit = &port->state->xmit;
                  ^
   drivers/tty/serial/men_z135_uart.c:354:62: error: incomplete definition of type 'struct circ_buf'
           memcpy_toio(port->membase + MEN_Z135_TX_RAM, &xmit->buf[xmit->tail], n);
                                                                   ~~~~^
   drivers/tty/serial/men_z135_uart.c:296:9: note: forward declaration of 'struct circ_buf'
           struct circ_buf *xmit = &port->state->xmit;
                  ^
   drivers/tty/serial/men_z135_uart.c:355:6: error: incomplete definition of type 'struct circ_buf'
           xmit->tail = (xmit->tail + n) & (UART_XMIT_SIZE - 1);
           ~~~~^
   drivers/tty/serial/men_z135_uart.c:296:9: note: forward declaration of 'struct circ_buf'
           struct circ_buf *xmit = &port->state->xmit;
                  ^
   drivers/tty/serial/men_z135_uart.c:355:20: error: incomplete definition of type 'struct circ_buf'
           xmit->tail = (xmit->tail + n) & (UART_XMIT_SIZE - 1);
                         ~~~~^
   drivers/tty/serial/men_z135_uart.c:296:9: note: forward declaration of 'struct circ_buf'
           struct circ_buf *xmit = &port->state->xmit;
                  ^
   9 errors generated.


vim +296 drivers/tty/serial/men_z135_uart.c

e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  287  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  288  /**
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  289   * men_z135_handle_tx() - TX tasklet routine
145f5646be67eb Jiri Slaby         2020-08-18  290   * @uart: Pointer to struct men_z135_port
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  291   *
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  292   */
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  293  static void men_z135_handle_tx(struct men_z135_port *uart)
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  294  {
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  295  	struct uart_port *port = &uart->port;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17 @296  	struct circ_buf *xmit = &port->state->xmit;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  297  	u32 txc;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  298  	u32 wptr;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  299  	int qlen;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  300  	int n;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  301  	int txfree;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  302  	int head;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  303  	int tail;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  304  	int s;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  305  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17 @306  	if (uart_circ_empty(xmit))
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  307  		goto out;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  308  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  309  	if (uart_tx_stopped(port))
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  310  		goto out;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  311  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  312  	if (port->x_char)
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  313  		goto out;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  314  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  315  	/* calculate bytes to copy */
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17 @316  	qlen = uart_circ_chars_pending(xmit);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  317  	if (qlen <= 0)
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  318  		goto out;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  319  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  320  	wptr = ioread32(port->membase + MEN_Z135_TX_CTRL);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  321  	txc = (wptr >> 16) & 0x3ff;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  322  	wptr &= 0x3ff;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  323  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  324  	if (txc > MEN_Z135_FIFO_WATERMARK)
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  325  		txc = MEN_Z135_FIFO_WATERMARK;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  326  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  327  	txfree = MEN_Z135_FIFO_WATERMARK - txc;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  328  	if (txfree <= 0) {
01ba8d6af4b76a Johannes Thumshirn 2015-01-19  329  		dev_err(&uart->mdev->dev,
01ba8d6af4b76a Johannes Thumshirn 2015-01-19  330  			"Not enough room in TX FIFO have %d, need %d\n",
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  331  			txfree, qlen);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  332  		goto irq_en;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  333  	}
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  334  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  335  	/* if we're not aligned, it's better to copy only 1 or 2 bytes and
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  336  	 * then the rest.
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  337  	 */
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  338  	if (align && qlen >= 3 && BYTES_TO_ALIGN(wptr))
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  339  		n = 4 - BYTES_TO_ALIGN(wptr);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  340  	else if (qlen > txfree)
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  341  		n = txfree;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  342  	else
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  343  		n = qlen;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  344  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  345  	if (n <= 0)
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  346  		goto irq_en;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  347  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17 @348  	head = xmit->head & (UART_XMIT_SIZE - 1);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  349  	tail = xmit->tail & (UART_XMIT_SIZE - 1);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  350  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  351  	s = ((head >= tail) ? head : UART_XMIT_SIZE) - tail;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  352  	n = min(n, s);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  353  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  354  	memcpy_toio(port->membase + MEN_Z135_TX_RAM, &xmit->buf[xmit->tail], n);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  355  	xmit->tail = (xmit->tail + n) & (UART_XMIT_SIZE - 1);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  356  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  357  	iowrite32(n & 0x3ff, port->membase + MEN_Z135_TX_CTRL);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  358  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  359  	port->icount.tx += n;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  360  
a9977620a448f1 Johannes Thumshirn 2014-06-16  361  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
a9977620a448f1 Johannes Thumshirn 2014-06-16  362  		uart_write_wakeup(port);
a9977620a448f1 Johannes Thumshirn 2014-06-16  363  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  364  irq_en:
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  365  	if (!uart_circ_empty(xmit))
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  366  		men_z135_reg_set(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  367  	else
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  368  		men_z135_reg_clr(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  369  
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  370  out:
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  371  	return;
e264ebf4c81ac7 Johannes Thumshirn 2014-04-17  372  

:::::: The code at line 296 was first introduced by commit
:::::: e264ebf4c81ac733642ed03ee3f0e26914ed3714 tty: serial: Add driver for MEN's 16z135 High Speed UART.

:::::: TO: Johannes Thumshirn <johannes.thumshirn@men.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
