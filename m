Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C38560BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiF2Vf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiF2VfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75623150E;
        Wed, 29 Jun 2022 14:35:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d2so23428995ejy.1;
        Wed, 29 Jun 2022 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hFpT71w8Y8NFBACfpOSVZPBieVKM+1lN0Bhp8Mtmog=;
        b=H6HWFiB6JDpuRFekKuj3enfoYHoGG3hh2lHBvMgE72/kEkTAXkW7fx9WhrLALCcE7t
         M1bootZg9eWsWesjH/X6iq+6bQnJMBH+tM8aiTBaHX4qA8k7jyt8ISL/VnJEbnJWYR6Q
         Wct98avi+zpjZQh4S4YyG+RkVECv/5mR3DIXDt9pkM5mtWXppq2w8rlGXr+Yb6B+qaSA
         C2GAN+9nm6eKy7g6hJVsZmRmDcSTOBk5//Xp9qkdUM+sdhpjHrfWX/PFNosvuUwP4/is
         fbMtqXo7VT4sNcbVL/OQuQsACLp+yYjDP7eESDkZ5MmHE+M56LW6RRwGIjeV4XY7tYj2
         DmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hFpT71w8Y8NFBACfpOSVZPBieVKM+1lN0Bhp8Mtmog=;
        b=tV/NcBZLE2UhR+ljz8L9VHP0f8tkgk+VGzrzfIeHDrScufl7VzoW23i3CAF7y0RhkF
         i9nPm+Gx9rwxCyyCzy2tzgSdoNt4C4Nr9eZmJLEk+dBVGCJWrw6vitpPOD2YxVAZKCFt
         jpKMdEnGfVRml+66YLW33NDpLbymcEx1DA4QD5tHjVfd/rlVOh3zwklvMFpheZOtuTp2
         RND9FMAJ23SMI9Qs/tNbrAwyVAPXjylC7Vtgwr+Whqb8UGdG8+xvG2+XFsb9dL2I98YQ
         RzIF7Xy1qSek5GvaxlNIGW1tAUb+hxNr6u7UQEPl0aujucLmBHbM8ia5JVFxCCljpBWV
         Pu2g==
X-Gm-Message-State: AJIora/ycFgZkXNYrTXVIQSdroMp2+emnH5Z4YbreHNIGsaKtex6H1he
        wLW41iJCoer7eRtCwXewoec=
X-Google-Smtp-Source: AGRyM1vmY4F3HF0zBUzjk7LEOZNPMtqy4zokl2BXrJnajDCerr9z5yokRpXpa+saTTZkiVB7rnBxoA==
X-Received: by 2002:a17:907:7f90:b0:726:e8ed:3c28 with SMTP id qk16-20020a1709077f9000b00726e8ed3c28mr5521372ejc.63.1656538520504;
        Wed, 29 Jun 2022 14:35:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible string
Date:   Wed, 29 Jun 2022 23:35:01 +0200
Message-Id: <20220629213508.1989600-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
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

The driver which was added at the same time as the dt-bindings uses the
compatible string "intel,lgm-ebunand". Use the same compatible string
also in the dt-bindings.

Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
index 30e0c66ab0eb..c45dd87fb5fd 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
@@ -14,7 +14,7 @@ maintainers:
 
 properties:
   compatible:
-    const: intel,lgm-nand
+    const: intel,lgm-ebunand
 
   reg:
     maxItems: 6
@@ -75,7 +75,7 @@ additionalProperties: false
 examples:
   - |
     nand-controller@e0f00000 {
-      compatible = "intel,lgm-nand";
+      compatible = "intel,lgm-ebunand";
       reg = <0xe0f00000 0x100>,
             <0xe1000000 0x300>,
             <0xe1400000 0x8000>,
-- 
2.37.0

