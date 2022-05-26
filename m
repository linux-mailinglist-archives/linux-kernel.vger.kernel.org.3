Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E8535552
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbiEZVEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbiEZVEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:04:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F0E733F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653599049; x=1685135049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1rGBekVLR5fyf1u1KkAShln4cU7xxlac4/dyJCpQk/E=;
  b=VG8AQYIOos4GCS5X0R8XTQzUQGuSU68sQb8iHjd535YtKZF4t10GifqZ
   8JKezXVnPoyWR5P2BiwHdXbSWkjmpwAo4rgRxUbh1F/ubKdCajtUK0Q6d
   ck93JfCf74VSKK4ZJ6tJITFuLfNnSLaKN0aPq6Ha3Ws8bQ6MQjxbLjWlA
   OBhU9vkxT46yNsrUKuGgn3275a0ljHLI1e8pi8xTCwcB0DPAlckCTKlo3
   yaZrR12q8/L/xpQrR43aRllw0ISsEFFqjO8v6OSAiSWaCzvcKOrIlbJ75
   BTFnO9RPut9JT+hl+keqF0yKbTGbrUpSQb0LFW2ZJo3ABw77P9jplTbYY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256357607"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256357607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 14:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="746536890"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2022 14:04:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuKeM-0004BW-Bk;
        Thu, 26 May 2022 21:04:06 +0000
Date:   Fri, 27 May 2022 05:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.05.23b 64/68]
 arch/powerpc/include/asm/cmpxchg.h:474:6: error: cast to union type from
 type not present in union
Message-ID: <202205270440.Slefdogz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.05.23b
head:   29fe03d9190c37a93b96078e34ddd95344ef8b0f
commit: 2b23adb3446ac4098c17dee98414df6fca07f6c9 [64/68] squash! rcu-tasks: Atomically update .b.need_qs to obviate count
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220527/202205270440.Slefdogz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2b23adb3446ac4098c17dee98414df6fca07f6c9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.05.23b
        git checkout 2b23adb3446ac4098c17dee98414df6fca07f6c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:606:
   kernel/rcu/tasks.h: In function 'rcu_trc_cmpxchg_need_qs':
   kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected
    1243 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |         ^~~
   kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected
   In file included from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from kernel/rcu/update.c:23:
>> arch/powerpc/include/asm/cmpxchg.h:474:6: error: cast to union type from type not present in union
     474 |      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,           \
         |      ^
   include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro 'arch_cmpxchg'
    1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~
   kernel/rcu/tasks.h:1243:15: note: in expansion of macro 'cmpxchg'
    1243 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |               ^~~~~~~


vim +474 arch/powerpc/include/asm/cmpxchg.h

56c08e6d226c86 Boqun Feng    2015-12-15  450  
56c08e6d226c86 Boqun Feng    2015-12-15  451  static __always_inline unsigned long
56c08e6d226c86 Boqun Feng    2015-12-15  452  __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
56c08e6d226c86 Boqun Feng    2015-12-15  453  		  unsigned int size)
56c08e6d226c86 Boqun Feng    2015-12-15  454  {
56c08e6d226c86 Boqun Feng    2015-12-15  455  	switch (size) {
d0563a1297e234 Pan Xinhui    2016-04-27  456  	case 1:
d0563a1297e234 Pan Xinhui    2016-04-27  457  		return __cmpxchg_u8_acquire(ptr, old, new);
d0563a1297e234 Pan Xinhui    2016-04-27  458  	case 2:
d0563a1297e234 Pan Xinhui    2016-04-27  459  		return __cmpxchg_u16_acquire(ptr, old, new);
56c08e6d226c86 Boqun Feng    2015-12-15  460  	case 4:
56c08e6d226c86 Boqun Feng    2015-12-15  461  		return __cmpxchg_u32_acquire(ptr, old, new);
56c08e6d226c86 Boqun Feng    2015-12-15  462  #ifdef CONFIG_PPC64
56c08e6d226c86 Boqun Feng    2015-12-15  463  	case 8:
56c08e6d226c86 Boqun Feng    2015-12-15  464  		return __cmpxchg_u64_acquire(ptr, old, new);
56c08e6d226c86 Boqun Feng    2015-12-15  465  #endif
56c08e6d226c86 Boqun Feng    2015-12-15  466  	}
10d8b1480e6966 pan xinhui    2016-02-23  467  	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
56c08e6d226c86 Boqun Feng    2015-12-15  468  	return old;
56c08e6d226c86 Boqun Feng    2015-12-15  469  }
9eaa82935dccb7 Mark Rutland  2021-05-25  470  #define arch_cmpxchg(ptr, o, n)						 \
ae3a197e3d0bfe David Howells 2012-03-28  471    ({									 \
ae3a197e3d0bfe David Howells 2012-03-28  472       __typeof__(*(ptr)) _o_ = (o);					 \
ae3a197e3d0bfe David Howells 2012-03-28  473       __typeof__(*(ptr)) _n_ = (n);					 \
ae3a197e3d0bfe David Howells 2012-03-28 @474       (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
ae3a197e3d0bfe David Howells 2012-03-28  475  				    (unsigned long)_n_, sizeof(*(ptr))); \
ae3a197e3d0bfe David Howells 2012-03-28  476    })
ae3a197e3d0bfe David Howells 2012-03-28  477  
ae3a197e3d0bfe David Howells 2012-03-28  478  

:::::: The code at line 474 was first introduced by commit
:::::: ae3a197e3d0bfe3f4bf1693723e82dc018c096f3 Disintegrate asm/system.h for PowerPC

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
