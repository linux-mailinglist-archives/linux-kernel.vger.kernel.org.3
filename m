Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27F4F0B5E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359502AbiDCQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359506AbiDCQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:55:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CE3916E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b15so8434358edn.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8SD2tWDFceFBc3Hy1HeduUtsXtz9wGLYrV1mAwzJ0s=;
        b=Ih+Vq66PmnEQifzPGWEAQYjEm+s7ZH/05V3TJsrkeZGdMphKGy6AksqvOuRbbCZDF5
         TK7cNEWdUiXK4Xme+ls/AZW+QHfMO8fYf6iD2KZGwiz7kapsMsfM4yJYI/vC7ab4E/bE
         m5KBaoUuG5CE8S/bDgzJfNzIGYdVc6gvk3LGQ1xC/cfdQhcw9J1h15WeVaBvLfkLHpZw
         pvc9Xg9ABwKQr9gm8RSqFcXYZTPhRRo0+WkPa3pwzH8yTmxhcLjlqqnxyjxMYXwcJffi
         e7iNqaz5BzOLQlUjjygJQr2yBIwmvtM7LbZFEZQ4740zxLHFeqwNHAj7RmFV3KtW0pFc
         W7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8SD2tWDFceFBc3Hy1HeduUtsXtz9wGLYrV1mAwzJ0s=;
        b=fFCosIYzL2ist158p1eTx9trP6lCZ2smLwRR53eYYoy8KCFmXn98RD/Aqs9829Y218
         esFfZYjCNpknUrRzrWSLnwSgh+ZjCHOwDNuR3vcitmj5eO3pmlrzSoBWGXtYPZxE1qId
         CKQzp+3yBaPwf9Bdm0swRTZc2NMcrnxoo5ZIOhf9Duf8SDbApmzdQ6ykM7SKh9G1BdW4
         AmLL6ZDEWDDKF6COUGKG7aWCj9lqXvdcKItL05W8rCS+2TUw9vICiwm+FTux7HVSeOcb
         WqY3xIgZcPHwToqC4YnRaKMb/BhJoBsNAtRBtPBwGvp06d4KonnBdAhW7Av+xOldCSGv
         hi2w==
X-Gm-Message-State: AOAM530kUFYWW1ta1faY43prp7lG0mLrVV2Z8TP8kNYgsnyMNmniIwGi
        mdvWV8YnVhOjwktBdgmk1tQ=
X-Google-Smtp-Source: ABdhPJwoufX7FfTOIR7O9fnlvrUb3MRXpRmZ/cTL5hm9tssCGUowDNRxlJSm4ANp1ZVQrxBicYHTZQ==
X-Received: by 2002:a05:6402:4254:b0:419:245b:8051 with SMTP id g20-20020a056402425400b00419245b8051mr29645806edb.295.1649004787558;
        Sun, 03 Apr 2022 09:53:07 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm4018138edu.11.2022.04.03.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove GetHalDefVar8188EUsb()
Date:   Sun,  3 Apr 2022 18:52:55 +0200
Message-Id: <20220403165255.6900-6-straube.linux@gmail.com>
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

The local variable odm_flag in rtw_dbg_port() is set but never used.
This are the last two remaining calls to GetHalDefVar8188EUsb(). Both
calls can be removed and we finally can remove GetHalDefVar8188EUsb()
itself. This is part of the ongoing effort to get rid of the unwanted
hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 14 --------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  8 +-------
 3 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 7a7eceaac311..028ccce2c282 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1212,20 +1212,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 }
 
-/* Query setting of specified variable. */
-void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
-{
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
-	switch (eVariable) {
-	case HAL_DEF_DBG_DM_FUNC:
-		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
-		break;
-	default:
-		break;
-	}
-}
-
 /* Change default setting of specified variable. */
 void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 92ba276031b0..c24059bab981 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -52,7 +52,6 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
 void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
-void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d127cebb6eae..b6851628e4d2 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3675,22 +3675,16 @@ static int rtw_dbg_port(struct net_device *dev,
 			break;
 		case 0xee:/* turn on/off dynamic funcs */
 			{
-				u32 odm_flag;
-
-				if (0xf == extra_arg) {
-					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-				} else {
+				if (extra_arg != 0xf) {
 					/*	extra_arg = 0  - disable all dynamic func
 						extra_arg = 1  - disable DIG
 						extra_arg = 2  - disable tx power tracking
 						extra_arg = 3  - turn on all dynamic func
 					*/
 					SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &extra_arg);
-					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
 				}
 			}
 			break;
-
 		case 0xfd:
 			rtw_write8(padapter, 0xc50, arg);
 			rtw_write8(padapter, 0xc58, arg);
-- 
2.35.1

