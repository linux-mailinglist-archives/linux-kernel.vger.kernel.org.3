Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B104CA59B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiCBNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiCBNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:09:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8D20F59;
        Wed,  2 Mar 2022 05:08:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk29so2720803wrb.4;
        Wed, 02 Mar 2022 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xXlb7cc4EyqnzFw8PQ0fBnQFiOHYPm8hTsgKE/9CO8Q=;
        b=np8mcRkHHqlMHinc7q2t/2Cpo2vbU8MWB+PuLJ05LpJg3PkpCND2SLdA8+h+nyquwP
         5Ac60majuASwgCKFMdvHiZ0JIxrhJiDl2NUnqOR54PRxR0ViilucxdQPBYtYYxv41KPW
         ed1su8/5e5wEAOZRJvbet8i6wZxQQh+13BcUZz1PviZNWQS47DdR6NIwvSZIrJTofUsR
         AM7naPwKwGkd1MFJbdKJYtujY9wz3+ZF5lcfZAxCaymr1+ICDNoPvD+TgJ331G1JzMVT
         b0KQyMiuvlaE6N/ndeQmh41u50QdE7chiwnvyFKXbO5NLfvPP2tnExYjQW76N6ZdX4wd
         vl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xXlb7cc4EyqnzFw8PQ0fBnQFiOHYPm8hTsgKE/9CO8Q=;
        b=YVhWmStW704j/+7pA2RukzDFO8dCQ+CWG2XNxegsxG1G4erMr3Kp2saLa9mcVhjPfm
         dbumB6s8xofE06WtwYvXuqg5TmahsDFP3C+sS/2vUM7aTe0QPhkjkxA5BW9w/DzMT81P
         qAyQO0QiWY3dmWHUUo3t1u+cDRHkUwtr3Ye4B6O0jQ9ydQU1q4oGsfrvI3pEX26eWQG/
         N8AheBvMMZyznECCwv2gfsPH/eiaZo7D8mXGRv8e7PSG8b6Vp56uTzRn/DDJyllwluaV
         AnwwX1sZueDpbb6lZ2v3EdONmFTXdyw2AkYJUOGoNC3cSxqCLZF4mAau7LE7Jxf+T93B
         C5Cg==
X-Gm-Message-State: AOAM530S1V9M0gMxzpgIFSfGDX4alcXoHksryjjLKyqNcIoeIytX/MEj
        0YJp9S1gympDm2daaaUvTS3vGtQwdcs=
X-Google-Smtp-Source: ABdhPJzuQN521B1SFDVZQJm/ctLkm2aM+RnrCXlzS8OE0PrnAn77bMy5SiW3lTIfXcbxYhVHtuLpXw==
X-Received: by 2002:adf:d1cc:0:b0:1f0:4570:bf75 with SMTP id b12-20020adfd1cc000000b001f04570bf75mr1502111wrd.656.1646226513863;
        Wed, 02 Mar 2022 05:08:33 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d4891000000b001e74e998bf9sm16698803wrq.33.2022.03.02.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:08:33 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: ab8500: fix a handful of spelling mistakes
Date:   Wed,  2 Mar 2022 13:08:32 +0000
Message-Id: <20220302130832.1076437-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few spelling mistakes in comments and in a dev_err
error message. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/ab8500_chargalg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index c9c7f7028af6..8842e51b8b1c 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -287,7 +287,7 @@ ab8500_chargalg_safety_timer_expired(struct hrtimer *timer)
  * the maintenance timer
  * @timer:     pointer to the timer structure
  *
- * This function gets called when the maintenence timer
+ * This function gets called when the maintenance timer
  * expires
  */
 static enum hrtimer_restart
@@ -431,7 +431,7 @@ static void ab8500_chargalg_stop_safety_timer(struct ab8500_chargalg *di)
 /**
  * ab8500_chargalg_start_maintenance_timer() - Start charging maintenance timer
  * @di:		pointer to the ab8500_chargalg structure
- * @duration:	duration of ther maintenance timer in minutes
+ * @duration:	duration of the maintenance timer in minutes
  *
  * The maintenance timer is used to maintain the charge in the battery once
  * the battery is considered full. These timers are chosen to match the
@@ -1271,7 +1271,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 				STATE_SAFETY_TIMER_EXPIRED_INIT);
 	}
 	/*
-	 * Check if any interrupts has occured
+	 * Check if any interrupts has occurred
 	 * that will prevent us from charging
 	 */
 
@@ -1525,7 +1525,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 				       bi->alert_high_temp_charge_voltage_uv,
 				       bi->alert_high_temp_charge_current_ua);
 		} else {
-			dev_err(di->dev, "neither low or high temp event occured\n");
+			dev_err(di->dev, "neither low or high temp event occurred\n");
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 			break;
 		}
-- 
2.34.1

