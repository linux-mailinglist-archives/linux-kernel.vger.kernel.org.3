Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D715599D24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349433AbiHSNud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349420AbiHSNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773CDFBA6C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb36so8885303ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DrYs5wXMzkTkGQcWHMkczyKadrbT/RhKmAvnzhy1suA=;
        b=p9qll2ZwMcI8GJPjpMIatWPBUs6cVNjmmb1dCuBggaPMzK+Dp8znjpp8gt8jhPAwDU
         QsuIwvc36BeYrGnek07YrgPO0DUjucvUmg84q207eBb+Snhqs7heTbEbcWyH8rLgmiRb
         kGn4BKSml07t3esXr5NQpREr0yqE6muM9D5jqe/MLthJ/2rPcunJm+SyarMRt025C+3J
         T+UO6xrfANZ0pG/Oy1vSMa1m87r5taUU2YkJW1dF5FX0urXTDoMRwM/YGzKr6EvxJyxx
         s1u1/9lSi/XoD8TOz6CGvkYeHFMyLCEX2sxJqX8Bn3O7pn7wOcZdAbGgbhP2MAFWO6VU
         B/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DrYs5wXMzkTkGQcWHMkczyKadrbT/RhKmAvnzhy1suA=;
        b=a6/OK0F8hc6TLFI+Xg1ymxaLAXQgnbsI2y/6meEtUXNrCj/cX0hQMnSzuHtrumQ+zW
         +pb0UtShJ7zYI03rFN2DoZAMUGmnSzlDdCB96qGtT2D6vUBQGt7H482iZ5Cod8SJPrVE
         B/CoejsmC/zZ1H3iGUDW7HKsp37P7TWo+nlU8kM+b41CxRS3x9TkRLxosW6q7OnxnC3d
         DHerDszGP14sG2RN4Sw9ubhZHzlsiIxS8ptmfZF/sOEH+9snWryDeq/xtkAWSqtWULC5
         vEo3FSFB5S4oZMxipYYDN/udCSkY5sASZHDNxUE7Wjf67z/E7Oiivk205MBThzpQI6Dc
         uhEA==
X-Gm-Message-State: ACgBeo18PAhmZsJ+wmj4Cs95ICD+Rw6aR1mrBfGlczfuUT71pwCS2lLn
        D3vHnCFQWAiML3jS2anteso=
X-Google-Smtp-Source: AA6agR5ToE5/sY/jfDvLQ8ZLVWmLfN/LmtF2j8s3eMMhHPcoS6Lo+W3+W5shrbaBLLlNPCccIFsIPA==
X-Received: by 2002:a17:907:60c7:b0:731:148b:c515 with SMTP id hv7-20020a17090760c700b00731148bc515mr4994191ejc.724.1660917023984;
        Fri, 19 Aug 2022 06:50:23 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:23 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 1/8] staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
Date:   Fri, 19 Aug 2022 15:49:35 +0200
Message-Id: <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660916523.git.namcaov@gmail.com>
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

