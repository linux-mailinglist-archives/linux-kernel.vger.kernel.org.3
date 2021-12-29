Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895184816C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhL2Uv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhL2Uvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso12313405wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOhkadV2itJwAv/GvEQUKWrwh58wZeAOeButqgCJq9Y=;
        b=c49B6FA8VAaPILfJ8AynON0+ZbjnNhMHkQwrHOFum9aCyp6lBmOLjsjrQmyqMFV+t2
         5cGAlcEghP0gZlGFzs90SbxJcCiLuxgZac7kp0KC5xGmKwG+sA6eNumelSXHdSSC9/rM
         m3WwoqG5WHBm5a8mo4crPKNMnXh9+6RvK6l2xjfzAfGMvvOl/CcJ3Pk/z6/9/QuD4FRA
         xZuxz955Q9Nb37O59cKT5Feovm4ESgPG5796oe+Ot2DqlSYhRZOTcElNwCNlL6xCxFow
         e/oSkQbvXeUUodWaJKYqSTUsf1XgMwBbF+rxNHoSMwLkuUjCYj9ICOhyOcjtiDzr90SF
         9dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOhkadV2itJwAv/GvEQUKWrwh58wZeAOeButqgCJq9Y=;
        b=GmtbtQ7gcO3oudcOo5UsUfN+k4vX4X4V4RIBEbqln6DCYyevDkqVrdvy+da4Y6SCCP
         af8MFhkm+BEnSMNVhW8o/bhU6V6x4Ph5EodZgzeOklabaOi3Z8pH+s9swtsWCDE9xuuJ
         lWKPCNXeYf1Fm9x+SaQCsFi/xYx2Qwjl1TE0BwIPrQbFPSTToCOly9JVSwYxil+7oIBM
         GaMXmXrRHh7xlS2k47VtwPqQg5/USJdA1tS1MBlLByzg/RMaPNKaGzcup/N9xfQ1JA8V
         2qq0rG2CnXrIDQhI7OH8E6gjXIDTCcpsYCF5lDqzbpmMDLdFERTi3R2/cPWs7g3lF47Y
         6mfQ==
X-Gm-Message-State: AOAM5317qRCn6lKsT8/I4SDzJjaV7Qbvznm0rytBeCyaX98H+r0srG13
        LQAx7GOv8EEp8aU+GEGIjwo=
X-Google-Smtp-Source: ABdhPJxt+fgvQCT/26rtHFS8bWw32/PoNWSnjBgMOF7+QXZND6MlMKkARfKgDfQy/emWLHr04koofQ==
X-Received: by 2002:a05:600c:4e11:: with SMTP id b17mr22973958wmq.66.1640811095717;
        Wed, 29 Dec 2021 12:51:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/32] staging: r8188eu: make odm_ConfigRFReg_8188E() static
Date:   Wed, 29 Dec 2021 21:50:49 +0100
Message-Id: <20211229205108.26373-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_ConfigRFReg_8188E() is only used in odm_RegConfig8188E.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c     | 6 +++---
 drivers/staging/r8188eu/include/odm_RegConfig8188E.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 3f1e30eb1a15..a74c05cd97b0 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -3,9 +3,9 @@
 
 #include "../include/odm_precomp.h"
 
-void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-			   u32 Data, enum rf_radio_path RF_PATH,
-			   u32 RegAddr)
+static void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+				  u32 Data, enum rf_radio_path RF_PATH,
+				  u32 RegAddr)
 {
 	if (Addr == 0xffe) {
 		msleep(50);
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
index 634454bffdb6..683fa4a07956 100644
--- a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
@@ -4,9 +4,6 @@
 #ifndef __INC_ODM_REGCONFIG_H_8188E
 #define __INC_ODM_REGCONFIG_H_8188E
 
-void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data,
-			   enum rf_radio_path  RF_PATH, u32 RegAddr);
-
 void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm,
 			       u32 Addr, u32 Data);
 
-- 
2.34.1

