Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE595A2552
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiHZKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbiHZKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:16 -0400
Received: from mxout.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F389C52B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 63C723D3B0E7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508072;
        bh=1GC7S1YI+aB5LYvu6vYYdn/mPMvHPNtxVJzgqwaAId0=;
        h=From:To:Cc:Subject:Date;
        b=aY04NnPOlV7fqAbKyLCrJjs4RswziZQ3udoZY006lMc4UGnDfmSuK6T47Bmpmp9Xu
         q+wRbXX357WVpmL20jRlgAXb1hlJHGyO4pmFxfaTALgx1u51DR9gUNATYxHLmMo3qh
         tESZxS5a3aektQ/2JvmEPwphRL9gytHeRXqIUlWU=
Received: from fx302 (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id D87253D3B088;
        Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <1510e.630899e7.57542.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx302.security-mail.net (Postfix) with ESMTPS id 57EFA3D3B0B8;
        Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 3C70B27E0397;
        Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 266A327E0396;
        Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 266A327E0396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508071;
        bh=51SLjhsn+vy0womsoGh4RwOudTiJbGNbt8966uS7txM=;
        h=From:To:Date:Message-Id;
        b=IGeaAppdp1g0yMNqxaSagJrlP/tL1gKAL7aqGdKAiRLPsXhZAQBYOCBwDn8WAeu0F
         LGHmX1I9oo/hta6P9NwrD8bQ6IRKyLV5/6GSOuF5JQgRh+LECI1hhURCw1G13x+t3k
         BE2tVsf3ZwcQPc0JUMo6Eg9pUHL/OUtMQLpAHcX4=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kxyUnf5eMmRV; Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 141B827E0392;
        Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: host: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:38 +0200
Message-Id: <20220826100052.22945-10-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/mmc/host/dw_mmc.c     | 2 +-
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 581614196a84..7f00d7d7e35e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		 * is just about to roll over.
 		 *
 		 * We do this whole thing under spinlock and only if the
-		 * command hasn't already completed (indicating the the irq
+		 * command hasn't already completed (indicating the irq
 		 * already ran so we don't want the timeout).
 		 */
 		spin_lock_irqsave(&host->irq_lock, irqflags);
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 4cca4c90769b..bddfaba091a9 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	 *       in reading a garbage value and using the wrong presets.
 	 *
 	 *       Since HS400 and HS200 presets must be identical, we could
-	 *       instead use the the SDR104 preset register.
+	 *       instead use the SDR104 preset register.
 	 *
 	 *    If the above issues are resolved we could remove this quirk for
 	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
-- 
2.17.1

