Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F927578614
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiGRPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGRPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:13:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35809275C0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:13:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26IFCmkp090786;
        Mon, 18 Jul 2022 10:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658157168;
        bh=VG8f/acBJAyK9kbXYs6a9nr3t+nEI09J3pQcpkEC7yc=;
        h=From:To:CC:Subject:Date;
        b=bOEATYHbZja4HUZV04J9+qfYvy39/wkmgeJeCAsMzjWWl0cx2RjYtuJTfSiEwWg8G
         vLKOolIjxjLFYak1h1pWucI1pGTL4qSM/l7+Asm/ZJDvTvLyzp1zq0fz/QNUh42pga
         DVyyAibzsC2tGxunNd9xF0RG9bjfj+//fEgG1jlg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26IFCmRI023058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jul 2022 10:12:48 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Jul 2022 10:12:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Jul 2022 10:12:47 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26IFChlw027105;
        Mon, 18 Jul 2022 10:12:44 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Use my kernel.org email
Date:   Mon, 18 Jul 2022 20:42:43 +0530
Message-ID: <20220718151243.1149442-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kernel.org email I have for reviewing patches.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..282b34eae750 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18827,7 +18827,7 @@ F:	drivers/pinctrl/spear/
 
 SPI NOR SUBSYSTEM
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
-M:	Pratyush Yadav <p.yadav@ti.com>
+M:	Pratyush Yadav <pratyush@kernel.org>
 R:	Michael Walle <michael@walle.cc>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
-- 
2.36.1

