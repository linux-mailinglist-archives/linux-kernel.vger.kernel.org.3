Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB4565CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiGDRTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiGDRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874126E2;
        Mon,  4 Jul 2022 10:19:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a13so16749149lfr.10;
        Mon, 04 Jul 2022 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knFtpsDUHJLhvP+nNFn6yLtZbr5Vu25n0owL6mtc+zk=;
        b=pvGal0LOB0yFzBlXFuxaiIecuEofk4mw2GbDEFA2PXk0x5lAB6OcvGwLpRVHV+zIdl
         qBikG+v7m3I9suYueNHdMoJPJlbsA8Xs29FskxFqHrxmwDYi+CuLWitoaG6xeD5WxMdI
         MwewFaV7iTLnWv41OfAm865T722mRxBOWbOfFhcEtlcSpFsRTTD9Jt0iaXVutMZjupyw
         EYEW/Eao2jwMm/HjQ3z9UNd5/h1EkEaahZyJchzU1dG9nRUUjEhspp+08bz2KlMbO82r
         /C9pPsod/MstNUq8Pv+zSUjhgp3k80+6AWyTfVUax8YoI5rsKJwVnhWv2CjwBu0jICRZ
         QnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knFtpsDUHJLhvP+nNFn6yLtZbr5Vu25n0owL6mtc+zk=;
        b=rXPVugCHuc+KsqyjFwyzd2l0PT1irikX+OmhDHkta6x/rAXunBXTQ4ahDoDkm2kxPm
         w6JL4uF80tXYy0uWINwGaKZaTtKnHjGwCDdztIWDjR8OBRKx7BF0zGa5qL+LRfymQWMr
         FCJSuwI80RI5UAbXxYT2rH1RKlJ/0rnAAqC/drmhJBx7CHC2RL9Gv8rGKE2JdQWyDs/h
         bQxIzA9LsbJKcR3rWi02RgDeIS4WLaJQY8vlAt1y3EB9ONq9hrRsDTWhpewnQ0CY+86C
         ve9gyjHZSfdPxqxdNA3N23Ad/U/tFGjEr48e278rRFyhc3UwnsDrg3zAran49oudxL8K
         D4/A==
X-Gm-Message-State: AJIora/4qR5s2xKdsKYBdSwh6eBHnEi8lryHvy+ZqPNiCkl9VY2aDBuy
        sCqOhXMr31F/NjnvntKLnA4=
X-Google-Smtp-Source: AGRyM1vKCFfMSZh0twn9oJ/TAoHFCQ2yOMpSU9QlGuqHVsWr/cIRujNV4AHSk70itMi7TadPBYbexw==
X-Received: by 2002:a05:6512:c09:b0:47f:bd92:4181 with SMTP id z9-20020a0565120c0900b0047fbd924181mr20050191lfu.470.1656955156496;
        Mon, 04 Jul 2022 10:19:16 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:15 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 7/9] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Mon,  4 Jul 2022 19:21:14 +0200
Message-Id: <20220704172116.195841-8-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704172116.195841-1-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
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

The Data Ready Output Pin is either hard wired to work as high
impedance or push-pull. Make it configurable.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 95ab285f4eba..57a16380f864 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -36,6 +36,13 @@ properties:
     description: IRQ line of the ADC
     maxItems: 1
 
+  microchip,data-ready-hiz:
+    description:
+      Data Ready Pin Inactive State Control
+      true = The DR pin state is high-impedance when data are NOT ready
+      false = The DR pin state is a logic high when data are NOT ready
+    type: boolean
+
   microchip,device-addr:
     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.36.1

