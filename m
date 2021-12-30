Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E2C482026
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhL3UBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbhL3UBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C10C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso16563149wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CtCwwPsCao8kkeRXV1Zww5XYrsoEXQXIXV3u2Cd1x4=;
        b=fKJE5tHF/wWzzTMnhcAO2od0kiS1rsPcb+5qwSGYe2uaF2LJAfClResc8KPEKhJPeQ
         mMoCcHuwYc0wqRAD1Ggp5NuFoU9d4mMnw3UWDZStchayTuaAC/2MDS6irJwLSfHcvUiw
         KbDu1xNHMrcpp/HptDW75IjelYVgK+Dy79AJbjKyav8W8k47wvoRFJm0ObuWc42rDy8c
         m76V1sHE70apbb0joGOFL3rq47vv2KqI3htgTf4ZjedVT9Ifkogj8+ib2lTZVS0VQGvI
         uaxrApeZJ+/0JyoqptWK46+Z/S4oVsApNVwGLlxqmwiu0KIxrv2HqN+eGhzljN6wKSUj
         n7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CtCwwPsCao8kkeRXV1Zww5XYrsoEXQXIXV3u2Cd1x4=;
        b=a7ELztjaSmuAk3FEkj6YnOI4TPefN0Wod0gnm9arZA1AZV5cXEzMaIzKhEZ2WrDbEN
         F76O9zzTPYeOBnjZF8oBvbjaTWCU088BRn2JrGzUnCzakVJn2I5ZXSTpmZ3X/d+os8Dn
         9q/JCIBZdknLAwYjIr1us7B9k0I8apeJNjPhietqMYIYfinQxOM95+kA/LKyFH5vKY3h
         O1zG52W/4pHlVa4l/KRYzXEnA0fgC1ABDyl6PI8PsHPOZOyeY5M8QQY/TJ+IlZ0OrmsH
         pkCUPgciAQmVsi1bXWDbdkkuOeMhOX0nuL51O7vbGYRMLa8UQOWu0t+GPt3M0/ih4Akr
         jE9A==
X-Gm-Message-State: AOAM531SCoUvyxrQ+v7A8RCE3GW1RNfweyktHHRPJG81qFSWTgIaThhL
        fd111MScyZKG/eUuWF6pmZ4=
X-Google-Smtp-Source: ABdhPJyKE7LoeS4OkyEwk4Pv3xU+Wioc8bGJ0Y7C+SGbwCUwusJZHlxkojJD+zJU96u2ISRsNR5LoQ==
X-Received: by 2002:a1c:494:: with SMTP id 142mr27836964wme.191.1640894469710;
        Thu, 30 Dec 2021 12:01:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:09 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: r8188eu: IntArray and C2hArray are set but never used
Date:   Thu, 30 Dec 2021 21:00:58 +0100
Message-Id: <20211230200059.13406-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields IntArray and C2hArray of struct hal_data_8188e are set but
never used. Remove them.

While at it, remove the unsed defines USB_INTR_CONTENT_CPWM1_OFFSET
and USB_INTR_CONTENT_CPWM2_OFFSET as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c     | 10 ----------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  3 ---
 drivers/staging/r8188eu/include/rtl8188e_spec.h |  7 -------
 3 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 9ec55a77dccd..85bcde5ee79a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -185,20 +185,10 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 
 static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
 {
-	struct hal_data_8188e *haldata = &adapt->haldata;
-
 	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
 		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
 		return;
 	}
-
-	/*  HISR */
-	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
-	memcpy(&haldata->IntArray[1], &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
-
-	/*  C2H Event */
-	if (pbuf[0] != 0)
-		memcpy(&haldata->C2hArray[0], &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
 }
 
 static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 2ce42d647a34..239d0db55639 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -246,9 +246,6 @@ struct hal_data_8188e {
 
 	u32	UsbBulkOutSize;
 
-	/*  Interrupt relatd register information. */
-	u32	IntArray[3];/* HISR0,HISR1,HSISR */
-	u8	C2hArray[16];
 	u8	UsbTxAggMode;
 	u8	UsbTxAggDescNum;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index e59fd2fe82c5..009222b4a95d 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -475,13 +475,6 @@ Default: 00b.
 #define	MSR_INFRA			0x02
 #define	MSR_AP				0x03
 
-/*   88EU (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
-#define	USB_INTR_CONTENT_C2H_OFFSET	0
-#define	USB_INTR_CONTENT_CPWM1_OFFSET	16
-#define	USB_INTR_CONTENT_CPWM2_OFFSET	20
-#define	USB_INTR_CONTENT_HISR_OFFSET	48
-#define	USB_INTR_CONTENT_HISRE_OFFSET	52
-
 /*  88E Driver Initialization Offload REG_FDHM0(Offset 0x88, 8 bits) */
 /* IOL config for REG_FDHM0(Reg0x88) */
 #define CMD_INIT_LLT			BIT(0)
-- 
2.34.1

