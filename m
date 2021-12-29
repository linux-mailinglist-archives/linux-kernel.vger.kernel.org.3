Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010D24816D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhL2Uws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhL2Uvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1603CC061792
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so46505146wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZnd6cWt7MVYERmaH5u+uHWZ+MW0YO45dvPr1gOum30=;
        b=QSxRh+0cp+AwBfATOeNjzKsu35QTIOcbXXcNyDmQEfyuJ8yKmYfI6JhHyz7+zYjqRr
         iMSLl0Mv8L1TSoSXJD96wn1mRg8YiPDFVlSAqdXmO4fmO5xKquLn63h0PQJVLhYr5a6y
         zKi3d8qAe3a9WxkPYJAOyTgo0CoM001MmhVCJBIT0yacyqK3mb2+aJeo2ao0MjJR5MRD
         aTGs1DybfAHekq1hf0xzFxFyhxH22W1mnU6lEUayw5791hrUL1qMOMMgSFUgWm9vkfq2
         0+P4ez+ZR8ay1MeZzMwU+HFxXCSrfg6MFlP8U+WydM/rSGV3MXuSZEBX4Zfmqh0d4Q4G
         UUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZnd6cWt7MVYERmaH5u+uHWZ+MW0YO45dvPr1gOum30=;
        b=qP9Hz9JpKgErnbHGRF3j/TN+3K1ft1X37wm5cvOtp8JCWB1OrOh9cdS7mbp4t4D4NR
         2q15QnuT1e02NU4lxpH1/yISX601/RSrNoJCO6SRuQAbjIxuKIJVvYhATwmFyOpi5XtS
         2JxEW8s/AP0OlDspJ4+eZjILobQPBDkAthFCHMOxX+evuCvKkI6/gidZu8yMEWWkPz5i
         zQ/vVt4PJTEYoV73sBQtUThwWIr4XtzODTCCiy7IcccCrNBTycfidwiwsAHbIHBqq7LD
         POw6NBRjIlsoNSSpXEukOKnVE4Bz+XRV9h+EMRRnxYrFTKnkc9ubmJ29rbjKUXF90lia
         WARg==
X-Gm-Message-State: AOAM532n1mCn4B70shHmwPs/LUTRobKUinRAlQnJvUpGei25qFRhfIdJ
        FiMqKKJI20vdGvpUDaGbKvg=
X-Google-Smtp-Source: ABdhPJx4jw+xVZACcogiHz33fvceG5A+HwGrMEZpeJxhPDE7ulIBOR9rFGATRc2ALNW9lEhTQvQymw==
X-Received: by 2002:a5d:64cc:: with SMTP id f12mr22130708wri.145.1640811105727;
        Wed, 29 Dec 2021 12:51:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:45 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 27/32] staging: r8188eu: make odm_InitHybridAntDiv() static
Date:   Wed, 29 Dec 2021 21:51:03 +0100
Message-Id: <20211229205108.26373-28-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_InitHybridAntDiv() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 16 ++++++++--------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index fc402824bed0..e067e46ccf64 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -536,6 +536,14 @@ static void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
 }
 
+static void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
+		return;
+
+	ODM_AntennaDiversityInit_88E(pDM_Odm);
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -851,14 +859,6 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
-void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
-{
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
-		return;
-
-	ODM_AntennaDiversityInit_88E(pDM_Odm);
-}
-
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
 {
 	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 7150228dc8d7..c3fce8b91a5a 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -33,7 +33,6 @@
 
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_PRECOMP_H__ */
-- 
2.34.1

