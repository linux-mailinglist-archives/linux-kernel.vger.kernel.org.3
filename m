Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75C47EEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbhLXNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:07 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53177 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233233AbhLXNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:06 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105104954"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 439BE43A1810;
        Fri, 24 Dec 2021 22:13:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 00/10] ata: pata_platform: Refurbish the driver
Date:   Fri, 24 Dec 2021 13:12:49 +0000
Message-Id: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to merge pata_of_platform into pata_platform
driver.

Cheers,
Prabhakar

Changes for v3:
* Split up the patches furthermore.

Changes for v2:
* Dropped check for IRQ0
* Dropped setting the irqflags as suggested by Rob
* Fixed freeing up irq_res when not present in DT
* Dropped PATA_OF_PLATFORM entry
* Split up sorting of headers in separate patch
* Dropped sht from struct pata_platform_priv
* Used GENMASK() to calculate mask

Lad Prabhakar (10):
  ata: pata_platform: Make use of platform_get_mem_or_io()
  ata: pata_platform: Drop use of unlikely() in pata_platform_probe
  ata: pata_of_platform: Use platform_get_irq_optional() to get the
    interrupt
  ata: pata_platform: Use platform_get_irq_optional() to get the
    interrupt
  ata: pata_platform: Drop check for invalid IRQ number
  ata: pata_of_platform: Make use of platform_get_mem_or_io()
  ata: pata_platform: Merge pata_of_platform into pata_platform
  ata: pata_platform: Drop validating num_resources count
  ata: pata_platform: Sort the #includes alphabetically
  ata: pata_platform: Make use of GENMASK() macro

 drivers/ata/Kconfig            |  10 --
 drivers/ata/Makefile           |   1 -
 drivers/ata/pata_of_platform.c |  90 --------------
 drivers/ata/pata_platform.c    | 208 ++++++++++++++++++++++-----------
 include/linux/ata_platform.h   |   9 --
 5 files changed, 142 insertions(+), 176 deletions(-)
 delete mode 100644 drivers/ata/pata_of_platform.c

-- 
2.17.1

