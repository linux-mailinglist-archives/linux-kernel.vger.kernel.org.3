Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC01546BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiFJRbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbiFJRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:31:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4271CE781;
        Fri, 10 Jun 2022 10:31:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C23395CC;
        Fri, 10 Jun 2022 17:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C23395CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654882261; bh=LHNWIZejSrX/E/iorq8X9FF5y8jRZt3nffd9SWiAc+c=;
        h=From:To:Cc:Subject:Date:From;
        b=TU7OO79TgvV6QTpsplDGDM9I/67MUSeP73aF7hzNQf6amivRixBoo1Th9QAXXUbad
         Z9MEZHDqp+qqa+m/mkze8LBU2cYOm56nh1xIrit3t2b+cn1ARstnIc2F2aTPsp5QPa
         2o7i2MXRkhF0BnZtfGXPTD2zGQW9kD+9HO2YO5fKaMWLuRCQiivtvt+rT1S7NbNv9E
         q+GydDQQGXEpAUMDWl1j2IX75hT17jijbCKTNojqzs5AY+iFDBJOQp8eUOjBTPRRDA
         4umfaGSANzIYhk5gUt6fE+U5wqhPhGsuNFXSjnzbqCgA0lnvdp1h0KUzGas1DlfDsy
         zM2mu9Q4EUxFQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.19
Date:   Fri, 10 Jun 2022 11:31:01 -0600
Message-ID: <87h74s77e2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.19-3

for you to fetch changes up to 387c67afccbb271707cbe6de2817f4e4c76287ad:

  docs: arm: tcm: Fix typo in description of TCM and MMU usage (2022-06-09 12:56:33 -0600)

----------------------------------------------------------------
A few documentation fixes for 5.19, including moving the new HTE docs to a
more suitable location, adding loongarch to the features lists, and a
couple of typo fixes.

----------------------------------------------------------------
Jonathan Corbet (1):
      docs: Move the HTE documentation to driver-api/

Justin Swartz (1):
      docs: usb: fix literal block marker in usbmon verification example

Simon Horman (1):
      docs: arm: tcm: Fix typo in description of TCM and MMU usage

Zheng Zengkai (1):
      Documentation/features: Update the arch support status files

 Documentation/arm/tcm.rst                                          | 2 +-
 Documentation/{ => driver-api}/hte/hte.rst                         | 0
 Documentation/{ => driver-api}/hte/index.rst                       | 0
 Documentation/{ => driver-api}/hte/tegra194-hte.rst                | 0
 Documentation/driver-api/index.rst                                 | 1 +
 Documentation/features/core/cBPF-JIT/arch-support.txt              | 1 +
 Documentation/features/core/eBPF-JIT/arch-support.txt              | 1 +
 Documentation/features/core/generic-idle-thread/arch-support.txt   | 1 +
 Documentation/features/core/jump-labels/arch-support.txt           | 1 +
 Documentation/features/core/thread-info-in-task/arch-support.txt   | 1 +
 Documentation/features/core/tracehook/arch-support.txt             | 1 +
 Documentation/features/debug/KASAN/arch-support.txt                | 1 +
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt     | 3 ++-
 Documentation/features/debug/gcov-profile-all/arch-support.txt     | 3 ++-
 Documentation/features/debug/kcov/arch-support.txt                 | 1 +
 Documentation/features/debug/kgdb/arch-support.txt                 | 1 +
 Documentation/features/debug/kmemleak/arch-support.txt             | 1 +
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 1 +
 Documentation/features/debug/kprobes/arch-support.txt              | 1 +
 Documentation/features/debug/kretprobes/arch-support.txt           | 1 +
 Documentation/features/debug/optprobes/arch-support.txt            | 1 +
 Documentation/features/debug/stackprotector/arch-support.txt       | 1 +
 Documentation/features/debug/uprobes/arch-support.txt              | 1 +
 Documentation/features/debug/user-ret-profiler/arch-support.txt    | 1 +
 Documentation/features/io/dma-contiguous/arch-support.txt          | 1 +
 Documentation/features/locking/cmpxchg-local/arch-support.txt      | 1 +
 Documentation/features/locking/lockdep/arch-support.txt            | 1 +
 Documentation/features/locking/queued-rwlocks/arch-support.txt     | 3 ++-
 Documentation/features/locking/queued-spinlocks/arch-support.txt   | 1 +
 Documentation/features/perf/kprobes-event/arch-support.txt         | 3 ++-
 Documentation/features/perf/perf-regs/arch-support.txt             | 1 +
 Documentation/features/perf/perf-stackdump/arch-support.txt        | 1 +
 Documentation/features/sched/membarrier-sync-core/arch-support.txt | 1 +
 Documentation/features/sched/numa-balancing/arch-support.txt       | 1 +
 Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 1 +
 Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 1 +
 Documentation/features/time/clockevents/arch-support.txt           | 1 +
 Documentation/features/time/context-tracking/arch-support.txt      | 1 +
 Documentation/features/time/irq-time-acct/arch-support.txt         | 1 +
 Documentation/features/time/virt-cpuacct/arch-support.txt          | 1 +
 Documentation/features/vm/ELF-ASLR/arch-support.txt                | 1 +
 Documentation/features/vm/PG_uncached/arch-support.txt             | 1 +
 Documentation/features/vm/THP/arch-support.txt                     | 1 +
 Documentation/features/vm/TLB/arch-support.txt                     | 1 +
 Documentation/features/vm/huge-vmap/arch-support.txt               | 1 +
 Documentation/features/vm/ioremap_prot/arch-support.txt            | 1 +
 Documentation/features/vm/pte_special/arch-support.txt             | 3 ++-
 Documentation/index.rst                                            | 1 -
 Documentation/usb/usbmon.rst                                       | 2 +-
 MAINTAINERS                                                        | 2 +-
 50 files changed, 51 insertions(+), 9 deletions(-)
 rename Documentation/{ => driver-api}/hte/hte.rst (100%)
 rename Documentation/{ => driver-api}/hte/index.rst (100%)
 rename Documentation/{ => driver-api}/hte/tegra194-hte.rst (100%)
