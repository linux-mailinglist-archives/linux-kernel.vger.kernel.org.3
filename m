Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD958F02D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiHJQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiHJQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:16:42 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9086554B;
        Wed, 10 Aug 2022 09:16:39 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id r5so12521476iod.10;
        Wed, 10 Aug 2022 09:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OymQtlIn9kZlALxo/zpxpVBZn4m4pQcHISZuq81uRio=;
        b=MjcxaaCnzo2q7MjCBOI6nyRogI+9Gax0RofvMu6oRLfyqO0v6qjfzh9x4RlLfa2J7e
         d5tYMiEcW5FEh7lb50cmTVkSCbLp2HLgjDq7QwMCKgTXah5hVIepbGNt+E+MyWsAVP30
         zs+hYHwQrjyXldUTRFRiSwyN3wm4TF3uMtCsJh0JpBB5b1XodTeZO/DLc95w0RdNGv2e
         kMGvvqg6MN1YUtmiTXZVsOB7Nleu2NrRQRlZpF0e2b55BXzedvGqEZWRxeK4zKbzqJ1k
         9GtYOeSWFZKbsIr/xZBrzrvbymzay5ibEcJxBwUf7TYUTnXPV/RsGO/9rJdgHhC3UezT
         aJzg==
X-Gm-Message-State: ACgBeo2t4qycyVMpVpUHiXjXMVvtT+lhMcGuHdgWlGFJRU0LJXRjyuZ5
        iua5ONQzT6LvFNnCUIZ8mg==
X-Google-Smtp-Source: AA6agR4KUEtY0qAyGhNW2eFu0jzbjqmIighV7qcuqPWJtLkc+jLRcrx7+pJAVcN91xpZjv0I7uWyOg==
X-Received: by 2002:a05:6602:2b8a:b0:67b:c57f:b4bc with SMTP id r10-20020a0566022b8a00b0067bc57fb4bcmr11332902iov.55.1660148198176;
        Wed, 10 Aug 2022 09:16:38 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id z17-20020a056602081100b0067885c5fd94sm2496974iow.29.2022.08.10.09.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:16:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: aspeed: Add missing properties to examples
Date:   Wed, 10 Aug 2022 10:16:34 -0600
Message-Id: <20220810161635.73936-2-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810161635.73936-1-robh@kernel.org>
References: <20220810161635.73936-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aspeed pinctrl parent node (SCU) in the examples is missing various
properties. Add the properties in preparation for the SCU schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml | 6 ++++++
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml | 4 ++++
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index d3a8911728d0..f4f1ee6b116e 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -63,6 +63,12 @@ examples:
     syscon: scu@1e6e2000 {
         compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
         reg = <0x1e6e2000 0x1a8>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
 
         pinctrl: pinctrl {
             compatible = "aspeed,ast2400-pinctrl";
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 5d2c1b1fb7fd..8168f0088471 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -82,6 +82,10 @@ examples:
         #clock-cells = <1>;
         #reset-cells = <1>;
 
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
+
         pinctrl: pinctrl {
             compatible = "aspeed,ast2500-pinctrl";
             aspeed,external-nodes = <&gfx>, <&lhc>;
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index e92686d2f062..62424c42c981 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -96,6 +96,12 @@ examples:
     syscon: scu@1e6e2000 {
         compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
         reg = <0x1e6e2000 0xf6c>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
 
         pinctrl: pinctrl {
             compatible = "aspeed,ast2600-pinctrl";
-- 
2.34.1

