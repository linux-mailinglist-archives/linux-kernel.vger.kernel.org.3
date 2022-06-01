Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA8539FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350988AbiFAJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351024AbiFAI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:59:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39081606D6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654073995; x=1685609995;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j2b6wLutuvOHJH7VhblS925xsyPTQ7csiUF93TuRYkU=;
  b=l/xJrKTQzF8zbjEqQM06FVVWWEkoRJp+dKFhyb6kuFuONE6mzy9ruQGX
   kBEMDw59rni4ROpJ28YbzDGcWQgvZTqfgmqpWCWJK5wLx6laqipWIRXqL
   1+ZcDEeD9Gz6rgxDHieLIh7pmPUwTDPpWEGEzYKKW2DoxsrQm6TwyHPcc
   EuTqfWrJ80tJ8MwlPp7YnLrzkTeAQ62/dXD5+ivm8FaDisH+V1Ms4AaU+
   g32qyv8Qjs6salCwIbC/qLx0ZaAnPWfKre0upBLIreVQQpVV6wFFg/cvH
   /eSWSKnnw1L1XewZPYuJ4oiRiwaJojgXx0qT87xlrXcrHpaKLt5l/OtEC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300873592"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="300873592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 01:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="755804973"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 01:59:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwKCm-0003mB-Q2;
        Wed, 01 Jun 2022 08:59:52 +0000
Date:   Wed, 1 Jun 2022 16:59:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 77/78]
 kernel/rcu/tasks.h:1231:12: warning: variable 'realnew' set but not used
Message-ID: <202206011656.3Ab9OjRb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   19abca3f9f9095e58c46e2f169543705bd92cf35
commit: 4b3564b0807387c66b80b24095019479584039c9 [77/78] rcu-tasks: Manual revert of 4b2a6af8fe31e85fb2754b8da5072041a4dea471
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220601/202206011656.3Ab9OjRb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4b3564b0807387c66b80b24095019479584039c9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 4b3564b0807387c66b80b24095019479584039c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:606:
   kernel/rcu/tasks.h: In function 'rcu_trc_cmpxchg_need_qs':
   kernel/rcu/tasks.h:1239:9: error: aggregate value used where an integer was expected
    1239 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |         ^~~
   kernel/rcu/tasks.h:1239:9: error: aggregate value used where an integer was expected
   In file included from arch/m68k/include/asm/cmpxchg.h:131,
                    from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from kernel/rcu/update.c:23:
   include/asm-generic/cmpxchg.h:92:10: error: cast to union type from type not present in union
      92 |         ((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o), \
         |          ^
   include/asm-generic/cmpxchg.h:105:33: note: in expansion of macro 'generic_cmpxchg_local'
     105 | #define arch_cmpxchg_local      generic_cmpxchg_local
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/cmpxchg.h:112:33: note: in expansion of macro 'arch_cmpxchg_local'
     112 | #define arch_cmpxchg            arch_cmpxchg_local
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro 'arch_cmpxchg'
    1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~
   kernel/rcu/tasks.h:1239:15: note: in expansion of macro 'cmpxchg'
    1239 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |               ^~~~~~~
   In file included from kernel/rcu/update.c:606:
>> kernel/rcu/tasks.h:1231:12: warning: variable 'realnew' set but not used [-Wunused-but-set-variable]
    1231 |         u8 realnew;
         |            ^~~~~~~


vim +/realnew +1231 kernel/rcu/tasks.h

122db3cac94c0b Paul E. McKenney 2022-05-23  1223  
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1224  /*
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1225   * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1226   * the four-byte operand-size restriction of some platforms.
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1227   * Returns the old value, which is often ignored.
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1228   */
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1229  u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1230  {
2b23adb3446ac4 Paul E. McKenney 2022-05-25 @1231  	u8 realnew;
2b23adb3446ac4 Paul E. McKenney 2022-05-25  1232  	union rcu_special ret;
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1233  	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1234  	union rcu_special trs_new = trs_old;
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1235  
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1236  	if (trs_old.b.need_qs != old)
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1237  		return trs_old.b.need_qs;
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1238  	trs_new.b.need_qs = new;
2b23adb3446ac4 Paul E. McKenney 2022-05-25  1239  	ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
2b23adb3446ac4 Paul E. McKenney 2022-05-25  1240  	realnew = READ_ONCE(t->trc_reader_special.b.need_qs);
2b23adb3446ac4 Paul E. McKenney 2022-05-25  1241  	return ret.b.need_qs;
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1242  }
0f7cb0c989a98c Paul E. McKenney 2022-05-24  1243  

:::::: The code at line 1231 was first introduced by commit
:::::: 2b23adb3446ac4098c17dee98414df6fca07f6c9 squash! rcu-tasks: Atomically update .b.need_qs to obviate count

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
