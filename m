Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4739E599844
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347791AbiHSIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbiHSIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57D75CDA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w3so4859318edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DrYs5wXMzkTkGQcWHMkczyKadrbT/RhKmAvnzhy1suA=;
        b=VwMe+OXtIYgPysKzYyius0umRigerBJorA1Uo/QI46XTJ3EddCrkG77sHIFapNycVj
         YujRthOrH10Plo27Co7fXeZz9HpjQHGgdJX3dtF3UKX+ENQ3z79D6vGepasexT4mPLjM
         u9gx/sJ8rgjJVahcf7sWqkNyCpcQ+Nm+okGoWlLTfJWXC4JgmH65tolWXuuivZxhSzVD
         nsAGOjO+CbbvU8WyaZ3wpwD9nF9f0DBbIZ776en24N1sI1KZFrz4lgfSah+7ZVpLaK/m
         PRafSGYS8739V6J2kr6BP4uGuhhnUOTmtcqBg9A4yu/ICUwrWHPP5AvkmpT4v+vqOcDM
         Jc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DrYs5wXMzkTkGQcWHMkczyKadrbT/RhKmAvnzhy1suA=;
        b=3hzz7OFadhpaLcDspk7Cf3cWPg4LosfRe09JTSkt+wvuvYoURJKgnPP3WFaicuwyHR
         0IsssVGP08xtqEzoWvXSD195KXL3rZJXlx/DrwK4WRp9MfwOGnX2g7DUuCipsJqh5tvN
         XBvll3OjTd1H8SuLAQI3EJ4ZWUyuuZQ2GID+CLcC07cvIcs1YSKiZhIxYBLMz4N6rCbG
         KuURTiGIFix7w7WPAiMkB/KDP2PLFeWLEFM3tTBA7Vq1Y5CX8Pz1FBc3zZzsea02cg+w
         AKBCW0FKzgRNoXuO/VK+wfHJgsGIMiSvrqont2UC6y8g5nLamPCKnkE+CBuOQKA3GdED
         kiBA==
X-Gm-Message-State: ACgBeo0FTrpd9IG7pbjexsH1ObIOvrvzYMUEzeSepBNHxSwyRP1FWinp
        irT0AQSNE7fCWTEVslB/3Os=
X-Google-Smtp-Source: AA6agR5WUZEJyI9HqojImXN4Drgb3PeklRM2HZ44q+D+us85SilFbfI6p2KJO8am5rW9Yl8/asMZcQ==
X-Received: by 2002:a05:6402:1044:b0:446:27c1:49a4 with SMTP id e4-20020a056402104400b0044627c149a4mr3388296edu.53.1660899245286;
        Fri, 19 Aug 2022 01:54:05 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:04 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 1/7] staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
Date:   Fri, 19 Aug 2022 10:52:51 +0200
Message-Id: <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660898432.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660898432.git.namcaov@gmail.com>
References: <cover.1660898432.git.namcaov@gmail.com>
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

because this function is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_odm.c    | 16 ----------------
 drivers/staging/rtl8723bs/include/rtw_odm.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index f6b73a2a0270..abb111752169 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -90,22 +90,6 @@ static const char * const odm_dbg_level_str[] = {
 
 #define RTW_ODM_DBG_LEVEL_NUM 6
 
-void rtw_odm_dbg_comp_msg(struct adapter *adapter)
-{
-	u64 dbg_comp;
-	int i;
-
-	rtw_hal_get_def_var(adapter, HW_DEF_ODM_DBG_FLAG, &dbg_comp);
-	netdev_dbg(adapter->pnetdev, "odm.DebugComponents = 0x%016llx\n",
-		   dbg_comp);
-	for (i = 0; i < RTW_ODM_COMP_MAX; i++) {
-		if (odm_comp_str[i])
-			netdev_dbg(adapter->pnetdev, "%cBIT%-2d %s\n",
-				   (BIT0 << i) & dbg_comp ? '+' : ' ', i,
-				   odm_comp_str[i]);
-	}
-}
-
 inline void rtw_odm_dbg_comp_set(struct adapter *adapter, u64 comps)
 {
 	rtw_hal_set_def_var(adapter, HW_DEF_ODM_DBG_FLAG, &comps);
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
index 94fc68a5c424..27e8240284b4 100644
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ b/drivers/staging/rtl8723bs/include/rtw_odm.h
@@ -13,7 +13,6 @@
 * This file provides utilities/wrappers for rtw driver to use ODM
 */
 
-void rtw_odm_dbg_comp_msg(struct adapter *adapter);
 void rtw_odm_dbg_comp_set(struct adapter *adapter, u64 comps);
 void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter);
 void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
-- 
2.25.1

