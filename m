Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE61482B5E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiABNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiABNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:12:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0AC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:12:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so19829328wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SL33q0T27N+17/iPtiGm4sL345lSNfWeom9DBrdJo38=;
        b=ZRDCbSk53SBgUiOzigZJbHYCxTyT9J9Yx8iamqXNi7DpcCMvubH8vCTY0jEvG2zddR
         nyyCRmn/ovZMLBvkfY0PClerdj+fKC76zMiTdT4ImjHF6HMEDYwWayyb0asrCmZBrzAc
         4V/QACLekgM0iLAjSPYhpnlP2T85cmgNyexwFGc9j5ZdTy8Qv4AWjH8YsVFtVVKFxuJI
         U3jdMbrRG1lSU5s19YlVu7v9wXAzmvbThayB+h7wVlfQpX1ca5H7arFRXu7bSo08Z/TQ
         Q5BfFwczFSH16l4uYjc4O1FBFTYdL6/eHYR7pvgHbXQXGTuHA4bL69VThmAKcxGRDMMH
         1N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SL33q0T27N+17/iPtiGm4sL345lSNfWeom9DBrdJo38=;
        b=AMO/F/HBMXr6CYcnaQA77n/tfpG+mL3ivtXNxU73cquGRoMMW7gQL15OZkFSi3Z0Dm
         ghX98elcIv2lUcSLQMyTCf714hdvgwTPNpWJNwtPbCnlwc4d4B4I0pmuAOO/LY2OXiFe
         g1JfRuq4bjZRZNdyXqy+bQ8t0+9NPCEQb6pWfz11db+HLSQysMOjJseSqGaVXqhyBnoQ
         15dZCbAkyvw0gN5my8MRzMmmODduL3pLvqhHY0mgLdI5T6YXxHXXXA3vv6FToTRWp/Qc
         jW8n99hdLcELxDnCslxQMgU36hlBD6G+CD+9JYkCRq+smhZof6JWI35rDDAmHWzOGt4J
         FG0g==
X-Gm-Message-State: AOAM533IN7QLyMy01FyIXCaJU8kLG60ynkEcPI8F0Sl5fOggRy+M6N4b
        JdbPbapi+j70X/EJLSa0QPE=
X-Google-Smtp-Source: ABdhPJweyl8fyZpYif4tM1g25KKYjjpRvtalMuRQUYJAVGFQz6JG4Wdydv87pnVCxalkCayibHMM+Q==
X-Received: by 2002:a05:600c:34c4:: with SMTP id d4mr36115150wmq.53.1641129120196;
        Sun, 02 Jan 2022 05:12:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:59 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/11] staging: r8188eu: remove unneeded comments from Hal8188EPhyCfg.h
Date:   Sun,  2 Jan 2022 14:11:39 +0100
Message-Id: <20220102131141.12310-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded comments from Hal8188EPhyCfg.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index fe6111fe278e..e01de2ebb75f 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -4,7 +4,6 @@
 #ifndef __INC_HAL8188EPHYCFG_H__
 #define __INC_HAL8188EPHYCFG_H__
 
-/*--------------------------Define Parameters-------------------------------*/
 #define LOOP_LIMIT			5
 #define MAX_STALL_TIME			50		/* us */
 #define AntennaDiversityValue		0x80
@@ -13,10 +12,6 @@
 
 #define MAX_AGGR_NUM			0x07
 
-/*--------------------------Define Parameters-------------------------------*/
-
-/*------------------------------Define structure----------------------------*/
-
 enum rf_radio_path {
 	RF_PATH_A = 0,			/* Radio Path A */
 	RF_PATH_B = 1,			/* Radio Path B */
@@ -81,18 +76,7 @@ struct bb_reg_def {
 				 * Path A and B */
 };
 
-/*------------------------------Define structure----------------------------*/
-
-/*------------------------Export global variable----------------------------*/
-/*------------------------Export global variable----------------------------*/
-
-/*------------------------Export Marco Definition---------------------------*/
-/*------------------------Export Marco Definition---------------------------*/
-
-/*--------------------------Exported Function prototype---------------------*/
-/*  */
 /*  BB and RF register read/write */
-/*  */
 u32 rtl8188e_PHY_QueryBBReg(struct adapter *adapter, u32 regaddr, u32 mask);
 void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr,
 			   u32 mask, u32 data);
@@ -119,6 +103,5 @@ void PHY_SwChnl8188E(struct adapter *adapter, u8 channel);
 
 void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 				 u32 mask, u32 data);
-/*--------------------------Exported Function prototype---------------------*/
 
-#endif	/*  __INC_HAL8192CPHYCFG_H */
+#endif
-- 
2.34.1

