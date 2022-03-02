Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBCD4CAEB3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiCBTaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiCBTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:30:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66EB27B18;
        Wed,  2 Mar 2022 11:29:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so311795pjb.4;
        Wed, 02 Mar 2022 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzhXNQEk/98D9nQUp1p8H/GyW3pI8iVAEFCE5YOMGLY=;
        b=d+cdkiaLMABcaz2/BTbjX2lCMh2WlXg1OAvIXG+RneTxIPApCaeWTwrYce2FtoR3BQ
         j4EuGjR/HHxtLdAik2Q+eWeEdQ19c4n4FashAo5xeCMkY2QAblES/mrzXkLYwXKsIILi
         Rd63nuZNJgeljVaAVKFS9vExpPnVFse5i8GL27dYKjKEd6MViSZbT+psLuYBe/79FDuj
         j8R1BeeMnwBA3ptFzVlGgYOjjL3L/9f3gfzxLGHRuWfcUoO50cd0YJSHM8nj99Lvjc0u
         Gq/WoGEvp8j7hHi/2KAx3ASOO9zBaeaKMgrJQWqK9e6LZczSySjOEJMGsq+lXu0zFiqH
         78Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzhXNQEk/98D9nQUp1p8H/GyW3pI8iVAEFCE5YOMGLY=;
        b=cqPYoN9ncnseoHjDzOdgqMIEvDFEXjoRnu4UdisJF/kkrNtk58s1tDYMadWcrqaWNB
         Fk1aslHVR9B4bb3n/jSUY80PKbpUFxFVRZ3/J10Ixe/TUXOkF7Fa30ICc6i2Tw1/eVSp
         T5E4pizhlomj/ayJZw0VWQ2/xKPC768I0lFCyMxCjtISdKbYSLkWudxO1zIzmYrcm5ZH
         gOIbuSpWwLFnFbJdiPfnG59y3GVHH9AOt5l4Pzmx++mY8iTosvDeTJ+ccMSLyS3UhKCG
         6dxeruQ1MSYoGfXcB00I+led+9RLzVJKHx2l1HaH+/pt9y7Amnl/PcdSwC61/81K5VLn
         J3ag==
X-Gm-Message-State: AOAM531HJLMYSkacRsrPemqXjhJyBqseWiJyl6hMYjrdEUmSKIY3w1N9
        gOjY6KuxHceJU6pk996YcTeLgjed3Rs34Q==
X-Google-Smtp-Source: ABdhPJy6JyjjvgV7Esq1cCv1MhMeNUuMKG73Gd6Qjt1R93GuwVHnmRshzm15dwzxBFVlearJQEKFVg==
X-Received: by 2002:a17:902:e889:b0:151:a56d:eb8f with SMTP id w9-20020a170902e88900b00151a56deb8fmr1132881plg.142.1646249360397;
        Wed, 02 Mar 2022 11:29:20 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.154])
        by smtp.gmail.com with ESMTPSA id e21-20020a635455000000b00372badd9063sm16763076pgm.11.2022.03.02.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:29:20 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Han Xu <han.xu@nxp.com>
Subject: [PATCH] dt-bindings: spi: Update NXP Flexspi maintainer details
Date:   Thu,  3 Mar 2022 00:59:15 +0530
Message-Id: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add Han Xu as flexspi maintainer.
Also, update my email address as previous one is not working anymore.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 283815d59e85..1b552c298277 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: NXP Flex Serial Peripheral Interface (FSPI)
 
 maintainers:
-  - Kuldeep Singh <kuldeep.singh@nxp.com>
+  - Han Xu <han.xu@nxp.com>
+  - Kuldeep Singh <singh.kuldeep87k@gmail.com>
 
 allOf:
   - $ref: "spi-controller.yaml#"
-- 
2.25.1

