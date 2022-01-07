Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D379E4875A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbiAGKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiAGKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A7C06118A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j6so20339026edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FEXdLRWkr8s5N8muAUD8OFsfgpGqsfzOv/whEnmPHk=;
        b=hKdUfZ+6woF+YMdbwtSPUR83LPfHHKvkCDIWATpBlka50qBT0KtKHEQU0+d8saF8ns
         Ld5lf8VKJP+toJvKXjz6u/nofokSMv/UAQ3i9nST4gFX0BnbWVaTdgbrciHZSj/a2B6S
         2FCgL8yUjRa8psVJ+ahmqHBN/TWDHRDzGH4jK0E9CT9oqMXqvOcHrhfpHXgFWDEs+nK6
         LFsldtZniBCn08+RxY8M9xe/k9zwEJIS0bNZH7kGrL5CjWIALVMUvepC+n5OoVyNTePH
         PKKfbwSrCjkou7HbvRLKUxVjb3yds9GQVs2UIuKdzdHdJ7ZN99sD2ALWBIbxWmOmkgoc
         B8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FEXdLRWkr8s5N8muAUD8OFsfgpGqsfzOv/whEnmPHk=;
        b=NhPiYpNnqXjnorLY0WXjvDtoNH2qDLfng+smb0p6Ju6rCMBwk68kKYJym17CTabIdj
         kduGYO/2U7fi7lPB97QJ+aV2wpOxnOVtGF1E16heq+7SRwdsKPEQepOPgjy423b2tede
         fGum9+5EWWohKrEseN2Kp4Kmr5JC2fDW9V4M7ojOryi76tuOVPUtl/T5uGmH/W3/r1FA
         SwSOsBPKDqTOI7RXx0c7IB9hl36+6S5i/mXGDfMuTrNJAWzc4Df6BgzobiJFaLZorLWw
         op6CRHzc8nfEzNiRurHsh+5uoD+ALFp0LYh69f0ZKFBLdYKvY0gow/p5NTKwQ4oTKEO2
         TJQw==
X-Gm-Message-State: AOAM532u0mqmHc9VBC+57r/DNSjbr1GZUFFXYt93PFxgaeLlZzXdkBQi
        4gAXlKWnnTK1ft0GExfYFEM=
X-Google-Smtp-Source: ABdhPJyu6NCY8XuNeO6fA3IbOZ5BGd3zNnHKKLMCs28tfnNbKiMJBWlf9mCRbjwLpmeh/M8qcMUtYw==
X-Received: by 2002:a17:907:386:: with SMTP id ss6mr7137507ejb.101.1641551793369;
        Fri, 07 Jan 2022 02:36:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/19] staging: r8188eu: rename parameter pFirmware of load_firmware()
Date:   Fri,  7 Jan 2022 11:36:08 +0100
Message-Id: <20220107103620.15648-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the parameter pFirmware of load_firmware() to avoid camel case.

pFirmware -> rtfw

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index bd7f3dc5878b..5c1da9dd179b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -508,7 +508,7 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	return _FAIL;
 }
 
-static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
+static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 {
 	int ret = _SUCCESS;
 	const struct firmware *fw;
@@ -530,15 +530,15 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 		goto exit;
 	}
 
-	pFirmware->szFwBuffer = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
-	if (!pFirmware->szFwBuffer) {
-		pr_err("Failed to allocate pFirmware->szFwBuffer\n");
+	rtfw->szFwBuffer = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
+	if (!rtfw->szFwBuffer) {
+		pr_err("Failed to allocate rtfw->szFwBuffer\n");
 		ret = _FAIL;
 		goto exit;
 	}
-	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
-	pFirmware->ulFwLength = fw->size;
-	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", pFirmware->ulFwLength);
+	memcpy(rtfw->szFwBuffer, fw->data, fw->size);
+	rtfw->ulFwLength = fw->size;
+	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->ulFwLength);
 
 exit:
 	release_firmware(fw);
-- 
2.34.1

