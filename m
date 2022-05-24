Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B480153205F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 03:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiEXBt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 21:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiEXBtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 21:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1C73792;
        Mon, 23 May 2022 18:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F387A615E9;
        Tue, 24 May 2022 01:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252E1C385A9;
        Tue, 24 May 2022 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653356988;
        bh=yYqlChNC7wSW48U/tmrDGTdB7v6edpb0+ug+TbgomIU=;
        h=From:To:Cc:Subject:Date:From;
        b=Gd00FXP2eQa0iqfguNAcFFMLJ0y78io1iZxAOI6LDgW4Inc+zUfBxIAIB7ZFRiQdC
         LibqLRhyTdsLpDu8YbhLVaIYiW/4Yp2QscdeHo4GFG261IYbChJTO69k4mwuRB9mxG
         Uid6AMuSqEG8xvZG2xGMWb7vkf+o+cfl2dCyqBvL1xWQhOHgoi11DKiBZXGQbAeLMh
         Q3rphuPTc28bbhUfsRmANJvtm1NwNDAg9CcWx1yD+mPr3xnrqzBUU4IJ10zfTdFqDX
         j6+zI5S0VdMdlv1l7zo/Qf8vvHawxbEJOaKUSq1hKDdxhvGqwDSbD5nkPDpxxv4nEq
         d+99wv7mijuuA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.19: 1st batch
Date:   Mon, 23 May 2022 22:49:38 -0300
Message-Id: <20220524014938.46153-1-acme@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.19-2022-05-23

for you to fetch changes up to 5d2b6bc3a6a27ad265d2ec0d53dd7ef33bd314fc:

  perf intel-pt: Add guest_code support (2022-05-23 10:19:24 -0300)

----------------------------------------------------------------
perf tools changes for v5.19: 1st batch

Intel PT:

- Allow hardware tracing on KVM test programs.  In this case, the VM is not
  running an OS, but only the functions loaded into it by the hypervisor test
  program, and conveniently, loaded at the same virtual addresses.

- Improve documentation:

  - Add link to perf wiki's page.

- Cleanups

  - Delete now unusdd perf-with-kcore.sh script.

  - Remove unused machines__find_host().

ARM SPE (Statistical Profile Extensions):

  - Add man page entry.

Vendor Events:

  - Update various Intel event topics.

  - Update various microarch events.

  - Fix various cstate metrics.

  - Fix Alderlake metric groups.

  - Add sapphirerapids events.

  - Add JSON files for ARM Cortex A34, A35, A55, A510, A65, A73, A75, A77, A78,
    A710, X1, X2 and Neoverse E1.

  - Update Cortex A57/A72.

perf stat:

  - Introduce stats for the user and system rusage times.

perf c2c:

  - Prep work to support ARM systems.

perf annotate:

  - Add --percent-limit option

perf lock:

  - Add -t/--thread option for report.

  - Do not discard broken lock stats.

perf bench:

  Add breakpoint benchmarks.

perf test:

  - Limit to only run executable scripts in tests.

  - Add basic perf record tests.

  - Add stat record+report test.

  - Add basic stat and topdown group test.

  - Skip several tests when the user hasn't permission to perform them.

  - Fix test case 81 ("perf record tests") on s390x.

perf version:

  - debuginfod support improvements.

perf scripting python:

  - Expose symbol offset and source information.

perf build:

  - Error for BPF skeletons without LIBBPF.

  - Use Python devtools for version autodetection rather than runtime.

Miscellaneous:

  - Add riscv64 support to 'perf jitdump'.

  - Various fixes/tidy ups related to cpu_map.

  - Fixes for handling Intel hybrid systems.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (26):
      libperf evsel: Factor out perf_evsel__ioctl()
      perf intel-pt: Add link to the perf wiki's Intel PT page
      perf tools: Delete perf-with-kcore.sh script
      libperf evsel: Add perf_evsel__enable_thread()
      perf evlist: Use libperf functions in evlist__enable_event_idx()
      perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
      perf auxtrace: Do not mix up mmap idx
      libperf evlist: Remove ->idx() per_cpu parameter
      libperf evlist: Move ->idx() into mmap_per_evsel()
      libperf evlist: Add evsel as a parameter to ->idx()
      perf auxtrace: Record whether an auxtrace mmap is needed
      perf tools: Remove unused machines__find_host()
      perf intel-pt: Add support for emulated ptwrite
      perf script: Print Intel ptwrite value as a string if it is ASCII
      perf scripts python: intel-pt-events.py: Print ptwrite value as a string if it is ASCII
      perf header: Add ability to keep feature sections
      libperf: Add preadn()
      perf inject: Keep some features sections from input file
      perf data: Add has_kcore_dir()
      perf inject: Keep a copy of kcore_dir
      perf tools: Add machine to machines back pointer
      perf tools: Factor out thread__set_guest_comm()
      perf tools: Add guest_code support
      perf script: Add guest_code support
      perf kvm report: Add guest_code support
      perf intel-pt: Add guest_code support

Arnaldo Carvalho de Melo (6):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf bench breakpoint: Fix build on 32-bit arches
      Merge remote-tracking branch 'torvalds/master' into perf/core

Carsten Haitzler (1):
      perf test: Shell - Limit to only run executable scripts in tests

Dmitry Vyukov (1):
      perf bench: Add breakpoint benchmarks

Eelco Chaudron (1):
      perf scripting python: Expose symbol offset and source information

Eric Lin (1):
      perf jitdump: Add riscv64 support

Florian Fischer (3):
      perf stat: Introduce stats for the user and system rusage times
      perf stat: Add user_time and system_time events
      perf list: Print all available tool events

Ian Rogers (50):
      perf test: Add basic perf record tests
      perf vendor events intel: Fix icelake cstate metrics
      perf vendor events intel: Fix icelakex cstate metrics
      perf vendor events intel: Add sapphirerapids events
      perf vendor events intel: Update CLX uncore to v1.14
      perf vendor events intel: Update SKX uncore
      perf vendor events intel: Update nehalemep event topics
      perf vendor events intel: Update tigerlake topic
      perf vendor events intel: Update tremontx uncore and topics
      perf vendor events intel: Update westmereep-dp event topics
      perf vendor events intel: Update westmereep-sp event topics
      perf vendor events intel: Update westmereex event topics
      perf vendor events intel: Update elkhartlake event topics
      perf vendor events intel: Update goldmontplus event topics
      perf vendor events intel: Update goldmont event topics
      perf vendor events intel: Update ICL events to v1.13
      perf vendor events intel: Update IVT events to v21
      perf vendor events intel: Update SKL events to v53
      perf vendor events intel: Update SKX events to v1.27
      perf vendor events intel: Update WSM-EP-SP events to v3
      perf vendor events intel: Update WSM-EX events to v3
      perf stat: Avoid printing cpus with no counters
      perf vendor events intel: Update CLX events to v1.15
      perf cpumap: Switch to using perf_cpu_map API
      perf evlist: Clear all_cpus before propagating
      perf test: Add skip to --per-thread test
      Revert "perf stat: Support metrics with hybrid events"
      perf evsel: Constify a few arrays
      perf evsel: Add tool event helpers
      perf metrics: Support all tool events
      perf metrics: Don't add all tool events for sharing
      perf evlist: Keep topdown counters in weak group
      perf test: Add basic stat and topdown group test
      perf build: Error for BPF skeletons without LIBBPF
      perf stat: Add stat record+report test
      perf cpumap: Add perf_cpu_map__for_each_idx()
      perf bpf_counter: Tidy use of CPU map index
      perf stat: Make use of index clearer with perf_counts
      perf test: Skip reason for suites with 1 test
      perf test: Use skip in vmlinux kallsyms
      perf test: Use skip in openat syscall
      perf test: Basic mmap use skip
      perf test: Parse events tidy terms_test
      perf test: Parse events tidy evlist_test
      perf test: Parse events break apart tests
      perf test: Use skip in PERF_RECORD_*
      perf jevents: Append PMU description later
      perf vendor events: Fix Alderlake metric groups
      perf vendor events: Fix Ivytown UNC_M_ACT_COUNT.RD umask
      perf jevents: Modify match field

James Clark (2):
      perf docs: Add man page entry for Arm SPE
      perf tools: Use Python devtools for version autodetection rather than runtime

Jiri Olsa (1):
      perf tools: Move libbpf init in libbpf_init function

Kan Liang (4):
      perf evsel: Fixes topdown events in a weak group for the hybrid platform
      perf stat: Always keep perf metrics topdown events in a group
      perf parse-events: Support different format of the topdown event name
      perf parse-events: Move slots event for the hybrid platform too

Leo Yan (4):
      perf mem: Print memory operation type
      perf mem: Add stats for store operation with no available memory level
      perf c2c: Add dimensions for 'N/A' metrics of store operation
      perf c2c: Update documentation for store metric 'N/A'

Martin Liška (2):
      perf version: Add HAVE_DEBUGINFOD_SUPPORT to built-in features
      perf tools: Print warning when HAVE_DEBUGINFOD_SUPPORT is not set and user tries to use debuginfod support

Namhyung Kim (3):
      perf annotate: Add --percent-limit option
      perf lock: Do not discard broken lock stats
      perf lock: Add -t/--thread option for report

Nick Forrington (14):
      perf vendors events arm64: Arm Cortex-A34
      perf vendors events arm64: Arm Cortex-A35
      perf vendors events arm64: Arm Cortex-A55
      perf vendors events arm64: Arm Cortex-A510
      perf vendors events arm64: Arm Cortex-A65
      perf vendors events arm64: Arm Cortex-A73
      perf vendors events arm64: Arm Cortex-A75
      perf vendors events arm64: Arm Cortex-A77
      perf vendors events arm64: Arm Cortex-A78
      perf vendors events arm64: Arm Cortex-A710
      perf vendors events arm64: Arm Cortex-X1
      perf vendors events arm64: Arm Cortex-X2
      perf vendors events arm64: Arm Neoverse E1
      perf vendors events arm64: Update Cortex A57/A72

Thomas Richter (1):
      perf test: Fix test case 81 ("perf record tests") on s390x

Yang Jihong (1):
      perf tools: Add missing headers needed by util/data.h

Zhengjun Xing (6):
      perf vendor events intel: Add metrics for Alderlake
      perf stat: Support metrics with hybrid events
      perf stat: Merge event counts from all hybrid PMUs
      perf stat: Support hybrid --topdown option
      perf vendor events intel: Update core event list for Sapphirerapids
      perf vendor events intel: Add uncore event list for Sapphirerapids

 tools/lib/perf/evlist.c                            |   13 +-
 tools/lib/perf/evsel.c                             |   34 +-
 tools/lib/perf/include/internal/evlist.h           |    3 +-
 tools/lib/perf/include/internal/lib.h              |    2 +
 tools/lib/perf/include/perf/cpumap.h               |    3 +
 tools/lib/perf/include/perf/evsel.h                |    1 +
 tools/lib/perf/lib.c                               |   20 +
 tools/perf/.gitignore                              |    1 -
 tools/perf/Documentation/perf-annotate.txt         |    5 +
 tools/perf/Documentation/perf-arm-spe.txt          |  218 +
 tools/perf/Documentation/perf-c2c.txt              |    8 +-
 tools/perf/Documentation/perf-intel-pt.txt         |  165 +
 tools/perf/Documentation/perf-kvm.txt              |    3 +
 tools/perf/Documentation/perf-lock.txt             |   21 +
 tools/perf/Documentation/perf-script.txt           |    4 +
 tools/perf/Documentation/perf-stat.txt             |   10 +
 tools/perf/Documentation/perf.txt                  |    2 +-
 tools/perf/Makefile.config                         |   42 +-
 tools/perf/Makefile.perf                           |    5 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    1 +
 tools/perf/arch/arm64/util/arm-spe.c               |    1 +
 tools/perf/arch/riscv/Makefile                     |    1 +
 tools/perf/arch/s390/util/auxtrace.c               |    1 +
 tools/perf/arch/x86/util/evlist.c                  |    7 +-
 tools/perf/arch/x86/util/evsel.c                   |   31 +
 tools/perf/arch/x86/util/intel-bts.c               |    1 +
 tools/perf/arch/x86/util/intel-pt.c                |    1 +
 tools/perf/arch/x86/util/topdown.c                 |   25 +
 tools/perf/arch/x86/util/topdown.h                 |    7 +
 tools/perf/bench/Build                             |    1 +
 tools/perf/bench/bench.h                           |    2 +
 tools/perf/bench/breakpoint.c                      |  244 +
 tools/perf/builtin-annotate.c                      |   24 +
 tools/perf/builtin-bench.c                         |    8 +
 tools/perf/builtin-c2c.c                           |   80 +-
 tools/perf/builtin-inject.c                        |  162 +-
 tools/perf/builtin-kvm.c                           |    2 +
 tools/perf/builtin-lock.c                          |   92 +-
 tools/perf/builtin-record.c                        |   13 +-
 tools/perf/builtin-script.c                        |   37 +-
 tools/perf/builtin-stat.c                          |   71 +-
 tools/perf/builtin-version.c                       |    1 +
 tools/perf/perf-with-kcore.sh                      |  247 -
 .../arch/arm64/arm/cortex-a34/branch.json          |   11 +
 .../pmu-events/arch/arm64/arm/cortex-a34/bus.json  |   17 +
 .../arch/arm64/arm/cortex-a34/cache.json           |   32 +
 .../arch/arm64/arm/cortex-a34/exception.json       |   14 +
 .../arch/arm64/arm/cortex-a34/instruction.json     |   29 +
 .../arch/arm64/arm/cortex-a34/memory.json          |    8 +
 .../arch/arm64/arm/cortex-a35/branch.json          |   11 +
 .../pmu-events/arch/arm64/arm/cortex-a35/bus.json  |   17 +
 .../arch/arm64/arm/cortex-a35/cache.json           |   32 +
 .../arch/arm64/arm/cortex-a35/exception.json       |   14 +
 .../arch/arm64/arm/cortex-a35/instruction.json     |   44 +
 .../arch/arm64/arm/cortex-a35/memory.json          |    8 +
 .../arch/arm64/arm/cortex-a510/branch.json         |   59 +
 .../pmu-events/arch/arm64/arm/cortex-a510/bus.json |   17 +
 .../arch/arm64/arm/cortex-a510/cache.json          |  182 +
 .../arch/arm64/arm/cortex-a510/exception.json      |   14 +
 .../arch/arm64/arm/cortex-a510/instruction.json    |   95 +
 .../arch/arm64/arm/cortex-a510/memory.json         |   32 +
 .../arch/arm64/arm/cortex-a510/pipeline.json       |  107 +
 .../pmu-events/arch/arm64/arm/cortex-a510/pmu.json |    8 +
 .../arch/arm64/arm/cortex-a510/trace.json          |   32 +
 .../arch/arm64/arm/cortex-a55/branch.json          |   59 +
 .../pmu-events/arch/arm64/arm/cortex-a55/bus.json  |   17 +
 .../arch/arm64/arm/cortex-a55/cache.json           |  188 +
 .../arch/arm64/arm/cortex-a55/exception.json       |   20 +
 .../arch/arm64/arm/cortex-a55/instruction.json     |   65 +
 .../arch/arm64/arm/cortex-a55/memory.json          |   17 +
 .../arch/arm64/arm/cortex-a55/pipeline.json        |   80 +
 .../arch/arm64/arm/cortex-a57-a72/branch.json      |   17 +
 .../arch/arm64/arm/cortex-a57-a72/bus.json         |   29 +
 .../arch/arm64/arm/cortex-a57-a72/cache.json       |   80 +
 .../arm64/arm/cortex-a57-a72/core-imp-def.json     |  179 -
 .../arch/arm64/arm/cortex-a57-a72/exception.json   |   47 +
 .../arch/arm64/arm/cortex-a57-a72/instruction.json |   68 +
 .../arch/arm64/arm/cortex-a57-a72/memory.json      |   20 +
 .../arch/arm64/arm/cortex-a65/branch.json          |   17 +
 .../pmu-events/arch/arm64/arm/cortex-a65/bus.json  |   17 +
 .../arch/arm64/arm/cortex-a65/cache.json           |  236 +
 .../pmu-events/arch/arm64/arm/cortex-a65/dpu.json  |   32 +
 .../arch/arm64/arm/cortex-a65/exception.json       |   14 +
 .../pmu-events/arch/arm64/arm/cortex-a65/ifu.json  |  122 +
 .../arch/arm64/arm/cortex-a65/instruction.json     |   71 +
 .../arch/arm64/arm/cortex-a65/memory.json          |   35 +
 .../arch/arm64/arm/cortex-a65/pipeline.json        |    8 +
 .../arch/arm64/arm/cortex-a710/branch.json         |   17 +
 .../pmu-events/arch/arm64/arm/cortex-a710/bus.json |   20 +
 .../arch/arm64/arm/cortex-a710/cache.json          |  155 +
 .../arch/arm64/arm/cortex-a710/exception.json      |   47 +
 .../arch/arm64/arm/cortex-a710/instruction.json    |  134 +
 .../arch/arm64/arm/cortex-a710/memory.json         |   41 +
 .../arch/arm64/arm/cortex-a710/pipeline.json       |   23 +
 .../arch/arm64/arm/cortex-a710/trace.json          |   29 +
 .../arch/arm64/arm/cortex-a73/branch.json          |   11 +
 .../pmu-events/arch/arm64/arm/cortex-a73/bus.json  |   23 +
 .../arch/arm64/arm/cortex-a73/cache.json           |  107 +
 .../pmu-events/arch/arm64/arm/cortex-a73/etm.json  |   14 +
 .../arch/arm64/arm/cortex-a73/exception.json       |   14 +
 .../arch/arm64/arm/cortex-a73/instruction.json     |   65 +
 .../arch/arm64/arm/cortex-a73/memory.json          |   14 +
 .../pmu-events/arch/arm64/arm/cortex-a73/mmu.json  |   44 +
 .../arch/arm64/arm/cortex-a73/pipeline.json        |   38 +
 .../arch/arm64/arm/cortex-a75/branch.json          |   11 +
 .../pmu-events/arch/arm64/arm/cortex-a75/bus.json  |   17 +
 .../arch/arm64/arm/cortex-a75/cache.json           |  164 +
 .../pmu-events/arch/arm64/arm/cortex-a75/etm.json  |   14 +
 .../arch/arm64/arm/cortex-a75/exception.json       |   17 +
 .../arch/arm64/arm/cortex-a75/instruction.json     |   74 +
 .../arch/arm64/arm/cortex-a75/memory.json          |   17 +
 .../pmu-events/arch/arm64/arm/cortex-a75/mmu.json  |   44 +
 .../arch/arm64/arm/cortex-a75/pipeline.json        |   44 +
 .../arch/arm64/arm/cortex-a77/branch.json          |   17 +
 .../pmu-events/arch/arm64/arm/cortex-a77/bus.json  |   17 +
 .../arch/arm64/arm/cortex-a77/cache.json           |  143 +
 .../arch/arm64/arm/cortex-a77/exception.json       |   47 +
 .../arch/arm64/arm/cortex-a77/instruction.json     |   77 +
 .../arch/arm64/arm/cortex-a77/memory.json          |   23 +
 .../arch/arm64/arm/cortex-a77/pipeline.json        |    8 +
 .../arch/arm64/arm/cortex-a78/branch.json          |   17 +
 .../pmu-events/arch/arm64/arm/cortex-a78/bus.json  |   20 +
 .../arch/arm64/arm/cortex-a78/cache.json           |  155 +
 .../arch/arm64/arm/cortex-a78/exception.json       |   47 +
 .../arch/arm64/arm/cortex-a78/instruction.json     |   80 +
 .../arch/arm64/arm/cortex-a78/memory.json          |   23 +
 .../arch/arm64/arm/cortex-a78/pipeline.json        |   23 +
 .../arch/arm64/arm/cortex-x1/branch.json           |   17 +
 .../pmu-events/arch/arm64/arm/cortex-x1/bus.json   |   20 +
 .../pmu-events/arch/arm64/arm/cortex-x1/cache.json |  155 +
 .../arch/arm64/arm/cortex-x1/exception.json        |   47 +
 .../arch/arm64/arm/cortex-x1/instruction.json      |   80 +
 .../arch/arm64/arm/cortex-x1/memory.json           |   23 +
 .../arch/arm64/arm/cortex-x1/pipeline.json         |   23 +
 .../arch/arm64/arm/cortex-x2/branch.json           |   17 +
 .../pmu-events/arch/arm64/arm/cortex-x2/bus.json   |   20 +
 .../pmu-events/arch/arm64/arm/cortex-x2/cache.json |  155 +
 .../arch/arm64/arm/cortex-x2/exception.json        |   47 +
 .../arch/arm64/arm/cortex-x2/instruction.json      |  134 +
 .../arch/arm64/arm/cortex-x2/memory.json           |   41 +
 .../arch/arm64/arm/cortex-x2/pipeline.json         |   23 +
 .../pmu-events/arch/arm64/arm/cortex-x2/trace.json |   29 +
 .../arch/arm64/arm/neoverse-e1/branch.json         |   17 +
 .../pmu-events/arch/arm64/arm/neoverse-e1/bus.json |   17 +
 .../arch/arm64/arm/neoverse-e1/cache.json          |  107 +
 .../arch/arm64/arm/neoverse-e1/exception.json      |   14 +
 .../arch/arm64/arm/neoverse-e1/instruction.json    |   65 +
 .../arch/arm64/arm/neoverse-e1/memory.json         |   23 +
 .../arch/arm64/arm/neoverse-e1/pipeline.json       |    8 +
 .../pmu-events/arch/arm64/arm/neoverse-e1/spe.json |   14 +
 .../arch/arm64/common-and-microarch.json           |   66 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   13 +
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  729 +++
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 1164 +----
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  702 +--
 .../pmu-events/arch/x86/cascadelakex/other.json    |  156 +-
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   14 +-
 .../arch/x86/cascadelakex/uncore-memory.json       |   61 +
 .../arch/x86/cascadelakex/uncore-other.json        |   96 +-
 .../pmu-events/arch/x86/elkhartlake/other.json     |   13 +-
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   13 +-
 tools/perf/pmu-events/arch/x86/goldmont/other.json |   31 +-
 .../pmu-events/arch/x86/goldmont/pipeline.json     |   31 +-
 .../pmu-events/arch/x86/goldmontplus/other.json    |   37 +-
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |   37 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |   41 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   36 +-
 tools/perf/pmu-events/arch/x86/icelake/memory.json |   10 +-
 tools/perf/pmu-events/arch/x86/icelake/other.json  |   38 +-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |   26 +-
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |   31 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   24 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |   21 +-
 tools/perf/pmu-events/arch/x86/icelakex/other.json |   70 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |   14 +-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |    4 +-
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |    3 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    1 +
 .../perf/pmu-events/arch/x86/nehalemep/other.json  |   66 +-
 .../pmu-events/arch/x86/nehalemep/pipeline.json    |   66 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  | 1083 ++++
 .../arch/x86/sapphirerapids/floating-point.json    |  218 +
 .../arch/x86/sapphirerapids/frontend.json          |  471 ++
 .../pmu-events/arch/x86/sapphirerapids/memory.json |  415 ++
 .../pmu-events/arch/x86/sapphirerapids/other.json  |  362 ++
 .../arch/x86/sapphirerapids/pipeline.json          | 1283 +++++
 .../arch/x86/sapphirerapids/uncore-memory.json     |  499 ++
 .../arch/x86/sapphirerapids/uncore-other.json      | 5150 ++++++++++++++++++++
 .../arch/x86/sapphirerapids/uncore-power.json      |   12 +
 .../arch/x86/sapphirerapids/virtual-memory.json    |  225 +
 tools/perf/pmu-events/arch/x86/skylake/cache.json  |  174 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json |   90 +-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |   14 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |   74 +-
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |   74 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   14 +-
 .../arch/x86/skylakex/uncore-memory.json           |   20 +
 .../pmu-events/arch/x86/skylakex/uncore-other.json |   96 +-
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |   13 +-
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |   13 +-
 tools/perf/pmu-events/arch/x86/tremontx/other.json |   13 +-
 .../pmu-events/arch/x86/tremontx/pipeline.json     |   13 +-
 .../arch/x86/tremontx/uncore-memory.json           |   22 +
 .../pmu-events/arch/x86/tremontx/uncore-other.json |   94 +
 .../pmu-events/arch/x86/westmereep-dp/other.json   |   66 +-
 .../arch/x86/westmereep-dp/pipeline.json           |   66 +-
 .../pmu-events/arch/x86/westmereep-sp/cache.json   |   14 +-
 .../pmu-events/arch/x86/westmereep-sp/memory.json  |    6 +-
 .../pmu-events/arch/x86/westmereep-sp/other.json   |   66 +-
 .../arch/x86/westmereep-sp/pipeline.json           |   66 +-
 .../perf/pmu-events/arch/x86/westmereex/cache.json |   14 +-
 .../pmu-events/arch/x86/westmereex/memory.json     |    6 +-
 .../perf/pmu-events/arch/x86/westmereex/other.json |   66 +-
 .../pmu-events/arch/x86/westmereex/pipeline.json   |   66 +-
 tools/perf/pmu-events/jevents.c                    |   90 +-
 tools/perf/scripts/python/intel-pt-events.py       |    8 +-
 tools/perf/tests/builtin-test.c                    |   10 +-
 tools/perf/tests/evsel-roundtrip-name.c            |    2 +-
 tools/perf/tests/mmap-basic.c                      |   18 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   23 +-
 tools/perf/tests/openat-syscall.c                  |   20 +-
 tools/perf/tests/parse-events.c                    |  492 +-
 tools/perf/tests/perf-record.c                     |   18 +-
 tools/perf/tests/pmu-events.c                      |   30 +-
 tools/perf/tests/shell/record.sh                   |   80 +
 tools/perf/tests/shell/stat.sh                     |   80 +
 tools/perf/tests/vmlinux-kallsyms.c                |   12 +-
 tools/perf/util/auxtrace.c                         |   16 +
 tools/perf/util/bpf-loader.c                       |   27 +-
 tools/perf/util/bpf_counter.c                      |   61 +-
 tools/perf/util/bpf_counter_cgroup.c               |   42 +-
 tools/perf/util/data.c                             |   14 +
 tools/perf/util/data.h                             |    2 +
 tools/perf/util/event.c                            |    7 +-
 tools/perf/util/evlist.c                           |   66 +-
 tools/perf/util/evlist.h                           |    2 -
 tools/perf/util/evsel.c                            |   77 +-
 tools/perf/util/evsel.h                            |   29 +-
 tools/perf/util/genelf.h                           |    3 +
 tools/perf/util/header.c                           |   62 +-
 tools/perf/util/header.h                           |   15 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   99 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |    1 +
 tools/perf/util/intel-pt.c                         |   57 +-
 tools/perf/util/machine.c                          |  101 +-
 tools/perf/util/machine.h                          |    5 +-
 tools/perf/util/mem-events.c                       |   32 +-
 tools/perf/util/mem-events.h                       |    1 +
 tools/perf/util/metricgroup.c                      |  124 +-
 tools/perf/util/parse-events.c                     |   46 +-
 tools/perf/util/parse-events.l                     |    2 +
 tools/perf/util/path.c                             |   14 +-
 tools/perf/util/path.h                             |    1 +
 .../util/scripting-engines/trace-event-python.c    |   49 +-
 tools/perf/util/session.c                          |    7 +
 tools/perf/util/stat-display.c                     |   46 +-
 tools/perf/util/stat-shadow.c                      |   29 +-
 tools/perf/util/stat.c                             |   14 +-
 tools/perf/util/stat.h                             |   22 +
 tools/perf/util/symbol_conf.h                      |    3 +-
 tools/perf/util/topdown.c                          |   17 +-
 tools/perf/util/topdown.h                          |    3 +-
 tools/perf/util/util.c                             |    5 +
 265 files changed, 19159 insertions(+), 4151 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-arm-spe.txt
 create mode 100644 tools/perf/arch/x86/util/topdown.h
 create mode 100644 tools/perf/bench/breakpoint.c
 delete mode 100644 tools/perf/perf-with-kcore.sh
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a35/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a710/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a78/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-x2/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
 create mode 100755 tools/perf/tests/shell/record.sh
 create mode 100755 tools/perf/tests/shell/stat.sh

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
Gwith a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:4.2 and openmandriva:cooker,
where on the feature build test it doesn't manage to find libpthread, because
the pthread functions (and the ones in librt, IIRC) are on the main libc, so a
test for that is needed to avoid adding '-lpthread and -lrt' in distros where
this is the case. It's in the TODO list.

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.18.0.tar.xz
  [perfbuilder@five ~]$ time dm
   1   181.20 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    73.95 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    67.22 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    70.83 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    75.84 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    76.54 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    78.46 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8   104.54 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   118.16 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   124.38 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   134.42 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12   121.78 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   122.89 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   114.46 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  15    62.39 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  16    90.40 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  17    89.59 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  18    89.50 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
  19    63.59 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  20    98.72 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-14) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  21   105.34 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20220401 (Red Hat 11.2.1-10) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  22   104.21 archlinux:base                : Ok   gcc (GCC) 11.2.0 , clang version 13.0.1
  23    98.13 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  24   106.84 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-13) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
  25    54.83 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220512 releases/gcc-12.1.0-30-gf363017e8b , clang version 14.0.1
  26    78.64 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  27    83.26 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  28   109.58 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  29   114.78 debian:experimental           : Ok   gcc (Debian 11.3.0-1) 11.3.0 , Debian clang version 13.0.1-4
  30    24.66 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-1) 11.3.0 
  31    20.05 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  32    22.15 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  33    22.55 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  34    22.85 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  35    69.51 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  36    80.24 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  37    18.24 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  38    81.15 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  39    93.78 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  40    96.79 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  41   106.91 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  42   112.03 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  43   117.94 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  44   110.13 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  45   116.49 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  46   105.24 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  47   110.54 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  48    20.45 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  49    18.34 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  50   112.78 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  51   124.48 fedora:36                     : Ok   gcc (GCC) 12.0.1 20220413 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  52   125.92 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
  53    96.11 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  54    82.25 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  55    42.71 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.18.0/tools/build/Makefile.build:139: util] Error 2
  56   105.14 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  57    12.61 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:66,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  58     6.28 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:66,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  59   114.34 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  60   122.95 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  61   117.64 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  62   130.68 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  63   129.68 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  64   152.17 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20220316 [revision 6a1150d1524aeda3381b2171712e1a6611d441d6] , clang version 13.0.1
  65   117.79 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  66   114.45 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  67    84.66 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  68    19.64 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    19.74 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    19.35 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71    19.95 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  72    25.18 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  73    19.74 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  74    88.97 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  75    21.35 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    21.25 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    17.64 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    20.45 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    22.35 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    22.16 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81   101.53 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    19.04 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  83    20.05 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  84    19.05 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  85    88.58 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
    LINK    /tmp/build/perf/perf
  /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
  (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
  clang: error: linker command failed with exit code 1 (use -v to see invocation)

  86    22.76 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  87    87.08 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  88   101.92 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  89   104.93 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  90   127.20 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
  BUILD_TARBALL_HEAD=5d2b6bc3a6a27ad265d2ec0d53dd7ef33bd314fc
  91 7007.03

  real	118m46.346s
  user	1m40.331s
  sys	1m1.108s
  [perfbuilder@five ~]$

  $ uname -a
  Linux quaco 5.17.8-300.fc36.x86_64 #1 SMP PREEMPT Mon May 16 01:00:37 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  5d2b6bc3a6a27ad2 (HEAD -> perf/core, seventh/perf/core, five/perf/core, acme.korg/tmp.perf/core, acme.korg/perf/core) perf intel-pt: Add guest_code support
  $ perf -v
  perf version 5.18.g5d2b6bc3a6a2
  $ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 5.18.g5d2b6bc3a6a2
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
              debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ OFF ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                 libpfm4: [ OFF ]  # HAVE_LIBPFM
  [root@quaco ~]# perf test
    1: vmlinux symtab matches kallsyms                                 : Ok
    2: Detect openat syscall event                                     : Ok
    3: Detect openat syscall event on all cpus                         : Ok
    4: Read samples using the mmap interface                           : Ok
    5: Test data source output                                         : Ok
    6: Parse event definition strings                                  :
    6.1: Test event parsing                                            : Ok
    6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
    6.3: Parsing of all PMU events from sysfs                          : Ok
    6.4: Parsing of given PMU events from sysfs                        : Ok
    6.5: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
    6.6: Parsing of aliased events                                     : Ok
    6.7: Parsing of terms (event modifiers)                            : Ok
    7: Simple expression parser                                        : Ok
    8: PERF_RECORD_* events & perf_sample fields                       : Ok
    9: Parse perf pmu format                                           : Ok
   10: PMU events                                                      :
   10.1: PMU event table sanity                                        : Ok
   10.2: PMU event map aliases                                         : Ok
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
   11: DSO data read                                                   : Ok
   12: DSO data cache                                                  : Ok
   13: DSO data reopen                                                 : Ok
   14: Roundtrip evsel->name                                           : Ok
   15: Parse sched tracepoints fields                                  : Ok
   16: syscalls:sys_enter_openat event fields                          : Ok
   17: Setup struct perf_event_attr                                    : Ok
   18: Match and link multiple hists                                   : Ok
   19: 'import perf' in python                                         : Ok
   20: Breakpoint overflow signal handler                              : Ok
   21: Breakpoint overflow sampling                                    : Ok
   22: Breakpoint accounting                                           : Ok
   23: Watchpoint                                                      :
   23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
   23.2: Write Only Watchpoint                                         : Ok
   23.3: Read / Write Watchpoint                                       : Ok
   23.4: Modify Watchpoint                                             : Ok
   24: Number of exit events of a simple workload                      : Ok
   25: Software clock events period values                             : Ok
   26: Object code reading                                             : Ok
   27: Sample parsing                                                  : Ok
   28: Use a dummy software event to keep tracking                     : Ok
   29: Parse with no sample_id_all bit set                             : Ok
   30: Filter hist entries                                             : Ok
   31: Lookup mmap thread                                              : Ok
   32: Share thread maps                                               : Ok
   33: Sort output of hist entries                                     : Ok
   34: Cumulate child hist entries                                     : Ok
   35: Track with sched_switch                                         : Ok
   36: Filter fds with revents mask in a fdarray                       : Ok
   37: Add fd to a fdarray, making it autogrow                         : Ok
   38: kmod_path__parse                                                : Ok
   39: Thread map                                                      : Ok
   40: LLVM search and compile                                         :
   40.1: Basic BPF llvm compile                                        : Ok
   40.2: kbuild searching                                              : Ok
   40.3: Compile source for BPF prologue generation                    : Ok
   40.4: Compile source for BPF relocation                             : Ok
   41: Session topology                                                : Ok
   42: BPF filter                                                      :
   42.1: Basic BPF filtering                                           : Ok
   42.2: BPF pinning                                                   : Ok
   42.3: BPF prologue generation                                       : Ok
   43: Synthesize thread map                                           : Ok
   44: Remove thread map                                               : Ok
   45: Synthesize cpu map                                              : Ok
   46: Synthesize stat config                                          : Ok
   47: Synthesize stat                                                 : Ok
   48: Synthesize stat round                                           : Ok
   49: Synthesize attr update                                          : Ok
   50: Event times                                                     : Ok
   51: Read backward ring buffer                                       : Ok
   52: Print cpu map                                                   : Ok
   53: Merge cpu map                                                   : Ok
   54: Probe SDT events                                                : Ok
   55: is_printable_array                                              : Ok
   56: Print bitmap                                                    : Ok
   57: perf hooks                                                      : Ok
   58: builtin clang support                                           :
   58.1: builtin clang compile C source to IR                          : Skip (not compiled in)
   58.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
   59: unit_number__scnprintf                                          : Ok
   60: mem2node                                                        : Ok
   61: time utils                                                      : Ok
   62: Test jit_write_elf                                              : Ok
   63: Test libpfm4 support                                            :
   63.1: test of individual --pfm-events                               : Skip (not compiled in)
   63.2: test groups of --pfm-events                                   : Skip (not compiled in)
   64: Test api io                                                     : Ok
   65: maps__merge_in                                                  : Ok
   66: Demangle Java                                                   : Ok
   67: Demangle OCaml                                                  : Ok
   68: Parse and process metrics                                       : Ok
   69: PE file support                                                 : Ok
   70: Event expansion for cgroups                                     : Ok
   71: Convert perf time to TSC                                        :
   71.1: TSC support                                                   : Ok
   71.2: Perf time to TSC                                              : Ok
   72: dlfilter C API                                                  : Ok
   73: Sigtrap                                                         : Ok
   74: x86 rdpmc                                                       : Ok
   75: Test dwarf unwind                                               : Ok
   76: x86 instruction decoder - new instructions                      : Ok
   77: Intel PT packet decoder                                         : Ok
   78: x86 bp modify                                                   : Ok
   79: x86 Sample parsing                                              : Ok
   80: build id cache operations                                       : Ok
   81: daemon operations                                               : Ok
   82: perf pipe recording and injection test                          : Ok
   83: Add vfs_getname probe to get syscall args filenames             : Ok
   84: probe libc's inet_pton & backtrace it with ping                 : Ok
   85: Use vfs_getname probe to get syscall args filenames             : Ok
   86: Zstd perf.data compression/decompression                        : Ok
   87: perf record tests                                               : Ok
   88: perf stat csv summary test                                      : Ok
   89: perf stat metrics (shadow stat) test                            : Ok
   90: perf stat tests                                                 : Ok
   91: perf all metricgroups test                                      : Ok
   92: perf all metrics test                                           : FAILED!
   93: perf all PMU test                                               : Ok
   94: perf stat --bpf-counters test                                   : Ok
   95: Check Arm64 callgraphs are complete in fp mode                  : Skip
   96: Check Arm CoreSight trace data recording and synthesized samples: Skip
   97: Check Arm SPE trace data recording and synthesized samples      : Skip
   98: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]#

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  ⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
  5d2b6bc3a6a27ad2 (HEAD -> perf/core) perf intel-pt: Add guest_code support
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.LJ48Out0P1
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.WU4Lgay4fD
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
         make_install_prefix_O: make install prefix=/tmp/krava
                    make_doc_O: make doc
         make_with_coresight_O: make CORESIGHT=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
                   make_pure_O: make
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_no_newt_O: make NO_NEWT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_gtk2_O: make NO_GTK2=1
                   make_help_O: make help
            make_install_bin_O: make install-bin
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_no_sdt_O: make NO_SDT=1
              make_clean_all_O: make clean all
             make_no_libperl_O: make NO_LIBPERL=1
                   make_tags_O: make tags
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_debug_O: make DEBUG=1
           make_with_libpfm4_O: make LIBPFM4=1
               make_no_slang_O: make NO_SLANG=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_perf_o_O: make perf.o
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_demangle_O: make NO_DEMANGLE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_util_map_o_O: make util/map.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_install_O: make install
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	5m16.178s
  user	61m20.474s
  sys	15m17.757s
  ⬢[acme@toolbox perf]$
