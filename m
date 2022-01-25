Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB449AB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392264AbiAYFTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:19:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:50376 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S255130AbiAYEyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643086490; x=1674622490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vXP0nGJDzpUIZCEXCb2Mz9/qHS+B2SE76A0MMvP1Jlk=;
  b=S6IurXZawBd4JiNHe4XRG08IqwEdmP3QcIWEQbjSjnOufL5ElNHafDUx
   /sYn+qNVvFQFut+7g0Hg+OhgPBXXD5hPz0sGHnvstIAgDa62ffRwbwgFG
   PIv78CO51vjIWzHqBTQIwPiwMtXhwo7FqwawgrTYmgBwdZJIfqaUUfrTn
   94tMv0qbRqEaKBSxb6IGNO2nq2nWIbjPX7HfZt7JXUIjVmI2q8CFIbBi0
   8VOSxiwX39y0cZa7W2I2EmtrlbmvPbHXdjIwiHB4h8wB6P2DR62u/86u3
   Q9ASMbSjp6HDcltf19xzV7byoIOYeqMOe7w+gDjl3KOV0bkFwQHnjfb15
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332572074"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="332572074"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 20:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="562910539"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 20:50:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCDmg-000JMv-Pd; Tue, 25 Jan 2022 04:50:22 +0000
Date:   Tue, 25 Jan 2022 12:50:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abhilasha Rao <abhilasha.hv@samsung.corp-partner.google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 400/9999] kernel/sched/core.c:94:22: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202201251245.Jpz3uXmU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   3307e1a058380163f1a11c8f7632706168f9fcb1
commit: a0212dbcef6d8b619371eb766da024aaf25e877b [400/9999] ANDROID: GKI: core: Export for runqueues
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220125/202201251245.Jpz3uXmU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/a0212dbcef6d8b619371eb766da024aaf25e877b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.4
        git checkout a0212dbcef6d8b619371eb766da024aaf25e877b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/sched/core.c:94:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:94:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:94:22: sparse:     got struct rq *
   kernel/sched/core.c:96:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:96:21: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:96:21: sparse:     got struct rq *
   kernel/sched/core.c:118:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:118:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:118:22: sparse:     got struct rq *
   kernel/sched/core.c:137:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:137:21: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:137:21: sparse:     got struct rq *
   kernel/sched/core.c:541:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:541:25: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:541:25: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:569:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:569:9: sparse:     got struct rq *
   kernel/sched/core.c:569:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] <asn:4> *parent @@
   kernel/sched/core.c:569:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:569:9: sparse:     got struct sched_domain [noderef] <asn:4> *parent
   kernel/sched/core.c:600:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:600:25: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:600:25: sparse:     got struct rq *
   kernel/sched/core.c:1691:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:1691:14: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:1691:14: sparse:     got struct rq *
   kernel/sched/core.c:1738:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:1738:25: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:1738:25: sparse:     got struct rq *
   kernel/sched/core.c:1760:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:1760:13: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:1760:13: sparse:     got struct rq *
   kernel/sched/core.c:1785:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:1785:25: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:1785:25: sparse:     got struct rq *
   kernel/sched/core.c:1929:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:1929:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:1929:9: sparse:     got struct rq *
   kernel/sched/core.c:2098:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2098:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2098:22: sparse:     got struct rq *
   kernel/sched/core.c:2334:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2334:40: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2334:40: sparse:     got struct rq *
   kernel/sched/core.c:2350:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2350:9: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2350:9: sparse:     got struct rq *
   kernel/sched/core.c:2379:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2379:14: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2379:14: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2390:17: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2390:17: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2390:17: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2390:17: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2390:17: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2390:17: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2390:17: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2390:17: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2390:17: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2390:17: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@
   kernel/sched/core.c:2390:17: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/sched/core.c:2390:17: sparse:     got struct rq *
   kernel/sched/core.c:2390:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct rq * @@

vim +94 kernel/sched/core.c

fa85ae2418e684 kernel/sched.c      Peter Zijlstra 2008-01-25   82  
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   83  /*
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   84   * __task_rq_lock - lock the rq @p resides on.
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   85   */
eb58075149b7f0 kernel/sched/core.c Peter Zijlstra 2015-07-31   86  struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   87  	__acquires(rq->lock)
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   88  {
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   89  	struct rq *rq;
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   90  
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   91  	lockdep_assert_held(&p->pi_lock);
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   92  
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   93  	for (;;) {
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  @94  		rq = task_rq(p);
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   95  		raw_spin_lock(&rq->lock);
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   96  		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
d8ac897137a230 kernel/sched/core.c Matt Fleming   2016-09-21   97  			rq_pin_lock(rq, rf);
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   98  			return rq;
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28   99  		}
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  100  		raw_spin_unlock(&rq->lock);
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  101  
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  102  		while (unlikely(task_on_rq_migrating(p)))
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  103  			cpu_relax();
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  104  	}
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  105  }
3e71a462dd483c kernel/sched/core.c Peter Zijlstra 2016-04-28  106  

:::::: The code at line 94 was first introduced by commit
:::::: 3e71a462dd483ce508a723356b293731e7d788ea sched/core: Move task_rq_lock() out of line

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
