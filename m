Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73FE476F92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhLPLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:11:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:11219 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231602AbhLPLK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639653059; x=1671189059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ds3RgWZvW4eDde03mNH/3gjdsT6ti6b62fyD+QUbS3M=;
  b=NgHIqqmY9b/+B72o5fPBgXDGmu87/bqOGZ7R6V+bKO6O2cjQsU/i1clB
   JZ1TqFOi8rIZ0EPCGkEtQEFPbfnFu2uPzyqKxZt+pQZ8yKKqmOIHPCoO4
   3x7p/4tswKXtAuORF6cSbyY6svXsW/rEi1Nj5yyxAMPDpMrd1U7fXWDo1
   /2HBUBv3U5gAS8AZjAuAw4UotI2+5ieLqlpliKNyVrDDKIDWN3AQGComn
   Uu9J0TKZlTmX/weFrTQucvJ1pAJANSIlBuEI48Eb1dmlc5UOTd+fQVhzY
   uTK+4Tx79rXIQCnJe6wleCAdhFJmQlE3K6sB1yqOOt56E4J1O2Kb8IeHs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220144113"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="220144113"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="506234772"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 03:10:57 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxof3-00033J-2t; Thu, 16 Dec 2021 11:10:57 +0000
Date:   Thu, 16 Dec 2021 19:10:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 22/33] drivers/tty/serial/pch_uart.c:955:17:
 sparse: sparse: incompatible types in comparison expression (different
 signedness):
Message-ID: <202112161927.OMw1GBHb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   d61595c5423534810c1a3c0d4a88dd2fd81d750c
commit: 4671e2ec5eadf881696fad611235561e94c6be9c [22/33] circ_buf: switch macros to inlines
config: i386-randconfig-s001-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161927.OMw1GBHb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=4671e2ec5eadf881696fad611235561e94c6be9c
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 4671e2ec5eadf881696fad611235561e94c6be9c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/pch_uart.c:955:17: sparse: sparse: incompatible types in comparison expression (different signedness):
>> drivers/tty/serial/pch_uart.c:955:17: sparse:    int *
>> drivers/tty/serial/pch_uart.c:955:17: sparse:    unsigned int *
   drivers/tty/serial/pch_uart.c:1474:30: sparse: sparse: restricted upf_t degrades to integer
   drivers/tty/serial/pch_uart.c:1478:32: sparse: sparse: invalid assignment: &=
   drivers/tty/serial/pch_uart.c:1478:32: sparse:    left side has type int
   drivers/tty/serial/pch_uart.c:1478:32: sparse:    right side has type restricted upf_t
   drivers/tty/serial/pch_uart.c:1662:28: sparse: sparse: context imbalance in 'pch_console_write' - unexpected unlock

vim +955 drivers/tty/serial/pch_uart.c

3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   917  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   918  static unsigned int dma_handle_tx(struct eg20t_port *priv)
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   919  {
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   920  	struct uart_port *port = &priv->port;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   921  	struct circ_buf *xmit = &port->state->xmit;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   922  	struct scatterlist *sg;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   923  	int nent;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   924  	int fifo_size;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   925  	struct dma_async_tx_descriptor *desc;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   926  	int num;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   927  	int i;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   928  	int bytes;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   929  	int size;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   930  	int rem;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   931  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   932  	if (!priv->start_tx) {
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   933  		dev_info(priv->port.dev, "%s:Tx isn't started. (%lu)\n",
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   934  			__func__, jiffies);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   935  		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   936  		priv->tx_empty = 1;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   937  		return 0;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   938  	}
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   939  
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   940  	if (priv->tx_dma_use) {
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   941  		dev_dbg(priv->port.dev, "%s:Tx is not completed. (%lu)\n",
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   942  			__func__, jiffies);
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   943  		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   944  		priv->tx_empty = 1;
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   945  		return 0;
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   946  	}
60d1031e114a3e drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   947  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   948  	fifo_size = max(priv->fifo_size, 1);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   949  	if (pop_tx_x(priv, xmit->buf)) {
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   950  		pch_uart_hal_write(priv, xmit->buf, 1);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   951  		port->icount.tx++;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   952  		fifo_size--;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   953  	}
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   954  
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  @955  	bytes = min((int)CIRC_CNT(xmit->head, xmit->tail,
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   956  			     UART_XMIT_SIZE), CIRC_CNT_TO_END(xmit->head,
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   957  			     xmit->tail, UART_XMIT_SIZE));
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   958  	if (!bytes) {
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   959  		dev_dbg(priv->port.dev, "%s 0 bytes return\n", __func__);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   960  		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   961  		uart_write_wakeup(port);
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   962  		return 0;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   963  	}
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   964  
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   965  	if (bytes > fifo_size) {
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   966  		num = bytes / fifo_size + 1;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   967  		size = fifo_size;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   968  		rem = bytes % fifo_size;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   969  	} else {
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   970  		num = 1;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   971  		size = bytes;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   972  		rem = bytes;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   973  	}
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   974  
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   975  	dev_dbg(priv->port.dev, "%s num=%d size=%d rem=%d\n",
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   976  		__func__, num, size, rem);
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   977  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   978  	priv->tx_dma_use = 1;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   979  
290ff182e92a3d drivers/tty/serial/pch_uart.c Julia Lawall       2020-09-20   980  	priv->sg_tx_p = kmalloc_array(num, sizeof(struct scatterlist), GFP_ATOMIC);
a92098a1cb7ec0 drivers/tty/serial/pch_uart.c Fengguang Wu       2012-07-28   981  	if (!priv->sg_tx_p) {
a92098a1cb7ec0 drivers/tty/serial/pch_uart.c Fengguang Wu       2012-07-28   982  		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
a92098a1cb7ec0 drivers/tty/serial/pch_uart.c Fengguang Wu       2012-07-28   983  		return 0;
a92098a1cb7ec0 drivers/tty/serial/pch_uart.c Fengguang Wu       2012-07-28   984  	}
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   985  
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   986  	sg_init_table(priv->sg_tx_p, num); /* Initialize SG table */
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   987  	sg = priv->sg_tx_p;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   988  
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   989  	for (i = 0; i < num; i++, sg++) {
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   990  		if (i == (num - 1))
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   991  			sg_set_page(sg, virt_to_page(xmit->buf),
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   992  				    rem, fifo_size * i);
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   993  		else
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   994  			sg_set_page(sg, virt_to_page(xmit->buf),
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   995  				    size, fifo_size * i);
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   996  	}
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17   997  
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   998  	sg = priv->sg_tx_p;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23   999  	nent = dma_map_sg(port->dev, sg, num, DMA_TO_DEVICE);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1000  	if (!nent) {
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1001  		dev_err(priv->port.dev, "%s:dma_map_sg Failed\n", __func__);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1002  		return 0;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1003  	}
74887542fdcc92 drivers/tty/serial/pch_uart.c Peng Fan           2019-11-13  1004  	priv->orig_nent = num;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1005  	priv->nent = nent;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1006  
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1007  	for (i = 0; i < nent; i++, sg++) {
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1008  		sg->offset = (xmit->tail & (UART_XMIT_SIZE - 1)) +
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1009  			      fifo_size * i;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1010  		sg_dma_address(sg) = (sg_dma_address(sg) &
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1011  				    ~(UART_XMIT_SIZE - 1)) + sg->offset;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1012  		if (i == (nent - 1))
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1013  			sg_dma_len(sg) = rem;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1014  		else
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1015  			sg_dma_len(sg) = size;
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1016  	}
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1017  
16052827d98fbc drivers/tty/serial/pch_uart.c Alexandre Bounine  2012-03-08  1018  	desc = dmaengine_prep_slave_sg(priv->chan_tx,
a485df4b440437 drivers/tty/serial/pch_uart.c Vinod Koul         2011-10-14  1019  					priv->sg_tx_p, nent, DMA_MEM_TO_DEV,
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1020  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1021  	if (!desc) {
493671a2cecbb7 drivers/tty/serial/pch_uart.c Geert Uytterhoeven 2014-07-11  1022  		dev_err(priv->port.dev, "%s:dmaengine_prep_slave_sg Failed\n",
23877fdc6df330 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1023  			__func__);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1024  		return 0;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1025  	}
da3564ee027e78 drivers/tty/serial/pch_uart.c Tomoya MORINAGA    2011-02-23  1026  	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1027  	priv->desc_tx = desc;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1028  	desc->callback = pch_dma_tx_complete;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1029  	desc->callback_param = priv;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1030  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1031  	desc->tx_submit(desc);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1032  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1033  	dma_async_issue_pending(priv->chan_tx);
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1034  
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1035  	return PCH_UART_HANDLED_TX_INT;
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1036  }
3c6a483275f47a drivers/serial/pch_uart.c     Tomoya MORINAGA    2010-11-17  1037  

:::::: The code at line 955 was first introduced by commit
:::::: da3564ee027e788a5ff8e520fb2d2b00a78b2464 pch_uart: add multi-scatter processing

:::::: TO: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
