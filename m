Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7C4816D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhL2Uw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhL2Uvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B45C061748
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w20so37583409wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SpK2HLJGDnJuDgQ781K2zoX6i9JQkfyl3XZmCFeYYQ=;
        b=Oby3zeuVClI+AWGdurc0SbJuylGLS250id1JlLd9Bw7R0WrMg59HsvY++BbTjYBC5Y
         zr7uTIqLVD218IQEX0WVnYFJqPhhqX9v4NEFdBSBJb2ehaUJvJhUsw7wQyyraUxo6FUb
         o2Te7e4LoT22CAyzh+8m0cTQxpJSXu8j8U0VepXoDJ8Zq95IRBUUkIkTu4ePRxE6T2Dq
         9cdFY7WcXdeIxToyMp2gdzoepVct6wYVr0qkxWs1E4ekZ1PVoXNCSv7+evO5IkkBP17s
         Q4AasCaDwXlVXPs9tF7671tmfaGV/7g0kfpXZXYSvoDSEAQ8W4jZHeqGpTQPyvV5UEu2
         +SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SpK2HLJGDnJuDgQ781K2zoX6i9JQkfyl3XZmCFeYYQ=;
        b=EERHsFEnksJ+IGBynV+MSMjLt2AusRdVGViUBh+/li4w2Ydis1gFSEl5UQ59yuacRQ
         6YL+OK828CTFHH/XH/9zaMfFZsooytv/buL6MAjpyrRUbnh20qol4kVmdyr8mIbUerA+
         Dubob1m0BTUAsqSfZ38jx6w6QqAdXkb8XWO6kix02NODbxEn18FJtCpMiecOHExSW91C
         5JfUKwYciE5Uect7slkl9zu+S4IhkISeWcUtaxzt+Hy1xvlFW0aj4qtVVjFu+qyJA4JH
         VABDx4a+2963vBElDw4aPXfbgGoRRw1Sl0PxjN4CH12vvPdwgTZPJq3RnU/7GqiVGvK4
         f0tw==
X-Gm-Message-State: AOAM531h7yBbrrGuFfqzOGmRPt8Ke4hLjtI6uzNHhidNij1545RN63Z4
        vz9JU/tk9dn2sBror7sswNA=
X-Google-Smtp-Source: ABdhPJybfhFP1iGZ9/vss9nbfXwXyK/c2sYYGtBhikKPTXkGA+vXK8mBF9CAmE9op72vMZpBXDTOyg==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr21749398wrt.161.1640811108647;
        Wed, 29 Dec 2021 12:51:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 31/32] staging: r8188eu: remove unnecessary comments
Date:   Wed, 29 Dec 2021 21:51:07 +0100
Message-Id: <20211229205108.26373-32-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unnecessary comments in odm.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index acdf0ba40567..5bbc47a46e8f 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-/*  include files */
-
 #include "../include/odm_precomp.h"
 
 /* avoid to warn in FreeBSD ==> To DO modify */
@@ -637,8 +635,6 @@ static void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	precvpriv->last_rx_bytes = precvpriv->rx_bytes;
 }
 
-/* 3 Export Interface */
-
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
 void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 {
@@ -696,7 +692,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case    ODM_CMNINFO_RF_ANTENNA_TYPE:
 		pDM_Odm->AntDivType = (u8)Value;
 		break;
-	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
 		break;
@@ -734,7 +729,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_POWER_SAVING:
 		pDM_Odm->pbPowerSaving = (bool *)pValue;
 		break;
-	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
 		break;
@@ -836,13 +830,6 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 	}
 }
 
-/* 3============================================================ */
-/* 3 RATR MASK */
-/* 3============================================================ */
-/* 3============================================================ */
-/* 3 Rate Adaptive */
-/* 3============================================================ */
-
 u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u8 rssi_level)
 {
 	struct sta_info *pEntry;
-- 
2.34.1

