Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB7599D40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349474AbiHSNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349447AbiHSNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C1FBA6C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi31so2424469ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xYBRhSDok53eb0OvQN4XDJTh9o2Zw4fM6AIaxBqnM/k=;
        b=Og7OjeyCQub+mnMsVXkByrzBGbjqFb5M6FJbciWdd8jKCe/PjrMXLxYZXKeP67b9yf
         gifOWmVXR8tuUugno343Xitsus7qrdkSkgy4Kt97EDQDy5YyO5RVVbmDUQbaL1Nk7Zsb
         5J3OKzv7/lFiLh5NDKi1ALmsImnmFQpiB9t9xa2dyLuW9USzm3nMS8xIW0q3DIvZUT6g
         88V49UrbxOlPkb19zP5FxyG0AxGG6B63n7JqG5eSS7NSACRvmtlqOj40wgjyMYniJCgt
         lDoEWjkHvAzoStDXF6nemBy5Xtv5VQ5SPnOva1idz1qkcFf/0pvbC2MEmG1+JjXnm6KX
         YmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xYBRhSDok53eb0OvQN4XDJTh9o2Zw4fM6AIaxBqnM/k=;
        b=huH0M9RMZ6mvUYu5MHJZUlQxUUt+Ugvxe8cgMsJ4cn9ulEkyoa+ZObUuTWdOA4WsAr
         23Wy5iKMrlFwpvLl+QVoKVzEBlAS6vLlZgvSzbKL1Y0EbnPkPWhhPJfM4eTxFVBj6u3Z
         WKbVo49QrPMuaFuW/haXdHPFk/Bk7JzzCw+A3O54R0c1wz59Vqd29FkC+1rvWpuVbgZy
         uUrWTF7r1rFbD18JnTwmLvjjo+5zOEJhzEiHSyUhToy3MwOV7VyrmPCLgeQyoNJQX7T4
         A9KdIKsPfxGHGnHfowSmMtmK2Q0QOOv5iRqend3bklJFZv8ygXzL9unjd2GL83LzyAL1
         qubw==
X-Gm-Message-State: ACgBeo05BDMHO1uf3aCq7JVlMPEGtqsZY3E+yDRwpc3CDra8PimByGFG
        Se9pDAjXjfzLhovaEWPEG5U=
X-Google-Smtp-Source: AA6agR4rRXBz+CZgGIaBhY7QFou4TuAqGpdPkmyKaIgYamtZlNgH6yr0JL4je0bCUzO+WuFvqhgAKQ==
X-Received: by 2002:a17:907:a074:b0:730:c7a3:2c9 with SMTP id ia20-20020a170907a07400b00730c7a302c9mr4865846ejc.110.1660917034635;
        Fri, 19 Aug 2022 06:50:34 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:34 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 7/8] staging: rtl8723bs: remove function rtw_odm_dbg_comp_set
Date:   Fri, 19 Aug 2022 15:49:41 +0200
Message-Id: <e1927eb6151d39b53a6ce1eed1d7ad20a2d633be.1660916523.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660916523.git.namcaov@gmail.com>
References: <cover.1660916523.git.namcaov@gmail.com>
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

