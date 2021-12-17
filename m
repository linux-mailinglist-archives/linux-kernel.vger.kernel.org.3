Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4E478D35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhLQOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:17:27 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:26932 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233061AbhLQORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:17:25 -0500
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; 
   d="scan'208";a="104310486"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Dec 2021 23:17:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B56824007F26;
        Fri, 17 Dec 2021 23:17:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] ata: pata_platform: Refurbish the driver
Date:   Fri, 17 Dec 2021 14:17:13 +0000
Message-Id: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to merge pata_of_platform into pata_platform
driver.

Note:
* The patches have been build tested only.
* Other thing I'm concerned about is the Copyright message which
  existed in pata_of_platform.c should that be pasted in pata_platform.c?

Cheers,
Prabhakar

Lad Prabhakar (2):
  ata: pata_platform: make use of platform_get_mem_or_io()
  ata: pata_platform: Merge pata_of_platform into pata_platform

 drivers/ata/Kconfig            |   3 +-
 drivers/ata/Makefile           |   1 -
 drivers/ata/pata_of_platform.c |  90 --------------
 drivers/ata/pata_platform.c    | 209 ++++++++++++++++++++++++---------
 include/linux/ata_platform.h   |   9 --
 5 files changed, 155 insertions(+), 157 deletions(-)
 delete mode 100644 drivers/ata/pata_of_platform.c

-- 
2.17.1

