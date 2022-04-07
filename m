Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522534F881D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiDGTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiDGTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8341299F3B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so12971540ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csidvWKCgQbNsJ3hDpmUS3N7kEV8FSmE0B1p9bl3FMU=;
        b=LCu+8Ovpgl9eYTcuwb9Q+M+QEA9KhFYou0ivJCjsTwaltep73B3ZdO1n4lkl2W3yCQ
         j31AwtDH9VwcD7fP4iVBI2xbg/FVS+EgU4fJ5fK53ZL3kdmJwBiuq334yaTT19zLXdkO
         EiRcu8tiWimxrjzsmOSyWdwvG5lcYobdtRNOkFWnbvsIF5GaxJdj/EwVRR2JSrI2mvlL
         ckAQHbaBXo7sSI4alS5N1FxxQHVJmwxe+eIKzn5eanaM+JetFzhT3dJfvbLU9XWFvhsG
         XWvPB80I/duS6lVIPdRrq/CYZWMOi8o7fkrOA3eTYuxjEGULJL8BWFQNgQkabeqY2L+J
         k53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csidvWKCgQbNsJ3hDpmUS3N7kEV8FSmE0B1p9bl3FMU=;
        b=mOx/KluE5mPbCHboflYwd3tHpCqyYp7ybnOdv1RbPTUmgx3XNjZRFwkybWKCE97ldW
         i5zRJP4mxVibmgIA8EhdoB2S7Oe0/MEAZLtw05S4N6VI9uUEq/Rxw9PuqTUdTg5PUYbC
         0MU6SUzNoiZPR6VGlDzHLF0P4gt9IC21tEPGT6zRWuBeuD/e//K81ph3PaDGqT++Z973
         UcdGxqV7pRRO6yktYkIKyHtxG3DLUi453vpjYmhPNwrqkRFp8g1QMNzy4q4fIK2Tek6i
         w4HTzO4tD2yRhNNN3jWuQLdPnA/p6MZgzGs6qbIv5pxZqtAAWKXB0F7pYsrtpsbwfDsL
         InZg==
X-Gm-Message-State: AOAM53202mqwwBuHYdu2iEswMhU4vUnEOiYvgvDY919hsgAxcV3oSyEz
        1fHzXo/9oBxu/IAFp5qRJgE=
X-Google-Smtp-Source: ABdhPJwPEspTPVDkuTZWkXizEfUbEEQmpCfYnRTlDuuAVtSDtN1nu/T/Le5/Sgq3ZtzFiCywokVd2g==
X-Received: by 2002:a17:906:c103:b0:6e0:df50:7f52 with SMTP id do3-20020a170906c10300b006e0df507f52mr15212510ejc.501.1649359708305;
        Thu, 07 Apr 2022 12:28:28 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: r8188eu: remove header usb_vendor_req.h
Date:   Thu,  7 Apr 2022 21:28:18 +0200
Message-Id: <20220407192819.10661-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

Nothing from the header usb_vendor_req.h is used in the driver code.
Remove the header.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_osintf.h  |  1 -
 .../staging/r8188eu/include/usb_vendor_req.h  | 35 -------------------
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  1 -
 3 files changed, 37 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h

diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
index 32ca8ef95b23..f271e93e9ab9 100644
--- a/drivers/staging/r8188eu/include/usb_osintf.h
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -6,7 +6,6 @@
 
 #include "osdep_service.h"
 #include "drv_types.h"
-#include "usb_vendor_req.h"
 
 extern char *rtw_initmac;
 extern int rtw_mc2u_disable;
diff --git a/drivers/staging/r8188eu/include/usb_vendor_req.h b/drivers/staging/r8188eu/include/usb_vendor_req.h
deleted file mode 100644
index 7337b1b7419f..000000000000
--- a/drivers/staging/r8188eu/include/usb_vendor_req.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef _USB_VENDOR_REQUEST_H_
-#define _USB_VENDOR_REQUEST_H_
-
-/* 4	Set/Get Register related wIndex/Data */
-#define	RT_USB_RESET_MASK_OFF		0
-#define	RT_USB_RESET_MASK_ON		1
-#define	RT_USB_SLEEP_MASK_OFF		0
-#define	RT_USB_SLEEP_MASK_ON		1
-#define	RT_USB_LDO_ON				1
-#define	RT_USB_LDO_OFF				0
-
-/* 4	Set/Get SYSCLK related	wValue or Data */
-#define	RT_USB_SYSCLK_32KHZ		0
-#define	RT_USB_SYSCLK_40MHZ		1
-#define	RT_USB_SYSCLK_60MHZ		2
-
-enum bt_usb_request {
-	RT_USB_SET_REGISTER		= 1,
-	RT_USB_SET_SYSCLK		= 2,
-	RT_USB_GET_SYSCLK		= 3,
-	RT_USB_GET_REGISTER		= 4
-};
-
-enum rt_usb_wvalue {
-	RT_USB_RESET_MASK	=	1,
-	RT_USB_SLEEP_MASK	=	2,
-	RT_USB_USB_HRCPWM	=	3,
-	RT_USB_LDO			=	4,
-	RT_USB_BOOT_TYPE	=	5
-};
-
-#endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index ffd727fb32e3..7bd5ab7e5248 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -8,7 +8,6 @@
 #include "../include/xmit_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/osdep_intf.h"
-#include "../include/usb_vendor_req.h"
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
 #include "../include/rtw_ioctl.h"
-- 
2.35.1

