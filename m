Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C15C57DEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiGVJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiGVJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:40:32 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2243FFE;
        Fri, 22 Jul 2022 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qIKYj
        gj5lpl2LIg188S6dzOSHartE4lDmNN4vgXZ9yI=; b=enKLWYD5dSvqxjQVLd3Dn
        P8aQOqraphoDLNa7RhHCtiSuFocrHX2qADzq6j8AcqPMK8tf9gJFAjDSzZjwjNYq
        5zfJU0Nnin3ZQSUROK6UqrDPUrfOAPXCrRUA2+jMEwyqmsTzL8PpJwAVMgzwE6PZ
        gL348uGrTx2hTdtRxexBBU=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgD3hH75bdpisZ+RQg--.7373S2;
        Fri, 22 Jul 2022 17:29:30 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] power: supply: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:29:27 +0800
Message-Id: <20220722092927.77315-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgD3hH75bdpisZ+RQg--.7373S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyfKFWrur1kGw1DCF4kWFg_yoW8Ww4Upa
        n5CrsYk398KFW7J3Wjy3WUWa45Ga1rA3s0krWxJ3y5u3W3A3y09r1UGFZxK343XrZ3AF4S
        qry3tr1IvF13Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pijjgrUUUUU=
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRpGZFyPdmzQ2AAAsg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

