Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708B599802
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiHSIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347518AbiHSIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588C7644C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e13so4823493edj.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hRYX9Qb8xgVcO72OHHpEJqvkK+/eKUc0GJTr4L8+CVs=;
        b=Zrdanl+ISS0t/bkFjxe38FKDpC4fChz8UY3qlFMBwI5B0xWU0HA9Z+g80uc/ASOWo/
         GuX73IWG2WYPEZrsQzUtig2dRC2SMsJ/+7Tl52u4XBuYU6cwGootc/r54lMwHoskpMlJ
         H+L+tJ8hlWcb7b5uSFoKk/e5fc6DjojWgmIYIN3CEtGArfo+GgGdU4zYJVFVY7YiRK8J
         KIGOY5nmisMSXXFNXehpYucxwg2wDOYmfUJBUdLgFPRp66NfCt+9cup5CYlM7ZoFqPgA
         U7/Y5Qc6ZTWNUUYtYGzFR8sDde4Avpz14VBVig1HK12JwufQHAn5tZEBeIF3gYtZsarP
         tjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hRYX9Qb8xgVcO72OHHpEJqvkK+/eKUc0GJTr4L8+CVs=;
        b=JpaptxJcDaQpN69kvitKesnRVfppmPBeKvfE39wnUGKmWEfrvoNsNAdLYFHbIFsabc
         d96IyLFI+95CkE5Z04gMRKV1l0MdiPv/t6UAS3dTIgsYrC8PE4WLxSfzMMsy6KBW0yw0
         M3uMrQEGy3MSw2OMAKSEviafbHO1OIjkm7UXaeEj03hzzSa36za+RUsjAUkmmoaBXNzc
         NBWK4qEZ3wi0AikUF4BUhWO8rYadv6yYQo9cEYoXdsTLr9PoHb+e1iLlfCfhk5R2lJIf
         Gia5ICn//Uo261cGihWcsYA8hnKM9jXoZ47/dzSUKUVlbd0czAxp5Nz1iYzqWjIvVwIJ
         qrQQ==
X-Gm-Message-State: ACgBeo1xyamKMl0X+kjW1FaiB7YrKstbo6iiqxBuL0NWCocI6bSpUpZC
        AZfT24yEOk5JoFoFh6qKN84=
X-Google-Smtp-Source: AA6agR65dRgEllaP6C7s1+YKmHkYBctIUXotwAG5I79QP25D4aveUE7rgFk83QswOi57Ba/eiQXgmg==
X-Received: by 2002:aa7:db5a:0:b0:446:62:922a with SMTP id n26-20020aa7db5a000000b004460062922amr5365995edt.373.1660899246990;
        Fri, 19 Aug 2022 01:54:06 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:06 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 3/7] staging: rtl8723bs: remove function rtw_odm_ability_set
Date:   Fri, 19 Aug 2022 10:52:53 +0200
Message-Id: <35d0f2115fa6febd72a1a7d1c740dece3d55a3df.1660898432.git.namcaov@gmail.com>
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

