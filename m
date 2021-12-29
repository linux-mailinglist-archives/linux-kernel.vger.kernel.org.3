Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B534816DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhL2UxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhL2Uv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF2C061759
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t26so46572331wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtuTEcJ0O+3l4dsLwUQ92Rx3EFSEt1INwm4Q9JjwcDA=;
        b=Mxo3+2n46ieZfKOIVeLg7aIaLKyS308BvQRpvjufpVoqvuLzjn51VHQMcmS70V1Srs
         v2HdOf1bTp5/AUrGftpT/seWXRHrzTQfgjBrfBHfM0kfc+F28adzXOTTCeH2wD+giANw
         mxrHK+0MaQGA4Pg7i7xu/6Oy7NrWqqqMDquULjiO5UTj5il1eHRkPCzPBr8OUYv5NxTZ
         F89c+eidkhGH+GA6juyz/WzZ7rCLUYIrIV6LyvRSPf4HPI8noeg6zxVEjVfxKpwSy8qp
         ZW7m/oVftKNYUwAx2Z+e6VBXwkk/Qh6/uAtgIBf/Tr+LF/+XzZior8KThh/gCS80Qh6h
         14+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtuTEcJ0O+3l4dsLwUQ92Rx3EFSEt1INwm4Q9JjwcDA=;
        b=NQ/2DfWWJtLoKQ30zR3v5Tkr/mwjDdpObXzRQc7MsCp6HoqNN0dVpY2R24rWYSMz8X
         cfU5gRPyHOywl0eTPLwHpPLISOzSrJluUHz6oSDyTtR5M0erakCjSdeKUOswYzoH105h
         jcE0f/hlUW5ASX80pZE0x9wQiq3Cl1z69K8P9jbpZq7EHkH9soM6r33lkglxBglX1AGs
         IAJcy7n8fPmbrFjl5hlDseqhikc6xQ1fBy0DLDRSEGIEuvICs9dPeEisx20wXau/ocBE
         4EHiStHKvWMcKZD5L1Kqt2Gj5XK0bghbAbgt3bnatC2Ixgz3BUWyJ8HM3nrvEkOicfJF
         lu5g==
X-Gm-Message-State: AOAM531SAfuTJ+yVQUNrxiURY1LeSTjaiFNVcgN4LRrRIBjuTEzZjCmR
        DgrHsCeB6oACfAftzvP3gI8=
X-Google-Smtp-Source: ABdhPJwWsMIL9MNWFLu0YyYn36GfkFHr7zX8S+47EvrhoyqCJc6+wHsP7WqurrZWPy51PfWX015gDA==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr22269926wrs.219.1640811109297;
        Wed, 29 Dec 2021 12:51:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 32/32] staging: r8188eu: remove header odm_precomp.h
Date:   Wed, 29 Dec 2021 21:51:08 +0100
Message-Id: <20211229205108.26373-33-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After previous cleanups the header odm_precomp.h only contains
includes and one unused define now. Remove the header and adjust
the includes in affected files.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        | 17 ++--------
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  1 -
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  1 -
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  1 -
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  2 +-
 drivers/staging/r8188eu/hal/odm.c             |  2 +-
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  2 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  2 +-
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  2 +-
 drivers/staging/r8188eu/hal/odm_debug.c       |  2 +-
 drivers/staging/r8188eu/include/odm_precomp.h | 34 -------------------
 .../staging/r8188eu/include/rtl8188e_hal.h    | 11 +++++-
 12 files changed, 18 insertions(+), 59 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_precomp.h

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index dd5d7dcce716..57e8f5573846 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -1,20 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) Realtek Semiconductor Corp.
-Module Name:
-	RateAdaptive.c
+/* Copyright (c) Realtek Semiconductor Corp. */
 
-Abstract:
-	Implement Rate Adaptive functions for common operations.
-
-Major Change History:
-	When       Who               What
-	---------- ---------------   -------------------------------
-	2011-08-12 Page            Create.
-
---*/
-#include "../include/odm_precomp.h"
-
-/*  Rate adaptive parameters */
+#include "../include/drv_types.h"
 
 static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE + 1] = {
 		{5, 4, 3, 2, 0, 3},      /* 92 , idx = 0 */
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index f6e4243e0c7b..e7f834b02567 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
 #include "../include/rtw_iol.h"
 
 #define read_next_pair(array, v1, v2, i)		\
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index b4c55863d3fb..20ce1571fc26 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
 #include "../include/rtw_iol.h"
 
 static bool Checkcondition(const u32  condition, const u32  hex)
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 5e0a96200078..9dc888a66d09 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
 #include "../include/rtw_iol.h"
 
 static bool CheckCondition(const u32  Condition, const u32  Hex)
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 04e24beb0488..21ecc90a558c 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
+#include "../include/drv_types.h"
 
 /*---------------------------Define Local Constant---------------------------*/
 /*  2010/04/25 MH Define the max tx power tracking tx agc power. */
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 5bbc47a46e8f..4ec377f1b90c 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
+#include "../include/drv_types.h"
 
 /* avoid to warn in FreeBSD ==> To DO modify */
 static u32 EDCAParam[HT_IOT_PEER_MAX][3] = {
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 7509e3c3f418..d5212a166dd2 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
+#include "../include/drv_types.h"
 
 #define READ_AND_CONFIG     READ_AND_CONFIG_MP
 
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 69babcd7bf87..c8a3c521bd60 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
+#include "../include/drv_types.h"
 
 static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 {
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index a74c05cd97b0..5fb5a88314ed 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
+#include "../include/drv_types.h"
 
 static void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 				  u32 Data, enum rf_radio_path RF_PATH,
diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
index 7029ec4f771e..7a134229fe39 100644
--- a/drivers/staging/r8188eu/hal/odm_debug.c
+++ b/drivers/staging/r8188eu/hal/odm_debug.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/odm_precomp.h"
+#include "../include/rtw_debug.h"
 
 u32 GlobalDebugLevel;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
deleted file mode 100644
index 994f5c883979..000000000000
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
-
-#ifndef	__ODM_PRECOMP_H__
-#define __ODM_PRECOMP_H__
-
-#include "odm_types.h"
-
-#define		TEST_FALG___		1
-
-/* 2 Config Flags and Structs - defined by each ODM Type */
-
-#include "osdep_service.h"
-#include "drv_types.h"
-#include "hal_intf.h"
-
-/* 2 OutSrc Header Files */
-
-#include "odm.h"
-#include "odm_HWConfig.h"
-#include "odm_RegDefine11N.h"
-
-#include "HalPhyRf_8188e.h"/* for IQK,LCK,Power-tracking */
-#include "Hal8188ERateAdaptive.h"/* for  RA,Power training */
-#include "rtl8188e_hal.h"
-
-#include "HalHWImg8188E_MAC.h"
-#include "HalHWImg8188E_RF.h"
-#include "HalHWImg8188E_BB.h"
-
-#include "odm_RegConfig8188E.h"
-#include "odm_RTL8188E.h"
-
-#endif	/*  __ODM_PRECOMP_H__ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 9bfa255f1679..b42af86555cd 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -14,8 +14,17 @@
 #include "rtl8188e_xmit.h"
 #include "rtl8188e_cmd.h"
 #include "rtw_efuse.h"
-#include "odm_precomp.h"
+#include "odm_types.h"
 #include "odm.h"
+#include "odm_HWConfig.h"
+#include "odm_RegDefine11N.h"
+#include "HalPhyRf_8188e.h"
+#include "Hal8188ERateAdaptive.h"
+#include "HalHWImg8188E_MAC.h"
+#include "HalHWImg8188E_RF.h"
+#include "HalHWImg8188E_BB.h"
+#include "odm_RegConfig8188E.h"
+#include "odm_RTL8188E.h"
 
 /* 		RTL8188E Power Configuration CMDs for USB/SDIO interfaces */
 #define Rtl8188E_NIC_PWR_ON_FLOW		rtl8188E_power_on_flow
-- 
2.34.1

