Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74D64875A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiAGKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiAGKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D7C061212
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k15so20287127edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okGzmf14e86UQU6BO3rbed+LRlBp1j5DltJ6EEYherw=;
        b=MRL0Z7pOhn9la+SogT2T1MGdTEJH439FaHQIgz+kq3DVrd41NoKbpSeb9pQ4c+DkJa
         HZMfO5VkAuSJqy+KvxDwjSSdcH58NN/aiK7zIOLOcTxtenrbrKEdrgzEIQ1UMvfU0A+v
         SwJV7nNMNWNVjq+crThnN/BEeZREyaJFY33oOgqfra8gi4GQsevKzS7eICkcgbNRiIEm
         2JFREtF6Q7H9ecw0pV5XU8pbxsSBvaK8wW5KF1P+BMzbs8kit183tsvUBQSxSJ28QlUP
         TfERqSlr/Di4+wf3w5GQSaYdQT5duCtNeoQNqsEbQnvoPpTmbpLp3tH/a09PafsQRsIj
         knYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okGzmf14e86UQU6BO3rbed+LRlBp1j5DltJ6EEYherw=;
        b=AKdf3nJExFHlvKON5Jrovi60ZNaGrZQ8xRT80AbCowed6gGvjaXkvBjp74fal0Rs0S
         bufTqtyYxg+sSpKpTYbfpAwVXB2GScor6zqGcaX9NpV5SHkXQbgE9lfatRYEtsTQzno4
         BOKiuccjv9QXNR+wmsywlb7ky4irv/rI/w/vd2x+Q8jq837da8sgSQ2S6SFI++95YVSP
         b6X8KC2pk6AhUgc5fNZmb0nvxsUVZMHsGsB9XoqYRbjoq2/FVXbV55TcaSs9z8ZZqMbC
         Ek8QHsIQ44t+JGkNJb8aIMRCE+wvkAha1fJeZlxbVCe8t/lJZKlGcDctXIMkd0H6CpGd
         EHiQ==
X-Gm-Message-State: AOAM53175oroopFFZKAoamM3c8PidqEFa0n+NlaE46X6KvA7FY0mQRcW
        24QXigL56YlHy6v8v+P0f94=
X-Google-Smtp-Source: ABdhPJw9+9yqXDvwLU8H0MmBWVfEZqL1/lWsh60xek+ClSo1VjJuXTeOeUBwjFM2PIRwydp6j8CB6Q==
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr62756811edc.110.1641551789001;
        Fri, 07 Jan 2022 02:36:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/19] staging: r8188eu: remove Firmware* from struct hal_data_8188e
Date:   Fri,  7 Jan 2022 11:36:02 +0100
Message-Id: <20220107103620.15648-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields FirmwareVersion, FirmwareSubVersion and FirmwareSignature
of struct hal_data_8188e are only used in the function
rtl8188e_FirmwareDownload(). Use local variables in that function and
remove the fields from struct hal_data_8188e. FirmwareVersionRev is
not used at all, remove it as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 11 +++++------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b818872e0d19..20e4a12801cf 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -550,10 +550,10 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	s32	rtStatus = _SUCCESS;
 	u8 writeFW_retry = 0;
 	u32 fwdl_start_time;
-	struct hal_data_8188e *pHalData = &padapter->haldata;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
 	struct rt_firmware_hdr *pFwHdr = NULL;
+	u16 fw_version, fw_subversion, fw_signature;
 	u8 *pFirmwareBuf;
 	u32 FirmwareLen;
 	static int log_version;
@@ -570,14 +570,13 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	pFwHdr = (struct rt_firmware_hdr *)dvobj->firmware.szFwBuffer;
 
-	pHalData->FirmwareVersion =  le16_to_cpu(pFwHdr->Version);
-	pHalData->FirmwareSubVersion = pFwHdr->Subversion;
-	pHalData->FirmwareSignature = le16_to_cpu(pFwHdr->Signature);
+	fw_version = le16_to_cpu(pFwHdr->Version);
+	fw_subversion = pFwHdr->Subversion;
+	fw_signature = le16_to_cpu(pFwHdr->Signature);
 
 	if (!log_version++)
 		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			DRIVER_PREFIX, pHalData->FirmwareVersion,
-			pHalData->FirmwareSubVersion, pHalData->FirmwareSignature);
+			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
 
 	if (IS_FW_HEADER_EXIST(pFwHdr)) {
 		/*  Shift 32 bytes for FW header */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 8134a173ea07..9133f3b0acc1 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -162,10 +162,6 @@ struct txpowerinfo24g {
 
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
-	u16	FirmwareVersion;
-	u16	FirmwareVersionRev;
-	u16	FirmwareSubVersion;
-	u16	FirmwareSignature;
 	u8	PGMaxGroup;
 	/* current WIFI_PHY values */
 	u32	ReceiveConfig;
-- 
2.34.1

