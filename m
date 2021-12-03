Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7A467405
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351325AbhLCJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhLCJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:30:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB29EC06173E;
        Fri,  3 Dec 2021 01:26:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b11so1663731pld.12;
        Fri, 03 Dec 2021 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMjtefQPD8LMKp7HsI40U7ExFBle/hPa8kdDB8ErYSQ=;
        b=DJlpvcH7FkSrOa3ZkTlNitW5TQcKtglRXBezAJRUh9Ahzk7/EHwD7xSltWy1j6mW2u
         yf47DLXbBp4XtzWSaxZwAFUle8vojCrdF/zfq5lUKwFKHFGgIYZKyhIj0byc4kgQWnk1
         VqncEYJJbR6QJWnWMa/tSPWIHSe1FjGuvED/nAhSwg0dE1Iew0tm2kcXdAT9s3kcA9kx
         o82XsRDCp3Z25sOQw4gDeLzu8oRAjEDNlJlSe9eYmY5tshn7cZmDF753ZzDIQ8U6Lr/v
         LYk7QnVym6mKVY9kl/U7GWLUD5wQmq+/gOesQh8GkUQb3vgVBL6mQiB9O4w3gOuYq8dI
         FOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMjtefQPD8LMKp7HsI40U7ExFBle/hPa8kdDB8ErYSQ=;
        b=WduuRRYeBWupdSshCSCcTO87n6uDmfmGoJriSDKy7dQmFxM4FDQhIj17Pmp8IncGlK
         HFdpPds2xoiP1Ek2zABs7q8+hCRKZL4To/AhntDo/qa8RnAjCgyCauwPly2i7IJUcs2u
         wyyuROb5m7oOeoEA4crY71uSP0ua15xyoCW5zCJyUU99fpQru75l16LH9IAA9X8he0TL
         ry3uqQtWMnP+GHmaSsDyAs2McSchARtIQFZQ/FOp6RHNuodZ8oUD/payYQGk4bu+nCGx
         b2b5HBm75vEb+UTQidrR3QCvHaNDdkHd9tRP295geBEbQVUwC/MDAN6MBDGkPiTIb6Ug
         L08w==
X-Gm-Message-State: AOAM531h5be8H7R2glNQy1hfLjrzZOWbLwHP4DfYaqlj+qzPFuN0eHpu
        jtHuxccwfQe7ZBb8styZqCDL8yz7iPs=
X-Google-Smtp-Source: ABdhPJyz00I6JdsvrIgMwB7IELtD022bY6FOhfE0ySNfkapKPEmIGeHUD0GJfqfWcye2xgiTfOUc0g==
X-Received: by 2002:a17:90b:615:: with SMTP id gb21mr13086859pjb.10.1638523612208;
        Fri, 03 Dec 2021 01:26:52 -0800 (PST)
Received: from richard-System-Product-Name.. ([49.216.238.137])
        by smtp.gmail.com with ESMTPSA id h13sm2489100pfv.37.2021.12.03.01.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 01:26:51 -0800 (PST)
From:   Richard Hsu <saraon640529@gmail.com>
X-Google-Original-From: Richard Hsu <Richard_Hsu@asmedia.com.tw>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, Richard_Hsu@asmedia.com.tw
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Subject: [PATCH] gpio Add my driver new id
Date:   Fri,  3 Dec 2021 17:26:09 +0800
Message-Id: <20211203092609.8502-1-Richard_Hsu@asmedia.com.tw>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/gpio/gpio-amdpt.c | 12 ++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index bbf53e289141..4d01d4341a67 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>

 #define PT_TOTAL_GPIO 8
+#define PT_TOTAL_GPIO_EX 24

 /* PCI-E MMIO register offsets */
 #define PT_DIRECTION_REG   0x00
@@ -72,10 +73,12 @@ static void pt_gpio_free(struct gpio_chip *gc, unsigned offset)
 static int pt_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_dev;
+	acpi_handle handle = ACPI_HANDLE(dev);
 	struct pt_gpio_chip *pt_gpio;
 	int ret = 0;

-	if (!ACPI_COMPANION(dev)) {
+	if (acpi_bus_get_device(handle, &acpi_dev)) {
 		dev_err(dev, "PT GPIO device node not found\n");
 		return -ENODEV;
 	}
@@ -100,10 +103,14 @@ static int pt_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}

+	if (!strncmp(acpi_dev_name(acpi_dev), "AMDIF031", 8))
+		pt_gpio->gc.ngpio = PT_TOTAL_GPIO_EX;
+	else
+		pt_gpio->gc.ngpio = PT_TOTAL_GPIO;
+
 	pt_gpio->gc.owner            = THIS_MODULE;
 	pt_gpio->gc.request          = pt_gpio_request;
 	pt_gpio->gc.free             = pt_gpio_free;
-	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
 #if defined(CONFIG_OF_GPIO)
 	pt_gpio->gc.of_node          = dev->of_node;
 #endif
@@ -135,6 +142,7 @@ static int pt_gpio_remove(struct platform_device *pdev)
 static const struct acpi_device_id pt_gpio_acpi_match[] = {
 	{ "AMDF030", 0 },
 	{ "AMDIF030", 0 },
+	{ "AMDIF031", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pt_gpio_acpi_match);
--
2.30.2

