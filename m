Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AFB467EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359015AbhLCUTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353691AbhLCUTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:19:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D22C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:15:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so16078829edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQxJrVTwbMTGbpX2IL1FtoxqI0v6WcmxBcnCNhy3JLg=;
        b=O6d5Nr2jRIyqNqykxET77UEBjoNyYpFtwDUhP2OruMwVVe+i+xW53aPAmq203c5K9F
         nZzb+CjQECUqeFbxwDa9ZI9ovnczmvkZElrYTLGUbXskqkwqhjjMW2sNuB0ztHLLDYrF
         YSAsWjV0wOuz4tZuHssk/2ELuKmvQAzaPsLgQdLtKSkm0YZeP22HHcw0WXU7kH4jN4S/
         1EDIl5qJTHM1vfnKWBmmD5YCs1w5/NkngNgeZPWv0rjUtXPamRdViTRR5FfzHN15qKGi
         DQNjZU+V1O68N0N+JYkRHeTkqWAMcbFglol4sx06w9NNA6AOm4yAVVbX7Q/rc2c8fmf5
         uTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQxJrVTwbMTGbpX2IL1FtoxqI0v6WcmxBcnCNhy3JLg=;
        b=PzBHtjS5fx4iMMY/OB2uVncJfKEHHas/mWUWTsAnwo6vMN/HELwNUMXS7FeNigihVx
         WoEwlQU7vtgLNHaQ9XsXNl8THB1mSgB7ykg4wHbz1dlaxFjtSQYgMisgX/K0xAMVwMJA
         lfliRWwcs9rxCMnUsALfBA55XFh9/tdCw3i69v3JcaXvIxXtHYqGmD04My3czEbOxAfx
         TPrjFmSYOQrQCceXy/4uEHWdxxq7M/twvcV0uwrw5yvXd1JMkPbYBAGA9P9GDhe5A6CN
         IvnCvDZoQSRI8A007KQxmgF5GGDy4YIWd/s4/GXtBD/Gt65OoEfqpvEyJ7Hr1pzYVXNz
         676A==
X-Gm-Message-State: AOAM533euKmrAfuvL7oQ6xRVAfhZAKe5Y5gLHYeDTyJgrgJp0+uATVY3
        GGca3cNbsD+cscjkcXffE2MpwIbgcyI=
X-Google-Smtp-Source: ABdhPJxg/LxdAuOc59AIBf3PuXEtoIypdxhEGZK8tOMoI36L9KU5dWC1O//4bdcItkDzsthtuFq2WA==
X-Received: by 2002:a17:906:d54d:: with SMTP id cr13mr25768242ejc.72.1638562534177;
        Fri, 03 Dec 2021 12:15:34 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id j4sm2495133edk.64.2021.12.03.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:15:33 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] staging: vt6655: refactor byRadioCtl to radio_ctl
Date:   Fri,  3 Dec 2021 21:14:50 +0100
Message-Id: <20211203201452.3806090-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase hungarian notated variable "byRadioCtl"
into linux kernel coding style equivalent variable "hw_radio_off".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index c51eba94230d..245f992e5a23 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -227,7 +227,7 @@ struct vnt_private {
 	bool bPWBitOn;
 
 	/* GPIO Radio Control */
-	unsigned char byRadioCtl;
+	unsigned char radio_ctl;
 	unsigned char byGPIO;
 	bool hw_radio_off;
 	bool bPrvActive4RadioOFF;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 897d70cf32b8..37a82550ca82 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -371,18 +371,18 @@ static void device_init_registers(struct vnt_private *priv)
 
 	priv->radio_off = false;
 
-	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_offset,
+	priv->radio_ctl = SROMbyReadEmbedded(priv->port_offset,
 					      EEP_OFS_RADIOCTL);
 	priv->hw_radio_off = false;
 
-	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
+	if (priv->radio_ctl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
 		MACvGPIOIn(priv->port_offset, &priv->byGPIO);
 
 		if (((priv->byGPIO & GPIO0_DATA) &&
-		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
+		     !(priv->radio_ctl & EEP_RADIOCTL_INV)) ||
 		     (!(priv->byGPIO & GPIO0_DATA) &&
-		     (priv->byRadioCtl & EEP_RADIOCTL_INV)))
+		     (priv->radio_ctl & EEP_RADIOCTL_INV)))
 			priv->hw_radio_off = true;
 	}
 
-- 
2.25.1

