Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A61564348
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGBXMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiGBXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F6BC1A;
        Sat,  2 Jul 2022 16:12:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so10244920ejj.12;
        Sat, 02 Jul 2022 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtcfJDlBtIQgsJctsItB2jzUjAIsrPcb5sLRSibvewY=;
        b=qed6BExX6r9RFcO7N/YaPXvv0CuF4LZlMKFRZXUeWaKTX/oo0mMQ0CtWdqXxVK/Pe8
         tSmMt0syPx0daH/cypM0v17Kii6YdnDYYxAbqphyO7eHeuVf2CwcCNdXT+jIeKK5v/KG
         gI2C/gfRJmZ09ZKXZE4nK0Kr8eAteRL76xpgvq1HTQxuKUFR7ZTTnwiou1W49TV2xFrQ
         aVJr8Qdl4HOoixPdSH1HSkHp+qhQdFiLuF9ZUYnnoh7YtC+j7Oti5EtFatHJrSyvhYnQ
         2L1ybUFJu2Y1KPwc3yfmnkGKC4LiyZO2YCD7imITIa8sdgVNjI92w+oFjLPSnVTJj+qW
         Bo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtcfJDlBtIQgsJctsItB2jzUjAIsrPcb5sLRSibvewY=;
        b=VJVrQkkhzyPPeMOsb1CcLPvSiEJVBqfFXtQgBNvJxHWY0WyUckO32NnbFlmWVViZz2
         qGooCIaONS5fC5Qb8cjRn7St+S/e18gNPIM2wBECrNELxdJFRhk5ri6I5UUBs6BtVcWT
         2F8akYytf0gQ6HU2yRaOz9vzLZrc2EeK4jTk4HVqr+A9Ll2MNR5qxwEb2pFGgH05AaLf
         VB6FTKuPbXo6vBAXtajztd04ZJOOeI0+18+LMGusKl5WMWY9Z6vQSX1g8BNfWJkZFJ2B
         NtvWX9QEXlWZD+hp1PhdRK4A7rtYnFzClzIP6eds+FLJDH8CQrFwYE/z0ybFigmBhpvv
         JnCQ==
X-Gm-Message-State: AJIora+K7zD0HP1Jjt5b9lF+WFsniNJI85g9yX/6yZPYN49EmZN6lJ5/
        hjWs/xRY9ia/eU7vdrFspnU=
X-Google-Smtp-Source: AGRyM1uPubQUBkUKfCj6Pab0PNni4xlv9AST3IHTvB/EK4KaVO/XfMVh/qyaIxTVFiFgUYRv+RmQCw==
X-Received: by 2002:a17:907:608b:b0:722:f954:6e3 with SMTP id ht11-20020a170907608b00b00722f95406e3mr21619271ejc.550.1656803561997;
        Sat, 02 Jul 2022 16:12:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: mtd: intel: lgm-nand: Fix maximum chip select value
Date:   Sun,  3 Jul 2022 01:12:21 +0200
Message-Id: <20220702231227.1579176-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
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

The Intel LGM NAND IP only supports two chip selects: There's only two
CS and ADDR_SEL register sets. Fix the maximum allowed chip select value
according to the dt-bindings.

Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index 763ee3e1faf3..04f26196c4c1 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -51,7 +51,7 @@ patternProperties:
     properties:
       reg:
         minimum: 0
-        maximum: 7
+        maximum: 1
 
       nand-ecc-mode: true
 
-- 
2.37.0

