Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6884EDA35
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiCaNHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiCaNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126C4A3D4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c62so28091924edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDkMgRtARbafWLIsbRUHsKRuUskVl4hLD8Sy8XkZqqQ=;
        b=RuBqpGSqjVaNIFU0quQSMU7nMkXosvjERI4FrDrlsgaGgLhK7/ARVZFry+fAVp5s6S
         hq5MsxLjysLVqULWFzG5uFc3dGwdt+l1F5cuib5Evgsp+n3/C4j7gkf0qGTpyC8D7Ee7
         rT9VRxPfPa4O47VYd+paKpeo/6OXAbd61PMNSi6vaC2rz7HE07gY6WpDne/AxvKJV0ro
         1b90+Dgxu3gkPnGQktk/lmBWr4rzxXrSgZSB+MZ53RFqWUttx+vUbLVYQOOH0ct32Z/D
         p/dzmDFriyTZoPxKpfxOlAmxNzcpjIBb/mBnfMt1u5jUQFok19miYGi+yzl2x2tSR08M
         2G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDkMgRtARbafWLIsbRUHsKRuUskVl4hLD8Sy8XkZqqQ=;
        b=pt801eXOFLfEsD9fuEKEqn+/jZGq7NCtOtHzV82LYW56H6UdRBcPSE3h9YWYxLHRNB
         aVa5nhsd0/gSrVx5qYD89ZebBbMZaQDUNfn0D2xEAismXAPEwYt0PZyThNQsubjgxFEz
         IYcYMf/R+j5fJOYdKEf8aEaXqvz17nOCdqvD9NNPpEH/5O7aQbW8G0YiPNk2IottxL36
         xDRv07SjY6Yd+VslCy2ZHS7GGFNwvdHH4Rq7fOolrGdmhmI0FNgKW019vcFGbJJQk1i/
         iWMEOJKgWpBqTPE/XEZdP0iu5+2zQvTKWinVP+2pN1kO1K/AhJ5GyDeRyjSU+dWiikol
         g1XA==
X-Gm-Message-State: AOAM530samq2DF57+kk7P0/0UA53iDcWejXtVpJx0T2V8I+ga0RbiypC
        42olJNVAkSjYcZKPUILWEw0=
X-Google-Smtp-Source: ABdhPJzlp512fZ6CXDDdg1NM8qbyrCqIy1+fO2jPvqpDCyPTWMsKe07QK7eYVqWYDPJO22cPiDbllA==
X-Received: by 2002:a05:6402:4248:b0:419:4583:eaa2 with SMTP id g8-20020a056402424800b004194583eaa2mr16571892edb.376.1648731933208;
        Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm9333358ejc.197.2022.03.31.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:05:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove GetHwReg8188EU()
Date:   Thu, 31 Mar 2022 15:05:22 +0200
Message-Id: <20220331130522.6648-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331130522.6648-1-straube.linux@gmail.com>
References: <20220331130522.6648-1-straube.linux@gmail.com>
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

The only call to GetHwReg8188EU() that is left over from previous
cleanups sets a variable that is immediately overwritten. This call
is useless and we can finally remove the GetHwReg8188EU() function.
This is part of the ongoing effort to get rid of the unwanted hal
layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 15 ---------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  4 +---
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 37c56690b13a..6b4b0b0c4f53 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1283,21 +1283,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 }
 
-void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
-{
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
-
-	switch (variable) {
-	case HW_VAR_DM_FLAG:
-		val[0] = podmpriv->SupportAbility;
-		break;
-	default:
-		break;
-	}
-
-}
-
 /* Query setting of specified variable. */
 void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 0033a0aca27b..9b465001975c 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -66,7 +66,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
-void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
 
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7df213856d66..6383b399ae40 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3620,9 +3620,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			break;
 		case 0x06:
 			{
-				u32	ODMFlag;
-				GetHwReg8188EU(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
-				ODMFlag = (u32)(0x0f & arg);
+				u32 ODMFlag = (u32)(0x0f & arg);
 				SetHwReg8188EU(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 			}
 			break;
-- 
2.35.1

