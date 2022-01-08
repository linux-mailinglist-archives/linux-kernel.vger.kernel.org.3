Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56703488110
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 04:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiAHDPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 22:15:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:48129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233287AbiAHDPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 22:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641611733; x=1673147733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sA1uQT+E+/oT1FwTrF/qRTED0E8Q8lKdTIYCP54Z5a4=;
  b=JbbvBYcnpycfVfeFH2hyMACmlsuSQnDKTJcyPQVypo6J32us9ms3nRET
   tuc+8asOgv1BTT6elzqfn2nszaTrIBsI8cCmMroBIFfibA6P3qq9zU54I
   j8bzJxmnwKqwxDLYtRjzglXTyWls5TRm2vS2ChibcypwrkKTxEv0zC5Wm
   bRpIXmrRHCKC9FD5WaefEPs5l03XM7IdgqSHlMobh6M/bwN5BW9gi3JTb
   n/efl/EEU39k/XO6bh3942rBV+53yoyjIPbYjX52z2bf7pZ9FEve24XzA
   tAmOy19Bi7tEHVezlg8TED+dbBlX5qMI9Q86pcrK2caIL48KNRhoALglW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242931417"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242931417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 19:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="557459520"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2022 19:15:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n62CZ-0000D5-Gr; Sat, 08 Jan 2022 03:15:31 +0000
Date:   Sat, 8 Jan 2022 11:14:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.04a 55/55] kernel/time/timer.c:1776:6:
 warning: no previous prototype for function 'tick_setup_sched_timer_dump'
Message-ID: <202201081127.geEljsMv-lkp@intel.com>
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
config: hexagon-randconfig-r011-20220108 (https://download.01.org/0day-ci/archive/20220108/202201081127.geEljsMv-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=64595d0dff992756e8c6d53c0e9f1e3e50c451f7
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2022.01.04a
        git checkout 64595d0dff992756e8c6d53c0e9f1e3e50c451f7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/time/timer.c:1776:6: warning: no previous prototype for function 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]
   void tick_setup_sched_timer_dump(void)
        ^
   kernel/time/timer.c:1776:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tick_setup_sched_timer_dump(void)
   ^
   static 
   1 warning generated.


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
