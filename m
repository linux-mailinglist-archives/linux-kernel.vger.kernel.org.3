Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A447148FD59
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiAPOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiAPOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:07:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CF4C061574;
        Sun, 16 Jan 2022 06:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A018B80D4E;
        Sun, 16 Jan 2022 14:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE93C36AE9;
        Sun, 16 Jan 2022 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642342047;
        bh=U8fN6S7uhYiBZ4iyu0gcNKlnfW/ZmzHF8t+msvrXuyM=;
        h=From:To:Cc:Subject:Date:From;
        b=nbl8PhDlyZD5vBlc8Lqk0PMw3rLyA7dkM8c7syr0nLNtf5O4+Myt2A3MkpkBewwTl
         hmaCmmZRr67Sco2Dd+ZLH9IdnfkdVfe69bIJMguHiZ/f3LJU5T3GEFwrm63l/QK6TB
         4aABy1B+0wqGTL0vyRlEvggx4VZssi8JHSYBC/fCEoLikQnQpAKiw5iMvSvE1EDUWO
         kRmgxgbFfNp2Bh0BUKZzruufP2wT/4131zyD8ZnTH3s9RBPE1R4eyVrGObvF1RszCR
         jskg6IwT6kzGsvrTLlqtdg0iaoDwsW74+VOKaZrtaFscTf/3OnOOMRO/APO55MJ4u2
         UvWgdPK1cnMWw==
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
        Alexandre Truong <alexandre.truong@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Gang Li <ligang.bdlg@bytedance.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>,
        Marco Elver <elver@google.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.17: 1st batch
Date:   Sun, 16 Jan 2022 11:07:16 -0300
Message-Id: <20220116140716.1167711-1-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit 455e73a07f6e288b0061dfcf4fcf54fa9fe06458:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2022-01-12 17:02:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.17-2022-01-16

for you to fetch changes up to 9bce13ea88f85344b765abe5d3dabdd0f44dc177:

  perf record: Disable debuginfod by default (2022-01-15 17:41:25 -0300)

----------------------------------------------------------------
perf tools changes for v5.17: 1st batch

New features:

- Add 'trace' subcommand for 'perf ftrace', setting the stage for more
  'perf ftrace' subcommands. Not using a subcommand yields the previous
  behaviour of 'perf ftrace'.

- Add 'latency' subcommand to 'perf ftrace', that can use the function
  graph tracer or a BPF optimized one, via the -b/--use-bpf option.

  E.g.:

  $ sudo perf ftrace latency -a -T mutex_lock sleep 1
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |       4596 | ########################       |
       1 - 2    us |       1680 | #########                      |
       2 - 4    us |       1106 | #####                          |
       4 - 8    us |        546 | ##                             |
       8 - 16   us |        562 | ###                            |
      16 - 32   us |          1 |                                |
      32 - 64   us |          0 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          0 |                                |
     256 - 512  us |          0 |                                |
     512 - 1024 us |          0 |                                |
       1 - 2    ms |          0 |                                |
       2 - 4    ms |          0 |                                |
       4 - 8    ms |          0 |                                |
       8 - 16   ms |          0 |                                |
      16 - 32   ms |          0 |                                |
      32 - 64   ms |          0 |                                |
      64 - 128  ms |          0 |                                |
     128 - 256  ms |          0 |                                |
     256 - 512  ms |          0 |                                |
     512 - 1024 ms |          0 |                                |
       1 - ...   s |          0 |                                |

  The original implementation of this command was in the bcc tool.

- Support --cputype option for hybrid events in 'perf stat'.

Improvements:

- Call chain improvements for ARM64.

- No need to do any affinity setup when profiling pids.

- Reduce multiplexing with duration_time in 'perf stat' metrics.

- Improve error message for uncore events, stating that some event groups are
  can only be used in system wide (-a) mode.

- perf stat metric group leader fixes/improvements, including arch specific
  changes to better support Intel topdown events.

- Probe non-deprecated sysfs path 1st, i.e. try /sys/devices/system/cpu/cpuN/topology/thread_siblings
  first, then the old /sys/devices/system/cpu/cpuN/topology/core_cpus.

- Disable debuginfod by default in 'perf record', to avoid stalls on distros
  such as Fedora 35.

- Use unbuffered output in 'perf bench' when pipe/tee'ing to a file.

- Enable ignore_missing_thread in 'perf trace'

Fixes:

- Avoid TUI crash when navigating in the annotation of recursive functions.

- Fix hex dump character output in 'perf script'.

- Fix JSON indentation to 4 spaces standard in the ARM vendor event files.

- Fix use after free in metric__new().

- Fix IS_ERR_OR_NULL() usage in the perf BPF loader.

- Fix up cross-arch register support, i.e. when printing register names take
  into account the architecture where the perf.data file was collected.

- Fix SMT fallback with large core counts.

- Don't lower case MetricExpr when parsing JSON files so as not to lose info
  such as the ":G" event modifier in metrics.

perf test:

- Add basic stress test for sigtrap handling to 'perf test'.

- Fix 'perf test' failures on s/390

- Enable system wide for metricgroups test in 'perf test´.

- Use 3 digits for test numbering now we can have more tests.

Arch specific:

- Add events for Arm Neoverse N2 in the ARM JSON vendor event files

- Support PERF_MEM_LVLNUM encodings in powerpc, that came from a single
  patch series, where I incorrectly merged the kernel bits, that were then
  reverted after coordination with Michael Ellerman and Stephen Rothwell.

- Add ARM SPE total latency as PERF_SAMPLE_WEIGHT.

- Update AMD documentation, with info on raw event encoding.

- Add support for global and local variants of the "p_stage_cyc" sort key,
  applicable to perf.data files collected on powerpc.

- Remove duplicate and incorrect aux size checks in the ARM CoreSight ETM code.

Refactorings:

- Add a perf_cpu abstraction to disambiguate CPUs and CPU map indexes, fixing
  problems along the way.

- Document CPU map methods.

UAPI sync:

- Update arch/x86/lib/mem{cpy,set}_64.S copies used in 'perf bench mem memcpy'

- Sync UAPI files with the kernel sources: drm, msr-index, cpufeatures.

Build system

- Enable warnings through HOSTCFLAGS.

- Drop requirement for libstdc++.so for libopencsd check

libperf:

- Make libperf adopt perf_counts_values__scale() from tools/perf/util/.

- Add a stat multiplexing test to libperf.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf script: Fix hex dump character output

Alexandre Truong (5):
      perf tools: Record ARM64 LR register automatically
      perf machine: Add a mechanism to inject stack frames
      perf script: Use callchain_param_setup() instead of open coded equivalent
      perf callchain: Enable dwarf_callchain_users on arm64
      perf arm64: Inject missing frames when using 'perf record --call-graph=fp'

Andrew Kilroy (3):
      perf vendor events arm64: Fix JSON indentation to 4 spaces standard
      perf vendor events: For the Arm Neoverse N2
      perf vendor events: Rename arm64 arch std event files

Arnaldo Carvalho de Melo (14):
      perf test sigtrap: Print errno string when failing
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Revert "perf powerpc: Add encodings to represent data based on newer composite PERF_MEM_LVLNUM* fields"
      Revert "perf powerpc: Add data source encodings for power10 platform"
      Merge remote-tracking branch 'torvalds/master' into perf/core
      tools arch: Update arch/x86/lib/mem{cpy,set}_64.S copies used in 'perf bench mem memcpy'
      tools headers UAPI: Update tools's copy of drm.h header
      tools headers cpufeatures: Sync with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      perf cpumap: Add is_dummy() method
      perf evlist: No need to do any affinity setup when profiling pids

Athira Rajeev (2):
      perf sort: Include global and local variants for p_stage_cyc sort key
      perf powerpc: Update global/local variants for p_stage_cyc

Carsten Haitzler (1):
      perf test: Use 3 digits for test numbering now we can have more tests

Colin Ian King (1):
      libperf tests: Fix a spelling mistake "Runnnig" -> "Running"

Dario Petrillo (1):
      perf annotate: Avoid TUI crash when navigating in the annotation of recursive functions

Gang Li (1):
      perf trace: Enable ignore_missing_thread for trace

German Gomez (4):
      perf arm64: Rename perf_event_arm_regs for ARM64 registers
      perf arch: Support register names from all archs
      perf arm-spe: Synthesize SPE instruction events
      perf tools: Refactor SMPL_REG macro in perf_regs.h

Ian Rogers (60):
      perf metric: Reduce multiplexing with duration_time
      perf evlist: Allow setting arbitrary leader
      perf parse-events: Architecture specific leader override
      perf test: Enable system wide for metricgroups test
      perf evsel: Improve error message for uncore events
      libperf: Add comments to 'struct perf_cpu_map'
      perf stat: Add aggr creators that are passed a cpu
      perf stat: Correct aggregation CPU map
      perf stat: Switch aggregation to use for_each loop
      perf stat: Switch to cpu version of cpu_map__get()
      perf cpumap: Switch cpu_map__build_map() to cpu function
      perf cpumap: Remove map+index get_socket()
      perf cpumap: Remove map+index get_die()
      perf cpumap: Remove map+index get_core()
      perf cpumap: Remove map+index get_node()
      perf cpumap: Add comments to aggr_cpu_id()
      perf cpumap: Remove unused cpu_map__socket()
      perf cpumap: Simplify equal function name
      perf cpumap: Rename empty functions
      perf cpumap: Document cpu__get_node() and remove redundant function
      perf cpumap: Remove map from function names that don't use a map
      perf cpumap: Remove cpu_map__cpu(), use libperf function
      perf cpumap: Refactor cpu_map__build_map()
      perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
      perf cpumap: Move 'has' function to libperf
      perf cpumap: Add some comments to cpu_aggr_map
      perf cpumap: Trim the cpu_aggr_map
      perf stat: Fix memory leak in check_per_pkg()
      perf cpumap: Add CPU to aggr_cpu_id
      perf stat-display: Avoid use of core for CPU
      perf evsel: Derive CPUs and threads in alloc_counts
      libperf: Switch cpu to more accurate cpu_map_idx
      libperf: Use cpu not index for evsel mmap
      perf counts: Switch name cpu to cpu_map_idx
      perf stat: Rename aggr_data cpu to imply it's an index
      perf stat: Use perf_cpu_map__for_each_cpu()
      perf script: Use for each cpu to aid readability
      libperf: Allow NULL in perf_cpu_map__idx()
      perf evlist: Refactor evlist__for_each_cpu()
      perf evsel: Pass cpu not cpu map index to synthesize
      perf stat: Correct variable name for read counter
      perf evsel: Rename CPU around get_group_fd
      perf evsel: Reduce scope of evsel__ignore_missing_thread
      perf evsel: Rename variable cpu to index
      perf test: Use perf_cpu_map__for_each_cpu()
      perf stat: Correct check_per_pkg() cpu
      perf stat: Swap variable name cpu to index
      libperf: Sync evsel documentation
      perf bpf: Rename 'cpu' to 'cpu_map_idx'
      perf c2c: Use more intention revealing iterator
      perf script: Fix flipped index and cpu
      perf stat: Correct first_shadow_cpu to return index
      perf cpumap: Give CPUs their own type
      perf tools: Fix SMT fallback with large core counts
      perf tools: Probe non-deprecated sysfs path 1st
      perf expr: Add debug logging for literals
      perf pmu-events: Don't lower case MetricExpr
      perf arm: Fix off-by-one directory path
      libperf tests: Update a use of the new cpumap API
      perf metric: Fix metric_leader

James Clark (1):
      perf cs-etm: Remove duplicate and incorrect aux size checks

Jin Yao (1):
      perf stat: Support --cputype option for hybrid events

Jiri Olsa (1):
      perf record: Disable debuginfod by default

John Garry (1):
      tools build: Enable warnings through HOSTCFLAGS

José Expósito (1):
      perf metricgroup: Fix use after free in metric__new()

Kajol Jain (3):
      tools headers UAPI: Add new macros for mem_hops field to perf_event.h
      perf powerpc: Add encodings to represent data based on newer composite PERF_MEM_LVLNUM* fields
      perf powerpc: Add data source encodings for power10 platform

Leo Yan (1):
      perf namespaces: Add helper nsinfo__is_in_root_namespace()

Marco Elver (1):
      perf test sigtrap: Add basic stress test for sigtrap handling

Miaoqian Lin (1):
      perf bpf-loader: Use IS_ERR_OR_NULL() to clean code and fix check

Namhyung Kim (6):
      perf arm-spe: Add SPE total latency as PERF_SAMPLE_WEIGHT
      perf ftrace: Add 'trace' subcommand
      perf ftrace: Move out common code from __cmd_ftrace
      perf ftrace: Add 'latency' subcommand
      perf ftrace: Add -b/--use-bpf option for latency subcommand
      perf ftrace: Implement cpu and task filters in BPF

Salvatore Bonaccorso (1):
      perf dlfilter: Drop unused variable

Sandipan Das (2):
      perf docs: Add info on AMD raw event encoding
      perf docs: Update link to AMD documentation

Shunsuke Nakamura (3):
      libperf: Adopt perf_counts_values__scale() from tools/perf/util
      libperf: Remove scaling process from perf_mmap__read_self()
      libperf tests: Add test_stat_multiplexing test

Sohaib Mohamed (1):
      perf bench: Use unbuffered output when pipe/tee'ing to a file

Thomas Richter (2):
      perf test: Test 73 Sig_trap fails on s390
      perf cputopo: Fix CPU topology reading on s/390

Uwe Kleine-König (1):
      perf tools: Drop requirement for libstdc++.so for libopencsd check

 tools/arch/x86/include/asm/cpufeatures.h           |   1 +
 tools/arch/x86/include/asm/msr-index.h             |  17 +
 tools/arch/x86/lib/memcpy_64.S                     |  12 +-
 tools/arch/x86/lib/memset_64.S                     |   6 +-
 tools/build/Build.include                          |   2 +-
 tools/include/uapi/drm/drm.h                       |  18 +
 tools/include/uapi/linux/perf_event.h              |   5 +-
 tools/lib/perf/Documentation/libperf.txt           |  11 +-
 tools/lib/perf/cpumap.c                            | 113 ++--
 tools/lib/perf/evlist.c                            |  19 +-
 tools/lib/perf/evsel.c                             | 111 ++--
 tools/lib/perf/include/internal/cpumap.h           |  18 +-
 tools/lib/perf/include/internal/evlist.h           |   5 +-
 tools/lib/perf/include/internal/evsel.h            |   4 +-
 tools/lib/perf/include/internal/mmap.h             |   5 +-
 tools/lib/perf/include/perf/cpumap.h               |   8 +-
 tools/lib/perf/include/perf/evsel.h                |  14 +-
 tools/lib/perf/libperf.map                         |   2 +
 tools/lib/perf/mmap.c                              |   4 +-
 tools/lib/perf/tests/test-evlist.c                 | 162 ++++-
 tools/perf/Documentation/perf-buildid-cache.txt    |   5 +-
 tools/perf/Documentation/perf-config.txt           |   9 +
 tools/perf/Documentation/perf-list.txt             |  48 +-
 tools/perf/Documentation/perf-record.txt           |  15 +-
 tools/perf/Documentation/perf-stat.txt             |  10 +-
 tools/perf/Documentation/perf-top.txt              |   7 +-
 tools/perf/Makefile.config                         |  10 +-
 tools/perf/Makefile.perf                           |   4 +-
 tools/perf/arch/arm/include/perf_regs.h            |  42 --
 tools/perf/arch/arm/util/cs-etm.c                  |  54 +-
 tools/perf/arch/arm64/include/perf_regs.h          |  78 +--
 tools/perf/arch/arm64/util/machine.c               |   7 +
 tools/perf/arch/arm64/util/pmu.c                   |   2 +-
 tools/perf/arch/csky/include/perf_regs.h           |  82 ---
 tools/perf/arch/mips/include/perf_regs.h           |  69 ---
 tools/perf/arch/powerpc/include/perf_regs.h        |  66 --
 tools/perf/arch/powerpc/util/event.c               |   8 +-
 tools/perf/arch/riscv/include/perf_regs.h          |  74 ---
 tools/perf/arch/s390/include/perf_regs.h           |  78 ---
 tools/perf/arch/x86/include/perf_regs.h            |  82 ---
 tools/perf/arch/x86/util/evlist.c                  |  17 +
 tools/perf/bench/epoll-ctl.c                       |   2 +-
 tools/perf/bench/epoll-wait.c                      |   2 +-
 tools/perf/bench/futex-hash.c                      |   2 +-
 tools/perf/bench/futex-lock-pi.c                   |   2 +-
 tools/perf/bench/futex-requeue.c                   |   2 +-
 tools/perf/bench/futex-wake-parallel.c             |   2 +-
 tools/perf/bench/futex-wake.c                      |   2 +-
 tools/perf/builtin-bench.c                         |   5 +-
 tools/perf/builtin-buildid-cache.c                 |  25 +-
 tools/perf/builtin-c2c.c                           |  15 +-
 tools/perf/builtin-ftrace.c                        | 447 +++++++++++---
 tools/perf/builtin-kmem.c                          |   2 +-
 tools/perf/builtin-record.c                        |  23 +-
 tools/perf/builtin-report.c                        |   4 +-
 tools/perf/builtin-sched.c                         |  71 ++-
 tools/perf/builtin-script.c                        |  41 +-
 tools/perf/builtin-stat.c                          | 541 ++++++++---------
 tools/perf/builtin-trace.c                         |   3 +
 tools/perf/dlfilters/dlfilter-test-api-v0.c        |   2 -
 .../arch/arm64/arm/neoverse-n2/branch.json         |   8 +
 .../pmu-events/arch/arm64/arm/neoverse-n2/bus.json |  20 +
 .../arch/arm64/arm/neoverse-n2/cache.json          | 155 +++++
 .../arch/arm64/arm/neoverse-n2/exception.json      |  47 ++
 .../arch/arm64/arm/neoverse-n2/instruction.json    | 143 +++++
 .../arch/arm64/arm/neoverse-n2/memory.json         |  38 ++
 .../arch/arm64/arm/neoverse-n2/other.json          |   5 +
 .../arch/arm64/arm/neoverse-n2/pipeline.json       |  23 +
 .../pmu-events/arch/arm64/arm/neoverse-n2/spe.json |  14 +
 .../arch/arm64/arm/neoverse-n2/trace.json          |  29 +
 ...nd-microarch.json => common-and-microarch.json} | 198 ++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 .../{armv8-recommended.json => recommended.json}   | 202 +++----
 tools/perf/pmu-events/jevents.c                    |   2 -
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/attr.c                            |   6 +-
 tools/perf/tests/bitmap.c                          |   2 +-
 tools/perf/tests/builtin-test.c                    |  16 +-
 tools/perf/tests/cpumap.c                          |   6 +-
 tools/perf/tests/event_update.c                    |   6 +-
 tools/perf/tests/mem2node.c                        |   2 +-
 tools/perf/tests/mmap-basic.c                      |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |  39 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |   2 +-
 tools/perf/tests/sigtrap.c                         | 177 ++++++
 tools/perf/tests/stat.c                            |   3 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/topology.c                        |  43 +-
 tools/perf/ui/browsers/annotate.c                  |  23 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/affinity.c                         |   2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   2 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   1 +
 tools/perf/util/arm-spe.c                          |  67 ++-
 .../perf/util/arm64-frame-pointer-unwind-support.c |  63 ++
 .../perf/util/arm64-frame-pointer-unwind-support.h |  10 +
 tools/perf/util/auxtrace.c                         |  12 +-
 tools/perf/util/auxtrace.h                         |   5 +-
 tools/perf/util/bpf-loader.c                       |  15 +-
 tools/perf/util/bpf_counter.c                      |  29 +-
 tools/perf/util/bpf_counter.h                      |   4 +-
 tools/perf/util/bpf_counter_cgroup.c               |  10 +-
 tools/perf/util/bpf_ftrace.c                       | 152 +++++
 tools/perf/util/bpf_skel/func_latency.bpf.c        | 114 ++++
 tools/perf/util/callchain.c                        |  14 +-
 tools/perf/util/callchain.h                        |   4 +-
 tools/perf/util/counts.c                           |   8 +-
 tools/perf/util/counts.h                           |  14 +-
 tools/perf/util/cpumap.c                           | 253 ++++----
 tools/perf/util/cpumap.h                           | 124 +++-
 tools/perf/util/cputopo.c                          |   9 +-
 tools/perf/util/debug.c                            |   2 +-
 tools/perf/util/env.c                              |  29 +-
 tools/perf/util/env.h                              |   3 +-
 tools/perf/util/evlist.c                           | 150 ++---
 tools/perf/util/evlist.h                           |  52 +-
 tools/perf/util/evsel.c                            | 166 +++--
 tools/perf/util/evsel.h                            |  30 +-
 tools/perf/util/expr.c                             |  37 +-
 tools/perf/util/ftrace.h                           |  81 +++
 tools/perf/util/header.c                           |   6 +-
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/hist.h                             |   3 +-
 tools/perf/util/libunwind/arm64.c                  |   2 +
 tools/perf/util/machine.c                          |  50 +-
 tools/perf/util/machine.h                          |   1 +
 tools/perf/util/mem-events.c                       |  29 +-
 tools/perf/util/metricgroup.c                      |  46 +-
 tools/perf/util/mmap.c                             |  19 +-
 tools/perf/util/mmap.h                             |   3 +-
 tools/perf/util/namespaces.c                       |  76 ++-
 tools/perf/util/namespaces.h                       |   2 +
 tools/perf/util/parse-events-hybrid.c              |   9 +-
 tools/perf/util/parse-events.c                     |  10 +-
 tools/perf/util/perf_api_probe.c                   |  15 +-
 tools/perf/util/perf_regs.c                        | 666 +++++++++++++++++++++
 tools/perf/util/perf_regs.h                        |  17 +-
 tools/perf/util/python.c                           |   4 +-
 tools/perf/util/record.c                           |  11 +-
 .../util/scripting-engines/trace-event-python.c    |  16 +-
 tools/perf/util/session.c                          |  35 +-
 tools/perf/util/smt.c                              |  73 ++-
 tools/perf/util/sort.c                             |  34 +-
 tools/perf/util/sort.h                             |   3 +-
 tools/perf/util/stat-display.c                     | 138 +++--
 tools/perf/util/stat-shadow.c                      | 308 +++++-----
 tools/perf/util/stat.c                             |  47 +-
 tools/perf/util/stat.h                             |   9 +-
 tools/perf/util/svghelper.c                        |   6 +-
 tools/perf/util/synthetic-events.c                 |  12 +-
 tools/perf/util/synthetic-events.h                 |   3 +-
 tools/perf/util/util.c                             |  15 +
 tools/perf/util/util.h                             |  11 +-
 153 files changed, 4685 insertions(+), 2175 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json
 rename tools/perf/pmu-events/arch/arm64/{armv8-common-and-microarch.json => common-and-microarch.json} (76%)
 rename tools/perf/pmu-events/arch/arm64/{armv8-recommended.json => recommended.json} (96%)
 create mode 100644 tools/perf/tests/sigtrap.c
 create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.c
 create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.h
 create mode 100644 tools/perf/util/bpf_ftrace.c
 create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
 create mode 100644 tools/perf/util/ftrace.h

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
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:cooker, where on the feature build
test it doesn't manage to find libpthread, looks like a distro problem, will keep
it there to see if a refreshed container cures this soon. This has been the case
for quite a while, probably time to drop building for those distros?

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0.tar.xz
  $ time dm
     1   211.23 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
     2   245.14 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
     3    85.01 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
     4    59.40 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
     5    65.23 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     6    63.33 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     7    65.63 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     8    88.38 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     9   100.74 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
    10   108.28 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
    11   115.08 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
    12   102.64 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
    13   103.65 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
    14   105.04 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
    15    51.87 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
    16    78.07 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    17    77.55 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
    18    76.16 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
    19    52.77 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    20    86.70 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    21    79.56 archlinux:base                : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
    22    81.78 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
    23    97.81 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
    24    27.26 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220103 releases/gcc-11.2.0-627-gd4a1d3c4b3 , clang version 11.1.0
    25    66.62 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    26    62.01 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    27    86.48 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    28    99.53 debian:experimental           : Ok   gcc (Debian 11.2.0-13) 11.2.0 , Debian clang version 13.0.0-9+b2
    29    23.86 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
    30    19.55 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    31    21.55 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    32    22.26 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
    33    22.05 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    34    56.59 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    35    66.81 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    36    17.64 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    37    68.41 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    38    79.95 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    39    81.05 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    40    92.28 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    41    96.62 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    42   101.60 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    43    94.70 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    44    89.40 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    45    86.69 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    46    90.59 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    47    19.94 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    48    17.94 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    49    93.34 fedora:35                     : Ok   gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
    50   101.24 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
    51    80.67 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
    52    69.32 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    53    38.80 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
            yychar = yylex (&yylval, &yylloc, scanner);
                     ^
      #define yylex           parse_events_lex
                              ^
      1 error generated.
      make[3]: *** [/git/perf-5.16.0/tools/build/Makefile.build:139: util] Error 2
    54    89.91 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
    55     6.48 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
      In file included from builtin-bench.c:22:
      bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
         66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
            |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      In file included from bench/bench.h:64,
                       from builtin-bench.c:22:
      /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
        394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
            |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
    56   102.70 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    57   110.62 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    58   104.71 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    59   118.36 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    60   117.96 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    61   132.61 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
    62    97.32 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
    63    96.72 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
    64    70.73 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    65    18.94 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    66    19.04 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    67    18.64 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    68    18.95 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    69    19.35 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    70    18.74 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    71    76.03 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    72    20.45 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    73    20.85 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    74    16.63 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    75    20.15 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    76    21.65 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    77    21.96 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    78    98.32 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    79    18.24 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    80    19.54 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    81    18.44 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    82    73.34 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
  
    83    22.16 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
    84    75.13 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
    85    85.18 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
    86    89.49 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
    87   108.76 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-13ubuntu1) 11.2.0 , Ubuntu clang version 13.0.0-9
  BUILD_TARBALL_HEAD=9bce13ea88f85344b765abe5d3dabdd0f44dc177
  88 6063.96
  
  real	103m0.802s
  user	1m21.250s
  sys	0m54.396s
  $ 


  $ uname -a
  Linux quaco 5.15.7-200.fc35.x86_64 #1 SMP Wed Dec 8 19:00:47 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  9bce13ea88f85344 (HEAD -> perf/core, seventh/perf/core, five/perf/core) perf record: Disable debuginfod by default
  $ perf -v
  perf version 5.16.g9bce13ea88f8
  # perf -vv
  perf version 5.16.g9bce13ea88f8
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
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
    6: Parse event definition strings                                  : Ok
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
   71: Convert perf time to TSC                                        : Ok
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
   87: perf stat csv summary test                                      : Ok
   88: perf stat metrics (shadow stat) test                            : Ok
   89: perf all metricgroups test                                      : Ok
   90: perf all metrics test                                           : Ok
   91: perf all PMU test                                               : Ok
   92: perf stat --bpf-counters test                                   : Ok
   93: Check Arm CoreSight trace data recording and synthesized samples: Skip
   94: Check Arm SPE trace data recording and synthesized samples      : Skip
   95: Check open filename arg using perf trace + vfs_getname          : Ok
  #

  $ git log --oneline -1 ; time make -C tools/perf build-test
  9bce13ea88f85344 (HEAD -> perf/core) perf record: Disable debuginfod by default
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.g9NfgOL5xB
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.pVhAJP48Pe
  - /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
                  make_debug_O: make DEBUG=1
            make_install_bin_O: make install-bin
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_pure_O: make
             make_no_libnuma_O: make NO_LIBNUMA=1
               make_no_slang_O: make NO_SLANG=1
           make_with_libpfm4_O: make LIBPFM4=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                    make_doc_O: make doc
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_install_prefix_O: make install prefix=/tmp/krava
                 make_perf_o_O: make perf.o
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_newt_O: make NO_NEWT=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
                   make_tags_O: make tags
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_clean_all_O: make clean all
                make_no_gtk2_O: make NO_GTK2=1
                   make_help_O: make help
                 make_no_sdt_O: make NO_SDT=1
         make_with_coresight_O: make CORESIGHT=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_util_map_o_O: make util/map.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                make_install_O: make install
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	8m55.414s
  user	64m6.612s
  sys	16m9.055s
  $
