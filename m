Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A490496920
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiAVBOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:14:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:25689 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbiAVBOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642814059; x=1674350059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qoq1MmcTuCqBoRSYXHzaPXvF4EDXlLhVzxwfvR2wQQY=;
  b=GzTuHdVhXmt123wOHSeDZTYD9dpXSFaIYljZUHZVhXwhVMHmf9KPzYR9
   /E8az3dQhkZj77bkYLYi3+zsLvwvJcNKTpqQxeP46WUeS0tyJ/r+NCGmw
   0JlJR/1IB+sEx1UhBbZCd7CUAv4T9XawlKl+zbu/AgBfYBRjm3ViPit9e
   uRWrEytHBwYxE1fI5HtdLLrOEhMA58yUfjJDhRx8reM3279qw95Rx+pcD
   qvZndVwoGfgeg9fZJKp5X3EvAzdDsBQ+BevDLIcYwOAV3y17wr8QmwW50
   CE5WT6lGoU+BlUEaUd5s6/Gqzn5qpLCwsKIvFJVfQuOrOmmjzTmQ/Xd8q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244598778"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="244598778"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="562062285"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2022 17:14:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB4yo-000FqZ-92; Sat, 22 Jan 2022 01:14:10 +0000
Date:   Sat, 22 Jan 2022 09:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.16.y-rt-rebase 8/132]
 kernel/printk/printk.c:2628:2: error: implicit declaration of function
 'boot_delay_msec'
Message-ID: <202201220950.sysXbxm5-lkp@intel.com>
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
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220122/202201220950.sysXbxm5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=75ade2af49f22287257530b6ba838efe2b6dfb56
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.16.y-rt-rebase
        git checkout 75ade2af49f22287257530b6ba838efe2b6dfb56
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/printk/printk.c:175:5: warning: no previous prototype for 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
     175 | int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/printk/printk.c: In function 'console_emit_next_record':
>> kernel/printk/printk.c:2628:2: error: implicit declaration of function 'boot_delay_msec' [-Werror=implicit-function-declaration]
    2628 |  boot_delay_msec(r.info->level);
         |  ^~~~~~~~~~~~~~~
>> kernel/printk/printk.c:2629:2: error: implicit declaration of function 'printk_delay'; did you mean 'print_dev_t'? [-Werror=implicit-function-declaration]
    2629 |  printk_delay();
         |  ^~~~~~~~~~~~
         |  print_dev_t
   cc1: some warnings being treated as errors


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
