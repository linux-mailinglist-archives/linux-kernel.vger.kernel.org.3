Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA45148270A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiAAISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiAAISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFADC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b73so18457034wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXMWSZptIeRPrV7Ny9e/lWoHz+fzwKFZLfpVM59vyP0=;
        b=VO34iHaCEpkAEFs44Q7eYbTI8ph5n1PkIqK1h8CXuIAV5t45xXfaLuPAyFJXZjUgdG
         Vei2424ILY+gQlG0xyBOuSOb9EntmNhVN8gwaQ1n19zOT6ozZdQ4xtNNm1dkakeJk6Xm
         6hEqxqqohHzr2WN9yJUIAJDptKJ1azvn7553/bMZkI/1u5J5PPYZkCyN2rSLT4urTudy
         2OhYGWrbDHRpEBDKL0pfacml2nbQjHLUphvHwMwrkm0MdQPVQy6boRtcIDFKNidwLZ+D
         QdcJqrfQVSnNaXhLYCMZxYRvF+M9ThP8NUddfGhU5DEYMwH8MYvTR5fgHnBKQnrx1xTm
         CksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXMWSZptIeRPrV7Ny9e/lWoHz+fzwKFZLfpVM59vyP0=;
        b=A5XHy/bJJDHqn2C39pQU8pLMltUAfuFNRhtkCIAGWZw7AI+WzAGqW+zwygrH8R1zC8
         nJQOJePJ3wjIZ1FAj6ooxU2K+xSkSzVPTjb0fka8CQ+EmodGvJwxSi4+3g+hF8B2FCUO
         FTavw2IuZtjNjCbFbXa9GR2Xx4Yl186Q8kDvMx4gzX7jShIhAU1P/FjTwUq9VDt/zMfl
         2KeYaDsFc16cELSgPfs42FoZV8a1HiW2WbvJJ+FjB3u567yOj67A7mF0voNAopaUuapP
         uZLHmD2Piaui8vcn0DdNO4l2O/Ar9BP0Fbmjd5gExwTiUbGSX5zT6m/c7/Y9NyV5/TLe
         0O0Q==
X-Gm-Message-State: AOAM533+IW7JGkvRnblq0xZmNY42iTdlCZs33sZ3hlfGcwwrZtM4LrKd
        WEnRy0Ach2dndiPPJw/NIGO0Pz9XG+4=
X-Google-Smtp-Source: ABdhPJyFiu1ixPgRE8CH34H8v8h+o9BmECh2Uy5ksNd1t+hrQ/8aGFGyVvA4bjvcVN26k+CHPiwN+w==
X-Received: by 2002:a05:600c:3797:: with SMTP id o23mr31927594wmr.178.1641025088584;
        Sat, 01 Jan 2022 00:18:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/7] staging: r8188eu: IntArray and C2hArray are set but never used
Date:   Sat,  1 Jan 2022 09:17:57 +0100
Message-Id: <20220101081758.9716-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields IntArray and C2hArray of struct hal_data_8188e are set but
never used. Remove them and remove interrupt_handler_8188eu() since it
does nothing now.

While at it, remove the unsed defines USB_INTR_CONTENT_CPWM1_OFFSET
and USB_INTR_CONTENT_CPWM2_OFFSET as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: Remove interrupt_handler_8188eu() since it does nothing now.

 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 20 -------------------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  3 ---
 .../staging/r8188eu/include/rtl8188e_spec.h   |  7 -------
 3 files changed, 30 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 9ec55a77dccd..4a0ab4053e90 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -183,24 +183,6 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	return RTW_STATUS_CODE(ret);
 }
 
-static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
-{
-	struct hal_data_8188e *haldata = &adapt->haldata;
-
-	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
-		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
-		return;
-	}
-
-	/*  HISR */
-	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
-	memcpy(&haldata->IntArray[1], &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
-
-	/*  C2H Event */
-	if (pbuf[0] != 0)
-		memcpy(&haldata->C2hArray[0], &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
-}
-
 static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 {
 	u8	*pbuf;
@@ -342,8 +324,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 							pattrib->MacIDValidEntry[0],
 							pattrib->MacIDValidEntry[1]
 							);
-			} else if (pattrib->pkt_rpt_type == HIS_REPORT) {
-				interrupt_handler_8188eu(adapt, pattrib->pkt_len, precvframe->rx_data);
 			}
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 		}
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

