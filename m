Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04155953B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiHPH1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiHPH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:26:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA817DDB8;
        Mon, 15 Aug 2022 20:56:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d16so8087157pll.11;
        Mon, 15 Aug 2022 20:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=qLSttsMwGgFXnsk5NhFWTdXd+2tQbLUyp0NNDCVHH9A=;
        b=SZQdxn0LRoB3Sm/BK6myvoUmneF2rPxNoNYW/qkudaijogCTBK8foe9e9swRxqm8am
         E2R0Q2dQ8sCFI/JHVrsKPlFPz/9U07gEMiKAkhodCIFqd1Y92AONNmo8g1eTQZQN5jWS
         3/csoDncaFMVRbm4v10In1P48Eo5Kd2YL9uL3whrh18IpZtUfzi8qacl0HOHcAz/CPlP
         vIdjoRWY2Cvdiu1PFyPlzThZh9rjP1vgiQ0lg5QNvYGyf5u8Ac5BaooXNF4ZuPIzLgdW
         rJBDG3Eg4at3j9bz/ZSmHsNkng0dd2CDWXfEyYDbn/h15eckZHHq6vz/qnnpdUCV2ynb
         1gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=qLSttsMwGgFXnsk5NhFWTdXd+2tQbLUyp0NNDCVHH9A=;
        b=3Hx7BIkbboe2Vuo1BdnPHMeVta+Uj0plbPVDVN0JAeAQskpo1qlpWOJZOC9F4HB4My
         XBdlYxgohTsusAIYx8aFy3s+e7Oupj51pWVBuYJook72zZruD00iNp3FEFBeRYG9CeVr
         itcNVy4nrXP/tFANM3kgydELf7FCXgYXKgXKvaz4Dkib1lMNMryYWFIORhMyXqajtbbg
         rEVV3mTq/jjT/fHBEOmxAkWcUgLNv3duRrHHl7vS1ZV+MSELns9Ci6pdHxsjJJOPBa/H
         kpyOtCs8fEslZe1lrvhJ42Ga2zK9lyyxmf3mWtWgc0vcWSzad9yr7mJT+dmt7/eW58kc
         l86g==
X-Gm-Message-State: ACgBeo0sa8p9J5nTQ1Z0BvmqMYOpMSWqgq1a0Dvo9EFEC/gDE3Cl8Vqm
        8NaSeCJSn0OTpJmBqnYVano=
X-Google-Smtp-Source: AA6agR6ezCfARSKr9teZqM98UWGmox8EuKcG/UykuOWOmBN60SUNF93S9sRfcJtcEICdyPuEUHCqig==
X-Received: by 2002:a17:90b:4a0a:b0:1f4:e4fc:91d3 with SMTP id kk10-20020a17090b4a0a00b001f4e4fc91d3mr30956594pjb.67.1660622207573;
        Mon, 15 Aug 2022 20:56:47 -0700 (PDT)
Received: from localhost.localdomain ([116.75.96.232])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090ac58d00b001f2fa09786asm5356846pjt.19.2022.08.15.20.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 20:56:47 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH 3/3] rtc: rv3028: Alignment to match the open parenthesis
Date:   Tue, 16 Aug 2022 09:26:36 +0530
Message-Id: <20220816035636.27226-4-jagathjog1996@gmail.com>
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

Fix following checkpatch.pl check by adding space to match the
open parenthesis and removing unwanted blank line.
CHECK: Alignment should match open parenthesis.
CHECK: Blank lines aren't necessary before a close brace '}'.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/rtc/rtc-rv3028.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index f7c801c06d00..0da68fd7cedd 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -266,7 +266,7 @@ static irqreturn_t rv3028_handle_irq(int irq, void *dev_id)
 	u32 status = 0, ctrl = 0;
 
 	if (regmap_read(rv3028->regmap, RV3028_STATUS, &status) < 0 ||
-	   status == 0) {
+	    status == 0) {
 		return IRQ_NONE;
 	}
 
@@ -514,7 +514,6 @@ static int rv3028_set_offset(struct device *dev, long offset)
 	rv3028_exit_eerd(rv3028, eerd);
 
 	return ret;
-
 }
 
 static int rv3028_param_get(struct device *dev, struct rtc_param *param)
-- 
2.17.1

