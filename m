Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3DC48271F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiAAIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiAAItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A76C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j18so59724140wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZkQCyjgnnx4rx3Sb/nBNm6G3aX374d2a0MfjOD+6ec=;
        b=Sybhx02EkBFbvZOR3XR5V2eT+cdFzcRaUqYw4aW0s6oikiiYIDJBpNTyJc/X0mHMNc
         qk8dlNvt7sjpYmSi/MlwhVdSZlsTRRGRi+2ZEyv4lRBZau4I2hYnjR9rAaFm4GMG0amC
         xsqIcp8jglMNFKxCM9noHJyIX2mF+YSt/2P8YZG7ALUc1B+F+JLx7rXDQFJFpRiGG9bB
         nkHwJ4g6hAfqoZgqkV/OZ68pIht3lQT6BmtaR+VNRtfeg61i3HZenrO7gjOV3G2QXc9S
         KVIceQhf+8EG7bVwbAwClD9yVFchjY3G+oXsJsxD7QKxLDNKnMndtyOr8dmJdsSwEIYO
         lFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZkQCyjgnnx4rx3Sb/nBNm6G3aX374d2a0MfjOD+6ec=;
        b=NtFAfe0M/Wu38xVYE+Dy63l664yvD/LptOrfJSby5aae6xIhDxput/AJ1Rp+34AVZz
         3kkf55bMG4/KSYwny1awGyyEhwaeEM0PCBn9VXDGGnZPVkkbnn+fsqxXCYT/ME0daWXi
         rVKrurMu4db8wlGRYwzBozoubF12maLm0Wcj2IciP+THKXY+mNXbuQobInYCbuwe+8Yy
         c64cyNRZXbVX1uWUyx9EnfCF/oQsfUrqIXiQ0lq6odhx8TNu/PLyi0CGrrYFTueMK58O
         fVcajqZQDbsi07nZiKtDFwnE4lUJ4y2zuYbGB1nDM6TePmHIfw6wc+NAl0Gj2SSat6+G
         29nA==
X-Gm-Message-State: AOAM530oCtLK3Sx2aAK8R7ySujNPYjyfRtkOnf3J5TvHfp6eFmxLpV6E
        FRbblILyWlal8bpUH8RYn1wBJzSGRqs=
X-Google-Smtp-Source: ABdhPJx6zSe6Kh9Z4dazVFhy3Kj6LxmnoOjYto7ujNy1nScVms71ewUF0u2PqvlfVUBhutz2wg3aMg==
X-Received: by 2002:adf:fbcf:: with SMTP id d15mr20265320wrs.132.1641026993306;
        Sat, 01 Jan 2022 00:49:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:53 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 6/7] staging: r8188eu: IntArray and C2hArray are set but never used
Date:   Sat,  1 Jan 2022 09:49:36 +0100
Message-Id: <20220101084937.3411-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101084937.3411-1-straube.linux@gmail.com>
References: <20220101084937.3411-1-straube.linux@gmail.com>
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
v3: Remove INTERRUPT_MSG_FORMAT_LEN from rtl8188e_recv.h.
v2: Remove interrupt_handler_8188eu() since it does nothing now.

 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 20 -------------------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  3 ---
 .../staging/r8188eu/include/rtl8188e_recv.h   |  1 -
 .../staging/r8188eu/include/rtl8188e_spec.h   |  7 -------
 4 files changed, 31 deletions(-)

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
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index bc30eb4634bb..0be9896eaf0f 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -37,7 +37,6 @@ enum rx_packet_type {
 	HIS_REPORT,/*  USB HISR RPT */
 };
 
-#define INTERRUPT_MSG_FORMAT_LEN 60
 void rtl8188eu_init_recvbuf(struct recv_buf *buf);
 s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
 void rtl8188eu_free_recv_priv(struct adapter * padapter);
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

