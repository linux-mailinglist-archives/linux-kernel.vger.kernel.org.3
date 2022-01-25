Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5A49B2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382064AbiAYLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:25:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:51933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382073AbiAYLYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643109894; x=1674645894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C5499IKDZcam7B8qnh88t9a7YfkLqr5hG1YE/3RI7Pk=;
  b=aIa7E/5vQvXhDLeMrMxrDWbH3c0VqxTSO8GqUwKpWHdF7vUQnjI/9g5H
   /fAYnVRHGb9/G9Xcd7iVKmqCNGnDKrGUU5G75drulCC648Ja+9hyA7u5o
   T9/mx8szr1bIbr1mdc0ulscI/CQZHVwIO23tuDAN5HYiXI1sfN/tiq9pg
   tx2i8WpsqZt7YY4StwdN+ZAiINon181swnZa6GvBa3kV5IVgm7G+NYW0u
   WyaFchhCRcVtKJBnmhlOptUO+Rt3LUH4M8wJKN3Cf7apcPXRGrdFVwCni
   RN1Kv1fZyTdzQiZfwLbmLXRCZVe6KCDYrv03NqYFapTURtBGJhPJLvp9a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309596897"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="309596897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 03:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="563004777"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 03:24:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCJwQ-000JoX-Rq; Tue, 25 Jan 2022 11:24:50 +0000
Date:   Tue, 25 Jan 2022 19:24:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 80/85]
 kernel/rcu/srcutree.c:1168:27: warning: variable 'sdp' set but not used
Message-ID: <202201251933.iaAyduWp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   3cd375aa70d563fe8aa3e5f03280bdd8a334de45
commit: 2c773bcaf4dd5031d0b2c980cc623ecfbcc6ab62 [80/85] squash! srcu: Make Tree SRCU able to operate without snp_node array
config: nds32-defconfig (https://download.01.org/0day-ci/archive/20220125/202201251933.iaAyduWp-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2c773bcaf4dd5031d0b2c980cc623ecfbcc6ab62
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 2c773bcaf4dd5031d0b2c980cc623ecfbcc6ab62
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/rcu/srcutree.c: In function 'srcu_barrier':
>> kernel/rcu/srcutree.c:1168:27: warning: variable 'sdp' set but not used [-Wunused-but-set-variable]
    1168 |         struct srcu_data *sdp;
         |                           ^~~


vim +/sdp +1168 kernel/rcu/srcutree.c

2c773bcaf4dd50 Paul E. McKenney 2022-01-24  1160  
dad81a2026841b Paul E. McKenney 2017-03-25  1161  /**
dad81a2026841b Paul E. McKenney 2017-03-25  1162   * srcu_barrier - Wait until all in-flight call_srcu() callbacks complete.
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1163   * @ssp: srcu_struct on which to wait for in-flight callbacks.
dad81a2026841b Paul E. McKenney 2017-03-25  1164   */
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1165  void srcu_barrier(struct srcu_struct *ssp)
dad81a2026841b Paul E. McKenney 2017-03-25  1166  {
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1167  	int cpu;
da915ad5cf25b5 Paul E. McKenney 2017-04-05 @1168  	struct srcu_data *sdp;
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1169  	unsigned long s = rcu_seq_snap(&ssp->srcu_barrier_seq);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1170  
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1171  	check_init_srcu_struct(ssp);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1172  	mutex_lock(&ssp->srcu_barrier_mutex);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1173  	if (rcu_seq_done(&ssp->srcu_barrier_seq, s)) {
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1174  		smp_mb(); /* Force ordering following return. */
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1175  		mutex_unlock(&ssp->srcu_barrier_mutex);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1176  		return; /* Someone else did our work for us. */
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1177  	}
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1178  	rcu_seq_start(&ssp->srcu_barrier_seq);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1179  	init_completion(&ssp->srcu_barrier_completion);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1180  
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1181  	/* Initial count prevents reaching zero until all CBs are posted. */
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1182  	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1183  
2c773bcaf4dd50 Paul E. McKenney 2022-01-24  1184  	if (!smp_load_acquire(&ssp->srcu_size_state)) {
2c773bcaf4dd50 Paul E. McKenney 2022-01-24  1185  		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
2c773bcaf4dd50 Paul E. McKenney 2022-01-24  1186  	} else {
2c773bcaf4dd50 Paul E. McKenney 2022-01-24  1187  
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1188  		/*
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1189  		 * Each pass through this loop enqueues a callback, but only
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1190  		 * on CPUs already having callbacks enqueued.  Note that if
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1191  		 * a CPU already has callbacks enqueue, it must have already
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1192  		 * registered the need for a future grace period, so all we
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1193  		 * need do is enqueue a callback that will use the same
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1194  		 * grace period as the last callback already in the queue.
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1195  		 */
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1196  		for_each_possible_cpu(cpu) {
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1197  			sdp = per_cpu_ptr(ssp->sda, cpu);
2c773bcaf4dd50 Paul E. McKenney 2022-01-24  1198  			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
a602538e46c9c6 Paul E. McKenney 2017-04-28  1199  		}
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1200  	}
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1201  
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1202  	/* Remove the initial count, at which point reaching zero can happen. */
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1203  	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1204  		complete(&ssp->srcu_barrier_completion);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1205  	wait_for_completion(&ssp->srcu_barrier_completion);
da915ad5cf25b5 Paul E. McKenney 2017-04-05  1206  
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1207  	rcu_seq_end(&ssp->srcu_barrier_seq);
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1208  	mutex_unlock(&ssp->srcu_barrier_mutex);
dad81a2026841b Paul E. McKenney 2017-03-25  1209  }
dad81a2026841b Paul E. McKenney 2017-03-25  1210  EXPORT_SYMBOL_GPL(srcu_barrier);
dad81a2026841b Paul E. McKenney 2017-03-25  1211  

:::::: The code at line 1168 was first introduced by commit
:::::: da915ad5cf25b5f5d358dd3670c3378d8ae8c03e srcu: Parallelize callback handling

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
