Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305434FFDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiDMSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiDMSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:19:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514614DF62
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649873840; x=1681409840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zoiqkI45OBXfZ+KneNUP3/NBmBFmzCfXcCxT+9CZjWY=;
  b=Kh/26PmuAKJNt4wxmHGX9BefwgMTP2oCah+RDLA/Np4g5Fdt3aeOSbtx
   i5jQzL6jEeW6ULJP3XInqhwfB3MijVl86TTPzJ2+ud3Qm+I4e7JASHWeZ
   7AQ4tRXm2YcrHGXGMTETLVVp/lyfN3LKhRrm4c2839iY/y3UMEbzEdTLg
   ZWscnMEQdDqI1JGMwCzyqdd48xXoMdJMlXXs/OS4SaNiWai0VSjeLB2sD
   V6mog1mU75rlF+p+96ym23ufxlcatDgdNT0KREeuE2vGg+PjWzRRxbVWX
   aFcvpDvay4SOfnEsaMy+3kejc6IoJzmpFl1WdlGyR2miUERQwsj73gQQe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="287773014"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="287773014"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="645270075"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2022 11:17:19 -0700
Received: from [10.212.225.84] (kliang2-MOBL.ccr.corp.intel.com [10.212.225.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 962F25805BD;
        Wed, 13 Apr 2022 11:17:17 -0700 (PDT)
Message-ID: <74d36e66-5b16-ee10-bcae-171e2b681845@linux.intel.com>
Date:   Wed, 13 Apr 2022 14:17:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [LKP] Re: [perf vendor events] 3f5f0df7bf:
 perf-sanity-tests.perf_all_metrics_test.fail
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Carel Si <beibei.si@intel.com>, acme@redhat.com,
        alexander.shishkin@linux.intel.com, alexandre.torgue@foss.st.com,
        ak@linux.intel.com, mingo@redhat.com, james.clark@arm.com,
        jolsa@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, namhyung@kernel.org,
        peterz@infradead.org, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@lists.01.org,
        lkp@intel.com
References: <20220304083329.GC20556@xsang-OptiPlex-9020>
 <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
 <20220413070529.GA1320@linux.intel.com>
 <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
 <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com>
 <CAP-5=fXj+WT3ExNo-fL4d9b_Wm5swnKaCWd67rU85Q=QFg5KUw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXj+WT3ExNo-fL4d9b_Wm5swnKaCWd67rU85Q=QFg5KUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 1:09 PM, Ian Rogers wrote:
> On Wed, Apr 13, 2022 at 9:37 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 4/13/2022 12:03 PM, Ian Rogers wrote:
>>> 3) Weak group doesn't fall back to no group:
>>
>> That's because the group validation code doesn't take pinned events,
>> such as the NMI watchdog, into account.
>>
>> I proposed a kernel patch to fix it, but it's rejected. It should be
>> hard to find a generic way to fix it from the kernel side.
>> https://lore.kernel.org/lkml/1565977750-76693-1-git-send-email-kan.liang@linux.intel.com/
>>
>> Maybe we can workaround it from the perf tool side?
>> For example, for each weak group with cycles event and NMI watchdog is
>> enabled, add an extra cycles event when opening the group. If the open
>> fails with the extra cycles event, fall back to no group. After the
>> extra cycles event check, remove the extra cycles.
>>
>> What do you think?
> 
> Thanks Kan, it is a shame the kernel support is lacking here. I'm not
> sure what you are proposing for the perf tool to do. So:
> 
>> for each weak group with cycles event and NMI watchdog
> 
> Okay, let's try Branching_Overhead as mentioned in this report - but
> the event is CPU_CLK_UNHALTED.THREAD here :-/
> 
>> add an extra cycles event when opening the group
> 
> So the perf_event_open doesn't fail here for me:
> $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD},cycles'
> -a sleep 1
> 

No, I mean modifying the perf tool code and add an extra cycles in the 
weak group.

Here is a very initial POC patch, which should prove the idea.

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b7fe88beb584..782c3d7f1b32 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -71,7 +71,9 @@
  #include "util/bpf_counter.h"
  #include "util/iostat.h"
  #include "util/pmu-hybrid.h"
+#include "util/util.h"
  #include "asm/bug.h"
+#include "perf-sys.h"

  #include <linux/time64.h>
  #include <linux/zalloc.h>
@@ -777,6 +779,8 @@ static enum counter_recovery 
stat_handle_error(struct evsel *counter)
  	return COUNTER_FATAL;
  }

+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+
  static int __run_perf_stat(int argc, const char **argv, int run_idx)
  {
  	int interval = stat_config.interval;
@@ -793,6 +797,7 @@ static int __run_perf_stat(int argc, const char 
**argv, int run_idx)
  	struct affinity saved_affinity, *affinity = NULL;
  	int err;
  	bool second_pass = false;
+	bool has_cycles = false;

  	if (forks) {
  		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe, 
workload_exec_failed_signal) < 0) {
@@ -821,6 +826,8 @@ static int __run_perf_stat(int argc, const char 
**argv, int run_idx)
  	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
  		counter = evlist_cpu_itr.evsel;

+		if (counter->core.attr.config == 0x3c)
+			has_cycles = true;
  		/*
  		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
  		 * no need to call it again here.
@@ -867,6 +874,24 @@ static int __run_perf_stat(int argc, const char 
**argv, int run_idx)
  		counter->supported = true;
  	}

+	//make it model specific. need to move to a better place
+	if (counter->supported && !second_pass && has_cycles && 
counter->weak_group && sysctl__nmi_watchdog_enabled()) {
+		struct evsel *leader = evsel__leader(counter);
+		int group_fd = FD(leader, 0, 0);
+		struct evsel *evsel;
+		int fd;
+
+		evsel = evsel__new_cycles(0, PERF_TYPE_HARDWARE, 
PERF_COUNT_HW_CPU_CYCLES);
+		fd = sys_perf_event_open(&evsel->core.attr, -1, 0, group_fd, 0x8);
+
+		if (fd < 0) {
+			evlist__reset_weak_group(evsel_list, counter, false);
+			second_pass = true;
+		} else {
+			evsel__close(evsel);
+		}
+	}
+
  	if (second_pass) {
  		/*
  		 * Now redo all the weak group after closing them,

With the above patch,

$ sudo ./perf stat -e 
'{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD}:W' 
-C0 sleep 1

  Performance counter stats for 'CPU(s) 0':

            913,369      BR_INST_RETIRED.NEAR_CALL 
                       (79.95%)
          3,648,433      BR_INST_RETIRED.NEAR_TAKEN 
                       (80.00%)
          2,481,976      BR_INST_RETIRED.NOT_TAKEN 
                       (80.05%)
          3,696,298      BR_INST_RETIRED.CONDITIONAL 
                       (80.04%)
         27,792,053      CPU_CLK_UNHALTED.THREAD 
                       (79.96%)

        1.002224709 seconds time elapsed


Thanks,
Kan
