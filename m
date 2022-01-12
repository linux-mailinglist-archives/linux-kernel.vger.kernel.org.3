Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6948BDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350653AbiALEWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350662AbiALEWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:22:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD405C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l15so2263512pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2R7ZVHCw02Rsd6KEYUhmsx7al3DqDAEUHEngmsp8FkQ=;
        b=dnxIrVKdQ6h2JdYrWAjfTleVVECs28kpUbTiUcf0mNwpjSUzOyPKjUdmx0JI9i9lQR
         O9jzMhAz05DwGdXbPQq4zhCOWo/1TN+DfDnoaB0ybjhjxiAsPcYGXi52q4whryQc//Sw
         Zlr9gI20VM0EgdUtab4vePrTV6qNdjCI7jQRK1jnSvGjKwDVb/0vTjc3lY+ayCbmfFMo
         RFGNwS63jDa/C9uAptISdrcbl0va30U/tY8/Xclz0G5sQBru1hhrzN2d58Zq4oWZPw7c
         rhd8Iq1QcJBITPJ6LNW7Znm2Dyaq52mq6qdi6aPQtx4r8oKxRD0KqyV6EwMHSzInXZ3p
         Eg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2R7ZVHCw02Rsd6KEYUhmsx7al3DqDAEUHEngmsp8FkQ=;
        b=eHD0RjsS/pXWOiYkhRjFi+a7t5C/zBAr0Gr81Uma8AbTs+k6ITLxJMAVu8HBiWl/2Y
         FhoEUI5KUDZhbUBKgDCv0UvG3J4CLzT2Hzy2kKGwnB30UkpoD6d5EuR0APo61hSwFf5Y
         PcrGlkbIzYsbz22ZeBnSEswva0cSN59ZmJymLR3F9zMqKoNIVIkaFXeEFswBo4C2QwaM
         CV6RCDvq1Jw8NKB6jjjn+xvQvn4BjcYOPOYub0kXHnV6E0AvU/kpO8JYKmKEi1Rz9i/2
         mK3DH6l/Z1vVuNYCdfnDlVuBJnfud1cvuy+pKQehWjUiQGPvmJzUQ3DD366wBrv//TEH
         V6DA==
X-Gm-Message-State: AOAM532iny10bPBn+dk0zKIAUzCSt+C8rzg4pgTCYtidLY4+7Rs815vq
        /SlJ5Yqc1HGwtzD99zWGUNY=
X-Google-Smtp-Source: ABdhPJwH04RiAnN/vpjJy/C7SUy9+Vt8ZIlRoKWHoHEUBCj0SXUouBS2IRJIOCWZ4bA4kXpR9eRK9A==
X-Received: by 2002:a17:903:10c:b0:14a:3d99:d883 with SMTP id y12-20020a170903010c00b0014a3d99d883mr7797461plc.75.1641961335190;
        Tue, 11 Jan 2022 20:22:15 -0800 (PST)
Received: from localhost.localdomain ([115.99.137.58])
        by smtp.gmail.com with ESMTPSA id t207sm11237747pfc.205.2022.01.11.20.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:22:14 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH  4/4] Staging: rtl8723bs: Inserting blank line after declaration
Date:   Wed, 12 Jan 2022 09:52:01 +0530
Message-Id: <20220112042201.5056-5-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112042201.5056-1-jagathjog1996@gmail.com>
References: <20220112042201.5056-1-jagathjog1996@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl warning by inserting blank line
and removing unwanted spaces
WARNING: Missing a blank line after declarations

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 4868a69cdb8f..02c720d49b53 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -181,13 +181,14 @@ void rtw_hal_disable_interrupt(struct adapter *padapter)
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
 {
 	u8 val = false;
+
 	if (padapter->HalFunc.check_ips_status)
 		val = padapter->HalFunc.check_ips_status(padapter);
 
 	return val;
 }
 
-s32	rtw_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
+s32 rtw_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	if (padapter->HalFunc.hal_xmitframe_enqueue)
 		return padapter->HalFunc.hal_xmitframe_enqueue(padapter, pxmitframe);
@@ -195,7 +196,7 @@ s32	rtw_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmit
 	return false;
 }
 
-s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
+s32 rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	if (padapter->HalFunc.hal_xmit)
 		return padapter->HalFunc.hal_xmit(padapter, pxmitframe);
@@ -206,9 +207,10 @@ s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
 /*
  * [IMPORTANT] This function would be run in interrupt context.
  */
-s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
+s32 rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 {
 	s32 ret = _FAIL;
+
 	update_mgntframe_attrib_addr(padapter, pmgntframe);
 	/* pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET; */
 	/* pwlanhdr = (struct rtw_ieee80211_hdr *)pframe; */
@@ -230,7 +232,7 @@ s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 	return ret;
 }
 
-s32	rtw_hal_init_xmit_priv(struct adapter *padapter)
+s32 rtw_hal_init_xmit_priv(struct adapter *padapter)
 {
 	if (padapter->HalFunc.init_xmit_priv)
 		return padapter->HalFunc.init_xmit_priv(padapter);
@@ -243,7 +245,7 @@ void rtw_hal_free_xmit_priv(struct adapter *padapter)
 		padapter->HalFunc.free_xmit_priv(padapter);
 }
 
-s32	rtw_hal_init_recv_priv(struct adapter *padapter)
+s32 rtw_hal_init_recv_priv(struct adapter *padapter)
 {
 	if (padapter->HalFunc.init_recv_priv)
 		return padapter->HalFunc.init_recv_priv(padapter);
@@ -299,6 +301,7 @@ void rtw_hal_stop_thread(struct adapter *padapter)
 u32 rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask)
 {
 	u32 data = 0;
+
 	if (padapter->HalFunc.read_bbreg)
 		 data = padapter->HalFunc.read_bbreg(padapter, RegAddr, BitMask);
 	return data;
@@ -312,6 +315,7 @@ void rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32
 u32 rtw_hal_read_rfreg(struct adapter *padapter, u32 eRFPath, u32 RegAddr, u32 BitMask)
 {
 	u32 data = 0;
+
 	if (padapter->HalFunc.read_rfreg)
 		data = padapter->HalFunc.read_rfreg(padapter, eRFPath, RegAddr, BitMask);
 	return data;
@@ -385,6 +389,7 @@ bool rtw_hal_c2h_valid(struct adapter *adapter, u8 *buf)
 s32 rtw_hal_c2h_handler(struct adapter *adapter, u8 *c2h_evt)
 {
 	s32 ret = _FAIL;
+
 	if (adapter->HalFunc.c2h_handler)
 		ret = adapter->HalFunc.c2h_handler(adapter, c2h_evt);
 	return ret;
-- 
2.17.1

