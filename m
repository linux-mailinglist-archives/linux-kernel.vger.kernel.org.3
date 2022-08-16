Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BCC5953BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiHPH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiHPH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:26:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0117DDAB;
        Mon, 15 Aug 2022 20:56:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 17so8098686plj.10;
        Mon, 15 Aug 2022 20:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=s8oNghfnYa7l1esuj40oA6nn+OSitBYmevXG3PN0/dg=;
        b=lBhKEQe3AA1B/QR1wfZr12wvHyF5MYh8X2+H543inbuVi7k6AwDmHw6L8zrrYc07RZ
         xAAHTbtdmT4oORQ62xoEmUzQFoIc/FFHY7KkpyF73yMC7g/DvogG6SNsgXmkoIna2L0Y
         WRE50FO7zNhmIAjmETqCZzO5/6gUNKLqTfGqP1NflecapvhnO8lL+m/rusAz/64EI6xd
         rSzqjHXmdh/aSrRXLLr6C13to6TONqKNQ0w3S69Hiql+/pLP2R6cis1WGfuBmCBPEKSv
         HJBfJPUETLiblqatCbfuDXh0RdG/Ptk3JjhXgc7yULbYDNPQxNPoN4qFYyY/QGcX1IXM
         1J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=s8oNghfnYa7l1esuj40oA6nn+OSitBYmevXG3PN0/dg=;
        b=vWXoPHvfVVK3YpuTzynuor4BNebp3oB4hL3jWLBD6S4QghJPpF+/cdfbHjExLtGiLQ
         8YLZD+lTBhY1hYwKtkjnJxZq/7bG9dfSrBezk2LczkeBt9qFCo7er5JcGChYTlrh1+oJ
         I+rkmqaRTM3n264zHOpJ3LyReWqiertlyhDtNurvqkZ1fM3aDwukVvIs1NJaNUJWOFDO
         kuEmvB7bo1+dIknVqDTvk5W2a3Uxl+IP02Nzl9Y6X+mKuMNkYmRQfTsAZpGqVsnByxph
         lN7WWHonQtXPNc0uX3XI8/tAdRHYG9L4KYQtTqpKiZb8Wp69dVR63lxBJPKXcfxXxj2f
         11NQ==
X-Gm-Message-State: ACgBeo1W7HxIaKr5D8Y3OPhZRYhIYUr3HwbN/6Jzr2YffhJq+mn4Tqw+
        xfgqvy8v9catpSPn+IRQvW8=
X-Google-Smtp-Source: AA6agR7m2fU0y6ibWSbyBnWs2O3z6a6K32WlqkuGVV7W36F0NCVChJbhT6orJpk28JQ8IWD8mBhO2w==
X-Received: by 2002:a17:90b:4acd:b0:1f4:cf0c:7a68 with SMTP id mh13-20020a17090b4acd00b001f4cf0c7a68mr21159619pjb.178.1660622205332;
        Mon, 15 Aug 2022 20:56:45 -0700 (PDT)
Received: from localhost.localdomain ([116.75.96.232])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090ac58d00b001f2fa09786asm5356846pjt.19.2022.08.15.20.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 20:56:44 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH 2/3] rtc: rv3028: fix code indent issue
Date:   Tue, 16 Aug 2022 09:26:35 +0530
Message-Id: <20220816035636.27226-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816035636.27226-1-jagathjog1996@gmail.com>
References: <20220816035636.27226-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following the checkpatch.pl error by using tabs instead of spaces.
ERROR: code indent should use tabs where possible.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/rtc/rtc-rv3028.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 5cebb00bec21..f7c801c06d00 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -851,9 +851,9 @@ static const struct rtc_class_ops rv3028_rtc_ops = {
 };
 
 static const struct regmap_config regmap_config = {
-        .reg_bits = 8,
-        .val_bits = 8,
-        .max_register = 0x37,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x37,
 };
 
 static int rv3028_probe(struct i2c_client *client)
-- 
2.17.1

