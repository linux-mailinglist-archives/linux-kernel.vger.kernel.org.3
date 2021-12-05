Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F034468C5B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhLERSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbhLERSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10850C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so33197113edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gAS0cKvETcknOrMPrbKidw5V5Godx+Ja70TOG5Jm99M=;
        b=fxCle58pxpV2zm/+RE28LYJnZCZ5yC6PHbV+CzS9CsQPaDDC4Pwsfb12ENDRquN4y/
         vYzTHtHREonL/Bzkm4ze7Z1dOhEnpAA7TljKoWF9oRbgpWIsQVt9kGT1xfO+fytOntHb
         fk5/ix3f4I/1n5RWcahiqmCATDDTie3uDi37MGvUPIBSoq7qpN3iMdm6cPWivxRnzxFa
         oZuRsP9el/KGf6k75ccDBDA8WlbhYcYuVsYaTl3IXRbbWCDG89HnycONIvrtmUvYDk90
         ajd/G//Q01unrXAnR45lcW6ruqUnYvqmj4kWzPXiEEq1pfab6+544jyqdjETnQi8FESG
         zWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAS0cKvETcknOrMPrbKidw5V5Godx+Ja70TOG5Jm99M=;
        b=vIwsoDJraWXxgKPTQ4FKfx++fSfQGV9fh9BHZF664Al8uDTbzYwN/fgmaVD3/SqEjy
         piX4bAsUUW/APiSpPOGDoZc+pw3tMvqsTmHgcdCYc5Rhzhw51NqsjYktsB+l4/ofNd/E
         ua+H6/U9Xi0aIs/JFGz9RiKQx0A1bFV8NM5sAMiJ9NXtGoKCHCcH2y8I34g+5kNGVDcs
         kBPJXa8Ko43MyVdt4toFDi+Y3Q+sgjqT9A7+iHfuOamMBmWvPTGGhjnD/yt9v9cmz1GX
         Pu8mePoyS7aZdBZH74ov0tbYDns46OhZ91fxkTiMlF2V7PvE7rJ9UXv6Ih48HULnRU8y
         10fw==
X-Gm-Message-State: AOAM532SoviFo2WCOIUiga77w+OQv4VaEQJrOL11pHgqvET0lEz/DQ45
        MUYCxO/Si4yJ+oPOGSUB+iQ=
X-Google-Smtp-Source: ABdhPJymbhdBxLudvXRx7IH7AxhbaCXN5L8R76uEvozYMXtDDh5gX9zO2Gxc5nuPHQzf2hiG6uEesw==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr46837090edd.347.1638724479726;
        Sun, 05 Dec 2021 09:14:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 09/10] staging: r8188eu: bWIFI_Display is set but never used
Date:   Sun,  5 Dec 2021 18:13:41 +0100
Message-Id: <20211205171342.20551-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bWIFI_Display in odm_dm_struct is set but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h      | 1 -
 drivers/staging/r8188eu/include/odm.h           | 2 --
 4 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index b1cebdfb7d88..5629556cca8a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -260,9 +260,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	case	ODM_CMNINFO_ABILITY:
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
-	case	ODM_CMNINFO_WIFI_DISPLAY:
-		pDM_Odm->bWIFI_Display = (bool)Value;
-		break;
 	case	ODM_CMNINFO_LINK:
 		pDM_Odm->bLinked = (bool)Value;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index ed54da84e40b..5791172fa5c4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -874,9 +874,6 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
 		       }
 		}
 		break;
-	case HAL_ODM_WIFI_DISPLAY_STATE:
-			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DISPLAY, bSet);
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3383570c2bf3..7de35fde15a9 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -96,7 +96,6 @@ enum hal_def_variable {
 
 enum hal_odm_variable {
 	HAL_ODM_STA_INFO,
-	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index d6c10ac2b8a8..69faf8b50996 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -230,7 +230,6 @@ enum odm_common_info_def {
 /*  POINTER REFERENCE----------- */
 
 /* CALL BY VALUE------------- */
-	ODM_CMNINFO_WIFI_DISPLAY,
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
 	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
@@ -479,7 +478,6 @@ struct odm_dm_struct {
 /*  POINTER REFERENCE----------- */
 	/*  */
 /* CALL BY VALUE------------- */
-	bool	bWIFI_Display;
 	bool	bLinked;
 	u8	RSSI_Min;
 	bool	bIsMPChip;
-- 
2.34.1

