Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE45997FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbiHSIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346481AbiHSIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DADBAEDB9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i14so7588099ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xYBRhSDok53eb0OvQN4XDJTh9o2Zw4fM6AIaxBqnM/k=;
        b=ltdvzkJRO9g2IMP5iAVwgdjpl0KDRL0IG3LSpk4IBLDzc/KPGdw9U+rjTiGUI5Uemz
         0Koyktpo0sYtmEWn8siCBEcp9dgM0ON/9MZeX7t0dqGJiTXtjeHmzP6CTMO7d6uGPgas
         AX+Ek87nsl2r8G3RcnUdpz6uLqk/oOwxhpw4G36ksJ/7+EGErTfgmhSMJL3XvqtwNj8E
         eBH/sScrEuYCYHA/5FeF9gJ9/YpIS3GII/tI6hr0CvTfIa6E15f3nDx53QjcjjrsZ6Pd
         Vl97bRM0mK8VoYceRVo/gEzGb785J6wFnu7qGgIlmxhCFQrpfZcvS5IBXZ1yC8Ocp960
         s0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xYBRhSDok53eb0OvQN4XDJTh9o2Zw4fM6AIaxBqnM/k=;
        b=p+pwfu0nx9ouNHYEWkruHHQq+q+Q+dEPuJypaFLDPV5KjVx1aOaB+AdxabTfwG6xKr
         5Cs4qZId1JVoxCvE9MwGsXyZLLXUZApEdIuFHg9kEfOLQuuxEryWVK0PKa1x4C/sam5S
         IPiNaNx5y9kp3VvuHtUBTOdyTlYork8dME3m5qtw91uW/7ABkrLEWpEiEsJqtKr0cnuo
         bs0JsU26mY9zlugN6Sw11uFlMINHvpJWfQphglIRFldjYlzQK97WeatOE5OO4Gucv/0H
         +5UQgIxDYaVVPMJzGsCennMY6xzThoQXGulhZwSvwex4BHUE8bsO4rIOTJxBBjNKyjml
         YB8Q==
X-Gm-Message-State: ACgBeo1anyeArDkNQsFJiZ9yDgi/NzWIRxUo/kjbGn7GNY0RU5xAmPNm
        U6J/I2G/epgsucpEqQJOtlVO+/KD08Qeag==
X-Google-Smtp-Source: AA6agR5AVVX8Bhx+h0cLCh1hbXIILyI8JLqKQvYeEvO2DBkVvyckuyYRwtaLGKgumDy8vWrKgnjS4A==
X-Received: by 2002:a17:907:2bc4:b0:730:aa9c:bd86 with SMTP id gv4-20020a1709072bc400b00730aa9cbd86mr4243212ejc.341.1660899251902;
        Fri, 19 Aug 2022 01:54:11 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:11 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 7/7] staging: rtl8723bs: remove function rtw_odm_dbg_comp_set
Date:   Fri, 19 Aug 2022 10:52:57 +0200
Message-Id: <e1927eb6151d39b53a6ce1eed1d7ad20a2d633be.1660898432.git.namcaov@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_odm.c    | 5 -----
 drivers/staging/rtl8723bs/include/rtw_odm.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index 2cba7825c9b3..58b6299ed9d7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -90,11 +90,6 @@ static const char * const odm_dbg_level_str[] = {
 
 #define RTW_ODM_DBG_LEVEL_NUM 6
 
-inline void rtw_odm_dbg_comp_set(struct adapter *adapter, u64 comps)
-{
-	rtw_hal_set_def_var(adapter, HW_DEF_ODM_DBG_FLAG, &comps);
-}
-
 void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter)
 {
 	u32 dbg_level;
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
index be0d47413fd2..6a431c121285 100644
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ b/drivers/staging/rtl8723bs/include/rtw_odm.h
@@ -13,7 +13,6 @@
 * This file provides utilities/wrappers for rtw driver to use ODM
 */
 
-void rtw_odm_dbg_comp_set(struct adapter *adapter, u64 comps);
 void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter);
 void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
 
-- 
2.25.1

