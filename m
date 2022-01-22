Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0AD49694A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiAVByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:54:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:28160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbiAVByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642816454; x=1674352454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zorvSDBAubTXte+6tmdrFVKs+rFT4v+G2hoJCX97njQ=;
  b=ATcWNXID6LWg7PLNMn1kCbo56T/CtojpEl+P9QMn9eu61cmYKz64Oc2H
   sw/RMtuM7Vvync5y01g7YdXM4ziK2I/e3kn6Zh3SZ1DDOrCCViru7VbGm
   B4l/XbsECP9CDri85DUj35mfjhz9SSVEbV9YCz4I8/1dR2jmvG4nM2QAD
   hXo/7nVVsC3qI9wFE6Uwub29/lHNGvmRS0Tpve89L0vuxf+k1QUp/U+5m
   sE23S/ubta65aJQSZ+abU6ZX2lqE3issfyltSn3sxWsCSbK+kOUKu8r5U
   Myhn51R/9hSK2CusynpBxaEtJPW/CDzAFZUmNxbmhKNMIcvkmyhsur3G+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="226455115"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="226455115"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="768174063"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2022 17:54:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB5bX-000Fst-Sb; Sat, 22 Jan 2022 01:54:11 +0000
Date:   Sat, 22 Jan 2022 09:54:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.16.y-rt-rebase 8/132]
 kernel/printk/printk.c:2628:2: error: implicit declaration of function
 'boot_delay_msec'
Message-ID: <202201220904.ZcTeNwWl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt-rebase
head:   1722f531f5244c70dcd9687c40729860bb254e8d
commit: 75ade2af49f22287257530b6ba838efe2b6dfb56 [8/132] printk: refactor and rework printing logic
config: hexagon-buildonly-randconfig-r005-20220121 (https://download.01.org/0day-ci/archive/20220122/202201220904.ZcTeNwWl-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=75ade2af49f22287257530b6ba838efe2b6dfb56
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.16.y-rt-rebase
        git checkout 75ade2af49f22287257530b6ba838efe2b6dfb56
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/printk/printk.c:175:5: warning: no previous prototype for function 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
       ^
   kernel/printk/printk.c:175:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
   ^
   static 
>> kernel/printk/printk.c:2628:2: error: implicit declaration of function 'boot_delay_msec' [-Werror,-Wimplicit-function-declaration]
           boot_delay_msec(r.info->level);
           ^
>> kernel/printk/printk.c:2629:2: error: implicit declaration of function 'printk_delay' [-Werror,-Wimplicit-function-declaration]
           printk_delay();
           ^
   1 warning and 2 errors generated.


vim +/boot_delay_msec +2628 kernel/printk/printk.c

  2556	
  2557	/*
  2558	 * Print one record for the given console. The record printed is whatever
  2559	 * record is the next available record for the given console.
  2560	 *
  2561	 * Requires the console_lock.
  2562	 *
  2563	 * Returns false if the given console has no next record to print, otherwise
  2564	 * true.
  2565	 *
  2566	 * @handover will be set to true if a printk waiter has taken over the
  2567	 * console_lock, in which case the caller is no longer holding the
  2568	 * console_lock.
  2569	 */
  2570	static bool console_emit_next_record(struct console *con, bool *handover)
  2571	{
  2572		static char ext_text[CONSOLE_EXT_LOG_MAX];
  2573		static char text[CONSOLE_LOG_MAX];
  2574		struct printk_info info;
  2575		struct printk_record r;
  2576		unsigned long flags;
  2577		char *write_text;
  2578		size_t len;
  2579	
  2580		prb_rec_init_rd(&r, &info, text, sizeof(text));
  2581	
  2582		if (!prb_read_valid(prb, con->seq, &r))
  2583			return false;
  2584	
  2585		if (con->seq != r.info->seq) {
  2586			con->dropped += r.info->seq - con->seq;
  2587			con->seq = r.info->seq;
  2588		}
  2589	
  2590		/* Skip record that has level above the console loglevel. */
  2591		if (suppress_message_printing(r.info->level)) {
  2592			con->seq++;
  2593			goto skip;
  2594		}
  2595	
  2596		if (con->flags & CON_EXTENDED) {
  2597			write_text = &ext_text[0];
  2598			len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
  2599			len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
  2600						  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
  2601		} else {
  2602			write_text = &text[0];
  2603			len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
  2604		}
  2605	
  2606		/*
  2607		 * While actively printing out messages, if another printk()
  2608		 * were to occur on another CPU, it may wait for this one to
  2609		 * finish. This task can not be preempted if there is a
  2610		 * waiter waiting to take over.
  2611		 *
  2612		 * Interrupts are disabled because the hand over to a waiter
  2613		 * must not be interrupted until the hand over is completed
  2614		 * (@console_waiter is cleared).
  2615		 */
  2616		printk_safe_enter_irqsave(flags);
  2617		console_lock_spinning_enable();
  2618	
  2619		stop_critical_timings();	/* don't trace print latency */
  2620		call_console_driver(con, write_text, len);
  2621		start_critical_timings();
  2622	
  2623		con->seq++;
  2624	
  2625		*handover = console_lock_spinning_disable_and_check();
  2626		printk_safe_exit_irqrestore(flags);
  2627	
> 2628		boot_delay_msec(r.info->level);
> 2629		printk_delay();
  2630	skip:
  2631		return true;
  2632	}
  2633	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
