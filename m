Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E364875B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbiAGKhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346785AbiAGKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999CC034008
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:40 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 30so18828846edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv4jc9aXbLqInVQ3V0d0MEK9dE0H07uL4Qmt1lgDr1E=;
        b=O9r5+X59nJO2f8v0jS6ollNA/3EqHLTHEVHBzbhIlpiO0K9zwdWJdVsBHo80yqAJpP
         a4uVGnISo7KTcIt2Lv+FhhkJGbTAJUAWJd9+19jVsCyP/A321A52Ou61iP66uouHkTJU
         fuK8PEYDvuW2e3g3d8Qb3WU3bpP/DKo1e25XWCChqSM1orCcZs6gsyZUDtsmRU57gBPa
         TalOQSSoixjLDhLCnYF607AkFfUdsZxSofVtRnu4QXyMqCZSkd+HiEGTN2ZR7Gd6UC4A
         gNRm40+imeIPBRddZyR6c47K1g7Onrly1/o3aNADGdX/ovIL9yLgKAdDPTjn/zXmuWrX
         9Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv4jc9aXbLqInVQ3V0d0MEK9dE0H07uL4Qmt1lgDr1E=;
        b=rdIWL9pQlgrnh5tME3M8DCoR9QdjCTcPys4WjucXrvuxYbuGQUg+OmyGPPpl/VJtgu
         z18U0IF5ExAfE7+vGb3Lxa62rlpA60zvD/ujUhG6NjmTlFAzAJB8rxYSViDLkgPio/7S
         E27TLFZb8x4yX/4aATcWar/z+jslEh8RGXGaL8mUXN1+5MMCXnPzMyxirfpt9GwDiuGb
         0v+64bBTqcCFpD+at2tUz4BulN44536p5CzdYtcOPlOUnJyT9OWh3t5VgF2zdZM/MJ5N
         0M7D6nbW1eM7UaWleS3PkXTvVz0KhE1E0Bcy9WvhR9jRTc9NsJ3WNHq2sbgeWP0WzJPt
         /BqA==
X-Gm-Message-State: AOAM533MoULypGk31wHzrs+APOvw0BWSbE4kcg88PdPdPkSvaiYgXmuF
        0FJKJSSL256faBZdr9LASzU=
X-Google-Smtp-Source: ABdhPJzMbmeVkGuQKiIWMefbl6HVyOq/Hn4cU2eBl4vpyc3toR80OMPUVZmyfHOh23zSf3wmrPi0/g==
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr60218617edc.125.1641551798668;
        Fri, 07 Jan 2022 02:36:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/19] staging: r8188eu: rename FWDL_ChkSum_rpt
Date:   Fri,  7 Jan 2022 11:36:16 +0100
Message-Id: <20220107103620.15648-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename FWDL_ChkSum_rpt to avoid camel case.

FWDL_ChkSum_rpt -> FWDL_CHKSUM_RPT

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
 drivers/staging/r8188eu/include/rtl8188e_spec.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1685386a7015..6c23966ec785 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -475,7 +475,7 @@ static int fw_free_to_go(struct adapter *padapter)
 	/*  polling CheckSum report */
 	do {
 		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & FWDL_ChkSum_rpt)
+		if (value32 & FWDL_CHKSUM_RPT)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
@@ -589,7 +589,7 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	fwdl_start_time = jiffies;
 	while (1) {
 		/* reset the FWDL chksum */
-		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_ChkSum_rpt);
+		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
 
 		ret = write_fw(padapter, pFirmwareBuf, FirmwareLen);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 009222b4a95d..edae053e350e 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -794,7 +794,7 @@ Current IOREG MAP
 /* 2 MCUFWDL */
 #define MCUFWDL_EN			BIT(0)
 #define MCUFWDL_RDY			BIT(1)
-#define FWDL_ChkSum_rpt			BIT(2)
+#define FWDL_CHKSUM_RPT			BIT(2)
 #define MACINI_RDY			BIT(3)
 #define BBINI_RDY			BIT(4)
 #define RFINI_RDY			BIT(5)
-- 
2.34.1

