Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DB5097EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384998AbiDUGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384981AbiDUGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:43:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82DE13F83
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523252; x=1682059252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vbncj1wSQkz1ynhQ/00xcXrt6fr8QurrCwytx4fiQ5k=;
  b=A9hCNwprM1VIbSqHQ1CZmUUzQj08Na+428LG0tBj6Kqi1ci5IzaXHKBY
   skZRXdPEasEfZ2n55wmY+bCZ4rbqKxIqEnO0+p9buDKthVpzPlaHPUgmY
   +Ph6D8IfLVYtZ2eTtQ37F6XxpZ4YocIEV0tcjS7Co6y1GNKF7Xz/RXVfV
   mv70BpHGinUYvtq0KJHGYO+1GtAPg+NiaI/9Yk149KP26ZCrU3rI8TaXx
   7SP9KeEbxuAnSLrhAGOQ/oUF/uamSX98S8XhVQM6PRuTBsC00MCoyqieF
   KXvmMpxCcUMzpa6SeeHtwr213pBTCNGv0sr6/d2pNQDU2Y7S3IRVW/MPO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327160567"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327160567"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532790131"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:40:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQUj-0007xq-Dv;
        Thu, 21 Apr 2022 06:40:49 +0000
Date:   Thu, 21 Apr 2022 14:40:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 28/28]
 kernel/rcu/tree_nocb.h:1217:2: error: expected identifier or '('
Message-ID: <202204202254.kr5zvuSL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   ad68d8bf085421e4f22731c8b64c0b774a154e06
commit: ad68d8bf085421e4f22731c8b64c0b774a154e06 [28/28] rcu/nocb: Add an option to offload all CPUs on boot
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220420/202204202254.kr5zvuSL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ad68d8bf085421e4f22731c8b64c0b774a154e06
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout ad68d8bf085421e4f22731c8b64c0b774a154e06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h:1213:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   offload_all = false; /* NO_HZ_FULL has its own mask. */
                   ^
   kernel/rcu/tree_nocb.h:1211:2: note: previous statement is here
           if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
           ^
   kernel/rcu/tree_nocb.h:1198:6: warning: unused variable 'cpu' [-Wunused-variable]
           int cpu;
               ^
   kernel/rcu/tree_nocb.h:1199:7: warning: variable 'need_rcu_nocb_mask' set but not used [-Wunused-but-set-variable]
           bool need_rcu_nocb_mask = false;
                ^
   kernel/rcu/tree_nocb.h:1200:7: warning: variable 'offload_all' set but not used [-Wunused-but-set-variable]
           bool offload_all = false;
                ^
   kernel/rcu/tree_nocb.h:1201:19: warning: unused variable 'rdp' [-Wunused-variable]
           struct rcu_data *rdp;
                            ^
>> kernel/rcu/tree_nocb.h:1217:2: error: expected identifier or '('
           if (need_rcu_nocb_mask) {
           ^
   kernel/rcu/tree_nocb.h:1227:2: error: expected identifier or '('
           if (!rcu_state.nocb_is_setup)
           ^
   kernel/rcu/tree_nocb.h:1231:2: error: expected identifier or '('
           if (tick_nohz_full_running)
           ^
   kernel/rcu/tree_nocb.h:1235:2: error: expected identifier or '('
           if (offload_all)
           ^
   kernel/rcu/tree_nocb.h:1238:2: error: expected identifier or '('
           if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
           ^
   kernel/rcu/tree_nocb.h:1243:2: error: expected identifier or '('
           if (cpumask_empty(rcu_nocb_mask))
           ^
   kernel/rcu/tree_nocb.h:1245:2: error: expected identifier or '('
           else
           ^
   kernel/rcu/tree_nocb.h:1248:2: error: expected identifier or '('
           if (rcu_nocb_poll)
           ^
   kernel/rcu/tree_nocb.h:1251:2: error: expected identifier or '('
           for_each_cpu(cpu, rcu_nocb_mask) {
           ^
   include/linux/cpumask.h:276:2: note: expanded from macro 'for_each_cpu'
           for ((cpu) = -1;                                \
           ^
   In file included from kernel/rcu/tree.c:5031:
>> kernel/rcu/tree_nocb.h:1259:2: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
           rcu_organize_nocb_kthreads();
           ^
>> kernel/rcu/tree_nocb.h:1259:28: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
           rcu_organize_nocb_kthreads();
                                     ^
                                      void
>> kernel/rcu/tree_nocb.h:1259:2: error: conflicting types for 'rcu_organize_nocb_kthreads'
           rcu_organize_nocb_kthreads();
           ^
   kernel/rcu/tree.h:463:20: note: previous declaration is here
   static void __init rcu_organize_nocb_kthreads(void);
                      ^
   In file included from kernel/rcu/tree.c:5031:
>> kernel/rcu/tree_nocb.h:1260:1: error: extraneous closing brace ('}')
   }
   ^
   5 warnings and 13 errors generated.


vim +1217 kernel/rcu/tree_nocb.h

dfcb27540213e80 Frederic Weisbecker 2021-05-19  1216  
a81aeaf7a1de514 Frederic Weisbecker 2021-11-23 @1217  	if (need_rcu_nocb_mask) {
a81aeaf7a1de514 Frederic Weisbecker 2021-11-23  1218  		if (!cpumask_available(rcu_nocb_mask)) {
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1219  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1220  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1221  				return;
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1222  			}
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1223  		}
8d2aaa9b7c290e7 Frederic Weisbecker 2022-02-14  1224  		rcu_state.nocb_is_setup = true;
a81aeaf7a1de514 Frederic Weisbecker 2021-11-23  1225  	}
a81aeaf7a1de514 Frederic Weisbecker 2021-11-23  1226  
8d2aaa9b7c290e7 Frederic Weisbecker 2022-02-14  1227  	if (!rcu_state.nocb_is_setup)
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1228  		return;
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1229  
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1230  #if defined(CONFIG_NO_HZ_FULL)
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1231  	if (tick_nohz_full_running)
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1232  		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1233  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1234  
ad68d8bf085421e Joel Fernandes      2022-04-19  1235  	if (offload_all)
ad68d8bf085421e Joel Fernandes      2022-04-19  1236  		cpumask_setall(rcu_nocb_mask);
ad68d8bf085421e Joel Fernandes      2022-04-19  1237  
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1238  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1239  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1240  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1241  			    rcu_nocb_mask);
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1242  	}
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1243  	if (cpumask_empty(rcu_nocb_mask))
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1244  		pr_info("\tOffload RCU callbacks from CPUs: (none).\n");
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1245  	else
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1246  		pr_info("\tOffload RCU callbacks from CPUs: %*pbl.\n",
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1247  			cpumask_pr_args(rcu_nocb_mask));
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1248  	if (rcu_nocb_poll)
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1249  		pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1250  
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1251  	for_each_cpu(cpu, rcu_nocb_mask) {
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1252  		rdp = per_cpu_ptr(&rcu_data, cpu);
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1253  		if (rcu_segcblist_empty(&rdp->cblist))
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1254  			rcu_segcblist_init(&rdp->cblist);
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1255  		rcu_segcblist_offload(&rdp->cblist, true);
213d56bf33bdda8 Frederic Weisbecker 2021-10-19  1256  		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
213d56bf33bdda8 Frederic Weisbecker 2021-10-19  1257  		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1258  	}
dfcb27540213e80 Frederic Weisbecker 2021-05-19 @1259  	rcu_organize_nocb_kthreads();
dfcb27540213e80 Frederic Weisbecker 2021-05-19 @1260  }
dfcb27540213e80 Frederic Weisbecker 2021-05-19  1261  

:::::: The code at line 1217 was first introduced by commit
:::::: a81aeaf7a1de51400374a8e3982a3cc3ff130dd1 rcu/nocb: Optimize kthreads and rdp initialization

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
