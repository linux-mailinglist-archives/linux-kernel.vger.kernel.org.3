Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6A248F829
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiAORKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiAORKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:10:48 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5BC061574;
        Sat, 15 Jan 2022 09:10:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c3so15911728pls.5;
        Sat, 15 Jan 2022 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZbAfuW1XWY9HaUdMD8hJuwmFfyCOS07KigrE8S+BFHk=;
        b=ZLSF7DGk12toPT8H7bM/RZjVKNh6ds3T/W+4W7QejIQg3f2GdxuRzPLj7lMZufz2KS
         7SfhFv6eBPh3GQUwEHDsoqsfZQDOwjcgOXenYsddce5Twmkc+CU4TqRwxWaXOdnqW5Dn
         p1g89/XswyuZaNGJrKdlpMVjklLLf5P5RZhxaPo+2ky/GGOojOEH4sJqX+CsYFP1aC+o
         JJJXV+ID+WRAn/PzanIQktNoL7x35AGky5AilW7i9aofoIQ7+Jkxdhy3SBaS8bNoyEMH
         CM1nxUh6h25PlBT5+8hQRl4U1qcyKnseDbxvfP6oS/pC4uWoKQQfV0NbHpNjPxKpws38
         VmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZbAfuW1XWY9HaUdMD8hJuwmFfyCOS07KigrE8S+BFHk=;
        b=mpFLgIx6p2myO5QOWRRqf+2o8OgUp4fCP1Cem8lNErv1o1sWPin9fBJmWYAYmdUHut
         3GSpipy9bk/gyrdsHoM0iv8dIAA/8zt0itTWboNklBzBdSejvD+WFuN4RaS56bTM+SLn
         zJrHSrwQlcjKiZM2QFvjm1yDiapqKE+IK9hrK3D16NvOPpxiq78H7yEbllYY448rds38
         R07u+qQnIOWDtj9r5G9lL/ZUpd29q+dbXNkCaQf2xCDPa1dYe2nq9yGqTrn0mqiM50ez
         SD4Df8qzILpTdu6UHtKHnE5NgaCc3sNWVQpCdRoJms7vNB1jt5Sopch5QJ7JaXNCXvcF
         VJcw==
X-Gm-Message-State: AOAM532NAxukmBYhi2Y2gZX2ggQ404zkPPuEICip/yg11eBwc54kSTYD
        Yb6XXs0yaZgTmwfiZwbPOVHfpezFx8i1Wn0o6jE=
X-Google-Smtp-Source: ABdhPJy2O0baAy/pVYzY1xhuksgifczAOmTVCuqrQOQpCTTeVEXaOoRMu9vb2xstPBoTtki77TFry1AkUc7l1DEx1DE=
X-Received: by 2002:a17:90b:1d83:: with SMTP id pf3mr26040320pjb.228.1642266647763;
 Sat, 15 Jan 2022 09:10:47 -0800 (PST)
MIME-Version: 1.0
From:   Yury Norov <yury.norov@gmail.com>
Date:   Sat, 15 Jan 2022 09:10:36 -0800
Message-ID: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
Subject: [GIT PULL] Bitmap patches for 5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Zhou <dennis@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-mm <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  git://github.com/norov/linux.git/ tags/bitmap-5.17-rc1

for you to fetch changes up to 15325b4f768f2b27b5765489eeab6ec0d6b5e902:

  vsprintf: rework bitmap_list_string (2022-01-15 08:47:31 -0800)

----------------------------------------------------------------
bitmap patches for 5.17-rc1

Hi Linus, please pull these patches for bitmap. They were supposed to
be pulled in 5.16 cycle, but due to merge glitch we decided to merge them
in 5.17.

Thanks,
Yury
----------------------------------------------------------------
Yury Norov (16):
      bitops: protect find_first_{,zero}_bit properly
      bitops: move find_bit_*_le functions from le.h to find.h
      include: move find.h from asm_generic to linux
      arch: remove GENERIC_FIND_FIRST_BIT entirely
      lib: add find_first_and_bit()
      cpumask: use find_first_and_bit()
      all: replace find_next{,_zero}_bit with find_first{,_zero}_bit
where appropriate
      tools: sync tools/bitmap with mother linux
      cpumask: replace cpumask_next_* with cpumask_first_* where appropriate
      include/linux: move for_each_bit() macros from bitops.h to find.h
      find: micro-optimize for_each_{set,clear}_bit()
      Replace for_each_*_bit_from() with for_each_*_bit() where appropriate
      mm/percpu: micro-optimize pcpu_is_populated()
      bitmap: unify find_bit operations
      lib: bitmap: add performance test for bitmap_print_to_pagebuf
      vsprintf: rework bitmap_list_string

 MAINTAINERS                                                |   4 +-
 arch/alpha/include/asm/bitops.h                            |   2 -
 arch/arc/Kconfig                                           |   1 -
 arch/arc/include/asm/bitops.h                              |   1 -
 arch/arm/include/asm/bitops.h                              |   1 -
 arch/arm64/Kconfig                                         |   1 -
 arch/arm64/include/asm/bitops.h                            |   1 -
 arch/csky/include/asm/bitops.h                             |   1 -
 arch/h8300/include/asm/bitops.h                            |   1 -
 arch/hexagon/include/asm/bitops.h                          |   1 -
 arch/ia64/include/asm/bitops.h                             |   2 -
 arch/m68k/include/asm/bitops.h                             |   2 -
 arch/mips/Kconfig                                          |   1 -
 arch/mips/include/asm/bitops.h                             |   1 -
 arch/openrisc/include/asm/bitops.h                         |   1 -
 arch/parisc/include/asm/bitops.h                           |   1 -
 arch/powerpc/include/asm/bitops.h                          |   2 -
 arch/powerpc/platforms/pasemi/dma_lib.c                    |   4 +-
 arch/riscv/include/asm/bitops.h                            |   1 -
 arch/s390/Kconfig                                          |   1 -
 arch/s390/include/asm/bitops.h                             |   1 -
 arch/s390/kvm/kvm-s390.c                                   |   2 +-
 arch/sh/include/asm/bitops.h                               |   1 -
 arch/sparc/include/asm/bitops_32.h                         |   1 -
 arch/sparc/include/asm/bitops_64.h                         |   2 -
 arch/x86/Kconfig                                           |   1 -
 arch/x86/include/asm/bitops.h                              |   2 -
 arch/x86/kernel/apic/vector.c                              |   4 +-
 arch/x86/um/Kconfig                                        |   1 -
 arch/xtensa/include/asm/bitops.h                           |   1 -
 block/blk-mq.c                                             |   2 +-
 drivers/block/rnbd/rnbd-clt.c                              |   2 +-
 drivers/dma/ti/edma.c                                      |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                      |   4 +-
 drivers/hwmon/ltc2992.c                                    |   3 +-
 drivers/iio/adc/ad7124.c                                   |   2 +-
 drivers/infiniband/hw/irdma/hw.c                           |  16 +-
 drivers/media/cec/core/cec-core.c                          |   2 +-
 drivers/media/mc/mc-devnode.c                              |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c                       |   2 +-
 drivers/net/virtio_net.c                                   |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c                    |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c                               |  10 +-
 drivers/soc/fsl/qbman/bman_portal.c                        |   2 +-
 drivers/soc/fsl/qbman/qman_portal.c                        |   2 +-
 drivers/soc/ti/k3-ringacc.c                                |   4 +-
 drivers/tty/n_tty.c                                        |   2 +-
 drivers/virt/acrn/ioreq.c                                  |   3 +-
 fs/f2fs/segment.c                                          |   8 +-
 fs/ocfs2/cluster/heartbeat.c                               |   2 +-
 fs/ocfs2/dlm/dlmdomain.c                                   |   4 +-
 fs/ocfs2/dlm/dlmmaster.c                                   |  18 +-
 fs/ocfs2/dlm/dlmrecovery.c                                 |   2 +-
 fs/ocfs2/dlm/dlmthread.c                                   |   2 +-
 include/asm-generic/bitops.h                               |   1 -
 include/asm-generic/bitops/le.h                            |  64 -------
 include/linux/bitmap.h                                     |  34 +---
 include/linux/bitops.h                                     |  34 ----
 include/linux/cpumask.h                                    |  46 ++++-
 include/linux/find.h                                       | 372
++++++++++++++++++++++++++++++++++++++
 kernel/time/clocksource.c                                  |   4 +-
 lib/Kconfig                                                |   3 -
 lib/find_bit.c                                             |  21 +++
 lib/find_bit_benchmark.c                                   |  21 +++
 lib/genalloc.c                                             |   2 +-
 lib/test_bitmap.c                                          |  37 ++++
 lib/vsprintf.c                                             |  24 +--
 mm/percpu.c                                                |  35 ++--
 net/ncsi/ncsi-manage.c                                     |   4 +-
 tools/include/asm-generic/bitops.h                         |   1 -
 tools/include/asm-generic/bitops/find.h                    | 145
---------------
 tools/include/linux/bitmap.h                               |   7 +-
 {include/asm-generic/bitops => tools/include/linux}/find.h |  54 ++++--
 tools/lib/find_bit.c                                       |  20 ++
 74 files changed, 636 insertions(+), 439 deletions(-)
 create mode 100644 include/linux/find.h
 delete mode 100644 tools/include/asm-generic/bitops/find.h
 rename {include/asm-generic/bitops => tools/include/linux}/find.h (83%)
