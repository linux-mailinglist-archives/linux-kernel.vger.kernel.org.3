Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECC53D27D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbiFCTsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349338AbiFCTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:48:23 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9D3C4A5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:48:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r65so11663422oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rJbGYhPXmdmUU1rpXgtZOZ0rbYPtaMUluT7u34YQc+k=;
        b=PSeX+ah8/CcVYWIDXHZiwoxmikkzzleZuTKtu1nyI7D4XtdImvvJg+1CqNwc8P/Ucr
         etZM4CvbDM+plWXxztuWX5RweH+J6/uIRkQca5QI5AO5xoPb/1h7neru94RakSCTa7q+
         R5+HllauQoLdpXm/bBo4CeemmcRv+JjW0CvUlgaekwBRXpeHnxpYfQTnmHZ6u91ZuaCd
         1FvzcB++ewCtQPr1M/ZK1YVmtDeUtvsYdHZJPv9hBsULK7U/6j5Xhl2MiSYzvCf7rkfO
         U0M0gNEtIa3cnUVXfZPQFKI3e4rXnLFsRqe5kdt9f0Sl+DRPxi7JNrrlFSFoBh2Fw18H
         hpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rJbGYhPXmdmUU1rpXgtZOZ0rbYPtaMUluT7u34YQc+k=;
        b=q8sxM8bpCgDZ19WrOooB6gmUsc+EfhWR12gWgPhKRzVpA3ztM3sif+wBtq2OeOgFY3
         aozYwDjP+iekCQQHum2vswwsUFezGldj3R8JZeEc/xAFnOA/NrNNpb7IYcDMVdViHT/x
         Hbrv3jK4d0z+9w6Ck4bzAu4svOrNfzp3ylwvIA6bxzJJE8zss17iSLcktX0+wAbxHGMH
         iGHFpYexRSBgsoah1lhqVa1mE84GNhG9QCkVu61Whcs1Pf3N0NzV2vFxXStNKGnCTeIy
         EVcj/ipD1mpvggGuXZRBd9L5aILxIASg5O7dIY0GSGmvvTW3RqmjkH6qiirYRUvJG69S
         FYhQ==
X-Gm-Message-State: AOAM531r9Xjt5gqABJiT7epSb4W8GfUGEHhr6AoXXCsBBsMmucup8L2E
        XQlZSbLPgRYfNAMg0XvBUKI=
X-Google-Smtp-Source: ABdhPJxPbCWTIlZ/CT+IBeY3+2mIvr0jjLC5rgqhmIypLj/PDbIrcdGE+GWki2Fw+2f2eRKVf673rw==
X-Received: by 2002:aca:6c5:0:b0:325:5bce:bbc1 with SMTP id 188-20020aca06c5000000b003255bcebbc1mr22319697oig.221.1654285700984;
        Fri, 03 Jun 2022 12:48:20 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id y37-20020a4a9828000000b0040e68c9dce6sm4177469ooi.31.2022.06.03.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 12:48:20 -0700 (PDT)
Date:   Fri, 3 Jun 2022 12:46:06 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [GIT PULL] Bitmap patches for v5.19-rc1
Message-ID: <Yppk/mN+KYTDkvz3@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a shorter version of the original pull request for 5.19:
https://lkml.org/lkml/2022/5/27/1096
with all bitmap_weight_cmp() patches excluded.

Please, pull.

Thanks,
Yury

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git@github.com:/norov/linux.git tags/bitmap-for-5.19-rc1

for you to fetch changes up to 0dfe54071d7c828a02917b595456bfde1afdddc9:

  nodemask: Fix return values to be unsigned (2022-06-03 06:52:58 -0700)

----------------------------------------------------------------
Bitmap patches for 5.19-rc1

This series includes the following patchsets:
 - bitmap: optimize bitmap_weight() usage (w/o bitmap_weight_cmp), from me;
 - lib/bitmap.c make bitmap_print_bitmask_to_buf parseable, from Mauro
   Carvalho Chehab;
 - include/linux/find: Fix documentation, from Anna-Maria Behnsen;
 - bitmap: fix conversion from/to fix-sized arrays, from me;
 - bitmap: Fix return values to be unsigned, from Kees Cook.

It has been in linux-next for at least a week with no problems.

----------------------------------------------------------------
Anna-Maria Behnsen (1):
      include/linux/find: Fix documentation

Kees Cook (2):
      bitmap: Fix return values to be unsigned
      nodemask: Fix return values to be unsigned

Mauro Carvalho Chehab (1):
      lib/bitmap.c make bitmap_print_bitmask_to_buf parseable

Yury Norov (27):
      net: dsa: don't use bitmap_weight() in b53_arl_read()
      net: systemport: don't use bitmap_weight() in bcm_sysport_rule_set()
      net: mellanox: fix open-coded for_each_set_bit()
      iio: fix opencoded for_each_set_bit()
      qed: rework qed_rdma_bmap_free()
      KVM: x86: replace bitmap_weight with bitmap_empty where appropriate
      octeontx2-pf: replace bitmap_weight with bitmap_empty where appropriate
      qed: replace bitmap_weight with bitmap_empty in qed_roce_stop()
      risc-v: replace bitmap_weight with bitmap_empty in riscv_fill_hwcap()
      arch/alpha: replace cpumask_weight with cpumask_empty where appropriate
      arch/ia64: replace cpumask_weight with cpumask_empty where appropriate
      arch/x86: replace cpumask_weight with cpumask_empty where appropriate
      drm/i915/pmu: replace cpumask_weight with cpumask_empty where appropriate
      irq: mips: replace cpumask_weight with cpumask_empty where appropriate
      genirq/affinity: replace cpumask_weight with cpumask_empty where appropriate
      clocksource: replace cpumask_weight with cpumask_empty in clocksource.c
      mm/vmstat: replace cpumask_weight with cpumask_empty where appropriate
      arch/x86: replace nodes_weight with nodes_empty where appropriate
      MAINTAINERS: add cpumask and nodemask files to BITMAP_API
      lib/bitmap: extend comment for bitmap_(from,to)_arr32()
      lib: add bitmap_{from,to}_arr64
      lib/bitmap: add test for bitmap_{from,to}_arr64
      KVM: s390: replace bitmap_copy with bitmap_{from,to}_arr64 where appropriate
      drm/amd/pm: use bitmap_{from,to}_arr32 where appropriate
      ia64: cleanup remove_siblinginfo()
      KVM: x86: hyper-v: fix type of valid_bank_mask
      KVM: x86: hyper-v: replace bitmap_weight() with hweight64()

 MAINTAINERS                                        |   4 +
 arch/alpha/kernel/process.c                        |   2 +-
 arch/ia64/kernel/setup.c                           |   2 +-
 arch/ia64/kernel/smpboot.c                         |   4 -
 arch/riscv/kernel/cpufeature.c                     |   7 +-
 arch/s390/kvm/kvm-s390.c                           |  10 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |  14 +--
 arch/x86/kvm/hyperv.c                              |  14 +--
 arch/x86/mm/amdtopology.c                          |   2 +-
 arch/x86/mm/mmio-mod.c                             |   2 +-
 arch/x86/mm/numa_emulation.c                       |   4 +-
 arch/x86/platform/uv/uv_nmi.c                      |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   2 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |  48 ++++-----
 drivers/irqchip/irq-bcm6345-l1.c                   |   2 +-
 drivers/net/dsa/b53/b53_common.c                   |   6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |  23 ++--
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  45 +++-----
 drivers/net/ethernet/qlogic/qed/qed_roce.c         |   2 +-
 include/linux/bitmap.h                             |  56 ++++++----
 include/linux/find.h                               |   6 +-
 include/linux/nodemask.h                           |  38 +++----
 kernel/irq/affinity.c                              |   2 +-
 kernel/time/clocksource.c                          |   2 +-
 lib/bitmap.c                                       | 117 ++++++++++++++++-----
 lib/nodemask.c                                     |   4 +-
 lib/test_bitmap.c                                  |  25 +++++
 mm/vmstat.c                                        |   4 +-
 tools/include/linux/bitmap.h                       |  17 +--
 tools/lib/bitmap.c                                 |  20 ++--
 35 files changed, 279 insertions(+), 223 deletions(-)
