Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5BB4FC260
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348606AbiDKQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348610AbiDKQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:32:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8730F41
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649694591; x=1681230591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=77oPR4LmE7Bt119yuWsMyORGZb3xw2RvMXnIBUrecwE=;
  b=iQ8d9GTRxKXqE63iQJZuY3KijPWZf/NgGuvZk1rilWpQRa8HRd7FNeiw
   p3lpEMfot1kGARYRwdrKDLpW9V/BU6oFOLiotjcdN8OrOY2OrXWt8Od0G
   3wjnsqt+ia10ov1tBo5sbxyvOFwgRjPX1qIt6ZRyqpgkN/i4Xg3tOLHXV
   fJzlFyhDVbujtGB0KaMUOpgBws/IcgDfUGYLR/dGmuU+98p/+LWkDmaMT
   TccjMar7evhxdKvCSGs4Gxs35JLaAXyCFu8J1hAxVC6ax7BFUfBBAHlxR
   5zEuUYWhNrRr2SoK8CK4OlPmy+IsV/sUV/F/phzJi7jOzsiHqas1SzK9t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325069196"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="325069196"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="589943900"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2022 09:29:48 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndwvE-0001yl-5R;
        Mon, 11 Apr 2022 16:29:48 +0000
Date:   Tue, 12 Apr 2022 00:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 48/48] drivers/tty/serial/atmel_serial.c:985:13:
 warning: variable 'sg_len' is uninitialized when used here
Message-ID: <202204120034.naMtjHQQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   c196e3b15cddb539135de6a3c6bcf32b89213b4c
commit: c196e3b15cddb539135de6a3c6bcf32b89213b4c [48/48] tty: serial, use kfifo
config: hexagon-randconfig-r045-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120034.naMtjHQQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=c196e3b15cddb539135de6a3c6bcf32b89213b4c
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout c196e3b15cddb539135de6a3c6bcf32b89213b4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/atmel_serial.c:927:23: warning: variable 'part1_len' set but not used [-Wunused-but-set-variable]
           unsigned int tx_len, part1_len, part2_len, sg_len;
                                ^
   drivers/tty/serial/atmel_serial.c:927:34: warning: variable 'part2_len' set but not used [-Wunused-but-set-variable]
           unsigned int tx_len, part1_len, part2_len, sg_len;
                                           ^
>> drivers/tty/serial/atmel_serial.c:985:13: warning: variable 'sg_len' is uninitialized when used here [-Wuninitialized]
                                                  sg_len,
                                                  ^~~~~~
   drivers/tty/serial/atmel_serial.c:927:51: note: initialize the variable 'sg_len' to silence this warning
           unsigned int tx_len, part1_len, part2_len, sg_len;
                                                            ^
                                                             = 0
   3 warnings generated.
--
>> drivers/tty/serial/serial-tegra.c:584:25: warning: variable 'count' is uninitialized when used here [-Wuninitialized]
           if (tup->use_tx_pio || count < TEGRA_UART_MIN_DMA)
                                  ^~~~~
   drivers/tty/serial/serial-tegra.c:571:21: note: initialize the variable 'count' to silence this warning
           unsigned long count;
                              ^
                               = 0
>> drivers/tty/serial/serial-tegra.c:586:26: warning: variable 'tail' is uninitialized when used here [-Wuninitialized]
           else if (BYTES_TO_ALIGN(tail) > 0)
                                   ^~~~
   drivers/tty/serial/serial-tegra.c:39:46: note: expanded from macro 'BYTES_TO_ALIGN'
   #define BYTES_TO_ALIGN(x)                       ((unsigned long)(x) & 0x3)
                                                                    ^
   drivers/tty/serial/serial-tegra.c:570:20: note: initialize the variable 'tail' to silence this warning
           unsigned long tail;
                             ^
                              = 0
>> drivers/tty/serial/serial-tegra.c:1188:26: warning: variable 'dma_buf' is uninitialized when used here [-Wuninitialized]
                   tup->tx_dma_buf_virt = dma_buf;
                                          ^~~~~~~
   drivers/tty/serial/serial-tegra.c:1140:24: note: initialize the variable 'dma_buf' to silence this warning
           unsigned char *dma_buf;
                                 ^
                                  = NULL
>> drivers/tty/serial/serial-tegra.c:1189:26: warning: variable 'dma_phys' is uninitialized when used here [-Wuninitialized]
                   tup->tx_dma_buf_phys = dma_phys;
                                          ^~~~~~~~
   drivers/tty/serial/serial-tegra.c:1141:21: note: initialize the variable 'dma_phys' to silence this warning
           dma_addr_t dma_phys;
                              ^
                               = 0
   4 warnings generated.


vim +/sg_len +985 drivers/tty/serial/atmel_serial.c

08f738be88bb7a Elen Song       2013-07-22   916  
08f738be88bb7a Elen Song       2013-07-22   917  /*
08f738be88bb7a Elen Song       2013-07-22   918   * Called from tasklet with TXRDY interrupt is disabled.
08f738be88bb7a Elen Song       2013-07-22   919   */
08f738be88bb7a Elen Song       2013-07-22   920  static void atmel_tx_dma(struct uart_port *port)
08f738be88bb7a Elen Song       2013-07-22   921  {
08f738be88bb7a Elen Song       2013-07-22   922  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
c196e3b15cddb5 Jiri Slaby      2022-01-05   923  	struct tty_port *tport = &port->state->port;
08f738be88bb7a Elen Song       2013-07-22   924  	struct dma_chan *chan = atmel_port->chan_tx;
08f738be88bb7a Elen Song       2013-07-22   925  	struct dma_async_tx_descriptor *desc;
c196e3b15cddb5 Jiri Slaby      2022-01-05   926  	struct scatterlist sgl[2], /**sg,*/ *sg_tx = &atmel_port->sg_tx;
5f258b3e3d223b Cyrille Pitchen 2015-07-02  @927  	unsigned int tx_len, part1_len, part2_len, sg_len;
c196e3b15cddb5 Jiri Slaby      2022-01-05   928  	//dma_addr_t phys_addr;
08f738be88bb7a Elen Song       2013-07-22   929  
08f738be88bb7a Elen Song       2013-07-22   930  	/* Make sure we have an idle channel */
08f738be88bb7a Elen Song       2013-07-22   931  	if (atmel_port->desc_tx != NULL)
08f738be88bb7a Elen Song       2013-07-22   932  		return;
08f738be88bb7a Elen Song       2013-07-22   933  
c196e3b15cddb5 Jiri Slaby      2022-01-05   934  	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(port)) {
08f738be88bb7a Elen Song       2013-07-22   935  		/*
08f738be88bb7a Elen Song       2013-07-22   936  		 * DMA is idle now.
08f738be88bb7a Elen Song       2013-07-22   937  		 * Port xmit buffer is already mapped,
08f738be88bb7a Elen Song       2013-07-22   938  		 * and it is one page... Just adjust
08f738be88bb7a Elen Song       2013-07-22   939  		 * offsets and lengths. Since it is a circular buffer,
08f738be88bb7a Elen Song       2013-07-22   940  		 * we have to transmit till the end, and then the rest.
08f738be88bb7a Elen Song       2013-07-22   941  		 * Take the port lock to get a
08f738be88bb7a Elen Song       2013-07-22   942  		 * consistent xmit buffer state.
08f738be88bb7a Elen Song       2013-07-22   943  		 */
c196e3b15cddb5 Jiri Slaby      2022-01-05   944  		tx_len = 0;/*CIRC_CNT_TO_END(xmit->head,
08f738be88bb7a Elen Song       2013-07-22   945  					 xmit->tail,
c196e3b15cddb5 Jiri Slaby      2022-01-05   946  					 UART_XMIT_SIZE);*/
5f258b3e3d223b Cyrille Pitchen 2015-07-02   947  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   948  		if (atmel_port->fifo_size) {
5f258b3e3d223b Cyrille Pitchen 2015-07-02   949  			/* multi data mode */
5f258b3e3d223b Cyrille Pitchen 2015-07-02   950  			part1_len = (tx_len & ~0x3); /* DWORD access */
5f258b3e3d223b Cyrille Pitchen 2015-07-02   951  			part2_len = (tx_len & 0x3); /* BYTE access */
5f258b3e3d223b Cyrille Pitchen 2015-07-02   952  		} else {
5f258b3e3d223b Cyrille Pitchen 2015-07-02   953  			/* single data (legacy) mode */
5f258b3e3d223b Cyrille Pitchen 2015-07-02   954  			part1_len = 0;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   955  			part2_len = tx_len; /* BYTE access only */
5f258b3e3d223b Cyrille Pitchen 2015-07-02   956  		}
5f258b3e3d223b Cyrille Pitchen 2015-07-02   957  
c196e3b15cddb5 Jiri Slaby      2022-01-05   958  #if 0
5f258b3e3d223b Cyrille Pitchen 2015-07-02   959  		sg_init_table(sgl, 2);
5f258b3e3d223b Cyrille Pitchen 2015-07-02   960  		sg_len = 0;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   961  		phys_addr = sg_dma_address(sg_tx) + xmit->tail;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   962  		if (part1_len) {
5f258b3e3d223b Cyrille Pitchen 2015-07-02   963  			sg = &sgl[sg_len++];
5f258b3e3d223b Cyrille Pitchen 2015-07-02   964  			sg_dma_address(sg) = phys_addr;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   965  			sg_dma_len(sg) = part1_len;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   966  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   967  			phys_addr += part1_len;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   968  		}
5f258b3e3d223b Cyrille Pitchen 2015-07-02   969  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   970  		if (part2_len) {
5f258b3e3d223b Cyrille Pitchen 2015-07-02   971  			sg = &sgl[sg_len++];
5f258b3e3d223b Cyrille Pitchen 2015-07-02   972  			sg_dma_address(sg) = phys_addr;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   973  			sg_dma_len(sg) = part2_len;
5f258b3e3d223b Cyrille Pitchen 2015-07-02   974  		}
c196e3b15cddb5 Jiri Slaby      2022-01-05   975  #endif
5f258b3e3d223b Cyrille Pitchen 2015-07-02   976  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   977  		/*
5f258b3e3d223b Cyrille Pitchen 2015-07-02   978  		 * save tx_len so atmel_complete_tx_dma() will increase
5f258b3e3d223b Cyrille Pitchen 2015-07-02   979  		 * xmit->tail correctly
5f258b3e3d223b Cyrille Pitchen 2015-07-02   980  		 */
5f258b3e3d223b Cyrille Pitchen 2015-07-02   981  		atmel_port->tx_len = tx_len;
08f738be88bb7a Elen Song       2013-07-22   982  
08f738be88bb7a Elen Song       2013-07-22   983  		desc = dmaengine_prep_slave_sg(chan,
5f258b3e3d223b Cyrille Pitchen 2015-07-02   984  					       sgl,
5f258b3e3d223b Cyrille Pitchen 2015-07-02  @985  					       sg_len,
08f738be88bb7a Elen Song       2013-07-22   986  					       DMA_MEM_TO_DEV,
08f738be88bb7a Elen Song       2013-07-22   987  					       DMA_PREP_INTERRUPT |
08f738be88bb7a Elen Song       2013-07-22   988  					       DMA_CTRL_ACK);
08f738be88bb7a Elen Song       2013-07-22   989  		if (!desc) {
08f738be88bb7a Elen Song       2013-07-22   990  			dev_err(port->dev, "Failed to send via dma!\n");
08f738be88bb7a Elen Song       2013-07-22   991  			return;
08f738be88bb7a Elen Song       2013-07-22   992  		}
08f738be88bb7a Elen Song       2013-07-22   993  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   994  		dma_sync_sg_for_device(port->dev, sg_tx, 1, DMA_TO_DEVICE);
08f738be88bb7a Elen Song       2013-07-22   995  
08f738be88bb7a Elen Song       2013-07-22   996  		atmel_port->desc_tx = desc;
08f738be88bb7a Elen Song       2013-07-22   997  		desc->callback = atmel_complete_tx_dma;
08f738be88bb7a Elen Song       2013-07-22   998  		desc->callback_param = atmel_port;
08f738be88bb7a Elen Song       2013-07-22   999  		atmel_port->cookie_tx = dmaengine_submit(desc);
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1000  		if (dma_submit_error(atmel_port->cookie_tx)) {
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1001  			dev_err(port->dev, "dma_submit_error %d\n",
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1002  				atmel_port->cookie_tx);
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1003  			return;
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1004  		}
4f4b9b5895614e Tudor Ambarus   2021-11-25  1005  
4f4b9b5895614e Tudor Ambarus   2021-11-25  1006  		dma_async_issue_pending(chan);
08f738be88bb7a Elen Song       2013-07-22  1007  	}
08f738be88bb7a Elen Song       2013-07-22  1008  
c196e3b15cddb5 Jiri Slaby      2022-01-05  1009  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
08f738be88bb7a Elen Song       2013-07-22  1010  		uart_write_wakeup(port);
08f738be88bb7a Elen Song       2013-07-22  1011  }
08f738be88bb7a Elen Song       2013-07-22  1012  

:::::: The code at line 985 was first introduced by commit
:::::: 5f258b3e3d223b5cb6d1753b2f9b821ba4455f81 tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabled

:::::: TO: Cyrille Pitchen <cyrille.pitchen@atmel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
