Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C924466A60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376803AbhLBT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhLBT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87503C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so2307837edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hucBawdxhi54mMwdEP0JYBCWSxKtvfTJGsGhMSfgi0=;
        b=ImcIA2TmYkc4DExBQ1ghrTuHlJbRsEYe5RkSoTxxraD9L2WmPVNCw6WQ9Icj0k7cuj
         oAw+yCljcD1RbzslNG1iouCHQ3k9OhzpYJoARjorir8XC77Wrkh3aH1PF70Hy4c+58Fe
         M4UhRuXQrklMSm9nZO2uV/byOFYe2T8o6jU+d8rbJQxDL3Gk5NqRsso3AHGKnJ6EWVah
         aueWPLI4hXdWj8CyQwNMFN4/nt2jfV/SD9DA6fog66HJU6LbtqbPtkcSt10N3lixGe8Y
         MlNUPFtGu+pxLh/QXRMSuaqxmu+wJP6aBcyXtst7l+8waiwCeaTB3Im1Qe+N8j0FC8Cp
         aC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hucBawdxhi54mMwdEP0JYBCWSxKtvfTJGsGhMSfgi0=;
        b=RcTFd251uAaOOZDuVdwdcwkkhL6Vj4D0mHWIsROw/cca359IA0eEX+44WCe7PFyAMU
         KdIYLycTdRmKL4h4IMx5BpbXG9aAZ1Qht7lLjjO4UL4wlSA2b8qhg6w8L72rgARlGouA
         FiAEoxiUfcqFRXo71TrgjauY0E9o8LRDaBMysK9yQ1RGRy9vSmcPCiTF9Z7AzJ3F9Vtu
         WJOgH5PoAHSNRt5C1t7aUT5RgSwpRW57A0qrRzk7H4xAf9/DOVma7VF8KwrYp2BGWT3j
         iJ6i5vf6Nm/FUxTS695vL17FHM6moSoOzh+vDsVmMK9/g6r/bPbV8QPHZsRLRbZEgmIs
         21Gg==
X-Gm-Message-State: AOAM532ojZrob0BrA69L1LmXqmNK2A3/rjzNrpguREtrA6/xn71G9D0R
        LNaEjE41+v3D8bNzOHZf/DA=
X-Google-Smtp-Source: ABdhPJydvong/74MxBo+3spVnP42b2MXyvxp0KiaCdtDSt5VrV3bOm8HINfP5p1Fy2pkr9M3rws/Fg==
X-Received: by 2002:a17:906:c109:: with SMTP id do9mr17414361ejc.48.1638472998132;
        Thu, 02 Dec 2021 11:23:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id jg36sm432530ejc.44.2021.12.02.11.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: pbNet_closed is set but never used
Date:   Thu,  2 Dec 2021 20:23:06 +0100
Message-Id: <20211202192309.9362-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202192309.9362-1-straube.linux@gmail.com>
References: <20211202192309.9362-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pbNet_closed in odm_dm_struct is set but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c         | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 drivers/staging/r8188eu/include/odm.h     | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 182ec5dc2773..aa5249505fde 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -252,9 +252,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_POWER_SAVING:
 		pDM_Odm->pbPowerSaving = (bool *)pValue;
 		break;
-	case	ODM_CMNINFO_NET_CLOSED:
-		pDM_Odm->pbNet_closed = (bool *)pValue;
-		break;
 	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 5d76f6ea91c4..5725774cd89b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -75,7 +75,6 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_MODE, &Adapter->securitypriv.dot11PrivacyAlgrthm);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &hal_data->CurrentChannelBW);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &hal_data->CurrentChannel);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_NET_CLOSED, &Adapter->net_closed);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &pmlmepriv->bScanInProcess);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_POWER_SAVING, &pwrctrlpriv->bpower_saving);
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 2f99d267d25c..f3f17ad2c1c6 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -234,7 +234,6 @@ enum odm_common_info_def {
 
 	ODM_CMNINFO_SCAN,
 	ODM_CMNINFO_POWER_SAVING,
-	ODM_CMNINFO_NET_CLOSED,
 /*  POINTER REFERENCE----------- */
 
 /* CALL BY VALUE------------- */
@@ -491,8 +490,6 @@ struct odm_dm_struct {
 	/*  Common info for Status */
 	bool	*pbScanInProcess;
 	bool	*pbPowerSaving;
-
-	bool	*pbNet_closed;
 /*  POINTER REFERENCE----------- */
 	/*  */
 /* CALL BY VALUE------------- */
-- 
2.34.0

