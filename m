Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153157A95C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiGSVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiGSVuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:50:09 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4831CF5;
        Tue, 19 Jul 2022 14:50:06 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id n138so11704021iod.4;
        Tue, 19 Jul 2022 14:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uc8dTbCs7ii6OtIpUoNiWI+bZ2IGfa5Sn9yPhzaCkic=;
        b=ERKBkeCef4Wwnw8kKvK6fr3YT4j0Vtp7HRMU0twFyVY3ahfOjbBlEEET1vZu3Lj3cc
         rhr83Ap3yOEe3SRxTGCdvob11eeK+TOOLu0Na2WIyx3+d3zR+YCKcSfnGshmpdEd9jnH
         Jdat2o5Y/HXBOZ+6oHT1GUL1L6Cnq1M5pK2/IVIbrclgBZvc5XbCN0SN3nnhZcto6EUf
         2dcepZvDPddw9S1nN5u35O38lgWfCP92rS52BNYKtd8P0D16ywBLYVwQ/Zjp8xQ8jsZ2
         jTaZ+K3GlbHhekzlLC1DkBjUJ9VL9XmD9+r/7GbbZI2JCqhfndF+E+QLOv/DrOoyAjtf
         UINg==
X-Gm-Message-State: AJIora9TOWPsVcSwGKR51yJufWGMYeSjoeM1hkBV6uLzd6VpUTS1w5qU
        MPvJYR1+nyWP3SCXSYQvqw==
X-Google-Smtp-Source: AGRyM1sSjCNPW0y8claL4HT40MMZy1QtSqugJ1KONdXeSON48IRYgp7p0MLK3JCLiUcY4Abp5Db2Qg==
X-Received: by 2002:a05:6638:168e:b0:341:5b82:a46f with SMTP id f14-20020a056638168e00b003415b82a46fmr9722732jat.201.1658267405972;
        Tue, 19 Jul 2022 14:50:05 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id z8-20020a05660229c800b00674c8448c3csm7811758ioq.6.2022.07.19.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:50:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: st,stm32: Correct 'resets' property name
Date:   Tue, 19 Jul 2022 15:49:54 -0600
Message-Id: <20220719214955.1875020-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct property name for the reset binding is 'resets', not 'reset'.
Assuming actual users are correct, this error didn't show up due to
missing 'additionalProperties: false'. Fix the name and add missing
'additionalProperties'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 335ffc1353b5..d35dcc4f0242 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -59,6 +59,7 @@ properties:
 patternProperties:
   '^gpio@[0-9a-f]*$':
     type: object
+    additionalProperties: false
     properties:
       gpio-controller: true
       '#gpio-cells':
@@ -68,8 +69,7 @@ patternProperties:
         maxItems: 1
       clocks:
         maxItems: 1
-      reset:
-        minItems: 1
+      resets:
         maxItems: 1
       gpio-ranges:
         minItems: 1
-- 
2.34.1

