Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A85AABDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIBJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiIBJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675182D19
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so2830171ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ThDb76+kZEC72ISvvHs25TvHqgP2beNaL5wxY8n7dsc=;
        b=NUjfOq9/5L6JJV9vJslddUmeS7AaRFkr6sq7xI5oNDsccB2aIuvLHNuJMg4wyof+oE
         7eK1TW/8FULpKamlM2neerduzBjYzxCGh3lNa389TOkGOZgtmJnFPMxghfdXhO/Y4z8i
         zDoHTUFvq8k8z0GQ/0KQedD84hZ7wDSCI0Ec/3Qr+aREoxLvqNArcapuzeI9OQXbiDJI
         P0yYoSpuU/JKHzF1Ln8zPAiqDupoId6KnskqbWRSPzrnovkk3nGnjoTKhti74M279vD2
         CY1xutNtVilPSitlh/dWJjBi82mbFFOGvBgqKrW62bqYJRqLdH5Y+tdoGCFdobv5eSyV
         77SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ThDb76+kZEC72ISvvHs25TvHqgP2beNaL5wxY8n7dsc=;
        b=nrPIPzxpRs27s59A8WLRXm3DehFy+78whYGUueQORqev13AXtUCWxrpPrzfztcSENK
         vLDnC3TWWrKjhTwACMaz5Yqwnb4Wzf+EVJH64ZxWQfmgRQq8vyVyKAJs6t4rdrgAfreZ
         xt0QNzZH8fyms1hkPqAKLfuqMaWZKnZMkrMeFl5ohmOtrphqhr1ERh8sPXxkMfNPa6xY
         v30/iswEfToujO0MXW1g0seuUT/wM3I0++cYdC5dvQwXMkzRn/1d1PlkC1BH57H87o26
         felo42+MrAT0STo8F5U4agaGnsOyfLtFHKsZsBMohW9wxvoaYQlSYJtttF0a4JoyA7Hi
         u69g==
X-Gm-Message-State: ACgBeo3tPkwFX9vr7IZquwh3icqLLlqQAQO0s4w99HOmcboMgdrnBAm4
        Uzl+4KSLS8629UiIhgn2nL31/zTBcN0=
X-Google-Smtp-Source: AA6agR5zCoNE6sH+KYkTSJ2nPQ/wNsIebIEN4dcGZhqUWHmM/Uy+L1R5TGLi9CJOyVZmVMrYjw1Kxg==
X-Received: by 2002:a17:907:9620:b0:730:d5f4:d448 with SMTP id gb32-20020a170907962000b00730d5f4d448mr26586297ejc.45.1662112354552;
        Fri, 02 Sep 2022 02:52:34 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:34 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 01/10] staging: rtl8723bs: delete rtw_setdatarate_cmd
Date:   Fri,  2 Sep 2022 11:51:51 +0200
Message-Id: <bfc4c5c9aec8b026fd3cf092354d508881d790fc.1662111798.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
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

Remove function rtw_setdatarate_cmd because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c    | 29 ---------------------
 drivers/staging/rtl8723bs/include/rtw_cmd.h |  1 -
 2 files changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index b4170f64d118..a5e66b9868ad 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -593,35 +593,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	return res;
 }
 
-u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
-{
-	struct cmd_obj *ph2c;
-	struct setdatarate_parm *pbsetdataratepara;
-	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
-	u8 res = _SUCCESS;
-
-	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	pbsetdataratepara = rtw_zmalloc(sizeof(struct setdatarate_parm));
-	if (!pbsetdataratepara) {
-		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
-	}
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, pbsetdataratepara, GEN_CMD_CODE(_SetDataRate));
-	pbsetdataratepara->mac_id = 5;
-	memcpy(pbsetdataratepara->datarates, rateset, NumRates);
-
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-exit:
-	return res;
-}
-
 void rtw_getbbrfreg_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
 	/* rtw_free_cmd_obj(pcmd); */
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 1bf030cbbbbe..0af8215e2f2f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -591,7 +591,6 @@ extern u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8
 extern u8 rtw_joinbss_cmd(struct adapter *padapter, struct wlan_network *pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
 extern u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infrastructure networktype, bool enqueue);
-extern u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
 extern u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
 
 extern u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset, u8 *pval);
-- 
2.25.1

