Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2A4FDE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiDLLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356321AbiDLLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:40:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1A5AA62
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758863; x=1681294863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p6V7B0yDyO7Mu+Ri/DBEsFLVGj1883OUpp9MaCUn5ns=;
  b=XW0uXHKomP832X8Y3gNa97zQlCXZevmP8fqnUWTwCCtdrRhS5vg7LqNR
   xRUMdiWZ1ZUl+/zwuHtiPu+Dw4skVb3Mvwhrw0Bh2h1bD7tWW8dZVFwSN
   SeBFqQgYXcCTW6EJYpQ5c78L9G4L6n3gjyzf1SocMFRChWwnyoDXRGVv3
   YujMX6aO6T1UIoetYFxGSvjHRArfCDgnPZdPf8gC97+rU41IJKSRnQ3v9
   KbaDVmFUewyxcSDmC5ENJ6fEEAtbzC13raztJwhaRZ71SB4oYPkmNSwq7
   VmncTP2n3c128lzvr9moTs5fE60lzAtnvrVNyH1CC3DtAOTj0FaxFyoMo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262085895"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262085895"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="644657721"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 03:21:00 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDdr-0002ku-KE;
        Tue, 12 Apr 2022 10:20:59 +0000
Date:   Tue, 12 Apr 2022 18:20:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 48/48] drivers/tty/serial/max310x.c:753:33:
 warning: variable 'to_send' set but not used
Message-ID: <202204121850.mWrZUR2V-lkp@intel.com>
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
head:   ea94a80635daaf36a289f1ec1f982b1e094faeca
commit: ea94a80635daaf36a289f1ec1f982b1e094faeca [48/48] tty: serial, use kfifo
config: arc-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121850.mWrZUR2V-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=ea94a80635daaf36a289f1ec1f982b1e094faeca
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout ea94a80635daaf36a289f1ec1f982b1e094faeca
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/serial/ kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/max310x.c: In function 'max310x_handle_tx':
>> drivers/tty/serial/max310x.c:753:33: warning: variable 'to_send' set but not used [-Wunused-but-set-variable]
     753 |         unsigned int /*txlen,*/ to_send;//, until_end;
         |                                 ^~~~~~~


vim +/to_send +753 drivers/tty/serial/max310x.c

   749	
   750	static void max310x_handle_tx(struct uart_port *port)
   751	{
   752		struct tty_port *tport = &port->state->port;
 > 753		unsigned int /*txlen,*/ to_send;//, until_end;
   754	
   755		if (unlikely(port->x_char)) {
   756			max310x_port_write(port, MAX310X_THR_REG, port->x_char);
   757			port->icount.tx++;
   758			port->x_char = 0;
   759			return;
   760		}
   761	
   762		if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
   763			return;
   764	
   765		/* Get length of data pending in circular buffer */
   766		to_send = kfifo_len(&tport->xmit_fifo);
   767	#ifdef UNFINISHED
   768		until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
   769		if (likely(to_send)) {
   770			/* Limit to size of TX FIFO */
   771			txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
   772			txlen = port->fifosize - txlen;
   773			to_send = (to_send > txlen) ? txlen : to_send;
   774	
   775			if (until_end < to_send) {
   776				/* It's a circ buffer -- wrap around.
   777				 * We could do that in one SPI transaction, but meh. */
   778				max310x_batch_write(port, xmit->buf + xmit->tail, until_end);
   779				max310x_batch_write(port, xmit->buf, to_send - until_end);
   780			} else {
   781				max310x_batch_write(port, xmit->buf + xmit->tail, to_send);
   782			}
   783	
   784			/* Add data to send */
   785			port->icount.tx += to_send;
   786			xmit->tail = (xmit->tail + to_send) & (UART_XMIT_SIZE - 1);
   787		}
   788	#endif
   789	
   790		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
   791			uart_write_wakeup(port);
   792	}
   793	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
