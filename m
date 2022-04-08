Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5077D4F960A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiDHMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiDHMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:48:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B2EFF91
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:46:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so17138403ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVGN7Vuf2OES8d0E6KIMK5SLay2jC5tCW1R73Tr2cd4=;
        b=Tc88kf57x/fVe07aWgPrRv578I5Uskxs9c97PiXAi8tYH6VVuuV+XSEuiAcqWJZ214
         Q8Qa33P32wl5Gbon074AIDrpqUeX41bjJrW0Ah8kGsS2aj4EMViUO6HtAvUTtB+97kTf
         /rn1iQkudUO7ZJXFvKzDZTzYzCYeYBFIqe+9TfCK6jmPOBUKyoUabGxZWMt2rZJRBYcR
         Ttq/2eOxUuYXqwP6Yu96PEQ2esozvUbX++iiqQxRW3eWLb0fmZqyJ6g7l5QXNEh88KIQ
         lqSGWgP1vq/jXX3JOsvaGgkmUxbhlyOeFWdRKmU7g9CRCqVxqfLYMAm4s1r8kBj5VuDn
         qi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVGN7Vuf2OES8d0E6KIMK5SLay2jC5tCW1R73Tr2cd4=;
        b=4X7W/Ywzdr5jnoP4U/3C2MDFo/6z0WQLZP16h+IiKR4sLUlg8TKSyWP2WU0x+0EaUX
         U5AL+FK7ILFK2FfzT/CsFIA9p+0ac2ZJx7gQzYsGXXwTkO7Tt8TYqJp85L3YVc45Iw2z
         SKMEpj6X9QqUjSiup5uPPjwq6UixnUx3QQhZQl+/JAfbvg+mtN/VdHz0cPsg8Uh8s7Pj
         8vUXSzZyK5SfgQnzRV5JXsvgBU6Mwaj3pQ1WlaJ2m5+0k7L3ioX8dh85Pv7xGL5JHMaI
         hLPtEv6U+z3oQlOX93kYT2LtOgHx1IM+kQyhyOCaLmJU1BTLg3bTKP8ScYT/3RxUaYIW
         gjaQ==
X-Gm-Message-State: AOAM532ZJ7P6TiwOAtD2jOWXR60943E+NPMzmlVlJbqOySTNtDRlRpVp
        i0WF0Y2d6eFyrzXJRUe7jhDCi+lGMRE=
X-Google-Smtp-Source: ABdhPJzG9p1wR3iUBlbRnnKrV8IMTkpnFql8HP8Dz5oQFflM82uqP6ONy8xHi2weMkt/TTGu5Itg3A==
X-Received: by 2002:a17:907:1c9a:b0:6df:bfc3:c9f3 with SMTP id nb26-20020a1709071c9a00b006dfbfc3c9f3mr18871647ejc.679.1649421980864;
        Fri, 08 Apr 2022 05:46:20 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id et21-20020a170907295500b006e7f1abe2ccsm5464622ejc.75.2022.04.08.05.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 05:46:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove SetHalDefVar8188EUsb()
Date:   Fri,  8 Apr 2022 14:46:15 +0200
Message-Id: <20220408124615.3687-1-straube.linux@gmail.com>
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

In SetHalDefVar8188EUsb() there is only the case HAL_DEF_DBG_DM_FUNC.
Move its functionality to a new static function in ioctl_linux.c and
remove SetHalDefVar8188EUsb(). This is part of the ongoing effort to
get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 29 -------------
 drivers/staging/r8188eu/include/hal_intf.h   |  6 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 43 ++++++++++++++++----
 3 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 285282b5fe35..5cbb982505a8 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1194,35 +1194,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 }
 
-/* Change default setting of specified variable. */
-void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
-{
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
-	switch (eVariable) {
-	case HAL_DEF_DBG_DM_FUNC:
-		{
-			u8 dm_func = *((u8 *)pValue);
-			struct odm_dm_struct *podmpriv = &haldata->odmpriv;
-
-			if (dm_func == 0) { /* disable all dynamic func */
-				podmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
-			} else if (dm_func == 1) {/* disable DIG */
-				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DIG);
-			} else if (dm_func == 6) {/* turn on all dynamic func */
-				if (!(podmpriv->SupportAbility  & DYNAMIC_BB_DIG)) {
-					struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
-					pDigTable->CurIGValue = rtw_read8(Adapter, 0xc50);
-				}
-				podmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
-			}
-		}
-		break;
-	default:
-		break;
-	}
-}
-
 void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	u8 init_rate = 0;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index ab6cab1281ab..532d02bba9f8 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -27,10 +27,6 @@ enum hw_variables {
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
 };
 
-enum hal_def_variable {
-	HAL_DEF_DBG_DM_FUNC,/* for dbg */
-};
-
 typedef s32 (*c2h_id_filter)(u8 id);
 
 #define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
@@ -51,8 +47,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level);
 int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
-void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
-
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index b6851628e4d2..6b655d65eafb 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3389,6 +3389,34 @@ static void rf_reg_dump(struct adapter *padapter)
 	}
 }
 
+static void rtw_set_dynamic_functions(struct adapter *adapter, u8 dm_func)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
+
+	switch (dm_func) {
+	case 0:
+		/* disable all dynamic func */
+		odmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
+		break;
+	case 1:
+		/* disable DIG */
+		odmpriv->SupportAbility &= (~DYNAMIC_BB_DIG);
+		break;
+	case 6:
+		/* turn on all dynamic func */
+		if (!(odmpriv->SupportAbility & DYNAMIC_BB_DIG)) {
+			struct rtw_dig *digtable = &odmpriv->DM_DigTable;
+
+			digtable->CurIGValue = rtw_read8(adapter, 0xc50);
+		}
+		odmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
+		break;
+	default:
+		break;
+	}
+}
+
 static int rtw_dbg_port(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -3674,15 +3702,12 @@ static int rtw_dbg_port(struct net_device *dev,
 				rf_reg_dump(padapter);
 			break;
 		case 0xee:/* turn on/off dynamic funcs */
-			{
-				if (extra_arg != 0xf) {
-					/*	extra_arg = 0  - disable all dynamic func
-						extra_arg = 1  - disable DIG
-						extra_arg = 2  - disable tx power tracking
-						extra_arg = 3  - turn on all dynamic func
-					*/
-					SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &extra_arg);
-				}
+			if (extra_arg != 0xf) {
+				/* extra_arg = 0  - disable all dynamic func
+				 * extra_arg = 1  - disable DIG
+				 * extra_arg = 6  - turn on all dynamic func
+				 */
+				rtw_set_dynamic_functions(padapter, extra_arg);
 			}
 			break;
 		case 0xfd:
-- 
2.35.1

