Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011AA4F4DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454079AbiDFAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385436AbiDENwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:52:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC4B0D22
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:55:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qh7so16451605ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytesatwork-ch.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Acf4acQluxBBQ1rW9r9qNL8jfAQ/kyxdg57R0ZrmQeM=;
        b=pw4XB7KVBDqlmosjOS6xg6faW9nKtwA5PtUCZh7wOsDTNRiVRz6D4K+8wHBLOqxpa/
         rUpMrsmaS5cUPMIOugH14RHeoYs9Vvna71Lg0R6THFC8G3KdgTRebynSHNLbTdDGn3zz
         zeqcRDAn5WHFhq4Ke3wfuDp4AzFENOExhBk48qrHU5UUOzg20Y2B4sIlOJXGGjRfZC2F
         Xv4hv3f0vmVWPxAxgbLTheY8Qs0RT36etR9pR5qEQHDivsNyME1EevqwcIGGk4STAigS
         yeBR58tPNIpR2c+aieoGZk1n5FQDhRKKVdgt0bE5fwUxASiLm6FgTr/z4UhUL4jhKx3H
         BrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Acf4acQluxBBQ1rW9r9qNL8jfAQ/kyxdg57R0ZrmQeM=;
        b=tXfrPlyLwqvelUupb5yUeixRGJ2bDigcTEPkN6IDcTJFyqA0PdBv8h66qKcxYMUIUA
         Ac34hCxegcDGWFlJRsmFIAxIp9nuwZtSqBRdvcQtMRO6thWajc/UTVzLKMU6IyDjOKBL
         u7mKu1M37ZSHkwYo+b4G2dwfN3B6mINrRr2QZphRFEXja7DbD8I4tPQMiknMyQn0PvJJ
         FSYZFoqHRI25DVLXtTDGFajHd87gafQIewtllaI2/+XMxV0wQ1MdJK1FSlhavMR/UV9+
         6+jzs/qZlPbpNh87YZeUspWNaKt6k7whJaTKUejo4Eddd+Gmf8UrtKAbQgTs9ZOtFm8E
         0dNA==
X-Gm-Message-State: AOAM533MFYv33NUtl2DQiO816qHdaGbPbJZXFOhYKvE0leLtzYIhh0pw
        yHunI+XDuQEUAE7kM5hCsIFPpg==
X-Google-Smtp-Source: ABdhPJwN4vLCMXtDjdljJMLoWsW7c/00TcHwa5+FUbWUUIZpHaptN8XXakM1d/wlF3nKh836WcOu5w==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr3543897ejc.153.1649163313351;
        Tue, 05 Apr 2022 05:55:13 -0700 (PDT)
Received: from mimas.bytesatwork.ch (162.40.150.83.ftth.as8758.net. [83.150.40.162])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090626da00b006e7cb663277sm3060849ejc.90.2022.04.05.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:55:12 -0700 (PDT)
From:   Daniel Ammann <daniel.ammann@bytesatwork.ch>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: tps65218: Fix trivial typo in comment
Date:   Tue,  5 Apr 2022 14:54:25 +0200
Message-Id: <20220405125426.28016-1-daniel.ammann@bytesatwork.ch>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is for TPS65218, not TPS65219.

Signed-off-by: Daniel Ammann <daniel.ammann@bytesatwork.ch>
---
 include/linux/mfd/tps65218.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index f4ca367e3473..122e24ddbd4b 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -1,7 +1,7 @@
 /*
  * linux/mfd/tps65218.h
  *
- * Functions to access TPS65219 power management chip.
+ * Functions to access TPS65218 power management chip.
  *
  * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com/
  *
-- 
2.30.2

