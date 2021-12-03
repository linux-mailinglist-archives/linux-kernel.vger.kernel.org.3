Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FB46771B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380727AbhLCMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:12:50 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49458 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352004AbhLCMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:12:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3C9ItB016776;
        Fri, 3 Dec 2021 06:09:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638533358;
        bh=06cwBrxsMnk03y/AEmhUPhS021s3XUHatnZteejmans=;
        h=From:To:CC:Subject:Date;
        b=Pv2/UZAB/ikGD0Ma3Ji/cDArnLi5zKc7+m9+oBVlVbM5uyA4p6Od7itLPuI9Rc2kI
         epL1yLzMiDfktb0+XpenatuUzwys/nV5ugtsjjmJsLSwgNU0x9Tm6IqioYcb/WYyf1
         KHwvxIr6DomKcrlsqaRyf53cYvfRU1UcpGrKORhE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3C9Iw8129286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 06:09:18 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 06:09:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 06:09:18 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3C9Fu2122882;
        Fri, 3 Dec 2021 06:09:16 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] soc: ti: k3-socinfo: Add entry for J721S2 SoC family
Date:   Fri, 3 Dec 2021 17:39:13 +0530
Message-ID: <20211203120913.14737-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721S2 SoC's JTAG PARTNO is 0xBB75.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v1:
- Added ',' in the last entry too
- Fixed the commit desciption

 drivers/soc/ti/k3-socinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index fd91129de6e5..b6b2150aca4e 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -40,7 +40,8 @@ static const struct k3_soc_id {
 	{ 0xBB5A, "AM65X" },
 	{ 0xBB64, "J721E" },
 	{ 0xBB6D, "J7200" },
-	{ 0xBB38, "AM64X" }
+	{ 0xBB38, "AM64X" },
+	{ 0xBB75, "J721S2"},
 };
 
 static int
-- 
2.17.1

