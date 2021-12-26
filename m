Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507E847F838
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhLZQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 11:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLZQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 11:29:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA1C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 08:29:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j18so27726735wrd.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbBCQPiLPvbvH63E7sGlrAGyH6uOANlIz6hb4LK+I7Q=;
        b=lBWJU8wCeKvYRIJCxJJZ+qhBDBKOYed+laVvOec7wASpxrDJOKfDEWsBF6/cTyfIio
         0uOnwG8uSiIU9B3j4OjPV48hDrhb2y7alXJfHyKm+Clp5DGNSXX1nciUft6SnXGTj/eS
         BxVgJ9qCUQEZFyVux3KM9TyfrXiNfBhBnEesAgo7UUypmIJWkQB0OHJV1rese1iWKqCE
         H2GsQ/TiaOby3HeBzDUL2+hcGHq8N7VDaAX9MRL1HHC/hEivnbNodxwt34zkLC0jHug/
         mT9M7IHBzKY42uz4IZp9JSbluXN1zR06+mTHLcbnqN31zGxW0hwdLQDFdQFeabxDnk2R
         0hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbBCQPiLPvbvH63E7sGlrAGyH6uOANlIz6hb4LK+I7Q=;
        b=oDH2wL7UC7/1zNlY8BIUphwq04t+1Dmx0o4uIBYlAyQbO9PlfF8hptl/fwwcR0EBxR
         lIBlmZU5p/0F8ccqRe0NLCHt/PD2JYgXED1+FEH85KySxEkuO44YRTZMvFr8MCkSyf0B
         HoVJgoKmOemmTPmuths64cvEkDFcJfBEhacjR0Qndn9jppDMPOeSt0CmiMwGFZ1bpB8r
         q30GTlIyD6qJAHntPPjyF5XWJ87Qdg2lGG4tm06FiQVkdu68itoy0GQzUoaicMc2Itlr
         BEtq5bzKI4drwk6TZwUVZyXOAGdZvjcWgViC39vp4oQiSx+m8lDQ5qAqVwCh0fTDugVm
         zsZg==
X-Gm-Message-State: AOAM531Y/bJKpkjixyYpJJZJWEzpN59U7MAMOp+FLlFObnm/mcyn8QNS
        al3ByQGWnqpsSJ1tqWeLtHilF7VKtPw=
X-Google-Smtp-Source: ABdhPJwqVNmE7rzX4E1GAY5vuAAYqUQwpoKZA2UYPwdUEuYq3Y67nlv3TXQQpMrz+O8kxojPBmO+fw==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr10511495wri.8.1640536166883;
        Sun, 26 Dec 2021 08:29:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id j39sm10785259wms.0.2021.12.26.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 08:29:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: DM_PriCCA is set but never used
Date:   Sun, 26 Dec 2021 17:29:21 +0100
Message-Id: <20211226162921.10227-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field DM_PriCCA of struct odm_dm_struct is set but never used.
Remove it and remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c              |  1 -
 drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 15 ---------------
 drivers/staging/r8188eu/include/odm.h          |  9 ---------
 drivers/staging/r8188eu/include/odm_RTL8188E.h |  2 --
 4 files changed, 27 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 7a42687b3128..a820bdc26fbc 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -152,7 +152,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 	odm_DIGInit(pDM_Odm);
 	odm_RateAdaptiveMaskInit(pDM_Odm);
 
-	odm_PrimaryCCA_Init(pDM_Odm);    /*  Gary */
 	odm_DynamicBBPowerSavingInit(pDM_Odm);
 	odm_TXPowerTrackingInit(pDM_Odm);
 	ODM_EdcaTurboInit(pDM_Odm);
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 8af45c7535ea..34530fcd00d8 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -260,18 +260,3 @@ void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV))
 		odm_HWAntDiv(dm_odm);
 }
-
-/* 3============================================================ */
-/* 3 Dynamic Primary CCA */
-/* 3============================================================ */
-
-void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
-{
-	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
-
-	PrimaryCCA->dup_rts_flag = 0;
-	PrimaryCCA->intf_flag = 0;
-	PrimaryCCA->intf_type = 0;
-	PrimaryCCA->monitor_flag = 0;
-	PrimaryCCA->pri_cca_flag = 0;
-}
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 19e859b989ad..306640e92e6f 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -81,14 +81,6 @@ struct false_alarm_stats {
 	u32	Cnt_BW_LSC;	/* Gary */
 };
 
-struct dyn_primary_cca {
-	u8		pri_cca_flag;
-	u8		intf_flag;
-	u8		intf_type;
-	u8		dup_rts_flag;
-	u8		monitor_flag;
-};
-
 struct rx_hpc {
 	u8		RXHP_flag;
 	u8		PSD_func_trigger;
@@ -487,7 +479,6 @@ struct odm_dm_struct {
 	struct fast_ant_train DM_FatTable;
 	struct rtw_dig	DM_DigTable;
 	struct rtl_ps	DM_PSTable;
-	struct dyn_primary_cca DM_PriCCA;
 	struct false_alarm_stats FalseAlmCnt;
 	struct sw_ant_switch DM_SWAT_Table;
 	bool		RSSI_test;
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index 96e50c9224aa..85a0d7ec7378 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -29,6 +29,4 @@ void odm_FastAntTrainingCallback(struct odm_dm_struct *pDM_Odm);
 
 void odm_FastAntTrainingWorkItemCallback(struct odm_dm_struct *pDM_Odm);
 
-void odm_PrimaryCCA_Init(struct odm_dm_struct *pDM_Odm);
-
 #endif
-- 
2.34.1

