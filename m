Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549524AE234
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386012AbiBHTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349608AbiBHTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:25:56 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DAC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:25:56 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t199so85314oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4fQscmZkT+if4EO2KKC4BHgRmaa2ZCGZYHdDINn6rg=;
        b=PdWrfXkIjt3VIfc2e4P3VaMlTO+XvE8D+4A1D4ulpwJs9IBNLMMWxt6+uPc+oeTfYb
         y108pvUNFvPJHS1PghA3SqZAxRa4XpmMNt4NMk6aefrv6XovDvjZEQ7TpcitL1lGJM/4
         OEFNgjYVU2rP458YVct8kg44N9jwLgS3IDuEUah8NFdRmFmx7f2IUSUH/D/kLeGYRu3f
         d5muvbwtnipYwVrA07PjIm2Vy0pG1QT6RTcfisVq/qoWJFisE29K8F8sjZAtvMs6TMFP
         tWKmlMjY+XgaLzAPBLOiV6FeJMyhFnBZQi1sGb3asKOBxxQ8LvpYXa4uQWCBBzm7cr15
         sGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4fQscmZkT+if4EO2KKC4BHgRmaa2ZCGZYHdDINn6rg=;
        b=mHlr6K1zSBvT9xgo+0RbWEn5WUCcPhFXJXDbiZ3ziIVlwArq0U2mvmH/WVk7AyUyz+
         TEoHXo91Ym48KTz6nPa7NdW86BkxbYEY+RLhm6Py/4oNzZu1Yj6yrxkJsYBBYA/Vp5jS
         tkksT/OimjSi4o0BRlgCFsKWPHkE7WMBx1tdsBOY9ivtkvAhr7dEj5rgSV3txB4zvEX1
         LQXg55cJSN3J8uSFMGeC40Pl5uz4OJv28MWjt3N77/bWfy/3TmKoElAKKcewBcoOvhoF
         88ZgkvUxH1FX1StZAu5IrfUATrj3WQDSF0PaahbXnbgBffbQ9rl/KfQSjeH6mDahw4v3
         GHtQ==
X-Gm-Message-State: AOAM53102t8ZkhfYx1JHNnqswof6LXExqoZ3QpLG4uScSZo41gIAYRiB
        iokmFn01iKIXJX3xsKehFew5jVicCyc+U0cv
X-Google-Smtp-Source: ABdhPJwUhfUqWe+1ZtTYdnp1bQhJpEvnHbut3RIb8QPNR7nD0ROTEdtPAvr95qASDuj8bjX+HKwvJQ==
X-Received: by 2002:a05:6808:481:: with SMTP id z1mr1214409oid.197.1644348355377;
        Tue, 08 Feb 2022 11:25:55 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:fde8:3cda:d976:7f4e])
        by smtp.gmail.com with ESMTPSA id k10sm5772649oou.26.2022.02.08.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:25:54 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Blank lines aren't necessary before a close brace '}'
Date:   Tue,  8 Feb 2022 16:25:29 -0300
Message-Id: <20220208192529.19774-1-leonardo.aa88@gmail.com>
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
 drivers/staging/r8188eu/core/rtw_cmd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c7e8602d2097..5fdac6f8f717 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1424,7 +1424,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 
 	/*  free cmd */
 	rtw_free_cmd_obj(pcmd);
-
 }
 void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 {
@@ -1483,7 +1482,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 
 		rtw_indicate_connect(padapter);
 	} else {
-
 		pwlan = _rtw_alloc_network(pmlmepriv);
 		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		if (!pwlan) {
@@ -1513,7 +1511,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 	rtw_free_cmd_obj(pcmd);
-
 }
 
 void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
@@ -1526,7 +1523,6 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 		goto exit;
 exit:
 	rtw_free_cmd_obj(pcmd);
-
 }
 
 void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
@@ -1553,5 +1549,4 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 
 exit:
 	rtw_free_cmd_obj(pcmd);
-
 }
-- 
2.29.0

