Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09204AFEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiBIUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:45:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiBIUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:45:38 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC18AC001914
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:45:41 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so3852741ooq.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xm1Tr2nzcItVDKdJ9rf+wdRu6cxWSGf4prYg3I3bnUE=;
        b=NBGl6aQbAp98ukynCozOD6vcb7U3mC1W8x3sx+urs1D/Bzgy7+TwxssYr+Oqnj2Bwn
         vZ2WPAmXEXQU7wxdjENVrQ5g55yCXjrzvTdWZ1BlC/D4IGOZCNQgDMEnN8Wse78xpyyS
         fsKZkT9wIosEAxt/MwwPAKIIbTWmhItTvIok+5zN1n6kxEbJ6AapLt6hi+CzElNiOS+9
         RFFBsPMt5gFRg6CPDjf6flRabV3ZUCebnW6CFr4Q8NOkD46KlJMfutgWQBbGO0zm7qX6
         jF0cR0fWKeCSoskPVIaWI0LkBjXX+kS+nfDMQi1trpdZ74wq/ZQcyMDdQ0eoJDNbFP5b
         NzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xm1Tr2nzcItVDKdJ9rf+wdRu6cxWSGf4prYg3I3bnUE=;
        b=mgZoAe7/7Vfb2hezEGJotaBO50b/RSTnpcv5biC/upu+nxahy+eq07QxAqzUqWmhOK
         ewypdOMvVMG1YI5t4/G5ZlY2+HaxvkTLdRQvBrcVwZWuG9nczF0cHnj0uKDGHswNjxSu
         50QRko+qdVd0NJCbbjL8EySTRTUpe/8FhLMOEfN9T6wMFwOTfERIrHwIe0Wa4q5Sbjtn
         P6dfhL0wn5js5EZsLo3GwSxf+LyKgrR917pU54hVMgWLQl+FjQlM4anYZrdcwMjnyOAR
         uvP8k60LMCr2HPeC24auqvzj7NnEekEmktRPBWkQv8LSIzKtEu+lXsLS0Pv3sWikPWww
         UlTQ==
X-Gm-Message-State: AOAM5329d5BzbqfBboMBue51DZVtgNcu1Zw2rocv6ioxMi2RF3FiVLSz
        t4lD6yLCaoVK0zjKQ0MlaxE=
X-Google-Smtp-Source: ABdhPJwGgR/vaGaQIeSh8grZh68qH9RmsC2xSnUT6J9yjPdDQbN2hUrBKaL2YgzPOJixTNmSPPZDKQ==
X-Received: by 2002:a05:6870:1351:: with SMTP id 17mr1300466oac.246.1644439541235;
        Wed, 09 Feb 2022 12:45:41 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:758b:9a0d:6e95:934f])
        by smtp.gmail.com with ESMTPSA id m130sm7242730oif.21.2022.02.09.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:45:40 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Alignment should match open parenthesis
Date:   Wed,  9 Feb 2022 17:45:28 -0300
Message-Id: <20220209204528.7114-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
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

This patch fixes the following checkpatch.pl warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ef0dd395b1d8..e42119e16284 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -327,7 +327,7 @@ rtw_sitesurvey_cmd(~)
 	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
 */
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
-	struct rtw_ieee80211_channel *ch, int ch_num)
+		      struct rtw_ieee80211_channel *ch, int ch_num)
 {
 	u8 res = _FAIL;
 	struct cmd_obj		*ph2c;
-- 
2.29.0

