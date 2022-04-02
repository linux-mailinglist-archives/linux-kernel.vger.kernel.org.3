Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5144EFFCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbiDBIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353950AbiDBIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:53:14 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F374156C5D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:51:23 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-deb9295679so5170751fac.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwyPQSB+WJYU+JkcFUBBvDrf5lBS4YcYc8z0W7DhRMo=;
        b=DubTEXg4Iq97boyWsG+ES8tg2dBvQdNgO7s3bOR3PAhTsUm1TPc9GqibMunWyFkQi1
         PAI1grvSPXOAr+LAkhzoE9m4j2fFaPhxX5+pBWv+ACUTBfb7C3yN6RBFKN904E1kcd7E
         Ii2z18jwsn2VBVRFK9WpYDgT8sWHlPTjAymqlKRf3WZMpwBY6kqAkxnZpgOkewJEI9KD
         pGuZspgQa779EjH7glXXnpPTH6sfDvaz3p6wgmYX4cKAGwKUlVhq/q61A4HTKuOW3GMC
         wPeeeX5IayCzDGxTxIq9aO/n8Bw6x/82NDSVwTKaXJI9R+K0X64ucEL8MsA0Ye2Vm1IF
         gmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwyPQSB+WJYU+JkcFUBBvDrf5lBS4YcYc8z0W7DhRMo=;
        b=XFQDBRLY4n0M++qB8iJKU4ViULTvkSxEkzou/ygCInXunYf60zMN9z4Ee2QdRkHR2U
         lJO6yyxnXxUyi4RRpQ4qNeikSlznp5t/8sgZFPbb412eMWq3cqaWrpeb21tJCi+M1Qeb
         uKxbW9gBpPixnZD9XIZxpFL/+1kFTsdwoPxArxFJSWdhGfxSglreBWLvCZq/osoOmpaq
         aTBmwxNeG/EzeZj+u2HI6ycqI8RrPzxuGmghJnjZMAdwoodDtztGszIsXN5yMdO0NoYF
         eHmkyu3X07C4WHqL+XSZTTDdOUU81ZZuq3FtKL/7Xa3rdyrMlEzJTAQdXfy4A6uk9jdf
         uzwQ==
X-Gm-Message-State: AOAM533VXHXlTXcmAnTjE5J3PekBJcXJvc11F7VXfCmk0O3UB9yeb272
        cFLzfQQFzysocXJUiJhdZQE=
X-Google-Smtp-Source: ABdhPJwHvzC34/jLXSMJglm+fac8tsDNLvgYbrYDMZAEB1F1P7UFN/NhraLjOGiAk2qNsFmMimowsQ==
X-Received: by 2002:a05:6870:e2c9:b0:dd:b78a:82cd with SMTP id w9-20020a056870e2c900b000ddb78a82cdmr6912349oad.50.1648889482790;
        Sat, 02 Apr 2022 01:51:22 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id m5-20020a056870194500b000d9a0818925sm1911593oak.25.2022.04.02.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:51:22 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: remove unnecessary braces in conditional statements
Date:   Sat,  2 Apr 2022 03:50:47 -0500
Message-Id: <2b46501bb3965a8cf27e7134407c50551c36b7e8.1648888462.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1648888461.git.remckee0@gmail.com>
References: <cover.1648888461.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks
WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 0c659b40aa1c..832bf25b1a83 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -331,13 +331,11 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	struct cmd_priv		*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
-	}
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		p2p_ps_wk_cmd(padapter, P2P_PS_SCAN, 1);
-	}
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (!ph2c)
@@ -517,11 +515,10 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
 
-	if (psecnetwork->IELength - 12 < 255) {
+	if (psecnetwork->IELength - 12 < 255)
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength - 12);
-	} else {
+	else
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], 255);
-	}
 
 	psecnetwork->IELength = 0;
 	/*  Added by Albert 2009/02/18 */
-- 
2.32.0

