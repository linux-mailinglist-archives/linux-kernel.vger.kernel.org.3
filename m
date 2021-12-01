Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC185464E98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhLANRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbhLANQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:16:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B9C06174A;
        Wed,  1 Dec 2021 05:12:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so52244078wrn.6;
        Wed, 01 Dec 2021 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIEUlYwwjZhie4WfBlBG/NpfH8otfmo5HsnuybLMve8=;
        b=mQ+FnalR6SWQF6pzza1008JsmNoEsDmM6KSjX6hjpKVYN4zo7BQD4f1ZhFl3dysd9C
         RhSL+5oIKBeUAUm585UhYPMP/NSY1CLyk9p/Vbp4lm22tR6j0VQB7EltAssqee6w9SeG
         8bGCknAIghrY15aM1KECmyi4oIrYOshsFWEavkt1geVXpqrp3VsgDtzZmlUGVVeCQwk7
         4oPWbtYC3j5mhmhUUrEH0e/LSncnX+uOFs0bCsJ5FC91gnTLylYSXrXnl5AdE6ov0MSw
         BALHZI14w5H8gnApeAb9LGED401tsPKAyh7kxWEfmZ+ccouLdrZN/fuZqNFK0oNsOtKC
         B2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIEUlYwwjZhie4WfBlBG/NpfH8otfmo5HsnuybLMve8=;
        b=OPULV8FTFN6Bt3UQvsXTPFkAuyVY8OZmJC75lD7o4ngBz0h0XhYt2jIGDGJ+iUj2BQ
         wNpvvsuuWDTl8PMWuU3c9oEoRhd0atig2W2zfg0ydtGKF1WmQ1WRCyImyGknx7VA6D/M
         YJ7aRYrNKrA7HNdKzCc+CHfWEDVAkO6C6Z8eYXsWsm8KM/uPeEay/DHNR4W0clG6EmBW
         RNHBk7wZyKLMbXjMvy1tquvPossYQQlWMG1Elm9fu6kQt0UQrilAxp3rdxsml9RLB+NR
         +gCY1Tm7lRNFFh1M+m1L2viqzLC+6lN9cil7kP0qXIkR4C3C6M6/OEHpnFHqzM53D3RC
         /TLg==
X-Gm-Message-State: AOAM533lAughAtNmbhYoaFw3z8nfFu9sNmHOrUJmFYpeToLARc/jRSA/
        hnwSXM0+jvP8oBEjBc4r8unJ7VIJyGhJ1nfk
X-Google-Smtp-Source: ABdhPJzzhQEWcLY07TGwbBoaHSNvvx7vNfJqwOhbqX02sgXx9TS5NAfLLtksTpCUdGiS4CpLg+TUFg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr6879766wra.468.1638364373828;
        Wed, 01 Dec 2021 05:12:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t11sm19689819wrz.97.2021.12.01.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 05:12:53 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] thermal/drivers: Fix spelling mistake "caliberation" -> "calibration"
Date:   Wed,  1 Dec 2021 13:12:52 +0000
Message-Id: <20211201131252.135535-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spelling mistakes in a comment and a dev_dbg message. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/rzg2l_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index d47d4a30cd6c..8d55e401d185 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -99,7 +99,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 
 	/* The temperature Tj is calculated by the formula
 	 * Tj = (dsensor − calib1) * 165/ (calib0 − calib1) − 40
-	 * where calib0 and calib1 are the caliberation values.
+	 * where calib0 and calib1 are the calibration values.
 	 */
 	val = ((dsensor - priv->calib1) * (MCELSIUS(165) /
 		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
@@ -209,7 +209,7 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	dev_dbg(dev, "TSU probed with %s caliberation values",
+	dev_dbg(dev, "TSU probed with %s calibration values",
 		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
 
 	return 0;
-- 
2.33.1

