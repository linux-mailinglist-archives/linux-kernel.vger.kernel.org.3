Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAD94875BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiAGKhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346830AbiAGKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73240C034006
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:39 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id k15so20288717edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kdpn8r0JqvLlGfo3MqmUrRJbX7osy6ZEtxXCs41Q3Q4=;
        b=m8el/STITfyN6+L+3eVLfgfQKOaL5yNtZpo+CYJZHH9TryY7WIWkuhL1AJZKh2wFlp
         5FnaWCj8FvUPsByTCrZcrgvKxw3dYnXK3t1Yp7+lY116LKvhIipsB/9uiOebZJeNw2U5
         xrATSW9D0eSym7vQ9waFCRogY2kfFsUOJBHx7LtBQQDxlLs8NQDDmcQ3tiPW2MvabkXt
         JfXmUSDPJBOMGkVO0v+CYyXISSgTw8sCeUJNS9+PhkQWKWqrhOVJvctra47SkVZeu3dx
         spGL8fsjWfdLfhBXT3QCSKTKcQ9udmHMXCKuOOOsX3gUiklQMhRf/mcvz41q03JDML9b
         jSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kdpn8r0JqvLlGfo3MqmUrRJbX7osy6ZEtxXCs41Q3Q4=;
        b=2jtV1JxLaNo41EqKhYhtDK7BiN1a5lRKjTF/D91udbVFC8YhMraPm5hxTrqMDCA54h
         JaFcKJySZYZst/pJDnESKSvxg6B4/bFthNDeu2ZZKv9gKmOIifPxkYkYvvkWBPG5b345
         dSakHe82sdEth6ybv6OurLQxG3LrnnEgDq7uQ+LZDAOTf+Jz0D600dO+gtCzM3ZsS1eP
         xmIjtlrZGTVe8fick+zEzqSefKKQA5AqrCJ2n7K9jKqCZIJZRLCmxzz8nb/51TY91UOB
         dGkD5QWXphHNLQryVEl8SqMnULlWlRHnyXi0/Ds8hf6D0bIl99T+S0E6WXafuELgoWkK
         3yYg==
X-Gm-Message-State: AOAM531zcQ/A3dhsHIDFXRKSQLJAvjiqLPD1SFR50xSB14d8mvSwI+5X
        Us8gNeCcCOngRGfgNkRALnQ=
X-Google-Smtp-Source: ABdhPJyuCsoVGiej5YvrWk/4ErGKYTzi7SoJXHRiCNDpsMh2g8ttfNFDC8ZfSECF3iRGU2bGPWKI6A==
X-Received: by 2002:aa7:d8c5:: with SMTP id k5mr6063213eds.53.1641551798005;
        Fri, 07 Jan 2022 02:36:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/19] staging: r8188eu: rename rtSatus in rtl8188e_firmware_download()
Date:   Fri,  7 Jan 2022 11:36:15 +0100
Message-Id: <20220107103620.15648-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable rtStatus in rtl8188e_firmware_download() to avoid
camel case.

rtStatus -> ret

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f158bbf44094..1685386a7015 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -541,7 +541,7 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 
 int rtl8188e_firmware_download(struct adapter *padapter)
 {
-	int rtStatus = _SUCCESS;
+	int ret = _SUCCESS;
 	u8 writeFW_retry = 0;
 	u32 fwdl_start_time;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
@@ -553,8 +553,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	static int log_version;
 
 	if (!dvobj->firmware.data)
-		rtStatus = load_firmware(&dvobj->firmware, device);
-	if (rtStatus == _FAIL) {
+		ret = load_firmware(&dvobj->firmware, device);
+	if (ret == _FAIL) {
 		dvobj->firmware.data = NULL;
 		goto exit;
 	}
@@ -591,9 +591,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 		/* reset the FWDL chksum */
 		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_ChkSum_rpt);
 
-		rtStatus = write_fw(padapter, pFirmwareBuf, FirmwareLen);
+		ret = write_fw(padapter, pFirmwareBuf, FirmwareLen);
 
-		if (rtStatus == _SUCCESS ||
+		if (ret == _SUCCESS ||
 		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && writeFW_retry++ >= 3))
 			break;
 
@@ -602,19 +602,19 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 		);
 	}
 	fw_download_enable(padapter, false);
-	if (_SUCCESS != rtStatus) {
+	if (ret != _SUCCESS) {
 		DBG_88E("DL Firmware failed!\n");
 		goto exit;
 	}
 
-	rtStatus = fw_free_to_go(padapter);
-	if (_SUCCESS != rtStatus) {
+	ret = fw_free_to_go(padapter);
+	if (ret != _SUCCESS) {
 		DBG_88E("DL Firmware failed!\n");
 		goto exit;
 	}
 
 exit:
-	return rtStatus;
+	return ret;
 }
 
 /*  */
-- 
2.34.1

