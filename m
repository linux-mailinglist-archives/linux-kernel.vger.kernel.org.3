Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE634595889
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiHPKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiHPKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:36:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00291580AF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660640396; x=1692176396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q+HdrRCnvvj+ngiiNuaTCFTjvs1YWZ91n6fAjhbVwjU=;
  b=A5DnkdOt1ReYnSadhTUeobzP+WMO8k8ZkbIsO1yoSGRDEfoDvCKVsQsq
   8Hmk7ScZvVKDKTWJQaxXrGV+C4i2g+Qk+nh/z7vSxoXA/x4TKuNKYNyxh
   /cc4NaSnbDH1YZs3xJ9gQj591egkw6ufF72fuTnLoswzj9X4JaU+zhcBZ
   7vm/1ZOd5yQOsxWKh4YP6a8HEbH6ug9WJRcVwrJBYdIAtetGUnzF5Xo/f
   iGH1ubSXvjGnsswo+pRBFN1FKPNSv3oDY7dcdp++4qlNBTgP1vmNsNQsP
   ZhDJKs1Tzhli6y22rvWldgxVNqj/CzXeIoEchbj1F/uXJk1okO4YZq2St
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289737320"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="289737320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="635810857"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 01:59:51 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNsQR-0001f3-0P;
        Tue, 16 Aug 2022 08:59:51 +0000
Date:   Tue, 16 Aug 2022 16:59:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/tty/serial/sunplus-uart.c:671: undefined reference to
 `uart_remove_one_port'
Message-ID: <202208161624.f6SCFLBq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 0aa94eea8d955c82014e5368a843da93f1dc58f8 ARM: sunplus: Add initial support for Sunplus SP7021 SoC
date:   6 weeks ago
config: arm-randconfig-r012-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161624.f6SCFLBq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0aa94eea8d955c82014e5368a843da93f1dc58f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0aa94eea8d955c82014e5368a843da93f1dc58f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_remove':
>> drivers/tty/serial/sunplus-uart.c:671: undefined reference to `uart_remove_one_port'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_set_termios':
>> drivers/tty/serial/sunplus-uart.c:342: undefined reference to `uart_get_baud_rate'
>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:379: undefined reference to `uart_update_timeout'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `uart_handle_break':
>> include/linux/serial_core.h:584: undefined reference to `do_SAK'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `uart_handle_sysrq_char':
>> include/linux/serial_core.h:481: undefined reference to `uart_try_toggle_sysrq'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `receive_chars':
>> drivers/tty/serial/sunplus-uart.c:268: undefined reference to `uart_insert_char'
>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:274: undefined reference to `tty_flip_buffer_push'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_console_write':
>> drivers/tty/serial/sunplus-uart.c:526: undefined reference to `uart_console_write'
>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:526: undefined reference to `uart_console_write'
>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:526: undefined reference to `uart_console_write'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_probe':
>> drivers/tty/serial/sunplus-uart.c:658: undefined reference to `uart_add_one_port'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `transmit_chars':
>> drivers/tty/serial/sunplus-uart.c:227: undefined reference to `uart_write_wakeup'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `.LANCHOR1':
>> sunplus-uart.c:(.data+0x118): undefined reference to `uart_console_device'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_init':
>> drivers/tty/serial/sunplus-uart.c:720: undefined reference to `uart_register_driver'
>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:726: undefined reference to `uart_unregister_driver'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_console_setup':
>> drivers/tty/serial/sunplus-uart.c:551: undefined reference to `uart_parse_options'
>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:553: undefined reference to `uart_set_options'
   arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_exit':
>> drivers/tty/serial/sunplus-uart.c:735: undefined reference to `uart_unregister_driver'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
   Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=y])
   Selected by [y]:
   - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
   Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
   Selected by [y]:
   - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]


vim +671 drivers/tty/serial/sunplus-uart.c

9e8d5470325f25 Hammer Hsieh 2022-02-22  509  
9e8d5470325f25 Hammer Hsieh 2022-02-22  510  static void sunplus_console_write(struct console *co,
9e8d5470325f25 Hammer Hsieh 2022-02-22  511  				  const char *s,
9e8d5470325f25 Hammer Hsieh 2022-02-22  512  				  unsigned int count)
9e8d5470325f25 Hammer Hsieh 2022-02-22  513  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  514  	unsigned long flags;
9e8d5470325f25 Hammer Hsieh 2022-02-22  515  	int locked = 1;
9e8d5470325f25 Hammer Hsieh 2022-02-22  516  
9e8d5470325f25 Hammer Hsieh 2022-02-22  517  	local_irq_save(flags);
9e8d5470325f25 Hammer Hsieh 2022-02-22  518  
9e8d5470325f25 Hammer Hsieh 2022-02-22  519  	if (sunplus_console_ports[co->index]->port.sysrq)
9e8d5470325f25 Hammer Hsieh 2022-02-22  520  		locked = 0;
9e8d5470325f25 Hammer Hsieh 2022-02-22  521  	else if (oops_in_progress)
9e8d5470325f25 Hammer Hsieh 2022-02-22  522  		locked = spin_trylock(&sunplus_console_ports[co->index]->port.lock);
9e8d5470325f25 Hammer Hsieh 2022-02-22  523  	else
9e8d5470325f25 Hammer Hsieh 2022-02-22  524  		spin_lock(&sunplus_console_ports[co->index]->port.lock);
9e8d5470325f25 Hammer Hsieh 2022-02-22  525  
9e8d5470325f25 Hammer Hsieh 2022-02-22 @526  	uart_console_write(&sunplus_console_ports[co->index]->port, s, count,
9e8d5470325f25 Hammer Hsieh 2022-02-22  527  			   sunplus_uart_console_putchar);
9e8d5470325f25 Hammer Hsieh 2022-02-22  528  
9e8d5470325f25 Hammer Hsieh 2022-02-22  529  	if (locked)
9e8d5470325f25 Hammer Hsieh 2022-02-22  530  		spin_unlock(&sunplus_console_ports[co->index]->port.lock);
9e8d5470325f25 Hammer Hsieh 2022-02-22  531  
9e8d5470325f25 Hammer Hsieh 2022-02-22  532  	local_irq_restore(flags);
9e8d5470325f25 Hammer Hsieh 2022-02-22  533  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  534  
9e8d5470325f25 Hammer Hsieh 2022-02-22  535  static int __init sunplus_console_setup(struct console *co, char *options)
9e8d5470325f25 Hammer Hsieh 2022-02-22  536  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  537  	struct sunplus_uart_port *sup;
9e8d5470325f25 Hammer Hsieh 2022-02-22  538  	int baud = 115200;
9e8d5470325f25 Hammer Hsieh 2022-02-22  539  	int bits = 8;
9e8d5470325f25 Hammer Hsieh 2022-02-22  540  	int parity = 'n';
9e8d5470325f25 Hammer Hsieh 2022-02-22  541  	int flow = 'n';
9e8d5470325f25 Hammer Hsieh 2022-02-22  542  
9e8d5470325f25 Hammer Hsieh 2022-02-22  543  	if (co->index < 0 || co->index >= SUP_UART_NR)
9e8d5470325f25 Hammer Hsieh 2022-02-22  544  		return -EINVAL;
9e8d5470325f25 Hammer Hsieh 2022-02-22  545  
9e8d5470325f25 Hammer Hsieh 2022-02-22  546  	sup = sunplus_console_ports[co->index];
9e8d5470325f25 Hammer Hsieh 2022-02-22  547  	if (!sup)
9e8d5470325f25 Hammer Hsieh 2022-02-22  548  		return -ENODEV;
9e8d5470325f25 Hammer Hsieh 2022-02-22  549  
9e8d5470325f25 Hammer Hsieh 2022-02-22  550  	if (options)
9e8d5470325f25 Hammer Hsieh 2022-02-22 @551  		uart_parse_options(options, &baud, &parity, &bits, &flow);
9e8d5470325f25 Hammer Hsieh 2022-02-22  552  
9e8d5470325f25 Hammer Hsieh 2022-02-22 @553  	return uart_set_options(&sup->port, co, baud, parity, bits, flow);
9e8d5470325f25 Hammer Hsieh 2022-02-22  554  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  555  
9e8d5470325f25 Hammer Hsieh 2022-02-22  556  static struct uart_driver sunplus_uart_driver;
9e8d5470325f25 Hammer Hsieh 2022-02-22  557  static struct console sunplus_uart_console = {
9e8d5470325f25 Hammer Hsieh 2022-02-22  558  	.name		= "ttySUP",
9e8d5470325f25 Hammer Hsieh 2022-02-22  559  	.write		= sunplus_console_write,
9e8d5470325f25 Hammer Hsieh 2022-02-22  560  	.device		= uart_console_device,
9e8d5470325f25 Hammer Hsieh 2022-02-22  561  	.setup		= sunplus_console_setup,
9e8d5470325f25 Hammer Hsieh 2022-02-22  562  	.flags		= CON_PRINTBUFFER,
9e8d5470325f25 Hammer Hsieh 2022-02-22  563  	.index		= -1,
9e8d5470325f25 Hammer Hsieh 2022-02-22  564  	.data		= &sunplus_uart_driver
9e8d5470325f25 Hammer Hsieh 2022-02-22  565  };
a106848c42b6a0 Hammer Hsieh 2022-03-01  566  
a106848c42b6a0 Hammer Hsieh 2022-03-01  567  #define	SERIAL_SUNPLUS_CONSOLE	(&sunplus_uart_console)
a106848c42b6a0 Hammer Hsieh 2022-03-01  568  #else
a106848c42b6a0 Hammer Hsieh 2022-03-01  569  #define	SERIAL_SUNPLUS_CONSOLE	NULL
9e8d5470325f25 Hammer Hsieh 2022-02-22  570  #endif
9e8d5470325f25 Hammer Hsieh 2022-02-22  571  
9e8d5470325f25 Hammer Hsieh 2022-02-22  572  static struct uart_driver sunplus_uart_driver = {
9e8d5470325f25 Hammer Hsieh 2022-02-22  573  	.owner		= THIS_MODULE,
9e8d5470325f25 Hammer Hsieh 2022-02-22  574  	.driver_name	= "sunplus_uart",
9e8d5470325f25 Hammer Hsieh 2022-02-22  575  	.dev_name	= "ttySUP",
9e8d5470325f25 Hammer Hsieh 2022-02-22  576  	.major		= TTY_MAJOR,
9e8d5470325f25 Hammer Hsieh 2022-02-22  577  	.minor		= 64,
9e8d5470325f25 Hammer Hsieh 2022-02-22  578  	.nr		= SUP_UART_NR,
a106848c42b6a0 Hammer Hsieh 2022-03-01  579  	.cons		= SERIAL_SUNPLUS_CONSOLE,
9e8d5470325f25 Hammer Hsieh 2022-02-22  580  };
9e8d5470325f25 Hammer Hsieh 2022-02-22  581  
9e8d5470325f25 Hammer Hsieh 2022-02-22  582  static void sunplus_uart_disable_unprepare(void *data)
9e8d5470325f25 Hammer Hsieh 2022-02-22  583  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  584  	clk_disable_unprepare(data);
9e8d5470325f25 Hammer Hsieh 2022-02-22  585  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  586  
9e8d5470325f25 Hammer Hsieh 2022-02-22  587  static void sunplus_uart_reset_control_assert(void *data)
9e8d5470325f25 Hammer Hsieh 2022-02-22  588  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  589  	reset_control_assert(data);
9e8d5470325f25 Hammer Hsieh 2022-02-22  590  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  591  
9e8d5470325f25 Hammer Hsieh 2022-02-22  592  static int sunplus_uart_probe(struct platform_device *pdev)
9e8d5470325f25 Hammer Hsieh 2022-02-22  593  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  594  	struct sunplus_uart_port *sup;
9e8d5470325f25 Hammer Hsieh 2022-02-22  595  	struct uart_port *port;
9e8d5470325f25 Hammer Hsieh 2022-02-22  596  	struct resource *res;
9e8d5470325f25 Hammer Hsieh 2022-02-22  597  	int ret, irq;
9e8d5470325f25 Hammer Hsieh 2022-02-22  598  
9e8d5470325f25 Hammer Hsieh 2022-02-22  599  	pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
9e8d5470325f25 Hammer Hsieh 2022-02-22  600  
9e8d5470325f25 Hammer Hsieh 2022-02-22  601  	if (pdev->id < 0 || pdev->id >= SUP_UART_NR)
9e8d5470325f25 Hammer Hsieh 2022-02-22  602  		return -EINVAL;
9e8d5470325f25 Hammer Hsieh 2022-02-22  603  
9e8d5470325f25 Hammer Hsieh 2022-02-22  604  	sup = devm_kzalloc(&pdev->dev, sizeof(*sup), GFP_KERNEL);
9e8d5470325f25 Hammer Hsieh 2022-02-22  605  	if (!sup)
9e8d5470325f25 Hammer Hsieh 2022-02-22  606  		return -ENOMEM;
9e8d5470325f25 Hammer Hsieh 2022-02-22  607  
9e8d5470325f25 Hammer Hsieh 2022-02-22  608  	sup->clk = devm_clk_get_optional(&pdev->dev, NULL);
9e8d5470325f25 Hammer Hsieh 2022-02-22  609  	if (IS_ERR(sup->clk))
9e8d5470325f25 Hammer Hsieh 2022-02-22  610  		return dev_err_probe(&pdev->dev, PTR_ERR(sup->clk), "clk not found\n");
9e8d5470325f25 Hammer Hsieh 2022-02-22  611  
9e8d5470325f25 Hammer Hsieh 2022-02-22  612  	ret = clk_prepare_enable(sup->clk);
9e8d5470325f25 Hammer Hsieh 2022-02-22  613  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22  614  		return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  615  
9e8d5470325f25 Hammer Hsieh 2022-02-22  616  	ret = devm_add_action_or_reset(&pdev->dev, sunplus_uart_disable_unprepare, sup->clk);
9e8d5470325f25 Hammer Hsieh 2022-02-22  617  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22  618  		return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  619  
9e8d5470325f25 Hammer Hsieh 2022-02-22  620  	sup->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
9e8d5470325f25 Hammer Hsieh 2022-02-22  621  	if (IS_ERR(sup->rstc))
9e8d5470325f25 Hammer Hsieh 2022-02-22  622  		return dev_err_probe(&pdev->dev, PTR_ERR(sup->rstc), "rstc not found\n");
9e8d5470325f25 Hammer Hsieh 2022-02-22  623  
9e8d5470325f25 Hammer Hsieh 2022-02-22  624  	port = &sup->port;
9e8d5470325f25 Hammer Hsieh 2022-02-22  625  
9e8d5470325f25 Hammer Hsieh 2022-02-22  626  	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
9e8d5470325f25 Hammer Hsieh 2022-02-22  627  	if (IS_ERR(port->membase))
9e8d5470325f25 Hammer Hsieh 2022-02-22  628  		return dev_err_probe(&pdev->dev, PTR_ERR(port->membase), "membase not found\n");
9e8d5470325f25 Hammer Hsieh 2022-02-22  629  
9e8d5470325f25 Hammer Hsieh 2022-02-22  630  	irq = platform_get_irq(pdev, 0);
9e8d5470325f25 Hammer Hsieh 2022-02-22  631  	if (irq < 0)
9e8d5470325f25 Hammer Hsieh 2022-02-22  632  		return irq;
9e8d5470325f25 Hammer Hsieh 2022-02-22  633  
9e8d5470325f25 Hammer Hsieh 2022-02-22  634  	port->mapbase = res->start;
9e8d5470325f25 Hammer Hsieh 2022-02-22  635  	port->uartclk = clk_get_rate(sup->clk);
9e8d5470325f25 Hammer Hsieh 2022-02-22  636  	port->line = pdev->id;
9e8d5470325f25 Hammer Hsieh 2022-02-22  637  	port->irq = irq;
9e8d5470325f25 Hammer Hsieh 2022-02-22  638  	port->dev = &pdev->dev;
9e8d5470325f25 Hammer Hsieh 2022-02-22  639  	port->iotype = UPIO_MEM;
9e8d5470325f25 Hammer Hsieh 2022-02-22  640  	port->ops = &sunplus_uart_ops;
9e8d5470325f25 Hammer Hsieh 2022-02-22  641  	port->flags = UPF_BOOT_AUTOCONF;
9e8d5470325f25 Hammer Hsieh 2022-02-22  642  	port->fifosize = 128;
9e8d5470325f25 Hammer Hsieh 2022-02-22  643  
9e8d5470325f25 Hammer Hsieh 2022-02-22  644  	ret = reset_control_deassert(sup->rstc);
9e8d5470325f25 Hammer Hsieh 2022-02-22  645  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22  646  		return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  647  
9e8d5470325f25 Hammer Hsieh 2022-02-22  648  	ret = devm_add_action_or_reset(&pdev->dev, sunplus_uart_reset_control_assert, sup->rstc);
9e8d5470325f25 Hammer Hsieh 2022-02-22  649  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22  650  		return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  651  
9e8d5470325f25 Hammer Hsieh 2022-02-22  652  #ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
9e8d5470325f25 Hammer Hsieh 2022-02-22  653  	sunplus_console_ports[sup->port.line] = sup;
9e8d5470325f25 Hammer Hsieh 2022-02-22  654  #endif
9e8d5470325f25 Hammer Hsieh 2022-02-22  655  
9e8d5470325f25 Hammer Hsieh 2022-02-22  656  	platform_set_drvdata(pdev, &sup->port);
9e8d5470325f25 Hammer Hsieh 2022-02-22  657  
9e8d5470325f25 Hammer Hsieh 2022-02-22 @658  	ret = uart_add_one_port(&sunplus_uart_driver, &sup->port);
9e8d5470325f25 Hammer Hsieh 2022-02-22  659  #ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
9e8d5470325f25 Hammer Hsieh 2022-02-22  660  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22  661  		sunplus_console_ports[sup->port.line] = NULL;
9e8d5470325f25 Hammer Hsieh 2022-02-22  662  #endif
9e8d5470325f25 Hammer Hsieh 2022-02-22  663  
9e8d5470325f25 Hammer Hsieh 2022-02-22  664  	return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  665  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  666  
9e8d5470325f25 Hammer Hsieh 2022-02-22  667  static int sunplus_uart_remove(struct platform_device *pdev)
9e8d5470325f25 Hammer Hsieh 2022-02-22  668  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  669  	struct sunplus_uart_port *sup = platform_get_drvdata(pdev);
9e8d5470325f25 Hammer Hsieh 2022-02-22  670  
9e8d5470325f25 Hammer Hsieh 2022-02-22 @671  	uart_remove_one_port(&sunplus_uart_driver, &sup->port);
9e8d5470325f25 Hammer Hsieh 2022-02-22  672  
9e8d5470325f25 Hammer Hsieh 2022-02-22  673  	return 0;
9e8d5470325f25 Hammer Hsieh 2022-02-22  674  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  675  
9e8d5470325f25 Hammer Hsieh 2022-02-22  676  static int __maybe_unused sunplus_uart_suspend(struct device *dev)
9e8d5470325f25 Hammer Hsieh 2022-02-22  677  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  678  	struct sunplus_uart_port *sup = dev_get_drvdata(dev);
9e8d5470325f25 Hammer Hsieh 2022-02-22  679  
9e8d5470325f25 Hammer Hsieh 2022-02-22  680  	if (!uart_console(&sup->port))
9e8d5470325f25 Hammer Hsieh 2022-02-22  681  		uart_suspend_port(&sunplus_uart_driver, &sup->port);
9e8d5470325f25 Hammer Hsieh 2022-02-22  682  
9e8d5470325f25 Hammer Hsieh 2022-02-22  683  	return 0;
9e8d5470325f25 Hammer Hsieh 2022-02-22  684  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  685  
9e8d5470325f25 Hammer Hsieh 2022-02-22  686  static int __maybe_unused sunplus_uart_resume(struct device *dev)
9e8d5470325f25 Hammer Hsieh 2022-02-22  687  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  688  	struct sunplus_uart_port *sup = dev_get_drvdata(dev);
9e8d5470325f25 Hammer Hsieh 2022-02-22  689  
9e8d5470325f25 Hammer Hsieh 2022-02-22  690  	if (!uart_console(&sup->port))
9e8d5470325f25 Hammer Hsieh 2022-02-22  691  		uart_resume_port(&sunplus_uart_driver, &sup->port);
9e8d5470325f25 Hammer Hsieh 2022-02-22  692  
9e8d5470325f25 Hammer Hsieh 2022-02-22  693  	return 0;
9e8d5470325f25 Hammer Hsieh 2022-02-22  694  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  695  
9e8d5470325f25 Hammer Hsieh 2022-02-22  696  static const struct dev_pm_ops sunplus_uart_pm_ops = {
9e8d5470325f25 Hammer Hsieh 2022-02-22  697  	SET_SYSTEM_SLEEP_PM_OPS(sunplus_uart_suspend, sunplus_uart_resume)
9e8d5470325f25 Hammer Hsieh 2022-02-22  698  };
9e8d5470325f25 Hammer Hsieh 2022-02-22  699  
9e8d5470325f25 Hammer Hsieh 2022-02-22  700  static const struct of_device_id sp_uart_of_match[] = {
9e8d5470325f25 Hammer Hsieh 2022-02-22  701  	{ .compatible = "sunplus,sp7021-uart" },
9e8d5470325f25 Hammer Hsieh 2022-02-22  702  	{}
9e8d5470325f25 Hammer Hsieh 2022-02-22  703  };
9e8d5470325f25 Hammer Hsieh 2022-02-22  704  MODULE_DEVICE_TABLE(of, sp_uart_of_match);
9e8d5470325f25 Hammer Hsieh 2022-02-22  705  
9e8d5470325f25 Hammer Hsieh 2022-02-22  706  static struct platform_driver sunplus_uart_platform_driver = {
9e8d5470325f25 Hammer Hsieh 2022-02-22  707  	.probe		= sunplus_uart_probe,
9e8d5470325f25 Hammer Hsieh 2022-02-22  708  	.remove		= sunplus_uart_remove,
9e8d5470325f25 Hammer Hsieh 2022-02-22  709  	.driver = {
9e8d5470325f25 Hammer Hsieh 2022-02-22  710  		.name	= "sunplus_uart",
9e8d5470325f25 Hammer Hsieh 2022-02-22  711  		.of_match_table = sp_uart_of_match,
9e8d5470325f25 Hammer Hsieh 2022-02-22  712  		.pm     = &sunplus_uart_pm_ops,
9e8d5470325f25 Hammer Hsieh 2022-02-22  713  	}
9e8d5470325f25 Hammer Hsieh 2022-02-22  714  };
9e8d5470325f25 Hammer Hsieh 2022-02-22  715  
9e8d5470325f25 Hammer Hsieh 2022-02-22  716  static int __init sunplus_uart_init(void)
9e8d5470325f25 Hammer Hsieh 2022-02-22  717  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  718  	int ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  719  
9e8d5470325f25 Hammer Hsieh 2022-02-22 @720  	ret = uart_register_driver(&sunplus_uart_driver);
9e8d5470325f25 Hammer Hsieh 2022-02-22  721  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22  722  		return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  723  
9e8d5470325f25 Hammer Hsieh 2022-02-22  724  	ret = platform_driver_register(&sunplus_uart_platform_driver);
9e8d5470325f25 Hammer Hsieh 2022-02-22  725  	if (ret)
9e8d5470325f25 Hammer Hsieh 2022-02-22 @726  		uart_unregister_driver(&sunplus_uart_driver);
9e8d5470325f25 Hammer Hsieh 2022-02-22  727  
9e8d5470325f25 Hammer Hsieh 2022-02-22  728  	return ret;
9e8d5470325f25 Hammer Hsieh 2022-02-22  729  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  730  module_init(sunplus_uart_init);
9e8d5470325f25 Hammer Hsieh 2022-02-22  731  
9e8d5470325f25 Hammer Hsieh 2022-02-22  732  static void __exit sunplus_uart_exit(void)
9e8d5470325f25 Hammer Hsieh 2022-02-22  733  {
9e8d5470325f25 Hammer Hsieh 2022-02-22  734  	platform_driver_unregister(&sunplus_uart_platform_driver);
9e8d5470325f25 Hammer Hsieh 2022-02-22 @735  	uart_unregister_driver(&sunplus_uart_driver);
9e8d5470325f25 Hammer Hsieh 2022-02-22  736  }
9e8d5470325f25 Hammer Hsieh 2022-02-22  737  module_exit(sunplus_uart_exit);
9e8d5470325f25 Hammer Hsieh 2022-02-22  738  

:::::: The code at line 671 was first introduced by commit
:::::: 9e8d5470325f25bed7d33f9faaae6d5e4f313650 serial: sunplus-uart: Add Sunplus SoC UART Driver

:::::: TO: Hammer Hsieh <hammerh0314@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
