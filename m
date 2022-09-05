Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7E5AC8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiIEDKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiIEDKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:10:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7039F1CFE2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662347416; x=1693883416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+pWEk4rY6xlC1Kq+N6uT1/KgGQz+2KW6sD2sIkWVS7c=;
  b=Ce5yvkXvKiZly1DFO9xyXzfW/OOjmOgfKV6dLi/6qEgMEVbxXAkanISc
   t9ekInqDKjh8B8TPqeBZTkfe8Oa7j5tPihrjVGjkiXMuesvjNHgW/oDlG
   chPqutBGy46pWi1Zkjqrc1/cCy8p5dowv87jQv5XiYyxDJzhGqZAAntVb
   cV4tFHh6UdWJYzH/YfMGL4OBYaVPvMpBiyo1ltT7+XNQchM7sFVnbYHWq
   XE4LmpMasdPhlvrh37D+jSDmkSdv7vuUO/UaE0nfcDIRQfcVCu5w/Oii2
   iVApz2EKfO4nSQJOEazUEC7tO8h5lK0vch5eFFyeZx9mf2ILZT27T2+6q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283289278"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="283289278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 20:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="941946866"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2022 20:10:13 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV2V3-0003lF-0R;
        Mon, 05 Sep 2022 03:10:13 +0000
Date:   Mon, 5 Sep 2022 11:09:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/lazy.2022.09.03b 38/40]
 include/net/dst.h:230:2: error: call to __compiletime_assert_401 declared
 with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct dst_entry,
 __refcnt) & 63
Message-ID: <202209051011.pAmcAnkK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/lazy.2022.09.03b
head:   485ca0ab99b3e10ff521fff226c3c8fe48fad488
commit: c944944108dcac62942ab154ce09e96afcd190c5 [38/40] rcu: Add per-CB tracing for queuing, flush and invocation.
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220905/202209051011.pAmcAnkK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/c944944108dcac62942ab154ce09e96afcd190c5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/lazy.2022.09.03b
        git checkout c944944108dcac62942ab154ce09e96afcd190c5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/sched/act_tunnel_key.c:12:
   In file included from include/net/geneve.h:5:
   In file included from include/net/udp_tunnel.h:5:
   In file included from include/net/ip_tunnels.h:13:
   In file included from include/net/dsfield.h:12:
   In file included from include/linux/ipv6.h:93:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:66:
>> include/net/dst.h:230:2: error: call to __compiletime_assert_401 declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
           BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:354:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:342:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:335:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:218:1: note: expanded from here
   __compiletime_assert_401
   ^
   1 error generated.


vim +/error +230 include/net/dst.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  223  
^1da177e4c3f41 Linus Torvalds 2005-04-16  224  static inline void dst_hold(struct dst_entry *dst)
^1da177e4c3f41 Linus Torvalds 2005-04-16  225  {
5635c10d976716 Eric Dumazet   2008-11-16  226  	/*
5635c10d976716 Eric Dumazet   2008-11-16  227  	 * If your kernel compilation stops here, please check
8b207e7374c244 David Miller   2017-11-28  228  	 * the placement of __refcnt in struct dst_entry
5635c10d976716 Eric Dumazet   2008-11-16  229  	 */
5635c10d976716 Eric Dumazet   2008-11-16 @230  	BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
44ebe79149ff41 Wei Wang       2017-06-17  231  	WARN_ON(atomic_inc_not_zero(&dst->__refcnt) == 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  232  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  233  

:::::: The code at line 230 was first introduced by commit
:::::: 5635c10d976716ef47ae441998aeae144c7e7387 net: make sure struct dst_entry refcount is aligned on 64 bytes

:::::: TO: Eric Dumazet <dada1@cosmosbay.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
