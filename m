Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939959AF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiHTSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiHTSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:00:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C22A421
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:00:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gi31so7708725ejc.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=r+EQNFTk8Lbnc1FR6eRAVAKKKC2AwPwoVIbcVgIDipA=;
        b=ePiogsx7tM5+6lHPvyQL5xQZbVhdaZ/XbkOSsMJWUO7i2PTB2b8cT87v6dzhB5PvXz
         8jsInEhB+WSiMaSNYILdiMRt3iVmHoFcaSLCUXgjPXE88MjSfdS5WpFJCsIZsadaeEJ8
         fK/f2qQJ4w5aocWCeVVeZJL4ezlEDNsiZ2xqnpyaV1lFbH0zltudD60REme+jejB2nae
         t1UqkAsqAgG0OZTP5QabkbFb7wThD+elS7945ew7sLPQJiXFwGUBhm/cA6VdKfSf3mGQ
         psOPfMN9+qvUxBnVo1B9WQeUnFYQQTeL65EM3gOEtFfK2Vdxel5X/PL4duS5Mwe9vyyQ
         pKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=r+EQNFTk8Lbnc1FR6eRAVAKKKC2AwPwoVIbcVgIDipA=;
        b=i7RZy341OoS9sDoc4viGRv744Lnwhktgb8E99Iv9evXPuJbguO6m8E5XpiqW90F7LR
         N8a+OsR6ppZ5Q2XEP1twTPzBsHEGpAh/6c9dcNvmHALIt+xdudr66eHOpan0DypvJU90
         nzvSd0raL9N9M4RRg7eurwCCsclrPBrvJv/Z6aLGTWDE+lxjH3dbrCNBtmxsc2JOto30
         wwev0S7in2e+7hc7Ry2CpHEGIXWpdbdJiU1Yw8XtlqQpG4Kd+BM9hr2ks7TdTWsnv+U+
         KUBZZa3jqKlOl1CeMlVDXKLpbJeX3Bh0/fg91kp0XXhuIcDNM/BT045TFfNl8hjJ15XH
         4lrQ==
X-Gm-Message-State: ACgBeo3LLXkPQBtMNuRDcM7CKuyoND/EmD2QT1UELrgYM3B7mDAfIM4Y
        RmGT+3qcjWOu/W+OZalNeOb5UwDAP4hvgw==
X-Google-Smtp-Source: AA6agR46PPgCrSi8GZd63cJR4dnA19+L48LoQ9Toywcs8Kmg21w/Fcx125VGseKW0jfBGsxELO9Zvg==
X-Received: by 2002:a17:907:7b8e:b0:731:4e73:89f2 with SMTP id ne14-20020a1709077b8e00b007314e7389f2mr8324152ejc.562.1661018435700;
        Sat, 20 Aug 2022 11:00:35 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d6d3000000b00445e037345csm4938841edr.14.2022.08.20.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:00:35 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     hdegoede@redhat.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com, namcaov@gmail.com
Subject: [PATCH v3 3/3] staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
Date:   Sat, 20 Aug 2022 20:00:04 +0200
Message-Id: <6f51a3531ffe60650972bd9f288570db55e3e0ec.1661018051.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661018051.git.namcaov@gmail.com>
References: <cover.1661018051.git.namcaov@gmail.com>
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
 drivers/staging/rtl8723bs/Makefile            |  1 -
 drivers/staging/rtl8723bs/hal/odm.h           |  1 -
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 19 -----------
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  | 32 -------------------
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |  1 -
 5 files changed, 54 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index 159ca1b9016b..bc7ff1dd14f9 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -33,7 +33,6 @@ r8723bs-y = \
 		hal/odm_DynamicTxPower.o \
 		hal/odm_EdcaTurboCheck.o \
 		hal/odm_HWConfig.o \
-		hal/odm_NoiseMonitor.o \
 		hal/odm_RegConfig8723B.o \
 		hal/rtl8723b_cmd.o \
 		hal/rtl8723b_dm.o \
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

