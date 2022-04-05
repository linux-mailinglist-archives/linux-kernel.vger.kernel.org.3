Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B954F4E43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588474AbiDFAQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358879AbiDELRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69189CD9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:49:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l26so9515332ejx.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zViYAUFQVHIRikDuX6j+iM/MlBPaBYxpO5JyU8YFMSI=;
        b=HX7FccOo5jAwIAyUPKPVfO1C7rM0P2OVxOou/QVrnJSIT8xcG1zyigtwztrhCwtuY9
         ZmM78DmWkl1jSmUf0/sqnlU3hvYkKN9lXcyisU0IZ+cgFmbjyuE1H5TyxDwTavTb0gvU
         CAAMscYuY3SiXo+X1RhtxqSoVeU+ebWghnPhMSFrs+TuvIccWK9kKjRO/5GCbSTy4F7y
         +UxAuJuGV8ergvjCPFOyk23JC+QdVT/B9jmn7GfWJh6TDjo3JMPE3KWskuzQ88jxubQc
         a/9s1mTkhxnFQatLwgT/tuwaZ3Wrr5t/5G1gAi+FFjSQADlhFcR6vjLeZySxdKf6L4bn
         nv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zViYAUFQVHIRikDuX6j+iM/MlBPaBYxpO5JyU8YFMSI=;
        b=ZYYHOpXFLwNL4WmNEcpJ7Tb7JIDuwvTrKSGWySiBRZcyjWjxaqsNQa1iOeTeJhGkQX
         8aJ4nowJgN1gvebBWiZiKxhGKut/I37eucLB6Yavy/wMoGFZkVX8RCu03IzFqTcjD5Cf
         Ix9iVmOuF6Noij9vKRcSp5nVC5PlMNLjgt7BaNYWNpQKsr3GtHAbNRijZQY7Xyi9joBF
         oQpqnIGGbkSuU8puylDT/9DWsflVLT1s5WHhfSl5igsEloafP7NiS493jPU/jc+/KINM
         DoWPyhzE6qhN2a0W073R4ILd/66ry5ky8UZCchL0tM3U36oJFVVSOK+apySWltOJrfAc
         x5PA==
X-Gm-Message-State: AOAM533LL/juKywbPmyyU6h1N/YTt0aBTf1mS9rV1ccEG6eDtPvYAgYC
        WGCXXkM0k1wvtw6UStWbLsQ=
X-Google-Smtp-Source: ABdhPJz2XGP+0BiflWArPaHsDrJe6au9KfAeYxqej54AetrBlgpkuyRds+r5h/lm/oAs4/axf/h0FA==
X-Received: by 2002:a17:907:7f04:b0:6e0:39a2:79a6 with SMTP id qf4-20020a1709077f0400b006e039a279a6mr2775579ejc.243.1649155767360;
        Tue, 05 Apr 2022 03:49:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm2436702edl.28.2022.04.05.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:49:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/4] staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
Date:   Tue,  5 Apr 2022 12:49:08 +0200
Message-Id: <20220405104910.9769-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405104910.9769-1-straube.linux@gmail.com>
References: <20220405104910.9769-1-straube.linux@gmail.com>
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
the HAL_DEF_IS_SUPPORT_ANT_DIV case from it and move the functionality
into a new function. This is part of the ongoing effort to get rid of
the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
- made the function static
- used a more obvious function name

 drivers/staging/r8188eu/core/rtw_cmd.c     | 11 ++++++++---
 drivers/staging/r8188eu/hal/usb_halinit.c  |  3 ---
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 8b24330e97c1..66d4346a34ee 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1094,16 +1094,21 @@ static void antenna_select_wk_hdl(struct adapter *padapter, u8 antenna)
 	}
 }
 
+static bool rtw_antenna_diversity(struct adapter *adapter)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+
+	return haldata->AntDivCfg != 0;
+}
+
 u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
 {
 	struct cmd_obj		*ph2c;
 	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	support_ant_div;
 	u8	res = _SUCCESS;
 
-	GetHalDefVar8188EUsb(padapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &support_ant_div);
-	if (!support_ant_div)
+	if (!rtw_antenna_diversity(padapter))
 		return res;
 
 	if (enqueue) {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4bc6b08fb282..805460bd6340 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1204,9 +1204,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	switch (eVariable) {
-	case HAL_DEF_IS_SUPPORT_ANT_DIV:
-		*((u8 *)pValue) = (haldata->AntDivCfg == 0) ? false : true;
-		break;
 	case HAL_DEF_CURRENT_ANTENNA:
 		*((u8 *)pValue) = haldata->CurAntenna;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e222ab89bfc5..6a80e517a7ad 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -28,7 +28,6 @@ enum hw_variables {
 };
 
 enum hal_def_variable {
-	HAL_DEF_IS_SUPPORT_ANT_DIV,
 	HAL_DEF_CURRENT_ANTENNA,
 	HAL_DEF_DBG_DM_FUNC,/* for dbg */
 };
-- 
2.35.1

