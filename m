Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD834F90A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiDHIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiDHIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:22:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ADE31DC9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:20:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k23so15794222ejd.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wA8IbfGSWA/LPNyziDBCK5VK56qWyjFyrwxoJLLumqM=;
        b=f4QztbglX7qsRUv1AamaKIQPC1zGaRggsSLfHGW+vNkRHY2LOMAu9S9f5QlcPVPQiM
         mz45UgVmOjkMW2YMJmNrVe3Q7nmMYT61OU6T1QIcKI9YFKy2Qz+GHa8y6Q0yi/1at0bh
         xzaZzftBTmDjPQ7MvMiwomEW+dqTMoCTEudoKGz0cFvrICOFzRJ4qAsKAZgzscKR2xLv
         0a/6cjYhvaHpJqMB1ZBbvINSLPaboaIunmiHr8Ungl0BSNpOslQMSjkIH3OpwsBhQn5q
         rSh3ef6w4Z7fjCs2VNEtv19BM+WypGPFV0Ic6/V6JGjlAfvStxBqb3SxqkU3XlyZ4CTn
         q+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wA8IbfGSWA/LPNyziDBCK5VK56qWyjFyrwxoJLLumqM=;
        b=YuVO4BdBQ3j6yvCmCRamEMJgCa84krEI/P1NhmUSJb8I0As/kCzMsWzqOxZ2QPShPb
         6W1Up3A/eBONGoQPco64s2SEH5R5YMaBcVW3LF/qMDCuqPqr9fLmOHYyk8P9LETof0u3
         P5EZ/+AsqMm4+A0E2HDnsht/w844fGUHhQT3Bz+VScz9K84kpuu8chVoipwc2V6S2pde
         pbXXRBHlVgQGelm4CHI7TwMgu698qV7mJpujicfDj9twY0u99g05hFyQ7PXUgnpvnSLF
         JrH8yu8rx7DleUy+87JCXEGspOnZdqTvmKhJxIl8x7AE6t+kaai9ZSO5CdeRW8NVIQQ3
         vnqw==
X-Gm-Message-State: AOAM532UW4wSTFhUwmSZUXnMDpBVL3LJ2hmLzMlh+RRqHhTeF5uHYA07
        fvT/6ioen0sONpXNrzs/rJSbrC57Pos=
X-Google-Smtp-Source: ABdhPJwOck7yEQaxgpFC3uQMXW6SzFTGGB88/AvvSIS3Ock5yTPLLNwngO5fRl9SaFiKFL9gniyTYw==
X-Received: by 2002:a17:907:1c0c:b0:6e0:9b15:29d5 with SMTP id nc12-20020a1709071c0c00b006e09b1529d5mr17404226ejc.416.1649406008459;
        Fri, 08 Apr 2022 01:20:08 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm8466546ejy.93.2022.04.08.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:20:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove header rtw_ioctl.h
Date:   Fri,  8 Apr 2022 10:19:56 +0200
Message-Id: <20220408081956.1093-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Nothing from the header rtw_ioctl.h is used in the driver code.
Remove the header.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 drivers/staging/rtl8723bs/include/rtw_ioctl.h | 72 -------------------
 2 files changed, 73 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_ioctl.h

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 0ce08c2a0755..0bbbdebdf157 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -42,7 +42,6 @@
 #include <rtw_mlme.h>
 #include <mlme_osdep.h>
 #include <rtw_io.h>
-#include <rtw_ioctl.h>
 #include <rtw_ioctl_set.h>
 #include <osdep_intf.h>
 #include <rtw_eeprom.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl.h b/drivers/staging/rtl8723bs/include/rtw_ioctl.h
deleted file mode 100644
index 7179591cb01d..000000000000
--- a/drivers/staging/rtl8723bs/include/rtw_ioctl.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef _RTW_IOCTL_H_
-#define _RTW_IOCTL_H_
-
-/* 	00 - Success */
-/* 	11 - Error */
-#define STATUS_SUCCESS				(0x00000000L)
-#define STATUS_PENDING				(0x00000103L)
-
-#define STATUS_UNSUCCESSFUL			(0xC0000001L)
-#define STATUS_INSUFFICIENT_RESOURCES		(0xC000009AL)
-#define STATUS_NOT_SUPPORTED			(0xC00000BBL)
-
-#define NDIS_STATUS_SUCCESS			((uint)STATUS_SUCCESS)
-#define NDIS_STATUS_PENDING			((uint)STATUS_PENDING)
-#define NDIS_STATUS_NOT_RECOGNIZED		((uint)0x00010001L)
-#define NDIS_STATUS_NOT_COPIED			((uint)0x00010002L)
-#define NDIS_STATUS_NOT_ACCEPTED		((uint)0x00010003L)
-#define NDIS_STATUS_CALL_ACTIVE			((uint)0x00010007L)
-
-#define NDIS_STATUS_FAILURE			((uint)STATUS_UNSUCCESSFUL)
-#define NDIS_STATUS_RESOURCES			((uint)STATUS_INSUFFICIENT_RESOURCES)
-#define NDIS_STATUS_CLOSING			((uint)0xC0010002L)
-#define NDIS_STATUS_BAD_VERSION			((uint)0xC0010004L)
-#define NDIS_STATUS_BAD_CHARACTERISTICS		((uint)0xC0010005L)
-#define NDIS_STATUS_ADAPTER_NOT_FOUND		((uint)0xC0010006L)
-#define NDIS_STATUS_OPEN_FAILED			((uint)0xC0010007L)
-#define NDIS_STATUS_DEVICE_FAILED		((uint)0xC0010008L)
-#define NDIS_STATUS_MULTICAST_FULL		((uint)0xC0010009L)
-#define NDIS_STATUS_MULTICAST_EXISTS		((uint)0xC001000AL)
-#define NDIS_STATUS_MULTICAST_NOT_FOUND		((uint)0xC001000BL)
-#define NDIS_STATUS_REQUEST_ABORTED		((uint)0xC001000CL)
-#define NDIS_STATUS_RESET_IN_PROGRESS		((uint)0xC001000DL)
-#define NDIS_STATUS_CLOSING_INDICATING		((uint)0xC001000EL)
-#define NDIS_STATUS_NOT_SUPPORTED		((uint)STATUS_NOT_SUPPORTED)
-#define NDIS_STATUS_INVALID_PACKET		((uint)0xC001000FL)
-#define NDIS_STATUS_OPEN_LIST_FULL		((uint)0xC0010010L)
-#define NDIS_STATUS_ADAPTER_NOT_READY		((uint)0xC0010011L)
-#define NDIS_STATUS_ADAPTER_NOT_OPEN		((uint)0xC0010012L)
-#define NDIS_STATUS_NOT_INDICATING		((uint)0xC0010013L)
-#define NDIS_STATUS_INVALID_LENGTH		((uint)0xC0010014L)
-#define NDIS_STATUS_INVALID_DATA		((uint)0xC0010015L)
-#define NDIS_STATUS_BUFFER_TOO_SHORT		((uint)0xC0010016L)
-#define NDIS_STATUS_INVALID_OID			((uint)0xC0010017L)
-#define NDIS_STATUS_ADAPTER_REMOVED		((uint)0xC0010018L)
-#define NDIS_STATUS_UNSUPPORTED_MEDIA		((uint)0xC0010019L)
-#define NDIS_STATUS_GROUP_ADDRESS_IN_USE	((uint)0xC001001AL)
-#define NDIS_STATUS_FILE_NOT_FOUND		((uint)0xC001001BL)
-#define NDIS_STATUS_ERROR_READING_FILE		((uint)0xC001001CL)
-#define NDIS_STATUS_ALREADY_MAPPED		((uint)0xC001001DL)
-#define NDIS_STATUS_RESOURCE_CONFLICT		((uint)0xC001001EL)
-#define NDIS_STATUS_NO_CABLE			((uint)0xC001001FL)
-
-#define NDIS_STATUS_INVALID_SAP			((uint)0xC0010020L)
-#define NDIS_STATUS_SAP_IN_USE			((uint)0xC0010021L)
-#define NDIS_STATUS_INVALID_ADDRESS		((uint)0xC0010022L)
-#define NDIS_STATUS_VC_NOT_ACTIVATED		((uint)0xC0010023L)
-#define NDIS_STATUS_DEST_OUT_OF_ORDER		((uint)0xC0010024L)  /*  cause 27 */
-#define NDIS_STATUS_VC_NOT_AVAILABLE		((uint)0xC0010025L)  /*  cause 35, 45 */
-#define NDIS_STATUS_CELLRATE_NOT_AVAILABLE	((uint)0xC0010026L)  /*  cause 37 */
-#define NDIS_STATUS_INCOMPATABLE_QOS		((uint)0xC0010027L)  /*  cause 49 */
-#define NDIS_STATUS_AAL_PARAMS_UNSUPPORTED	((uint)0xC0010028L)  /*  cause 93 */
-#define NDIS_STATUS_NO_ROUTE_TO_DESTINATION	((uint)0xC0010029L)  /*  cause 3 */
-
-extern struct iw_handler_def  rtw_handlers_def;
-
-#endif /*  #ifndef __INC_CEINFO_ */
-- 
2.35.1

