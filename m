Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE84E350C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiCVAA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiCVAAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:00:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942156402
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:58:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so730224pjm.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2WCRaXyJNfT25RlaLnKjG5IpC0nuVkmevmwHgWTxhDU=;
        b=0PahQ6QoXT4pY0tIlmmNw7ASpnE4NmFxgFuO+xLrAyXX85d6f8PhKJBn2m6hW0Q4wq
         JfkR5Veqf5xw1F/A2K9qm1hKouQ4d2v16lK/jBwQgB1VM/Rv8ewdAybl0BLyAe+EEfkH
         FnnVoJ8R0dIUb0s7fbf5o0b58RDJs8QnChhSQHcPD5uRldk9yjkFRJOjCQJv2TBtEaqP
         Iu2FXWzxbVA9A1EkRoC4b7wI1kUtt7sOhvBDiEbAd+O2dzGHqazWDmsZPxIKb54AxYa2
         ndu0i9FriyKs+5Kmkj+2qIElTpqRFLSt0bXVW7H/04HWGv9m4HzJ7Jv2LRrMglJw6wCB
         3/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2WCRaXyJNfT25RlaLnKjG5IpC0nuVkmevmwHgWTxhDU=;
        b=M7I4t4z2/FvUCX+ZYvIkjbwDnA0yWL9U2gavV+S42ekNvuNvhiNlNwbB9PY1S07YJj
         BzR7Q0O6lDgFgjfeCA8v9Vccr1EUy+mHxm6GWpREE5pEH0PskBOERGzyVIeJmrbs9l7c
         3Te76w2js2MAfMFdWuxa5UXhkrJIEOJwDepEZwW9pwNF7hm7ACXLIrgSkfk+KU5+TZEx
         PY0IvF8TEX5i8XLb9waA6t8s8jwEH4Xlr6/yO6D+m+hZmbX3cpZ6ess/2OQ0VNVhTEfl
         HnnTI3/deWXo9nC46sujQgzveyG7m/xVf1QzWx17D4pL16HqfhrUQN2HTONEfpxW0Dy3
         5RDg==
X-Gm-Message-State: AOAM531jvw31p+H7+u9o4ikYYHMLK/hO155YLZY7CJuvSzfz5DJ1+yP0
        +xKJI5APG6wi3QBZXety2JvUPpHwWbuQWw==
X-Google-Smtp-Source: ABdhPJxXEhHVuh8zmmi6r9ISLVsMdKJWOUN2ppxSOSVlZR97nu7sLik7vSo0/LIUqdJKE4D35J4HSA==
X-Received: by 2002:a17:902:db0d:b0:14f:b047:8d22 with SMTP id m13-20020a170902db0d00b0014fb0478d22mr14974715plx.90.1647907066311;
        Mon, 21 Mar 2022 16:57:46 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm20890232pfx.34.2022.03.21.16.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:57:44 -0700 (PDT)
Date:   Mon, 21 Mar 2022 16:57:44 -0700 (PDT)
X-Google-Original-Date: Mon, 21 Mar 2022 16:57:41 PDT (-0700)
Subject:     Re: [v6 0/9] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
In-Reply-To: <20220219004700.1973682-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, anup@brainfault.org, damien.lemoal@wdc.com,
        devicetree@vger.kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-11acdcb6-8dfc-46dd-bc30-4efc85e8a0ed@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 16:46:51 PST (-0800), Atish Patra wrote:
> This series adds improved perf support for RISC-V based system using
> SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension allows
> the kernel to program the counters for different events and start/stop counters
> while the sscofpmf extension allows the counter overflow interrupt and privilege
> mode filtering. An hardware platform can leverage SBI PMU extension without
> the sscofpmf extension if it supports mcounteren at least. Perf stat will work
> but record won't work as sscofpmf & mcountinhibit is required to support that.
> A platform can support both features event counting and sampling using perf
> tool only if sscofpmf is supported.
>
> This series introduces a platform perf driver instead of a existing arch
> specific implementation. The new perf implementation has adopted a modular
> approach where most of the generic event handling is done in the core library
> while individual PMUs need to only implement necessary features specific to
> the PMU. This is easily extensible and any future RISC-V PMU implementation
> can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
> as a part of this series.
>
> The legacy driver tries to reimplement the existing minimal perf under a new
> config to maintain backward compatibility. This implementation only allows
> monitoring of always running cycle/instruction counters. Moreover, they can
> not be started or stopped. In general, this is very limited and not very useful.
> That's why, I am not very keen to carry the support into the new driver.
> However, I don't want to break perf for any existing hardware platforms.
> If everybody agrees that we don't need legacy perf implementation for older
> implementation, I will be happy to drop PATCH 4.
>
> This series has been tested in Qemu (RV64 & RV32) and HiFive Unmatched.
> Qemu patches[4] and OpenSBI v1.0 is required to test it on Qemu and a dt patch
> required in U-Boot[5] for HiFive Unmatched. Qemu changes are not
> backward compatible. That means, you can not use perf anymore on older Qemu
> versions with latest OpenSBI and/or Kernel. However, newer kernel will
> just use legacy pmu driver if old OpenSBI is detected.
>
> The U-Boot patch is just an example that encodes few of the events defined
> in fu740 documentation [6] in the DT. We can update the DT to include all the
> events defined if required.
>
> This series depends on the ISA extension parsing series[7].
>
> Here is an output of perf stat/report while running perf benchmark with OpenSBI,
> Linux kernel and U-Boot patches applied.
>
> HiFive Unmatched:
> =================
> perf stat -e cycles -e instructions -e L1-icache-load-misses -e branches -e branch-misses \
> -e r0000000000000200 -e r0000000000000400 \
> -e r0000000000000800 perf bench sched messaging -g 25 -l 15
>
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 25 groups == 1000 processes run
>
>      Total time: 0.826 [sec]
>
>  Performance counter stats for 'perf bench sched messaging -g 25 -l 15':
>
>         3426710073      cycles                (65.92%)
>         1348772808      instructions          #0.39  insn per cycle  (75.44%)
>                  0      L1-icache-load-misses (72.28%)
>          201133996      branches              (67.88%)
>           44663584      branch-misses         #22.21% of all branches (35.01%)
>          248194747      r0000000000000200     (41.94%) --> Integer load instruction retired
>          156879950      r0000000000000400     (43.58%) --> Integer store instruction retired
>            6988678      r0000000000000800     (47.91%) --> Atomic memory operation retired
>
>        1.931335000 seconds time elapsed
>
>        1.100415000 seconds user
>        3.755176000 seconds sys
>
>
> QEMU:
> =========
> Perf stat:
> =========
>
> [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r8000000000000007 \
> -e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branch-misses \
> -e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
> -e cycles -e instructions perf bench sched messaging -g 15 -l 10 \
> Running with 15*40 (== 600) tasks.
> Time: 6.578
>
>  Performance counter stats for './hackbench -pipe 15 process':
>
>              1,794      r8000000000000005      (52.59%) --> SBI_PMU_FW_SET_TIMER
>              2,859      r8000000000000007      (60.74%) --> SBI_PMU_FW_IPI_RECVD
>              4,205      r8000000000000006      (68.71%) --> SBI_PMU_FW_IPI_SENT
>                  0      r0000000000020002      (81.69%)
>      <not counted>      r0000000000020004      (0.00%)
>      <not counted>      branch-misses          (0.00%)
>      <not counted>      cache-misses           (0.00%)
>          7,878,328      dTLB-load-misses       (15.60%)
>            680,270      dTLB-store-misses      (28.45%)
>          8,287,931      iTLB-load-misses       (39.24%)
>     20,008,506,675      cycles                 (48.60%)
>     21,484,427,932      instructions   # 1.07  insn per cycle (56.60%)
>
>        1.681344735 seconds time elapsed
>
>        0.614460000 seconds user
>        8.313254000 seconds sys
>
>
> [root@fedora-riscv ~]# perf stat -e cycles -e instructions -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
>> perf bench sched messaging -g 1 -l 10
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 1 groups == 40 processes run
>
>      Total time: 0.218 [sec]
>
>  Performance counter stats for 'perf bench sched messaging -g 1 -l 10':
>
>      3,685,401,394      cycles
>      3,684,529,388      instructions              #    1.00  insn per cycle
>          3,006,042      dTLB-load-misses
>            258,144      dTLB-store-misses
>          1,992,860      iTLB-load-misses
>
>        0.588717389 seconds time elapsed
>
>        0.324009000 seconds user
>        0.937087000 seconds sys
>
> [root@fedora-riscv ~]# perf record -e cycles -e instructions -e dTLB-load-misses -e dTLB-store-misses \
> -e iTLB-load-misses -c 10000 perf bench sched messaging -g 1 -l 10
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 1 groups == 40 processes run
>
>      Total time: 2.160 [sec]
> [ perf record: Woken up 11 times to write data ]
> Warning:
> Processed 291769 events and lost 1 chunks!
>
> [root@fedora-riscv ~]# perf report
>
> Available samples
> 146K cycles                                                                    ◆
> 146K instructions                                                              ▒
> 298 dTLB-load-misses                                                           ▒
> 8 dTLB-store-misses                                                            ▒
> 211 iTLB-load-misses
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
> [3] https://github.com/atishp04/linux/tree/riscv_pmu_v6
> [4] https://github.com/atishp04/qemu/tree/riscv_pmu_v5
> [5] https://github.com/atishp04/u-boot/tree/hifive_unmatched_dt_pmu
> [6] https://sifive.cdn.prismic.io/sifive/de1491e5-077c-461d-9605-e8a0ce57337d_fu740-c000-manual-v1p3.pdf
> [7] https://lkml.org/lkml/2022/2/15/1604
>
> Changes from v5->v6:
> 1. Split the used counters bitmap to firmware and hardware so that we don't
>    have to generate a hardware only used counter mask during overflow handling.
> 2. Stopped all the counters during cpu hotplug to restore correct behavior.
> 3. Addressed all the comments during the v5 review.
> 4. Rebased on top of the isa extension framework series and 5.17-rc4.
>
> Changes from v4->v5:
> 1. Fixed few corner case issues in perf interrupt handling.
> 2. Changed the set_period API so that the caller can compute the initialize
>    value.
> 3. Fixed the per cpu interrupt enablement issue.
> 4. Fixed a bug for the privilege mode filtering.
> 5. Modified the sbi driver independent of the DT.
> 6. Removed any DT related modifications.
>
> Changes from v3->v4:
> 1. Do not proceed overflow handler if event doesn't set for sampling.
> 2. overflow status register is only read after counters are stopped.
> 3. Added the PMU DT node for HiFive Unmatched.
>
> Changes from v2->v3:
> 1. Added interrupt overflow support.
> 2. Cleaned up legacy driver initialization.
> 3. Supports perf record now.
> 4. Added the DT binding and maintainers file.
> 5. Changed cpu hotplug notifier to be multi-state.
> 6. OpenSBI doesn't disable cycle/instret counter during boot. Update the
>    perf code to disable all the counter during the boot.
>
> Changes from v1->v2
> 1. Implemented the latest SBI PMU extension specification.
> 2. The core platform driver was changed to operate as a library while only
>    sbi based PMU is built as a driver. The legacy one is just a fallback if
>    SBI PMU extension is not available.
>
> Atish Patra (9):
> RISC-V: Remove the current perf implementation
> RISC-V: Add CSR encodings for all HPMCOUNTERS
> RISC-V: Add a perf core library for pmu drivers
> RISC-V: Add a simple platform driver for RISC-V legacy perf
> RISC-V: Add RISC-V SBI PMU extension definitions
> RISC-V: Add perf platform driver based on SBI PMU extension
> RISC-V: Add sscofpmf extension support
> Documentation: riscv: Remove the old documentation
> MAINTAINERS: Add entry for RISC-V PMU drivers
>
> Documentation/riscv/pmu.rst         | 255 ---------
> MAINTAINERS                         |   9 +
> arch/riscv/Kconfig                  |  13 -
> arch/riscv/include/asm/csr.h        |  66 ++-
> arch/riscv/include/asm/hwcap.h      |   1 +
> arch/riscv/include/asm/perf_event.h |  72 ---
> arch/riscv/include/asm/sbi.h        |  95 ++++
> arch/riscv/kernel/Makefile          |   1 -
> arch/riscv/kernel/cpu.c             |   1 +
> arch/riscv/kernel/cpufeature.c      |   2 +
> arch/riscv/kernel/perf_event.c      | 485 -----------------
> drivers/perf/Kconfig                |  30 ++
> drivers/perf/Makefile               |   3 +
> drivers/perf/riscv_pmu.c            | 324 ++++++++++++
> drivers/perf/riscv_pmu_legacy.c     | 142 +++++
> drivers/perf/riscv_pmu_sbi.c        | 790 ++++++++++++++++++++++++++++
> include/linux/cpuhotplug.h          |   1 +
> include/linux/perf/riscv_pmu.h      |  75 +++
> 18 files changed, 1538 insertions(+), 827 deletions(-)
> delete mode 100644 Documentation/riscv/pmu.rst
> delete mode 100644 arch/riscv/kernel/perf_event.c
> create mode 100644 drivers/perf/riscv_pmu.c
> create mode 100644 drivers/perf/riscv_pmu_legacy.c
> create mode 100644 drivers/perf/riscv_pmu_sbi.c
> create mode 100644 include/linux/perf/riscv_pmu.h

Thanks, this is on for-next.
