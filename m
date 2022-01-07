Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864BD4875AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiAGKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiAGKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:33 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59578C061212
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bm14so20438995edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rU+Vg4+1drVRrn/D9Am4bqhT5yHNGNCE4vZue9cHXJ4=;
        b=Q+PuxjAxN3VchAWxps6UKlrw4hc1OEJepqFnqdV//iV4O01xRimuwcdMNl3Y4JhNW2
         dd0Nmw7mEHpR6u9fFR1tJ+m6Q4KZmKtaXMGN3ut56fcg6TSENdyG3r9rgTgAF1wxcbhg
         fDCEB9YGvXfNfrbo/mR9cRMn1bUOapOjVFFMh3TQrevnBtRVMtJdtuyZgntwDK37QEp4
         D4hgY6ZEVIo371Ma8V0tWrZnqGDhO/4vKFAnzh9+QXuYU9U7EOaN9DvLN6uscG9cruBj
         BLO5HUVUgNAfqL/vfo4ktoRrPFmIvxZcAkqxzXhGVDlrH9iHbg1juA/5W56QWk9e9P08
         biiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rU+Vg4+1drVRrn/D9Am4bqhT5yHNGNCE4vZue9cHXJ4=;
        b=rnAXLth1xpBSR/LUjHJXS4A3Y7ZigCD5FPBVgWcQ5mpVapNOvy03+v0jJqFJ9pWFiD
         pzLFbHvwdXvRPNRGOfspB3oqvoqJ9S0o32qSymDXzp7eibyrVWyKs3XdEzUdH5RyND+a
         tSv0CXMCAEK13D4EcGdF+4+XSEjXHYrmEveCrJSxhihsnZc7t1MrTJpWlyVymQuGid+C
         ApyBKQyPXHC6JkPxnb9hqK7+qKheKh2mRLLF+xe5uCVkwUaLAnuogHIzSH7/w+LUvvDp
         Q8O0M+xWtl5a1ImpbhWVMoBOTe/rnUpC6zVXJbk30bp7foSoMYOlGKbe6cAtstz5DeZZ
         5uqg==
X-Gm-Message-State: AOAM530D4zGIgyHqPCK1FU0nm1A5emPhLqshLtXd3qGbKWc6U+RaEyKE
        IC1pkrsSL1gNZqwdJm53uMY=
X-Google-Smtp-Source: ABdhPJxHmbVSWyq/A7hA27XUwk+OEUgR9WU1HX8M6ccFTpPuUzbrOUGIQsz1wvDhcTCjzpwQ7iEKbQ==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr60833104edb.360.1641551792025;
        Fri, 07 Jan 2022 02:36:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/19] staging: r8188eu: rename rtStatus in load_firmware()
Date:   Fri,  7 Jan 2022 11:36:06 +0100
Message-Id: <20220107103620.15648-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the local variable rtStatus in load_firmware() to avoid camel
case.

rtStatus -> ret

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b4f29c48d58d..edb56a9ae283 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -510,30 +510,30 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 
 static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 {
-	s32	rtStatus = _SUCCESS;
+	s32 ret = _SUCCESS;
 	const struct firmware *fw;
 	const char *fw_name = "rtlwifi/rtl8188eufw.bin";
 	int err = request_firmware(&fw, fw_name, device);
 
 	if (err) {
 		pr_err("Request firmware failed with error 0x%x\n", err);
-		rtStatus = _FAIL;
+		ret = _FAIL;
 		goto exit;
 	}
 	if (!fw) {
 		pr_err("Firmware %s not available\n", fw_name);
-		rtStatus = _FAIL;
+		ret = _FAIL;
 		goto exit;
 	}
 	if (fw->size > FW_8188E_SIZE) {
-		rtStatus = _FAIL;
+		ret = _FAIL;
 		goto exit;
 	}
 
 	pFirmware->szFwBuffer = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
 	if (!pFirmware->szFwBuffer) {
 		pr_err("Failed to allocate pFirmware->szFwBuffer\n");
-		rtStatus = _FAIL;
+		ret = _FAIL;
 		goto exit;
 	}
 	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
@@ -542,7 +542,7 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 
 exit:
 	release_firmware(fw);
-	return rtStatus;
+	return ret;
 }
 
 s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
-- 
2.34.1

