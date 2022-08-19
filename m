Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E844599803
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiHSIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbiHSIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16098D19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e21so5395edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=meuYSHAo/A5Ok1qkNjeYNT8E0hFFDPVG1zV7y+jAVHY=;
        b=eSvTxLLnbqMqzFWxm8LILKoYi6s56iLyYyvrkQ2ukU/qwcp8JaFQpXGELAIriB3IJH
         odgFCnwXhQfDodM5kQWxcVYCg1O0fgpXLNyhuxU5k0xIhooBjXO/te4V865nbOS6vNkE
         JqSQxvEyzRndr5lNY2aBx+kOfZaLq//1y1uSZyt6WkhLUvN1IyR7oc1kibfsI/Klx4by
         kwkOAL00NvqV++L7wVrd0IqPm/g0JI3C8Uyo/FLRSMMS6hidJva0+Rvo2IJR4VAamI13
         F1tHlSfqj1vKXO0zdReoGHkQqu96stlHswn9T1+qMxDJJK1kLm/DeDlD9wF8w2Pzxhu1
         /FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=meuYSHAo/A5Ok1qkNjeYNT8E0hFFDPVG1zV7y+jAVHY=;
        b=j87kHVBpko9YobkgQd3KXkEoPKQQ7Tqba+1YvP5EincZW1otdvokR+R3XESWqr2CQ3
         uYqrUdq11WcZDm2dlEFGZjrv745Dpq+Ov0SIBRKauHclSghWG9Rtxr2ZuGYXg0e6riRV
         4IrHQWvFrU8yr6z/SRmPvtmXi/kgOTv6T7beLgUAM4u4Jqjo19qros79OWPgl3Hrv+4B
         vKUKMDNP9iDeilWvyoSGuIncpz9AjUfe6fGb8xzSwDXzbWl+nFu9CDykIQaxtGbI/I4P
         js6R+4+UIelhQbEKoYJt7XSwbrYY7yNL0elKxKEd5/R5mtYkcYqN6z774SPsA0UgGksS
         1m4A==
X-Gm-Message-State: ACgBeo1Fp0x5aIB8ZviSeB9glHq7QahgNWRZgnVraCO2ynIeChD4ooBt
        lZE7zjPsy94KyqoiVmq89QqKFiyk406xgQ==
X-Google-Smtp-Source: AA6agR79aExTGcwUe0On9Ih0n7/GYqU12C75vM3DTcu6b2iWtvI6OXm+nczfqnQPU6fHrMYxyFX8NQ==
X-Received: by 2002:a05:6402:540c:b0:434:d965:f8a with SMTP id ev12-20020a056402540c00b00434d9650f8amr5352222edb.30.1660899250356;
        Fri, 19 Aug 2022 01:54:10 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:10 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 6/7] staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
Date:   Fri, 19 Aug 2022 10:52:56 +0200
Message-Id: <24c3baa696adb7633d643258b60bba9bcd18b953.1660898432.git.namcaov@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_odm.c    | 18 ------------------
 drivers/staging/rtl8723bs/include/rtw_odm.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index ec8406c18b03..2cba7825c9b3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -129,24 +129,6 @@ void rtw_odm_ability_msg(void *sel, struct adapter *adapter)
 	}
 }
 
-void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
-{
-	struct hal_com_data *pHalData = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &pHalData->odmpriv;
-
-	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
-		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
-		   "AdapEn_RSSI", "IGI_LowerBound");
-	netdev_dbg(adapter->pnetdev,
-		   "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
-		   (u8)odm->TH_L2H_ini,
-		   odm->TH_EDCCA_HL_diff,
-		   odm->IGI_Base,
-		   odm->ForceEDCCA,
-		   odm->AdapEn_RSSI,
-		   odm->IGI_LowerBound);
-}
-
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini,
 				 s8 TH_EDCCA_HL_diff, s8 IGI_Base,
 				 bool ForceEDCCA, u8 AdapEn_RSSI,
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
index ea9c4de0f284..be0d47413fd2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ b/drivers/staging/rtl8723bs/include/rtw_odm.h
@@ -19,7 +19,6 @@ void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
 
 void rtw_odm_ability_msg(void *sel, struct adapter *adapter);
 
-void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter);
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini, s8 TH_EDCCA_HL_diff,
 	s8 IGI_Base, bool ForceEDCCA, u8 AdapEn_RSSI, u8 IGI_LowerBound);
 void rtw_odm_get_perpkt_rssi(void *sel, struct adapter *adapter);
-- 
2.25.1

