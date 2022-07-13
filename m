Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA110572E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiGMGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGMGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:44:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F14DE9E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657694692; x=1689230692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cn1z7D3yq5p9a+zIQYH3O0ext3e1VeheuYf4TBBmeEU=;
  b=cQNL9A89z+jfnClcOKmqxLM0VeWTEEAxzkNgdIq44T1DpJUk/Q/1VmJB
   /RlNYq1R6qQCOngz3AyoVNiH88dHhVDd4GMyQInvaF6VAyWuHtFbIOB3H
   kD8pqPJCsaPjwTyg+GQkbKgqD29+HFpo3HXbHhjzglTysiZx6iY+Iz0N4
   /UntRZeiPv290rJrh02TLTHv3aRY/nTmfpHvBIU7q4oZ4vYaHqU3eVMM6
   WTIRFNiZnJSjUex18RlO29L55MqY2ja2LXxyepKfqzVQiCAgFM4jgUbTl
   yfoQ0AGWSX6lhpm3QpGSyxKnVpNHARUElgE+foG2caHQjqLLf8tdY83ds
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="310756031"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="310756031"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 23:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570498028"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 23:44:50 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBW77-0003Df-GP;
        Wed, 13 Jul 2022 06:44:49 +0000
Date:   Wed, 13 Jul 2022 14:44:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/4] include/net/sch_xgress.h:55:39: error: 'struct
 net_device' has no member named 'sch_ingress'
Message-ID: <202207131422.TaNxjjlB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cilium/linux.git pr/meta5
head:   9c43c45e608fcb6fac0d8148662406a919ba9bee
commit: 9c43c45e608fcb6fac0d8148662406a919ba9bee [4/4] bpf: Add fd-based API to attach tc BPF programs
config: s390-randconfig-r025-20220712 (https://download.01.org/0day-ci/archive/20220713/202207131422.TaNxjjlB-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/9c43c45e608fcb6fac0d8148662406a919ba9bee
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout 9c43c45e608fcb6fac0d8148662406a919ba9bee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   include/net/sch_xgress.h: In function 'dev_sch_entry_update':
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from ./arch/s390/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:9,
                    from kernel/bpf/syscall.c:4:
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:9: note: in expansion of macro 'compiletime_assert'
     355 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:28: note: in expansion of macro '__native_word'
     355 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:40:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      40 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:9: note: in expansion of macro 'compiletime_assert'
     355 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:28: note: in expansion of macro '__native_word'
     355 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:40:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      40 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:9: note: in expansion of macro 'compiletime_assert'
     355 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:28: note: in expansion of macro '__native_word'
     355 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:40:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      40 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:9: note: in expansion of macro 'compiletime_assert'
     355 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:355:28: note: in expansion of macro '__native_word'
     355 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:40:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      40 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from ./arch/s390/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:9,
                    from kernel/bpf/syscall.c:4:
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:39: note: in expansion of macro 'RCU_INITIALIZER'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                                       ^~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:39: error: 'struct net_device' has no member named 'sch_ingress'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   include/asm-generic/rwonce.h:61:9: note: in expansion of macro '__WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~
   arch/s390/include/asm/barrier.h:42:9: note: in expansion of macro 'WRITE_ONCE'
      42 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:39: note: in expansion of macro 'RCU_INITIALIZER'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                                       ^~~~~~~~~~~~~~~
   include/net/sch_xgress.h:55:17: note: in expansion of macro 'rcu_assign_pointer'
      55 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/net/sch_xgress.h:57:39: error: 'struct net_device' has no member named 'sch_egress'
      57 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:57:17: note: in expansion of macro 'rcu_assign_pointer'
      57 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:57:39: error: 'struct net_device' has no member named 'sch_egress'
      57 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:454:17: note: in expansion of macro 'WRITE_ONCE'
     454 |                 WRITE_ONCE((p), (typeof(p))(_r_a_p__v));                      \
         |                 ^~~~~~~~~~
   include/net/sch_xgress.h:57:17: note: in expansion of macro 'rcu_assign_pointer'
      57 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_xgress.h:57:39: error: 'struct net_device' has no member named 'sch_egress'
      57 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
     332 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'


vim +55 include/net/sch_xgress.h

    48	
    49	static inline void
    50	dev_sch_entry_update(struct net_device *dev, struct sch_entry *entry,
    51			     bool ingress)
    52	{
    53		ASSERT_RTNL();
    54		if (ingress)
  > 55			rcu_assign_pointer(dev->sch_ingress, entry);
    56		else
  > 57			rcu_assign_pointer(dev->sch_egress, entry);
    58	}
    59	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
