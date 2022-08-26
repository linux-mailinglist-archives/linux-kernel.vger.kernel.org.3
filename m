Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149B5A254C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245522AbiHZKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343690AbiHZKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:31 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A13A7205
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 98D87323820
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508086;
        bh=IXh1AnWpkuXoC7TbTvhFYHh6T+ctHCL9u2fV7eqXuqc=;
        h=From:To:Cc:Subject:Date;
        b=iJ/LI5Efx5USOVqllKKAEZx38RFVI9QhhZTXscdoE+WFHreNKqubDobk/J1zVK7nj
         JtdyKRLFs8er4FQO1Wz4/2hzGgtP591n8pC+KgHnPiAh09lrhn630HguMCmHmzZ6L7
         Y/SDt5iJqKRLbdwILS1yRQuWD/iyoCYgkMSsh10I=
Received: from fx405 (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 2A9DB3237E2;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <8c06.630899f3.17464.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx405.security-mail.net (Postfix) with ESMTPS id 1937C3236E3;
        Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id EC49527E0397;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D5B4227E0392;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D5B4227E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508082;
        bh=AEdCki1kaU7qrTk791Ry5BYT1smvHLvfdWrisP7ew1Y=;
        h=From:To:Date:Message-Id;
        b=ee/kuYMyGCET6s+ufDectbkcwFejqCsWLAdI1YHhk07T8JU++YLpzmr+p0Dn075u9
         Gm7JqC0mZX2R0EXcwlg7CScqKXNNewSjGTDf0lUAV/0RvRvfECOrBdNS5Y8LfViIDw
         7L1vqThUzkI/mVB1FJlspFwPSao1hSwycrvsPyP0=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kvPAhY-jR2an; Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id C588627E02FA;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:45 +0200
Message-Id: <20220826100052.22945-17-jmaselbas@kalray.eu>
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

CC: Sebastian Reichel <sre@kernel.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 drivers/power/supply/tps65217_charger.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4239591e1522..5369abaceb5c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -442,7 +442,7 @@ static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *env,
 	if (ret == -ENODEV || ret == -ENODATA) {
 		/*
 		 * When a battery is absent, we expect -ENODEV. Don't abort;
-		 * send the uevent with at least the the PRESENT=0 property
+		 * send the uevent with at least the PRESENT=0 property
 		 */
 		return 0;
 	}
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index ba33d1617e0b..a4bc9f2a10bc 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -50,7 +50,7 @@ static int tps65217_config_charger(struct tps65217_charger *charger)
 	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
 	 *
 	 * The device can be configured to support a 100k NTC (B = 3960) by
-	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
+	 * setting the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
 	 * is not recommended to do so. In sleep mode, the charger continues
 	 * charging the battery, but all register values are reset to default
 	 * values. Therefore, the charger would get the wrong temperature
-- 
2.17.1

