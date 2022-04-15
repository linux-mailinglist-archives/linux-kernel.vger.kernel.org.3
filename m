Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D023502D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355426AbiDOPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356293AbiDOPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:39:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074B13DA46
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e21so11044948wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8lmuusreyEB7Gud7csUtw7tpltYDp61Pfem/SE6pZk=;
        b=Td7opDcQaMHI3JFBSWitUPOiGjC1BZcN+VXkNxXfzTacxCPZd+RlBamsom/P6pj6hg
         EQXrRuHGXiNXFQtSrR3QL1QbiiNbjPTITd8XdGNJyB82Ht5mkqdGh5NTUY6JlXUr5pcI
         1GhmEzwbf39+IAX+BfrK0XFv21dUff4s5Uie+EEAFN6tGnT8k7GalPtJr0bbWKkJ/t+I
         LCf964j2RpBGLIc9wst5Vwsn1c4F+klbJrplVP42wMIlCUMJwMzI+m5JAQXDMcnvfCSy
         EI6YeGHcj7aHLbpDBaAkPXjZMQojCrSqhAnsraX9fvf0KOLJVNgLWd+mzHnJMKoTfYCv
         CaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8lmuusreyEB7Gud7csUtw7tpltYDp61Pfem/SE6pZk=;
        b=5z0S/5566S8yUFj6PFxY8peHfJA3CpzEfmwbN5QI8WJzL804+kWXtEe5Fd1r79q7zo
         8EFY1MfVninO5NL7ZuLB8eQeyKY50XnuK7ByxpEdQHsDhJ7UiXRLKMT7vNyqWaqdtDk4
         kG6dGk0nDrICFc+xXMtLimyzWxBX5epn7fxwPsa3IYdPMEBkUM6P++x0p2zBwO6pe5b/
         tlyIHHmFtIN6AG2lST6Xqx4UBRWpWuWtngpJm061N5xFKktVITpjmNsp6tVh0L71093p
         yPZ1PCMZlWJYyNPlaN0KPTA3YiPehgrO4zlA/Wmw/ihk1XMKOAGDWJtTFN4bXRHX10+r
         ja/Q==
X-Gm-Message-State: AOAM532V4FOOUa+nsh6fufLVMsmSna0MDTAbzWAIlDIPmt2Ss2tnOBwH
        0xbcK/fu/4faZWzj9TQmjfM8Mg==
X-Google-Smtp-Source: ABdhPJyicB0kEbhTFgNRydBA+wCxkMiQhnsXg+5hKIJU185vpb3FHT12FRvF9HoZokb6+MthOFW4HA==
X-Received: by 2002:adf:d1e3:0:b0:20a:7841:b9b4 with SMTP id g3-20020adfd1e3000000b0020a7841b9b4mr4299001wrd.61.1650037018548;
        Fri, 15 Apr 2022 08:36:58 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm8459292wmb.15.2022.04.15.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:36:58 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mfd: add missing defines necessary for mtk-pmic-keys support
Date:   Fri, 15 Apr 2022 17:36:24 +0200
Message-Id: <20220415153629.1817202-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415153629.1817202-1-fparent@baylibre.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
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

Add 2 missing MT6359 registers that are needed to implement
the keyboard driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 include/linux/mfd/mt6359/registers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/mt6359/registers.h b/include/linux/mfd/mt6359/registers.h
index 2135c9695918..2a4394a27b1c 100644
--- a/include/linux/mfd/mt6359/registers.h
+++ b/include/linux/mfd/mt6359/registers.h
@@ -8,6 +8,8 @@
 
 /* PMIC Registers */
 #define MT6359_SWCID                         0xa
+#define MT6359_TOPSTATUS                     0x2a
+#define MT6359_TOP_RST_MISC                  0x14c
 #define MT6359_MISC_TOP_INT_CON0             0x188
 #define MT6359_MISC_TOP_INT_STATUS0          0x194
 #define MT6359_TOP_INT_STATUS0               0x19e
-- 
2.35.2

