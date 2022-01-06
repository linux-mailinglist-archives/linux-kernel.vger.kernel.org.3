Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43F2486184
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiAFIip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiAFIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:38:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D61C061201;
        Thu,  6 Jan 2022 00:38:44 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id x194so2006494pgx.4;
        Thu, 06 Jan 2022 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt0rtZoVf/LFU96gxwDi5D6C9OB9ceL1t7u8+Oncfhg=;
        b=O/0Wl3v+9hbC+RnCJ546mxl6K1tSclLOXBGw9w5EpYj0Q094ok9SA3wlVwOA9huBnw
         Fl6J5pdXnPDxpcFhIH91bf45J55AHm2Vo3SVtb7QKACmX4gqwvxB8YNMa14YMyyYPK/n
         xUKPDjXqzrbePkPdLpP9RkCIJs0ev0/BljVQah3gw/GLyVGZA4cbw+LptPGmhTQMROUZ
         VaF9qq1qSgBYrZGFjnHjQdhElNwT0q5vkYQPWtGwHV/g5KKWSOHpcvFD6xgYOENo1nY/
         vOKjGmqhFJIEU6u6Ve8bmdCusYdoT6vwsIZj3C2skafK/SsgVtE2NhIy/kP3p7+pq+Ud
         3+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt0rtZoVf/LFU96gxwDi5D6C9OB9ceL1t7u8+Oncfhg=;
        b=DnIjpe0n7oO41NtmgpbBmGOCE35mN+nR202DQS8GLhqJrcTG6FD11QBUaaObPZ97T2
         7Op1sb5WemWi/es1FiQrIZ5mM9M2qTE3XAWtJoiVPidaH1KKztI9/B4eLpzXO2rXIai7
         +MRGh58U1XwxVays6MWjNTGWaa+5oLK2Wq3VXhrFowhmML3yfmDw1xkVadOl4Q1vTH67
         DI6UcBb4eYPFjaF+UwjMxuUg6CSkWkuzJ3myqS3YV2cG248c51LLx+SCi4ww+6gAv1UL
         xngFSGB2jvcHCKpPH3xv+bzGn8uEVOq+kDwiTjinoSRnz4Ziro9GPek0J8vUejpJG6rI
         9B5g==
X-Gm-Message-State: AOAM533J8uteH1IXb7G8X9tiyKFhLIUjPYE4tMPSoIDK0Tlfw5h1LVnO
        YEs8YCrA/mmKbIX0X00VYo0V8N2MtAorRQ==
X-Google-Smtp-Source: ABdhPJxDaZ9mvHwlhAGvE5275tgoDp8/T+GoPAe9hOw2K/beUFq7GK3XZI0Wx+7penfRBeWXl0cOjQ==
X-Received: by 2002:aa7:8c05:0:b0:4bc:a73a:dc9f with SMTP id c5-20020aa78c05000000b004bca73adc9fmr17340160pfd.75.1641458324145;
        Thu, 06 Jan 2022 00:38:44 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.googlemail.com with ESMTPSA id v12sm1329538pgc.13.2022.01.06.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:38:43 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Qinghua Jin <qhjin.dev@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ti_am335x_tsc: Fix type
Date:   Thu,  6 Jan 2022 16:38:02 +0800
Message-Id: <20220106083803.355106-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'postion' to 'position'

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 83e685557a19..d77555e0571e 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -310,7 +310,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			/*
 			 * Calculate pressure using formula
 			 * Resistance(touch) = x plate resistance *
-			 * x postion/4096 * ((z2 / z1) - 1)
+			 * x position/4096 * ((z2 / z1) - 1)
 			 */
 			z = z1 - z2;
 			z *= x;
-- 
2.30.2

