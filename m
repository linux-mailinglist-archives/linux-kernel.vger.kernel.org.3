Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C924B7060
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiBOQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:21:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbiBOQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:21:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B5E4D0A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644942057; x=1676478057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fjd5BdwhAAHsy8KJ8QkVyZTQ91mJKeL8x310B2X1eps=;
  b=EdpSineSHu51yIMFuhga521G1hjPoKhifOOuMYdGOlaFYCfe4aS7jByy
   4+B3xAh2W67X18rUAEAURVdlCfkVnyLXcQMfnqSlgatqAvwqyFnoMH+xB
   qnCsoTD7t5tmnY9SpjoGhJbOTc7kqWQig5qe83io3kNznmDt1yXghj0b9
   taVdESoLDYO0Tmq/NNB+3P8AJBTZDG/MX3PxJ2F/uREuyvUnZLDW1paGr
   o2ElFa5vizqXrPR/HZbCS0+wVB6l87hoID+4NdAu2U4jzzNyAEH7QAKUp
   QgcaF+MPWSsNi6ONpvLzsj4XHq8Z5L/IEgOyTovft1v8+3bVpc4KqGazw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="233928434"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="233928434"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="635980812"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 08:20:54 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK0ZS-0009pt-88; Tue, 15 Feb 2022 16:20:54 +0000
Date:   Wed, 16 Feb 2022 00:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: [crng-random:master 17/42] include/trace/events/random.h:55:1:
 error: incompatible function pointer types passing 'void (void *, size_t,
 unsigned long)' (aka 'void (void *, unsigned int, unsigned long)') to
 parameter of type 'void (*)(void *, int, unsigned long)'
Message-ID: <202202160014.qVgMDFfX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
head:   e09db9454de88dca579c13562129bef2b0c7dd36
commit: 60681e3678705f119c0d32b5e0d56a21f90bb720 [17/42] random: make more consistent use of integer types
config: i386-randconfig-a001-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160014.qVgMDFfX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=60681e3678705f119c0d32b5e0d56a21f90bb720
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random master
        git checkout 60681e3678705f119c0d32b5e0d56a21f90bb720
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the crng-random/master HEAD e09db9454de88dca579c13562129bef2b0c7dd36 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from drivers/char/random.c:241:
   In file included from include/trace/events/random.h:212:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:873:
>> include/trace/events/random.h:55:1: error: incompatible function pointer types passing 'void (void *, size_t, unsigned long)' (aka 'void (void *, unsigned int, unsigned long)') to parameter of type 'void (*)(void *, int, unsigned long)' [-Werror,-Wincompatible-function-pointer-types]
   DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:870:35: note: expanded from macro 'DEFINE_EVENT'
           check_trace_callback_type_##call(trace_event_raw_event_##template); \
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:39:1: note: expanded from here
   trace_event_raw_event_random__mix_pool_bytes
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: passing argument to parameter 'cb' here
   DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
   ^
   include/linux/tracepoint.h:542:2: note: expanded from macro 'DEFINE_EVENT'
           DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
           ^
   include/linux/tracepoint.h:419:2: note: expanded from macro 'DECLARE_TRACE'
           __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
           ^
   include/linux/tracepoint.h:279:42: note: expanded from macro '__DECLARE_TRACE'
           check_trace_callback_type_##name(void (*cb)(data_proto))        \
                                                   ^
   In file included from drivers/char/random.c:241:
   In file included from include/trace/events/random.h:212:
   In file included from include/trace/define_trace.h:103:
   In file included from include/trace/perf.h:107:
>> include/trace/events/random.h:55:1: error: incompatible function pointer types passing 'void (void *, size_t, unsigned long)' (aka 'void (void *, unsigned int, unsigned long)') to parameter of type 'void (*)(void *, int, unsigned long)' [-Werror,-Wincompatible-function-pointer-types]
   DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/perf.h:99:35: note: expanded from macro 'DEFINE_EVENT'
           check_trace_callback_type_##call(perf_trace_##template);        \
                                            ^~~~~~~~~~~~~~~~~~~~~
   <scratch space>:62:1: note: expanded from here
   perf_trace_random__mix_pool_bytes
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: passing argument to parameter 'cb' here
   DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
   ^
   include/linux/tracepoint.h:542:2: note: expanded from macro 'DEFINE_EVENT'
           DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
           ^
   include/linux/tracepoint.h:419:2: note: expanded from macro 'DECLARE_TRACE'
           __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
           ^
   include/linux/tracepoint.h:279:42: note: expanded from macro '__DECLARE_TRACE'
           check_trace_callback_type_##name(void (*cb)(data_proto))        \
                                                   ^
   drivers/char/random.c:1734:6: warning: no previous prototype for function 'add_hwgenerator_randomness' [-Wmissing-prototypes]
   void add_hwgenerator_randomness(const void *buffer, size_t count,
        ^
   drivers/char/random.c:1734:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void add_hwgenerator_randomness(const void *buffer, size_t count,
   ^
   static 
   1 warning and 2 errors generated.


vim +55 include/trace/events/random.h

00ce1db1a634746 Theodore Ts'o      2012-07-04  54  
00ce1db1a634746 Theodore Ts'o      2012-07-04 @55  DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
90ed1e67e896cc8 Jason A. Donenfeld 2022-01-12  56  	TP_PROTO(int bytes, unsigned long IP),
00ce1db1a634746 Theodore Ts'o      2012-07-04  57  
90ed1e67e896cc8 Jason A. Donenfeld 2022-01-12  58  	TP_ARGS(bytes, IP)
00ce1db1a634746 Theodore Ts'o      2012-07-04  59  );
00ce1db1a634746 Theodore Ts'o      2012-07-04  60  

:::::: The code at line 55 was first introduced by commit
:::::: 00ce1db1a634746040ace24c09a4e3a7949a3145 random: add tracepoints for easier debugging and verification

:::::: TO: Theodore Ts'o <tytso@mit.edu>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
