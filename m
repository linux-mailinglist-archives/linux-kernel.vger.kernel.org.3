Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38A46A334
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbhLFRpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:45:11 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46764 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243816AbhLFRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:45:04 -0500
Received: by mail-oi1-f171.google.com with SMTP id s139so22726526oie.13;
        Mon, 06 Dec 2021 09:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etHzQ9NM1GZEqBXMjqlYDuSFEcEX2xS/LEQ7h5EquGo=;
        b=YctZurHRkX13CFAwwRZuxftsdGSyQ3kQ6ztesZRMYxLNXOqbp61H6LDZ96cg4ia14b
         85Hiz69HAN3Y2h2K6NRXKTXS5VyDKlcJDGSbOEAII+esEA/5gbvwVYkBkd361TRgU2Px
         GnR9m1QjL8kZqdNQoJUWA60A0dBobssVSPxWB3qz06OGrHVkDF0Ofuz2uVXViRTXGD4F
         j8MQuIV0v8o6Mx/W3pdTb4eCBkqEAGu6hf/1+OOBOTaTqohN3XJ1uShPQ44yUucuE204
         Cb6IkN/YP6xbLYdZSZ/Ulw+0ulmvXxViVOeIhkCAvuzVAsgJA6oWiXhYSrqJg4GwxGZ9
         vYWw==
X-Gm-Message-State: AOAM5304DJQBQSxH/zv37xO5zBxRja7iaFdaYbvTCiNWjLSxZT+LWChr
        AlyBEyBr8E12998VGDVbmg==
X-Google-Smtp-Source: ABdhPJwwxTmZ7Eqr9wMl8P5TiW8Ov5GJd5FOiHq71uFdfxjXaV9kDi+hp+5N1L25yBtoBolRABsZEA==
X-Received: by 2002:a05:6808:2309:: with SMTP id bn9mr24795493oib.42.1638812495150;
        Mon, 06 Dec 2021 09:41:35 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id u13sm2244644oop.28.2021.12.06.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:41:34 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvmem: Add missing 'reg' property
Date:   Mon,  6 Dec 2021 11:41:33 -0600
Message-Id: <20211206174133.2296265-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, the following warnings
are generated in the nvmem examples:

Documentation/devicetree/bindings/nvmem/st,stm32-romem.example.dt.yaml: efuse@1fff7800: Unevaluated properties are not allowed ('reg' was unexpected)
Documentation/devicetree/bindings/nvmem/rmem.example.dt.yaml: nvram@10000000: Unevaluated properties are not allowed ('reg' was unexpected)
Documentation/devicetree/bindings/nvmem/brcm,nvram.example.dt.yaml: nvram@1eff0000: Unevaluated properties are not allowed ('reg' was unexpected)

Add the missing 'reg' property definition.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Rafał Miłecki <rafal@milecki.pl>
Cc: Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml     | 3 +++
 Documentation/devicetree/bindings/nvmem/rmem.yaml           | 3 +++
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 58ff6b0bdb1a..8c3f0cd22821 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -24,6 +24,9 @@ properties:
   compatible:
     const: brcm,nvram
 
+  reg:
+    maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
index 1d85a0a30846..a4a755dcfc43 100644
--- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -19,6 +19,9 @@ properties:
           - raspberrypi,bootloader-config
       - const: nvmem-rmem
 
+  reg:
+    maxItems: 1
+
   no-map:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index a48c8fa56bce..448a2678dc62 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -24,6 +24,9 @@ properties:
       - st,stm32f4-otp
       - st,stm32mp15-bsec
 
+  reg:
+    maxItems: 1
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.32.0

