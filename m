Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC15653D612
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiFDIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiFDIQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 04:16:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB79FD9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654330586; x=1685866586;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sKvv2rSh1byY2alcOt60uMDMNg+RbXaffQMP88UhYZc=;
  b=eu9aFgbEfd0DMJ5TfvT1TI0u1ShS/IBZLn44XjHJexaRz0WIoWc9VoUX
   HkbuA4iwa/FbJRn1s5RnMiRNX/03jL7eCGh/i26xKmHiCKBAKVG0KZo3j
   b3jJxSvbmR4PRET9G/o/cEpLmpOpnqUYCfXSIHEbIpr3ZOf2qBoE4UaS1
   Ku37kfYMK9EU4AM5epLjFBdTR+MGBKLd892sch3yHfGpA/JhzWp9vKm8K
   jgKk+pWPutjIabJx3Sy1hhAUDoGKWJzv0spr8IuCX1nrZyrcrZN8y5mAD
   cTniJQ+OiSl8lB7UpAxrAFDRYWwGByGuiuYdrjq4s2knIWBobDatIVAgE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="264086271"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="264086271"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 01:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="668775391"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 01:16:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxOxL-000AUJ-B9;
        Sat, 04 Jun 2022 08:16:23 +0000
Date:   Sat, 4 Jun 2022 16:15:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.18-esp32 42/45]
 drivers/tty/serial/esp32_uart.c:33:6: warning: no previous prototype for
 'dbg_echo'
Message-ID: <202206041621.cmMY1siz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.18-esp32
head:   137adeae90088411fe27a1be624afd8336542302
commit: 4475ad0ed7f7654f6cbc879814c0a2bad8274db4 [42/45] WIP: drivers/tty/serial: add driver for ESP32 UART
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220604/202206041621.cmMY1siz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/4475ad0ed7f7654f6cbc879814c0a2bad8274db4
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.18-esp32
        git checkout 4475ad0ed7f7654f6cbc879814c0a2bad8274db4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/tty/serial/

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
