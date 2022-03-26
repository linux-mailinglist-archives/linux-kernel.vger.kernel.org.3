Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4234E81DC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiCZP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiCZPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:55:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA213E95;
        Sat, 26 Mar 2022 08:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73FF9B801B9;
        Sat, 26 Mar 2022 15:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD1AC340ED;
        Sat, 26 Mar 2022 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648310055;
        bh=jXekh4YRe6AH7ZyfdvV3uG6yZSjf+gKUZ6Osvf3KNFY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZR5xjqtiNfGK4CA3RAv+Uktczit12cWFI4VwsioteR4PN4ChPu8LRSpKBifdF4m1N
         5hqOdzH9//lwTQi3r0mbp/vNGDcLmrF4SaqKBwYuj/92h3UzVuPcNNX9DoV3JJZPxD
         YSNc+wflMGOUo/D3g1hNY1+1GEzr8NdT1BO6oF/uYKJjtsYr82G2ZWi8wZkO63/ysr
         GP8ErlGs81J8iiutcsxuRiS9Jb9LFN5WaEZZx+Eew8mB6oGrN9HftykgqBiWehtbFv
         vjRdveTXcwqxDOZyUbbg/D0j/wzJAllHRygR7KcbmmTOzwnNr1ovuVbXR16sZGySDS
         CaGJ/pyNcHKYA==
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
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christylee@fb.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mahmoud Mandour <ma.mandourr@gmail.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        xaizek <xaizek@posteo.net>, Yury Norov <yury.norov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.18: 1st batch
Date:   Sat, 26 Mar 2022 12:53:57 -0300
Message-Id: <20220326155357.231739-1-acme@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit 5191290407668028179f2544a11ae9b57f0bcf07:

  Merge tag 'for-5.18-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2022-03-22 10:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.18-2022-03-26

for you to fetch changes up to ab0809af0bee88b689ba289ec8c40aa2be3a17ec:

  perf evsel: Improve AMD IBS (Instruction-Based Sampling) error handling messages (2022-03-26 10:55:58 -0300)

----------------------------------------------------------------
perf tools changes for v5.18: 1st batch

New features:

perf ftrace:

- Add -n/--use-nsec option to the 'latency' subcommand.

  Default: usecs:

  $ sudo perf ftrace latency -T dput -a sleep 1
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |    2098375 | #############################  |
       1 - 2    us |         61 |                                |
       2 - 4    us |         33 |                                |
       4 - 8    us |         13 |                                |
       8 - 16   us |        124 |                                |
      16 - 32   us |        123 |                                |
      32 - 64   us |          1 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          1 |                                |
     256 - 512  us |          0 |                                |

  Better granularity with nsec:

  $ sudo perf ftrace latency -T dput -a -n sleep 1
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |          0 |                                |
       1 - 2    ns |          0 |                                |
       2 - 4    ns |          0 |                                |
       4 - 8    ns |          0 |                                |
       8 - 16   ns |          0 |                                |
      16 - 32   ns |          0 |                                |
      32 - 64   ns |          0 |                                |
      64 - 128  ns |    1163434 | ##############                 |
     128 - 256  ns |     914102 | #############                  |
     256 - 512  ns |        884 |                                |
     512 - 1024 ns |        613 |                                |
       1 - 2    us |         31 |                                |
       2 - 4    us |         17 |                                |
       4 - 8    us |          7 |                                |
       8 - 16   us |        123 |                                |
      16 - 32   us |         83 |                                |

perf lock:

- Add -c/--combine-locks option to merge lock instances in the same class into
  a single entry.

  # perf lock report -c
                 Name acquired contended avg wait(ns) total wait(ns) max wait(ns) min wait(ns)

        rcu_read_lock   251225         0            0              0            0            0
   hrtimer_bases.lock    39450         0            0              0            0            0
  &sb->s_type->i_l...    10301         1          662            662          662          662
     ptlock_ptr(page)    10173         2          701           1402          760          642
  &(ei->i_block_re...     8732         0            0              0            0            0
         &xa->xa_lock     8088         0            0              0            0            0
          &base->lock     6705         0            0              0            0            0
          &p->pi_lock     5549         0            0              0            0            0
  &dentry->d_lockr...     5010         4         1274           5097         1844          789
            &ep->lock     3958         0            0              0            0            0

- Add -F/--field option to customize the list of fields to output:

  $ perf lock report -F contended,wait_max -k avg_wait
                  Name contended max wait(ns) avg wait(ns)

        slock-AF_INET6         1        23543        23543
     &lruvec->lru_lock         5        18317        11254
        slock-AF_INET6         1        10379        10379
            rcu_node_1         1         2104         2104
   &dentry->d_lockr...         1         1844         1844
   &dentry->d_lockr...         1         1672         1672
      &newf->file_lock        15         2279         1025
   &dentry->d_lockr...         1          792          792

- Add --synth=no option for record, as there is no need to symbolize,
  lock names comes from the tracepoints.

perf record:

- Threaded recording, opt-in, via the new --threads command line option.

- Improve AMD IBS (Instruction-Based Sampling) error handling messages.

perf script:

- Add 'brstackinsnlen' field (use it with -F) for branch stacks.

- Output branch sample type in 'perf script'.

perf report:

- Add "addr_from" and "addr_to" sort dimensions.

- Print branch stack entry type in 'perf report --dump-raw-trace'

- Fix symbolization for chrooted workloads.

Hardware tracing:

Intel PT:

- Add CFE (Control Flow Event) and EVD (Event Data) packets support.

- Add MODE.Exec IFLAG bit support.

Explanation about these features from the "Intel® 64 and IA-32 architectures
software developer’s manual combined volumes: 1, 2A, 2B, 2C, 2D, 3A, 3B, 3C,
3D, and 4" PDF at:

  https://cdrdv2.intel.com/v1/dl/getContent/671200

At page 3951:

<quote>
32.2.4

Event Trace is a capability that exposes details about the asynchronous
events, when they are generated, and when their corresponding software
event handler completes execution. These include:

o Interrupts, including NMI and SMI, including the interrupt vector when
defined.

o Faults, exceptions including the fault vector.

— Page faults additionally include the page fault address, when in context.

o Event handler returns, including IRET and RSM.

o VM exits and VM entries.¹

— VM exits include the values written to the “exit reason” and “exit qualification” VMCS fields.
INIT and SIPI events.

o TSX aborts, including the abort status returned for the RTM instructions.

o Shutdown.

Additionally, it provides indication of the status of the Interrupt Flag
(IF), to indicate when interrupts are masked.
</quote>

ARM CoreSight:

- Use advertised caps/min_interval as default sample_period on ARM spe.

- Update deduction of TRCCONFIGR register for branch broadcast on ARM's CoreSight ETM.

Vendor Events (JSON):

Intel:

- Update events and metrics for:

    Alderlake, Broadwell, Broadwell DE, BroadwellX, CascadelakeX, Elkhartlake,
    Bonnell, Goldmont, GoldmontPlus, Westmere EP-DP, Haswell, HaswellX,
    Icelake, IcelakeX, Ivybridge, Ivytown, Jaketown, Knights Landing,
    Nehalem EP, Sandybridge, Silvermont, Skylake, Skylake Server, SkylakeX,
    Tigerlake, TremontX, Westmere EP-SP, Westmere EX.

ARM:

- Add support for HiSilicon CPA PMU aliasing.

perf stat:

- Fix forked applications enablement of counters.

- The 'slots' should only be printed on a different order than the one specified
  on the command line when 'topdown' events are present, fix it.

Miscellaneous:

- Sync msr-index, cpufeatures header files with the kernel sources.

- Stop using some deprecated libbpf APIs in 'perf trace'.

- Fix some spelling mistakes.

- Refactor the maps pointers usage to pave the way for using refcount debugging.

- Only offer the --tui option on perf top, report and annotate when perf was
  built with libslang.

- Don't mention --to-ctf in 'perf data --help' when not linking with the required
  library, libbabeltrace.

- Use ARRAY_SIZE() instead of ad hoc equivalent, spotted by array_size.cocci.

- Enhance the matching of sub-commands abbreviations:
	'perf c2c rec' -> 'perf c2c record'
	'perf c2c recport -> error

- Set build-id using build-id header on new mmap records.

- Fix generation of 'perf --version' string.

perf test:

- Add test for the arm_spe event.

- Add test to check unwinding using fame-pointer (fp) mode on arm64.

- Make metric testing more robust in 'perf test'.

- Add error message for unsupported branch stack cases.

libperf:

- Add API for allocating new thread map array.

- Fix typo in perf_evlist__open() failure error messages in libperf tests.

perf c2c:

- Replace bitmap_weight() with bitmap_empty() where appropriate.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (25):
      perf intel-pt: pkt-decoder-test: Fix scope of test_data
      perf intel-pt: pkt-decoder: Remove misplaced linebreak
      perf intel-pt: pkt-decoder: Add CFE and EVD packets
      perf intel-pt: pkt-decoder: Add MODE.Exec IFLAG bit
      perf intel-pt: decoder: Add config bit definitions
      perf intel-pt: decoder: Factor out clearing of FUP (Flow Update) event variables
      perf intel-pt: decoder: Add CFE (Control Flow Event) and EVD (Event Data) processing
      perf intel-pt: decoder: Add MODE.Exec IFLAG processing
      perf tools: Define Intel PT CFE (Control Flow Event) / EVD (Event Data) event
      perf tools: Define Intel PT iflag synthesized event
      perf tools: Define new D (Intr Disable) and t (Intr Toggle) flags
      perf auxtrace: Add itrace option "I"
      perf intel-pt: Record Event Trace capability flag
      perf intel-pt: Synthesize CFE (Control Flow Event) / EVD (Event Data) event
      perf intel-pt: Synthesize iflag event
      perf intel-pt: Synthesize new D (Intr Disabled) and t (Intr Toggle) flags
      perf intel-pt: Force 'quick' mode when TNT (Taken/Not-Taken packet) is disabled
      perf script: Display Intel PT CFE (Control Flow Event) / EVD (Event Data) synthesized event
      perf script: Display Intel PT iflag synthesized event
      perf script: Display new D (Intr Disabled) and t (Intr Toggle) flags
      perf scripts python: intel-pt-events.py: Add Event Trace
      perf scripting python: Add all sample flags to DB export
      perf scripts python: export-to-sqlite.py: Export all sample flags
      perf scripts python: export-to-postgresql.py: Export all sample flags
      perf intel-pt: Add documentation for Event Trace and TNT disable

Alexey Bayduraev (17):
      perf record: Introduce thread affinity and mmap masks
      tools lib: Introduce fdarray duplicate function
      perf record: Introduce thread specific data array
      perf record: Introduce function to propagate control commands
      perf record: Introduce thread local variable
      perf record: Stop threads in the end of trace streaming
      perf record: Start threads in the beginning of trace streaming
      perf record: Introduce data file at mmap buffer object
      perf record: Introduce bytes written stats
      perf record: Introduce compressor at mmap buffer object
      perf record: Introduce data transferred and compressed stats
      perf record: Introduce --threads command line option
      perf record: Extend --threads command line option
      perf record: Implement compatibility checks
      perf session: Load data directory files for analysis
      perf report: Output data file name in raw trace dump
      perf data: Adding error message if perf_data__create_dir() fails

Ali Saidi (1):
      tools arm64: Import cputype.h

Arnaldo Carvalho de Melo (7):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      perf python: Add perf_env stubs that will be needed in evsel__open_strerror()

Christy Lee (2):
      perf bpf: Stop using deprecated bpf_load_program() API
      perf bpf: Stop using deprecated bpf_object__next() API

Colin Ian King (3):
      perf tools: Fix spelling mistake "commpressor" -> "compressor"
      perf header: Fix spelling mistake "could't" -> "couldn't"
      perf build-id: Fix spelling mistake "Cant" -> "Can't"

German Gomez (3):
      perf arm-spe: Use advertised caps/min_interval as default sample_period
      perf test: Add perf_event_attr tests for the arm_spe event
      perf test arm64: Test unwinding using fame-pointer (fp) mode

Guo Zhengkui (1):
      perf tools: Use ARRAY_SIZE() instead of ad hoc equivalent, spotted by array_size.cocci

Ian Rogers (46):
      perf cpumap: Migrate to libperf cpumap api
      perf cpumap: Use for each loop
      perf map: Add const to map_ip and unmap_ip
      perf namespaces: Add functions to access nsinfo
      perf maps: Use a pointer for kmaps
      perf test: Use pointer for maps
      perf maps: Reduce scope of init and exit
      perf maps: Move maps code to own C file
      perf map: Make map__contains_symbol() args const
      perf test: Allow skip for all metrics test
      perf vendor events: Update metrics for SkyLake Server
      perf vendor events: Update metrics for Broadwell DE
      perf vendor events: Update metrics for CascadelakeX
      perf vendor events: Update metrics for HaswellX
      perf vendor events: Update metrics for Ivybridge
      perf vendor events: Update for Westmere EP-DP
      perf vendor events: Update metrics for IcelakeX
      perf vendor events: Update for Bonnell
      perf vendor events: Update metrics for Broadwell
      perf vendor events: Update metrics for BroadwellX
      perf vendor events: Update for Goldmont
      perf vendor events: Update for GoldmontPlus
      perf vendor events: Update metrics for Haswell
      perf vendor events: Update metrics for Icelake
      perf vendor events: Update metrics for Ivytown
      perf vendor events: Update metrics for Jaketown
      perf vendor events: Update Knights Landing
      perf vendor events: Update Nehalem EP
      perf vendor events: Update metrics for Skylake
      perf vendor events: Update Sandybridge
      perf vendor events: Update Silvermont
      perf vendor events: Update Tigerlake
      perf vendor events: Update Westmere EP-SP
      perf vendor events: Update Westmere EX
      perf vendor events: Update TremontX
      perf tui: Only support --tui with slang
      perf test: Make metric testing more robust
      perf vendor events intel: Update events for CascadelakeX
      perf vendor events intel: Update events for Elkhartlake
      perf vendor events intel: Update events for Icelake
      perf vendor events intel: Update events for IcelakeX
      perf vendor events intel: Update events for Skylake
      perf vendor events intel: Update events for SkylakeX
      perf vendor events intel: Update events for Tigerlake
      perf vendor events intel: Update events for TremontX
      perf parse-events: Move slots only with topdown

James Clark (6):
      perf cs-etm: Update deduction of TRCCONFIGR register for branch broadcast
      perf evsel: Add error message for unsupported branch stack cases
      perf session: Print branch stack entry type in --dump-raw-trace
      perf script: Refactor branch stack printing
      perf script: Output branch sample type
      perf tools: Set build-id using build-id header on new mmap records

Jiri Olsa (2):
      perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
      perf tools: Remove bpf_map__set_priv()/bpf_map__priv() usage

John Garry (2):
      perf tools: Fix dependency for version file creation
      perf tools: Fix version kernel tag

Kan Liang (1):
      perf script: Add 'brstackinsnlen' for branch stacks

Kim Phillips (2):
      perf evsel: Make evsel__env() always return a valid env
      perf evsel: Improve AMD IBS (Instruction-Based Sampling) error handling messages

Mahmoud Mandour (1):
      perf data: Don't mention --to-ctf if it's not supported

Namhyung Kim (14):
      perf tools: Try chroot'ed filename when opening dso/symbol
      perf inject: Try chroot directory when reading build-id
      perf annotate: Try chroot filename for objdump
      perf lock: Convert lockhash_table to use hlist
      perf lock: Change type of lock_stat->addr to u64
      perf lock: Sort map info based on class name
      perf lock: Fix lock name length check for printing
      perf lock: Add -c/--combine-locks option
      perf lock: Carefully combine lock stats for discarded entries
      perf ftrace latency: Add -n/--use-nsec option
      perf ftrace latency: Update documentation
      perf lock: Add --synth=no option for record
      perf lock: Extend struct lock_key to have print function
      perf lock: Add -F/--field option to control output

Qi Liu (1):
      perf jevents: Add support for HiSilicon CPA PMU aliasing

Rasmus Villemoes (1):
      tools compiler.h: Remove duplicate #ifndef noinline block

Shunsuke Nakamura (1):
      libperf tests: Fix typo in perf_evlist__open() failure error messages

Stephane Eranian (1):
      perf report: Add "addr_from" and "addr_to" sort dimensions

Thomas Richter (1):
      perf stat: Fix forked applications enablement of counters

Tzvetomir Stoyanov (VMware) (2):
      libperf: Rename arguments of perf_thread_map APIs
      libperf: Add API for allocating new thread map array

Wei Li (1):
      perf tools: Enhance the matching of sub-commands abbreviations

Yury Norov (1):
      perf c2c: Replace bitmap_weight() with bitmap_empty() where appropriate

Zhengjun Xing (2):
      perf vendor events intel: Add core event list for Alderlake
      perf vendor events intel: Add uncore event list for Alderlake

tangmeng (2):
      perf top: Remove redundant 'err' variable
      perf annotate: Remove redundant 'ret' variable

 tools/arch/arm64/include/asm/cputype.h             |  258 +
 tools/arch/x86/include/asm/cpufeatures.h           |    7 +-
 tools/arch/x86/include/asm/disabled-features.h     |    7 +-
 tools/arch/x86/include/asm/msr-index.h             |    6 +
 tools/include/linux/compiler.h                     |    4 -
 tools/include/linux/coresight-pmu.h                |    2 +
 tools/lib/api/fd/array.c                           |   17 +
 tools/lib/api/fd/array.h                           |    1 +
 tools/lib/perf/Documentation/libperf.txt           |    7 +-
 tools/lib/perf/include/perf/threadmap.h            |    7 +-
 tools/lib/perf/libperf.map                         |    1 +
 tools/lib/perf/tests/test-evlist.c                 |    8 +-
 tools/lib/perf/tests/test-threadmap.c              |   41 +
 tools/lib/perf/threadmap.c                         |   36 +-
 tools/perf/Documentation/itrace.txt                |    2 +
 tools/perf/Documentation/perf-ftrace.txt           |   75 +-
 tools/perf/Documentation/perf-intel-pt.txt         |  104 +-
 tools/perf/Documentation/perf-lock.txt             |   10 +
 tools/perf/Documentation/perf-record.txt           |   34 +
 tools/perf/Documentation/perf-script.txt           |   21 +-
 tools/perf/Makefile.perf                           |    4 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    3 +
 tools/perf/arch/arm64/util/arm-spe.c               |    2 +-
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |   17 +-
 tools/perf/arch/x86/util/event.c                   |    2 +-
 tools/perf/arch/x86/util/evlist.c                  |   18 +-
 tools/perf/arch/x86/util/intel-pt.c                |    7 +
 tools/perf/builtin-annotate.c                      |   14 +-
 tools/perf/builtin-c2c.c                           |    9 +-
 tools/perf/builtin-data.c                          |    7 +
 tools/perf/builtin-ftrace.c                        |   24 +-
 tools/perf/builtin-inject.c                        |   15 +-
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-kvm.c                           |   11 +-
 tools/perf/builtin-lock.c                          |  298 +-
 tools/perf/builtin-mem.c                           |    5 +-
 tools/perf/builtin-probe.c                         |    2 +-
 tools/perf/builtin-record.c                        | 1166 ++-
 tools/perf/builtin-report.c                        |   10 +-
 tools/perf/builtin-sched.c                         |    4 +-
 tools/perf/builtin-script.c                        |  154 +-
 tools/perf/builtin-stat.c                          |    6 +-
 tools/perf/builtin-timechart.c                     |    3 +-
 tools/perf/builtin-top.c                           |   10 +-
 tools/perf/builtin-trace.c                         |    2 +-
 tools/perf/check-headers.sh                        |    1 +
 .../arch/arm64/hisilicon/hip09/sys/uncore-cpa.json |   81 +
 .../perf/pmu-events/arch/x86/alderlake/cache.json  | 1140 +++
 .../arch/x86/alderlake/floating-point.json         |  158 +
 .../pmu-events/arch/x86/alderlake/frontend.json    |  491 ++
 .../perf/pmu-events/arch/x86/alderlake/memory.json |  318 +
 .../perf/pmu-events/arch/x86/alderlake/other.json  |  146 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    | 1721 +++++
 .../arch/x86/alderlake/uncore-memory.json          |  222 +
 .../arch/x86/alderlake/uncore-other.json           |   40 +
 .../arch/x86/alderlake/virtual-memory.json         |  258 +
 tools/perf/pmu-events/arch/x86/bonnell/cache.json  |  748 +-
 .../arch/x86/bonnell/floating-point.json           |  274 +-
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |   96 +-
 tools/perf/pmu-events/arch/x86/bonnell/memory.json |  152 +-
 tools/perf/pmu-events/arch/x86/bonnell/other.json  |  452 +-
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |  402 +-
 .../arch/x86/bonnell/virtual-memory.json           |  126 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  353 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  | 4713 ++++++------
 .../arch/x86/broadwell/floating-point.json         |  235 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |  361 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json | 4312 +++++------
 .../perf/pmu-events/arch/x86/broadwell/other.json  |   42 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    | 1903 +++--
 .../arch/x86/broadwell/virtual-memory.json         |  412 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |  407 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     | 1122 +--
 .../arch/x86/broadwellde/floating-point.json       |  222 +-
 .../pmu-events/arch/x86/broadwellde/frontend.json  |  335 +-
 .../pmu-events/arch/x86/broadwellde/memory.json    |  608 +-
 .../pmu-events/arch/x86/broadwellde/other.json     |   28 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  | 1892 +++--
 .../arch/x86/broadwellde/virtual-memory.json       |  394 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  351 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json | 1300 ++--
 .../arch/x86/broadwellx/floating-point.json        |  224 +-
 .../pmu-events/arch/x86/broadwellx/frontend.json   |  335 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |  974 +--
 .../perf/pmu-events/arch/x86/broadwellx/other.json |   28 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   | 1891 +++--
 .../arch/x86/broadwellx/virtual-memory.json        |  394 +-
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 7809 ++++++++++++++++++--
 .../arch/x86/cascadelakex/clx-metrics.json         |  469 +-
 .../arch/x86/cascadelakex/floating-point.json      |   50 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   18 +-
 .../pmu-events/arch/x86/cascadelakex/memory.json   | 1008 +--
 .../pmu-events/arch/x86/cascadelakex/other.json    | 7462 ++-----------------
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   11 +
 .../arch/x86/cascadelakex/uncore-other.json        |   23 +
 .../pmu-events/arch/x86/elkhartlake/other.json     |  241 -
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |  241 +
 tools/perf/pmu-events/arch/x86/goldmont/cache.json | 1466 ++--
 .../arch/x86/goldmont/floating-point.json          |   33 +
 .../pmu-events/arch/x86/goldmont/frontend.json     |   78 +-
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |   38 +-
 tools/perf/pmu-events/arch/x86/goldmont/other.json |   92 +-
 .../pmu-events/arch/x86/goldmont/pipeline.json     |  538 +-
 .../arch/x86/goldmont/virtual-memory.json          |   94 +-
 .../pmu-events/arch/x86/goldmontplus/cache.json    | 1730 +++--
 .../arch/x86/goldmontplus/floating-point.json      |   38 +
 .../pmu-events/arch/x86/goldmontplus/frontend.json |   88 +-
 .../pmu-events/arch/x86/goldmontplus/memory.json   |   44 +-
 .../pmu-events/arch/x86/goldmontplus/other.json    |  106 +-
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |  616 +-
 .../arch/x86/goldmontplus/virtual-memory.json      |  214 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  | 1446 ++--
 .../arch/x86/haswell/floating-point.json           |  129 +-
 .../perf/pmu-events/arch/x86/haswell/frontend.json |  362 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  265 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json | 1004 +--
 tools/perf/pmu-events/arch/x86/haswell/other.json  |   40 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json | 1796 +++--
 .../pmu-events/arch/x86/haswell/uncore-cache.json  |  252 +
 .../pmu-events/arch/x86/haswell/uncore-other.json  |   69 +
 tools/perf/pmu-events/arch/x86/haswell/uncore.json |  374 -
 .../arch/x86/haswell/virtual-memory.json           |  552 +-
 tools/perf/pmu-events/arch/x86/haswellx/cache.json | 1434 ++--
 .../arch/x86/haswellx/floating-point.json          |  116 +-
 .../pmu-events/arch/x86/haswellx/frontend.json     |  336 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  263 +-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  | 1070 +--
 tools/perf/pmu-events/arch/x86/haswellx/other.json |   28 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     | 1763 +++--
 .../arch/x86/haswellx/virtual-memory.json          |  512 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  | 1321 +++-
 .../arch/x86/icelake/floating-point.json           |   69 +-
 .../perf/pmu-events/arch/x86/icelake/frontend.json |  449 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  338 +-
 tools/perf/pmu-events/arch/x86/icelake/memory.json |  591 +-
 tools/perf/pmu-events/arch/x86/icelake/other.json  |  862 +--
 .../perf/pmu-events/arch/x86/icelake/pipeline.json | 1118 +--
 .../arch/x86/icelake/virtual-memory.json           |  178 +-
 tools/perf/pmu-events/arch/x86/icelakex/cache.json | 1137 ++-
 .../arch/x86/icelakex/floating-point.json          |   51 +-
 .../pmu-events/arch/x86/icelakex/frontend.json     |  501 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  304 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |  613 +-
 tools/perf/pmu-events/arch/x86/icelakex/other.json |  549 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     | 1135 +--
 .../pmu-events/arch/x86/icelakex/uncore-other.json |   61 +-
 .../arch/x86/icelakex/virtual-memory.json          |  150 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  | 1446 ++--
 .../arch/x86/ivybridge/floating-point.json         |  212 +-
 .../pmu-events/arch/x86/ivybridge/frontend.json    |  386 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  287 +-
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |  290 +-
 .../perf/pmu-events/arch/x86/ivybridge/other.json  |   42 +-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    | 1769 +++--
 .../arch/x86/ivybridge/uncore-cache.json           |  252 +
 .../arch/x86/ivybridge/uncore-other.json           |   91 +
 .../perf/pmu-events/arch/x86/ivybridge/uncore.json |  314 -
 .../arch/x86/ivybridge/virtual-memory.json         |  208 +-
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  | 1594 ++--
 .../arch/x86/ivytown/floating-point.json           |  212 +-
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |  386 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  277 +-
 tools/perf/pmu-events/arch/x86/ivytown/memory.json |  562 +-
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |   42 +-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json | 1769 +++--
 .../arch/x86/ivytown/virtual-memory.json           |  232 +-
 tools/perf/pmu-events/arch/x86/jaketown/cache.json | 1582 ++--
 .../arch/x86/jaketown/floating-point.json          |  160 +-
 .../pmu-events/arch/x86/jaketown/frontend.json     |  363 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  140 +-
 .../perf/pmu-events/arch/x86/jaketown/memory.json  |  478 +-
 tools/perf/pmu-events/arch/x86/jaketown/other.json |   58 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     | 1556 ++--
 .../arch/x86/jaketown/virtual-memory.json          |  178 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  | 2602 ++++---
 .../arch/x86/knightslanding/floating-point.json    |   29 +
 .../arch/x86/knightslanding/frontend.json          |   48 +-
 .../pmu-events/arch/x86/knightslanding/memory.json | 1226 +--
 .../arch/x86/knightslanding/pipeline.json          |  465 +-
 .../arch/x86/knightslanding/virtual-memory.json    |   68 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    2 +
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  | 3062 ++++----
 .../arch/x86/nehalemep/floating-point.json         |  180 +-
 .../pmu-events/arch/x86/nehalemep/frontend.json    |   18 +-
 .../perf/pmu-events/arch/x86/nehalemep/memory.json |  670 +-
 .../perf/pmu-events/arch/x86/nehalemep/other.json  |  156 +-
 .../pmu-events/arch/x86/nehalemep/pipeline.json    |  764 +-
 .../arch/x86/nehalemep/virtual-memory.json         |   90 +-
 .../pmu-events/arch/x86/sandybridge/cache.json     | 2298 +++---
 .../arch/x86/sandybridge/floating-point.json       |  172 +-
 .../pmu-events/arch/x86/sandybridge/frontend.json  |  365 +-
 .../pmu-events/arch/x86/sandybridge/memory.json    |  520 +-
 .../pmu-events/arch/x86/sandybridge/other.json     |   66 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  | 1634 ++--
 .../arch/x86/sandybridge/snb-metrics.json          |  150 +-
 .../arch/x86/sandybridge/uncore-cache.json         |  252 +
 .../arch/x86/sandybridge/uncore-other.json         |   91 +
 .../pmu-events/arch/x86/sandybridge/uncore.json    |  314 -
 .../arch/x86/sandybridge/virtual-memory.json       |  160 +-
 .../perf/pmu-events/arch/x86/silvermont/cache.json |  940 ++-
 .../arch/x86/silvermont/floating-point.json        |   11 +
 .../pmu-events/arch/x86/silvermont/frontend.json   |   75 +-
 .../pmu-events/arch/x86/silvermont/memory.json     |    8 +-
 .../perf/pmu-events/arch/x86/silvermont/other.json |   20 +-
 .../pmu-events/arch/x86/silvermont/pipeline.json   |  422 +-
 .../arch/x86/silvermont/virtual-memory.json        |   76 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json  | 2657 +++----
 .../arch/x86/skylake/floating-point.json           |   48 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |  578 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json | 1566 ++--
 tools/perf/pmu-events/arch/x86/skylake/other.json  |   36 -
 .../perf/pmu-events/arch/x86/skylake/pipeline.json | 1083 +--
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  497 +-
 .../arch/x86/skylake/virtual-memory.json           |  274 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  147 +-
 .../arch/x86/skylakex/floating-point.json          |   24 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |   18 +-
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |   96 +-
 tools/perf/pmu-events/arch/x86/skylakex/other.json |   36 -
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   11 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  461 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json |   23 +
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |  130 +-
 .../arch/x86/tigerlake/floating-point.json         |   11 +-
 .../pmu-events/arch/x86/tigerlake/frontend.json    |   17 +-
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |  129 -
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |   80 +-
 tools/perf/pmu-events/arch/x86/tremontx/cache.json | 1111 ++-
 .../arch/x86/tremontx/floating-point.json          |   36 +
 .../pmu-events/arch/x86/tremontx/frontend.json     |   97 +-
 .../perf/pmu-events/arch/x86/tremontx/memory.json  |  436 +-
 tools/perf/pmu-events/arch/x86/tremontx/other.json |  680 +-
 .../pmu-events/arch/x86/tremontx/pipeline.json     |  659 +-
 .../arch/x86/tremontx/uncore-memory.json           |  156 +-
 .../pmu-events/arch/x86/tremontx/uncore-other.json | 2046 ++++-
 .../arch/x86/tremontx/virtual-memory.json          |  331 +-
 .../pmu-events/arch/x86/westmereep-dp/cache.json   | 2734 +++----
 .../arch/x86/westmereep-dp/floating-point.json     |  180 +-
 .../arch/x86/westmereep-dp/frontend.json           |   18 +-
 .../pmu-events/arch/x86/westmereep-dp/memory.json  |  686 +-
 .../pmu-events/arch/x86/westmereep-dp/other.json   |  238 +-
 .../arch/x86/westmereep-dp/pipeline.json           |  780 +-
 .../arch/x86/westmereep-dp/virtual-memory.json     |  138 +-
 .../pmu-events/arch/x86/westmereep-sp/cache.json   | 3142 ++++----
 .../arch/x86/westmereep-sp/floating-point.json     |  180 +-
 .../arch/x86/westmereep-sp/frontend.json           |   18 +-
 .../pmu-events/arch/x86/westmereep-sp/memory.json  |  670 +-
 .../pmu-events/arch/x86/westmereep-sp/other.json   |  238 +-
 .../arch/x86/westmereep-sp/pipeline.json           |  780 +-
 .../arch/x86/westmereep-sp/virtual-memory.json     |  120 +-
 .../perf/pmu-events/arch/x86/westmereex/cache.json | 3142 ++++----
 .../arch/x86/westmereex/floating-point.json        |  180 +-
 .../pmu-events/arch/x86/westmereex/frontend.json   |   18 +-
 .../pmu-events/arch/x86/westmereex/memory.json     |  676 +-
 .../perf/pmu-events/arch/x86/westmereex/other.json |  238 +-
 .../pmu-events/arch/x86/westmereex/pipeline.json   |  784 +-
 .../arch/x86/westmereex/virtual-memory.json        |  138 +-
 tools/perf/pmu-events/jevents.c                    |    1 +
 tools/perf/scripts/python/export-to-postgresql.py  |   17 +-
 tools/perf/scripts/python/export-to-sqlite.py      |   19 +-
 tools/perf/scripts/python/intel-pt-events.py       |   55 +-
 tools/perf/tests/attr/README                       |    2 +
 tools/perf/tests/attr/base-record-spe              |   40 +
 tools/perf/tests/attr/test-record-spe-period       |   12 +
 tools/perf/tests/attr/test-record-spe-period-term  |   12 +
 tools/perf/tests/bpf.c                             |   14 +-
 tools/perf/tests/cpumap.c                          |   12 +-
 tools/perf/tests/maps.c                            |   20 +-
 tools/perf/tests/pmu-events.c                      |   32 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |   10 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |   68 +
 tools/perf/tests/vmlinux-kallsyms.c                |    8 +-
 tools/perf/util/Build                              |    1 +
 tools/perf/util/PERF-VERSION-GEN                   |   13 +-
 tools/perf/util/annotate.c                         |   10 +
 tools/perf/util/auxtrace.c                         |    4 +
 tools/perf/util/auxtrace.h                         |    4 +
 tools/perf/util/bpf-event.c                        |   15 +-
 tools/perf/util/bpf-loader.c                       |  254 +-
 tools/perf/util/bpf_ftrace.c                       |    2 +
 tools/perf/util/bpf_skel/func_latency.bpf.c        |    6 +-
 tools/perf/util/build-id.c                         |    6 +-
 tools/perf/util/callchain.c                        |    2 +-
 tools/perf/util/data.c                             |    8 +-
 tools/perf/util/dso.c                              |   15 +-
 tools/perf/util/dso.h                              |    1 +
 tools/perf/util/dsos.c                             |   13 +
 tools/perf/util/event.c                            |    6 +-
 tools/perf/util/event.h                            |   45 +-
 tools/perf/util/evlist.c                           |   16 +
 tools/perf/util/evlist.h                           |    1 +
 tools/perf/util/evsel.c                            |   31 +-
 tools/perf/util/ftrace.h                           |    1 +
 tools/perf/util/header.c                           |    3 +-
 tools/perf/util/hist.c                             |    2 +
 tools/perf/util/hist.h                             |    2 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  245 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   21 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   47 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |    3 +
 tools/perf/util/intel-pt.c                         |  164 +-
 tools/perf/util/jitdump.c                          |   10 +-
 tools/perf/util/machine.c                          |   38 +-
 tools/perf/util/machine.h                          |    8 +-
 tools/perf/util/map.c                              |  456 +-
 tools/perf/util/map.h                              |   26 +-
 tools/perf/util/maps.c                             |  403 +
 tools/perf/util/maps.h                             |    2 -
 tools/perf/util/mmap.c                             |   10 +
 tools/perf/util/mmap.h                             |    3 +
 tools/perf/util/namespaces.c                       |   50 +-
 tools/perf/util/namespaces.h                       |   10 +-
 tools/perf/util/ordered-events.c                   |    3 +-
 tools/perf/util/ordered-events.h                   |    3 +-
 tools/perf/util/pmu.c                              |   14 +-
 tools/perf/util/probe-event.c                      |    2 +-
 tools/perf/util/python.c                           |   13 +-
 tools/perf/util/record.h                           |    2 +
 .../util/scripting-engines/trace-event-python.c    |    3 +-
 tools/perf/util/session.c                          |  213 +-
 tools/perf/util/session.h                          |    3 +-
 tools/perf/util/sort.c                             |  128 +
 tools/perf/util/sort.h                             |    2 +
 tools/perf/util/symbol.c                           |   18 +-
 tools/perf/util/tool.h                             |    3 +-
 tools/perf/util/top.h                              |    5 +-
 tools/perf/util/trace-event-parse.c                |    2 +-
 tools/perf/util/util.c                             |   31 +
 tools/perf/util/util.h                             |    2 +
 329 files changed, 77801 insertions(+), 61187 deletions(-)
 create mode 100644 tools/arch/arm64/include/asm/cputype.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
 create mode 100644 tools/perf/tests/attr/base-record-spe
 create mode 100644 tools/perf/tests/attr/test-record-spe-period
 create mode 100644 tools/perf/tests/attr/test-record-spe-period-term
 create mode 100755 tools/perf/tests/shell/test_arm_callgraph_fp.sh
 create mode 100644 tools/perf/util/maps.c

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

There is also a strange one with openmandriva:4.2 and openmandriva:cooker,
where on the feature build test it doesn't manage to find libpthread, because
the pthread functions (and the ones in librt, IIRC) are on the main libc, so a
test for that is needed to avoid adding '-lpthread and -lrt' in distros where
this is the case. It's in the TODO list.

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

Ubuntu 22.04 now also has some LLVM/clang library problem to be investigated, again
this isn't in the default set of libraries built into perf.

And finally there is a problem when linking with libtraceevent-devel dynamicly on
fedora:36, will be investigated.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.17.0.tar.xz
  $ time dm
   1   102.14 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    57.59 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    56.29 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    59.50 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    66.52 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    64.92 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    68.14 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8    93.02 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   104.74 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   111.07 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   119.80 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12   106.45 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   107.77 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14    99.64 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  15    54.68 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  16    81.78 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  17    80.27 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  18    80.17 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
  19    61.32 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  20    90.92 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  21    94.43 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  22    83.58 archlinux:base                : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  23    87.29 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  24    94.61 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
  25    51.83 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220316 releases/gcc-11.2.0-860-g6a1150d152 , clang version 13.0.0
  26    69.72 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  27    65.52 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  28    90.01 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  29   105.55 debian:experimental           : Ok   gcc (Debian 11.2.0-18) 11.2.0 , Debian clang version 13.0.1-3+b1
  30    25.47 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  31    20.55 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  32    22.66 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  33    23.66 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  34    23.25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  35    58.79 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  36    70.22 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  37    18.54 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  38    72.03 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  39    86.18 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  40    97.80 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  41   100.12 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  42   103.42 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  43   120.37 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  44   101.73 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  45    93.54 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  46    93.73 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  47    96.22 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  48    21.25 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  49    19.13 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  50   100.96 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  51    30.58 fedora:36                     : FAIL gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC) 
    + make PYTHON=python3 ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf
    make: Entering directory '/git/perf-5.17.0/tools/perf'
      BUILD:   Doing 'make -j32' parallel build
    Makefile.config:725: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
    Makefile.config:1005: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
    Makefile.config:1112: *** Error: No libtraceevent devel library found, please install libtraceevent-devel.  Stop.
  52   110.28 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220308 (Red Hat 12.0.1-0) , clang version 13.0.1 (Fedora 13.0.1-1.fc37)
  53    83.08 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  54    72.33 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  55    42.01 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.17.0/tools/build/Makefile.build:139: util] Error 2
  56    93.82 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  57     6.78 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
  58     6.67 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
  59   109.63 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  60   114.45 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  61   108.93 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  62   125.47 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  63   126.78 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  64   140.14 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
  65   102.25 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  66   102.44 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  67    76.96 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  68    20.14 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    20.54 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    20.34 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71    20.25 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  72    20.15 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  73    20.25 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  74    82.35 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  75    21.24 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    21.74 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    17.53 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    20.75 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    22.35 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    22.46 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81   100.44 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    19.45 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  83    20.35 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  84    18.94 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  85    78.76 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 

  86    23.25 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  87    76.46 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  88    90.71 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  89    91.90 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  90    88.79 ubuntu:22.04                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-18ubuntu1) 
    util/c++/clang.cpp:23:10: fatal error: llvm/Support/TargetRegistry.h: No such file or directory
       23 | #include "llvm/Support/TargetRegistry.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    make[4]: *** [/git/perf-5.17.0/tools/build/Makefile.build:139: c++] Error 2
    make[3]: *** [/git/perf-5.17.0/tools/build/Makefile.build:139: util] Error 2
  BUILD_TARBALL_HEAD=ab0809af0bee88b689ba289ec8c40aa2be3a17ec
  91 6170.58

  real	104m41.330s
  user	0m50.827s
  sys	0m59.998s
  $ 

  $ uname -a
  Linux quaco 5.16.13-200.fc35.x86_64 #1 SMP PREEMPT Tue Mar 8 22:50:58 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  ab0809af0bee88b6 (HEAD -> perf/core, seventh/perf/core, five/perf/core, acme.korg/tmp.perf/core) perf evsel: Improve AMD IBS (Instruction-Based Sampling) error handling messages
  $ perf -v
  perf version 5.17.gab0809af0bee
  $ sudo su -
  # perf -vv
  perf version 5.17.gab0809af0bee
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
  # perf test
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
   90: perf all metrics test                                           : FAILED!
   91: perf all PMU test                                               : Ok
   92: perf stat --bpf-counters test                                   : Ok
   93: Check Arm64 callgraphs are complete in fp mode                  : Skip
   94: Check Arm CoreSight trace data recording and synthesized samples: Skip
   95: Check Arm SPE trace data recording and synthesized samples      : Skip
   96: Check open filename arg using perf trace + vfs_getname          : Ok
  #

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ git log --oneline -1 ; time make -C tools/perf build-test
  ab0809af0bee88b6 (HEAD -> perf/core) perf evsel: Improve AMD IBS (Instruction-Based Sampling) error handling messages
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.PKFwox5pEQ
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.BvsBD13Qpu
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_no_sdt_O: make NO_SDT=1
               make_no_slang_O: make NO_SLANG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_pure_O: make
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_install_bin_O: make install-bin
            make_no_demangle_O: make NO_DEMANGLE=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_backtrace_O: make NO_BACKTRACE=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                   make_tags_O: make tags
                 make_perf_o_O: make perf.o
                make_install_O: make install
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
              make_no_libelf_O: make NO_LIBELF=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
                make_no_gtk2_O: make NO_GTK2=1
                    make_doc_O: make doc
                   make_help_O: make help
             make_no_libperl_O: make NO_LIBPERL=1
              make_clean_all_O: make clean all
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                  make_debug_O: make DEBUG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_no_newt_O: make NO_NEWT=1
           make_with_libpfm4_O: make LIBPFM4=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_with_coresight_O: make CORESIGHT=1
             make_util_map_o_O: make util/map.o
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	4m32.728s
  user	55m21.864s
  sys	13m26.278s
  $
