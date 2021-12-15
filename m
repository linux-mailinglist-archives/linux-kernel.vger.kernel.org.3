Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072054764F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhLOVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhLOVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639605147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d8Xx3zTekrihbvJfhZhhSli7JDX8raqst1ZSqjxf0vI=;
        b=VyAnZa5Ea2e6Tvem5EeUyB/Ln5eecw4ryau+VGyce+TL+Rf8ocMmrDs4/GEJRGRKoM88gg
        FML1z97KpCOSLyTSYLsd06CTDjAFDvK3qJZh0Ja/lgphy9b+5oJiPkl8RkzrL61X61hgTK
        0rY5w3VYozSlJh4aDpzzG3WmH+V86UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-PMyltjrkMS6PmpVo4bzuhQ-1; Wed, 15 Dec 2021 16:52:23 -0500
X-MC-Unique: PMyltjrkMS6PmpVo4bzuhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D18E7190B2A3;
        Wed, 15 Dec 2021 21:52:20 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D67DF78DE6;
        Wed, 15 Dec 2021 21:52:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [GIT PULL] Immutable branch with INT3472 ACPI/i2c + pdx86 patches
Date:   Wed, 15 Dec 2021 22:52:12 +0100
Message-Id: <20211215215212.321235-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello clk, regulator and media maintainers,

As discussed here is a pull-req from an immutable branch based on 5.16-rc1
with the ACPI/i2c, tps68470 and pdx86/INT3472 changes necessary as a base
to merge the remaining clk / regulator / media changes from my
[PATCH v7 00/14] Add support for X86/ACPI camera sensor/PMIC setup with clk and regulator platform data
series. The remaining changes are:

[PATCH v7 05/14] regulator: Introduce tps68470-regulator driver
[PATCH v7 06/14] clk: Introduce clk-tps68470 driver
[PATCH v7 12/14] media: ipu3-cio2: Defer probing until the PMIC is fully setup
[PATCH v7 13/14] media: ipu3-cio2: Call cio2_bridge_init() before anything else
[PATCH v7 14/14] media: ipu3-cio2: Add support for instantiating i2c-clients for VCMs

Please pull this immutable branch into your tree and then merge the
remaining patches relevant for your tree on top.

Regards,

Hans


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-int3472-1

for you to fetch changes up to 97c2259ec7757ec24a90f0ef8fc5ea7fa1c6acca:

  platform/x86: int3472: Deal with probe ordering issues (2021-12-13 11:44:51 +0100)

----------------------------------------------------------------
Signed tag for the immutable platform-drivers-x86-int3472 branch

This branch contains 5.16-rc1 + the pending ACPI/i2c, tps68570 platform_data
and INT3472 driver patches.

----------------------------------------------------------------
Hans de Goede (9):
      ACPI: delay enumeration of devices with a _DEP pointing to an INT3472 device
      i2c: acpi: Use acpi_dev_ready_for_enumeration() helper
      i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
      platform_data: Add linux/platform_data/tps68470.h file
      platform/x86: int3472: Split into 2 drivers
      platform/x86: int3472: Add get_sensor_adev_and_name() helper
      platform/x86: int3472: Pass tps68470_clk_platform_data to the tps68470-regulator MFD-cell
      platform/x86: int3472: Pass tps68470_regulator_platform_data to the tps68470-regulator MFD-cell
      platform/x86: int3472: Deal with probe ordering issues

 drivers/acpi/scan.c                                |  37 +++++-
 drivers/i2c/i2c-core-acpi.c                        |  22 +++-
 drivers/platform/x86/intel/int3472/Makefile        |   9 +-
 ...472_clk_and_regulator.c => clk_and_regulator.c} |   2 +-
 drivers/platform/x86/intel/int3472/common.c        |  82 ++++++++++++
 .../{intel_skl_int3472_common.h => common.h}       |   6 +-
 .../{intel_skl_int3472_discrete.c => discrete.c}   |  51 +++++---
 .../x86/intel/int3472/intel_skl_int3472_common.c   | 106 ---------------
 .../{intel_skl_int3472_tps68470.c => tps68470.c}   |  92 +++++++++++--
 drivers/platform/x86/intel/int3472/tps68470.h      |  25 ++++
 .../x86/intel/int3472/tps68470_board_data.c        | 145 +++++++++++++++++++++
 include/acpi/acpi_bus.h                            |   5 +-
 include/linux/i2c.h                                |  17 ++-
 include/linux/platform_data/tps68470.h             |  35 +++++
 14 files changed, 473 insertions(+), 161 deletions(-)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regulator.c => clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h => common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c => discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c => tps68470.c} (56%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 create mode 100644 include/linux/platform_data/tps68470.h

