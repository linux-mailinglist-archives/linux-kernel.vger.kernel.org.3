Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B2A4816CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhL2UwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhL2Uvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEBAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so12335637wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPXFKP24S9HYo1oAtd+5wVylGqR6XS7SREVC37I7fxg=;
        b=CzpJqn9inym1g/r0W1e7drS86koAaQJhLRUaoknTF3+ZUImya/gstwKYX5v7T+k2tF
         toCNVpzn05+/8cbFAxKkY/qODjnCovhmM6IQJ7UKY+qMHAtnrZ2dTTc3JFnQSBpiEzSw
         4w2kgVyhXZVAZU98kalCHMdpKCreZwXY6BdNpDnR3rUBQVemV2QMqwcVm1fG1MAKRTeX
         ZQs4Y0SEdtC8eIbYzcEUO5tAA/Q4fLiy8D/rInVlzd4gyBHmKHkSBzCcLc/x627bN6pX
         +iHKgekCK5gIuRXSt2OWljKJBB0UWVqHK2v5diS4yq8fpK4+n1XwToih6KUnHqt2nYg8
         r8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPXFKP24S9HYo1oAtd+5wVylGqR6XS7SREVC37I7fxg=;
        b=d3vjvpkJXvGNvIGgRVGrf8Inx7SD0XpRerdeg86vvy1ceWkBvRRg20tFnnvja++xLE
         /yX1nr4mkDrSNIqG1P+VqybhdBA98k4kQECcqzfrkYAPpfAnOg/xz0qriY8QZLh28Cfo
         RXzTvHbyqW01a7n6ITtEV1N5zBSOLD31zWzZnQ4npXDkvyaA2e63x8nvzlsnmqx7AGAk
         0sat8SFLdR1rLJLbvPhq1wldLy4wWHnIEjwHJeil1UJCaFealbiqvzlLc39IQM+Be/4R
         Js36bo0u9q0S0pg55vBA+PxiLc7PHTQr//ZWl2lBbPNrLo8kE/hueFhMt7Ha+SPNPmVO
         ZvZw==
X-Gm-Message-State: AOAM533yRN/s+XbejpTxfWLSqDLBO0yRT/jtyrTJaqTrJjgtJJfTgLDM
        zsV92ovOsXa2RevOYtAUKqA=
X-Google-Smtp-Source: ABdhPJzI3i5JfS++gGs1Zo16s0kQtSX0HirvYlpXsnGPekLyVUn8B8npRhEJIH2NoGW9I8G2NiexOA==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr23270918wmk.46.1640811101618;
        Wed, 29 Dec 2021 12:51:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:41 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 21/32] staging: r8188eu: make odm_DynamicBBPowerSavingInit() static
Date:   Wed, 29 Dec 2021 21:50:57 +0100
Message-Id: <20211229205108.26373-22-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DynamicBBPowerSavingInit() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 21 ++++++++-----------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 41e954ec4e86..d933d60a77ac 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -364,6 +364,15 @@ static void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
+static void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
+
+	pDM_PSTable->pre_rf_state = RF_MAX;
+	pDM_PSTable->cur_rf_state = RF_MAX;
+	pDM_PSTable->initialize = 0;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -599,18 +608,6 @@ void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres)
 	pDM_DigTable->CurCCK_CCAThres = CurCCK_CCAThres;
 }
 
-/* 3============================================================ */
-/* 3 BB Power Save */
-/* 3============================================================ */
-void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
-{
-	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
-
-	pDM_PSTable->pre_rf_state = RF_MAX;
-	pDM_PSTable->cur_rf_state = RF_MAX;
-	pDM_PSTable->initialize = 0;
-}
-
 void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 {
 	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index c2287d00aa60..259e0de93144 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -31,7 +31,6 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

