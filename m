Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA64C6CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiB1Mok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiB1Mof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:44:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298F4705E;
        Mon, 28 Feb 2022 04:43:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so11278900pjb.0;
        Mon, 28 Feb 2022 04:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrRsoKRtG0mcfhdQPUnOY8nojOfT4rmkj88AgkRskwM=;
        b=pnZNncTdmyfuefVRpe2IvducML65L4g7+/qFZ3TrIgqStJSuQ7UGb6eQt3FtmbCE/c
         QQdFGvS3KDYTOEsMQ6NfyVR7CtvqPqoJEZMMyJTgkCX6YAwdnKh3ttJjhHtiCOzs1gZG
         U4xCDYRl7vBFza1x3KwYU0p3yasMZ3S4jlfhMgkfz1aYed4kNjHECFRR577vin0Q6h1U
         xonjDctMMo2nu0XChVquH1Cawc6Xq8bSQ3Y2V1fzWQRanK36DD2OWdTk/1hY5hIxF516
         CE3Gw7uqQNmWfapb/j2OrRON+GVQ3bbJWTieoJubBkQmE2kiBRIVmp9HI8ne5XIwS57V
         6tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrRsoKRtG0mcfhdQPUnOY8nojOfT4rmkj88AgkRskwM=;
        b=qIzfaOgJQu6qJ8EGBNFhKO/zulYin8b6eUd5VkEwpNxXIw/sih47m5A4T0UsXfYyFa
         XYgqxruqFAWoinKL5GDKizhwiafqfG/55gqRM7/hH7KTQJ+SnJ+TKMexkIj5t+ky2A6K
         FUouMQYYxeitzk/2eZZ0SgTFPCfZNqHUCtDVQ+uZxschswWysUxwq74XQKiPvqI18ngV
         2lExlTjixe63lbXtdVWWmZ3/aqiGmQn/Ga2FRkthQPGyUt43nYLX1HIpKuEIXzZ7HWO9
         am4DwQ3Bc7YDaN5DIge75YE/yz0c0GRRJHYbttbwdPPdfiUV/gcquBMof1McXj917oOo
         8Wjw==
X-Gm-Message-State: AOAM533B7AsOQ3wi2CBNMTiBPlBMVxJZfKaJrN+DjxRXeBCkdJB2TtMN
        gBnYLtRDLecdPT64UUlNMr0=
X-Google-Smtp-Source: ABdhPJwNbvaXDpT841PdpIqVwHAplHPhGYbqz0CTAtKqYv9ptJWEv1RkOzVqDgJ4Iy49jn2Mx3poCg==
X-Received: by 2002:a17:90a:e606:b0:1bc:4c56:b31 with SMTP id j6-20020a17090ae60600b001bc4c560b31mr16254434pjy.49.1646052236750;
        Mon, 28 Feb 2022 04:43:56 -0800 (PST)
Received: from localhost.localdomain ([122.161.51.77])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b004e1bf2f5818sm14129214pfj.87.2022.02.28.04.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:43:56 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] dt-bindings: spi: Update clock-names property for ARM pl022
Date:   Mon, 28 Feb 2022 18:13:44 +0530
Message-Id: <20220228124345.99474-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
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

Below are the possibilities of pl022 clock-names property:
    - apb_pclk
    - [sspclk, SSPCLK, spiclk], apb_pclk

The current schema refers to second case and does not consider first
one. Hence, resolve the below dtc warnings by updating clock properties:

arch/arm64/boot/dts/lg/lg1313-ref.dt.yaml: spi@fe900000: clock-names:0:
'apb_pclk' is not one of ['SSPCLK', 'sspclk']
    From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 7d36e15db5b3..5f6926a58b15 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -38,11 +38,14 @@ properties:
     maxItems: 2
 
   clock-names:
-    items:
+    oneOf:
       - enum:
-          - SSPCLK
-          - sspclk
-      - const: apb_pclk
+          - apb_pclk
+      - items:
+          - enum:
+              - sspclk
+              - SSPCLK
+          - const: apb_pclk
 
   pl022,autosuspend-delay:
     description: delay in ms following transfer completion before the
-- 
2.25.1

