Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB604ECB35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349629AbiC3SCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349619AbiC3SCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:02:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA32982C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:00:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p189so12775208wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjDBA8xXV3PaVr1T7IqgeEG7zCa3/bW1lV8w1dmHNbo=;
        b=gYGIDn+dPCphlCTk/qqlLNO0kbPmWbsbaxGJlFezdIeGKOfdz3ZTK3sICB7jxsEMUz
         1ErRmuLNzGEBgejIgG1cTy3fHdlIm9brSoNAFnRR/VpS/S6QY7x9kigNkJoAh+CwEopZ
         s9escAG/6I8MXO1M2t30LC7bORx2kyodVjBWSa5Vsp4vtJKbHptL3xCZxXaB+QNRwpq6
         BWaZ4cq1ottckQ1/Qkdtukrf55/gB/NUuqLdimoAcHGF4+mwXRu45aytAAzZXDlIRP1k
         MeHHtL57gEDJM0xyQoA/zrDNPjkTlQsEknTX0R8lq/Im5R/Eg7kgfFm6M56sk2MM9QuQ
         5gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjDBA8xXV3PaVr1T7IqgeEG7zCa3/bW1lV8w1dmHNbo=;
        b=riLRQoomFqQrYc5kVKlwTghXgK7z9Ds+igtOU0uqFvHAwyudhK63Ppg8cWsGcZLiuU
         NQ56INDAw5SYKrATXWsMEmcCAbuIIIyQHFpm/ivw2Djnc2ATu0BUKSJt/CfsskB58IHY
         6dfqyoyC+aLnN7NEZCXujYiAVo0nxdb+4gPkzf34cOhLxAi1wnTNLFYvcGXsS1sMBmCq
         4bKi7DgZHYXGKzS3lPlgXH/xSyoWRg5dK4P6KqjOKAl0zr2bBPGv8VB8WeHX0vNzgMPA
         LFfjDhgQzPBe1fc9XU9L455RkWq71aezIJ2tKW2mrEZmnuo8x+k/+jtHvKuVbBRYnFMy
         ceVw==
X-Gm-Message-State: AOAM531eOdXH5fFRbVvDJ/KwNX9KLFPEsy6Bb5pWRGKXS/MGdTbsx05R
        D6n0lgcGJkC6fR/QY/FF2Qk=
X-Google-Smtp-Source: ABdhPJx2yaZhLKwvYiQxEaZYg1Ek8pVsCoS/BpPLxLWQcxbSTDeRqWKbtjLgWBoZ7PphulafdFI8pg==
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr635353wmq.112.1648663244522;
        Wed, 30 Mar 2022 11:00:44 -0700 (PDT)
Received: from alaa-emad ([41.37.132.115])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm18951588wrg.70.2022.03.30.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:00:44 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH v2] staging: rtl8723bs: remove code suspect indent
Date:   Wed, 30 Mar 2022 19:59:49 +0200
Message-Id: <20220330175949.95564-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Fix "WARNING: suspect code indent for conditional
statements (16, 32)" for line 1240
founded by checkpatch.pl

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
Changes in v2:
  - Edit the subject.
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 14d37b369273..46e18a90529f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1238,7 +1238,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 		/*&& !MgntInitAdapterInProgress(pMgntInfo)*/) {
 		/*  if we raise bBusyTraffic in last watchdog, using lower threshold. */
 		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
-				BusyThreshold = BusyThresholdLow;
+			BusyThreshold = BusyThresholdLow;
 
 		if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > BusyThreshold ||
 			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
-- 
2.35.1

