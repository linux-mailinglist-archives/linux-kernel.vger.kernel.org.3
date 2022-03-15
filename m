Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406564DA577
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352277AbiCOWiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244881AbiCOWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:38:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37F5C856;
        Tue, 15 Mar 2022 15:37:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso1650446wms.1;
        Tue, 15 Mar 2022 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAJ42Sw5cn2QVZO4B0ryJMqINKH0u5yKfMlL7xZRHdY=;
        b=S3HdweX4UDsfvRuFHYL/7/VcxXYn3QnEjH0RIb/qFpmRvIA/MX8LoZbBdSlDxvXKRC
         xmKw6G8Kvd1gvuPtq8NaiWnIleqMsArx/bXGvbfe0lpoG78YcMpw8H1QO9nDQ5J8o1ov
         +Emjsk5GnBxWPrc0t0MG+QFTUgjlfW5PlI6FbpKTaS9mHs6Up1YZLW0nPCRE2zxX/Tzv
         95Ds2I+kVj7Lb4RW2rDIlDdsGbOh2dA77uSH2TlOXRDXbeQWxfvsl796Ht82LMOM91Ab
         Rigol+MeonELE10CsRMlbTeZGghW7IHRPZXq7FybsmkADTceusjcNQJqWwGGjNvBP7dP
         RFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAJ42Sw5cn2QVZO4B0ryJMqINKH0u5yKfMlL7xZRHdY=;
        b=P5hjrhdCnZEAfCa38/WiGAGlCLpY2KcOfxFilnKFbU+akmqRN173P11phppkX1auin
         etuXbCU5RM6o9c+BNZwsGwC1745SXWPH7THjZIoSgTRfRA8Xa3oATGipUiBEMRS1bnWE
         SM/SwaUt7IMdOQB83EZufXQukNyqXz0rwpj3idV455v+1PUS/XrqrIstVbq+T04TmmMe
         RA3MsxbYvxZ5+WXlTcAu6/df6wD82lb6VF5YQfiZXPm2kEhPI9sXpXz4UCwBJI+HcBiG
         EL75Ir5Kkwyg+e9c+rjXPF+/GwUu2uvLABuRN9vr2oKuGpFHLh0Mpy7/DyFPU1KuOXal
         nWvw==
X-Gm-Message-State: AOAM530DaAYh32rZxRhKYOZhLgBwaai9v26x1lfqeN+Acuyg4Ppxpavj
        Whthcl1qUdlNbsTOcBpmuP9zNqoUlno5HA==
X-Google-Smtp-Source: ABdhPJy0fWCYuKdUbrMBGPM3SGYfsPMr5qWsNgcZByVXd5VHELf3+IGIrj/Ln2RMX17UACoUY+nvNA==
X-Received: by 2002:a1c:7c06:0:b0:389:7fd0:f6ec with SMTP id x6-20020a1c7c06000000b003897fd0f6ecmr4957514wmc.44.1647383821156;
        Tue, 15 Mar 2022 15:37:01 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b00389f368cf1esm93834wmq.40.2022.03.15.15.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:37:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" -> "vendor"
Date:   Tue, 15 Mar 2022 22:37:00 +0000
Message-Id: <20220315223700.2961660-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

There are several spelling mistakes in comments, function names
and literal strings. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 5724001e66b9..b35700071966 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -71,7 +71,7 @@
 #define BQ2415X_BIT_OTG_PL		1
 #define BQ2415X_BIT_OTG_EN		0
 
-/* vender register */
+/* vendor register */
 #define BQ2415X_MASK_VENDER		(BIT(5)|BIT(6)|BIT(7))
 #define BQ2415X_SHIFT_VENDER		5
 #define BQ2415X_MASK_PN			(BIT(3)|BIT(4))
@@ -491,8 +491,8 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
 	return -1;
 }
 
-/* return chip vender code */
-static int bq2415x_get_vender_code(struct bq2415x_device *bq)
+/* return chip vendor code */
+static int bq2415x_get_vendor_code(struct bq2415x_device *bq)
 {
 	int ret;
 
@@ -1501,9 +1501,9 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 		sprintf(revstr, "1.%d", ret);
 
 	bq->model = kasprintf(GFP_KERNEL,
-				"chip %s, revision %s, vender code %.3d",
+				"chip %s, revision %s, vendor code %.3d",
 				bq2415x_chip_name[chip], revstr,
-				bq2415x_get_vender_code(bq));
+				bq2415x_get_vendor_code(bq));
 	if (!bq->model) {
 		dev_err(bq->dev, "failed to allocate model name\n");
 		return -ENOMEM;
-- 
2.35.1

