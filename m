Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B95A487B24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348523AbiAGROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:14:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:40437 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348477AbiAGROH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641575647; x=1673111647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5S8HMRuD2QZPFSULfx9qRH9Uh7G6jQZF8OyxPNfQmrc=;
  b=mP2MOb8LDTT4hlrPPH0XpjHyGs4XMlSdbXfeNYD+TB0Hu3hrI0TnohMb
   QomlkA1PlZT3hXgW4mC27NHpotQP+V36uiORulwWmNhqitxPjXJzaAjm2
   0TWQrBzFrhdrqW77rRALCz2ZCNsRDo76r+mk/o1aaxOkBrjsRGACppP31
   QBHkdh5TYdd5p6ltxm//joM4WBnWoZT7H8qV6cQleEcqgAKalzfPqGYt5
   659+I1u88dyli7hWyCJ20hcA40RkdCA5/nva8klNKovcQc3Fw8esuHiK1
   Q/C/3WfwXoJc6pIRp4Ole/GY2zsoY0Jx8YKW4uuuVYZsTf5quVOC7oFmv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="243099887"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="243099887"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 09:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="689847429"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2022 09:13:05 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5snY-000Isx-IL; Fri, 07 Jan 2022 17:13:04 +0000
Date:   Sat, 8 Jan 2022 01:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:rs485_fixes 10/10] drivers/tty/serial/8250/8250_omap.c:1450:40:
 error: incompatible type for argument 1 of 'serial_in'
Message-ID: <202201080120.oOHk60a4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux rs485_fixes
head:   01e60137e91a8d400ecde3438328c168a3804820
commit: 01e60137e91a8d400ecde3438328c168a3804820 [10/10] serial: 8250: 8250_omap: Support native rs485
config: arc-randconfig-r013-20220107 (https://download.01.org/0day-ci/archive/20220108/202201080120.oOHk60a4-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/01e60137e91a8d400ecde3438328c168a3804820
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k rs485_fixes
        git checkout 01e60137e91a8d400ecde3438328c168a3804820
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_omap.c: In function 'omap8250_probe':
>> drivers/tty/serial/8250/8250_omap.c:1450:40: error: incompatible type for argument 1 of 'serial_in'
    1450 |                 priv->mdr3 = serial_in(up, UART_OMAP_MDR3);
         |                                        ^~
         |                                        |
         |                                        struct uart_8250_port
   In file included from drivers/tty/serial/8250/8250_omap.c:32:
   drivers/tty/serial/8250/8250.h:113:52: note: expected 'struct uart_8250_port *' but argument is of type 'struct uart_8250_port'
     113 | static inline int serial_in(struct uart_8250_port *up, int offset)
         |                             ~~~~~~~~~~~~~~~~~~~~~~~^~


vim +/serial_in +1450 drivers/tty/serial/8250/8250_omap.c

  1341	
  1342	static int omap8250_probe(struct platform_device *pdev)
  1343	{
  1344		struct device_node *np = pdev->dev.of_node;
  1345		struct omap8250_priv *priv;
  1346		const struct omap8250_platdata *pdata;
  1347		struct uart_8250_port up;
  1348		struct resource *regs;
  1349		void __iomem *membase;
  1350		int irq, ret;
  1351	
  1352		irq = platform_get_irq(pdev, 0);
  1353		if (irq < 0)
  1354			return irq;
  1355	
  1356		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1357		if (!regs) {
  1358			dev_err(&pdev->dev, "missing registers\n");
  1359			return -EINVAL;
  1360		}
  1361	
  1362		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
  1363		if (!priv)
  1364			return -ENOMEM;
  1365	
  1366		membase = devm_ioremap(&pdev->dev, regs->start,
  1367					       resource_size(regs));
  1368		if (!membase)
  1369			return -ENODEV;
  1370	
  1371		memset(&up, 0, sizeof(up));
  1372		up.port.dev = &pdev->dev;
  1373		up.port.mapbase = regs->start;
  1374		up.port.membase = membase;
  1375		up.port.irq = irq;
  1376		/*
  1377		 * It claims to be 16C750 compatible however it is a little different.
  1378		 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
  1379		 * have) is enabled via EFR instead of MCR. The type is set here 8250
  1380		 * just to get things going. UNKNOWN does not work for a few reasons and
  1381		 * we don't need our own type since we don't use 8250's set_termios()
  1382		 * or pm callback.
  1383		 */
  1384		up.port.type = PORT_8250;
  1385		up.port.iotype = UPIO_MEM;
  1386		up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW |
  1387			UPF_HARD_FLOW;
  1388		up.port.private_data = priv;
  1389	
  1390		up.port.regshift = 2;
  1391		up.port.fifosize = 64;
  1392		up.tx_loadsz = 64;
  1393		up.capabilities = UART_CAP_FIFO;
  1394	#ifdef CONFIG_PM
  1395		/*
  1396		 * Runtime PM is mostly transparent. However to do it right we need to a
  1397		 * TX empty interrupt before we can put the device to auto idle. So if
  1398		 * PM is not enabled we don't add that flag and can spare that one extra
  1399		 * interrupt in the TX path.
  1400		 */
  1401		up.capabilities |= UART_CAP_RPM;
  1402	#endif
  1403		up.port.set_termios = omap_8250_set_termios;
  1404		up.port.set_mctrl = omap8250_set_mctrl;
  1405		up.port.pm = omap_8250_pm;
  1406		up.port.startup = omap_8250_startup;
  1407		up.port.shutdown = omap_8250_shutdown;
  1408		up.port.throttle = omap_8250_throttle;
  1409		up.port.unthrottle = omap_8250_unthrottle;
  1410		up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
  1411	
  1412		ret = of_alias_get_id(np, "serial");
  1413		if (ret < 0) {
  1414			dev_err(&pdev->dev, "failed to get alias\n");
  1415			return ret;
  1416		}
  1417		up.port.line = ret;
  1418	
  1419		if (of_property_read_u32(np, "clock-frequency", &up.port.uartclk)) {
  1420			struct clk *clk;
  1421	
  1422			clk = devm_clk_get(&pdev->dev, NULL);
  1423			if (IS_ERR(clk)) {
  1424				if (PTR_ERR(clk) == -EPROBE_DEFER)
  1425					return -EPROBE_DEFER;
  1426			} else {
  1427				up.port.uartclk = clk_get_rate(clk);
  1428			}
  1429		}
  1430	
  1431		if (of_property_read_u32(np, "overrun-throttle-ms",
  1432					 &up.overrun_backoff_time_ms) != 0)
  1433			up.overrun_backoff_time_ms = 0;
  1434	
  1435		priv->wakeirq = irq_of_parse_and_map(np, 1);
  1436	
  1437		pdata = of_device_get_match_data(&pdev->dev);
  1438		if (pdata)
  1439			priv->habit |= pdata->habit;
  1440	
  1441		if (!up.port.uartclk) {
  1442			up.port.uartclk = DEFAULT_CLK_SPEED;
  1443			dev_warn(&pdev->dev,
  1444				 "No clock speed specified: using default: %d\n",
  1445				 DEFAULT_CLK_SPEED);
  1446		}
  1447	
  1448		if (priv->habit & UART_HAS_NATIVE_RS485) {
  1449			up.port.rs485_config = omap8250_rs485_config;
> 1450			priv->mdr3 = serial_in(up, UART_OMAP_MDR3);
  1451		} else {
  1452			up.port.rs485_config = serial8250_em485_config;
  1453			up.rs485_start_tx = serial8250_em485_start_tx;
  1454			up.rs485_stop_tx = serial8250_em485_stop_tx;
  1455		}
  1456	
  1457		priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
  1458		priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
  1459		cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
  1460		INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
  1461	
  1462		spin_lock_init(&priv->rx_dma_lock);
  1463	
  1464		device_init_wakeup(&pdev->dev, true);
  1465		pm_runtime_enable(&pdev->dev);
  1466		pm_runtime_use_autosuspend(&pdev->dev);
  1467	
  1468		/*
  1469		 * Disable runtime PM until autosuspend delay unless specifically
  1470		 * enabled by the user via sysfs. This is the historic way to
  1471		 * prevent an unsafe default policy with lossy characters on wake-up.
  1472		 * For serdev devices this is not needed, the policy can be managed by
  1473		 * the serdev driver.
  1474		 */
  1475		if (!of_get_available_child_count(pdev->dev.of_node))
  1476			pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
  1477	
  1478		pm_runtime_irq_safe(&pdev->dev);
  1479	
  1480		pm_runtime_get_sync(&pdev->dev);
  1481	
  1482		omap_serial_fill_features_erratas(&up, priv);
  1483		up.port.handle_irq = omap8250_no_handle_irq;
  1484		priv->rx_trigger = RX_TRIGGER;
  1485		priv->tx_trigger = TX_TRIGGER;
  1486	#ifdef CONFIG_SERIAL_8250_DMA
  1487		/*
  1488		 * Oh DMA support. If there are no DMA properties in the DT then
  1489		 * we will fall back to a generic DMA channel which does not
  1490		 * really work here. To ensure that we do not get a generic DMA
  1491		 * channel assigned, we have the the_no_dma_filter_fn() here.
  1492		 * To avoid "failed to request DMA" messages we check for DMA
  1493		 * properties in DT.
  1494		 */
  1495		ret = of_property_count_strings(np, "dma-names");
  1496		if (ret == 2) {
  1497			struct omap8250_dma_params *dma_params = NULL;
  1498	
  1499			up.dma = &priv->omap8250_dma;
  1500			up.dma->fn = the_no_dma_filter_fn;
  1501			up.dma->tx_dma = omap_8250_tx_dma;
  1502			up.dma->rx_dma = omap_8250_rx_dma;
  1503			if (pdata)
  1504				dma_params = pdata->dma_params;
  1505	
  1506			if (dma_params) {
  1507				up.dma->rx_size = dma_params->rx_size;
  1508				up.dma->rxconf.src_maxburst = dma_params->rx_trigger;
  1509				up.dma->txconf.dst_maxburst = dma_params->tx_trigger;
  1510				priv->rx_trigger = dma_params->rx_trigger;
  1511				priv->tx_trigger = dma_params->tx_trigger;
  1512			} else {
  1513				up.dma->rx_size = RX_TRIGGER;
  1514				up.dma->rxconf.src_maxburst = RX_TRIGGER;
  1515				up.dma->txconf.dst_maxburst = TX_TRIGGER;
  1516			}
  1517		}
  1518	#endif
  1519		ret = serial8250_register_8250_port(&up);
  1520		if (ret < 0) {
  1521			dev_err(&pdev->dev, "unable to register 8250 port\n");
  1522			goto err;
  1523		}
  1524		priv->line = ret;
  1525		platform_set_drvdata(pdev, priv);
  1526		pm_runtime_mark_last_busy(&pdev->dev);
  1527		pm_runtime_put_autosuspend(&pdev->dev);
  1528		return 0;
  1529	err:
  1530		pm_runtime_dont_use_autosuspend(&pdev->dev);
  1531		pm_runtime_put_sync(&pdev->dev);
  1532		pm_runtime_disable(&pdev->dev);
  1533		return ret;
  1534	}
  1535	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
