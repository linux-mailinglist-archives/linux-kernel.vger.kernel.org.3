Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD94FAA9E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiDIUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDIUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:09 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890E24926C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:05:01 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 319742C4657;
        Sat,  9 Apr 2022 21:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkfs1gHO5sgAn4raphVRPtE947SinFm+RwKVlazXeBM=;
        b=yulkC0mLCL9H8dfj88+37waAQabf2/mlTI1o3iV8bw8MjkyLQqkTJbglX+qN+cnmzffJV6
        Fhabzw0N27syJwzbsfrv+eA6InEoAyWjpJ727JYIFz859Hu9sZQMrioB/JMbl5xT/FSpdN
        pI6of76Ovu+4KVUKdc7jxXcyCVCgGm9L4c4Nt3yf5UFhixETO9l3RXqF0hCW6jzTpZzgtV
        YKkYGOJXqDU8VFyn73lxLkMDsaUYrfNDYLapw3P0Rbw6pXekNt77Pw/BIw/lIvC4MF8oK7
        e6CDrFTbliCIxBbsvpmB58SWrZqIpU0f34f0uULWg4qlrk5j64G8KFYX+lnfGQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: gpio: realtek-otto: Add rtl9310 compatible
Date:   Sat,  9 Apr 2022 21:55:50 +0200
Message-Id: <380b17f04e127351b83d7f4d7db22d4f58aebcbd.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649533972.git.sander@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "realtek,rlt9310-gpio", "realtek,otto-gpio" compatible for GPIO
nodes on the RTL931x SoC series.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
index 3c511e9af377..39fd959c45d2 100644
--- a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
@@ -29,6 +29,7 @@ properties:
           - realtek,rtl8380-gpio
           - realtek,rtl8390-gpio
           - realtek,rtl9300-gpio
+          - realtek,rtl9310-gpio
       - const: realtek,otto-gpio
 
   reg: true
-- 
2.35.1

