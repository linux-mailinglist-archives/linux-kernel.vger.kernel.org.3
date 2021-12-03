Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077DD467069
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350278AbhLCDEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhLCDEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:04:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B21C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:01:26 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x7so1297845pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=flNl4+wOdPQZ7BpJ4HcBce/7klXuEOQ0vt7dFvL/gho=;
        b=XC/Yz4sYM1Arbp2e3E2wVTt//UL4M7PuJO7JTzib1PPRdSPgHChxeRRPSEzI3PvlJg
         NJpusJcEW+xLJUEeh+qL4A0YzLt4HJusHf4g6Oj5CbivdLsMxJUrYCNJnDmbN99oRcee
         jj2goEz/txZZtcAFe41LlyFtnO18yNiJuKnho/Db+3KNLbG2GqQSYeFbo8Ppdhrw4M/a
         bkCsXGcN+5w7jL++b5w7wbIE/xuNEqOpOdvFwitzZX/UPpgaHHsuNZ8AAJ71vyQbUla0
         6BWRHg80BLEncUvFuXMyumxfhZiq2kyrkknfyHCAVEFYopBy2j7nRcYNNVza06aUfXSY
         1dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=flNl4+wOdPQZ7BpJ4HcBce/7klXuEOQ0vt7dFvL/gho=;
        b=ck/J+u/M8g1Z1DwfYBPFB+9IrEZLLbDUACjqIghXQqqg+ao+t8a7bqWRBz/D7eTmGh
         VE3Pb/eSuLgnymQNZWMlSRwVvt4n0D060pL4nDeMDV373sAjiQfheeKXKP4e0DC9OgE5
         g/Ga26t4JJs7LP5QSBU0+CupmIdW2lzFn96XFvvewp8h0XmU3l+pMjJ6RW08dfo1GQG+
         umnEIhql+QjKkQNi3Z1v46bJ16ss0i59QU6Yj/LUjij5p5uomAdoCl0onXQnM6ABErhj
         0Lssn6oeYjJ+OAemWNBRYTSR6DXM4zYDvDTkhin2+5Fy6VewXfrs+2Gklg/L+rGop6VI
         KEiA==
X-Gm-Message-State: AOAM530l3e/MIluNBhAcjocKWDSsasnhlDdX9xRfM6MBHk1AvFzYKmAq
        fJRARJ4RX6WvSbDrwG7ONbWDbQ==
X-Google-Smtp-Source: ABdhPJzt+6XC66+2G5EwGqBuBxlxbAKK0cPUS/l0GmnEfaLzUfQst1xZqtaaxooHw+a8jZ46Cz+iog==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr10570528pjy.123.1638500486530;
        Thu, 02 Dec 2021 19:01:26 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id n16sm737476pja.46.2021.12.02.19.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:01:26 -0800 (PST)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        phoenixshen@google.com,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH] HID: google: add eel USB id
Date:   Fri,  3 Dec 2021 11:01:19 +0800
Message-Id: <20211203030119.28612-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one additional hammer-like device.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
---
 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 8123b871a3eb..0403beb3104b 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -585,6 +585,8 @@ static void hammer_remove(struct hid_device *hdev)
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_DON) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 96a455921c67..b02d8b1d907a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -501,6 +501,7 @@
 #define USB_DEVICE_ID_GOOGLE_MAGNEMITE	0x503d
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
+#define USB_DEVICE_ID_GOOGLE_EEL	0x5057
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.17.1

