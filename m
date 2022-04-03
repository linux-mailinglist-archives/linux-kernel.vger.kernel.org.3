Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53F4F0B5D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357156AbiDCQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359502AbiDCQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:55:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873C3916B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x20so563251edi.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgW+r2rP7Ct/Bi5AidEK3XFadkAf/CFhGmpGq5m5aQg=;
        b=h5z/2illQph4XE2LeEm29mLGHWAH+IQxdWwy7d7mCxJ9WiGBxj8fZft7+iSOVggUgL
         Bvv2Ys/V8XBRt0j5uI/Og0wyd5oA6qoAandvz+J6R582c+bI0HxiXIaS2Nm8LowW99S6
         hisyWD2hebUnpqxRhIWeYn2AEXqJCFhrpHjtIbmIQwG23wLiImhTc/MuevCIjL3mh+xu
         gdGjrhICC9qeQFRZTeC0Pz/hkCjVSsDXELFzmJ9BUsammZ48RmSeqV6JTZ2cxDl4XgPF
         M3IBZ5MggWVTXeL2zsw7e6wW6Eid/qb27wGptGeloAE0o3b77WxPjSmhU646z8Rx7cgo
         bfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgW+r2rP7Ct/Bi5AidEK3XFadkAf/CFhGmpGq5m5aQg=;
        b=cF/eeCVw6aToM6H6/AROGvWVf4X3kMKH+04TUGylPqR8vNaa4Q2yj6R4ZS0MPdgf7u
         UkIxIysBuKcUhSGLCE4xvNq21ntCoJq5ckfa+qn63LrnuTCpkbS/0E/v+GavoNsgXl8M
         Ki2WZJSBXG1jnY/V1ZX5HpVUx20+uvN7Wse9VhE5ye6v9n+ojKDIMr9UKFDa9/csaWxm
         Hc1NbuVTWPzeHgvX5cTq+Bs11Fwf+0MxoEdCUTfWMzVq6NZTIACDZR5hHTBhR7WfJnkN
         hHxXsli2cUGhZR4CILUR8NBlfFl569oGFeic2JF1oDJGTRT8SX+d5T3wBkSH4RXvJ81h
         HJBw==
X-Gm-Message-State: AOAM5325VbVA4WpfrgHIDf5MhswzGSLSVNNSdSPOYsxMHSGqx/BhAK7E
        fbMG0WQyBQdMP2ghZ+0B4HE=
X-Google-Smtp-Source: ABdhPJzlPp8abHQhTZAJ8nXP1unvfDpch2BZUQ+D3gOaI/H3gTqR4RChIKheVOpW5z/QFLAvh+tzxQ==
X-Received: by 2002:a50:c3c6:0:b0:416:293f:1f42 with SMTP id i6-20020a50c3c6000000b00416293f1f42mr29321074edf.187.1649004786593;
        Sun, 03 Apr 2022 09:53:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm4018138edu.11.2022.04.03.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove HAL_DEF_CURRENT_ANTENNA
Date:   Sun,  3 Apr 2022 18:52:54 +0200
Message-Id: <20220403165255.6900-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403165255.6900-1-straube.linux@gmail.com>
References: <20220403165255.6900-1-straube.linux@gmail.com>
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

In order to get rid of the function GetHalDefVar8188EUsb(), remove
the HAL_DEF_CURRENT_ANTENNA case from it and move the functionality
into a new function. This is part of the ongoing effort to get rid of
the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c     |  4 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 10 +++++++---
 drivers/staging/r8188eu/include/hal_intf.h  |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 24ceb8028f89..84aeb356e485 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -497,7 +497,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* If there are no more slots, expire the oldest */
 			pnetwork = oldest;
 
-			GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
+			target->PhyInfo.Optimum_antenna = current_antenna(adapter);
 			memcpy(&pnetwork->network, target,  get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
@@ -520,7 +520,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
-			GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
+			target->PhyInfo.Optimum_antenna = current_antenna(adapter);
 			memcpy(&pnetwork->network, target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 2c073219c13f..99df084d670a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5995,7 +5995,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	bssid->Rssi = precv_frame->attrib.phy_info.recvpower; /*  in dBM.raw data */
 	bssid->PhyInfo.SignalQuality = precv_frame->attrib.phy_info.SignalQuality;/* in percentage */
 	bssid->PhyInfo.SignalStrength = precv_frame->attrib.phy_info.SignalStrength;/* in percentage */
-	GetHalDefVar8188EUsb(padapter, HAL_DEF_CURRENT_ANTENNA,  &bssid->PhyInfo.Optimum_antenna);
+	bssid->PhyInfo.Optimum_antenna = current_antenna(padapter);
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index e5b352671ea4..7a7eceaac311 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -488,6 +488,13 @@ bool support_ant_div(struct adapter *adapter)
 	return haldata->AntDivCfg != 0;
 }
 
+u8 current_antenna(struct adapter *adapter)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+
+	return haldata->CurAntenna;
+}
+
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
@@ -1211,9 +1218,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	switch (eVariable) {
-	case HAL_DEF_CURRENT_ANTENNA:
-		*((u8 *)pValue) = haldata->CurAntenna;
-		break;
 	case HAL_DEF_DBG_DM_FUNC:
 		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 2a82bc392b87..92ba276031b0 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -28,7 +28,6 @@ enum hw_variables {
 };
 
 enum hal_def_variable {
-	HAL_DEF_CURRENT_ANTENNA,
 	HAL_DEF_DBG_DM_FUNC,/* for dbg */
 };
 
@@ -64,6 +63,7 @@ uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
 
 bool support_ant_div(struct adapter *adapter);
+u8 current_antenna(struct adapter *adapter);
 
 u32 rtl8188eu_hal_init(struct adapter *Adapter);
 u32 rtl8188eu_hal_deinit(struct adapter *Adapter);
-- 
2.35.1

