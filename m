Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E0547174
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbiFKCsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiFKCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:48:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B71C92E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654915681; x=1686451681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JDIGuIE/sWIsuGOtCT6RC0SdPcKMXgY7qvg/ZRqOW5I=;
  b=JVpMtu5u9nFrcCBKtQ5QqfrSWT/uoiJqjNGbCh/QgmClEKoyaYSIeGzU
   n3wqBkCrFUQ7rrR10L2G93sWWYSPXJj0mh7ObGQA/yNagyCkT4HCW/C8X
   DY5988ZtjEKg+JW75onBaYiPzEPBKqT6sGcuvA7WofjJNFtbwH8kVr4OX
   jRKThj+l6lY27BkRsIBZG/dsA7JBEBIhepfEbncH8iT9QNGI1HUc0+wyP
   5khzuhCnob80pcKDj6qeE1cjhPR/dH6sPSp61jlwJOfNmCg9WZVYi16Bg
   D4eOg6PaMUZFickCLLzFe7TjXXe5XryWLlXdbZJWycahZkrqgOWm1Svnk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="303190139"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="303190139"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 19:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="711209559"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2022 19:48:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzrAN-000IUD-Ev;
        Sat, 11 Jun 2022 02:47:59 +0000
Date:   Sat, 11 Jun 2022 10:47:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.19-esp32 5/9]
 drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for
 'dbg_echo'
Message-ID: <202206111058.DLtGNJRk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.19-esp32
head:   a44bcd03203280e59963b3eb3bfba38402be6e33
commit: 88ec52cf55d1fbcbdd78ef3bad5c963b70686883 [5/9] WIP: drivers/tty/serial: add driver for ESP32 UART
config: parisc64-allyesconfig (https://download.01.org/0day-ci/archive/20220611/202206111058.DLtGNJRk-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/88ec52cf55d1fbcbdd78ef3bad5c963b70686883
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.19-esp32
        git checkout 88ec52cf55d1fbcbdd78ef3bad5c963b70686883
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/mgag200/ drivers/iio/adc/ drivers/regulator/ drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for 'dbg_echo' [-Wmissing-prototypes]
      33 | void dbg_echo(const char *s)
         |      ^~~~~~~~
>> drivers/tty/serial/esp32_uart.c:48:6: warning: no previous prototype for 'dbg_printf' [-Wmissing-prototypes]
      48 | void dbg_printf(const char *fmt, ...)
         |      ^~~~~~~~~~
   drivers/tty/serial/esp32_uart.c: In function 'dbg_printf':
>> drivers/tty/serial/esp32_uart.c:54:9: warning: function 'dbg_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      54 |         vsnprintf(buf, sizeof(buf), fmt, ap);
         |         ^~~~~~~~~


vim +/dbg_echo +33 drivers/tty/serial/esp32_uart.c

    32	
  > 33	void dbg_echo(const char *s)
    34	{
    35		volatile void __iomem *base = (volatile void __iomem *)0x3ff40000;
    36	
    37		while ((readl(base + UART_STATUS_REG) & UART_TXFIFO_CNT_MASK) != 0)
    38			;
    39	
    40		while (*s) {
    41			if (*s == '\n')
    42				writel('\r', base + UART_FIFO_REG);
    43			writel(*s, base + UART_FIFO_REG);
    44			++s;
    45		}
    46	}
    47	
  > 48	void dbg_printf(const char *fmt, ...)
    49	{
    50		va_list ap;
    51		char buf[256];
    52	
    53		va_start(ap, fmt);
  > 54		vsnprintf(buf, sizeof(buf), fmt, ap);
    55		va_end(ap);
    56		dbg_echo(buf);
    57	}
    58	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
