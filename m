Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980FF4E341C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiCUXRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiCUXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:17:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72298356E6E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647903993; x=1679439993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ynCVYcawpw7anMNllsT8yMyIi2FLTEUWlAucgMzGzVk=;
  b=oGunCjDDuZC8KdpJm9x9o5XwGAT9eOsXB+Hg45PcKHTJxosi2MraP1Mh
   0MuWZ1hHVXnaF9YOOy5ijZ3a6k6uWS554TtXV1Cbj1wCy8eQzCiYYrsDr
   1yAHRKYXvuyklC+FlhBicNWezI+jQJDm2f2RScoQuKAzccsESa6r09VmF
   BoeeeybvkCona6+VGaZJdO7i1SvVhod2kavcicXIDmGOVPurvWZ+2+3zb
   0n3FaJFEc7Vptcq0ceRlE6fRaQcWEjfEQc2762wJc9XycVniALUaHhtrZ
   gS90I4cRxa/R7FZcd1jK14wN5NjzlbwGqm9bEnoB8szSwW9+zT3f1ieyW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="256486183"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="256486183"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 15:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="716670016"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2022 15:43:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWQkk-000IEa-Mb; Mon, 21 Mar 2022 22:43:54 +0000
Date:   Tue, 22 Mar 2022 06:43:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 21/24] net/netfilter/nfnetlink.c:711:22:
 error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
Message-ID: <202203220605.8O9WsB6a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: x86_64-randconfig-a011-20220321 (https://download.01.org/0day-ci/archive/20220322/202203220605.8O9WsB6a-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=75a944cf2fe90182d986638a7422238b310f1ca4
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 75a944cf2fe90182d986638a7422238b310f1ca4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/netfilter/nfnetlink.c: In function 'nfnetlink_bind':
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
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
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
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
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
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
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
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
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
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
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
   include/asm-generic/rwonce.h:55:20: note: in definition of macro '__WRITE_ONCE'
      55 |  *(volatile typeof(x) *)&(x) = (val);    \
         |                    ^
   net/netfilter/nfnetlink.c:711:4: note: in expansion of macro 'WRITE_ONCE'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |    ^~~~~~~~~~
>> net/netfilter/nfnetlink.c:711:22: error: 'struct netns_ct' has no member named 'ctnetlink_has_listener'
     711 |    WRITE_ONCE(net->ct.ctnetlink_has_listener, true);
         |                      ^
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
