Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABD59E8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiHWRW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiHWRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:01 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016EF5AA;
        Tue, 23 Aug 2022 07:57:04 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id a133so8510491oif.4;
        Tue, 23 Aug 2022 07:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SMkQGb2meOHqQ3XeuH36b0daZ7EGL7C2+BlU5YxZCws=;
        b=BalsLBBIERJdDuCeO4DwxpP/RH9FZqlgn78d2w2hGal7f3K1BFaJMX/8lREUB0ZzjR
         BPhjSIavpN4jbod0ogx071dN8crIiFYbN5xucVPLCjj4pvK1eNQ5osTsRTSPmxdP9mt1
         Oagaz7Js3GPCQRfxfGlFuVy/eZ/mvG43nRYq439jlGdQoiExSR8A3Oo0Zz5UD/UVXvDw
         eB7EKOqdVAjtqkfO+elxG0gn5NTEUbKj1x8IlXgVHUfZds5/qXJjeSNCspcIG9DlgipX
         RVWtmP02iGWrLmp/DFE63u6If3AeZvsaeEEwpWjb/T4jzxJ0vZ82Ya3c3lGm4IsBvh3v
         3WRg==
X-Gm-Message-State: ACgBeo3TJAK6dm2uhKb85FFEHqOjP7bZ3I2pweDy9qKDjykDJp4xw4aA
        4CKZKec6k2AaPGw43lJ/0w==
X-Google-Smtp-Source: AA6agR6xzWvGgZqYd3x7xuRg7BZuL+v+Yucp3s++eMMwthXLGw+y7H/8hoYXfp6Y4J0eX+e/+z87/Q==
X-Received: by 2002:a05:6808:1a06:b0:343:290e:813e with SMTP id bk6-20020a0568081a0600b00343290e813emr1456943oib.256.1661266623521;
        Tue, 23 Aug 2022 07:57:03 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: samsung: Add 'power-domains' property
Date:   Tue, 23 Aug 2022 09:56:32 -0500
Message-Id: <20220823145649.3118479-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Some Samsung UARTs are in a power domain, so allow 'power-domains'
property.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 901c1e2cea28..d20f77c44dfd 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -69,6 +69,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  power-domains:
+    maxItems: 1
+
   samsung,uart-fifosize:
     description: The fifo size supported by the UART channel.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.34.1

