Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA44BD1B2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbiBTUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:52:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiBTUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:52:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3D38BD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645390313; x=1676926313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P1p0BPZFwe35D4RMvf2S66aiIfSYzzHjMO/RaVsrPas=;
  b=lARal5OTuZAHm6nEqZQ47/pMvHMoenCff62N72nf8qvHsYGgMlLuOx3G
   YBsCSdqkQ8U+uRSAv2dLlslPibGkYgd1QluTbTeV1CMMZnYh5J7cmelWP
   bpHEtTIcnciZgjsDXqsa7WD7sWnfm2WdR5F7Mjr6tkF7sbsb92CNS5V/6
   I6mZXq8I7R1rba6yjxO7sJibYW9XZruzK0FSA9uSkprg5c1iBbP+rL4Jk
   HyAp57O5wOhIerYZIJrPQTKg8mCoP8yRCJKIoEeMd7KQF/OP9kTra/IoB
   wbq/nokvl4HdE0paVlLzCVMjYsTPzgQdu/rQzk1vSN8gLKymAMPLoCSh6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238813866"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="238813866"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="775807382"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2022 12:51:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLtBO-0000kX-KG; Sun, 20 Feb 2022 20:51:50 +0000
Date:   Mon, 21 Feb 2022 04:51:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: [ammarfaizi2-block:crng/random/master 17/41]
 include/trace/trace_events.h:870:35: error: passing argument 1 of
 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer
 type
Message-ID: <202202210411.RtmlkvoG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/master
head:   0a5b4f0c48521f6cb5c4d82cfef83742636ac70a
commit: c66a21451b644d1cee8df01f688c4342a293d713 [17/41] random: make more consistent use of integer types
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220221/202202210411.RtmlkvoG-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c66a21451b644d1cee8df01f688c4342a293d713
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/master
        git checkout c66a21451b644d1cee8df01f688c4342a293d713
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/crng/random/master HEAD 0a5b4f0c48521f6cb5c4d82cfef83742636ac70a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from include/trace/events/random.h:212,
                    from drivers/char/random.c:241:
   include/trace/events/random.h: In function 'ftrace_test_probe_mix_pool_bytes_nolock':
>> include/trace/trace_events.h:870:35: error: passing argument 1 of 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     870 |  check_trace_callback_type_##call(trace_event_raw_event_##template); \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   void (*)(void *, size_t,  long unsigned int) {aka void (*)(void *, long unsigned int,  long unsigned int)}
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:228:
   include/linux/tracepoint.h:279:42: note: expected 'void (*)(void *, int,  long unsigned int)' but argument is of type 'void (*)(void *, size_t,  long unsigned int)' {aka 'void (*)(void *, long unsigned int,  long unsigned int)'}
     279 |  check_trace_callback_type_##name(void (*cb)(data_proto)) \
         |                                   ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/random.h:212,
                    from drivers/char/random.c:241:
   include/trace/events/random.h: In function 'perf_test_probe_mix_pool_bytes_nolock':
>> include/trace/perf.h:99:35: error: passing argument 1 of 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer type [-Werror=incompatible-pointer-types]
      99 |  check_trace_callback_type_##call(perf_trace_##template); \
         |                                   ^~~~~~~~~~~
         |                                   |
         |                                   void (*)(void *, size_t,  long unsigned int) {aka void (*)(void *, long unsigned int,  long unsigned int)}
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:228:
   include/linux/tracepoint.h:279:42: note: expected 'void (*)(void *, int,  long unsigned int)' but argument is of type 'void (*)(void *, size_t,  long unsigned int)' {aka 'void (*)(void *, long unsigned int,  long unsigned int)'}
     279 |  check_trace_callback_type_##name(void (*cb)(data_proto)) \
         |                                   ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/define_trace.h:104,
                    from include/trace/events/random.h:212,
                    from drivers/char/random.c:241:
   include/trace/events/random.h: In function 'bpf_test_probe_mix_pool_bytes_nolock':
>> include/trace/bpf_probe.h:94:35: error: passing argument 1 of 'check_trace_callback_type_mix_pool_bytes_nolock' from incompatible pointer type [-Werror=incompatible-pointer-types]
      94 |  check_trace_callback_type_##call(__bpf_trace_##template); \
         |                                   ^~~~~~~~~~~~
         |                                   |
         |                                   void (*)(void *, size_t,  long unsigned int) {aka void (*)(void *, long unsigned int,  long unsigned int)}
   include/trace/bpf_probe.h:130:2: note: in expansion of macro '__DEFINE_EVENT'
     130 |  __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
         |  ^~~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:228:
   include/linux/tracepoint.h:279:42: note: expected 'void (*)(void *, int,  long unsigned int)' but argument is of type 'void (*)(void *, size_t,  long unsigned int)' {aka 'void (*)(void *, long unsigned int,  long unsigned int)'}
     279 |  check_trace_callback_type_##name(void (*cb)(data_proto)) \
         |                                   ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   include/trace/events/random.h:55:1: note: in expansion of macro 'DEFINE_EVENT'
      55 | DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes_nolock,
         | ^~~~~~~~~~~~
   drivers/char/random.c: At top level:
   drivers/char/random.c:1734:6: warning: no previous prototype for 'add_hwgenerator_randomness' [-Wmissing-prototypes]
    1734 | void add_hwgenerator_randomness(const void *buffer, size_t count,
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
