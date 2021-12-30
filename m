Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338E482024
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhL3UBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbhL3UBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67FC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v7so52257359wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eCdntbo1fpqOMRKpRxKk5VqCLi7+91tE3jKZQQIpLM=;
        b=Zb7JmPF/OFLUDObEsqtwc0tpUtXSoCwHBynii3bEHf/Ez/3jw3wzk4W55FZopLLSIM
         6YV4gbqqASDb60kZzgXdBNHKM42cZTq0qSccuh6k9nzi1STD3i8LuckbzTtAgrRM2EWX
         A6aJALyKYDQhehvm17xQAOp5G3JAsiRw8b76mXoiZ3Y3dp+PC+mauH9PSRusQYnf6bre
         OLfI2BRshMNZj2QpGOrQ6IpQ3Y7o3oI10IToAOJGcBl+z+V7v+cnUEt3om2niJzAluAi
         qDhV+u+bPDY+tDiJMnhjICHJ8bWEdJs6OcPs4qaCFHL5pqJtvseA6qb11KKA/qFwmID7
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4eCdntbo1fpqOMRKpRxKk5VqCLi7+91tE3jKZQQIpLM=;
        b=RneCKgStaYmYGfkMHOG3n3NEIrRdu//STzfcUoZ8B1ObVW8CblB/4RcB7NUiRjKN8O
         iT7m1BCFQRlr7qe+e7gNGy4j+s5Zvew8H7tPKA181W8oWsqX2vGsO6YrQuDunVT7vjFP
         vaQNDhqp6ztWzmSOviEb0SXLD58zp4qWGzJf2E/32DeH1yB4vIbmoip7H6tiz0LQtpxd
         eZHTohta6irUfmfceM1dJlr0yPUB8pFdqHDJ3wvmHmk70LyXp4cYt3E5FnSk7s8SZy52
         NChyNRfWwpFwCzzS5jNQwQTp9G+yCPnXMCquooBIPBX1pWvQrYq1ZixFjd9ruRj7oKLm
         6EEQ==
X-Gm-Message-State: AOAM532S30CHbLXFpY2ejZ8DJ43mOzrYaq8W2HfTI4vTLzMMqs+sBs0k
        rGczq8ToRv33tjuTlwO6HH8=
X-Google-Smtp-Source: ABdhPJxP+zzzLjXOP2uYo44csOHEbeJ1PXAddp0HVDH7XBbtp0K1A7dKLG7EGNNhWT+v1shTDTR0Tg==
X-Received: by 2002:a5d:5547:: with SMTP id g7mr16614764wrw.551.1640894468326;
        Thu, 30 Dec 2021 12:01:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: r8188eu: bAPKThermalMeterIgnore is set but never used
Date:   Thu, 30 Dec 2021 21:00:56 +0100
Message-Id: <20211230200059.13406-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bAPKThermalMeterIgnore of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 ++---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 065c2701077d..cce291ca44b1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1230,9 +1230,8 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 	else
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
 
-	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
-		pHalData->bAPKThermalMeterIgnore = true;
+	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
-	}
+
 	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index de58c85b8bdc..40b3db34b8f2 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -181,7 +181,6 @@ struct hal_data_8188e {
 	u8	EEPROMRegulatory;
 
 	u8	EEPROMThermalMeter;
-	u8	bAPKThermalMeterIgnore;
 
 	bool	EepromOrEfuse;
 
-- 
2.34.1

