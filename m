Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0451ADCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiEDTdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiEDTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:33:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FE4B43F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651692563; x=1683228563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DZQw5tDbjVrnSpmx9GUxEH7BSviPc0lm4waXQzgCuEo=;
  b=cXpabQFNHNwAIwNwkhMl8vGrT9I32tPLVgMIkpIu9ZvLXpsBy54s9c3b
   oE9t4isEui00kZz+TqwYNqBk6jurfRb+gg7pnn8jM7MQPWV8IadN7WeAF
   UE3hTsuou5OeMhima5VbfngSlujQ8J7QKNCvVRbZ12NjcmR9DlHZN6g78
   ZUcMlljTLY8hwyTzEMynianswvzFWt6QQ6NZoqfMsy2ACM6un8PQXfg/g
   eN7O4SUWZ70FoyYu4WwwE+4TQebsNJ9yDhT4Ix76W5ao8Eq8/CBMcLTUI
   8KL7HFcXjKjZl+y5uah9RDIPmw68i5HT7BU4VR5TItFRj26qkqlqKuZsU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255345441"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="255345441"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 12:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="694307564"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 12:29:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmKga-000Bj1-Um;
        Wed, 04 May 2022 19:29:20 +0000
Date:   Thu, 5 May 2022 03:28:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 34/39]
 drivers/tty/serial/8250/8250_port.c:2372:31: error: incompatible type for
 argument 1 of 'is_upf_fourport'
Message-ID: <202205050355.iKHbsVWd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   2d239b86b347751644338b1dc5b64d25beb640ce
commit: 1e52c1d28da11ba596e6666f1e403d68a4b0696b [34/39] tty: serial: handle HAS_IOPORT dependencies
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220505/202205050355.iKHbsVWd-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=1e52c1d28da11ba596e6666f1e403d68a4b0696b
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout 1e52c1d28da11ba596e6666f1e403d68a4b0696b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_port.c: In function 'serial8250_do_startup':
>> drivers/tty/serial/8250/8250_port.c:2372:31: error: incompatible type for argument 1 of 'is_upf_fourport'
    2372 |         if (is_upf_fourport(up->port)) {
         |                             ~~^~~~~~
         |                               |
         |                               struct uart_port
   drivers/tty/serial/8250/8250_port.c:474:54: note: expected 'struct uart_port *' but argument is of type 'struct uart_port'
     474 | static inline bool is_upf_fourport(struct uart_port *port)
         |                                    ~~~~~~~~~~~~~~~~~~^~~~
   At top level:
   drivers/tty/serial/8250/8250_port.c:466:13: warning: 'io_serial_out' defined but not used [-Wunused-function]
     466 | static void io_serial_out(struct uart_port *p, int offset, int value)
         |             ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_port.c:460:21: warning: 'io_serial_in' defined but not used [-Wunused-function]
     460 | static unsigned int io_serial_in(struct uart_port *p, int offset)
         |                     ^~~~~~~~~~~~


vim +/is_upf_fourport +2372 drivers/tty/serial/8250/8250_port.c

  2252	
  2253		/*
  2254		 * Clear the FIFO buffers and disable them.
  2255		 * (they will be reenabled in set_termios())
  2256		 */
  2257		serial8250_clear_fifos(up);
  2258	
  2259		/*
  2260		 * Clear the interrupt registers.
  2261		 */
  2262		serial_port_in(port, UART_LSR);
  2263		serial_port_in(port, UART_RX);
  2264		serial_port_in(port, UART_IIR);
  2265		serial_port_in(port, UART_MSR);
  2266	
  2267		/*
  2268		 * At this point, there's no way the LSR could still be 0xff;
  2269		 * if it is, then bail out, because there's likely no UART
  2270		 * here.
  2271		 */
  2272		if (!(port->flags & UPF_BUGGY_UART) &&
  2273		    (serial_port_in(port, UART_LSR) == 0xff)) {
  2274			dev_info_ratelimited(port->dev, "LSR safety check engaged!\n");
  2275			retval = -ENODEV;
  2276			goto out;
  2277		}
  2278	
  2279		/*
  2280		 * For a XR16C850, we need to set the trigger levels
  2281		 */
  2282		if (port->type == PORT_16850) {
  2283			unsigned char fctr;
  2284	
  2285			serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
  2286	
  2287			fctr = serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
  2288			serial_port_out(port, UART_FCTR,
  2289					fctr | UART_FCTR_TRGD | UART_FCTR_RX);
  2290			serial_port_out(port, UART_TRG, UART_TRG_96);
  2291			serial_port_out(port, UART_FCTR,
  2292					fctr | UART_FCTR_TRGD | UART_FCTR_TX);
  2293			serial_port_out(port, UART_TRG, UART_TRG_96);
  2294	
  2295			serial_port_out(port, UART_LCR, 0);
  2296		}
  2297	
  2298		/*
  2299		 * For the Altera 16550 variants, set TX threshold trigger level.
  2300		 */
  2301		if (((port->type == PORT_ALTR_16550_F32) ||
  2302		     (port->type == PORT_ALTR_16550_F64) ||
  2303		     (port->type == PORT_ALTR_16550_F128)) && (port->fifosize > 1)) {
  2304			/* Bounds checking of TX threshold (valid 0 to fifosize-2) */
  2305			if ((up->tx_loadsz < 2) || (up->tx_loadsz > port->fifosize)) {
  2306				dev_err(port->dev, "TX FIFO Threshold errors, skipping\n");
  2307			} else {
  2308				serial_port_out(port, UART_ALTR_AFR,
  2309						UART_ALTR_EN_TXFIFO_LW);
  2310				serial_port_out(port, UART_ALTR_TX_LOW,
  2311						port->fifosize - up->tx_loadsz);
  2312				port->handle_irq = serial8250_tx_threshold_handle_irq;
  2313			}
  2314		}
  2315	
  2316		/* Check if we need to have shared IRQs */
  2317		if (port->irq && (up->port.flags & UPF_SHARE_IRQ))
  2318			up->port.irqflags |= IRQF_SHARED;
  2319	
  2320		if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
  2321			unsigned char iir1;
  2322	
  2323			if (port->irqflags & IRQF_SHARED)
  2324				disable_irq_nosync(port->irq);
  2325	
  2326			/*
  2327			 * Test for UARTs that do not reassert THRE when the
  2328			 * transmitter is idle and the interrupt has already
  2329			 * been cleared.  Real 16550s should always reassert
  2330			 * this interrupt whenever the transmitter is idle and
  2331			 * the interrupt is enabled.  Delays are necessary to
  2332			 * allow register changes to become visible.
  2333			 */
  2334			spin_lock_irqsave(&port->lock, flags);
  2335	
  2336			wait_for_xmitr(up, UART_LSR_THRE);
  2337			serial_port_out_sync(port, UART_IER, UART_IER_THRI);
  2338			udelay(1); /* allow THRE to set */
  2339			iir1 = serial_port_in(port, UART_IIR);
  2340			serial_port_out(port, UART_IER, 0);
  2341			serial_port_out_sync(port, UART_IER, UART_IER_THRI);
  2342			udelay(1); /* allow a working UART time to re-assert THRE */
  2343			iir = serial_port_in(port, UART_IIR);
  2344			serial_port_out(port, UART_IER, 0);
  2345	
  2346			spin_unlock_irqrestore(&port->lock, flags);
  2347	
  2348			if (port->irqflags & IRQF_SHARED)
  2349				enable_irq(port->irq);
  2350	
  2351			/*
  2352			 * If the interrupt is not reasserted, or we otherwise
  2353			 * don't trust the iir, setup a timer to kick the UART
  2354			 * on a regular basis.
  2355			 */
  2356			if ((!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) ||
  2357			    up->port.flags & UPF_BUG_THRE) {
  2358				up->bugs |= UART_BUG_THRE;
  2359			}
  2360		}
  2361	
  2362		retval = up->ops->setup_irq(up);
  2363		if (retval)
  2364			goto out;
  2365	
  2366		/*
  2367		 * Now, initialize the UART
  2368		 */
  2369		serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
  2370	
  2371		spin_lock_irqsave(&port->lock, flags);
> 2372		if (is_upf_fourport(up->port)) {
  2373			if (!up->port.irq)
  2374				up->port.mctrl |= TIOCM_OUT1;
  2375		} else
  2376			/*
  2377			 * Most PC uarts need OUT2 raised to enable interrupts.
  2378			 */
  2379			if (port->irq)
  2380				up->port.mctrl |= TIOCM_OUT2;
  2381	
  2382		serial8250_set_mctrl(port, port->mctrl);
  2383	
  2384		/*
  2385		 * Serial over Lan (SoL) hack:
  2386		 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be
  2387		 * used for Serial Over Lan.  Those chips take a longer time than a
  2388		 * normal serial device to signalize that a transmission data was
  2389		 * queued. Due to that, the above test generally fails. One solution
  2390		 * would be to delay the reading of iir. However, this is not
  2391		 * reliable, since the timeout is variable. So, let's just don't
  2392		 * test if we receive TX irq.  This way, we'll never enable
  2393		 * UART_BUG_TXEN.
  2394		 */
  2395		if (up->port.quirks & UPQ_NO_TXEN_TEST)
  2396			goto dont_test_tx_en;
  2397	
  2398		/*
  2399		 * Do a quick test to see if we receive an interrupt when we enable
  2400		 * the TX irq.
  2401		 */
  2402		serial_port_out(port, UART_IER, UART_IER_THRI);
  2403		lsr = serial_port_in(port, UART_LSR);
  2404		iir = serial_port_in(port, UART_IIR);
  2405		serial_port_out(port, UART_IER, 0);
  2406	
  2407		if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
  2408			if (!(up->bugs & UART_BUG_TXEN)) {
  2409				up->bugs |= UART_BUG_TXEN;
  2410				dev_dbg(port->dev, "enabling bad tx status workarounds\n");
  2411			}
  2412		} else {
  2413			up->bugs &= ~UART_BUG_TXEN;
  2414		}
  2415	
  2416	dont_test_tx_en:
  2417		spin_unlock_irqrestore(&port->lock, flags);
  2418	
  2419		/*
  2420		 * Clear the interrupt registers again for luck, and clear the
  2421		 * saved flags to avoid getting false values from polling
  2422		 * routines or the previous session.
  2423		 */
  2424		serial_port_in(port, UART_LSR);
  2425		serial_port_in(port, UART_RX);
  2426		serial_port_in(port, UART_IIR);
  2427		serial_port_in(port, UART_MSR);
  2428		up->lsr_saved_flags = 0;
  2429		up->msr_saved_flags = 0;
  2430	
  2431		/*
  2432		 * Request DMA channels for both RX and TX.
  2433		 */
  2434		if (up->dma) {
  2435			const char *msg = NULL;
  2436	
  2437			if (uart_console(port))
  2438				msg = "forbid DMA for kernel console";
  2439			else if (serial8250_request_dma(up))
  2440				msg = "failed to request DMA";
  2441			if (msg) {
  2442				dev_warn_ratelimited(port->dev, "%s\n", msg);
  2443				up->dma = NULL;
  2444			}
  2445		}
  2446	
  2447		/*
  2448		 * Set the IER shadow for rx interrupts but defer actual interrupt
  2449		 * enable until after the FIFOs are enabled; otherwise, an already-
  2450		 * active sender can swamp the interrupt handler with "too much work".
  2451		 */
  2452		up->ier = UART_IER_RLSI | UART_IER_RDI;
  2453	
  2454		if (is_upf_fourport(port)) {
  2455			unsigned int icp;
  2456			/*
  2457			 * Enable interrupts on the AST Fourport board
  2458			 */
  2459			icp = (port->iobase & 0xfe0) | 0x01f;
  2460			outb_p(0x80, icp);
  2461			inb_p(icp);
  2462		}
  2463		retval = 0;
  2464	out:
  2465		serial8250_rpm_put(up);
  2466		return retval;
  2467	}
  2468	EXPORT_SYMBOL_GPL(serial8250_do_startup);
  2469	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
