Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4E4FE94C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiDLUIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiDLUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:07:29 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9C765A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 75so11831424qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hepSgzGX1ayc5uaj+DhWfA1vMc3etzGY6KGlUx8uOco=;
        b=PqH3myYYEiMPoqI86MF0nXFrvRxRIHfXKpTlfObqjZJnTOf+3mjUYUh+R+kIOYs4hJ
         kTAqkPm1coLb4HqVU9FlJbQkE+Z7s7WM+0TrADSKnyuczW3KmOO/fALzISpjqHQZAo+Q
         UCuLRNoQl+DufWzGtMIgHSVVJvxz/ZcYQ2p7Ob2XPFKscZIvf8Y4+btFtXkNMievHvfc
         Y1zkIkZ+ZyWdICeueBhHF5DVwUwLgw2afEIKTD2ZN8Q4HOEUot135n3jA1CI4OAABlV5
         +bIaO39UAOZB0gHxTZvqurHK4Y77blmEwL33sYlIvci5FWWt4yaMQ+QUmoV7C6stl67V
         UgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hepSgzGX1ayc5uaj+DhWfA1vMc3etzGY6KGlUx8uOco=;
        b=1YiHSKJgK/1NYXBDLnq6lI88tE9oVIYQl8IQtQTIxozlZR5Iyk/ZbR9QG4X1CoHXjH
         GU/zbKjAAhv/rOkdLBPEANshY3N8uZqnk7h3pWLwNkuqpO98qQXFyk+0scC/5WH4B6AR
         E4jQR38z8MboZv9Vd7PGjgHr+SaIoZV9tFAnEPFIDItjx3iuBYd1xN33pONVxfdT5Nab
         ugbrjWswDJWNUvM/Eb1j7M5EzoBvj88HMm7tlJagCNIBEifUqHqbQ3ktk3PkO/QsQ1RN
         DJrqJsSt+fGj7pKGbYhfuDXPNwlWTX30pXheuzKMDG1cF8MgKesSx7YSdExq09qFBhVL
         hivA==
X-Gm-Message-State: AOAM531bvWRVgBIL8gyp5nIf3JFf0cxighPBNGp0KxMBtX7ka+y1cBj0
        wBnPk6UbcTPmiP6N3XVXRiM=
X-Google-Smtp-Source: ABdhPJySqzDv3PGtG9/O5YcAzDMDnFRohUff7hHMdby3sYkeQsP33V9rXq8vbvK/mrOzdnbpyQO/Lg==
X-Received: by 2002:a37:9a83:0:b0:67b:31be:2ac2 with SMTP id c125-20020a379a83000000b0067b31be2ac2mr4489603qke.416.1649793570850;
        Tue, 12 Apr 2022 12:59:30 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm27270744qtw.26.2022.04.12.12.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:59:30 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH v2 2/2] staging: greybus: remove unneeded return
Date:   Tue, 12 Apr 2022 15:59:15 -0400
Message-Id: <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649793138.git.jhpark1013@gmail.com>
References: <cover.1649793138.git.jhpark1013@gmail.com>
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

An empty function with void return type does not need an explicit
return. Issue found by checkpatch.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 0f50d1e51e2c..3e3a16568def 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
 static void gbcodec_remove(struct snd_soc_component *comp)
 {
 	/* Empty function for now */
-	return;
 }
 
 static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
-- 
2.25.1

