Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8724D58A2C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiHDVfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiHDVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:35:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E76357DF;
        Thu,  4 Aug 2022 14:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21766B825BA;
        Thu,  4 Aug 2022 21:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66125C433D7;
        Thu,  4 Aug 2022 21:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659648905;
        bh=uPO2NLviA4o1Br8gg6vvELq1OXDlm/M0j1252V2iyG0=;
        h=From:To:Cc:Subject:Date:From;
        b=HGVNY0LasiLw1s8bG0DwfYpwCoxnUFbcyaNYqBC4R19c7BkNMsnaNIUyGBnGY3e/n
         /MvAYPUUFk1aqXaY/HMk7nCe8XxNFiRKIz3p6O2fjnSyMPqfy8On8ayfVs4iaCydfR
         FPqcxmoAP7LMB16Z54anNg/6rb1J+yfpPQCwKfQ0+ACD2BzR96lK7WN24gq3jVJOd5
         EndiVLHUpUNSBCbhZ7r6hSG2CAoKMkXq6ybL7CLYH/VJ5g8HTwlBcIcfgRaSJbDh5T
         2q0kLgMuGpOjXjQrYmAwLGgbfmHksMfrecB8/C1IfQzR9uOSP9lnHHIU3xCOy2xigu
         /i4pGJ1Vhe4qg==
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
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Blake Jones <blakejones@google.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Shawn M . Chapla" <schapla@codeweavers.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.0: 1st batch
Date:   Thu,  4 Aug 2022 18:34:57 -0300
Message-Id: <20220804213457.500335-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Tests at the end of this message.

The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.0-2022-08-04

for you to fetch changes up to bb8bc52e75785af94b9ba079277547d50d018a52:

  perf stat: Refactor __run_perf_stat() common code (2022-08-03 13:02:50 -0300)

----------------------------------------------------------------
perf tools changes for v6.0: 1st batch

- Introduce 'perf lock contention' subtool, using new lock contention
  tracepoints and using BPF for in kernel aggregation and then userspace
  processing using the perf tooling infrastructure for resolving symbols, target
  specification, etc.

  Since the new lock contention tracepoints don't provide lock names, get up to
  8 stack traces and display the first non-lock function symbol name as a caller:

  $ perf lock report -F acquired,contended,avg_wait,wait_total

                  Name   acquired  contended     avg wait    total wait

   update_blocked_a...         40         40      3.61 us     144.45 us
   kernfs_fop_open+...          5          5      3.64 us      18.18 us
    _nohz_idle_balance          3          3      2.65 us       7.95 us
   tick_do_update_j...          1          1      6.04 us       6.04 us
    ep_scan_ready_list          1          1      3.93 us       3.93 us

  Supports the usual 'perf record' + 'perf report' workflow as well as a
  BCC/bpftrace like mode where you start the tool and then press control+C to get
  results:

   $ sudo perf lock contention -b
  ^C
   contended   total wait     max wait     avg wait         type   caller

          42    192.67 us     13.64 us      4.59 us     spinlock   queue_work_on+0x20
          23     85.54 us     10.28 us      3.72 us     spinlock   worker_thread+0x14a
           6     13.92 us      6.51 us      2.32 us        mutex   kernfs_iop_permission+0x30
           3     11.59 us     10.04 us      3.86 us        mutex   kernfs_dop_revalidate+0x3c
           1      7.52 us      7.52 us      7.52 us     spinlock   kthread+0x115
           1      7.24 us      7.24 us      7.24 us     rwlock:W   sys_epoll_wait+0x148
           2      7.08 us      3.99 us      3.54 us     spinlock   delayed_work_timer_fn+0x1b
           1      6.41 us      6.41 us      6.41 us     spinlock   idle_balance+0xa06
           2      2.50 us      1.83 us      1.25 us        mutex   kernfs_iop_lookup+0x2f
           1      1.71 us      1.71 us      1.71 us        mutex   kernfs_iop_getattr+0x2c
  ...

- Add new 'perf kwork' tool to trace time properties of kernel work (such as
  softirq, and workqueue), uses eBPF skeletons to collect info in kernel space,
  aggregating data that then gets processed by the userspace tool, e.g.:

  # perf kwork report

   Kwork Name      | Cpu | Total Runtime | Count | Max runtime | Max runtime start | Max runtime end |
  ----------------------------------------------------------------------------------------------------
   nvme0q5:130     | 004 |      1.101 ms |    49 |    0.051 ms |    26035.056403 s |  26035.056455 s |
   amdgpu:162      | 002 |      0.176 ms |     9 |    0.046 ms |    26035.268020 s |  26035.268066 s |
   nvme0q24:149    | 023 |      0.161 ms |    55 |    0.009 ms |    26035.655280 s |  26035.655288 s |
   nvme0q20:145    | 019 |      0.090 ms |    33 |    0.014 ms |    26035.939018 s |  26035.939032 s |
   nvme0q31:156    | 030 |      0.075 ms |    21 |    0.010 ms |    26035.052237 s |  26035.052247 s |
   nvme0q8:133     | 007 |      0.062 ms |    12 |    0.021 ms |    26035.416840 s |  26035.416861 s |
   nvme0q6:131     | 005 |      0.054 ms |    22 |    0.010 ms |    26035.199919 s |  26035.199929 s |
   nvme0q19:144    | 018 |      0.052 ms |    14 |    0.010 ms |    26035.110615 s |  26035.110625 s |
   nvme0q7:132     | 006 |      0.049 ms |    13 |    0.007 ms |    26035.125180 s |  26035.125187 s |
   nvme0q18:143    | 017 |      0.033 ms |    14 |    0.007 ms |    26035.169698 s |  26035.169705 s |
   nvme0q17:142    | 016 |      0.013 ms |     1 |    0.013 ms |    26035.565147 s |  26035.565160 s |
   enp5s0-rx-0:164 | 006 |      0.004 ms |     4 |    0.002 ms |    26035.928882 s |  26035.928884 s |
   enp5s0-tx-0:166 | 008 |      0.003 ms |     3 |    0.002 ms |    26035.870923 s |  26035.870925 s |
  --------------------------------------------------------------------------------------------------------

  See commit log messages for more examples with extra options to limit the events time window, etc.

- Add support for new AMD IBS (Instruction Based Sampling) features:

  With the DataSrc extensions, the source of data can be decoded among:
 - Local L3 or other L1/L2 in CCX.
 - A peer cache in a near CCX.
 - Data returned from DRAM.
 - A peer cache in a far CCX.
 - DRAM address map with "long latency" bit set.
 - Data returned from MMIO/Config/PCI/APIC.
 - Extension Memory (S-Link, GenZ, etc - identified by the CS target
    and/or address map at DF's choice).
 - Peer Agent Memory.

- Support hardware tracing with Intel PT on guest machines, combining the
  traces with the ones in the host machine.

- Add a "-m" option to 'perf buildid-list' to show kernel and modules
  build-ids, to display all of the information needed to do external
  symbolization of kernel stack traces, such as those collected by
  bpf_get_stackid().

- Add arch TSC frequency information to perf.data file headers.

- Handle changes in the binutils disassembler function signatures in
  perf, bpftool and bpf_jit_disasm (Acked by the bpftool maintainer).

- Fix building the perf perl binding with the newest gcc in distros such
  as fedora rawhide, where some new warnings were breaking the build as
  perf uses -Werror.

- Add 'perf test' entry for branch stack sampling.

- Add ARM SPE system wide 'perf test' entry.

- Add user space counter reading tests to 'perf test'.

- Build with python3 by default, if available.

- Add python converter script for the vendor JSON event files.

- Update vendor JSON files for alderlake, bonnell, broadwell, broadwellde,
  broadwellx, cascadelakex, elkhartlake, goldmont, goldmontplus, haswell,
  haswellx, icelake, icelakex, ivybridge, ivytown, jaketown, knightslanding,
  nehalemep, nehalemex, sandybridge, sapphirerapids, silvermont, skylake,
  skylakex, snowridgex, tigerlake, westmereep-dp, westmereep-sp and westmereex.

- Add vendor JSON File for Intel meteorlake.

- Add Arm Cortex-A78C and X1C JSON vendor event files.

- Add workaround to symbol address reading from ELF files without phdr,
  falling back to the previoous equation.

- Convert legacy map definition to BTF-defined in the perf BPF script test.

- Rework prologue generation code to stop using libbpf deprecated APIs.

- Add default hybrid events for 'perf stat' on x86.

- Add topdown metrics in the default 'perf stat' on the hybrid machines (big/little cores).

- Prefer sampled CPU when exporting JSON in 'perf data convert'

- Fix ('perf stat CSV output linter') and ("Check branch stack sampling") 'perf test' entries on s390.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (40):
      perf record: Always get text_poke events with --kcore option
      perf record: Always record id index
      perf record: Add new option to sample identifier
      perf record: Add finished init event
      perf script: Add some missing event dumps
      perf tools: Fix dso_id inode generation comparison
      perf tools: Export dsos__for_each_with_build_id()
      perf ordered_events: Add ordered_events__last_flush_time()
      perf tools: Export perf_event__process_finished_round()
      perf tools: Factor out evsel__id_hdr_size()
      perf tools: Add perf_event__synthesize_id_sample()
      perf script: Add --dump-unsorted-raw-trace option
      perf buildid-cache: Add guestmount'd files to the build ID cache
      perf buildid-cache: Do not require purge files to also be in the file system
      perf tools: Add machine_pid and vcpu to id_index
      perf session: Create guest machines from id_index
      perf tools: Add guest_cpu to hypervisor threads
      perf tools: Add machine_pid and vcpu to perf_sample
      perf session: Use sample->machine_pid to find guest machine
      perf script: Add machine_pid and vcpu
      perf dlfilter: Add machine_pid and vcpu
      perf auxtrace: Add machine_pid and vcpu to auxtrace_error
      perf script python: Add machine_pid and vcpu
      perf script python: intel-pt-events: Add machine_pid and vcpu
      perf tools: Remove also guest kcore_dir with host kcore_dir
      perf tools: Make has_kcore_dir() work also for guest kcore_dir
      perf tools: Automatically use guest kcore_dir if present
      perf tools: Add reallocarray_as_needed()
      perf inject: Add support for injecting guest sideband events
      perf machine: Use realloc_array_as_needed() in machine__set_current_tid()
      perf tools: Handle injected guest kernel mmap event
      perf tools: Add perf_event__is_guest()
      perf intel-pt: Remove guest_machine_pid
      perf intel-pt: Add some more logging to intel_pt_walk_next_insn()
      perf intel-pt: Track guest context switches
      perf intel-pt: Disable sync switch with guest sideband
      perf intel-pt: Determine guest thread from guest sideband
      perf intel-pt: Add machine_pid and vcpu to auxtrace_error
      perf intel-pt: Use guest pid/tid etc in guest samples
      perf intel-pt: Add documentation for tracing guest machine user space

Adrián Herrera Arcila (1):
      perf stat: Refactor __run_perf_stat() common code

Andres Freund (8):
      tools build: Add feature test for init_disassemble_info API changes
      tools build: Don't display disassembler-four-args feature test
      tools include: add dis-asm-compat.h to handle version differences
      tools perf: Fix compilation error with new binutils
      tools bpf_jit_disasm: Fix compilation error with new binutils
      tools bpf_jit_disasm: Don't display disassembler-four-args feature test
      tools bpftool: Fix compilation error with new binutils
      tools bpftool: Don't display disassembler-four-args feature test

Arnaldo Carvalho de Melo (10):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf scripting perl: Ignore some warnings to keep building with perl headers
      perf build: Avoid defining _FORTIFY_SOURCE multiple times
      perf python: Ignore unused command line arguments when building with clang
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf data: Add missing unistd.h header needed for pid_t
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      genelf: Use HAVE_LIBCRYPTO_SUPPORT, not the never defined HAVE_LIBCRYPTO
      perf scripting python: Do not build fail on deprecation warnings

Blake Jones (1):
      perf buildid-list: Add a "-m" option to show kernel and modules build-ids

Colin Ian King (1):
      perf inject: Fix spelling mistake "theads" -> "threads"

German Gomez (1):
      perf test: Add test for branch stack sampling

Ian Rogers (46):
      perf python: Prefer python3
      perf jevents: Add python converter script
      perf jevents: Switch build to use jevents.py
      perf jevents: Remove jevents.c
      perf test: Add debug line to diagnose broken metrics
      perf test: Make all metrics test more tolerant
      perf gtk: Only support --gtk if compiled in
      perf python: Avoid deprecation warning on distutils
      perf tsc: Add cpuinfo fall back for arch_get_tsc_freq()
      perf test: Add test for #system_tsc_freq in metrics
      perf test: Avoid sysfs state affecting fake events
      perf vendor events: Update Intel broadwellx
      perf vendor events: Update Intel broadwell
      perf vendor events: Update Intel broadwellde
      perf vendor events: Update Intel alderlake
      perf vendor events: Update bonnell mapfile.csv
      perf vendor events: Update Intel cascadelakex
      perf vendor events: Update Intel elkhartlake
      perf vendor events: Update goldmont mapfile.csv
      perf vendor events: Update goldmontplus mapfile.csv
      perf vendor events: Update Intel haswell
      perf vendor events: Update Intel haswellx
      perf vendor events: Update Intel icelake
      perf vendor events: Update Intel icelakex
      perf vendor events: Update Intel ivybridge
      perf vendor events: Update Intel ivytown
      perf vendor events: Update Intel jaketown
      perf vendor events: Update Intel knightslanding
      perf vendor events: Add Intel meteorlake
      perf vendor events: Update Intel nehalemep
      perf vendor events: Update Intel nehalemex
      perf vendor events: Update Intel sandybridge
      perf vendor events: Update Intel sapphirerapids
      perf vendor events: Update Intel silvermont
      perf vendor events: Update Intel skylake
      perf vendor events: Update Intel skylakex
      perf vendor events: Update Intel tigerlake
      perf vendor events: Update Intel westmereep-dp
      perf vendor events: Update Intel westmereep-sp
      perf vendor events: Update Intel westmereex
      perf vendor events: Update Intel snowridgex
      perf test: Remove x86 rdpmc test
      perf test: Add user space counter reading tests
      perf symbol: Fail to read phdr workaround
      perf parse-events: Don't #define YY_EXTRA_TYPE
      perf parse-events: Break out tracepoint and printing

Jason Wang (2):
      perf probe: Fix duplicated 'the' in comment
      perf cs-etm: Fix duplicated 'the' in comment

Jiri Olsa (2):
      perf bpf: Convert legacy map definition to BTF-defined
      perf tools: Rework prologue generation code

Kan Liang (5):
      perf tsc: Add arch TSC frequency information
      perf stat: Revert "perf stat: Add default hybrid events"
      perf evsel: Add arch_evsel__hw_name()
      perf evlist: Always use arch_evlist__add_default_attrs()
      perf x86 evlist: Add default hybrid events for perf stat

Namhyung Kim (20):
      perf lock: Print wait times with unit
      perf lock: Allow to use different kernel symbols
      perf lock: Skip print_bad_events() if nothing bad
      perf lock: Add lock contention tracepoints record support
      perf lock: Handle lock contention tracepoints
      perf record: Allow to specify max stack depth of fp callchain
      perf lock: Look up callchain for the contended locks
      perf lock: Fix a copy-n-paste bug
      perf lock: Add flags field in the lock_stat
      perf lock: Add lock aggregation enum
      perf lock: Add 'contention' subcommand
      perf lock: Add -k and -F options to 'contention' subcommand
      perf lock: Support -t option for 'contention' subcommand
      perf lock: Pass machine pointer to is_lock_function()
      perf lock: Use BPF for lock contention analysis
      perf lock: Implement cpu and task filters for BPF
      perf test: Add ARM SPE system wide test
      perf lock: Introduce struct lock_contention
      perf lock: Add --map-nr-entries option
      perf lock: Print the number of lost entries for BPF

Nick Forrington (1):
      perf vendor events arm64: Arm Cortex-A78C and X1C

Ravi Bangoria (7):
      perf record ibs: Warn about sampling period skew
      perf pmu: Parse pmu caps sysfs only once
      perf header: Pass "cpu" pmu name while printing caps
      perf header: Store PMU caps in an array of strings
      perf header: Record non-CPU PMU capabilities
      perf tool ibs: Sync AMD IBS header file
      perf script ibs: Support new IBS bits in raw trace dump

Shawn M. Chapla (1):
      perf data convert: Prefer sampled CPU when exporting JSON

Thomas Richter (2):
      perf test: Fix test case 83 ('perf stat CSV output linter') on s390
      perf test: Fix test case 95 ("Check branch stack sampling") on s390 and use same event

Yang Jihong (17):
      perf kwork: New tool to trace time properties of kernel work (such as softirq, and workqueue)
      perf kwork: Add irq kwork record support
      perf kwork: Add softirq kwork record support
      perf kwork: Add workqueue kwork record support
      tools lib: Add list_last_entry_or_null()
      perf kwork: Implement 'report' subcommand
      perf kwork: Add irq report support
      perf kwork: Add softirq report support
      perf kwork: Add workqueue report support
      perf kwork: Implement perf kwork latency
      perf kwork: Add softirq latency support
      perf kwork: Add workqueue latency support
      perf kwork: Implement perf kwork timehist
      perf kwork: Implement BPF trace
      perf kwork: Add IRQ trace BPF support
      perf kwork: Add softirq trace BPF support
      perf kwork: Add workqueue trace BPF support

Zhengjun Xing (7):
      perf vendor events intel: Update event list for Alderlake
      perf vendor events intel: Update event list for Sapphirerapids
      perf vendor events intel: Rename tremontx to snowridgex
      perf vendor events intel: Update event list for Snowridgex
      perf vendor events intel: Update event list for broadwellx
      perf vendor events intel: Update event list for haswellx
      perf stat: Add topdown metrics in the default perf stat on the hybrid machine

Zixuan Tan (1):
      perf build: Suppress openssl v3 deprecation warnings in libcrypto feature test

 tools/arch/x86/include/asm/amd-ibs.h               |    16 +-
 tools/bpf/Makefile                                 |     7 +-
 tools/bpf/bpf_jit_disasm.c                         |     5 +-
 tools/bpf/bpftool/Makefile                         |     8 +-
 tools/bpf/bpftool/jit_disasm.c                     |    42 +-
 tools/build/Makefile.feature                       |     4 +-
 tools/build/feature/Makefile                       |     4 +
 tools/build/feature/test-all.c                     |     4 +
 .../build/feature/test-disassembler-init-styled.c  |    13 +
 tools/build/feature/test-libcrypto.c               |     6 +
 tools/include/linux/list.h                         |    11 +
 tools/include/tools/dis-asm-compat.h               |    55 +
 tools/lib/perf/include/internal/evsel.h            |     4 +
 tools/lib/perf/include/perf/event.h                |     8 +
 tools/perf/Build                                   |     1 +
 tools/perf/Documentation/perf-buildid-list.txt     |     4 +
 tools/perf/Documentation/perf-dlfilter.txt         |    22 +
 tools/perf/Documentation/perf-inject.txt           |    17 +
 tools/perf/Documentation/perf-intel-pt.txt         |   181 +-
 tools/perf/Documentation/perf-kwork.txt            |   180 +
 tools/perf/Documentation/perf-lock.txt             |    55 +-
 tools/perf/Documentation/perf-record.txt           |    10 +
 tools/perf/Documentation/perf-script.txt           |    10 +-
 tools/perf/Documentation/perf.data-file-format.txt |    20 +-
 tools/perf/Makefile.config                         |    37 +-
 tools/perf/Makefile.perf                           |    19 +-
 tools/perf/arch/x86/tests/Build                    |     1 -
 tools/perf/arch/x86/tests/arch-tests.c             |     2 -
 tools/perf/arch/x86/tests/rdpmc.c                  |   182 -
 tools/perf/arch/x86/util/cpuid.h                   |    34 +
 tools/perf/arch/x86/util/evlist.c                  |    64 +-
 tools/perf/arch/x86/util/evsel.c                   |    72 +
 tools/perf/arch/x86/util/header.c                  |    27 +-
 tools/perf/arch/x86/util/topdown.c                 |    51 +
 tools/perf/arch/x86/util/topdown.h                 |     1 +
 tools/perf/arch/x86/util/tsc.c                     |    77 +
 tools/perf/builtin-annotate.c                      |     8 +
 tools/perf/builtin-buildid-list.c                  |    39 +-
 tools/perf/builtin-inject.c                        |  1046 +-
 tools/perf/builtin-kwork.c                         |  1832 ++
 tools/perf/builtin-list.c                          |     2 +-
 tools/perf/builtin-lock.c                          |   958 +-
 tools/perf/builtin-record.c                        |    44 +-
 tools/perf/builtin-report.c                        |     6 +
 tools/perf/builtin-script.c                        |    25 +
 tools/perf/builtin-stat.c                          |    75 +-
 tools/perf/builtin-timechart.c                     |     1 +
 tools/perf/builtin-trace.c                         |     1 +
 tools/perf/builtin.h                               |     1 +
 tools/perf/command-list.txt                        |     1 +
 tools/perf/include/perf/perf_dlfilter.h            |     8 +
 tools/perf/perf.c                                  |     1 +
 tools/perf/pmu-events/Build                        |    17 +-
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |     2 +
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |     4 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |   178 +-
 .../arch/x86/alderlake/floating-point.json         |    19 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |    38 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |    40 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |    97 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |   507 +-
 .../arch/x86/alderlake/uncore-other.json           |     2 +-
 .../arch/x86/alderlake/virtual-memory.json         |    63 +-
 tools/perf/pmu-events/arch/x86/bonnell/cache.json  |     2 +-
 .../arch/x86/bonnell/floating-point.json           |     2 +-
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |     2 +-
 tools/perf/pmu-events/arch/x86/bonnell/memory.json |     2 +-
 tools/perf/pmu-events/arch/x86/bonnell/other.json  |     2 +-
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |     2 +-
 .../arch/x86/bonnell/virtual-memory.json           |     2 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   130 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |     2 +-
 .../arch/x86/broadwell/floating-point.json         |     2 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |     2 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json |     2 +-
 .../perf/pmu-events/arch/x86/broadwell/other.json  |     2 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    |     2 +-
 .../arch/x86/broadwell/uncore-cache.json           |   152 +
 .../arch/x86/broadwell/uncore-other.json           |    82 +
 .../perf/pmu-events/arch/x86/broadwell/uncore.json |   278 -
 .../arch/x86/broadwell/virtual-memory.json         |     2 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |   136 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |     2 +-
 .../arch/x86/broadwellde/floating-point.json       |     2 +-
 .../pmu-events/arch/x86/broadwellde/frontend.json  |     2 +-
 .../pmu-events/arch/x86/broadwellde/memory.json    |     2 +-
 .../pmu-events/arch/x86/broadwellde/other.json     |     2 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |     2 +-
 .../arch/x86/broadwellde/uncore-cache.json         |  3818 ++-
 .../arch/x86/broadwellde/uncore-memory.json        |  2867 ++-
 .../arch/x86/broadwellde/uncore-other.json         |  1246 +
 .../arch/x86/broadwellde/uncore-power.json         |   492 +-
 .../arch/x86/broadwellde/virtual-memory.json       |     2 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   570 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |    22 +-
 .../arch/x86/broadwellx/floating-point.json        |     9 +-
 .../pmu-events/arch/x86/broadwellx/frontend.json   |     2 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |    39 +-
 .../perf/pmu-events/arch/x86/broadwellx/other.json |     2 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |     4 +-
 .../arch/x86/broadwellx/uncore-cache.json          |  3788 ++-
 .../arch/x86/broadwellx/uncore-interconnect.json   |  1438 +-
 .../arch/x86/broadwellx/uncore-memory.json         |  2849 ++-
 .../arch/x86/broadwellx/uncore-other.json          |  3252 +++
 .../arch/x86/broadwellx/uncore-power.json          |   437 +-
 .../arch/x86/broadwellx/virtual-memory.json        |     2 +-
 .../pmu-events/arch/x86/cascadelakex/cache.json    |     8 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |   724 +-
 .../arch/x86/cascadelakex/floating-point.json      |     2 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |     2 +-
 .../pmu-events/arch/x86/cascadelakex/other.json    |    63 +
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |    11 +
 .../arch/x86/cascadelakex/uncore-memory.json       |     9 +
 .../arch/x86/cascadelakex/uncore-other.json        |   697 +-
 .../arch/x86/cascadelakex/virtual-memory.json      |     2 +-
 .../pmu-events/arch/x86/elkhartlake/cache.json     |   956 +-
 .../arch/x86/elkhartlake/floating-point.json       |    19 +-
 .../pmu-events/arch/x86/elkhartlake/frontend.json  |    34 +-
 .../pmu-events/arch/x86/elkhartlake/memory.json    |   388 +-
 .../pmu-events/arch/x86/elkhartlake/other.json     |   527 +-
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   203 +-
 .../arch/x86/elkhartlake/virtual-memory.json       |   151 +-
 tools/perf/pmu-events/arch/x86/goldmont/cache.json |     2 +-
 .../arch/x86/goldmont/floating-point.json          |     2 +-
 .../pmu-events/arch/x86/goldmont/frontend.json     |     2 +-
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |     2 +-
 .../pmu-events/arch/x86/goldmont/pipeline.json     |     2 +-
 .../arch/x86/goldmont/virtual-memory.json          |     2 +-
 .../pmu-events/arch/x86/goldmontplus/cache.json    |     2 +-
 .../arch/x86/goldmontplus/floating-point.json      |     2 +-
 .../pmu-events/arch/x86/goldmontplus/frontend.json |     2 +-
 .../pmu-events/arch/x86/goldmontplus/memory.json   |     2 +-
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |     2 +-
 .../arch/x86/goldmontplus/virtual-memory.json      |     2 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |    78 +-
 .../arch/x86/haswell/floating-point.json           |     2 +-
 .../perf/pmu-events/arch/x86/haswell/frontend.json |     2 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |    85 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |    75 +-
 tools/perf/pmu-events/arch/x86/haswell/other.json  |     2 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json |     9 +-
 .../pmu-events/arch/x86/haswell/uncore-other.json  |     7 +-
 .../arch/x86/haswell/virtual-memory.json           |     2 +-
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |    44 +-
 .../arch/x86/haswellx/floating-point.json          |     2 +-
 .../pmu-events/arch/x86/haswellx/frontend.json     |     2 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |    85 +-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |    52 +-
 tools/perf/pmu-events/arch/x86/haswellx/other.json |     2 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     |     9 +-
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |  3779 ++-
 .../arch/x86/haswellx/uncore-interconnect.json     |  1430 +-
 .../arch/x86/haswellx/uncore-memory.json           |  2839 ++-
 .../pmu-events/arch/x86/haswellx/uncore-other.json |  3170 +++
 .../pmu-events/arch/x86/haswellx/uncore-power.json |   477 +-
 .../arch/x86/haswellx/virtual-memory.json          |     2 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |     8 +-
 .../arch/x86/icelake/floating-point.json           |     2 +-
 .../perf/pmu-events/arch/x86/icelake/frontend.json |     2 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   126 +-
 .../pmu-events/arch/x86/icelake/uncore-other.json  |    31 +
 .../arch/x86/icelake/virtual-memory.json           |     2 +-
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |    28 +-
 .../arch/x86/icelakex/floating-point.json          |     2 +-
 .../pmu-events/arch/x86/icelakex/frontend.json     |     2 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   691 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |     6 +-
 tools/perf/pmu-events/arch/x86/icelakex/other.json |    51 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |    12 +
 .../arch/x86/icelakex/virtual-memory.json          |     2 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |     2 +-
 .../arch/x86/ivybridge/floating-point.json         |     2 +-
 .../pmu-events/arch/x86/ivybridge/frontend.json    |     2 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |    94 +-
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |     2 +-
 .../perf/pmu-events/arch/x86/ivybridge/other.json  |     2 +-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |     4 +-
 .../arch/x86/ivybridge/uncore-other.json           |     2 +-
 .../arch/x86/ivybridge/virtual-memory.json         |     2 +-
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |     2 +-
 .../arch/x86/ivytown/floating-point.json           |     2 +-
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |     2 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |    94 +-
 tools/perf/pmu-events/arch/x86/ivytown/memory.json |     2 +-
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |     2 +-
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |  3495 ++-
 .../arch/x86/ivytown/uncore-interconnect.json      |  1750 +-
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |  1775 +-
 .../pmu-events/arch/x86/ivytown/uncore-other.json  |  2411 ++
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |   696 +-
 .../arch/x86/ivytown/virtual-memory.json           |     2 +-
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |     2 +-
 .../arch/x86/jaketown/floating-point.json          |     2 +-
 .../pmu-events/arch/x86/jaketown/frontend.json     |     2 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |    11 +-
 .../perf/pmu-events/arch/x86/jaketown/memory.json  |     2 +-
 tools/perf/pmu-events/arch/x86/jaketown/other.json |     2 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     |    16 +-
 .../pmu-events/arch/x86/jaketown/uncore-cache.json |  1960 +-
 .../arch/x86/jaketown/uncore-interconnect.json     |   824 +-
 .../arch/x86/jaketown/uncore-memory.json           |   445 +-
 .../pmu-events/arch/x86/jaketown/uncore-other.json |  1551 ++
 .../pmu-events/arch/x86/jaketown/uncore-power.json |   362 +-
 .../arch/x86/jaketown/virtual-memory.json          |     2 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |     2 +-
 .../arch/x86/knightslanding/floating-point.json    |     2 +-
 .../arch/x86/knightslanding/frontend.json          |     2 +-
 .../pmu-events/arch/x86/knightslanding/memory.json |     2 +-
 .../arch/x86/knightslanding/pipeline.json          |     2 +-
 .../arch/x86/knightslanding/uncore-memory.json     |    42 -
 .../arch/x86/knightslanding/uncore-other.json      |  3890 +++
 .../arch/x86/knightslanding/virtual-memory.json    |     2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    74 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   262 +
 .../pmu-events/arch/x86/meteorlake/frontend.json   |    24 +
 .../pmu-events/arch/x86/meteorlake/memory.json     |   185 +
 .../perf/pmu-events/arch/x86/meteorlake/other.json |    46 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |   254 +
 .../arch/x86/meteorlake/virtual-memory.json        |    46 +
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  |    14 +-
 .../arch/x86/nehalemep/floating-point.json         |     2 +-
 .../pmu-events/arch/x86/nehalemep/frontend.json    |     2 +-
 .../perf/pmu-events/arch/x86/nehalemep/memory.json |     6 +-
 .../arch/x86/nehalemep/virtual-memory.json         |     2 +-
 .../perf/pmu-events/arch/x86/nehalemex/cache.json  |  2974 +--
 .../arch/x86/nehalemex/floating-point.json         |   182 +-
 .../pmu-events/arch/x86/nehalemex/frontend.json    |    20 +-
 .../perf/pmu-events/arch/x86/nehalemex/memory.json |   672 +-
 .../perf/pmu-events/arch/x86/nehalemex/other.json  |   170 +-
 .../pmu-events/arch/x86/nehalemex/pipeline.json    |   830 +-
 .../arch/x86/nehalemex/virtual-memory.json         |    92 +-
 .../pmu-events/arch/x86/sandybridge/cache.json     |     2 +-
 .../arch/x86/sandybridge/floating-point.json       |     2 +-
 .../pmu-events/arch/x86/sandybridge/frontend.json  |     4 +-
 .../pmu-events/arch/x86/sandybridge/memory.json    |     2 +-
 .../pmu-events/arch/x86/sandybridge/other.json     |     2 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |    10 +-
 .../arch/x86/sandybridge/snb-metrics.json          |    11 +-
 .../arch/x86/sandybridge/uncore-other.json         |     2 +-
 .../arch/x86/sandybridge/virtual-memory.json       |     2 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |   135 +-
 .../arch/x86/sapphirerapids/floating-point.json    |     6 +
 .../arch/x86/sapphirerapids/frontend.json          |    16 +
 .../pmu-events/arch/x86/sapphirerapids/memory.json |    23 +-
 .../pmu-events/arch/x86/sapphirerapids/other.json  |    68 +-
 .../arch/x86/sapphirerapids/pipeline.json          |    99 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |   566 +-
 .../arch/x86/sapphirerapids/uncore-other.json      |     9 -
 .../arch/x86/sapphirerapids/virtual-memory.json    |    20 +
 .../perf/pmu-events/arch/x86/silvermont/cache.json |     2 +-
 .../arch/x86/silvermont/floating-point.json        |     2 +-
 .../pmu-events/arch/x86/silvermont/frontend.json   |     2 +-
 .../pmu-events/arch/x86/silvermont/memory.json     |     2 +-
 .../perf/pmu-events/arch/x86/silvermont/other.json |     2 +-
 .../pmu-events/arch/x86/silvermont/pipeline.json   |     2 +-
 .../arch/x86/silvermont/virtual-memory.json        |     2 +-
 .../arch/x86/skylake/floating-point.json           |     2 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |     2 +-
 tools/perf/pmu-events/arch/x86/skylake/other.json  |     2 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   178 +-
 .../pmu-events/arch/x86/skylake/uncore-cache.json  |   142 +
 .../pmu-events/arch/x86/skylake/uncore-other.json  |    79 +
 tools/perf/pmu-events/arch/x86/skylake/uncore.json |   254 -
 .../arch/x86/skylake/virtual-memory.json           |     2 +-
 .../arch/x86/skylakex/floating-point.json          |     2 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |     2 +-
 tools/perf/pmu-events/arch/x86/skylakex/other.json |    66 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |    11 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   667 +-
 .../arch/x86/skylakex/uncore-memory.json           |     9 +
 .../pmu-events/arch/x86/skylakex/uncore-other.json |   730 +-
 .../arch/x86/skylakex/virtual-memory.json          |     2 +-
 .../arch/x86/{tremontx => snowridgex}/cache.json   |    60 +-
 .../{tremontx => snowridgex}/floating-point.json   |     9 +-
 .../x86/{tremontx => snowridgex}/frontend.json     |    20 +-
 .../arch/x86/{tremontx => snowridgex}/memory.json  |     4 +-
 .../arch/x86/{tremontx => snowridgex}/other.json   |    18 +-
 .../x86/{tremontx => snowridgex}/pipeline.json     |    98 +-
 .../arch/x86/snowridgex/uncore-memory.json         |   619 +
 .../arch/x86/snowridgex/uncore-other.json          | 25249 +++++++++++++++++++
 .../arch/x86/snowridgex/uncore-power.json          |   235 +
 .../{tremontx => snowridgex}/virtual-memory.json   |    69 +-
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |    48 +-
 .../arch/x86/tigerlake/floating-point.json         |     2 +-
 .../pmu-events/arch/x86/tigerlake/frontend.json    |     2 +-
 .../perf/pmu-events/arch/x86/tigerlake/memory.json |     2 +-
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |     1 -
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |     4 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   378 +-
 .../arch/x86/tigerlake/uncore-other.json           |    65 +
 .../arch/x86/tigerlake/virtual-memory.json         |     2 +-
 .../arch/x86/tremontx/uncore-memory.json           |   245 -
 .../pmu-events/arch/x86/tremontx/uncore-other.json |  2395 --
 .../pmu-events/arch/x86/tremontx/uncore-power.json |    11 -
 .../pmu-events/arch/x86/westmereep-dp/cache.json   |     2 +-
 .../arch/x86/westmereep-dp/floating-point.json     |     2 +-
 .../arch/x86/westmereep-dp/frontend.json           |     2 +-
 .../pmu-events/arch/x86/westmereep-dp/memory.json  |     2 +-
 .../arch/x86/westmereep-dp/virtual-memory.json     |     2 +-
 .../arch/x86/westmereep-sp/floating-point.json     |     2 +-
 .../arch/x86/westmereep-sp/frontend.json           |     2 +-
 .../arch/x86/westmereep-sp/virtual-memory.json     |     2 +-
 .../arch/x86/westmereex/floating-point.json        |     2 +-
 .../pmu-events/arch/x86/westmereex/frontend.json   |     2 +-
 .../arch/x86/westmereex/virtual-memory.json        |     2 +-
 tools/perf/pmu-events/empty-pmu-events.c           |   158 +
 tools/perf/pmu-events/jevents.c                    |  1342 -
 tools/perf/pmu-events/jevents.py                   |   409 +
 tools/perf/pmu-events/jsmn.c                       |   352 -
 tools/perf/pmu-events/jsmn.h                       |    68 -
 tools/perf/pmu-events/json.c                       |   162 -
 tools/perf/pmu-events/json.h                       |    39 -
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |     6 +-
 tools/perf/scripts/python/intel-pt-events.py       |    32 +-
 tools/perf/tests/bpf-script-example.c              |    35 +-
 tools/perf/tests/expr.c                            |    13 +
 tools/perf/tests/mmap-basic.c                      |   127 +-
 tools/perf/tests/pmu-events.c                      |    10 +
 tools/perf/tests/shell/stat+csv_output.sh          |     7 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |    47 +-
 tools/perf/tests/shell/test_arm_spe.sh             |    30 +-
 tools/perf/tests/shell/test_brstack.sh             |   114 +
 tools/perf/util/Build                              |     4 +
 tools/perf/util/amd-sample-raw.c                   |    68 +-
 tools/perf/util/annotate.c                         |     7 +-
 tools/perf/util/auxtrace.c                         |    30 +-
 tools/perf/util/auxtrace.h                         |     4 +
 tools/perf/util/bpf-loader.c                       |   204 +-
 tools/perf/util/bpf_kwork.c                        |   346 +
 tools/perf/util/bpf_lock_contention.c              |   189 +
 tools/perf/util/bpf_skel/kwork_trace.bpf.c         |   383 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   175 +
 tools/perf/util/build-id.c                         |    80 +-
 tools/perf/util/build-id.h                         |    16 +-
 tools/perf/util/callchain.c                        |    18 +-
 tools/perf/util/cs-etm.c                           |     2 +-
 tools/perf/util/data-convert-json.c                |     5 +-
 tools/perf/util/data.c                             |    43 +-
 tools/perf/util/data.h                             |     2 +
 tools/perf/util/dlfilter.c                         |     2 +
 tools/perf/util/dso.h                              |     6 +
 tools/perf/util/dsos.c                             |    15 +-
 tools/perf/util/env.c                              |    62 +-
 tools/perf/util/env.h                              |    14 +-
 tools/perf/util/event.c                            |     1 +
 tools/perf/util/event.h                            |    23 +
 tools/perf/util/evlist.c                           |    53 +-
 tools/perf/util/evlist.h                           |     9 +-
 tools/perf/util/evsel.c                            |    41 +-
 tools/perf/util/evsel.h                            |     4 +
 tools/perf/util/expr.c                             |    13 +
 tools/perf/util/genelf.c                           |     6 +-
 tools/perf/util/header.c                           |   192 +-
 tools/perf/util/header.h                           |     2 +-
 tools/perf/util/intel-pt.c                         |   183 +-
 tools/perf/util/kwork.h                            |   257 +
 tools/perf/util/llvm-utils.c                       |     2 +-
 tools/perf/util/lock-contention.h                  |   147 +
 tools/perf/util/machine.c                          |    56 +-
 tools/perf/util/machine.h                          |     7 +
 tools/perf/util/ordered-events.h                   |     6 +
 tools/perf/util/parse-events.c                     |   714 +-
 tools/perf/util/parse-events.h                     |    31 -
 tools/perf/util/pmu.c                              |    15 +-
 tools/perf/util/pmu.h                              |     2 +
 tools/perf/util/print-events.c                     |   572 +
 tools/perf/util/print-events.h                     |    22 +
 tools/perf/util/probe-event.c                      |     2 +-
 tools/perf/util/record.c                           |     2 +-
 tools/perf/util/record.h                           |     1 +
 tools/perf/util/scripting-engines/Build            |     4 +-
 .../util/scripting-engines/trace-event-python.c    |    15 +-
 tools/perf/util/session.c                          |   115 +-
 tools/perf/util/session.h                          |     4 +
 tools/perf/util/setup.py                           |    12 +-
 tools/perf/util/stat-display.c                     |     2 +-
 tools/perf/util/symbol-elf.c                       |    27 +-
 tools/perf/util/symbol.c                           |     6 +-
 tools/perf/util/synthetic-events.c                 |   105 +-
 tools/perf/util/synthetic-events.h                 |     2 +
 tools/perf/util/thread.c                           |     1 +
 tools/perf/util/thread.h                           |     1 +
 tools/perf/util/tool.h                             |     3 +-
 tools/perf/util/topdown.c                          |     7 +
 tools/perf/util/topdown.h                          |     3 +-
 tools/perf/util/trace-event-info.c                 |    96 +
 tools/perf/util/tracepoint.c                       |    63 +
 tools/perf/util/tracepoint.h                       |    25 +
 tools/perf/util/tsc.h                              |     1 +
 tools/perf/util/util.c                             |    70 +-
 tools/perf/util/util.h                             |    15 +
 391 files changed, 98508 insertions(+), 11952 deletions(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c
 create mode 100644 tools/include/tools/dis-asm-compat.h
 create mode 100644 tools/perf/Documentation/perf-kwork.txt
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c
 create mode 100644 tools/perf/arch/x86/util/cpuid.h
 create mode 100644 tools/perf/builtin-kwork.c
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore.json
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/cache.json (95%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/floating-point.json (84%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json (94%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/memory.json (99%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/other.json (98%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json (89%)
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/virtual-memory.json (91%)
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.c
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h
 create mode 100755 tools/perf/tests/shell/test_brstack.sh
 create mode 100644 tools/perf/util/bpf_kwork.c
 create mode 100644 tools/perf/util/bpf_lock_contention.c
 create mode 100644 tools/perf/util/bpf_skel/kwork_trace.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/lock_contention.bpf.c
 create mode 100644 tools/perf/util/kwork.h
 create mode 100644 tools/perf/util/lock-contention.h
 create mode 100644 tools/perf/util/print-events.c
 create mode 100644 tools/perf/util/print-events.h
 create mode 100644 tools/perf/util/tracepoint.c
 create mode 100644 tools/perf/util/tracepoint.h

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

Cross building on 32-bit MIPS debian is failing due to redefinition of 'struct flock'
on a 'perf trace' beautifier, to be investigated.

Another regression alt:sisyphus, will be eventually on the non-default libllvm build.

debian experimental has a problem with a change in the prototype of a binutils function
used for disassembling BPF code, a fix is being discussed and will soon be merged.

The fedora:32 container needs rebuilding, its failing because it has a clang that is "old"
for building BPF stuff, probably its really old and needs to get out of this test suite.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-5.19.0.tar.xz
  [perfbuilder@five ~]$ time dm
   1   119.67 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2   111.54 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
   3    82.87 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   4   109.44 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   5   127.10 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   6   115.97 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   7   127.30 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
   8   127.19 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
   9   129.51 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  10   118.77 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  11   122.47 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 14.0.6
  12    71.51 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  13    79.65 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  14    91.00 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  15    89.58 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC) 
      CC      /tmp/build/perf/util/expr.o
      LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
      LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
      LINK    /tmp/build/perf/libbpf/libbpf.a
    In file included from /usr/lib/llvm-13.0/include/clang/AST/ExprObjC.h:18,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/ConstructionContext.h:21,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/CFG.h:18,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/AnalysisDeclContext.h:22,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/PathDiagnostic.h:17,
                     from /usr/lib/llvm-13.0/include/clang/StaticAnalyzer/Core/AnalyzerOptions.h:17,
                     from /usr/lib/llvm-13.0/include/clang/Frontend/CompilerInvocation.h:22,
                     from util/c++/clang.cpp:14:
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h: In instantiation of 'void clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::SkipToNextDecl() [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isInstanceProperty]':
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h:2242:7:   required from 'clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::filtered_decl_iterator(clang::DeclContext::decl_iterator) [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isInstanceProperty]'
    /usr/lib/llvm-13.0/include/clang/AST/DeclObjC.h:984:43:   required from here
  16   102.73 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  17   120.87 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  18   127.98 archlinux:base                : Ok   gcc (GCC) 12.1.1 20220730 , clang version 14.0.6
  19   102.70 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  20   110.05 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-13) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
  21    32.89 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220720 releases/gcc-12.1.0-247-g94d44a83ff , clang version 14.0.4
  22    79.85 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  23    84.17 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  24   100.92 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25   115.67 debian:experimental           : Ok   gcc (Debian 11.3.0-4) 11.3.0 , Debian clang version 13.0.1-6
  26    24.87 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0 
  27    20.95 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  28    22.65 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  29    23.46 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  30    23.26 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  31    82.85 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  32    18.95 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  33    84.75 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  34   100.40 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  35    99.69 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  36   103.71 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  37   109.04 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  38   112.23 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  39   113.53 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  40    43.12 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    clang-10: error: unknown argument: '-fstack-clash-protection'
    clang-10: error: unknown argument: '-fstack-clash-protection'
    clang-10: error: unknown argument: '-fstack-clash-protection'
    error: command 'clang' failed with exit status 1
  41   117.46 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  42   125.57 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  43    20.75 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  44    18.83 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  45   127.51 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  46   129.11 fedora:36                     : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  47   129.70 fedora:37                     : Ok   gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3) , clang version 14.0.5 (Fedora 14.0.5-3.fc37)
  48   130.61 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3) , clang version 14.0.5 (Fedora 14.0.5-3.fc37)
  49   109.14 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  50     9.20 mageia:6                      : FAIL gcc version 5.5.0 (Mageia 5.5.0-1.mga6) 
  51    28.86 mageia:7                      : Ok   gcc (Mageia 8.4.0-1.mga7) 8.4.0 , clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  52   120.69 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  53     6.77 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
      CC      /tmp/build/perf/builtin-buildid-cache.o
      CC      /tmp/build/perf/builtin-kallsyms.o
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    In file included from builtin-bench.c:22:
    bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:66,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      CC      /tmp/build/perf/builtin-list.o
      AR      /tmp/build/perf/libsubcmd.a
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
      CC      /tmp/build/perf/builtin-record.o
      CC      /tmp/build/perf/builtin-report.o
  54     6.67 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
      CC      /tmp/build/perf/builtin-sched.o
      LD      /tmp/build/perf/libtraceevent-in.o
      LD      /tmp/build/perf/libperf-in.o
      CC      /tmp/build/perf/builtin-buildid-list.o
    In file included from builtin-bench.c:22:
    bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:66,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      CC      /tmp/build/perf/builtin-buildid-cache.o
      CC      /tmp/build/perf/builtin-kallsyms.o
      GEN     /tmp/build/perf/libtraceevent-dynamic-list
      CC      /tmp/build/perf/builtin-list.o
      CC      /tmp/build/perf/builtin-record.o
      CC      /tmp/build/perf/builtin-report.o
  55   119.65 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  56   122.85 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  57   116.86 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  58   132.31 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  59   134.11 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
  60   160.30 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.1.1 20220629 [revision 7811663964aa7e31c3939b859bbfa2e16919639f] , clang version 14.0.6
  61   116.58 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  62   109.13 oraclelinux:9                 : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9.4.0.2) , clang version 13.0.1 (Red Hat 13.0.1-1.0.1.el9)
  63   109.25 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.1 (Red Hat 13.0.1-2.module+el8.6.0+987+d36ea6a1)
  64   112.45 rockylinux:9                  : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
  65    87.66 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  66    19.64 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  67    19.34 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  68    20.04 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    19.84 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    92.97 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  71    21.15 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  72    21.45 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    17.64 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    21.15 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75    22.26 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    22.35 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77   109.25 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    19.75 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    20.55 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    19.34 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81    35.79 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
  82    23.16 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  83   111.95 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  84   117.45 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  85   130.73 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
  86   125.30 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-5ubuntu1) 11.3.0 , Ubuntu clang version 14.0.6-1
BUILD_TARBALL_HEAD=bb8bc52e75785af94b9ba079277547d50d018a52
[perfbuilder@five ~]$

  $ uname -a
  Linux quaco 5.18.10-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 7 17:21:38 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  bb8bc52e75785af9 (HEAD -> perf/core, seventh/perf/core, five/perf/core, acme.korg/tmp.perf/core) perf stat: Refactor __run_perf_stat() common code
  $ perf -v
  perf version 5.19.gbb8bc52e7578
  $ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 5.19.gbb8bc52e7578
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
    4: mmap interface tests                                            :
    4.1: Read samples using the mmap interface                         : Ok
    4.2: User space counter reading of instructions                    : Ok
    4.3: User space counter reading of cycles                          : Ok
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
   74: Test dwarf unwind                                               : Ok
   75: x86 instruction decoder - new instructions                      : Ok
   76: Intel PT packet decoder                                         : Ok
   77: x86 bp modify                                                   : Ok
   78: x86 Sample parsing                                              : Ok
   79: build id cache operations                                       : Ok
   80: daemon operations                                               : Ok
   81: perf pipe recording and injection test                          : Ok
   82: Add vfs_getname probe to get syscall args filenames             : Ok
   83: probe libc's inet_pton & backtrace it with ping                 : Ok
   84: Use vfs_getname probe to get syscall args filenames             : Ok
   85: Zstd perf.data compression/decompression                        : Ok
   86: perf record tests                                               : Ok
   87: perf record offcpu profiling tests                              : Ok
   88: perf stat CSV output linter                                     : Ok
   89: perf stat csv summary test                                      : Ok
   90: perf stat metrics (shadow stat) test                            : Ok
   91: perf stat tests                                                 : Ok
   92: perf all metricgroups test                                      : Ok
   93: perf all metrics test                                           : FAILED!
   94: perf all PMU test                                               : Ok
   95: perf stat --bpf-counters test                                   : Ok
   96: Check Arm64 callgraphs are complete in fp mode                  : Skip
   97: Check Arm CoreSight trace data recording and synthesized samples: Skip
   98: Check Arm SPE trace data recording and synthesized samples      : Skip
   99: Check Arm SPE doesn't hang when there are forks                 : Skip
  100: Check branch stack sampling                                     : Ok
  101: Miscellaneous Intel PT testing                                  : Ok
  102: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]# 

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  ⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
  bb8bc52e75785af9 (HEAD -> perf/core) perf stat: Refactor __run_perf_stat() common code
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.qdNPSXpTRs
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.E1PBIeU9vG
  - /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_util_map_o_O: make util/map.o
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
            make_install_bin_O: make install-bin
              make_clean_all_O: make clean all
           make_no_libpython_O: make NO_LIBPYTHON=1
         make_install_prefix_O: make install prefix=/tmp/krava
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_no_libelf_O: make NO_LIBELF=1
                  make_debug_O: make DEBUG=1
                make_install_O: make install
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_pure_O: make
         make_with_coresight_O: make CORESIGHT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
            make_no_demangle_O: make NO_DEMANGLE=1
                    make_doc_O: make doc
                 make_no_sdt_O: make NO_SDT=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_with_libpfm4_O: make LIBPFM4=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_backtrace_O: make NO_BACKTRACE=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_help_O: make help
                 make_perf_o_O: make perf.o
             make_no_libperl_O: make NO_LIBPERL=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	4m39.761s
  user	59m56.067s
  sys	13m57.422s
  ⬢[acme@toolbox perf]$
