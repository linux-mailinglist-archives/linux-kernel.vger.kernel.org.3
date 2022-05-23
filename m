Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DF530B00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiEWIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiEWIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:01:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D91E09A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:01:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p22so24121083lfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=543COb3o10G2My0ILa7Mc1EXCIR7+2EdAMRpl+m6Qc4=;
        b=M3CdKej+MktkXxivYsN8g3EgibTEUvvBGZhUzFY4w3N4jlqXyLoNwuLPkLLPvsbVre
         02b8zWugPSC3SY7m5bGzwtdpwgWbHfUad0hV+/sAegsA0QTLeyfmzIrQSveuYsk2C94B
         xLQo5QMY+vuzXxNCLE666vUovTYlHom9lh+TSsp8sItbzDA3nxz/E92zqTZh8hZC5aux
         LW8dnY8ArT1mPYGlDLcSY1vSoZfWvq67C4qpi7zdpvIIt4nZ+kq0wQix3YKCuJucPdaq
         /LJC99LAB45Ki8AWD/gfORh5cpHn6sr4QH2EKUWbdNJkn8UUgCKL/UsGsJc58mWF3dSc
         TGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=543COb3o10G2My0ILa7Mc1EXCIR7+2EdAMRpl+m6Qc4=;
        b=TNDPZIIJyB1Y6aM56DQTOMOPpih1y+eMDehIifqlPfceKSO04XGiW2V1jpllLX5Iu8
         pY5nVuSIyKnwr3AxZxu4YeERHHVbF0e0CfXegF/UeEhygF3oNqpnz1uEm4hxdPiyexLZ
         dsqodof1KY5nl7oNjoCtxTDPUKkjO/YBfLqJPRyY8pz5g8wAOC6xdxTu4iv1Mc0mpyed
         sZHeog8GTh2JedshHTPn9mu+qGFCi3DENC1+GWtM/+9Tk6ssYkWh7ipeaxO5sxsPKCpB
         XtRzkxWSnymFwcif7Mon84TWtlWqxn/VCi0tfEeZvtNq4s0MGgzEktP2JbUlWZ0VZeP3
         YWyA==
X-Gm-Message-State: AOAM5308JyM2hwQxUIHcey7KHMSrUN3En0f/nlcqjn2SE6Ud220UyAiy
        MQEsR3vF1hSS06cGcOTK8eY=
X-Google-Smtp-Source: ABdhPJy+plyamPb+mRkp5yqHA+/150ABo1h6lqMIHD+1xmIDn67Td1m5dQjX9LYEPle5LLVd5br8Cw==
X-Received: by 2002:ac2:46e8:0:b0:477:ba2c:a68b with SMTP id q8-20020ac246e8000000b00477ba2ca68bmr15390881lfo.55.1653292897804;
        Mon, 23 May 2022 01:01:37 -0700 (PDT)
Received: from octofox.metropolis ([212.58.114.186])
        by smtp.gmail.com with ESMTPSA id k1-20020ac24561000000b0047255d21143sm1772209lfm.114.2022.05.23.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:01:37 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/36] xtensa updates for v5.19
Date:   Mon, 23 May 2022 01:01:07 -0700
Message-Id: <20220523080107.720784-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following updates for the xtensa architecture.

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220523

for you to fetch changes up to dc60001e1a305ad8bba1ddaf09484e0e150aba60:

  xtensa: Return true/false (not 1/0) from bool function (2022-05-23 00:33:05 -0700)

----------------------------------------------------------------
Xtensa updates for v5.19

- support coprocessors on SMP
- support KCSAN
- support handling protection faults in noMMU configurations
- support using coprocessors in the kernel mode
- support hibernation
- enable context tracking
- enable HAVE_VIRT_CPU_ACCOUNTING_GEN
- support division by 0 exception on cores without HW division option
- clean up locking in the ISS network driver
- clean up kernel entry assemly code
- various minor fixes

----------------------------------------------------------------
Jason Wang (1):
      xtensa: no need to initialise statics to 0

Max Filippov (33):
      xtensa: localize labels used in memmove
      xtensa: iss: drop opened_list logic from the network driver
      xtensa: iss: replace iss_net_set_mac with eth_mac_addr
      xtensa: iss: clean up per-device locking in network driver
      xtensa: iss: extract and constify network callbacks
      xtensa: move asid_cache from fault.c to mmu.c
      xtensa: extract vmalloc_fault code into a function
      xtensa: noMMU: allow handling protection faults
      xtensa: drop dead code from entry.S
      xtensa: move trace_hardirqs_off call back to entry.S
      xtensa: use abi_* register names in the kernel exit code
      xtensa: enable context tracking
      xtensa: enable HAVE_VIRT_CPU_ACCOUNTING_GEN
      xtensa: enable KCSAN
      xtensa: clean up function declarations in traps.c
      xtensa: clean up exception handler prototypes
      xtensa: clean up declarations in coprocessor.h
      xtensa: clean up excsave1 initialization
      xtensa: use callx0 opcode in fast_coprocessor
      xtensa: handle coprocessor exceptions in kernel mode
      xtensa: add xtensa_xsr macro
      xtensa: merge SAVE_CP_REGS_TAB and LOAD_CP_REGS_TAB
      xtensa: get rid of stack frame in coprocessor_flush
      xtensa: support coprocessors on SMP
      xtensa: add hibernation support
      xtensa: enable ARCH_HAS_DEBUG_VM_PGTABLE
      irqchip: irq-xtensa-mx: fix initial IRQ affinity
      xtensa: fix declaration of _SecondaryResetVector_text_*
      xtensa: don't leave invalid TLB entry in fast_store_prohibited
      xtensa: clean up labels in the kernel entry assembly
      xtensa: add trap handler for division by zero
      xtensa: support artificial division by 0 exception
      xtensa: improve call0 ABI probing

Yang Li (1):
      xtensa: Return true/false (not 1/0) from bool function

Yi Yang (1):
      xtensa/simdisk: fix proc_read_simdisk()

 .../debug/debug-vm-pgtable/arch-support.txt        |   2 +-
 .../time/context-tracking/arch-support.txt         |   2 +-
 .../features/time/virt-cpuacct/arch-support.txt    |   2 +-
 arch/xtensa/Kconfig                                |  18 ++
 arch/xtensa/boot/lib/Makefile                      |   1 +
 arch/xtensa/include/asm/barrier.h                  |  12 +-
 arch/xtensa/include/asm/bitops.h                   |  10 +-
 arch/xtensa/include/asm/coprocessor.h              |  11 +-
 arch/xtensa/include/asm/processor.h                |   7 +
 arch/xtensa/include/asm/sections.h                 |   2 +-
 arch/xtensa/include/asm/thread_info.h              |  11 +-
 arch/xtensa/include/asm/traps.h                    |  40 ++-
 arch/xtensa/kernel/Makefile                        |   1 +
 arch/xtensa/kernel/asm-offsets.c                   |  19 +-
 arch/xtensa/kernel/coprocessor.S                   | 230 ++++++++------
 arch/xtensa/kernel/entry.S                         | 335 ++++++++++++++-------
 arch/xtensa/kernel/hibernate.c                     |  25 ++
 arch/xtensa/kernel/process.c                       | 112 +++++--
 arch/xtensa/kernel/ptrace.c                        |   3 +-
 arch/xtensa/kernel/s32c1i_selftest.c               |   7 +-
 arch/xtensa/kernel/signal.c                        |   3 +-
 arch/xtensa/kernel/smp.c                           |   7 +
 arch/xtensa/kernel/traps.c                         | 143 +++++----
 arch/xtensa/lib/Makefile                           |   2 +
 arch/xtensa/lib/kcsan-stubs.c                      |  54 ++++
 arch/xtensa/lib/memcopy.S                          |  20 +-
 arch/xtensa/mm/Makefile                            |   3 +-
 arch/xtensa/mm/fault.c                             | 112 +++----
 arch/xtensa/mm/mmu.c                               |   2 +
 arch/xtensa/platforms/iss/network.c                | 150 ++++-----
 arch/xtensa/platforms/iss/simdisk.c                |  18 +-
 arch/xtensa/platforms/xt2000/setup.c               |   2 +-
 drivers/irqchip/irq-xtensa-mx.c                    |  18 +-
 33 files changed, 896 insertions(+), 488 deletions(-)
 create mode 100644 arch/xtensa/kernel/hibernate.c
 create mode 100644 arch/xtensa/lib/kcsan-stubs.c

-- 
Thanks.
-- Max
