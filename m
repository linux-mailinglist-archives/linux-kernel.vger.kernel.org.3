Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EF34816D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhL2Uwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhL2Uvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB999C061785
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so46601525wrd.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBcF53XoTwOshk3YrZwbKbN/UyVDJ23qlHTXxkU+SnU=;
        b=e/aonn1BxuMfd3aCITdHkFbqGTt2Qy74p9EyGH/oCB9D15PGcF2PczDq3ZJn7/N2Ah
         XYy4iEuF9+AIDb6tKayJUQ+Fv7PdVUHjHnPh7B/UKzY9QvdlB49oiZ675A/yNf1x+kw0
         52O1pqUyx/DKFc17tl2v1DKJjpLMpAIi2bDaxuU056DteU5daBVuGK3rd4ax45M0szkR
         iXVZ8nVwdEtjotSSc615VBidZs9EPq9kO6Yp7QXA5sPR3mqrvFt7Yff2djicwumPacqD
         nDqek+DEWnqjTF75nk8QS1b74D/7QchCTht1PJqC9Lct/NulKf90ql72VR4rn627YTn0
         HDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBcF53XoTwOshk3YrZwbKbN/UyVDJ23qlHTXxkU+SnU=;
        b=dFDtvGjELxJCenK59UhfTqu6aaQ8RwZqNP1QS1htuxpupLML9ikfL2BFB/QV5V4ppm
         LTQlb4aqLPyPIAtRPO8CobdNwncwsWOXK0kv4zhVnKSGTFoeAB/ai42M6ELYKeYR0Ws3
         i1XsW+1AM7E5KSmfpB3EcYI5pwC2pvE6gLRCOF+Resra2aV5jxg13lAU+eVpRolgyyEC
         RE56qSDjpMydMwBI39we+tlafCD717rV5FgygPzWOU5KIxhZsmin+1gKmztnVpOyc2fB
         2BpXxImvd53W8/o8PayvsOqs8lCGfmbihwKo57k5KAWtnJCgDnCGJaMe5vCjnVj3Yw9d
         igxA==
X-Gm-Message-State: AOAM533zDP/VECUOwzdhE20OYH9rBrO108E6Grv8HXXHqDN/ib0BjwEz
        9FOiEf+HTIKIB484VuPdCIc=
X-Google-Smtp-Source: ABdhPJxf0uiAx9Dgqb9+3Jn2xkcZDan6uqG/GZbfJ2RYKg7h+OfFVAjyk0y8cSkjTlkrZSZwqwvBug==
X-Received: by 2002:adf:aa9a:: with SMTP id h26mr21712625wrc.437.1640811106429;
        Wed, 29 Dec 2021 12:51:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 28/32] staging: r8188eu: make odm_HwAntDiv() static
Date:   Wed, 29 Dec 2021 21:51:04 +0100
Message-Id: <20211229205108.26373-29-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_HwAntDiv() is only used in odm.c. Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 16 ++++++++--------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index e067e46ccf64..14020a3e67d4 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -544,6 +544,14 @@ static void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
 	ODM_AntennaDiversityInit_88E(pDM_Odm);
 }
 
+static void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
+		return;
+
+	ODM_AntennaDiversity_88E(pDM_Odm);
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -859,14 +867,6 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
-void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
-{
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
-		return;
-
-	ODM_AntennaDiversity_88E(pDM_Odm);
-}
-
 /* EDCA Turbo */
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
 {
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index c3fce8b91a5a..fdd0e2355c69 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -33,6 +33,5 @@
 
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_PRECOMP_H__ */
-- 
2.34.1

