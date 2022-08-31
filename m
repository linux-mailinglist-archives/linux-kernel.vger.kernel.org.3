Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180175A75C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiHaFhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiHaFgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:36:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4BAB1B4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:36:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so5324599ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NOfWrLgk4XJRp02V6wb7t4ERG9KLrIB6EWwKvEYmHTY=;
        b=q3vo1pdqO4MDUp085vbr/x74o8yV1M3oVtMKQW32IH8QET4vp46nOdZFsgZYnlE4Eq
         DFUR8Mr0ujsg3pohQ9bHyeyxshmDK2QOG9zRxpVIS8cpmnUo9RHxE8AWKb2OV/OGQRuf
         YpStHVKowJWICs+AI/mEEpZY5KL4ucAVNow7choyKjB/iXJWjDW2x5v3gcC29WHLepXd
         YnGrNJz3MU7kkYV0aqw3+HrLsiRyRJNa8pv9pF5Z+ObNZWwWCN93zTqRDnrkfaBeSYub
         2hlsR2Slqzv16wC7abn0/wNoJuzjbLtUalTkSgiZoIEKVxCJcscNYwb6FMmlUaHg7DTo
         lZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NOfWrLgk4XJRp02V6wb7t4ERG9KLrIB6EWwKvEYmHTY=;
        b=pqOu43fn9JN4rJi972xTAk34wmESsEoCpQ/AOrleIJC3CEouwVkWkSiM906UcuKNfG
         ET/pxBJtHiaRNhGhGUllZrT8UGIWCiyjLlsC6vofcQH/sHu0P2iFCaijqPdEmd9TgV+Y
         kSwPpy2ecgEazYXeEFQoyEqhw4G/VZMH1Y9Besc/56ZwxazsgOkUCywfl1xBkgsXnZz6
         aTf6MFi8Ag4obvl+VE1QR1fCJG3IOtyiBUvhsia0dQNFv85psv5vurw8eVfpSyYsMnIM
         FzgA+yz+AEwDX28735IXk4nIIxFHaqoZvXkS5umGCi+Cv/2R5cpsIG2Iyxxn1/iIPxIe
         WI6g==
X-Gm-Message-State: ACgBeo2XAzsOaxGcu9PauCQrp8SzYU2ep7LaRvmoUb4xoOCRIbaUtMN6
        eAragjgNVIe6g9B/ONalclg=
X-Google-Smtp-Source: AA6agR4yPeXKBgBg73i/NeASyese1jidXLXvrRg8eV8eAKCsgMOWDQpIFf5czudGRXrYTShs23uDiQ==
X-Received: by 2002:a17:907:2cef:b0:741:4fbf:4628 with SMTP id hz15-20020a1709072cef00b007414fbf4628mr11490511ejc.334.1661924212448;
        Tue, 30 Aug 2022 22:36:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb89.dynamic.kabel-deutschland.de. [95.90.187.137])
        by smtp.gmail.com with ESMTPSA id gh21-20020a1709073c1500b0073a644ef803sm6610135ejc.101.2022.08.30.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 22:36:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove os_dep/mlme_linux.c
Date:   Wed, 31 Aug 2022 07:36:39 +0200
Message-Id: <20220831053639.8559-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831053639.8559-1-straube.linux@gmail.com>
References: <20220831053639.8559-1-straube.linux@gmail.com>
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

The function rtw_init_mlme_timer() is only used in core/rtw_mlme.c.
Move rtw_init_mlme_timer(), including the static functions it calls,
to core/rtw_mlme.c and make it static. Remove the now empty file
os_dep/mlme_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile             |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c      | 31 ++++++++++++++++
 drivers/staging/r8188eu/include/mlme_osdep.h |  2 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c  | 39 --------------------
 4 files changed, 31 insertions(+), 42 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index afafe6957155..f5091a3ed4d2 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -22,7 +22,6 @@ r8188eu-y = \
 		hal/usb_halinit.o \
 		hal/usb_ops_linux.o \
 		os_dep/ioctl_linux.o \
-		os_dep/mlme_linux.o \
 		os_dep/os_intfs.o \
 		os_dep/osdep_service.o \
 		os_dep/usb_intf.o \
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index bb317ba4bcd5..8f21d34a317f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -189,6 +189,37 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 	return ie + 8;
 }
 
+static void rtw_join_timeout_handler(struct timer_list *t)
+{
+	struct adapter *adapter = from_timer(adapter, t, mlmepriv.assoc_timer);
+
+	_rtw_join_timeout_handler(adapter);
+}
+
+static void _rtw_scan_timeout_handler(struct timer_list *t)
+{
+	struct adapter *adapter = from_timer(adapter, t, mlmepriv.scan_to_timer);
+
+	rtw_scan_timeout_handler(adapter);
+}
+
+static void _dynamic_check_timer_handlder(struct timer_list *t)
+{
+	struct adapter *adapter = from_timer(adapter, t, mlmepriv.dynamic_chk_timer);
+
+	rtw_dynamic_check_timer_handlder(adapter);
+	_set_timer(&adapter->mlmepriv.dynamic_chk_timer, 2000);
+}
+
+static void rtw_init_mlme_timer(struct adapter *padapter)
+{
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+
+	timer_setup(&pmlmepriv->assoc_timer, rtw_join_timeout_handler, 0);
+	timer_setup(&pmlmepriv->scan_to_timer, _rtw_scan_timeout_handler, 0);
+	timer_setup(&pmlmepriv->dynamic_chk_timer, _dynamic_check_timer_handlder, 0);
+}
+
 int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv) */
 {
 	int	i;
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
index d5e367e2d0de..1fa66c5e3c9c 100644
--- a/drivers/staging/r8188eu/include/mlme_osdep.h
+++ b/drivers/staging/r8188eu/include/mlme_osdep.h
@@ -7,8 +7,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-void rtw_init_mlme_timer(struct adapter *padapter);
-
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 
 #endif	/* _MLME_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
deleted file mode 100644
index 2f8f866d5362..000000000000
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
-
-#define _MLME_OSDEP_C_
-
-#include "../include/osdep_service.h"
-#include "../include/drv_types.h"
-#include "../include/mlme_osdep.h"
-
-static void rtw_join_timeout_handler(struct timer_list *t)
-{
-	struct adapter *adapter = from_timer(adapter, t, mlmepriv.assoc_timer);
-
-	_rtw_join_timeout_handler(adapter);
-}
-
-static void _rtw_scan_timeout_handler(struct timer_list *t)
-{
-	struct adapter *adapter = from_timer(adapter, t, mlmepriv.scan_to_timer);
-
-	rtw_scan_timeout_handler(adapter);
-}
-
-static void _dynamic_check_timer_handlder(struct timer_list *t)
-{
-	struct adapter *adapter = from_timer(adapter, t, mlmepriv.dynamic_chk_timer);
-
-	rtw_dynamic_check_timer_handlder(adapter);
-	_set_timer(&adapter->mlmepriv.dynamic_chk_timer, 2000);
-}
-
-void rtw_init_mlme_timer(struct adapter *padapter)
-{
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	timer_setup(&pmlmepriv->assoc_timer, rtw_join_timeout_handler, 0);
-	timer_setup(&pmlmepriv->scan_to_timer, _rtw_scan_timeout_handler, 0);
-	timer_setup(&pmlmepriv->dynamic_chk_timer, _dynamic_check_timer_handlder, 0);
-}
-- 
2.37.2

