Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C009E4A6417
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiBASiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbiBASiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:38:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA0C061714;
        Tue,  1 Feb 2022 10:37:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso2238497wms.4;
        Tue, 01 Feb 2022 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ve8tBclI5IMrrMI15B03jvD+eu/iK6m1qrk9Pz//fBI=;
        b=lFfSrnIIiNiQ9HzJ7/WifUaPADKRkkv+F3hqEDj0Jn9XW84XpBgFQbIMqpTr7/urD+
         YO6bYyWaiAOVo0Mun2QQ3wXa/eJFfmhy+GjW0FNeD5y8ZrTQC4PWkJhxHRmoLWIn8gfI
         sxewSoTkQHlDS36c6E8dYKP8E+0noOceVjOoUu5CxKvs6bO9GYmjWijoO9FvJKzrb7At
         CdrlfBmKwnxraAm2WQX5r+N+4hNai/jUk4G+NHJ1jXejeeuJxZNjdg8/OnCqZYa1/u2E
         85I/KW9EX0/SfGgISkhYMMANYaoxEgsLhmMLMC1B0B7OppI62gL83WZOreOXz3ulLF1K
         IuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ve8tBclI5IMrrMI15B03jvD+eu/iK6m1qrk9Pz//fBI=;
        b=daRtCnFYkgNMw4fM/7nQLoTcZb+mJYzd02P+uNNtVDmBzlUgGkGS9pCIhYmEQm42JY
         1CwZmRL8SsmleLF0fXZJt2fiCYo3oQOjgDkXJFaMwATzS7VJCiHQRgZHYD5VX5Ew8VL8
         PWXJothBBCJ/RwV5zphrmZZe68Og97cywd0qHZnXBiDhLjwrSvMjP9An3Fn//ThKxqgl
         gl6nolmDnaURPF8iYs3fNpr3hchM1q0ZwanZfDKRQmyk9mOtF6zPswcOSfA3X5BMu/jz
         BEhaUHMRq4EGX6YmirjOS9pyLrEicuSrkV9Lk/RTVmbUfNXEpYPQrcIDSZ7WOgjxSrTe
         cT+w==
X-Gm-Message-State: AOAM5336lsovmmw2MjlxK26wASeUrphZ7mQXZkG9FmuopswvVzMD/+Sh
        s/y34+yPLAuMtOoHtBA56zPahvy+efrpdw==
X-Google-Smtp-Source: ABdhPJwI6E3HElHpzSsZnZmMM8bQrF62l2ToUjMY8b8KAp0cybrgUDH9guSk/WKKQnqpcg75zMvrzQ==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr2978052wmq.122.1643740678276;
        Tue, 01 Feb 2022 10:37:58 -0800 (PST)
Received: from X1C7EK5.wind3.hub ([151.40.130.120])
        by smtp.gmail.com with ESMTPSA id j19sm3097477wmq.17.2022.02.01.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:37:57 -0800 (PST)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linuxfancy@googlegroups.com
Subject: [PATCH 2/2] media: cec: seco: add newlines in debug messages
Date:   Tue,  1 Feb 2022 19:37:34 +0100
Message-Id: <20220201183734.224756-3-ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201183734.224756-1-ek5.chimenti@gmail.com>
References: <20220201183734.224756-1-ek5.chimenti@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ettore Chimenti <ek5.chimenti@gmail.com>

Newlines were missing in almost all regular and debug printk.

Signed-off-by: Ettore Chimenti <ek5.chimenti@gmail.com>
---
 drivers/media/cec/platform/seco/seco-cec.c | 54 +++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/media/cec/platform/seco/seco-cec.c b/drivers/media/cec/platform/seco/seco-cec.c
index ae138cc253fd..78856a55e637 100644
--- a/drivers/media/cec/platform/seco/seco-cec.c
+++ b/drivers/media/cec/platform/seco/seco-cec.c
@@ -129,7 +129,7 @@ static int secocec_adap_enable(struct cec_adapter *adap, bool enable)
 		if (status)
 			goto err;
 
-		dev_dbg(dev, "Device enabled");
+		dev_dbg(dev, "Device enabled\n");
 	} else {
 		/* Clear the status register */
 		status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
@@ -141,7 +141,7 @@ static int secocec_adap_enable(struct cec_adapter *adap, bool enable)
 				  ~SECOCEC_ENABLE_REG_1_CEC &
 				  ~SECOCEC_ENABLE_REG_1_IR);
 
-		dev_dbg(dev, "Device disabled");
+		dev_dbg(dev, "Device disabled\n");
 	}
 
 	return 0;
@@ -264,12 +264,12 @@ static void secocec_rx_done(struct cec_adapter *adap, u16 status_val)
 
 	if (status_val & SECOCEC_STATUS_RX_OVERFLOW_MASK) {
 		/* NOTE: Untested, it also might not be necessary */
-		dev_warn(dev, "Received more than 16 bytes. Discarding");
+		dev_warn(dev, "Received more than 16 bytes. Discarding\n");
 		flag_overflow = true;
 	}
 
 	if (status_val & SECOCEC_STATUS_RX_ERROR_MASK) {
-		dev_warn(dev, "Message received with errors. Discarding");
+		dev_warn(dev, "Message received with errors. Discarding\n");
 		status = -EIO;
 		goto rxerr;
 	}
@@ -390,12 +390,12 @@ static int secocec_ir_probe(void *priv)
 	if (status != 0)
 		goto err;
 
-	dev_dbg(dev, "IR enabled");
+	dev_dbg(dev, "IR enabled\n");
 
 	status = devm_rc_register_device(dev, cec->ir);
 
 	if (status) {
-		dev_err(dev, "Failed to prepare input device");
+		dev_err(dev, "Failed to prepare input device\n");
 		cec->ir = NULL;
 		goto err;
 	}
@@ -408,7 +408,7 @@ static int secocec_ir_probe(void *priv)
 	smb_wr16(SECOCEC_ENABLE_REG_1,
 		 val & ~SECOCEC_ENABLE_REG_1_IR);
 
-	dev_dbg(dev, "IR disabled");
+	dev_dbg(dev, "IR disabled\n");
 	return status;
 }
 
@@ -431,13 +431,13 @@ static int secocec_ir_rx(struct secocec_data *priv)
 
 	rc_keydown(cec->ir, RC_PROTO_RC5, RC_SCANCODE_RC5(addr, key), toggle);
 
-	dev_dbg(dev, "IR key pressed: 0x%02x addr 0x%02x toggle 0x%02x", key,
+	dev_dbg(dev, "IR key pressed: 0x%02x addr 0x%02x toggle 0x%02x\n", key,
 		addr, toggle);
 
 	return 0;
 
 err:
-	dev_err(dev, "IR Receive message failed (%d)", status);
+	dev_err(dev, "IR Receive message failed (%d)\n", status);
 	return -EIO;
 }
 #else
@@ -497,7 +497,7 @@ static irqreturn_t secocec_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 
 err:
-	dev_err_once(dev, "IRQ: R/W SMBus operation failed (%d)", status);
+	dev_err_once(dev, "IRQ: R/W SMBus operation failed %d\n", status);
 
 	/*  Reset status register */
 	val = SECOCEC_STATUS_REG_1_CEC | SECOCEC_STATUS_REG_1_IR;
@@ -553,16 +553,16 @@ static int secocec_acpi_probe(struct secocec_data *sdev)
 
 	gpio = devm_gpiod_get(dev, NULL, GPIOF_IN);
 	if (IS_ERR(gpio)) {
-		dev_err(dev, "Cannot request interrupt gpio");
+		dev_err(dev, "Cannot request interrupt gpio\n");
 		return PTR_ERR(gpio);
 	}
 
 	irq = gpiod_to_irq(gpio);
 	if (irq < 0) {
-		dev_err(dev, "Cannot find valid irq");
+		dev_err(dev, "Cannot find valid irq\n");
 		return -ENODEV;
 	}
-	dev_dbg(dev, "irq-gpio is bound to IRQ %d", irq);
+	dev_dbg(dev, "irq-gpio is bound to IRQ %d\n", irq);
 
 	sdev->irq = irq;
 
@@ -590,7 +590,7 @@ static int secocec_probe(struct platform_device *pdev)
 
 	/* Request SMBus regions */
 	if (!request_muxed_region(BRA_SMB_BASE_ADDR, 7, "CEC00001")) {
-		dev_err(dev, "Request memory region failed");
+		dev_err(dev, "Request memory region failed\n");
 		return -ENXIO;
 	}
 
@@ -598,14 +598,14 @@ static int secocec_probe(struct platform_device *pdev)
 	secocec->dev = dev;
 
 	if (!has_acpi_companion(dev)) {
-		dev_dbg(dev, "Cannot find any ACPI companion");
+		dev_dbg(dev, "Cannot find any ACPI companion\n");
 		ret = -ENODEV;
 		goto err;
 	}
 
 	ret = secocec_acpi_probe(secocec);
 	if (ret) {
-		dev_err(dev, "Cannot assign gpio to IRQ");
+		dev_err(dev, "Cannot assign gpio to IRQ\n");
 		ret = -ENODEV;
 		goto err;
 	}
@@ -613,11 +613,11 @@ static int secocec_probe(struct platform_device *pdev)
 	/* Firmware version check */
 	ret = smb_rd16(SECOCEC_VERSION, &val);
 	if (ret) {
-		dev_err(dev, "Cannot check fw version");
+		dev_err(dev, "Cannot check fw version\n");
 		goto err;
 	}
 	if (val < SECOCEC_LATEST_FW) {
-		dev_err(dev, "CEC Firmware not supported (v.%04x). Use ver > v.%04x",
+		dev_err(dev, "CEC Firmware not supported (v.%04x). Use ver > v.%04x\n",
 			val, SECOCEC_LATEST_FW);
 		ret = -EINVAL;
 		goto err;
@@ -631,7 +631,7 @@ static int secocec_probe(struct platform_device *pdev)
 					dev_name(&pdev->dev), secocec);
 
 	if (ret) {
-		dev_err(dev, "Cannot request IRQ %d", secocec->irq);
+		dev_err(dev, "Cannot request IRQ %d\n", secocec->irq);
 		ret = -EIO;
 		goto err;
 	}
@@ -666,7 +666,7 @@ static int secocec_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, secocec);
 
-	dev_dbg(dev, "Device registered");
+	dev_dbg(dev, "Device registered\n");
 
 	return ret;
 
@@ -691,14 +691,14 @@ static int secocec_remove(struct platform_device *pdev)
 
 		smb_wr16(SECOCEC_ENABLE_REG_1, val & ~SECOCEC_ENABLE_REG_1_IR);
 
-		dev_dbg(&pdev->dev, "IR disabled");
+		dev_dbg(&pdev->dev, "IR disabled\n");
 	}
 	cec_notifier_cec_adap_unregister(secocec->notifier, secocec->cec_adap);
 	cec_unregister_adapter(secocec->cec_adap);
 
 	release_region(BRA_SMB_BASE_ADDR, 7);
 
-	dev_dbg(&pdev->dev, "CEC device removed");
+	dev_dbg(&pdev->dev, "CEC device removed\n");
 
 	return 0;
 }
@@ -709,7 +709,7 @@ static int secocec_suspend(struct device *dev)
 	int status;
 	u16 val;
 
-	dev_dbg(dev, "Device going to suspend, disabling");
+	dev_dbg(dev, "Device going to suspend, disabling\n");
 
 	/* Clear the status register */
 	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
@@ -733,7 +733,7 @@ static int secocec_suspend(struct device *dev)
 	return 0;
 
 err:
-	dev_err(dev, "Suspend failed (err: %d)", status);
+	dev_err(dev, "Suspend failed: %d\n", status);
 	return status;
 }
 
@@ -742,7 +742,7 @@ static int secocec_resume(struct device *dev)
 	int status;
 	u16 val;
 
-	dev_dbg(dev, "Resuming device from suspend");
+	dev_dbg(dev, "Resuming device from suspend\n");
 
 	/* Clear the status register */
 	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
@@ -762,12 +762,12 @@ static int secocec_resume(struct device *dev)
 	if (status)
 		goto err;
 
-	dev_dbg(dev, "Device resumed from suspend");
+	dev_dbg(dev, "Device resumed from suspend\n");
 
 	return 0;
 
 err:
-	dev_err(dev, "Resume failed (err: %d)", status);
+	dev_err(dev, "Resume failed: %d\n", status);
 	return status;
 }
 
-- 
2.17.1

