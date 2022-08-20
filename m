Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068E59ABCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiHTGnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbiHTGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:43:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FA12639
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dc19so12351901ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=K+ACVRr2qvbdZdGfEXZ+98M4lRWQBPuEkPQm+EeZJtg=;
        b=RN/MJth3KruMft+k48dYAhxZEs9O5v7vODTyzoqUQCsHDfmzq2p6yrUQnhmeBFCXXX
         u6ESR83dZSLHVVf3p/EubuLTlCqaSoLlPvJzNt0phGHzBm2Ha6BGaLTCh5SWmVoQhYjy
         ykEI6l+H6pUlT2DastachcsN4kcXcN+95aGlGPTE27hDnoF2GiRz3NXFWMfMpKf1zS9G
         5X5BgZDF0ceTtWvwBwO4SO0FZLAxzeRVqhSBZXPObzjQXhdirmIt4fkrINg2GhWcNrEJ
         BaW6J6IbmO/UEwT2PPXkQXz7ejq8UxdzJtzw/bfiFwCgsaddfdkMrDIQUz+IWu4U93y1
         iShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K+ACVRr2qvbdZdGfEXZ+98M4lRWQBPuEkPQm+EeZJtg=;
        b=syKXtQoveW+gLsOhWuWYkqC8tx8qFb7zjEkJXFPkhYs+W6EuQt/G3M7B/rYuhZRMk3
         ff6Ugf1/rQOM80Cu6EiMKx48uLQM3su20uOIpDp2OOu04ZTxXs6FCrSuF4BUR0r+/+Z8
         wP9L37PE4gB5yDHgkCR/tzbItT+pYViiFjkDbEQPEW72PEigdjELbwUTQR/KPbUCbsBx
         4qD266+xwUTGTZaUJflsulX2ULvEs7u7JLQjggTAKehEHYR3o0TEsi1gMPKAVG82rGol
         Qc6eRLmef5YqUobN8YoCGscHdHhyH8CEOIYZB0Ubk33ZKORjzV5gXvtk1rumrPYkmMb6
         NQEw==
X-Gm-Message-State: ACgBeo21kCf3A5jphQhRY2g83Ya/lYMytrM7jHPTsAccN7KJLQAeQ5XH
        Ow28jhbiOuScRLhMIl2Y48U=
X-Google-Smtp-Source: AA6agR7j8mzhn0ltAl7QUMevwSp8OgzgbuPbEAr0O4S4Ihi6BzQD8boGfYzXSv+MsZPcYGfXGeeDFQ==
X-Received: by 2002:a17:907:7f22:b0:73b:e53a:820d with SMTP id qf34-20020a1709077f2200b0073be53a820dmr6334613ejc.133.1660977809286;
        Fri, 19 Aug 2022 23:43:29 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm2935816ejw.198.2022.08.19.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:43:29 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 4/4] staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
Date:   Sat, 20 Aug 2022 08:42:46 +0200
Message-Id: <2e60f0f5fed9812cd7a0ba70bf8073eb25dfc43e.1660977536.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660977535.git.namcaov@gmail.com>
References: <cover.1660977535.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

because the content of these files is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h           |  1 -
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 19 -----------
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  | 32 -------------------
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |  1 -
 4 files changed, 53 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 033f22b0f394..fe9782d2d4fd 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -14,7 +14,6 @@
 #include "odm_DynamicBBPowerSaving.h"
 #include "odm_DynamicTxPower.h"
 #include "odm_CfoTracking.h"
-#include "odm_NoiseMonitor.h"
 
 #define	TP_MODE		0
 #define	RSSI_MODE		1
diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
deleted file mode 100644
index b85b323cf5bd..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include "odm_precomp.h"
-
-/*  This function is for inband noise test utility only */
-/*  To obtain the inband noise level(dbm), do the following. */
-/*  1. disable DIG and Power Saving */
-/*  2. Set initial gain = 0x1a */
-/*  3. Stop updating idle time pwer report (for driver read) */
-/* - 0x80c[25] */
-
-#define Valid_Min				-35
-#define Valid_Max			10
-#define ValidCnt				5
diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
deleted file mode 100644
index 01c5c524d4e0..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- *****************************************************************************/
-#ifndef	__ODMNOISEMONITOR_H__
-#define __ODMNOISEMONITOR_H__
-
-#define	ODM_MAX_CHANNEL_NUM					38/* 14+24 */
-struct noise_level {
-	/* u8 value_a, value_b; */
-	u8 value[MAX_RF_PATH];
-	/* s8 sval_a, sval_b; */
-	s8 sval[MAX_RF_PATH];
-
-	/* s32 noise_a = 0, noise_b = 0, sum_a = 0, sum_b = 0; */
-	/* s32 noise[ODM_RF_PATH_MAX]; */
-	s32 sum[MAX_RF_PATH];
-	/* u8 valid_cnt_a = 0, valid_cnt_b = 0, */
-	u8 valid[MAX_RF_PATH];
-	u8 valid_cnt[MAX_RF_PATH];
-
-};
-
-
-struct odm_noise_monitor {
-	s8 noise[MAX_RF_PATH];
-	s16 noise_all;
-};
-
-#endif
diff --git a/drivers/staging/rtl8723bs/hal/odm_precomp.h b/drivers/staging/rtl8723bs/hal/odm_precomp.h
index edce506022a5..2987857a8761 100644
--- a/drivers/staging/rtl8723bs/hal/odm_precomp.h
+++ b/drivers/staging/rtl8723bs/hal/odm_precomp.h
@@ -33,7 +33,6 @@
 #include "odm_DynamicBBPowerSaving.h"
 #include "odm_DynamicTxPower.h"
 #include "odm_CfoTracking.h"
-#include "odm_NoiseMonitor.h"
 #include "HalPhyRf.h"
 #include "HalPhyRf_8723B.h"/* for IQK, LCK, Power-tracking */
 #include "rtl8723b_hal.h"
-- 
2.25.1

