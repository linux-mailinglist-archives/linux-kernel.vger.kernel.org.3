Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253F959F482
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiHXHrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiHXHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:47:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C583BC1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:47:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f21so16272727pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=wTRpZL+bWIKCp88oDiuySEnQCeLGa3KRkogGZUhqEjE=;
        b=X0TATRazMjA8LbMXoUqEXzvo+goEfLUoRY6LQXo6u7wlJ5HkwKYy9xugZbBSq1Ox9X
         uXL8HTwaCqOSKITw4EtB7bfCilaihW/c5hGWyMUaCCYflWyqEvJYPmkcvavxPTkyG9YX
         KpC4DjTWlYPY2uuPj7NLy0sZKkwkfeAqoQkI3gVLf7CtuYVvYbr1jTMC4PPAS+jkiSLg
         BqG370TO9TYKJUY+wpU/Qv/sfENtfEhZv1nq0L23EnmYZazlI8M5OHGlBYUGQ1ROJ0+O
         9fELMgZ3vNKcgOyj4cSwLAQmZpLCbRyJlWjUQ0wlGYsQgxBeFANV+LYKcB9yyTEdFkA4
         sqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wTRpZL+bWIKCp88oDiuySEnQCeLGa3KRkogGZUhqEjE=;
        b=BF/wRllJG19EHzR7fLXOCUiY0Hqd5OVfuGXqsHuSHj51xI2MuD8V6YOLIjQqtmpn4f
         TaGzvDYTyxr3gScnHtzmltJA+R1zf1V7BcVYzChU9IHkKaKt9KA5pypAKwvj78xQAWoM
         VlntZAD4YRrea3wOe5oNqYmy+OMUYK4WbRrYLBKgvNZwWkll/sToXM/dDqDyYMMnHgV/
         8k9qIaAVrpeUaD4G8UnSz9qAPYSsbCDiOnVwDVG7PP3bl+0/oUmYZheHLp2KzCQOG/Tc
         J0H6/ZS5zCSHNvLMEWlfahvf2jZhZdkQtiyRO02Xmd2fflD/ZX2sWyL9SEbp1Kf5I9RJ
         NktA==
X-Gm-Message-State: ACgBeo1BO+PL07T1oxSZYt0OtY259lWZqA6O2gZ4bOF3qgeteBgMsIGN
        chjt3u1KyEtlNeODdv6SP1g=
X-Google-Smtp-Source: AA6agR6NfANjNCKSy8B9RavL/hU1qV7vtZU3sG+3iPRks2tQgJYJotB4gLY3wEIdVWmpbeWZgij/zg==
X-Received: by 2002:a17:902:da8c:b0:172:faaf:6d3a with SMTP id j12-20020a170902da8c00b00172faaf6d3amr8200348plx.166.1661327231996;
        Wed, 24 Aug 2022 00:47:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p4-20020aa79e84000000b00535fd0cb58bsm10562039pfq.111.2022.08.24.00.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:47:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] regulator: max597x: Remove the unneeded result variable
Date:   Wed, 24 Aug 2022 07:47:07 +0000
Message-Id: <20220824074707.221159-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from regmap_write() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/regulator/max597x-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index 03c6027682d8..39f803ff0a90 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -137,7 +137,7 @@ static int max597x_set_ovp(struct regulator_dev *rdev, int lim_uV, int severity,
 static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
 			   int severity, bool enable)
 {
-	int ret, val, reg;
+	int val, reg;
 	unsigned int vthst, vthfst;
 
 	struct max597x_regulator *data = rdev_get_drvdata(rdev);
@@ -183,9 +183,8 @@ static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
 		val = 0xFF;
 
 	reg = MAX5970_REG_DAC_FAST(rdev_id);
-	ret = regmap_write(rdev->regmap, reg, val);
 
-	return ret;
+	return regmap_write(rdev->regmap, reg, val);
 }
 
 static int max597x_get_status(struct regulator_dev *rdev)
-- 
2.25.1
