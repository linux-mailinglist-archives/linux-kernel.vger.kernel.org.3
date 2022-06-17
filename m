Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F055007D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383360AbiFQXQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383580AbiFQXQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:16:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DEC63BD9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655507761; x=1687043761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3HtJUaL6AK+hQVPvouGgMZ1sHbLrkehe8G2v8dPZwQs=;
  b=EHAqzTWPna3HReK4XUxEeScG7IZMY4iyylCcKd+uzmagZ3Eaql0h98In
   vQUVc1MbiTWOijZJVey3IceBnCOhYzsM+aJe7QbiBu1+gzYWosjS7KNNj
   jF+2d3n7IYMkAfl1o/vm+fJslkrq+Yx/+ovmpj7GrTgkfYuxtxEW6fdck
   DCo+NPHMYtT9ARUt+/cafHcdiFf3fzthtod9VQKckMVANpT42PocOaacR
   e5DraouxVgMUr3Zby6j0wkn6DF0tKkpqFbJ/zYgRFSv8DB5159X8PYYSg
   V+hvKryQ4NorYAkRs0oAGD8URGY7o+Ce7YKVqV11EbE8ItQduYUy47QPR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280665929"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280665929"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642226603"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2022 16:15:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2LC2-000PqH-6H;
        Fri, 17 Jun 2022 23:15:58 +0000
Date:   Sat, 18 Jun 2022 07:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta4 2/2] include/net/sch_generic.h:744:14: error: no
 member named 'tc_at_ingress' in 'struct sk_buff'
Message-ID: <202206180759.g5Fqzf3d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cilium/linux.git pr/meta4
head:   dcea837b60f0d9f8f3cdae284680659042f560d1
commit: dcea837b60f0d9f8f3cdae284680659042f560d1 [2/2] bpf: Add fd-based API to attach tc BPF programs
config: arm-buildonly-randconfig-r002-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180759.g5Fqzf3d-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/cilium/linux/commit/dcea837b60f0d9f8f3cdae284680659042f560d1
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta4
        git checkout dcea837b60f0d9f8f3cdae284680659042f560d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/packet/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/packet/af_packet.c:52:
   In file included from include/linux/filter.h:26:
>> include/net/sch_generic.h:744:14: error: no member named 'tc_at_ingress' in 'struct sk_buff'
           return skb->tc_at_ingress;
                  ~~~  ^
>> include/net/sch_generic.h:753:11: error: no member named 'tc_skip_classify' in 'struct sk_buff'
           if (skb->tc_skip_classify) {
               ~~~  ^
   include/net/sch_generic.h:754:8: error: no member named 'tc_skip_classify' in 'struct sk_buff'
                   skb->tc_skip_classify = 0;
                   ~~~  ^
   include/net/sch_generic.h:1361:27: error: no member named 'sch_ingress' in 'struct net_device'
                   rcu_assign_pointer(dev->sch_ingress, entry);
                                      ~~~  ^
   include/linux/rcupdate.h:454:15: note: expanded from macro 'rcu_assign_pointer'
                   WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
                               ^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from net/packet/af_packet.c:52:
   In file included from include/linux/filter.h:26:
   include/net/sch_generic.h:1361:27: error: no member named 'sch_ingress' in 'struct net_device'
                   rcu_assign_pointer(dev->sch_ingress, entry);
                                      ~~~  ^
   include/linux/rcupdate.h:454:15: note: expanded from macro 'rcu_assign_pointer'
                   WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
                               ^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from net/packet/af_packet.c:52:
   In file included from include/linux/filter.h:26:
   include/net/sch_generic.h:1361:27: error: no member named 'sch_ingress' in 'struct net_device'
                   rcu_assign_pointer(dev->sch_ingress, entry);
                                      ~~~  ^
   include/linux/rcupdate.h:454:15: note: expanded from macro 'rcu_assign_pointer'
                   WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
                               ^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from net/packet/af_packet.c:52:
   In file included from include/linux/filter.h:26:
   include/net/sch_generic.h:1361:27: error: no member named 'sch_ingress' in 'struct net_device'
                   rcu_assign_pointer(dev->sch_ingress, entry);
                                      ~~~  ^
   include/linux/rcupdate.h:454:15: note: expanded from macro 'rcu_assign_pointer'
                   WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
                               ^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   In file included from net/packet/af_packet.c:52:


vim +744 include/net/sch_generic.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  740  
fdc5432a7b44ab Daniel Borkmann  2016-01-07  741  static inline bool skb_at_tc_ingress(const struct sk_buff *skb)
fdc5432a7b44ab Daniel Borkmann  2016-01-07  742  {
fdc5432a7b44ab Daniel Borkmann  2016-01-07  743  #ifdef CONFIG_NET_CLS_ACT
8dc07fdbf2054f Willem de Bruijn 2017-01-07 @744  	return skb->tc_at_ingress;
fdc5432a7b44ab Daniel Borkmann  2016-01-07  745  #else
fdc5432a7b44ab Daniel Borkmann  2016-01-07  746  	return false;
fdc5432a7b44ab Daniel Borkmann  2016-01-07  747  #endif
fdc5432a7b44ab Daniel Borkmann  2016-01-07  748  }
fdc5432a7b44ab Daniel Borkmann  2016-01-07  749  
e7246e122aaa99 Willem de Bruijn 2017-01-07  750  static inline bool skb_skip_tc_classify(struct sk_buff *skb)
e7246e122aaa99 Willem de Bruijn 2017-01-07  751  {
e7246e122aaa99 Willem de Bruijn 2017-01-07  752  #ifdef CONFIG_NET_CLS_ACT
e7246e122aaa99 Willem de Bruijn 2017-01-07 @753  	if (skb->tc_skip_classify) {
e7246e122aaa99 Willem de Bruijn 2017-01-07  754  		skb->tc_skip_classify = 0;
e7246e122aaa99 Willem de Bruijn 2017-01-07  755  		return true;
e7246e122aaa99 Willem de Bruijn 2017-01-07  756  	}
e7246e122aaa99 Willem de Bruijn 2017-01-07  757  #endif
e7246e122aaa99 Willem de Bruijn 2017-01-07  758  	return false;
e7246e122aaa99 Willem de Bruijn 2017-01-07  759  }
e7246e122aaa99 Willem de Bruijn 2017-01-07  760  

:::::: The code at line 744 was first introduced by commit
:::::: 8dc07fdbf2054f157e8333f940a1ad728916c786 net-tc: convert tc_at to tc_at_ingress

:::::: TO: Willem de Bruijn <willemb@google.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
