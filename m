Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E749B4875A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346708AbiAGKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiAGKgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD1FC061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o6so20493711edc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHgEc02003j/l+0ICwvAEWZC5UXs+c6EZrUwzuX4CsY=;
        b=oGrqaKS9otfm0x16F8I8+0Cg0wqIp0xrodazwvQN4Us4ucUKfio8S2LFXuRH8OAUIC
         RhPTwRlLl722XvEEPTv/NTAxnMP61nlHMP4JFYXXWwk+l6j91XdN0TCvVaU+5faUzmo9
         y293UkLLL9FZoPPpyrDs560gYGzbM9MjKp3ve9fSs4ftJJilMYj0SXRMDbfYsTPnF8mM
         smpQM8XwmKqZ7W2Z105MfMqXQ9FgrNq0vxkvmqEShH9cXVjd112Reuwercra+DKKKgCR
         /JM89uJ4AmQ9wqNaq7CbRdrcBcagiDgnjGbRDoeNFj0oWTDIlYFGWgpGNWoPIMvbYyAH
         M26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHgEc02003j/l+0ICwvAEWZC5UXs+c6EZrUwzuX4CsY=;
        b=0N8T5ub9JnyzaWZaFXKHkeBzzcUSqH+4sKd2n+EhLoKZaXo6wE5QQ2qeiWQ01Gxz8/
         NcQlMbWnngOitZ5xjuwIhewjEevk8gQucj6RPW7izcYIEFSeZSokvlYG0/5dhePP0Uz6
         w0VnRpAz8bWaXbMSoSSxmt8yTWMXgMDFfPehAbyyyFx7lPHr0++d1uKFMkZeUxonYDuE
         tEhFL5iQDR706K6XnUQnEsZ3UMwSAFxblWjvpsLsr3eAnqmGcSsKB+DsqR3Dla0kxdE3
         5bOZZNShng1xv2AvyujVT1JVR43im2muz5lBtsu+Zi42quuBCvNEerb0SygCbUU6Ochv
         2Y+Q==
X-Gm-Message-State: AOAM530sT9RvBYtRD+4chKmIXy4pQP9hWHGZSdbDfWgVZ6btQUxtrIRI
        WqjpgM9C7DiLoS9Exw8655s=
X-Google-Smtp-Source: ABdhPJxX1X+VMdJOXI03+wSMcKfArtJ/0FyESFO+jXuC52iiuB5mTIqdkF4rrhU4s89QoAhxuSjrWw==
X-Received: by 2002:a17:906:b30d:: with SMTP id n13mr4177890ejz.511.1641551794021;
        Fri, 07 Jan 2022 02:36:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/19] staging: r8188eu: rename fields of struct rt_firmware
Date:   Fri,  7 Jan 2022 11:36:09 +0100
Message-Id: <20220107103620.15648-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fields of struct rt_firmware to avoid camel case.

szFwBuffer -> data
ulFwLength -> size

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 22 +++++++++----------
 drivers/staging/r8188eu/include/drv_types.h   |  4 ++--
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5c1da9dd179b..ee684b37ff91 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -530,15 +530,15 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 		goto exit;
 	}
 
-	rtfw->szFwBuffer = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
-	if (!rtfw->szFwBuffer) {
-		pr_err("Failed to allocate rtfw->szFwBuffer\n");
+	rtfw->data = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
+	if (!rtfw->data) {
+		pr_err("Failed to allocate rtfw->data\n");
 		ret = _FAIL;
 		goto exit;
 	}
-	memcpy(rtfw->szFwBuffer, fw->data, fw->size);
-	rtfw->ulFwLength = fw->size;
-	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->ulFwLength);
+	memcpy(rtfw->data, fw->data, fw->size);
+	rtfw->size = fw->size;
+	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->size);
 
 exit:
 	release_firmware(fw);
@@ -558,17 +558,17 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	u32 FirmwareLen;
 	static int log_version;
 
-	if (!dvobj->firmware.szFwBuffer)
+	if (!dvobj->firmware.data)
 		rtStatus = load_firmware(&dvobj->firmware, device);
 	if (rtStatus == _FAIL) {
-		dvobj->firmware.szFwBuffer = NULL;
+		dvobj->firmware.data = NULL;
 		goto Exit;
 	}
-	pFirmwareBuf = dvobj->firmware.szFwBuffer;
-	FirmwareLen = dvobj->firmware.ulFwLength;
+	pFirmwareBuf = dvobj->firmware.data;
+	FirmwareLen = dvobj->firmware.size;
 
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
-	pFwHdr = (struct rt_firmware_hdr *)dvobj->firmware.szFwBuffer;
+	pFwHdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
 	fw_version = le16_to_cpu(pFwHdr->Version);
 	fw_subversion = pFwHdr->Subversion;
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 2dd5ebaaa921..388822dd325d 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -117,8 +117,8 @@ struct registry_priv {
 #define MAX_CONTINUAL_URB_ERR		4
 
 struct rt_firmware {
-	u8			*szFwBuffer;
-	u32			ulFwLength;
+	u8 *data;
+	u32 size;
 };
 
 struct dvobj_priv {
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index b65e44f97826..08d719822062 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -789,8 +789,8 @@ int netdev_close(struct net_device *pnetdev)
 
 	rtw_p2p_enable(padapter, P2P_ROLE_DISABLE);
 
-	kfree(dvobj->firmware.szFwBuffer);
-	dvobj->firmware.szFwBuffer = NULL;
+	kfree(dvobj->firmware.data);
+	dvobj->firmware.data = NULL;
 
 	DBG_88E("-88eu_drv - drv_close, bup =%d\n", padapter->bup);
 	return 0;
-- 
2.34.1

