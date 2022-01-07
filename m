Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38B6487E88
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiAGVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiAGVuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 2-20020a05600c02c200b003470f96e778so3464478wmn.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glZSs3/XQjh2G5N2vOEcA3loKxbe1iN/kPhaUdhhepE=;
        b=FpkEuMCiVrVw/qTmkq7S9bVqRFluFqbxYVpA1Fv+6ULpGh4G9ltPAXwZ2XVO1iVQBs
         7f9YUcYKhao5+mGKvJcQLS4uz9kuHPMqfne/IruQRBqEuIW/XbfQKrqYk+QESrqGK0Nb
         ozO7+nLJ5C9zthvIIvC+LoyN7CB6mGbzsbl2DrcNJWyUhBQJcFgTsbhmxgcY6hStxEBn
         DzOw0pwSJMhisyiHFtV4gdRFqkay1HD/m93ws+esjyvq8IcfqnpiHj9tHU1acmoYF3VC
         TkPHU83L8dFI9g3kyQHd8pZOPf8aqML12wnuDS5GRb6TUOybzdtsZYfZLnZ9JOXtbKEJ
         Cypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glZSs3/XQjh2G5N2vOEcA3loKxbe1iN/kPhaUdhhepE=;
        b=7NM2TKpEmR3+Lfb1D5O+ceWsPvyt/m+bNQnd5qB+PQBrNlTtLaq0F2ZV+xzC+cgGT+
         SQVVR6sj78vDr7TcsQL+nvj1WNp6Ydjh6h86IK9Ikk0m+2Vj3KjTDD8Gv/J+FECL1EpE
         5EzwAmcs/je8M1GzWaQvZCcpUyd3nQfyMvyv1sy/ydg0vK+EJXVzz6PAGdbwErd7nHXg
         RJ6HKjJCgkG/D+Ts/VCl1sN4SDnQMkY9kO2ycY8EPXK9UP69O5t+YNsNCuRo0fk/GSh7
         jYAB4HjeGsgYiuxdSCIec1JIO7FmZWTdnv+RpIu2DdOh+KvHRs5WSqgbmw+snnCUP0R0
         nogw==
X-Gm-Message-State: AOAM531bF28NUL7CNrNl86h2Q9PYXRwLPK+uxL80a7MMiubANW6Z0vc1
        a6SH87M/VvMEHoisvo17H3s=
X-Google-Smtp-Source: ABdhPJwbmU13t91Q13fFOFQMLhIVJBHeIBsNTuRJcjq/K+2diA588Q73rPnr2G7JNlF5+ROUjT4TaQ==
X-Received: by 2002:a05:600c:34c4:: with SMTP id d4mr12713689wmq.53.1641592250663;
        Fri, 07 Jan 2022 13:50:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: remove HW_VAR_APFM_ON_MAC
Date:   Fri,  7 Jan 2022 22:50:33 +0100
Message-Id: <20220107215033.12257-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215033.12257-1-straube.linux@gmail.com>
References: <20220107215033.12257-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SetHwReg8188EU() and GetHwReg8188EU() are never called with
HW_VAR_APFM_ON_MAC. Remove that case from both functions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 7 -------
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 10e40e654775..91610e2adae2 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1556,10 +1556,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_APFM_ON_MAC:
-		haldata->bMacPwrCtrlOn = *val;
-		DBG_88E("%s: bMacPwrCtrlOn=%d\n", __func__, haldata->bMacPwrCtrlOn);
-		break;
 	case HW_VAR_TX_RPT_MAX_MACID:
 		{
 			u8 maxMacid = *val;
@@ -1611,9 +1607,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_APFM_ON_MAC:
-		*val = haldata->bMacPwrCtrlOn;
-		break;
 	case HW_VAR_CHK_HI_QUEUE_EMPTY:
 		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0) ? true : false;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index a86cb376a125..120b32994e1f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -62,8 +62,6 @@ enum hw_variables {
 	HW_VAR_EFUSE_BT_USAGE,
 	HW_VAR_EFUSE_BT_BYTES,
 	HW_VAR_FIFO_CLEARN_UP,
-	HW_VAR_APFM_ON_MAC, /* Auto FSM to Turn On, include clock, isolation,
-			     * power control for MAC only */
 	/*  The valid upper nav range for the HW updating, if the true value is
 	 *  larger than the upper range, the HW won't update it. */
 	/*  Unit in microsecond. 0 means disable this function. */
-- 
2.34.1

