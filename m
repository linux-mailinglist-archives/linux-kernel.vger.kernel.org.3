Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0099B4ACD4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbiBHBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiBGXst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:48:49 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB0C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:48:46 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so15655490ooo.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6w59Lm+S9vTDMWvPIWW+WWqVExelOhv6n2kHObVwhbw=;
        b=M9HKxXV66+sQsFok01Z8z37aiPmPfP4oMAcDwsAsTT6tAvFHw+vrKQ7S1r+LZYxS5o
         sa9z6UKa7XIB8PcRpDtsJzdEMR0N3nzporGuqxWzbOF7RnuHvzS+a6K4jT9wNikdCC1l
         VMQtwqpvSKXMTTEsnYu4I2Jztkq9DKMrAwvKH8XemO3IHj93f5UFZ2qP4qbUrNFbgISS
         unSNzqrz9aEby7fiWIio47sBWT9pQF+S7+MrxJjH1GJobF3DBzPod4Z/7pxA9u6d2PjA
         J8grum0WsVm2h1woWi4Kffhz5WqcwzqGRmIIirU2eAydEkxIlDCymrNQkWkitU/9rf3Q
         pocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6w59Lm+S9vTDMWvPIWW+WWqVExelOhv6n2kHObVwhbw=;
        b=J501utzc4KpKRz9Bxjr//teC3QLUWYjDGKafwwNMa8BDj3zoouUY+mwYcvKxZlet71
         yoTBGEwyvtA6SLC3/6S7jhypvzdEd7533KkF/TKh9/5lT0/gnWZS65JSbrxYhBPFH0Zh
         nL7zYPwqA0cUQOQNJUwxCbAL/454Szj44uahbVqfLi34M96SwzMvRYovgS5nMJKSXcWX
         men+A4L+xvABJvH9DzW4+2CctrFa97pHvC0O1X1J4owqp6EczWoiDERmYpZTF7R+M1Mc
         nGePJbjkM0mVY85On0LfpMld9LFZoYS/EobLr62Qh15d4aJE2rfuti656PIIx6rxQ7X9
         fY5w==
X-Gm-Message-State: AOAM532/XNM8KG+SYQST+jKYTjzf/ZVSVRcwXltHTfgDXY+gGS9fsAYB
        9n2S6w8oBzMc5vkxehflEl0=
X-Google-Smtp-Source: ABdhPJxtupvU6YR52AZ3UhRA9Dd/HfxzaQDo2i0IxqbYlKti6NgdZntpMSVHsSdeiBr0IbXLygMmaA==
X-Received: by 2002:a05:6870:6187:: with SMTP id a7mr427434oah.301.1644277725520;
        Mon, 07 Feb 2022 15:48:45 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:4134:806a:5a4a:2a88])
        by smtp.gmail.com with ESMTPSA id r41sm3330805oap.2.2022.02.07.15.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:48:45 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: alignment should match open parenthesis
Date:   Mon,  7 Feb 2022 20:48:24 -0300
Message-Id: <20220207234824.27893-1-leonardo.aa88@gmail.com>
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

Fixed a coding style issue.

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index e02dd8e11c95..c7803144355a 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -942,8 +942,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
 			DBG_88E("%s STA %pM - no greenfield, num of non-gf stations %d\n",
-				   __func__, (psta->hwaddr),
-				   pmlmepriv->num_sta_ht_no_gf);
+				__func__, (psta->hwaddr),
+				pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
@@ -952,8 +952,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
 			DBG_88E("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
-				   __func__, (psta->hwaddr),
-				   pmlmepriv->num_sta_ht_20mhz);
+				__func__, (psta->hwaddr),
+				pmlmepriv->num_sta_ht_20mhz);
 		}
 	} else {
 		if (!psta->no_ht_set) {
-- 
2.29.0

