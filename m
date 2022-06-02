Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9153C0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiFBWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbiFBWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:06:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D7344D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654207589; x=1685743589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y2o+zYi0pTeFaoAuPAevka/5/r5W32xOKIAc/ItxQpE=;
  b=jZB/HIDltiXi/gsRTSZflHm1JqB7dCxxntU5QnxXIwcH6z/t4qvvnROX
   J0Nvw1bRssumXyGVAfZjJ8hpMoyXRiE3aMgfJyxFjyHOpTRTCuQggjfiZ
   AuAzbFAnup3o+b8CpVJsqDaTLWVaIF0xcMrvfcfk/Y9fv4HWPXt4/Myg4
   0wk57o708imExN3anHhHCqtJyu31hkCbvHHpgDLHVp+umTPnIEFX+/2Cb
   TEugETxoNqT+gfvJQZENdsrcEfR4u4b7+dzcspeX3uuDJvlv7nE9TXnCP
   bNgoqIN6B4WHRZlYAw/s9ger6ai6ED4HjaOKz+WcNHxePMJ46m8etO+/s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="263737217"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="263737217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 15:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="646187961"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2022 15:05:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwswy-0005Tu-F1;
        Thu, 02 Jun 2022 22:05:52 +0000
Date:   Fri, 3 Jun 2022 06:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dave.2022.06.02a 56/78]
 kernel/rcu/tasks.h:1239:9: error: aggregate value used where an integer was
 expected
Message-ID: <202206030549.YOUkgBlA-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dave.2022.06.02a
head:   2efc5c4abe4cc1259378f7c1678a93540559673c
commit: cda3200416cdef7f25546cd6249fb411c8c32079 [56/78] rcu-tasks: Merge state into .b.need_qs and atomically update
config: nios2-randconfig-r005-20220602 (https://download.01.org/0day-ci/archive/20220603/202206030549.YOUkgBlA-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/cda3200416cdef7f25546cd6249fb411c8c32079
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dave.2022.06.02a
        git checkout cda3200416cdef7f25546cd6249fb411c8c32079
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:606:
   kernel/rcu/tasks.h: In function 'rcu_trc_cmpxchg_need_qs':
>> kernel/rcu/tasks.h:1239:9: error: aggregate value used where an integer was expected
    1239 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |         ^~~
>> kernel/rcu/tasks.h:1239:9: error: aggregate value used where an integer was expected
   In file included from ./arch/nios2/include/generated/asm/cmpxchg.h:1,
                    from include/asm-generic/atomic.h:12,
                    from ./arch/nios2/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from include/asm-generic/bitops.h:31,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from kernel/rcu/update.c:21:
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


vim +1239 kernel/rcu/tasks.h

  1224	
  1225	/*
  1226	 * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
  1227	 * the four-byte operand-size restriction of some platforms.
  1228	 * Returns the old value, which is often ignored.
  1229	 */
  1230	u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
  1231	{
  1232		union rcu_special ret;
  1233		union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
  1234		union rcu_special trs_new = trs_old;
  1235	
  1236		if (trs_old.b.need_qs != old)
  1237			return trs_old.b.need_qs;
  1238		trs_new.b.need_qs = new;
> 1239		ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
  1240		return ret.b.need_qs;
  1241	}
  1242	EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
  1243	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
