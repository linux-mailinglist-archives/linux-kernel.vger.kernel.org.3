Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEE4D6B48
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 01:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCLAIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 19:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCLAID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:08:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54C14089
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647043619; x=1678579619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uP2bQMi7foToz6URoboXiSv1BaDOD/4DPEY+RqnK/qc=;
  b=bdbfFaspXdue9aXWVoSeEduUoDKi9CSvaftdg83Rj+hezLz0XsxvlELH
   56XUZOa0LJ4UbgkKUimNhLq6bLiTnEstDQF9UKfSNQeByX11oL8IT/VHO
   cJmLGu29G/AKb5o8IW/lLpvD5Y71bEDounCMd4XU+ADofguL1Ybmw+3O3
   1lj2sAHD9vrfOHeWLKSXZUO5gTK5C/N4qeKg+1nL42gBgjX823insNg6s
   zHm2xrl+STzm/A5dMPYe2dgEbXXm2B/pWkni2zgr82b5eq5PgtvQbAJUR
   lxww5QFzqLK8opLzXhqw1stIlkbroTCHpskGgPmUcPGfPgEERt44925Mp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="342104585"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="342104585"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 16:06:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="511546906"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2022 16:06:57 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSpHc-0007J4-Tu; Sat, 12 Mar 2022 00:06:56 +0000
Date:   Sat, 12 Mar 2022 08:06:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: src/utils.c:6:10: fatal error: proc/readproc.h: No such file or
 directory
Message-ID: <202203120738.FgJwp7oP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: e9380df851878cee71df5a1c7611584421527f7e ACPI: Add stubs for wakeup handler functions
date:   4 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220312/202203120738.FgJwp7oP-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9380df851878cee71df5a1c7611584421527f7e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e9380df851878cee71df5a1c7611584421527f7e
        # save the config file to linux build tree
        make W=1 ARCH=x86_64 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> src/utils.c:6:10: fatal error: proc/readproc.h: No such file or directory
       6 | #include <proc/readproc.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[4]: *** [<builtin>: src/utils.o] Error 1
   make[4]: *** Waiting for unfinished jobs....
   src/osnoise.c: In function 'osnoise_init_trace_tool':
   src/osnoise.c:805:11: warning: implicit declaration of function 'tracefs_event_enable'; did you mean 'tracefs_event_systems'? [-Wimplicit-function-declaration]
     805 |  retval = tracefs_event_enable(trace->trace.inst, "osnoise", NULL);
         |           ^~~~~~~~~~~~~~~~~~~~
         |           tracefs_event_systems
   src/trace.c: In function 'enable_tracer_by_name':
   src/trace.c:18:23: error: storage size of 'tracer' isn't known
      18 |  enum tracefs_tracers tracer;
         |                       ^~~~~~
   src/trace.c:21:11: error: 'TRACEFS_TRACER_CUSTOM' undeclared (first use in this function)
      21 |  tracer = TRACEFS_TRACER_CUSTOM;
         |           ^~~~~~~~~~~~~~~~~~~~~
   src/trace.c:21:11: note: each undeclared identifier is reported only once for each function it appears in
   src/trace.c:25:11: warning: implicit declaration of function 'tracefs_tracer_set'; did you mean 'tracefs_tracers'? [-Wimplicit-function-declaration]
      25 |  retval = tracefs_tracer_set(inst, tracer, tracer_name);
         |           ^~~~~~~~~~~~~~~~~~
         |           tracefs_tracers
   src/trace.c:18:23: warning: unused variable 'tracer' [-Wunused-variable]
      18 |  enum tracefs_tracers tracer;
         |                       ^~~~~~
   src/trace.c: In function 'disable_tracer':
   src/trace.c:42:7: error: variable 't' has initializer but incomplete type
      42 |  enum tracefs_tracers t = TRACEFS_TRACER_NOP;
         |       ^~~~~~~~~~~~~~~
   src/trace.c:42:27: error: 'TRACEFS_TRACER_NOP' undeclared (first use in this function)
      42 |  enum tracefs_tracers t = TRACEFS_TRACER_NOP;
         |                           ^~~~~~~~~~~~~~~~~~
   src/trace.c:42:23: error: storage size of 't' isn't known
      42 |  enum tracefs_tracers t = TRACEFS_TRACER_NOP;
         |                       ^
   src/trace.c:42:23: warning: unused variable 't' [-Wunused-variable]
   src/osnoise_hist.c: In function 'osnoise_destroy_trace_hist':
   src/osnoise_hist.c:151:2: warning: implicit declaration of function 'tracefs_hist_pause'; did you mean 'tracefs_list_free'? [-Wimplicit-function-declaration]
     151 |  tracefs_hist_pause(tool->trace.inst, data->trace_hist);
         |  ^~~~~~~~~~~~~~~~~~
         |  tracefs_list_free
   src/trace.c: In function 'save_trace_to_file':
   src/trace.c:78:10: warning: implicit declaration of function 'tracefs_instance_file_open'; did you mean 'tracefs_instance_file_read'? [-Wimplicit-function-declaration]
      78 |  in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |          tracefs_instance_file_read
   src/osnoise_hist.c:152:2: warning: implicit declaration of function 'tracefs_hist_destroy'; did you mean 'tracefs_instance_destroy'? [-Wimplicit-function-declaration]
     152 |  tracefs_hist_destroy(tool->trace.inst, data->trace_hist);
         |  ^~~~~~~~~~~~~~~~~~~~
         |  tracefs_instance_destroy
   src/trace.c:78:49: error: 'O_RDONLY' undeclared (first use in this function)
      78 |  in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
         |                                                 ^~~~~~~~
   src/osnoise_hist.c: In function 'osnoise_init_trace_hist':
   src/osnoise_hist.c:172:21: warning: implicit declaration of function 'tracefs_hist_alloc'; did you mean 'tracefs_get_clock'? [-Wimplicit-function-declaration]
     172 |  data->trace_hist = tracefs_hist_alloc(tool->trace.tep, "osnoise", "sample_threshold",
         |                     ^~~~~~~~~~~~~~~~~~
         |                     tracefs_get_clock
   src/trace.c:84:11: warning: implicit declaration of function 'creat' [-Wimplicit-function-declaration]
      84 |  out_fd = creat(filename, mode);
         |           ^~~~~
   src/trace.c: In function 'trace_instance_init':
   src/trace.c:177:2: warning: implicit declaration of function 'tracefs_trace_off'; did you mean 'tracefs_tracers'? [-Wimplicit-function-declaration]
     177 |  tracefs_trace_off(trace->inst);
         |  ^~~~~~~~~~~~~~~~~
         |  tracefs_tracers
   src/trace.c: In function 'trace_instance_start':
   src/trace.c:191:9: warning: implicit declaration of function 'tracefs_trace_on'; did you mean 'tracefs_tracers'? [-Wimplicit-function-declaration]
     191 |  return tracefs_trace_on(trace->inst);
         |         ^~~~~~~~~~~~~~~~
         |         tracefs_tracers
   src/osnoise_hist.c:173:10: error: 'TRACEFS_HIST_KEY_NORMAL' undeclared (first use in this function)
     173 |    buff, TRACEFS_HIST_KEY_NORMAL);
         |          ^~~~~~~~~~~~~~~~~~~~~~~
   src/osnoise_hist.c:173:10: note: each undeclared identifier is reported only once for each function it appears in
   src/osnoise_hist.c:177:11: warning: implicit declaration of function 'tracefs_hist_add_key'; did you mean 'tracefs_list_free'? [-Wimplicit-function-declaration]
     177 |  retval = tracefs_hist_add_key(data->trace_hist, "cpu", 0);
         |           ^~~~~~~~~~~~~~~~~~~~
         |           tracefs_list_free
   make[4]: *** [<builtin>: src/trace.o] Error 1
   src/osnoise_hist.c:181:11: warning: implicit declaration of function 'tracefs_hist_start'; did you mean 'tracefs_list_free'? [-Wimplicit-function-declaration]
     181 |  retval = tracefs_hist_start(tool->trace.inst, data->trace_hist);
         |           ^~~~~~~~~~~~~~~~~~
         |           tracefs_list_free
   src/osnoise_hist.c: In function 'osnoise_read_trace_hist':
   src/osnoise_hist.c:203:12: warning: implicit declaration of function 'tracefs_event_file_read'; did you mean 'tracefs_instance_file_read'? [-Wimplicit-function-declaration]
     203 |  content = tracefs_event_file_read(tool->trace.inst, "osnoise",
         |            ^~~~~~~~~~~~~~~~~~~~~~~
         |            tracefs_instance_file_read
   src/osnoise_hist.c:203:10: warning: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     203 |  content = tracefs_event_file_read(tool->trace.inst, "osnoise",
         |          ^
   src/timerlat_hist.c: In function 'timerlat_hist_main':
   src/timerlat_hist.c:798:8: warning: implicit declaration of function 'tracefs_trace_is_on'; did you mean 'tracefs_tracers'? [-Wimplicit-function-declaration]
     798 |   if (!tracefs_trace_is_on(trace->inst))
         |        ^~~~~~~~~~~~~~~~~~~
         |        tracefs_tracers
   src/osnoise_hist.c: In function 'osnoise_hist_main':
   src/osnoise_hist.c:774:8: warning: implicit declaration of function 'tracefs_trace_is_on'; did you mean 'tracefs_tracers'? [-Wimplicit-function-declaration]
     774 |   if (!tracefs_trace_is_on(trace->inst))

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
