Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2194D599D41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349450AbiHSNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbiHSNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DCFBA6D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a22so5736110edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hRYX9Qb8xgVcO72OHHpEJqvkK+/eKUc0GJTr4L8+CVs=;
        b=f0o/htZwQHgDORpIN53D4O7FzqXU1zTEw/wWvixVmpVQcl1Po03p2kicqYdQAqOYhS
         5cJZNv9+FJFT19JORkV1uIg45xF+bwWWX311dwgxtv5WQyaS37GjOvCzr7vpcPqSQPf5
         RxOuShCKbKZUxzWpQLU/gVwk+6yxFiK3gqh6jcMiPG2gYrteDJM4bDXFUvOBNd1x53vL
         2ZDJ6lLlhVr6KzMuFZRKViY6JT3lCjp/MoTPVgOrl7FNRubXa5DQnTUGNMq3kbu9i1PY
         VZKmWyi4X9fwW+Xu58k6exm4qB6RWk3oq0Gqisu5JvPYNJQOUUlA85MdqFVfhsjzzWlJ
         HvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hRYX9Qb8xgVcO72OHHpEJqvkK+/eKUc0GJTr4L8+CVs=;
        b=M3CiCZ3lEPrWZ4vnDbpXcgwq3/ffqSAPyGONvI4dasn9K+CiSol2N1HgdddTb5kGRf
         aldcwcbYFqGQWm33gmrsDZvF9NkWXtjpQM87Ml9w7j1Erjy9XQFrd3pnSVqxzDQYm/C3
         7QMB1u4iiWNYxzPdSdnvjLbjKi8o0XgKDJIkadylWwNZUK2BnUGJgrveEbxXn6qwisIf
         zETGu4vKralk9hUMKtl711rWTUxyCXRa+tXL2OP665YgB1ZEFyqO1a6R2ZpNtqb0V9oD
         Y1a05heqHWSF997T2jN/ZMfEUw354GJt692i6sZWIKbNL/i5sX0oQ2622hXZFPkJMYAb
         axHw==
X-Gm-Message-State: ACgBeo15gnFfR1E4ZHipn0GTHE+0opQcl6AcD14J9lY+MzRTPctwZSkp
        MRv0gfrKz8r27pWyXMfM1BQ=
X-Google-Smtp-Source: AA6agR6zI3qiRl8/pfFxaePE28E7zQtoxndWxw8UzIrwRHhsLKd9VNYWn5vTY/soXEjRf+6jEfUyXg==
X-Received: by 2002:a05:6402:328a:b0:43d:f295:f14c with SMTP id f10-20020a056402328a00b0043df295f14cmr6336780eda.299.1660917029690;
        Fri, 19 Aug 2022 06:50:29 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:29 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 3/8] staging: rtl8723bs: remove function rtw_odm_ability_set
Date:   Fri, 19 Aug 2022 15:49:37 +0200
Message-Id: <35d0f2115fa6febd72a1a7d1c740dece3d55a3df.1660916523.git.namcaov@gmail.com>
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
index abb111752169..ec8406c18b03 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -129,11 +129,6 @@ void rtw_odm_ability_msg(void *sel, struct adapter *adapter)
 	}
 }
 
-inline void rtw_odm_ability_set(struct adapter *adapter, u32 ability)
-{
-	rtw_hal_set_hwreg(adapter, HW_VAR_DM_FLAG, (u8 *)&ability);
-}
-
 void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(adapter);
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
index 27e8240284b4..ea9c4de0f284 100644
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ b/drivers/staging/rtl8723bs/include/rtw_odm.h
@@ -18,7 +18,6 @@ void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter);
 void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
 
 void rtw_odm_ability_msg(void *sel, struct adapter *adapter);
-void rtw_odm_ability_set(struct adapter *adapter, u32 ability);
 
 void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter);
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini, s8 TH_EDCCA_HL_diff,
-- 
2.25.1

