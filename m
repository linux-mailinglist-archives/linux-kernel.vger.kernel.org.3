Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0883A5364DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbiE0Pof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiE0Poa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:44:30 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051EF37016
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:44:28 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2ccb58ee0so6212499fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RnV08G1Kvz3kLVVNN6T56qGAmIkjlLE76+/jxuoQtag=;
        b=OP7lyU05rL3SpAU0PcMjbGtnf6N2o0dwKhJNOSkmN5LzNQ+S7CEu8r9tDgroeaIpPw
         +1BBj47MsDG1BinGnoMhwGpdu9AIp7Kgq3QZ/Flagr3Z+hRPkkH0ph0BTNLajCJ0gLuk
         JOkVr8Ct4hfQecyFhGNx5cuY71ZDpojZcQrTjdNDmxGoxj9lYpUs8TVA6oDCx0N4AxzT
         u7zqfqFBVmYta6C/k2oi6UssDKsCKidhP7WkeWTyYoeFPRQ+EqKHBMLQgDh7AVh2e3JK
         5oe2S7sAggP2ig0Hw2E153LcjK5+6R6DZULjxslFxZ1yJdd29DcW4SfY/wo88RiYRzK/
         bqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RnV08G1Kvz3kLVVNN6T56qGAmIkjlLE76+/jxuoQtag=;
        b=K8RfEQHpVUDzd+nebeueRWtuzD68BS9c2HOaU4invp8yRWYylIlpw3PBCCkOCEghlr
         my8D/U62jg/EO5yjevMutzXgGH5Gx5FWkuIEN69MH6fv7hs95smHCjBV1WbIQ7Bg2K1S
         Y3kg5MvFm0dB/oKUSjsavAh18gzkZ0offZSOWnSEc+5hNY+cJVki4hZ5/qZkCEkXsz29
         WtcXWnshAXnwi6uYor2TTwmU+6iaAjjycsD096rTNkuquouEmScqdUljRCMRqQbflQkx
         2GNgG7cfaROstKl9ViAKZWps5C5yHZzLLgCrtUJzbcylOIHOCN3EG9yf2PoxlOJ6HKoa
         jCRQ==
X-Gm-Message-State: AOAM532pcd1/6zDIhzU6c4O3pmMEqC6tmrbXUxRCJ3BYeeD3g1w/tm6r
        C1+Pw+yX874F/IOkgJF67Bo=
X-Google-Smtp-Source: ABdhPJyzDTq1FSx3jO6Zw5xtfhaAC+SIyYVdEK9pofQNvLmSKzXE3nYkKU7zKb5IqxDyyKAgTxfH4Q==
X-Received: by 2002:a05:6870:5818:b0:ee:e90:46cc with SMTP id r24-20020a056870581800b000ee0e9046ccmr4434690oap.37.1653666268221;
        Fri, 27 May 2022 08:44:28 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r24-20020a9d7518000000b0060b069325f2sm1823034otk.63.2022.05.27.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 08:44:27 -0700 (PDT)
Date:   Fri, 27 May 2022 08:43:04 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [GIT PULL] Bitmap patches for v5.19-rc1
Message-ID: <YpDxiBywRMcdZNUO@yury-laptop>
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

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://github.com/norov/linux.git/ tags/bitmap-for-5.19-rc1

for you to fetch changes up to db7b4edf37fe9872bec4d1537d67c4c9f95810b6:

  nodemask: Fix return values to be unsigned (2022-05-23 13:17:07 -0700)

----------------------------------------------------------------
Bitmap patches for 5.19-rc1

This series includes the following patch-sets:
 - bitmap: optimize bitmap_weight() usage, from me;
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

Yury Norov (51):
      net: dsa: don't use bitmap_weight() in b53_arl_read()
      net: systemport: don't use bitmap_weight() in bcm_sysport_rule_set()
      net: mellanox: fix open-coded for_each_set_bit()
      iio: fix opencoded for_each_set_bit()
      qed: rework qed_rdma_bmap_free()
      KVM: x86: replace bitmap_weight with bitmap_empty where appropriate
      octeontx2-pf: replace bitmap_weight with bitmap_empty where appropriate
      qed: replace bitmap_weight with bitmap_empty in qed_roce_stop()
      arch/alpha: replace cpumask_weight with cpumask_empty where appropriate
      arch/ia64: replace cpumask_weight with cpumask_empty where appropriate
      arch/x86: replace cpumask_weight with cpumask_empty where appropriate
      drm/i915/pmu: replace cpumask_weight with cpumask_empty where appropriate
      irq: mips: replace cpumask_weight with cpumask_empty where appropriate
      genirq/affinity: replace cpumask_weight with cpumask_empty where appropriate
      clocksource: replace cpumask_weight with cpumask_empty in clocksource.c
      mm/vmstat: replace cpumask_weight with cpumask_empty where appropriate
      arch/x86: replace nodes_weight with nodes_empty where appropriate
      bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions
      arch/x86: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le} where appropriate
      iio: replace bitmap_weight() with bitmap_weight_{eq,gt} where appropriate
      memstick: replace bitmap_weight with bitmap_weight_eq where appropriate
      ixgbe: replace bitmap_weight with bitmap_weight_eq
      octeontx2-pf: replace bitmap_weight with bitmap_weight_{eq,gt}
      mlx4: replace bitmap_weight with bitmap_weight_{eq,gt,ge,lt,le}
      perf: replace bitmap_weight with bitmap_weight_eq for ThunderX2
      media: tegra-video: replace bitmap_weight with bitmap_weight_le
      cpumask: add cpumask_weight_{eq,gt,ge,lt,le}
      arch/ia64: replace cpumask_weight with cpumask_weight_eq in mm/tlb.c
      arch/mips: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
      arch/powerpc: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
      arch/s390: replace cpumask_weight with cpumask_weight_eq where appropriate
      firmware: psci: replace cpumask_weight with cpumask_weight_eq
      RDMA/hfi1: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
      scsi: lpfc: replace cpumask_weight with cpumask_weight_gt
      soc/qman: replace cpumask_weight with cpumask_weight_lt
      nodemask: add nodemask_weight_{eq,gt,ge,lt,le}
      ACPI: replace nodes__weight with nodes_weight_ge for numa
      mm/mempolicy: replace nodes_weight with nodes_weight_eq
      nodemask: add num_node_state_eq()
      tools: bitmap: sync bitmap_weight
      MAINTAINERS: add cpumask and nodemask files to BITMAP_API
      lib/bitmap: extend comment for bitmap_(from,to)_arr32()
      lib: add bitmap_{from,to}_arr64
      lib/bitmap: add test for bitmap_{from,to}_arr64
      KVM: s390: replace bitmap_copy with bitmap_{from,to}_arr64 where appropriate
      drm/amd/pm: use bitmap_{from,to}_arr32 where appropriate
      ia64: cleanup remove_siblinginfo()
      cpufreq: use cpumask_weight_gt() in policy_is_shared()
      KVM: x86: hyper-v: fix type of valid_bank_mask
      KVM: x86: hyper-v: replace bitmap_weight() with hweight64()
      risc-v: replace bitmap_weight with bitmap_empty in riscv_fill_hwcap()

 MAINTAINERS                                        |   4 +
 arch/alpha/kernel/process.c                        |   2 +-
 arch/ia64/kernel/setup.c                           |   2 +-
 arch/ia64/kernel/smpboot.c                         |   4 -
 arch/ia64/mm/tlb.c                                 |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   4 +-
 arch/mips/kernel/crash.c                           |   2 +-
 arch/powerpc/kernel/smp.c                          |   2 +-
 arch/powerpc/kernel/watchdog.c                     |   2 +-
 arch/powerpc/xmon/xmon.c                           |   4 +-
 arch/riscv/kernel/cpufeature.c                     |   7 +-
 arch/s390/kernel/perf_cpum_cf.c                    |   2 +-
 arch/s390/kvm/kvm-s390.c                           |  10 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |  16 +--
 arch/x86/kvm/hyperv.c                              |  14 +--
 arch/x86/mm/amdtopology.c                          |   2 +-
 arch/x86/mm/mmio-mod.c                             |   2 +-
 arch/x86/mm/numa_emulation.c                       |   4 +-
 arch/x86/platform/uv/uv_nmi.c                      |   2 +-
 drivers/acpi/numa/srat.c                           |   2 +-
 drivers/firmware/psci/psci_checker.c               |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   2 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |  48 +++----
 drivers/iio/industrialio-trigger.c                 |   2 +-
 drivers/infiniband/hw/hfi1/affinity.c              |   9 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |   2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |   2 +-
 drivers/memstick/core/ms_block.c                   |   4 +-
 drivers/net/dsa/b53/b53_common.c                   |   6 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   8 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |  33 ++---
 drivers/net/ethernet/mellanox/mlx4/eq.c            |   4 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |   4 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  45 +++----
 drivers/net/ethernet/qlogic/qed/qed_roce.c         |   2 +-
 drivers/perf/thunderx2_pmu.c                       |   4 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   2 +-
 drivers/soc/fsl/qbman/qman_test_stash.c            |   2 +-
 drivers/staging/media/tegra-video/vi.c             |   2 +-
 include/linux/bitmap.h                             | 139 ++++++++++++++++++---
 include/linux/cpufreq.h                            |   2 +-
 include/linux/cpumask.h                            |  50 ++++++++
 include/linux/find.h                               |   6 +-
 include/linux/nodemask.h                           |  78 +++++++++---
 kernel/irq/affinity.c                              |   2 +-
 kernel/time/clocksource.c                          |   2 +-
 lib/bitmap.c                                       | 138 +++++++++++++++-----
 lib/nodemask.c                                     |   4 +-
 lib/test_bitmap.c                                  |  25 ++++
 mm/mempolicy.c                                     |   2 +-
 mm/page_alloc.c                                    |   2 +-
 mm/vmstat.c                                        |   4 +-
 tools/include/linux/bitmap.h                       |  60 +++++++--
 tools/lib/bitmap.c                                 |  40 ++++--
 tools/perf/util/pmu.c                              |   2 +-
 63 files changed, 578 insertions(+), 270 deletions(-)
