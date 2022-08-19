Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95E9599D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbiHSNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349427AbiHSNu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD20FBA40
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so5734338edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lgIH+anOUapmsDT3madCqkJtVLuh/Inv9K5cFDxhThs=;
        b=lE34wyWOfJ2A+mHfyUMPbaHKwqYn+VsSx0alFzAYSLueTfeysXpz2AA6lhBwktZ+1x
         nG5BuXFVhdwbk8Nhx2541E8Id8vTt+QwctXGG97ez37uMo4jmdIeW9LCK+OuvpsBcVQa
         owTGNQC074Am+gOLo5oxzuL7rBMvTguXgDJMgPbZ3j3znadmzs6Tj7zyJ9q4JRsoxv3y
         KoC7jYKx1rIIxyMQwWPpBv7WvpJqR9KimjVAI2+5Fsu6baC9nC4Acw0qNFl+XcO1Vm8A
         vEhf2MfDYax3H687ISulQe8dw/TeTS42WWrJZuTGZog891s5t6AUIN+GHwUzMp7ptViL
         aMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lgIH+anOUapmsDT3madCqkJtVLuh/Inv9K5cFDxhThs=;
        b=RwSUbb1O8ysSffdM108x4UGXXYL8gKE+rnD+kLzRncMOxYp4FlvmRB2BeCHHkiR36l
         HTrMn/wJLttZXVsBISVyE7lXLjC6XrEH5twtjtwD1y2gIJJ7v3SZEn7gq7T0msf8NQss
         pGPK4B50YE9zrFzbkKjFEYFOblGiZIKXUdfOMoqGNMlEs5Iy7ISau1psMUbg2O9pWmJV
         2debRb8nGsdo7iRRsy759Iqvzru5heHv/VYKXTyj9V6FdZNVwB66sxiQEKwpVBMxhMBb
         WbMF7uAqMQlGFVi8vobQ7+tqe2Kj025QiizTJvvqqP1FFI/Ot34P4X3qW1MPL0N4nTdO
         UBsw==
X-Gm-Message-State: ACgBeo2lzOXLyKlBPY7RyBFwsD2gZRbTUMSqZsFxN/nRft1wLaiJUcXK
        lWJudpJ908rmbizcpyqsUbA=
X-Google-Smtp-Source: AA6agR5FwzKIiQPocVDtpf+VP2MPnrriXY3Y+t3WnL0ySLyHI3eH+k0lWM8+nTIq4M/UrhR+G31NxQ==
X-Received: by 2002:a05:6402:40d0:b0:43f:8f56:6b0e with SMTP id z16-20020a05640240d000b0043f8f566b0emr6300221edb.380.1660917026763;
        Fri, 19 Aug 2022 06:50:26 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:26 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 2/8] staging: rtl8723bs: remove function rtw_get_ch_setting_union
Date:   Fri, 19 Aug 2022 15:49:36 +0200
Message-Id: <c8c5b0c78ee9a4cd8304efeff22b51049c75a3f2.1660916523.git.namcaov@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 21 -------------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f878b04076d8..8e74b4f47b94 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5945,27 +5945,6 @@ int rtw_chk_start_clnt_join(struct adapter *padapter, u8 *ch, u8 *bw, u8 *offset
 	return connect_allow ? _SUCCESS : _FAIL;
 }
 
-/* Find union about ch, bw, ch_offset of all linked/linking interfaces */
-int rtw_get_ch_setting_union(struct adapter *adapter, u8 *ch, u8 *bw, u8 *offset)
-{
-	struct dvobj_priv *dvobj = adapter_to_dvobj(adapter);
-	struct adapter *iface;
-
-	if (ch)
-		*ch = 0;
-	if (bw)
-		*bw = CHANNEL_WIDTH_20;
-	if (offset)
-		*offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-
-	iface = dvobj->padapters;
-
-	if (!check_fwstate(&iface->mlmepriv, _FW_LINKED|_FW_UNDER_LINKING))
-		return 0;
-
-	return 1;
-}
-
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct set_ch_parm *set_ch_parm;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 89b389d4c44b..65e138a5238f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -662,7 +662,6 @@ extern void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint
 extern u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer);
 
 int rtw_chk_start_clnt_join(struct adapter *padapter, u8 *ch, u8 *bw, u8 *offset);
-int rtw_get_ch_setting_union(struct adapter *adapter, u8 *ch, u8 *bw, u8 *offset);
 
 struct cmd_hdl {
 	uint	parmsize;
-- 
2.25.1

