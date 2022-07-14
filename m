Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44039575776
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiGNWMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiGNWM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:12:27 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6AD70E75
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:12:27 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LkTHt3DDCz9sQt;
        Thu, 14 Jul 2022 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657836746; bh=nN8OVxxrhkv2QzlJp1RLZitf9bmBRAzLYPYKcObmvks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPBWn8/fCH53e16UY/EheNrXpt2jfK2VtMv48QLI76GA5g62sANdiEfYp5CBMpBXi
         lYLT3o6msUFK1pqZ8IMZQaQZg/bGfVJpTWIOdGlOjxHsljvTXZEaD2/gQyW4dbtqBh
         b6af3134iyb1twX9I7r1TR7PWFM1MIL1/SrPpmAI=
X-Riseup-User-ID: 52F8D95B0879F3E12E6299DA0CB9927E43DA238409F402D037997E981A91189D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LkTHp3lGJz1yWZ;
        Thu, 14 Jul 2022 22:12:22 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        andrzej.hajda@intel.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH RESEND 2/2] dt-bindings: media: s5c73m3: Fix reset-gpio descriptor
Date:   Thu, 14 Jul 2022 19:12:02 -0300
Message-Id: <20220714221202.86768-3-mairacanal@riseup.net>
In-Reply-To: <20220714221202.86768-1-mairacanal@riseup.net>
References: <20220714221202.86768-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maíra Canal <maira.canal@usp.br>

The reset-gpios is described as xshutdown-gpios on the required
properties, as it is on the driver. Despite that, the device tree
example set the property 'reset-gpios' instead of the property
'xshutdown-gpios'.

Therefore, this patch updates the example to match the property specified
on the driver.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 Documentation/devicetree/bindings/media/samsung-s5c73m3.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt b/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt
index 21f31fdf5543..f0ea9adad442 100644
--- a/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt
+++ b/Documentation/devicetree/bindings/media/samsung-s5c73m3.txt
@@ -76,7 +76,7 @@ i2c@138a000000 {
 		clock-frequency = <24000000>;
 		clocks = <&clk 0>;
 		clock-names = "cis_extclk";
-		reset-gpios = <&gpf1 3 1>;
+		xshutdown-gpios = <&gpf1 3 1>;
 		standby-gpios = <&gpm0 1 1>;
 		port {
 			s5c73m3_ep: endpoint {
-- 
2.36.1

