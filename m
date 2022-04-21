Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35550A90D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391891AbiDUTXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391875AbiDUTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53134D242
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x12so3994494qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNiJSrQTI1Pt1iGSKhItPgbMNPUK9lB0wjRcg9gqMY8=;
        b=GGaUeCDvR9QGBfQTYzXmtA2mY3jKLr6N+hQcsm5N+IJj2Z9qVCHTvvEAgdD+2L0BUm
         gqIK1a4iB7x1C1urijc40bhG9aoWiUhAPRKE7BcUr6/2xUzhd1HZWIe7doK3WA+0PTgN
         dtw7WX3+1dVTUCdBgSLweXtT7iMO8wBegjPHgKX66JKwF3h6z75ir/0SZyo2vNsKReQX
         CdKiRl1kGkstvvGE6DPFC3vsFHPP8GtgrByLDExVb7cLVX8Nqb/YY4kUjma9KxGVImCo
         jcGje/PtOQQGErsLL1jpRb4cVZhKOE/yIWQJ9bX/2Xp35KjHZyEUXlmvEvnGrRaY92iP
         93jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNiJSrQTI1Pt1iGSKhItPgbMNPUK9lB0wjRcg9gqMY8=;
        b=YXPB7FkcZ84wO9nbVa6GO494sOy8+XPqOsQRCqmUJFkyyRpmtS+33/PjAhT5ErNa5B
         /4Iq8trWkJEIaQhhS1d+5/j+2DEoRGwYZG/r6nqBbzCMSk6aNq112VCAQbjXgYM/e72E
         vQEKFl4Wp6RSlXh1LjRwIWESUyX9aMfPOXF4VEtB9Hwo8XDKgVuX06xs/tTNEH7kXklB
         hiNrcR7SaTc2Hr0ZaXCwHSoshiV26JCU7b/RrFJU9/DXuKIQA9PQLJmUzhL0uxchXSoq
         qhVRP3Uk/dge01FYlLkFF4HDXJeoG3dnYQqi7nd+PF80mZdrZAj1/uxkJZXOIIypYf5r
         z8FA==
X-Gm-Message-State: AOAM530iZEHqJbq4sFDibRq9p76N3vxLNMF97ZOXUpoDxI6+dCFrMx7S
        Tip3Cusq6+dSLy9c8wCxnQ4=
X-Google-Smtp-Source: ABdhPJyEzmQKmC7Kb7jfogLSXyLrjxG7Woq7WKpatFjKnInpS2Bgw0GVZhkNAsnyaBMvd4lv2Y7Y7Q==
X-Received: by 2002:a05:622a:120a:b0:2e1:c9ba:e99b with SMTP id y10-20020a05622a120a00b002e1c9bae99bmr723784qtx.685.1650568838876;
        Thu, 21 Apr 2022 12:20:38 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:38 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v4 0/7] staging: r8188eu: fix warnings reported by checkpatch
Date:   Thu, 21 Apr 2022 15:20:25 -0400
Message-Id: <cover.1650568579.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address style issues found by checkpatch in the
core/rtw_mlme.c file. 

Jaehee Park (7):
  staging: r8188eu: remove unnecessary braces in single statement block
  staging: r8188eu: remove spaces before tabs
  staging: r8188eu: remove 'added by' author comments
  staging: r8188eu: place constants on the right side of tests
  staging: r8188eu: replace spaces with tabs
  staging: r8188eu: correct typo in comments
  staging: r8188eu: remove unused else condition

 drivers/staging/r8188eu/core/rtw_mlme.c | 45 +++++++++++--------------
 1 file changed, 19 insertions(+), 26 deletions(-)

-- 
2.25.1

