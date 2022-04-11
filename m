Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3891D4FC780
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiDKWTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiDKWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:19:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE2D20BE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649715421; x=1681251421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tEnAdWnojPkI4ODgnB1z2ZIPdW40Eu66/5Uh+i72ekE=;
  b=b7nZEXLtrww6t4Q04umoooCJccWfEgltqMPqOSpxMF1LcHfPBMdq8ROG
   9FdG2bv9hwb7nmfxSZm9X/g1EyA1QhXg1ms6ihjM9kz84uPNWbh/FfKDD
   sZrowg5jT9GsDQzivOpqVD86U1A0D10F1mFX2MAnq9Ok3eRjzmJ/ya3Ew
   WMn65TLOAb1uaBepGh3Trm/78WFcfTImSd23xUX9n044hS3dPQSmXH+rO
   I7UQqUFrCgMzrExNw+F2HBIM2LXTRZO6levfA/HDtFyaA70Oa/XC8T4xS
   gCBY/n+Mi6bFFlkGEzDubaI9I0V0z7XmrROkS2/VYm000/nxGv4f7BXxD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287238999"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="287238999"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525748608"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2022 15:16:59 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne2LC-0002Fl-E5;
        Mon, 11 Apr 2022 22:16:58 +0000
Date:   Tue, 12 Apr 2022 06:16:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 48/48] drivers/tty/serial/samsung_tty.c:911:6:
 warning: variable 'count' is uninitialized when used here
Message-ID: <202204120654.zM4PenFU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   c196e3b15cddb539135de6a3c6bcf32b89213b4c
commit: c196e3b15cddb539135de6a3c6bcf32b89213b4c [48/48] tty: serial, use kfifo
config: arm64-randconfig-r002-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120654.zM4PenFU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=c196e3b15cddb539135de6a3c6bcf32b89213b4c
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout c196e3b15cddb539135de6a3c6bcf32b89213b4c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/samsung_tty.c:911:6: warning: variable 'count' is uninitialized when used here [-Wuninitialized]
           if (count > port->fifosize) {
               ^~~~~
   drivers/tty/serial/samsung_tty.c:877:11: note: initialize the variable 'count' to silence this warning
           int count, dma_count = 0;
                    ^
                     = 0
   1 warning generated.
--
>> drivers/tty/serial/atmel_serial.c:927:34: warning: variable 'part2_len' set but not used [-Wunused-but-set-variable]
           unsigned int tx_len, part1_len, part2_len, sg_len;
                                           ^
>> drivers/tty/serial/atmel_serial.c:927:23: warning: variable 'part1_len' set but not used [-Wunused-but-set-variable]
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


vim +/count +911 drivers/tty/serial/samsung_tty.c

29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga  2014-12-10  892  
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  893  	if (port->x_char) {
8fba6c0c4c4a52 drivers/tty/serial/samsung_tty.c Hyunki Koo      2020-05-06  894  		wr_reg(port, S3C2410_UTXH, port->x_char);
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  895  		port->icount.tx++;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  896  		port->x_char = 0;
ad5613b98a48e7 drivers/tty/serial/samsung_tty.c Hector Martin   2021-03-05  897  		return;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  898  	}
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  899  
25985edcedea63 drivers/tty/serial/samsung.c     Lucas De Marchi 2011-03-30  900  	/* if there isn't anything more to transmit, or the uart is now
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  901  	 * stopped, disable the uart and exit
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  902  	 */
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  903  
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  904  	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  905  		s3c24xx_serial_stop_tx(port);
ad5613b98a48e7 drivers/tty/serial/samsung_tty.c Hector Martin   2021-03-05  906  		return;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  907  	}
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  908  
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  909  	/* try and drain the buffer... */
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  910  
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31 @911  	if (count > port->fifosize) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga  2014-12-10  912  		count = port->fifosize;
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  913  		dma_count = 0;
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  914  	}
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  915  
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  916  	while (!(rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)) {
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  917  		unsigned char ch;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  918  
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  919  		if (!kfifo_get(&tport->xmit_fifo, &ch))
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  920  			break;
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  921  		wr_reg(port, S3C2410_UTXH, ch);
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  922  		port->icount.tx++;
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  923  		count--;
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  924  	}
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  925  
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  926  	if (!count && dma_count) {
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga  2015-07-31  927  		s3c24xx_serial_start_tx_dma(ourport, dma_count);
ad5613b98a48e7 drivers/tty/serial/samsung_tty.c Hector Martin   2021-03-05  928  		return;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  929  	}
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  930  
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  931  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  932  		uart_write_wakeup(port);
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  933  
c196e3b15cddb5 drivers/tty/serial/samsung_tty.c Jiri Slaby      2022-01-05  934  	if (kfifo_is_empty(&tport->xmit_fifo))
b497549a035c2a drivers/serial/samsung.c         Ben Dooks       2008-07-03  935  		s3c24xx_serial_stop_tx(port);
ad5613b98a48e7 drivers/tty/serial/samsung_tty.c Hector Martin   2021-03-05  936  }
ad5613b98a48e7 drivers/tty/serial/samsung_tty.c Hector Martin   2021-03-05  937  

:::::: The code at line 911 was first introduced by commit
:::::: 736cd79f483fd7a1e0b71e6eaddf01d8d87fbbbb serial: samsung: fix DMA for FIFO smaller than cache line size

:::::: TO: Robert Baldyga <r.baldyga@samsung.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
