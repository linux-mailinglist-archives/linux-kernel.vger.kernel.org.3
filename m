Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74734AFEC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiBIU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:57:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBIU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:57:51 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E02C050CF8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:57:53 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s185so3843044oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0XRMCidxLf3AMH2NileQLi/UY5vaptNNJhFkA7h62k=;
        b=aq0u3wZCQUyAx4ASAWiAG8nNmiuXymUY+bm91AJoSqSwFiNbMOuUFTdNx3KfI9J5/b
         cEV3F62a/1KKd9MFxa6WtmaxsaPFn2y8FWrK4sSQgqaGMtpzfOfIB63I2rN7S81PEdtb
         rmFppyJOS/RAOCYFFut/7e2o+zGy0ij2oin9Uo2mWqSTB5f4ctQ4bNbSr2m8TWNeqjmX
         uxAw+Mt17EO+D88rUfDEY9vL/UIXbltCwAzmFSYh3RlrlB3ZmIUnrzkiLXqyveY82iok
         mOm1N/ayrRrcQn30xpC+tdpafaEueJij/cMPKhYQV4MBInpdZvMpKQO1ACULujgw8Lvm
         wEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0XRMCidxLf3AMH2NileQLi/UY5vaptNNJhFkA7h62k=;
        b=te0acWqD6uunEXKyay2V7SCisZgR+JFnyRDIzksK+GgS8lGqvf0PcT7Iphi9Yb35wl
         jwssK1F5pLtrJNw3OjizR9iHN9egiJqcv5KRPl4QMXFOuG5b82wiP1KFgMVkLFdd7Dl/
         HJxhgxB50NVfK27wWahb4j4MAAkpHjfsl7sFZyoEwSpbjUTaubr+XmkUDy+A4U3SYeXg
         h9YOJvTEngHoqSJpm6nf6m8i0OjD7ZhmNsPA1RNFMJpn9W1eCEdiOX7UFH2Bax1WzsV6
         dB1YXwhZXx5e4hIl7+UcHc24Wt6W2oYI1o4BtxPFtxUzagUCHegT+rx1Tz5u/ZqMALKc
         JPvg==
X-Gm-Message-State: AOAM532zGWNh3YirYVCJwPyz27ej2Nt/gDe+g8kjXuC4SG41Gr1pKmTf
        Zi7bVQaHgHI/jRQVOUfCjE8=
X-Google-Smtp-Source: ABdhPJyGWueOWBlkiM1w5KuvGFTribr9OXBqRie/wd6kJ+eHbYjfobOUgS1S84qqkgKwTbm8vl/AjQ==
X-Received: by 2002:a05:6808:1702:: with SMTP id bc2mr2390274oib.214.1644440273270;
        Wed, 09 Feb 2022 12:57:53 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:758b:9a0d:6e95:934f])
        by smtp.gmail.com with ESMTPSA id j19sm7005949ots.21.2022.02.09.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:57:52 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Avoid CamelCase: <bEnterPS>
Date:   Wed,  9 Feb 2022 17:57:40 -0300
Message-Id: <20220209205740.9926-1-leonardo.aa88@gmail.com>
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
 drivers/staging/r8188eu/core/rtw_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e42119e16284..4ec4da6d3078 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -880,7 +880,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan)
 
 static void traffic_status_watchdog(struct adapter *padapter)
 {
-	u8	bEnterPS;
+	u8	b_enter_ps;
 	u8	bBusyTraffic = false, bTxBusyTraffic = false, bRxBusyTraffic = false;
 	u8	bHigherBusyTraffic = false, bHigherBusyRxTraffic = false, bHigherBusyTxTraffic = false;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
@@ -913,12 +913,12 @@ static void traffic_status_watchdog(struct adapter *padapter)
 		/*  check traffic for  powersaving. */
 		if (((pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod + pmlmepriv->LinkDetectInfo.NumTxOkInPeriod) > 8) ||
 		    (pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 2))
-			bEnterPS = false;
+			b_enter_ps = false;
 		else
-			bEnterPS = true;
+			b_enter_ps = true;
 
 		/*  LeisurePS only work in infra mode. */
-		if (bEnterPS)
+		if (b_enter_ps)
 			LPS_Enter(padapter);
 		else
 			LPS_Leave(padapter);
-- 
2.29.0

