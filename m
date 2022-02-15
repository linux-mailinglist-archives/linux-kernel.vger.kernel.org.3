Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495D4B779E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiBOSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:14:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiBOSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:14:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76611987F;
        Tue, 15 Feb 2022 10:14:16 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lw4so15223809ejb.12;
        Tue, 15 Feb 2022 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ve8tBclI5IMrrMI15B03jvD+eu/iK6m1qrk9Pz//fBI=;
        b=YNGCUR4gBl+cRj8ZDXavs6V5oA2FX/QUEX8ZsmLGhYPTyLe52OsMU8Zi5s3AJ+rw8N
         8C+z2K90YyucBK+6AuTmQReOR9IJYlQceYoSCxL01T6pps6H9Qkgfl4VIrngB2XIfr/b
         ORmRCmGZVTMVJrFnEcdK/n946xLx6m3AsP0xBqB3AwH1wSUkpH6H7wudaoserf2YRUvM
         oG1RyJSkbqqI8W8uuetSlvcDF3wp0pKHPWhE3aFfoOpgLKbUton15LbAnha6Qm/Ua8dd
         8M8Uc8tRxjf26rQ6QqAYBjYYmy0u/yXaVX5aI/Cb8CnO4o0eaPmKVeUP3t9nygh9b6CO
         Z4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ve8tBclI5IMrrMI15B03jvD+eu/iK6m1qrk9Pz//fBI=;
        b=OkOPlxPulSjlDt2CsvnBzzP/ME/2xUIoai5Cn/+P3dFcecaG8DqElDPn4sJq5oxuaS
         EivmoSwfSxOd4UHCrpdkTv69US0TgiSBJDNgUHuaYt9bUiFvMwBobfTHHaN5uBQN/Prs
         IZLbRMUZx9eQJKF5PqU2c/5/u7bOg9rrBUcHzZdrjnzMCoQ/23vjmh6AUL/nxAlCSKuM
         Dqf3tdR7NzaIgK7UyHOPR7F2kXsk7z/CG9MhOfx69VzOIw7DkbJCJLA8Cwt2c23Ot1AP
         bFMJx7lg/AKHMDfkarzFfi5A310HUWHO7Hw6TYOPiioACzG4cO/PoUA6B2/D/XQky/0U
         VWnw==
X-Gm-Message-State: AOAM531HAQ6XXWatVceCuj1kW6dDSjDID9RW9Gbc1FZ9XvZ/lkG0etFV
        e3+cHEviP5XI3wk8/XPQaL4=
X-Google-Smtp-Source: ABdhPJyoSFONuo6Co7zZ8pwQfFELPB8FD8jO4vB0KxDtbmUQ6rnpkUPkWrIXFuT7VIHoJlnCFPQcAg==
X-Received: by 2002:a17:906:77db:: with SMTP id m27mr233375ejn.763.1644948854980;
        Tue, 15 Feb 2022 10:14:14 -0800 (PST)
Received: from X1C7EK5.wind3.hub ([151.40.80.193])
        by smtp.gmail.com with ESMTPSA id i5sm1950497ejo.188.2022.02.15.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:14:14 -0800 (PST)
From:   ektor5 <ek5.chimenti@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linuxfancy@googlegroups.com
Subject: [PATCH v2 2/2] media: cec: seco: add newlines in debug messages
Date:   Tue, 15 Feb 2022 19:13:13 +0100
Message-Id: <20220215181313.264698-3-ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215181313.264698-1-ek5.chimenti@gmail.com>
References: <20220215181313.264698-1-ek5.chimenti@gmail.com>
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

