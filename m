Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC39550021
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbiFQWpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiFQWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:45:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509EC3E0C7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655505900; x=1687041900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1vOU98FLPlxlzKwHsfc9G3VPTFrl2r6C+kRfGvJaz3U=;
  b=KUutp8x+w7yRZOMcCO+slsFeFc+Y8TcCBQ6YsAXM/yONh/cMHkHEGcoJ
   IqqdTATZ8M09FGS77F4bnyWGbK/iMmtkDDdDZ++UF5crBdZ7LqK6vy1gW
   qx+AT8ZusBfFUtfyQRFHUGQd+ndPpULZxJFiHykFL2/tojP0BX0yBOK3k
   GU3BRcVpyLEAmrSmsdhcdnO9AeHLlBb9yCEUPq0KncCvPskUh16qRAX1g
   yET7AffT6vSdrA81l13rUIFgG8kUP1P/QHSkTji5er4pOU9jmIxy4Bd/Z
   5cG/F98/WmfcMYOJrSIxUmbfUeAWZnmIiZv9HxPJQQBOCkS2pNU5oC3AU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341284944"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341284944"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590295209"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2022 15:44:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Ki1-000PpB-GW;
        Fri, 17 Jun 2022 22:44:57 +0000
Date:   Sat, 18 Jun 2022 06:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta4 2/2] arch/arm64/include/asm/barrier.h:130:41:
 error: invalid type argument of unary '*' (have 'int')
Message-ID: <202206180602.gtyL07Si-lkp@intel.com>
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
config: arm64-randconfig-r016-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180602.gtyL07Si-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/dcea837b60f0d9f8f3cdae284680659042f560d1
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta4
        git checkout dcea837b60f0d9f8f3cdae284680659042f560d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:39: error: 'struct net_device' has no member named 'sch_ingress'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
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
   arch/arm64/include/asm/barrier.h:125:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     125 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:39: error: 'struct net_device' has no member named 'sch_ingress'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
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
   arch/arm64/include/asm/barrier.h:125:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     125 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:39: error: 'struct net_device' has no member named 'sch_ingress'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
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
   arch/arm64/include/asm/barrier.h:125:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     125 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from kernel/sysctl.c:22:
   include/net/sch_generic.h:1361:39: error: 'struct net_device' has no member named 'sch_ingress'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   arch/arm64/include/asm/barrier.h:126:40: note: in definition of macro '__smp_store_release'
     126 |         kasan_check_write(__p, sizeof(*p));                             \
         |                                        ^
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/barrier.h:126:27: warning: passing argument 1 of 'kasan_check_write' makes pointer from integer without a cast [-Wint-conversion]
     126 |         kasan_check_write(__p, sizeof(*p));                             \
         |                           ^~~
         |                           |
         |                           int
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from kernel/sysctl.c:22:
   include/linux/kasan-checks.h:44:59: note: expected 'const volatile void *' but argument is of type 'int'
      44 | static inline bool kasan_check_write(const volatile void *p, unsigned int size)
         |                                      ~~~~~~~~~~~~~~~~~~~~~^
   In file included from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from kernel/sysctl.c:22:
   include/net/sch_generic.h:1361:39: error: 'struct net_device' has no member named 'sch_ingress'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                                       ^~
   arch/arm64/include/asm/barrier.h:127:25: note: in definition of macro '__smp_store_release'
     127 |         switch (sizeof(*p)) {                                           \
         |                         ^
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/barrier.h:130:41: error: invalid type argument of unary '*' (have 'int')
     130 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:136:41: error: invalid type argument of unary '*' (have 'int')
     136 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:142:41: error: invalid type argument of unary '*' (have 'int')
     142 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:148:41: error: invalid type argument of unary '*' (have 'int')
     148 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1361:17: note: in expansion of macro 'rcu_assign_pointer'
    1361 |                 rcu_assign_pointer(dev->sch_ingress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
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
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
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
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                                       ^~
   include/linux/compiler_types.h:332:23: note: in definition of macro '__compiletime_assert'
--
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
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
   arch/arm64/include/asm/barrier.h:125:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     125 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
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
   arch/arm64/include/asm/barrier.h:125:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     125 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
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
   arch/arm64/include/asm/barrier.h:125:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     125 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from kernel/sysctl.c:22:
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                                       ^~
   arch/arm64/include/asm/barrier.h:126:40: note: in definition of macro '__smp_store_release'
     126 |         kasan_check_write(__p, sizeof(*p));                             \
         |                                        ^
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/barrier.h:126:27: warning: passing argument 1 of 'kasan_check_write' makes pointer from integer without a cast [-Wint-conversion]
     126 |         kasan_check_write(__p, sizeof(*p));                             \
         |                           ^~~
         |                           |
         |                           int
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from kernel/sysctl.c:22:
   include/linux/kasan-checks.h:44:59: note: expected 'const volatile void *' but argument is of type 'int'
      44 | static inline bool kasan_check_write(const volatile void *p, unsigned int size)
         |                                      ~~~~~~~~~~~~~~~~~~~~~^
   In file included from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from kernel/sysctl.c:22:
   include/net/sch_generic.h:1363:39: error: 'struct net_device' has no member named 'sch_egress'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                                       ^~
   arch/arm64/include/asm/barrier.h:127:25: note: in definition of macro '__smp_store_release'
     127 |         switch (sizeof(*p)) {                                           \
         |                         ^
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/barrier.h:130:41: error: invalid type argument of unary '*' (have 'int')
     130 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:136:41: error: invalid type argument of unary '*' (have 'int')
     136 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:142:41: error: invalid type argument of unary '*' (have 'int')
     142 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:148:41: error: invalid type argument of unary '*' (have 'int')
     148 |                                 : "=Q" (*__p)                           \
         |                                         ^~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:456:17: note: in expansion of macro 'smp_store_release'
     456 |                 smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                 ^~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1363:17: note: in expansion of macro 'rcu_assign_pointer'
    1363 |                 rcu_assign_pointer(dev->sch_egress, entry);
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arm64/include/asm/compat.h:28,
                    from arch/arm64/include/asm/stat.h:13,
                    from include/linux/stat.h:6,
                    from include/linux/module.h:13,
                    from kernel/sysctl.c:22:
   include/net/sch_generic.h: In function 'dev_sch_entry_fetch':
   include/net/sch_generic.h:1399:36: error: 'struct net_device' has no member named 'sch_ingress'
    1399 |                 rcu_dereference(dev->sch_ingress) :
         |                                    ^~
   include/linux/rcupdate.h:392:17: note: in definition of macro '__rcu_dereference_check'
     392 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   include/linux/rcupdate.h:604:28: note: in expansion of macro 'rcu_dereference_check'
     604 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1399:17: note: in expansion of macro 'rcu_dereference'
    1399 |                 rcu_dereference(dev->sch_ingress) :
         |                 ^~~~~~~~~~~~~~~
   include/net/sch_generic.h:1399:36: error: 'struct net_device' has no member named 'sch_ingress'
    1399 |                 rcu_dereference(dev->sch_ingress) :
         |                                    ^~
   include/linux/rcupdate.h:392:38: note: in definition of macro '__rcu_dereference_check'
     392 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
   include/linux/rcupdate.h:604:28: note: in expansion of macro 'rcu_dereference_check'
     604 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1399:17: note: in expansion of macro 'rcu_dereference'
    1399 |                 rcu_dereference(dev->sch_ingress) :
         |                 ^~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/net/sch_generic.h:1399:36: error: 'struct net_device' has no member named 'sch_ingress'
    1399 |                 rcu_dereference(dev->sch_ingress) :
         |                                    ^~
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
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:392:50: note: in expansion of macro 'READ_ONCE'
..


vim +130 arch/arm64/include/asm/barrier.h

47933ad41a86a4 Peter Zijlstra     2013-11-06  119  
fd072df850e536 Michael S. Tsirkin 2015-12-27  120  #define __smp_store_release(p, v)					\
47933ad41a86a4 Peter Zijlstra     2013-11-06  121  do {									\
131e135f7fd14b Mark Rutland       2019-04-09  122  	typeof(p) __p = (p);						\
10223c5286f738 Will Deacon        2019-12-19  123  	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u =	\
10223c5286f738 Will Deacon        2019-12-19  124  		{ .__val = (__force __unqual_scalar_typeof(*p)) (v) };	\
47933ad41a86a4 Peter Zijlstra     2013-11-06  125  	compiletime_assert_atomic_type(*p);				\
131e135f7fd14b Mark Rutland       2019-04-09 @126  	kasan_check_write(__p, sizeof(*p));				\
47933ad41a86a4 Peter Zijlstra     2013-11-06 @127  	switch (sizeof(*p)) {						\
878a84d5a8a18a Andre Przywara     2015-04-20  128  	case 1:								\
878a84d5a8a18a Andre Przywara     2015-04-20  129  		asm volatile ("stlrb %w1, %0"				\
131e135f7fd14b Mark Rutland       2019-04-09 @130  				: "=Q" (*__p)				\
994870bead4ab1 Mark Rutland       2017-05-03  131  				: "r" (*(__u8 *)__u.__c)		\
994870bead4ab1 Mark Rutland       2017-05-03  132  				: "memory");				\
878a84d5a8a18a Andre Przywara     2015-04-20  133  		break;							\
878a84d5a8a18a Andre Przywara     2015-04-20  134  	case 2:								\
878a84d5a8a18a Andre Przywara     2015-04-20  135  		asm volatile ("stlrh %w1, %0"				\
131e135f7fd14b Mark Rutland       2019-04-09  136  				: "=Q" (*__p)				\
994870bead4ab1 Mark Rutland       2017-05-03  137  				: "r" (*(__u16 *)__u.__c)		\
994870bead4ab1 Mark Rutland       2017-05-03  138  				: "memory");				\
878a84d5a8a18a Andre Przywara     2015-04-20  139  		break;							\
47933ad41a86a4 Peter Zijlstra     2013-11-06  140  	case 4:								\
47933ad41a86a4 Peter Zijlstra     2013-11-06  141  		asm volatile ("stlr %w1, %0"				\
131e135f7fd14b Mark Rutland       2019-04-09  142  				: "=Q" (*__p)				\
994870bead4ab1 Mark Rutland       2017-05-03  143  				: "r" (*(__u32 *)__u.__c)		\
994870bead4ab1 Mark Rutland       2017-05-03  144  				: "memory");				\
47933ad41a86a4 Peter Zijlstra     2013-11-06  145  		break;							\
47933ad41a86a4 Peter Zijlstra     2013-11-06  146  	case 8:								\
47933ad41a86a4 Peter Zijlstra     2013-11-06  147  		asm volatile ("stlr %1, %0"				\
131e135f7fd14b Mark Rutland       2019-04-09  148  				: "=Q" (*__p)				\
994870bead4ab1 Mark Rutland       2017-05-03  149  				: "r" (*(__u64 *)__u.__c)		\
994870bead4ab1 Mark Rutland       2017-05-03  150  				: "memory");				\
47933ad41a86a4 Peter Zijlstra     2013-11-06  151  		break;							\
47933ad41a86a4 Peter Zijlstra     2013-11-06  152  	}								\
47933ad41a86a4 Peter Zijlstra     2013-11-06  153  } while (0)
47933ad41a86a4 Peter Zijlstra     2013-11-06  154  

:::::: The code at line 130 was first introduced by commit
:::::: 131e135f7fd14b1de7a5eb26631076705c18073f arm64: instrument smp_{load_acquire,store_release}

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
