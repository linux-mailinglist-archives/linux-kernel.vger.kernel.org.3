Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CCA49F8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348284AbiA1LzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbiA1Ly5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:54:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224FAC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id j2so15133013ejk.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13iP0ysAJRd0WBFMaQVUlv7Pu203h1+BnMCWYbYB0eM=;
        b=hUY0ajqp9CexidLtdobTizYGbUTHqr+Pzq28rusK1pHK6Hnj9cIlVYSemM4JhiZUEH
         7bkRl4CGtNJSgG7wyqlRJON0rNBNZtpGvZAWp0I/vVF4tfgD+l0eeYSyI/w2/Wzny4QP
         f9l57FPZfPOAGY49L4XEfv3pTm5QuKF9dN6PMwutT933a0rBgqMa7V9ajkwYwYw9UrZc
         UWxZXrlRUPZi0nYQoQg2yVo0vxCmTHSQ9w+XUtkmp3qwcpT5A+yv1Z1jS/kk6DEHgATY
         AJGeJMkwgBDRWGefniyI1NUSztzXmC3tNDjKqqzcWhpT94h4cWXU6XKiQ/TPH4I75mMD
         JJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13iP0ysAJRd0WBFMaQVUlv7Pu203h1+BnMCWYbYB0eM=;
        b=rm9IA+66u7sbZymuSXdyKb1gOXX/u/2Jr/KRbZRa3HXgJPNLXyRdaQkSkG62mC/Yr2
         /Xx2dqSl9cJuYJfARo/vkKGMKufZQLE8oN5MvG+tGjD1gU1hQAOlX2kVMD3ZErX2tbwm
         JUELm/aAbbUsaN+VUBOK6JCQalkOZniXL/jA3o8/peQ8qbHe+SkH/i/RrDY+/o8c4E8B
         HizSWndV1I6YfkwGY/446yHY4Oe1pRtxm+KR6UwXeyNaCQHMWTPcrWJ7mGLwR4qBG4Tc
         BRLNijlyorW4OCCK/FyoPbe2vsPnGLS3yMQNcdU30KZJGucKfiETvqs5+A2GI6cdRodG
         ItYQ==
X-Gm-Message-State: AOAM531xdcek1gChbsUXXkHEJVHqUcqTsC5P2poA7t7stNFBkZgrOvz6
        9Fz25bb79uMJW5lTD2ptQII=
X-Google-Smtp-Source: ABdhPJzx05Ym8i+8QSQXqIYrnHP7zRS2uFfPyNTCJqUjWh41TBla9I6r+wGF74m4tkIK/zCsfhieFw==
X-Received: by 2002:a17:906:d551:: with SMTP id cr17mr6320553ejc.27.1643370895696;
        Fri, 28 Jan 2022 03:54:55 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id h20sm12494261eds.9.2022.01.28.03.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:54:55 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: remove unused cases from GetHalDefVar8188EUsb()
Date:   Fri, 28 Jan 2022 12:54:41 +0100
Message-Id: <20220128115445.6606-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128115445.6606-1-straube.linux@gmail.com>
References: <20220128115445.6606-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GetHalDefVar8188EUsb() is never called with HAL_DEF_DRVINFO_SZ,
HAL_DEF_RA_DECISION_RATE, HAL_DEF_RA_SGI and HAL_DEF_PT_PWR_STATUS.
Remove these cases from the function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 21 ---------------------
 drivers/staging/r8188eu/include/hal_intf.h |  4 ----
 2 files changed, 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d654d2f01c78..4bb1812f5ae7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1622,30 +1622,9 @@ u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 	case HAL_DEF_CURRENT_ANTENNA:
 		*((u8 *)pValue) = haldata->CurAntenna;
 		break;
-	case HAL_DEF_DRVINFO_SZ:
-		*((u32 *)pValue) = DRVINFO_SZ;
-		break;
 	case HAL_DEF_DBG_DM_FUNC:
 		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
 		break;
-	case HAL_DEF_RA_DECISION_RATE:
-		{
-			u8 MacID = *((u8 *)pValue);
-			*((u8 *)pValue) = ODM_RA_GetDecisionRate_8188E(&haldata->odmpriv, MacID);
-		}
-		break;
-	case HAL_DEF_RA_SGI:
-		{
-			u8 MacID = *((u8 *)pValue);
-			*((u8 *)pValue) = ODM_RA_GetShortGI_8188E(&haldata->odmpriv, MacID);
-		}
-		break;
-	case HAL_DEF_PT_PWR_STATUS:
-		{
-			u8 MacID = *((u8 *)pValue);
-			*((u8 *)pValue) = ODM_RA_GetHwPwrStatus_8188E(&haldata->odmpriv, MacID);
-		}
-		break;
 	case HW_VAR_MAX_RX_AMPDU_FACTOR:
 		*((u32 *)pValue) = MAX_AMPDU_FACTOR_64K;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 726e60fd7273..231badaa9cce 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -75,12 +75,8 @@ enum hal_def_variable {
 	HAL_DEF_UNDERCORATEDSMOOTHEDPWDB,
 	HAL_DEF_IS_SUPPORT_ANT_DIV,
 	HAL_DEF_CURRENT_ANTENNA,
-	HAL_DEF_DRVINFO_SZ,
 	HAL_DEF_DBG_DUMP_RXPKT,/* for dbg */
 	HAL_DEF_DBG_DM_FUNC,/* for dbg */
-	HAL_DEF_RA_DECISION_RATE,
-	HAL_DEF_RA_SGI,
-	HAL_DEF_PT_PWR_STATUS,
 	HW_VAR_MAX_RX_AMPDU_FACTOR,
 	HW_DEF_RA_INFO_DUMP,
 	HAL_DEF_DBG_DUMP_TXPKT,
-- 
2.34.1

