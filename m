Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E0448271D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiAAIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiAAItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49517C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w20so50706788wra.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOX3rSpe6Y+YD+edQeghlR9ENccpSM4hKY7ygLNTvjg=;
        b=N12nV/uvkUwL6yl4VCIwJqCSf8U2Gd+XH6dZjuLVSrU3SHtbDtBye59f7WkjX6uMyO
         jiyAD3QftB+Y5ybnW/Vl56gUuzQLr1O5TFIBnGEewuzu4t5XpKBc/bX+kdppK033S4J5
         +BeD5SUkSMe4LyqToCd+O0w998RbIkwhmE05p9zbHts62TZOhPW5PILF0aGmtfpSJ4+O
         fvjXxWEL5ygVepyNsNSEQyOJza0WkJmyonDs7M/SKlB3p9NPZUgtiDfejr6eZyGldoZY
         QJkAISqYVAZs7lNKAKfPcuMGzNWtHw5dTPxVuKUmSGf3iqiZMAhrJAA2TP+fIc3QvVUz
         NbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOX3rSpe6Y+YD+edQeghlR9ENccpSM4hKY7ygLNTvjg=;
        b=T38REf0pyLu3hPKWc6mR1Noh03pIBLQI0fTTAeQ1xR0gFIazWIa+rAiAa/Uaazbgmd
         dvIlq0Vtq9RDf1/qGN9wHribXA/feD6UIgDgc071sJslc/5cm4N+E95XqORN3D/u8e16
         z0BTFqrHsDbFR6i3LEf0W7tWgFLWwwtzCIiw04l/HaNIt33Rj2yH2o43Uc0U+m/jnLzq
         13GgWa0Murx3zNyzuA/pw4/nOS96fLZRX6A4u6BW4QC+I8xWbhPazq7l7hODMHI7AQX6
         1iDEC8QthmRZHsPQW8Ylus5ckGEtEOeQlnv6nDudo7WanV4d6aOoYKFG1EhL5UetkKGU
         +TKw==
X-Gm-Message-State: AOAM533Tc3+SoYGCodt75OYPcmMn2YTCf1juWYaQN//JdJzkfmbBYc40
        Z/1jYkgf8aQI2bPBwKViqnU=
X-Google-Smtp-Source: ABdhPJy79/0Fud68RuyOC3koTrXTUAQogNlzNd86dYMW5O2Clu/GBhLkKOs172Lc+YDSIg4C0+uEiw==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr31541256wrm.30.1641026991913;
        Sat, 01 Jan 2022 00:49:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:51 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 4/7] staging: r8188eu: bAPKThermalMeterIgnore is set but never used
Date:   Sat,  1 Jan 2022 09:49:34 +0100
Message-Id: <20220101084937.3411-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101084937.3411-1-straube.linux@gmail.com>
References: <20220101084937.3411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bAPKThermalMeterIgnore of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: no changes

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

