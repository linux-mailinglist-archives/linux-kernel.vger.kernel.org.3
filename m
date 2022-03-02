Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1534E4CA9C7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiCBQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCBQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:05:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC617304B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646237082; x=1677773082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=26NxKWXwuqD597/8BtfYtSDKtIxWP5CHP1tVb2le7Nk=;
  b=EqyZaOmZm1duuH1LvoEvky/gRN/RrEyH8PcPdY3yimuIC0JzGfti3Ws3
   UYK3YBh4wF0D3juALLNjzhRbfTqBISDapO+qS5pc8FXzVs26fYtOPxvL9
   06W6RlErlpQ4JzLcn8PjNUogMXD7OdvXZDOS3F1/nce2LmxAg6JFdWqFc
   FIAMbMA+9g26iVSAfUSpJWqYnYekzFyi7CRsByXksIBK+mfjYrppbtmHn
   U5Wl0RnwoJXrVR4WAf72J+1p1/6/ViPwZ6UfSrwd/mkdWzRGc25nwOb0e
   VhQ1trgMJEkm7+dIeadJO1WGedUX9losXKGTTo+Oln8JvOnpOSnCiTYk4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252265236"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="252265236"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="508246111"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 08:04:13 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPRSW-0001ZU-EB; Wed, 02 Mar 2022 16:04:12 +0000
Date:   Thu, 3 Mar 2022 00:03:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 1/26] drivers/tty/serial/sunplus-uart.c:526:7:
 error: incompatible function pointer types passing 'void (struct uart_port
 *, int)' to parameter of type 'void (*)(struct uart_port *, unsigned char)'
Message-ID: <202203022325.0pJF6ttl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   7191d41e22ce0a4e950f14966bad50b609e1bae5
commit: 5382fe2c6cd08c05c0def9d3bf422a2a454a5ff9 [1/26] serial: make uart_console_write->putchar()'s character an unsigned char
config: hexagon-randconfig-r001-20220302 (https://download.01.org/0day-ci/archive/20220302/202203022325.0pJF6ttl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=5382fe2c6cd08c05c0def9d3bf422a2a454a5ff9
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 5382fe2c6cd08c05c0def9d3bf422a2a454a5ff9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sunplus-uart.c:526:7: error: incompatible function pointer types passing 'void (struct uart_port *, int)' to parameter of type 'void (*)(struct uart_port *, unsigned char)' [-Werror,-Wincompatible-function-pointer-types]
                              sunplus_uart_console_putchar);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/serial_core.h:402:11: note: passing argument to parameter 'putchar' here
                           void (*putchar)(struct uart_port *, unsigned char));
                                  ^
   drivers/tty/serial/sunplus-uart.c:752:39: error: incompatible function pointer types passing 'void (struct uart_port *, int)' to parameter of type 'void (*)(struct uart_port *, unsigned char)' [-Werror,-Wincompatible-function-pointer-types]
           uart_console_write(&dev->port, s, n, sunplus_uart_putc);
                                                ^~~~~~~~~~~~~~~~~
   include/linux/serial_core.h:402:11: note: passing argument to parameter 'putchar' here
                           void (*putchar)(struct uart_port *, unsigned char));
                                  ^
   2 errors generated.


vim +526 drivers/tty/serial/sunplus-uart.c

9e8d5470325f25 Hammer Hsieh 2022-02-22  508  
9e8d5470325f25 Hammer Hsieh 2022-02-22  509  static void sunplus_console_write(struct console *co,
9e8d5470325f25 Hammer Hsieh 2022-02-22  510  				  const char *s,
9e8d5470325f25 Hammer Hsieh 2022-02-22  511  				  unsigned int count)
9e8d5470325f25 Hammer Hsieh 2022-02-22  512  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  513  	unsigned long flags;
9e8d5470325f25 Hammer Hsieh 2022-02-22  514  	int locked = 1;
9e8d5470325f25 Hammer Hsieh 2022-02-22  515  
9e8d5470325f25 Hammer Hsieh 2022-02-22  516  	local_irq_save(flags);
9e8d5470325f25 Hammer Hsieh 2022-02-22  517  
9e8d5470325f25 Hammer Hsieh 2022-02-22  518  	if (sunplus_console_ports[co->index]->port.sysrq)
9e8d5470325f25 Hammer Hsieh 2022-02-22  519  		locked = 0;
9e8d5470325f25 Hammer Hsieh 2022-02-22  520  	else if (oops_in_progress)
9e8d5470325f25 Hammer Hsieh 2022-02-22  521  		locked = spin_trylock(&sunplus_console_ports[co->index]->port.lock);
9e8d5470325f25 Hammer Hsieh 2022-02-22  522  	else
9e8d5470325f25 Hammer Hsieh 2022-02-22  523  		spin_lock(&sunplus_console_ports[co->index]->port.lock);
9e8d5470325f25 Hammer Hsieh 2022-02-22  524  
9e8d5470325f25 Hammer Hsieh 2022-02-22  525  	uart_console_write(&sunplus_console_ports[co->index]->port, s, count,
9e8d5470325f25 Hammer Hsieh 2022-02-22 @526  			   sunplus_uart_console_putchar);
9e8d5470325f25 Hammer Hsieh 2022-02-22  527  
9e8d5470325f25 Hammer Hsieh 2022-02-22  528  	if (locked)
9e8d5470325f25 Hammer Hsieh 2022-02-22  529  		spin_unlock(&sunplus_console_ports[co->index]->port.lock);
9e8d5470325f25 Hammer Hsieh 2022-02-22  530  
9e8d5470325f25 Hammer Hsieh 2022-02-22  531  	local_irq_restore(flags);
9e8d5470325f25 Hammer Hsieh 2022-02-22  532  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  533  

:::::: The code at line 526 was first introduced by commit
:::::: 9e8d5470325f25bed7d33f9faaae6d5e4f313650 serial: sunplus-uart: Add Sunplus SoC UART Driver

:::::: TO: Hammer Hsieh <hammerh0314@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
