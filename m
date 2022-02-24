Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B414C20B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiBXAfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiBXAfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:35:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F59EBB2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x18so417593pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gL3XTGq5gUROAVlMpm5UUf8rBYQ3NN/e4SMIW+cAkbs=;
        b=C4Rwg+RXOE2nLS9hHfaHBhxlxsndRx3kbfna2NfsUdZ3XpJQ5AADxr5uwaG260StFf
         6dnGtOShKtq3c29HEH35A3y13TZqQ9JgnufIEZ1nU8zOKrimmg+qFqpAQIXasCV44575
         TVJzBGqfbzWcTV65qxGiCssqAQmdcLROSZQfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL3XTGq5gUROAVlMpm5UUf8rBYQ3NN/e4SMIW+cAkbs=;
        b=QqYx0HcbsbJdRalRVZ+m5ZyyNN7zX/Fww4jwLj2gvsFkriAcsXIp881wOn6tmWvvPH
         oVQp/pHfquAdeyva7Bmlrs6y0oGachuNmjnMlMB0Jf8a9MhDHqkk/vB5yNANNuh8zuHa
         Chyl87Bh9BvXNvECniQWtfZy4cu5rfPcqBKcwkzqhRpyFNg0zbFbXmTe02NIceevJpj2
         76ETdUDady9lM1gf7levmD71HcOXemzHw5nJdB0mAIzPLLvY1iyJEECarbhh2F2DBLnz
         y/uFu+SBD6i6/qwfoVC2zWYmBf8QFBvdqAhvE4YfMWxygYbxUANEtkSOoaaFevZHMLUw
         S0hg==
X-Gm-Message-State: AOAM531VNpA1PI4H4Yx7jwA/mXNheOyWmBh88jGsiynG7kxZSru6lvPp
        8UMB+tl5QoqhoxG88BSev0Sksg==
X-Google-Smtp-Source: ABdhPJxfcv9LTi9fBh7Sk0mFa56j247B7kDzJ4ZLZMn7uUMjmf4tjsmzTnpNBeSPYQ6RV0PGjwdj2A==
X-Received: by 2002:a63:602:0:b0:373:efe4:8a24 with SMTP id 2-20020a630602000000b00373efe48a24mr269659pgg.287.1645662880090;
        Wed, 23 Feb 2022 16:34:40 -0800 (PST)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:e321:1e1b:f71e:33c])
        by smtp.gmail.com with ESMTPSA id ms7-20020a17090b234700b001bc7e6fc01csm4100344pjb.40.2022.02.23.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:34:39 -0800 (PST)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 2/3] memory: Update of_memory lpddr2 revision-id binding
Date:   Wed, 23 Feb 2022 16:34:20 -0800
Message-Id: <20220224003421.3440124-3-jwerner@chromium.org>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
In-Reply-To: <20220224003421.3440124-1-jwerner@chromium.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the code parsing the "jedec,lpddr2" device tree
binding to use the new `revision-id` property instead of the deprecated
`revision-id1` and `revision-id2` properties if available.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 drivers/memory/of_memory.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index b94408954d85cc..454a0e6d544cac 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -316,14 +316,21 @@ const struct lpddr2_info
 	struct property *prop;
 	const char *cp;
 	int err;
-
-	err = of_property_read_u32(np, "revision-id1", &info.revision_id1);
-	if (err)
-		info.revision_id1 = -ENOENT;
-
-	err = of_property_read_u32(np, "revision-id2", &info.revision_id2);
-	if (err)
-		info.revision_id2 = -ENOENT;
+	u32 revision_id[2];
+
+	err = of_property_read_u32_array(np, "revision-id", revision_id, 2);
+	if (!err) {
+		info.revision_id1 = revision_id[0];
+		info.revision_id2 = revision_id[1];
+	} else {
+		err = of_property_read_u32(np, "revision-id1", &info.revision_id1);
+		if (err)
+			info.revision_id1 = -ENOENT;
+
+		err = of_property_read_u32(np, "revision-id2", &info.revision_id2);
+		if (err)
+			info.revision_id2 = -ENOENT;
+	}
 
 	err = of_property_read_u32(np, "io-width", &info.io_width);
 	if (err)
-- 
2.31.0

