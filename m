Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72AE483042
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiACLNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiACLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:13:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020F1C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 03:13:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so134599692edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZXkJPdWljf+/dV3WK0IraDCIyxCUGWBgOH9D0rR91I=;
        b=VWBLxodJfliFelPaL4r3eW3VA8ZGb0ywH9I0BVwXx2yjtGpiQwN8Ww+MwdvHj9n82T
         8mG21L4O1VyXTRiFUyGy21OIhXcmfm0yO8oKDI5mrp+wSN/6lh2PZuysAJbn6S+2L+46
         JvFlNicVMFOQepR963n6OfSVNL4Mzbhw57HHJcqBVTdELg+FAyGReonbbjGTPOfkIkNK
         Cv7KYiRMIhA4Yp3R6PJv9hDXJaIaa657dZmXBC1biMdDAqYy6f7FlzRjVn8m4hBva5Gl
         87dcvUWfaAXc0apAMgW/AohxnBY7gpOkmAZypBCRwrMZSTwDovLUzdyTRsWZl8vqJ1IE
         vS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZXkJPdWljf+/dV3WK0IraDCIyxCUGWBgOH9D0rR91I=;
        b=7TkjRbPeZGVxMcZV0c7GDWlVoljS2Dlb8oJ4AvVl4pDa8VVGhSxzmdSSqVEI8/SXeR
         LXDMBba3jwKsqhGN6gIkU6zNsmGkklEioEzF+89r8IKsfS2kpyaVXbymNwY7LmYSK95X
         5aqMWCUwolep7EpZFumEsyoDdTuYvrp3X4HNJREozHX9Xrnn3RxG9EFW4+PZvBkp5owt
         xAMcBrVnw/Wr5GbKd9KlDxQ0aLhysRXaMZ5B3tWJQyV7gBYdWkpY6AchtdaFwo/NqaGr
         lYvEWeJHrm/FFzTLlSDkux1slts9w9768qVHqrzKuyJq3GIWltvXJiN/9eQ7lhSf+WfG
         d78g==
X-Gm-Message-State: AOAM5308MW5TxYprneydQxMBltMBDJP1JeY+/l/Q77Bg0ElejCmLZgNH
        VjEvVMlgylxrmUOPDEay0euxLKcVUZI=
X-Google-Smtp-Source: ABdhPJymq7s8SuzSTRRmYBg5/4GxuUXlOQUW46uBpafvMSUxFcQz2D78ninctslyZDL7QsBI4gp7sg==
X-Received: by 2002:a17:906:2a41:: with SMTP id k1mr34433952eje.512.1641208395620;
        Mon, 03 Jan 2022 03:13:15 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id v8sm13360312edt.10.2022.01.03.03.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 03:13:15 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: replace camelcase field CustomerID
Date:   Mon,  3 Jan 2022 12:11:32 +0100
Message-Id: <20220103111131.212261-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase field CustomerID to customer_id, compliant
with linux kernel coding style.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c      | 2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c      | 2 +-
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h | 2 +-
 drivers/staging/rtl8188eu/include/rtw_eeprom.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 1af919ff6d93..81d79b39e048 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -43,7 +43,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 	dm_odm->SupportICType = ODM_RTL8188E;
 	dm_odm->CutVersion = ODM_CUT_A;
 	dm_odm->bIsMPChip = hal_data->VersionID.ChipType == NORMAL_CHIP;
-	dm_odm->PatchID = hal_data->CustomerID;
+	dm_odm->PatchID = hal_data->customer_id;
 	dm_odm->bWIFITest = Adapter->registrypriv.wifi_spec;
 
 	dm_odm->AntDivType = hal_data->TRxAntDivType;
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 16a57b31a439..0fa01549bfa7 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1385,7 +1385,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-					RetryLimit = (haldata->CustomerID == RT_CID_CCX) ? 7 : 48;
+					RetryLimit = (haldata->customer_id == RT_CID_CCX) ? 7 : 48;
 				else /*  Ad-hoc Mode */
 					RetryLimit = 0x7;
 			} else if (type == 1) {
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index eb4655ecf6e0..231800f60583 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -181,7 +181,7 @@ struct txpowerinfo24g {
 
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
-	u16	CustomerID;
+	u16	customer_id;
 	u16	FirmwareVersion;
 	u16	FirmwareVersionRev;
 	u16	FirmwareSubVersion;
diff --git a/drivers/staging/rtl8188eu/include/rtw_eeprom.h b/drivers/staging/rtl8188eu/include/rtw_eeprom.h
index 10525493129b..57b675baf5bc 100644
--- a/drivers/staging/rtl8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/rtl8188eu/include/rtw_eeprom.h
@@ -49,7 +49,7 @@
 /*  EEPROM size consideration. So, we have to perform proper translation
  *  between them.
  */
-/*  Besides, CustomerID of registry has precedence of that of EEPROM. */
+/*  Besides, customer_id of registry has precedence of that of EEPROM. */
 /*  defined below. 060703, by rcnjko. */
 enum RT_CUSTOMER_ID {
 	RT_CID_DEFAULT = 0,
-- 
2.25.1

