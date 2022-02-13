Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789774B38E8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiBMCRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:17:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiBMCRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:17:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C2A126
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 18:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644718664; x=1676254664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NyMEWXzEQzTjegCMUyj4prv6bIi+d7lg+4hyWq4/J9E=;
  b=EAc2m/It+udjBC2pfzUJ5j7iN4WUMSh/t5BKehdEIYilBjknLCN1r1o+
   BOaYiNB46L8j3voDec5lsk98CgB8axKJ66TrPorC7w3JkMAeY1gxlWzOn
   C7QwER0ho7qbAno/Keg2leY/kQMy+Y134XGaKCsjK7iBnBNIMab+zV0rj
   p7snMIWL5K+afYgQGpYRlRk78JCGM7QzhuA/OvTjHYJXSlHTQ0lHa5hn4
   wXWqSoGxVXtxz8yE3aXg3gOfZP/EOrqNkfmEqWxKt/na5Q70Jv2U9XmdL
   00oAJezmvLAP/hCG4Vp7h/Zxb5hzfp8lQCzDnFMzHmNcGsNDx5r5kAg5p
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="233468423"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="233468423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 18:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="634470913"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Feb 2022 18:17:42 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ4SL-0006uX-MS; Sun, 13 Feb 2022 02:17:41 +0000
Date:   Sun, 13 Feb 2022 10:17:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: [ammarfaizi2-block:crng/random/jd/fast-mix-lfsr 17/38]
 include/trace/trace_events.h:870:42: error: passing argument 1 of
 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer
 type
Message-ID: <202202131057.QVvn6nBp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/fast-mix-lfsr
head:   2cdf0f5c31f7568d709533d93b746ae8932dfa99
commit: fc2551cdc07cfb4ea1247ecaec28e78f6d942c1f [17/38] random: make more consistent use of integer types
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220213/202202131057.QVvn6nBp-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fc2551cdc07cfb4ea1247ecaec28e78f6d942c1f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/fast-mix-lfsr
        git checkout fc2551cdc07cfb4ea1247ecaec28e78f6d942c1f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/crng/random/jd/fast-mix-lfsr HEAD 2cdf0f5c31f7568d709533d93b746ae8932dfa99 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from include/trace/events/random.h:212,
                    from drivers/char/random.c:241:
   include/trace/events/random.h: In function 'ftrace_test_probe_mix_pool_bytes_nolock':
>> include/trace/trace_events.h:870:42: error: passing argument 1 of 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     870 |         check_trace_callback_type_##call(trace_event_raw_event_##template); \
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          void (*)(void *, size_t,  long unsigned int) {aka void (*)(void *, unsigned int,  long unsigned int)}
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:228:
   include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, int,  long unsigned int)' but argument is of type 'void (*)(void *, size_t,  long unsigned int)' {aka 'void (*)(void *, unsigned int,  long unsigned int)'}
     279 |         check_trace_callback_type_##name(void (*cb)(data_proto))        \
         |                                          ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:9: note: in expansion of macro 'DECLARE_TRACE'
     542 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/random.h:212,
                    from drivers/char/random.c:241:
   include/trace/events/random.h: In function 'perf_test_probe_mix_pool_bytes_nolock':
>> include/trace/perf.h:99:42: error: passing argument 1 of 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer type [-Werror=incompatible-pointer-types]
      99 |         check_trace_callback_type_##call(perf_trace_##template);        \
         |                                          ^~~~~~~~~~~
         |                                          |
         |                                          void (*)(void *, size_t,  long unsigned int) {aka void (*)(void *, unsigned int,  long unsigned int)}
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:228:
   include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, int,  long unsigned int)' but argument is of type 'void (*)(void *, size_t,  long unsigned int)' {aka 'void (*)(void *, unsigned int,  long unsigned int)'}
     279 |         check_trace_callback_type_##name(void (*cb)(data_proto))        \
         |                                          ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:9: note: in expansion of macro 'DECLARE_TRACE'
     542 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/define_trace.h:104,
                    from include/trace/events/random.h:212,
                    from drivers/char/random.c:241:
   include/trace/events/random.h: In function 'bpf_test_probe_mix_pool_bytes_nolock':
>> include/trace/bpf_probe.h:94:42: error: passing argument 1 of 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer type [-Werror=incompatible-pointer-types]
      94 |         check_trace_callback_type_##call(__bpf_trace_##template);       \
         |                                          ^~~~~~~~~~~~
         |                                          |
         |                                          void (*)(void *, size_t,  long unsigned int) {aka void (*)(void *, unsigned int,  long unsigned int)}
   include/trace/bpf_probe.h:130:9: note: in expansion of macro '__DEFINE_EVENT'
     130 |         __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
         |         ^~~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:228:
   include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, int,  long unsigned int)' but argument is of type 'void (*)(void *, size_t,  long unsigned int)' {aka 'void (*)(void *, unsigned int,  long unsigned int)'}
     279 |         check_trace_callback_type_##name(void (*cb)(data_proto))        \
         |                                          ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:9: note: in expansion of macro 'DECLARE_TRACE'
     542 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   drivers/char/random.c: At top level:
   drivers/char/random.c:1739:6: warning: no previous prototype for 'add_hwgenerator_randomness' [-Wmissing-prototypes]
    1739 | void add_hwgenerator_randomness(const void *buffer, size_t count,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/check_trace_callback_type_mix_pool_bytes_nolock +870 include/trace/trace_events.h

46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  830) 
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  831) #undef DECLARE_EVENT_CLASS
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  832) #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  833) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  834) static notrace void							\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  835) trace_event_raw_event_##call(void *__data, proto)			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  836) {									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  837) 	struct trace_event_file *trace_file = __data;			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  838) 	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  839) 	struct trace_event_buffer fbuffer;				\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  840) 	struct trace_event_raw_##call *entry;				\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  841) 	int __data_size;						\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  842) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  843) 	if (trace_trigger_soft_disabled(trace_file))			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  844) 		return;							\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  845) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  846) 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  847) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  848) 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,	\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  849) 				 sizeof(*entry) + __data_size);		\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  850) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  851) 	if (!entry)							\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  852) 		return;							\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  853) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  854) 	tstruct								\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  855) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  856) 	{ assign; }							\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  857) 									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  858) 	trace_event_buffer_commit(&fbuffer);				\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  859) }
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  860) /*
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  861)  * The ftrace_test_probe is compiled out, it is only here as a build time check
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  862)  * to make sure that if the tracepoint handling changes, the ftrace probe will
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  863)  * fail to compile unless it too is updated.
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  864)  */
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  865) 
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  866) #undef DEFINE_EVENT
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  867) #define DEFINE_EVENT(template, call, proto, args)			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  868) static inline void ftrace_test_probe_##call(void)			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  869) {									\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23 @870) 	check_trace_callback_type_##call(trace_event_raw_event_##template); \
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  871) }
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  872) 

:::::: The code at line 870 was first introduced by commit
:::::: 46ac51822a6a0b83ee3e408ee9edcb292fb8ced0 tracing: Move non perf code out of perf.h

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
