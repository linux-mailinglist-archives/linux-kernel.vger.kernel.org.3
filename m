Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB951F07C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiEHTfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiEHTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:34:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5D103A;
        Sun,  8 May 2022 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652038216;
        bh=bWo1NsHRzKo/7mczgQM8M9vFn1mbdbdEYbRB3K13bxc=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=HleKCe4hrwOyeZL6mHFuyy4edh6AkfgOvpHOfuEdLHq4wXjZFiADDTKgk3pgRO6yJ
         y5as1qZxQ5E0MVUUocQPLXWKR74Eo7ydi3qHgWCx4fS5mV72Tuxb/ROpDuJpUAYPdy
         pkhippR4gsFg64BCtTRB8tteUrP2jvkTtYm35P0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.176.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1o4lC10iGz-00uWjA; Sun, 08
 May 2022 21:30:16 +0200
Date:   Sun, 8 May 2022 21:30:14 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for v5.18-rc6
Message-ID: <YngaRj/nUEkAKbZL@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:JZjR+y9aDfGLRtGGgCp5cOJKE4NHd/k5bXin4pVbcUN9fyvV+Mr
 EMw4zPeeQyS4UT8N9MGY6aHanbalMVte07zSokiTeDt1aXO2dMple+WisbpJQ3esS4qBx3w
 G4ksGP1/6LomH2+Uwh56pSeQ/lGNNhZ584fqYvSoe05bqLz/sDwy0bb/087bXg3FL8HmnFI
 VBTRzmOvZJyEcI6IywQHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X0aIJu9HeXM=:hp1NnnHqz1LcaoHVaEICWe
 g23esKUJPHIR4HnM9hfLRde5gECBYMjqzfYvXqK2+miAR87yw/HgNspjqnkUzw5TuhZaZvWWc
 nc4NILWQA+wVBZyJwHVmENhQJZZkUT211133sZIXRCp4Iemp6ax0M7b2MLKuMKf3qvhatCfbo
 6cBg261EGiWxy4K4lfNZlt39crdBjRSwNTzIVcSf8Lh9kd2QGI1o0ywCE0L0rdmyzg0UZbIHh
 4ai3VepO+FN7KiRf6UPaTPW7ZZj/hfbeGDPdCeyQL3r1DsPB3oXPd6umqpUy5ekaVlOzh0DwJ
 OgmZEqotk1N8oL80uD+BwUwdPABmm+3GA+MUSz9G1DeMsz7PCwx/IJ1/lw7gahjP49zbJ1D4w
 04ODLuwqV61qIkpM5mYxZWuNp3okxWBaBerKLen4iUPbRlcpMbwclK8aHneWOFEFgoKxzolSC
 SB/0F0bzZ/5VKxMIs4m+1W7r1VGngMTgzYvg7wItJynlwA4+SZj2MaVpIFF8SqpPUqOJsg12p
 yfpsZJMIYiyWzQbPuCnW19py74FCHEcTH9Zs22edRk2Fi5b6t9mxYe56rbliWw9oujVco9Kkv
 Qu/+Dv1FQrRqaknRj7FHOaXTw9lbL7zpWPoRMNXSoYa63KL295S/bXJYYon7EkBaYH9NZUXqs
 KXt/Efxt6mD8ppHZsfxVYr4SDK7bkIBcSstMtiItXNuQXNR9wjjPso/BpPMQczhAOJqxakOy/
 xw0+cykrCzVJcpANDgdFUDnop2yKv48Ke6W5qFvefI0Mo1d+Zi/V3TTaItZTFa8MKp/hDxgjq
 aoNudTcru5s1AQ6Qmmh2UAw+PQhQNWs7k90B4AwGuLUU2UzA1sUERCfmMFgQvnJ31t43grIRX
 cQ8mibTZKGDnQBBtfXbh9IqLLH2uKQqqucQz2zUk1AvOkcC5wWcJnzKo2PLJWorgNmrc1cCPY
 pb+6PXfK8c8P34V4ggGzO+bG0pgzNF/B/iTrnSW3/Rs4dpFoxxDw2+wfyQNzcPo9R+dosyUWO
 t+7uYOKRnkcdnblYKPVYoqH7WepJzGFzmxeNoufPW+Dw9Wn/U8uL7lDAI3selqQjr+Ywgy9ha
 n0rI245Hn8N2pE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest set of fixes for the parisc architecture.

It includes 4 reverts of existing patches, which were necessary because we had
boot issues due to wrong CPU clock handling and cache issues which led to
userspace segfaults with 32bit kernels. Dave has a whole bunch of upcoming
cache fixes which I then plan to push in the next merge window.

Other than that there are just small updates and fixes, e.g. defconfig updates,
spelling fixes, a clocksource fix, boot topology fixes and a fix for
/proc/cpuinfo output to satisfy lscpu.

----------------------------------------------------------------

The following changes since commit 30c8e80f79329617012f07b09b70114592092ea4:

  Merge tag 'gpio-fixes-for-v5.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2022-05-07 11:02:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-3

for you to fetch changes up to ba0c04104082ca211e108dd8eec6db2ad7676528:

  Revert "parisc: Increase parisc_cache_flush_threshold setting" (2022-05-08 20:13:36 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v5.18-rc6

Some reverts of existing patches, which were necessary because of boot
issues due to wrong CPU clock handling and cache issues which led to
userspace segfaults with 32bit kernels.

Other than that just small updates and fixes, e.g. defconfig updates,
spelling fixes, a clocksource fix, boot topology fixes and a fix for
/proc/cpuinfo output to satisfy lscpu.

----------------------------------------------------------------
Helge Deller (10):
      Revert "parisc: Mark cr16 CPU clocksource unstable on all SMP machines"
      Revert "parisc: Mark sched_clock unstable only if clocks are not syncronized"
      Revert "parisc: Fix patch code locking and flushing"
      parisc: Only list existing CPUs in cpu_possible_mask
      parisc: Update 32- and 64-bit defconfigs
      parisc: Re-enable GENERIC_CPU_DEVICES for !SMP
      parisc: Merge model and model name into one line in /proc/cpuinfo
      parisc: Change MAX_ADDRESS to become unsigned long long
      parisc: Mark cr16 clock unstable on all SMP machines
      Revert "parisc: Increase parisc_cache_flush_threshold setting"

Julia Lawall (1):
      parisc: Fix typos in comments

 arch/parisc/Kconfig                         |  1 +
 arch/parisc/configs/generic-32bit_defconfig |  4 +++-
 arch/parisc/configs/generic-64bit_defconfig |  3 ++-
 arch/parisc/include/asm/pgtable.h           |  2 +-
 arch/parisc/kernel/cache.c                  | 18 +++---------------
 arch/parisc/kernel/kprobes.c                |  2 +-
 arch/parisc/kernel/patch.c                  | 25 ++++++++++++++-----------
 arch/parisc/kernel/processor.c              | 11 +++++++++--
 arch/parisc/kernel/setup.c                  |  2 ++
 arch/parisc/kernel/time.c                   |  6 +-----
 arch/parisc/kernel/traps.c                  |  2 +-
 arch/parisc/math-emu/dfadd.c                |  2 +-
 arch/parisc/math-emu/dfsub.c                |  2 +-
 arch/parisc/math-emu/sfadd.c                |  2 +-
 arch/parisc/math-emu/sfsub.c                |  2 +-
 15 files changed, 42 insertions(+), 42 deletions(-)
