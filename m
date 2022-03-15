Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922F54D9C17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiCON1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbiCON1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:27:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02613464B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647350756; x=1678886756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jL5/IB56nZDpdozMOy9Uo5oSI/YzeWPmvSrZpyoRU9I=;
  b=Z/Ce5Q24FoOKgDU7WVB6q/b8ATvlF8kNMVZrneaKcW9iHIrQaA3Cbdiw
   yUvwzvQHzgKSmdvTaXOU/xDSbqWGfPHfkY50x9s8Wems72oE7fqJJVuWt
   8nXLrj6cJb1/6c1ll8+yRgOB+jKuzZinAis4Y5iVWuVamVJS6UQo25iR7
   dXjYrkyZ6IbStCpbQrl48eVRtsX8scT9+Rwbf/iw//HlLa48n8GDdPmnu
   FYsttFErORsCIRkCnsiXfq8OkteJL7032mu/FDsWmqUqw+wyr0aFdmlnx
   RTshoTXp1gb6Gi5EFmycZn+ycceYZYwwXhQMrF5Q8qUpeNqAbAspOYa44
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253856916"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="253856916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="498011477"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2022 06:25:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU7BS-000B1w-6E; Tue, 15 Mar 2022 13:25:54 +0000
Date:   Tue, 15 Mar 2022 21:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/core 16/16] kernel/sched/loadavg.c:245:6: warning:
 no previous prototype for 'calc_load_nohz_start'
Message-ID: <202203152144.uFQqgVUf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/core
head:   4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
commit: 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c [16/16] sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220315/202203152144.uFQqgVUf-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/core
        git checkout 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:79:
>> kernel/sched/loadavg.c:245:6: warning: no previous prototype for 'calc_load_nohz_start' [-Wmissing-prototypes]
     245 | void calc_load_nohz_start(void)
         |      ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:258:6: warning: no previous prototype for 'calc_load_nohz_remote' [-Wmissing-prototypes]
     258 | void calc_load_nohz_remote(struct rq *rq)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:263:6: warning: no previous prototype for 'calc_load_nohz_stop' [-Wmissing-prototypes]
     263 | void calc_load_nohz_stop(void)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/calc_load_nohz_start +245 kernel/sched/loadavg.c

45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  244  
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11 @245) void calc_load_nohz_start(void)
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  246) {
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  247) 	/*
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  248) 	 * We're going into NO_HZ mode, if there's any pending delta, fold it
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  249) 	 * into the pending NO_HZ delta.
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  250) 	 */
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  251) 	calc_load_nohz_fold(this_rq());
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  252) }
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  253) 
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  254) /*
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  255)  * Keep track of the load for NOHZ_FULL, must be called between
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  256)  * calc_load_nohz_{start,stop}().
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  257)  */
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11 @258) void calc_load_nohz_remote(struct rq *rq)
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  259) {
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  260) 	calc_load_nohz_fold(rq);
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  261) }
ebc0f83c78a2d26 kernel/sched/loadavg.c Peter Zijlstra (Intel  2020-01-11  262) 
3c85d6db5e5f05a kernel/sched/loadavg.c Frederic Weisbecker    2017-06-19 @263  void calc_load_nohz_stop(void)
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  264  {
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  265  	struct rq *this_rq = this_rq();
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  266  
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  267  	/*
6e5f32f7a43f45e kernel/sched/loadavg.c Matt Fleming           2017-02-17  268  	 * If we're still before the pending sample window, we're done.
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  269  	 */
caeb5882979bc6f kernel/sched/loadavg.c Matt Fleming           2017-02-17  270  	this_rq->calc_load_update = READ_ONCE(calc_load_update);
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  271  	if (time_before(jiffies, this_rq->calc_load_update))
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  272  		return;
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  273  
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  274  	/*
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  275  	 * We woke inside or after the sample window, this means we're already
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  276  	 * accounted through the nohz accounting, so skip the entire deal and
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  277  	 * sync up for the next window.
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  278  	 */
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  279  	if (time_before(jiffies, this_rq->calc_load_update + 10))
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  280  		this_rq->calc_load_update += LOAD_FREQ;
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  281  }
45ceebf77653975 kernel/sched/proc.c    Paul Gortmaker         2013-04-19  282  

:::::: The code at line 245 was first introduced by commit
:::::: ebc0f83c78a2d26384401ecf2d2fa48063c0ee27 timers/nohz: Update NOHZ load in remote tick

:::::: TO: Peter Zijlstra (Intel) <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
