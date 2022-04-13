Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3394FFA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiDMPth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiDMPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:49:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354EB6621F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649864834; x=1681400834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F3zbd6vsN/xYMo+xEA/uqxZ1y5kmTnkt79dlYfFG6zA=;
  b=F0RP3206gSTvTHi/A4o4lNTqvdvLY8uWh3gRyFhB3LC/14MAIIv1q3W4
   SkaSaKElncmdfcwLb8cgPIj40WWUsnCjOf5nNmRFKeisPE1HhjEhExxLI
   IGsVrPJVnFxvCLEybNh/rML6iKAsed8hurbTFsOJ+XXhWGaqDp7YAJzw+
   Z6OIYH0CSGophED38f5AT2RiwRVP2s5uaPDN0A+8MuSLT41FlKIIXJYoC
   Tc3QUdlwghUj7le435VOKnKM9qmx7+niekxOBRt+RPxSYLUzpA5hfDMZ4
   vIvtZ0EyS4vCLjBYnihlKnEKhyQX1/PiKBdDDvRIZSAnojShyQm2meHhc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="325608374"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="325608374"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="724948525"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 08:45:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nefBM-0000Py-6d;
        Wed, 13 Apr 2022 15:45:24 +0000
Date:   Wed, 13 Apr 2022 23:44:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 49/49] drivers/tty/serial/men_z135_uart.c:346:6:
 warning: variable '__tmp' is uninitialized when used within its own
 initialization
Message-ID: <202204132329.LphHCVTD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   af0ac0f5161e051a3e4a2a669e377bdc2439920e
commit: af0ac0f5161e051a3e4a2a669e377bdc2439920e [49/49] tty: serial, use kfifo
config: arm64-buildonly-randconfig-r003-20220413 (https://download.01.org/0day-ci/archive/20220413/202204132329.LphHCVTD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=af0ac0f5161e051a3e4a2a669e377bdc2439920e
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout af0ac0f5161e051a3e4a2a669e377bdc2439920e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/men_z135_uart.c:346:6: warning: variable '__tmp' is uninitialized when used within its own initialization [-Wuninitialized]
           n = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:850:42: note: expanded from macro 'kfifo_out_linear_ptr'
           unsigned int __count = kfifo_out_linear(__tmp, &___tail, (n)); \
                                  ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:834:30: note: expanded from macro 'kfifo_out_linear'
           typeof((fifo) + 1) __tmp = (fifo); \
                              ~~~~~    ^~~~
   1 warning generated.


vim +/__tmp +346 drivers/tty/serial/men_z135_uart.c

   287	
   288	/**
   289	 * men_z135_handle_tx() - TX tasklet routine
   290	 * @uart: Pointer to struct men_z135_port
   291	 *
   292	 */
   293	static void men_z135_handle_tx(struct men_z135_port *uart)
   294	{
   295		struct uart_port *port = &uart->port;
   296		struct tty_port *tport = &port->state->port;
   297		unsigned char *tail;
   298		unsigned int n, txfree;
   299		u32 txc;
   300		u32 wptr;
   301		int qlen;
   302	
   303		if (kfifo_is_empty(&tport->xmit_fifo))
   304			goto out;
   305	
   306		if (uart_tx_stopped(port))
   307			goto out;
   308	
   309		if (port->x_char)
   310			goto out;
   311	
   312		/* calculate bytes to copy */
   313		qlen = kfifo_len(&tport->xmit_fifo);
   314		if (qlen <= 0)
   315			goto out;
   316	
   317		wptr = ioread32(port->membase + MEN_Z135_TX_CTRL);
   318		txc = (wptr >> 16) & 0x3ff;
   319		wptr &= 0x3ff;
   320	
   321		if (txc > MEN_Z135_FIFO_WATERMARK)
   322			txc = MEN_Z135_FIFO_WATERMARK;
   323	
   324		txfree = MEN_Z135_FIFO_WATERMARK - txc;
   325		if (txfree <= 0) {
   326			dev_err(&uart->mdev->dev,
   327				"Not enough room in TX FIFO have %d, need %d\n",
   328				txfree, qlen);
   329			goto irq_en;
   330		}
   331	
   332		/* if we're not aligned, it's better to copy only 1 or 2 bytes and
   333		 * then the rest.
   334		 */
   335		if (align && qlen >= 3 && BYTES_TO_ALIGN(wptr))
   336			n = 4 - BYTES_TO_ALIGN(wptr);
   337		else if (qlen > txfree)
   338			n = txfree;
   339		else
   340			n = qlen;
   341	
   342		if (n <= 0)
   343			goto irq_en;
   344	
   345	
 > 346		n = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
   347				min_t(unsigned int, UART_XMIT_SIZE, n));
   348		memcpy_toio(port->membase + MEN_Z135_TX_RAM, tail, n);
   349		kfifo_dma_out_finish(&tport->xmit_fifo, n);
   350	
   351		iowrite32(n & 0x3ff, port->membase + MEN_Z135_TX_CTRL);
   352	
   353		port->icount.tx += n;
   354	
   355		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
   356			uart_write_wakeup(port);
   357	
   358	irq_en:
   359		if (!kfifo_is_empty(&tport->xmit_fifo))
   360			men_z135_reg_set(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
   361		else
   362			men_z135_reg_clr(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
   363	
   364	out:
   365		return;
   366	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
