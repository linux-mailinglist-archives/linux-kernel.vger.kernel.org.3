Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1426F576B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 03:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGPBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 21:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPBJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 21:09:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC68164E1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657933792; x=1689469792;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4GCCSqYfxhMfuUeYnX9yJ1HDie2rP+pCxp6DS8qkcDI=;
  b=jsK40m8r/Ne6/UnIK1fO+R4JhtyZycuBFjlQjT3r+Ov+eHS7RPr4bKJC
   JK3bXwALDw3MRwTFJ83qpwpFYQEQ2zjiugsuUsRVFftsfaaAgnES6M5bq
   BRcZTQU7KR7eFJQ2jFxIk8zZkYO4Bgea8WZLJ2LdV2lTLtv2QxwN9YY5B
   FJD1RswRzvUxyt4JtFWmzzK8WpW1g94tUG8iXPJ08XRuYlhplb6Mh/A+l
   2YT1ROsyM0UzVEquB/OSlopK8hou/7h2ZKKMQUdDrhGk7l1/pRGgthJoQ
   onrPqMwTOeOoMhAE5rX7jk7cghRO/kxC4+k8/vcdiSUa0ESIMZ28zf7Qp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="284692241"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="284692241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 18:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="629306177"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2022 18:09:50 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCWJZ-0000uk-Rz;
        Sat, 16 Jul 2022 01:09:49 +0000
Date:   Sat, 16 Jul 2022 09:09:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 30/30]
 include/linux/cpumask.h:95:42: warning: function
 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf'
 format attribute
Message-ID: <202207160905.GmOfByea-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   26b2da5fc0b41a9a6a5e30b858da28572a6f4cbc
commit: 26b2da5fc0b41a9a6a5e30b858da28572a6f4cbc [30/30] tracing: Add example and documentation for new __vstring() macro
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220716/202207160905.GmOfByea-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/26b2da5fc0b41a9a6a5e30b858da28572a6f4cbc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout 26b2da5fc0b41a9a6a5e30b858da28572a6f4cbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash samples/trace_events/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from samples/trace_events/trace-events-sample.h:608,
                    from samples/trace_events/trace-events-sample.c:12:
   samples/trace_events/./trace-events-sample.h: In function 'trace_event_get_offsets_foo_bar':
>> include/linux/cpumask.h:95:42: warning: function 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      95 | #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
         |                                          ^~~~~~~
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   samples/trace_events/./trace-events-sample.h:277:1: note: in expansion of macro 'TRACE_EVENT'
     277 | TRACE_EVENT(foo_bar,
         | ^~~~~~~~~~~
   samples/trace_events/./trace-events-sample.h:285:9: note: in expansion of macro 'TP_STRUCT__entry'
     285 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage5_get_offsets.h:82:34: note: in expansion of macro '__dynamic_array'
      82 | #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,   \
         |                                  ^~~~~~~~~~~~~~~
   include/trace/stages/stage5_get_offsets.h:70:11: note: in expansion of macro '__bitmask_size_in_bytes_raw'
      70 |         ((__bitmask_size_in_bytes_raw(nr_bits) +                \
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/stages/stage5_get_offsets.h:83:42: note: in expansion of macro '__bitmask_size_in_longs'
      83 |                                          __bitmask_size_in_longs(nr_bits))
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~
   samples/trace_events/./trace-events-sample.h:290:17: note: in expansion of macro '__bitmask'
     290 |                 __bitmask(      cpus,   num_possible_cpus()     )
         |                 ^~~~~~~~~
   include/linux/cpumask.h:915:48: note: in expansion of macro 'cpu_possible_mask'
     915 | #define num_possible_cpus()     cpumask_weight(cpu_possible_mask)
         |                                                ^~~~~~~~~~~~~~~~~
   samples/trace_events/./trace-events-sample.h:290:41: note: in expansion of macro 'num_possible_cpus'
     290 |                 __bitmask(      cpus,   num_possible_cpus()     )
         |                                         ^~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from samples/trace_events/trace-events-sample.h:608,
                    from samples/trace_events/trace-events-sample.c:12:
   samples/trace_events/./trace-events-sample.h: In function 'trace_event_raw_event_foo_bar':
   include/trace/trace_events.h:386:16: warning: function 'trace_event_raw_event_foo_bar' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     386 |         struct trace_event_raw_##call *entry;                           \
         |                ^~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   samples/trace_events/./trace-events-sample.h:277:1: note: in expansion of macro 'TRACE_EVENT'
     277 | TRACE_EVENT(foo_bar,
         | ^~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from samples/trace_events/trace-events-sample.h:608,
                    from samples/trace_events/trace-events-sample.c:12:
   samples/trace_events/./trace-events-sample.h: In function 'perf_trace_foo_bar':
   include/trace/perf.h:64:16: warning: function 'perf_trace_foo_bar' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      64 |         struct hlist_head *head;                                        \
         |                ^~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   samples/trace_events/./trace-events-sample.h:277:1: note: in expansion of macro 'TRACE_EVENT'
     277 | TRACE_EVENT(foo_bar,
         | ^~~~~~~~~~~


vim +95 include/linux/cpumask.h

^1da177e4c3f415 Linus Torvalds   2005-04-16   49  
^1da177e4c3f415 Linus Torvalds   2005-04-16   50  /*
^1da177e4c3f415 Linus Torvalds   2005-04-16   51   * The following particular system cpumasks and operations manage
b3199c025d1646e Rusty Russell    2008-12-30   52   * possible, present, active and online cpus.
^1da177e4c3f415 Linus Torvalds   2005-04-16   53   *
b3199c025d1646e Rusty Russell    2008-12-30   54   *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
b3199c025d1646e Rusty Russell    2008-12-30   55   *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
b3199c025d1646e Rusty Russell    2008-12-30   56   *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
b3199c025d1646e Rusty Russell    2008-12-30   57   *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
^1da177e4c3f415 Linus Torvalds   2005-04-16   58   *
b3199c025d1646e Rusty Russell    2008-12-30   59   *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
^1da177e4c3f415 Linus Torvalds   2005-04-16   60   *
b3199c025d1646e Rusty Russell    2008-12-30   61   *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
b3199c025d1646e Rusty Russell    2008-12-30   62   *  that it is possible might ever be plugged in at anytime during the
b3199c025d1646e Rusty Russell    2008-12-30   63   *  life of that system boot.  The cpu_present_mask is dynamic(*),
b3199c025d1646e Rusty Russell    2008-12-30   64   *  representing which CPUs are currently plugged in.  And
b3199c025d1646e Rusty Russell    2008-12-30   65   *  cpu_online_mask is the dynamic subset of cpu_present_mask,
b3199c025d1646e Rusty Russell    2008-12-30   66   *  indicating those CPUs available for scheduling.
b3199c025d1646e Rusty Russell    2008-12-30   67   *
b3199c025d1646e Rusty Russell    2008-12-30   68   *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
^1da177e4c3f415 Linus Torvalds   2005-04-16   69   *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
^1da177e4c3f415 Linus Torvalds   2005-04-16   70   *  ACPI reports present at boot.
^1da177e4c3f415 Linus Torvalds   2005-04-16   71   *
b3199c025d1646e Rusty Russell    2008-12-30   72   *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
^1da177e4c3f415 Linus Torvalds   2005-04-16   73   *  depending on what ACPI reports as currently plugged in, otherwise
b3199c025d1646e Rusty Russell    2008-12-30   74   *  cpu_present_mask is just a copy of cpu_possible_mask.
^1da177e4c3f415 Linus Torvalds   2005-04-16   75   *
b3199c025d1646e Rusty Russell    2008-12-30   76   *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
b3199c025d1646e Rusty Russell    2008-12-30   77   *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
^1da177e4c3f415 Linus Torvalds   2005-04-16   78   *
^1da177e4c3f415 Linus Torvalds   2005-04-16   79   * Subtleties:
^1da177e4c3f415 Linus Torvalds   2005-04-16   80   * 1) UP arch's (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
^1da177e4c3f415 Linus Torvalds   2005-04-16   81   *    assumption that their single CPU is online.  The UP
b3199c025d1646e Rusty Russell    2008-12-30   82   *    cpu_{online,possible,present}_masks are placebos.  Changing them
^1da177e4c3f415 Linus Torvalds   2005-04-16   83   *    will have no useful affect on the following num_*_cpus()
^1da177e4c3f415 Linus Torvalds   2005-04-16   84   *    and cpu_*() macros in the UP case.  This ugliness is a UP
^1da177e4c3f415 Linus Torvalds   2005-04-16   85   *    optimization - don't waste any instructions or memory references
^1da177e4c3f415 Linus Torvalds   2005-04-16   86   *    asking if you're online or how many CPUs there are if there is
^1da177e4c3f415 Linus Torvalds   2005-04-16   87   *    only one CPU.
^1da177e4c3f415 Linus Torvalds   2005-04-16   88   */
^1da177e4c3f415 Linus Torvalds   2005-04-16   89  
4b804c85dc37db6 Rasmus Villemoes 2016-01-20   90  extern struct cpumask __cpu_possible_mask;
4b804c85dc37db6 Rasmus Villemoes 2016-01-20   91  extern struct cpumask __cpu_online_mask;
4b804c85dc37db6 Rasmus Villemoes 2016-01-20   92  extern struct cpumask __cpu_present_mask;
4b804c85dc37db6 Rasmus Villemoes 2016-01-20   93  extern struct cpumask __cpu_active_mask;
e40f74c535b8a0e Peter Zijlstra   2021-01-19   94  extern struct cpumask __cpu_dying_mask;
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20  @95  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20   96  #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20   97  #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20   98  #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
e40f74c535b8a0e Peter Zijlstra   2021-01-19   99  #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
b3199c025d1646e Rusty Russell    2008-12-30  100  

:::::: The code at line 95 was first introduced by commit
:::::: 5aec01b834fd6f8ca49d1aeede665b950d0c148e kernel/cpu.c: eliminate cpu_*_mask

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
