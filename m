Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69364EB4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiC2U4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiC2U4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:56:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D754B41F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:54:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w21so15816730pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FDqhi0N/S/cUCLoAuboiyOBP3IQEQ1O6QqcgKgHDMTU=;
        b=x/3PVpLYjRnKwsaey2xougaew21RYo4GEuoyEXNrglvcGPfUh+vqthPJlK8+C2bTgd
         8IMQTz6lp1ZgXncGNdvSlXcRhEcstjb6VorrpPRbOp/t0HyM0LTjRzh5bRyXtvuo433s
         Or1qeAQH7BuLCtaKAaRBbLN0NO1o8aIwh9hcBCiqhksd6QZoCn7M+28UTb00TNrOsW4e
         X96Aj//eZ/TfBgpoel8d1ub+9aJsdZ/fBzuZP5e0dRYyqxdW0GdfkIuE/8uirSGD1dfk
         blTKmQGCEUVBvGIGXqfr4EQXMS/OOPijoAnAYxMAqoyD+VuClv5yU/a7zvGwdYqW7+OE
         Oe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FDqhi0N/S/cUCLoAuboiyOBP3IQEQ1O6QqcgKgHDMTU=;
        b=QUwJyjtlS+QbFbCml2woWo+i1mS+e0q507Ovfrs6EH4Iukiblz8bWQHPvqOUom04Nu
         kbBqhd29GAcbq75lweRXzxZslyxTIUOHkQ1CaHBqbVYuzsFdhEJN89V4OFulfdSvNQ0G
         OYtbRiwQNx3hg9rLlvGwvqB/LjSODp1rNvljw0LEcmBd4TT5QA04KOhK+7H6zAHCqHzJ
         LlcFGHvx6wfBsu+9fa9c1G/9jcP0P7meyZB/6nhM2alMatfuMJIXJI5J9EdOimJlGsLI
         K+bT0FA3/r23vCOGCi0rLLkWXkCXhj2L/Eyam7E6cDYwg1e/0ds0Z1rDtOUDjsr1rB57
         PyEw==
X-Gm-Message-State: AOAM530l7kaExWxfzH1cErcYStcqpFikhTuGrEvbMAddS7z1+NTBGNmZ
        a8VBvbxO0X1GuQqGUEpjwnVVxp9EOMBa/THXZhxPaocKxfIaWg==
X-Google-Smtp-Source: ABdhPJwmS9mDmjkje+k3GsHwWgWBckFPeTJrJcGyj7bgk4ha15BJ4lDerfFVoIwXMu5O3fOv2UnxO/USzXRhOvcTnJw=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr3350486pgb.74.1648587292181; Tue, 29
 Mar 2022 13:54:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 13:54:41 -0700
Message-ID: <CAPcyv4hydiSDFXVVBtYyuUgutTca6eL67s7txkSgzGzW1VGT0A@mail.gmail.com>
Subject: [GIT PULL] LIBNVDIMM update for v5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.18

...to receive the libnvdimm update for this cycle which includes the
deprecation of block-aperture mode and a new perf events interface for
the papr_scm nvdimm driver. The perf events approach was acked by
PeterZ. You will notice the top commit is less than a week old as
linux-next exposure identified some build failure scenarios. Kajol
turned around a fix and it has appeared in linux-next with no
additional reports. Some other fixups for the removal of
block-aperture mode also generated some follow-on fixes from -next
exposure.

I am not aware of anything else outstanding, please pull.

---

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.18

for you to fetch changes up to ada8d8d337ee970860c9844126e634df8076aa11:

  nvdimm/blk: Fix title level (2022-03-23 17:52:33 -0700)

----------------------------------------------------------------
libnvdimm for 5.18

- Add perf support for nvdimm events, initially only for 'papr_scm'
  devices.

- Deprecate the 'block aperture' support in libnvdimm, it only ever
  existed in the specification, not in shipping product.

----------------------------------------------------------------
Dan Williams (6):
      nvdimm/region: Fix default alignment for small regions
      nvdimm/blk: Delete the block-aperture window driver
      nvdimm/namespace: Delete blk namespace consideration in shared paths
      nvdimm/namespace: Delete nd_namespace_blk
      ACPI: NFIT: Remove block aperture support
      nvdimm/region: Delete nd_blk_region infrastructure

Kajol Jain (6):
      drivers/nvdimm: Add nvdimm pmu structure
      drivers/nvdimm: Add perf interface to expose nvdimm performance stats
      powerpc/papr_scm: Add perf interface support
      docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries
for nvdimm pmu
      drivers/nvdimm: Fix build failure when CONFIG_PERF_EVENTS is not set
      powerpc/papr_scm: Fix build failure when

Lukas Bulwahn (1):
      MAINTAINERS: remove section LIBNVDIMM BLK: MMIO-APERTURE DRIVER

Tom Rix (1):
      nvdimm/blk: Fix title level

 Documentation/ABI/testing/sysfs-bus-nvdimm |  35 ++
 Documentation/driver-api/nvdimm/nvdimm.rst | 406 +++++------------------
 MAINTAINERS                                |  11 -
 arch/powerpc/include/asm/device.h          |   5 +
 arch/powerpc/platforms/pseries/papr_scm.c  | 230 +++++++++++++
 drivers/acpi/nfit/core.c                   | 387 +---------------------
 drivers/acpi/nfit/nfit.h                   |   6 -
 drivers/nvdimm/Kconfig                     |  25 +-
 drivers/nvdimm/Makefile                    |   4 +-
 drivers/nvdimm/blk.c                       | 335 -------------------
 drivers/nvdimm/bus.c                       |   2 -
 drivers/nvdimm/dimm_devs.c                 | 204 +-----------
 drivers/nvdimm/label.c                     | 346 +-------------------
 drivers/nvdimm/label.h                     |   5 +-
 drivers/nvdimm/namespace_devs.c            | 506 ++---------------------------
 drivers/nvdimm/nd-core.h                   |  27 +-
 drivers/nvdimm/nd.h                        |  13 -
 drivers/nvdimm/nd_perf.c                   | 329 +++++++++++++++++++
 drivers/nvdimm/region.c                    |  31 +-
 drivers/nvdimm/region_devs.c               | 157 ++-------
 include/linux/libnvdimm.h                  |  24 --
 include/linux/nd.h                         |  78 +++--
 include/uapi/linux/ndctl.h                 |   2 -
 tools/testing/nvdimm/Kbuild                |   4 -
 tools/testing/nvdimm/config_check.c        |   1 -
 tools/testing/nvdimm/test/ndtest.c         |  67 +---
 tools/testing/nvdimm/test/nfit.c           |  23 --
 27 files changed, 833 insertions(+), 2430 deletions(-)
 delete mode 100644 drivers/nvdimm/blk.c
 create mode 100644 drivers/nvdimm/nd_perf.c
