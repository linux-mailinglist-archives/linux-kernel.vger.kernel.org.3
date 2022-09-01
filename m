Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A35A9DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiIARVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIARVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:21:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980CD5A3DB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:21:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e18so15960497edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GdKSrjYfMkwK9rUKg3FKiVa8IZKeoeUMaRJ6T28HaBQ=;
        b=Yw5T74k57lHXMjiqqC3YAyoxM8dkwdEtHHADOFOHEXWGvqT6pa4lJ9OInlJsqPoo08
         Porv/pR8ZvOvlgAxZErz3x+wB8GvAu0fq2CpPZk6oeTWEAcwRtiqNYnCcpRtyVSGtbfF
         zA8G7HXpLN10qQTp6JYC8y+9TK+beIZAP/NMhS+HrHb1Ko7bbnR77viZsMUO3fhN+XZv
         2836L8+Lq7SSqQpAEjItvhqGNFgBsRmxpeiDTX3LbsPjSP1MppAvkAPbEsfy4e5Nye9D
         Gzn2hT8rk1fXzRI6OojWGIlLMo5dvRGjdSSnuhwsvOpC+eE9JKOyfVszRK/BmVEbeyQV
         I9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GdKSrjYfMkwK9rUKg3FKiVa8IZKeoeUMaRJ6T28HaBQ=;
        b=16OMfDvvFCRXHH0WU8im8c7vEWgoi1Xg4RF+OMc2t11ijOxMTUnLVESkCl8CYlJBO2
         hsTCcpHk7XXuxZexE0pEPoS0zlMFL/R5BWj+hQ4XtjqfBE1i2xoN1ewvDVuUsqQTIZ89
         36kTIDXz9PvQ1xH2z0FdPvVzMjF1W7puXcGiY2StymIQYcgFIAzndL++YxYEWwNaSEsI
         RTOaw0amLJXmXu60IpcBwD3xxsCOqa7Bpp2rKV9h5Fexmb8/GEzdEjXrZDYz1fxSsoeN
         Yk9enFXOJK0yPsoWs7tsEuir4jhzhoZhibp6/Czz8LQXMKKHuXY2LYnEoBt+mTKDI5YX
         Odnw==
X-Gm-Message-State: ACgBeo0Ia8MZC5xvTXUktHTyEyTPid7NAtCrEcWViXq2tJrMLYB2qsVb
        0UcBkxd43CJnJZ5znM1ocZY=
X-Google-Smtp-Source: AA6agR7GgF9V4riY+CvNwpp4tsyE9Mo/MUaLpZkeZ7ENpwX0eCU6Hclub33HqW/SRLLIBQ8szB9CMg==
X-Received: by 2002:aa7:dcd6:0:b0:448:bddd:d562 with SMTP id w22-20020aa7dcd6000000b00448bdddd562mr12506696edu.365.1662052891022;
        Thu, 01 Sep 2022 10:21:31 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb63.dynamic.kabel-deutschland.de. [95.90.187.99])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906705000b00732e3d94f4fsm8645992ejj.124.2022.09.01.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 10:21:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove mlme_osdep.h
Date:   Thu,  1 Sep 2022 19:21:20 +0200
Message-Id: <20220901172120.8485-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The function indicate_wx_scan_complete_event() is declared multiple
times. That is not needed. Remove redundant declarations to clean up
the driver code and remove the now empty header mlme_osdep.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c       |  1 -
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  2 --
 drivers/staging/r8188eu/core/rtw_mlme.c      |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  1 -
 drivers/staging/r8188eu/core/rtw_recv.c      |  1 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c   |  1 -
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 drivers/staging/r8188eu/include/mlme_osdep.h | 12 ------------
 drivers/staging/r8188eu/include/rtw_mlme.h   |  1 -
 10 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/mlme_osdep.h

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 5b6a891b5d67..d690337ea74b 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/mlme_osdep.h"
 #include "../include/rtw_br_ext.h"
 #include "../include/rtw_mlme_ext.h"
 #include "../include/rtl8188e_dm.h"
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 17f6bcbeebf4..d859f2d8a0c8 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -11,8 +11,6 @@
 #include "../include/usb_osintf.h"
 #include "../include/usb_ops.h"
 
-extern void indicate_wx_scan_complete_event(struct adapter *padapter);
-
 u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 8f21d34a317f..d2ea2659d58e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -7,7 +7,6 @@
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
 #include "../include/hal_intf.h"
-#include "../include/mlme_osdep.h"
 #include "../include/sta_info.h"
 #include "../include/wifi.h"
 #include "../include/wlan_bssdef.h"
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 893dac30e8e6..86906a726941 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -9,7 +9,6 @@
 #include "../include/wifi.h"
 #include "../include/rtw_mlme_ext.h"
 #include "../include/wlan_bssdef.h"
-#include "../include/mlme_osdep.h"
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_xmit.h"
 #include "../include/rtl8188e_dm.h"
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index ee3817c3e1fd..353c7468367a 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -7,7 +7,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/mlme_osdep.h"
 #include "../include/usb_ops.h"
 #include "../include/wifi.h"
 #include "../include/rtl8188e_recv.h"
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 2d61cc9169c8..b5dd28a10e5b 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/mlme_osdep.h"
 #include "../include/sta_info.h"
 
 static void _rtw_init_stainfo(struct sta_info *psta)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index b01ee1695fee..a7ac9f62459f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -6,7 +6,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
-#include "../include/mlme_osdep.h"
 #include "../include/rtw_ioctl_set.h"
 
 #include "../include/rtl8188e_hal.h"
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fd8e792958ce..ac6e3f95c5b7 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -39,7 +39,6 @@ void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 
-void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
 #endif /* __HAL_INTF_H__ */
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
deleted file mode 100644
index 1fa66c5e3c9c..000000000000
--- a/drivers/staging/r8188eu/include/mlme_osdep.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef	__MLME_OSDEP_H_
-#define __MLME_OSDEP_H_
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-void indicate_wx_scan_complete_event(struct adapter *padapter);
-
-#endif	/* _MLME_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index d827ea7d841b..5dc2fe74b7b7 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -5,7 +5,6 @@
 #define __RTW_MLME_H_
 
 #include "osdep_service.h"
-#include "mlme_osdep.h"
 #include "drv_types.h"
 #include "wlan_bssdef.h"
 
-- 
2.37.2

