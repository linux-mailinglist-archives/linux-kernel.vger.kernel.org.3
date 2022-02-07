Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70C4ACD3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbiBHBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbiBGX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:56:54 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F3EC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:56:53 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso12051089otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RM60N0Rjf5a1UzUDohM/hVHwY147yFPqeTn24GmliwE=;
        b=ZfQHzR4lezRx9GD+vjJ10flGdwmXe+MNNuOGxKMK6/5aDP0mnZ5V3Qj66+QY4KWkay
         jCvVdr+WHrt2D4v55tW3SdLvlFAs03r4SD8k6VpDpuXEGJgO2XmxgbD47gFFzmy5rd9j
         9qwaQZ/znUULqh5PTElNJ9ySf185m8u30Wq3DCXhYQVOprof0ks1udTtaCjfHdx5qwYz
         srvz4I53b+jXFbQB7S996k3awzx0H3Mt8Qr/sGghUXc9WUkIdonqenWgC6DKuhuwi7yg
         6eqAU/6KmCbAu2k+TX2shwIXvTqvMRQRYAJQsklEQo4Gz3IwMRikoYIUQIciSRf5/HaL
         Rz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RM60N0Rjf5a1UzUDohM/hVHwY147yFPqeTn24GmliwE=;
        b=nzwu+YT55veiG1puCpr8IHQckUvuL7PCUZfdBzwh9qoRbj+TyidKrr3CV1zkJRRdMD
         MjKP2iQkUIZWClQmB89csU8LQoMtneY2d2SCVAcFygWroqHV6HvW70oC9TXWR0Sy0h6q
         9JOjfwn0exTuyeNbaiKcbnmd+QTIiGxdiCf4e9UIeFuep0JAL+mTiBCKN8JWufKz0Nsl
         PeEBR1yIKPT/Xb742VexFOBmdoVLmc0QoKBlM9BmmprQqGR2MdqyMTsnvtzId/AEBM+c
         yMzh0YMrPyHQhM+5Mj3Me/uv0RxitIfvw3HeClG53XgtvNQcDR1Pcn5qZNFUWr+RyAfs
         JhiQ==
X-Gm-Message-State: AOAM5322nh4Fb8YajnJ+9lbY5pl9MXyMnEd9+mFJjJoAyU4u0Ua/nSw4
        VN9rgJ/+nsNwyhcbDcXv7Mw=
X-Google-Smtp-Source: ABdhPJwGwnxCoyQKJmjQfarqUsvKouiqLlNdaWqGRnQr2hyJ/c17gDhzWz73HyIalUuaQy2yoQzK1A==
X-Received: by 2002:a05:6830:918:: with SMTP id v24mr873883ott.246.1644278213093;
        Mon, 07 Feb 2022 15:56:53 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:4134:806a:5a4a:2a88])
        by smtp.gmail.com with ESMTPSA id 1sm3829020oab.16.2022.02.07.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:56:52 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Concatenated strings should use spaces between elements
Date:   Mon,  7 Feb 2022 20:56:43 -0300
Message-Id: <20220207235643.29768-1-leonardo.aa88@gmail.com>
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

CHECK: Concatenated strings should use spaces between elements

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index c7803144355a..30f5ad4e7ca7 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1093,7 +1093,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
+	DBG_88E(FUNC_NDEV_FMT "\n", FUNC_NDEV_ARG(padapter->pnetdev));
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return ret;
-- 
2.29.0

