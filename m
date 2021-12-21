Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874947C8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhLUV1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:27:08 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10647 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236482AbhLUV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:27:07 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104266469"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 06:27:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CC3E141082DC;
        Wed, 22 Dec 2021 06:27:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Han Xu <han.xu@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] mtd: nand: Use platform_get_irq*() variants to fetch IRQ's
Date:   Tue, 21 Dec 2021 21:26:07 +0000
Message-Id: <20211221212609.31290-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to drop using platform_get_resource*() for IRQ
types in preparation for removal of static setup of IRQ resource from
DT core code.

Dropping usage of platform_get_resource*() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Note: I have just build tested the patches.

Cheers,
Prabhakar

Lad Prabhakar (2):
  mtd: rawnand: omap_elm: Use platform_get_irq() to get the interrupt
  mtd: rawnand: gpmi: Use platform_get_irq_byname() to get the interrupt

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 11 ++++-------
 drivers/mtd/nand/raw/omap_elm.c            | 16 +++++++---------
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.17.1

