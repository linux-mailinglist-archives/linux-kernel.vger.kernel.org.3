Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2193455C3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiF0TBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiF0TBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:01:07 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B423F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:01:05 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B617A2EFBDA;
        Mon, 27 Jun 2022 21:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656356463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wn0bl7AEtoo27Tv0nyM7ZfJLPJSTh5NOhrQjwguJzO8=;
        b=WMGJ/pdTnDkhYUfFQaZZUsMUFPsVhJlYBA/iZtUIwFPySOxQECxly9teX15XZfryJ5GMqI
        V63LyvRM5Y3RkZKW2r47TgHfjsl7sn9/Jsa/HZmvjYnaM1ZKXX8NtWSZ5VAJttVw6W62UI
        DDbWFHOhT4Vg7EFElW7ZP98YbIdzkwM3t16lQlUbbEshA2eUFh5Qeg+6LmmHTbsRn6+fZC
        bb6/3n8R64rNI4B2AtemgicEX8RO2GzFfEBsMxF2zq7nSIITpTnpY1YegQciuFdRedBIFt
        OkBLgM/N/bd6AUBNUNoQjuSPUYVmnTLlzwSS5b4Ca2lObuEQYETXJ29w+ZerLQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 1/2] dt-bindings: watchdog: realtek,otto-wdt: add RTL9310
Date:   Mon, 27 Jun 2022 21:00:55 +0200
Message-Id: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the realtek,rtl9310-wdt compatible to the Realtek Otto watchdog
binding.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
index 11b220a5e0f6..099245fe7b10 100644
--- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
@@ -29,6 +29,7 @@ properties:
       - realtek,rtl8380-wdt
       - realtek,rtl8390-wdt
       - realtek,rtl9300-wdt
+      - realtek,rtl9310-wdt
 
   reg:
     maxItems: 1
-- 
2.36.1

