Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB37949B213
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349056AbiAYKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358780AbiAYKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:33:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8CC061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so18940775wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KLk48uJDSh7dm6hMRysfiEnctm+6+wF78zxIH1Wen0=;
        b=o1Wq6iDHZRoJHBNvyNYJitPQBl0zy0dTTWhJMOzi3G/hkZEz9H4Ban72KriTfmzOKD
         iNdm1tC2X2uZzJVbSpZCOU+T6aNYuP3krRd5b4yWg/Qa/gKF8wwi2YirsEbBWaiDcJ3t
         QpsYkW7uzo2fAnWuVwrQcsmmvAlSx8cfKoy5McQk0yqzrfwD3Awsj3AiNdrSE1qakXdU
         r1nwjlNgED+9xKcijhORfvWGjlpgKDM/jOmmVyPUhsxN9ULhLjOOM8QZSGFBxuHJjIhx
         icyWxeF73hKIf2BPMJfcPWAu1FP+Ty/sJ8F060lA5EEPcUiISzBIX1LsPPqkNBsBl4RD
         XbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KLk48uJDSh7dm6hMRysfiEnctm+6+wF78zxIH1Wen0=;
        b=RMdYv6lNmpmkNB7NNRBXh4vk6yYrwQCUPMww6/3jBq+gc7Na55W/OsA1hNP1rPpJzT
         qmc81d57uyaZake7it4u4NEikeYRGasyHqGXByJnZJr/4CHWKTBWNXC8OCLN1gm+sWjv
         JHly/ShvWvzAnrwt9KoViMp0kEEPaqHUE64u5DMB8No1PVuHkSuMepmLd94W67y2BG6L
         HQqyEjca4Z/qcAo0K8qCrn8l1EUvL5FGb2r3/OuatJpshj/5dymA3h0YyvoOnq7I+Nbu
         5KDE5FeurMnFdAankATVfKU9E82BI6HILzoPEJY1Lmn5Bt8BO+4DRqWadKKHiOa2fx6V
         WKdg==
X-Gm-Message-State: AOAM532uFCwJr2MqhCz6oX30L3HE898s2jW5Ux9WlaIe92L6GaMy92mW
        AO1aWbg9aDBdIcCXQh0Xm0w=
X-Google-Smtp-Source: ABdhPJzeYnIwIwI2bx93AUMmHy9Ljr3qEjp+OgMxz/CXBizsLniJ0tPzBSFdSkmuwzhX3J1zRZKvVw==
X-Received: by 2002:a5d:6c64:: with SMTP id r4mr11041464wrz.389.1643106816397;
        Tue, 25 Jan 2022 02:33:36 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id t30sm17264875wra.95.2022.01.25.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:33:36 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 4/4] drivers: dio: Fixed spaces coding style issue
Date:   Tue, 25 Jan 2022 11:33:10 +0100
Message-Id: <20220125103310.13893-4-aleksav013@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125103310.13893-1-aleksav013@gmail.com>
References: <20220125103310.13893-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added or removed spaces in the code according to the checkpatch.pl script.

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 0f29d4903012..020a3d6219ae 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -64,7 +64,7 @@ struct dioname {
 
 /* useful macro */
 #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
-#define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
+#define DIOFBNAME(x) { DIO_ENCODE_ID(DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
 
 static struct dioname names[] = {
 	DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
@@ -236,7 +236,7 @@ static int __init dio_init(void)
 			dev->id = prid;
 
 		dev->ipl = DIO_IPL(va);
-		strcpy(dev->name,dio_getname(dev->id));
+		strcpy(dev->name, dio_getname(dev->id));
 		printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
 		if (DIO_NEEDSSECID(prid))
 			printk(":%02X", secid);
-- 
2.34.1

