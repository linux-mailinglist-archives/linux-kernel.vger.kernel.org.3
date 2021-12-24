Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42947EF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352906AbhLXNNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:39 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:45139 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352825AbhLXNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:26 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105104973"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 720FA43A180F;
        Fri, 24 Dec 2021 22:13:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 09/10] ata: pata_platform: Sort the #includes alphabetically
Date:   Fri, 24 Dec 2021 13:12:58 +0000
Message-Id: <20211224131300.18198-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the #includes alphabetically.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* Dropped of_address.h
* Dropped RB tag

v1-->v2
* New patch
---
 drivers/ata/pata_platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 88a9bdc81e68..b37c1028fd54 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -11,14 +11,14 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <scsi/scsi_host.h>
 #include <linux/ata.h>
+#include <linux/ata_platform.h>
+#include <linux/blkdev.h>
+#include <linux/kernel.h>
 #include <linux/libata.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/ata_platform.h>
+#include <scsi/scsi_host.h>
 
 #define DRV_NAME "pata_platform"
 #define DRV_VERSION "1.2"
-- 
2.17.1

