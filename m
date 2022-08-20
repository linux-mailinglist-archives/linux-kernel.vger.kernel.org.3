Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2553A59AF80
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiHTSRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiHTSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BC32045
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id vw19so591538ejb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SbZ9ZiVxuyeACf4/KqL5PgbBvR4jJU1zgm/G5ZPWing=;
        b=k2SFSmlGb4Finqn18OACg0OgpCeHrtiKtr0sIFWR6F9V1/JkcXGuj6sGu+4u6caqhb
         N2+iWA18A31VnI4JiVHlKBbKJ8W7Md8NV6X0RfCQd52r2+WEQAJOxhqk0wF5huoBapZ2
         e1UpWqKdNx/me3xuafvgCmfs5ntExFGUzrxKANKlwQgC/gzTkXZfLVfblSZTRQQDg+0x
         rLPM7KFT4RoKoD+JKtCxmq3aGcHmGYgiZkrIUcAKe3T7jGTmud4ZoARyrspsre15i7qu
         yUvDshMXKUl9UcMONiMrdptH1LZy0RNFhCF3f4QaNa7xvbr0IUF88TbYsBufF2+jbJxr
         fWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SbZ9ZiVxuyeACf4/KqL5PgbBvR4jJU1zgm/G5ZPWing=;
        b=dNtuel3s6Xdq6Va03GNDrREn4QdGOY22S7IlAfpnMsbWXdEk0In+N/UWhJGKJ4kkEG
         3fVD5Jh3/fwzx+PtsN4/NKEhR4fsFqN9Y4P3qP+hZCQ0a2BuECed2dZrvNq+OsF9NRpt
         S+Dr8W0WiJGWVvjo8lhbornaL94GdLHSo2TpMcv1kp1cefEuNSqNGmonqrU3z3Gu7bEi
         UC4TyaJWtlW7zHUtl+GaZnJam05nwm6Q1k5VYRT7MS52X1XwyhNzG60Zp/tAd164Efkv
         1+kfHUia6xzHZOEGOsRMYzZYHHKfyVlCc3m3gCun1ehNkm7YObza29thCK8N4+qj8FhC
         kCEQ==
X-Gm-Message-State: ACgBeo1lLbTqlR1F4Ys6WZk2l0ykr4Wc6ORX5BuAMqJOPas1qac6SbAX
        FCgeSubPQuMKrmBuNbA4o10=
X-Google-Smtp-Source: AA6agR4MvA1CBLVvUKP2apXIzJIDOEj2Tkz4lx7eS2Z8tAbZ/rDvYgGLrw9hwS0DKSQYNR/8OaBrcQ==
X-Received: by 2002:a17:907:6d16:b0:731:17b5:699 with SMTP id sa22-20020a1709076d1600b0073117b50699mr8923288ejc.23.1661019409330;
        Sat, 20 Aug 2022 11:16:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 19/19] staging: r8188eu: remove xmit_osdep.h
Date:   Sat, 20 Aug 2022 20:16:23 +0200
Message-Id: <20220820181623.12497-20-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
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

After previous cleanups the header xmit_osdep.h only contains some
structure forward declarations and extern declarations for some module
parameters. The forward declarations are not needed. We can make the
module parameters static in os_dep/os_intf.c and remove xmit_osdep.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      |  1 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |  1 -
 drivers/staging/r8188eu/include/rtw_xmit.h   |  3 ---
 drivers/staging/r8188eu/include/xmit_osdep.h | 20 --------------------
 drivers/staging/r8188eu/os_dep/os_intfs.c    |  7 +++----
 drivers/staging/r8188eu/os_dep/usb_intf.c    |  1 -
 6 files changed, 3 insertions(+), 30 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 9e7e0034d352..26d0aa307d17 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/xmit_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/mlme_osdep.h"
 #include "../include/sta_info.h"
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 2b58e11896b4..2d61cc9169c8 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/xmit_osdep.h"
 #include "../include/mlme_osdep.h"
 #include "../include/sta_info.h"
 
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 0d05ab9abcfb..8f54c41ba927 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -370,7 +370,4 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
 void rtw_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe);
 int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev);
 
-/* include after declaring struct xmit_buf, in order to avoid warning */
-#include "xmit_osdep.h"
-
 #endif	/* _RTL871X_XMIT_H_ */
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
deleted file mode 100644
index 0a68b2dd8d5e..000000000000
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __XMIT_OSDEP_H_
-#define __XMIT_OSDEP_H_
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-extern int rtw_ht_enable;
-extern int rtw_cbw40_enable;
-extern int rtw_ampdu_enable;/* for enable tx_ampdu */
-
-struct xmit_priv;
-struct pkt_attrib;
-struct sta_xmit_priv;
-struct xmit_frame;
-struct xmit_buf;
-
-#endif /* __XMIT_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 6405d88a4d24..2d2a1c27d433 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/xmit_osdep.h"
 #include "../include/recv_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/rtw_ioctl.h"
@@ -66,9 +65,9 @@ static int rtw_uapsd_acvo_en;
 
 static int rtw_led_enable = 1;
 
-int rtw_ht_enable = 1;
-int rtw_cbw40_enable = 3; /*  0 :disable, bit(0): enable 2.4g, bit(1): enable 5g */
-int rtw_ampdu_enable = 1;/* for enable tx_ampdu */
+static int rtw_ht_enable = 1;
+static int rtw_cbw40_enable = 3; /*  0 :disable, bit(0): enable 2.4g, bit(1): enable 5g */
+static int rtw_ampdu_enable = 1;/* for enable tx_ampdu */
 static int rtw_rx_stbc = 1;/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
 static int rtw_ampdu_amsdu;/*  0: disabled, 1:enabled, 2:auto */
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 0c752cf0c6c5..2bc88dc03fa8 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -5,7 +5,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/xmit_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
-- 
2.37.2

