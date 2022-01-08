Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1349E487FF8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiAHAmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:42:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:32647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbiAHAm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641602549; x=1673138549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZFQh7+Zx4QitKvWsY1aIw5HxwxUHS/THbLCQlNqrOZA=;
  b=GPedpWzBjQjQfIXe+8PLF1msy14+mZ0vff37HCZZyYXRj66Pn22ud9LN
   mg+2cfCOLHpP1fJJ4ZMn4GwxN8/CmCd3ABI6J9FflaK0H7tAJGJyQzlU6
   rlW+B/xGNZH8Za6iB10MzJ3ka1cikUPhzxvi+F/3wh1z9eh1x8vuHGACs
   N3YEQILv3ypnR7OTWRnGu6P4+OZhr8dOapaS6Eaq6zKmDkQgVosyCRo6E
   nr0ZtlPZhmolQaBcyxbzcuzFM/doDvQi1dp3Cip1LciyHkVEczi9/HrYL
   xAudEhRhZeqOq/T02M7yGihSNj6J7dTYMfBw/KmSwM5OfmdIubCKDBboR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="303712161"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="303712161"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="622109386"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 16:42:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5zoR-000079-RP; Sat, 08 Jan 2022 00:42:27 +0000
Date:   Sat, 8 Jan 2022 08:41:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.04a 55/55] kernel/time/timer.c:1776:6:
 warning: no previous prototype for 'tick_setup_sched_timer_dump'
Message-ID: <202201080834.rGuSv2SS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.04a
head:   64595d0dff992756e8c6d53c0e9f1e3e50c451f7
commit: 64595d0dff992756e8c6d53c0e9f1e3e50c451f7 [55/55] squash! EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220108/202201080834.rGuSv2SS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=64595d0dff992756e8c6d53c0e9f1e3e50c451f7
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2022.01.04a
        git checkout 64595d0dff992756e8c6d53c0e9f1e3e50c451f7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/timer.c:254:5: warning: no previous prototype for 'timer_migration_handler' [-Wmissing-prototypes]
     254 | int timer_migration_handler(struct ctl_table *table, int write,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/time/timer.c:1776:6: warning: no previous prototype for 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]
    1776 | void tick_setup_sched_timer_dump(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tick_setup_sched_timer_dump +1776 kernel/time/timer.c

  1775	
> 1776	void tick_setup_sched_timer_dump(void)
  1777	{
  1778		int cpu;
  1779		int j = jiffies;
  1780	
  1781		pr_alert("%s state", __func__);
  1782		for_each_possible_cpu(cpu)
  1783			pr_cont(" j/c %x/%d %c",
  1784				(int)(j - per_cpu(tick_setup_sched_timer_jiffies, cpu)) & 0xfff,
  1785				per_cpu(tick_setup_sched_timer_jiffies_count, cpu),
  1786				".H"[per_cpu(tick_setup_sched_timer_help_needed, cpu)]);
  1787		pr_cont("\n");
  1788	}
  1789	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
