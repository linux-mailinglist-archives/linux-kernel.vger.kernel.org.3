Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0D482027
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhL3UBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbhL3UBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B20C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so52380336wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxBAyfnlWCSVSWlKHhb9lVTqDDEl0PwfIm0RriFdcEU=;
        b=Uq07Y+CTPgl4iJGQJeSFZIYDoa2RSt3SJdAULbfsVgp42Cyv8q8g6vqvM/ZFTlRw7n
         d4H3FSMmMG712eKjpyPezAQTaLsJ5AGO0wE+AADugVpVRUxp+fadg1iO55IMO/tS3ZxT
         IyJ3tSLZZBoQQPxvA59lB32KQx86vFO4RwhMUpC+hcnDRUNS+HIv5WZiYCouPm3H6H/T
         zBbwc7VFtGrlbFQifMOahI8zqj6uG33Xr8D0dRtvxBNfj0Ao7YVgXq2CRn2mXn6fyQPi
         XKmaDFbrbYiU2onGPyKXW7kem1LmuDgjiSADDA1W55G6PzLpR3Vc0oX2acYK1hrcuGT0
         qjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxBAyfnlWCSVSWlKHhb9lVTqDDEl0PwfIm0RriFdcEU=;
        b=ntD0JfMv/bTj+hbQd8sABSnix43IPsuvKfdzqrNoYHvWSaB7IeagQr5zuR2dnGFkpw
         JxL9ZpfA38oHXX/SLOaKwoSYpMFRJxSq5x99L9lVJtBlfnNyNewkOM6jVGyovNBAvKRR
         zlv1D/OHzu03knElxCnZBbNqZzjDJCF7n1XSbyVzU07aFeCe6wMVi708wWKztFZwkOKi
         5tCkKdcAy1HEySCBb5IXLiwQzlT6i28mB/W7lhciSJmyhFx6V1ZCl2VRrEBlRJ4nak83
         n/+uSQR5kBV8IXlisr+gCDjM///HpYbhEU/R9SSEhHKplfpa6RGZa7oJM07x/U0i9paV
         WBbw==
X-Gm-Message-State: AOAM532FjjtoOxC+MjC+q9tX2wr0p3pERZfNdrkoxpn/8K8ZaBC0zQCA
        SwbDn8/AQuIdb2UENMJkUMM=
X-Google-Smtp-Source: ABdhPJz25IenNzkMGCPTIHnURmA31HLCCYj5aQTJh92hGu4l72n8pLmnGsgvXOSPsSXnMTWZOyEzKQ==
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr27249908wrg.31.1640894470418;
        Thu, 30 Dec 2021 12:01:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:10 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: FwRsvdPageStartOffset is set but never used
Date:   Thu, 30 Dec 2021 21:00:59 +0100
Message-Id: <20211230200059.13406-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field FwRsvdPageStartOffset of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 3 ---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index ca24e17c369d..a491c37777df 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -440,7 +440,6 @@ void CheckFwRsvdPageContent(struct adapter *Adapter)
 /*  2009.10.15 by tynli. */
 static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 {
-	struct hal_data_8188e *haldata;
 	struct xmit_frame	*pmgntframe;
 	struct pkt_attrib	*pattrib;
 	struct xmit_priv *pxmitpriv;
@@ -461,7 +460,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 		return;
 	}
 
-	haldata = &adapt->haldata;
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
@@ -480,7 +478,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	if (PageNeed == 1)
 		PageNeed += 1;
 	PageNum += PageNeed;
-	haldata->FwRsvdPageStartOffset = PageNum;
 
 	BufIndex += PageNeed * 128;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 239d0db55639..25f3c04e81b7 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -230,8 +230,6 @@ struct hal_data_8188e {
 
 	u8	bDumpRxPkt;/* for debug */
 	u8	bDumpTxPkt;/* for debug */
-	u8	FwRsvdPageStartOffset; /* Reserve page start offset except
-					*  beacon in TxQ. */
 
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
-- 
2.34.1

