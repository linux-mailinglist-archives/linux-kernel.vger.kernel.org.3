Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE074E361A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiCVBsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiCVBsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:48:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB7D377EF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647913598; x=1679449598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z17sQXdwaxg0ebIvpSslOgQK5+ta+3aRO7ECzMquass=;
  b=F4BKFH2XxEenEhOqy6XZ85TDrwDfVy9ExWKniYVE8AEivs5eKxEX3Ygm
   tn9/laZlyXvgZqRtJjXGSF4pvcvQ8c2yF/+fr7JfDsPaUwn7kzXPVqq69
   sAhFY1glI9uykb+h5hank0qaWQ5TiaAYcHqlWdZGJrCB60y7Me3Aj12zk
   +kC7wSvvUK594ij7HdTLnk8jpGLn4gzj7kenPG28b7TIiSyEQf3NE+GqN
   8yTLSRdNwugh59l/Xyp8a2JJH8hp7rBhbJkhdLpmwKIWrR4i/mRL6YKNY
   mMnyEcfq1ydpB5QQRJFncFxP0Bjr5BRWyjBDyLcTjzDsUZyiivo7u5SLi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257886332"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257886332"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="636860495"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2022 18:46:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWTbX-000IL2-PJ; Tue, 22 Mar 2022 01:46:35 +0000
Date:   Tue, 22 Mar 2022 09:46:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 21/24] net/netfilter/nfnetlink.c:711:18:
 error: 'struct net' has no member named 'ct'
Message-ID: <202203220927.XDcSImyg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   0481bbb83971b25a71fba81269b3bc0a392d24e3
commit: 75a944cf2fe90182d986638a7422238b310f1ca4 [21/24] netfilter: nfnetlink: allow to detect if ctnetlink listeners exist
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220322/202203220927.XDcSImyg-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=75a944cf2fe90182d986638a7422238b310f1ca4
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 75a944cf2fe90182d986638a7422238b310f1ca4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/netfilter/nfnetlink.c: In function 'nfnetlink_bind':
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/linux/compiler_types.h:329:9: note: in definition of macro '__compiletime_assert'
     329 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:349:2: note: in expansion of macro '_compiletime_assert'
     349 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/linux/compiler_types.h:329:9: note: in definition of macro '__compiletime_assert'
     329 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:349:2: note: in expansion of macro '_compiletime_assert'
     349 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/linux/compiler_types.h:329:9: note: in definition of macro '__compiletime_assert'
     329 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:349:2: note: in expansion of macro '_compiletime_assert'
     349 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/linux/compiler_types.h:329:9: note: in definition of macro '__compiletime_assert'
     329 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:349:2: note: in expansion of macro '_compiletime_assert'
     349 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/linux/compiler_types.h:329:9: note: in definition of macro '__compiletime_assert'
     329 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:349:2: note: in expansion of macro '_compiletime_assert'
     349 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:255,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/netfilter/nfnetlink.c:17:
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/asm-generic/rwonce.h:55:20: note: in definition of macro '__WRITE_ONCE'
      55 |  *(volatile typeof(x) *)&(x) = (val);    \
         |                    ^
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
>> net/netfilter/nfnetlink.c:711:18: error: 'struct net' has no member named 'ct'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                  ^~
   include/asm-generic/rwonce.h:55:27: note: in definition of macro '__WRITE_ONCE'
      55 |  *(volatile typeof(x) *)&(x) = (val);    \
         |                           ^
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~


vim +711 net/netfilter/nfnetlink.c

   698	
   699		if (type == NFNL_SUBSYS_CTNETLINK) {
   700			struct nfnl_net *nfnlnet = nfnl_pernet(net);
   701	
   702			nfnl_lock(NFNL_SUBSYS_CTNETLINK);
   703	
   704			if (WARN_ON_ONCE(nfnlnet->ctnetlink_listeners == UINT_MAX)) {
   705				nfnl_unlock(NFNL_SUBSYS_CTNETLINK);
   706				return -EOVERFLOW;
   707			}
   708	
   709			nfnlnet->ctnetlink_listeners++;
   710			if (nfnlnet->ctnetlink_listeners == 1)
 > 711				WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
   712			nfnl_unlock(NFNL_SUBSYS_CTNETLINK);
   713		}
   714	
   715		return 0;
   716	}
   717	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
