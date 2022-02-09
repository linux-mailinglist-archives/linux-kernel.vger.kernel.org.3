Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F94AEFE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiBILXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiBILXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:23:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3285E126CB2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:17:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h6so3104248wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfAV7F+Ro4DbSdjhHkusaJBb3PiMNKM76wOprs+NcNM=;
        b=ny9ULsL/xMEXFfNXPt20i+xiJxpkX2dV9SayL9TBFHnQZRFvyPp0T00z/YJrWXCNrL
         B0x8FxZfCdLVm3CW4kS/+7tgqqUiYKSPATkRb6BF9/tnoNqwZv/b11y/6rIZgRXHpArU
         5ZrEiJM4nHjULj3695Qcc3hqXjmarVseMpa3GxX8WqLmB15DbGwufz+iUoU/ghEJguzj
         cDquRy5IkmwC/jRm7sFTgzlmYvH8aZgZCKq5YnuHF+UFWVn4BrRSvA0mziIkSLydOE98
         sZ68twH4yfcSEuLLynk+EdDdPxZhn45IYbtbIpmC1lWwSRqQk7Bx4jLyBW1ImXROWCFw
         mW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfAV7F+Ro4DbSdjhHkusaJBb3PiMNKM76wOprs+NcNM=;
        b=yqussP0Otlfe64xTAXEcmliaLGco54dm8dmDs2xkmjHnoPUNnKfRwHVCls+JDnt5J/
         izP2tP5u8q2klKlLUnOz62wodUK02qnaa1AH9GQzB2LoW+QuOg0CSYPL6o8IfrMSW5tf
         RGVc7EP1X6lA4+Di/1oCr1h574vX2ZUwj5FnXJzyinp8bbtza70pOxseMGgnSmJ9mi0/
         bVwcBBcZXk2H/yxDXM4KobdCHvTlksVgtq9zkCh7LazNheF+/NPK4O/00/qcJ4ABgnl3
         BytjPOJH5U/kt5SK4+s4Y2xgxpYF917EgwIsZ9ZmkFjvvCKhvfxibfIujtaWjOJwsPXt
         QppA==
X-Gm-Message-State: AOAM531qLdq7TPCDXDQbnWoYWArpSSFPwuaWs4AMa0TuIEb2XvYqliVL
        IUpoFjYO/hac5EY0Hfah9N1pwQ==
X-Google-Smtp-Source: ABdhPJy0UdpjCxyiilvCKFqjSjmlR/q7Psi0zrmsidgeyfsV9G3fsYdDsqE4HZdrlSWv1cvyhkKIIg==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr1504960wrq.214.1644401848828;
        Wed, 09 Feb 2022 02:17:28 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e13sm17740929wrq.35.2022.02.09.02.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:17:28 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: crypto: rockchip: fix a typo on crypto-controller
Date:   Wed,  9 Feb 2022 10:17:21 +0000
Message-Id: <20220209101721.1659574-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto-controller had a typo, fix it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
index 5e2ba385b8c9..53e39d5f94e7 100644
--- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
+++ b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Examples:
 
-	crypto: cypto-controller@ff8a0000 {
+	crypto: crypto-controller@ff8a0000 {
 		compatible = "rockchip,rk3288-crypto";
 		reg = <0xff8a0000 0x4000>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

