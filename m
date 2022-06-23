Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873C557F84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiFWQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiFWQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:14:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9C27FD2;
        Thu, 23 Jun 2022 09:14:08 -0700 (PDT)
Received: from jupiter.universe (unknown [95.33.159.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 233F566017F0;
        Thu, 23 Jun 2022 17:14:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656000847;
        bh=BoLK/IAno35nYnryxQn1707X7my90AtpDBFfONbrkTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DwYumIE1rkTohKeo4V6pXnsPSy6ah7Bn0V0bRvltGpoeY0qQK4nYrWjC5DQCm2Sij
         TnXX9N0RWLlniAX3svPiST6r2CmqisSywceQfW7WPOoTYrRdwBayUBUq+z1sTifWyn
         bmVa+ubGxzrDPc1NGEdIxBqjNzU2HvsE3LaqWR9y3GAeLAmVfOOcAYGqTVfQBncGgv
         1VdsD1kw2SsA5cfHpHhMZdvMlgqVwHUsPrb5rikQCH1I73ARd0Z3whCBTltMuZDDif
         G+CZ15MwCBemTJYmV9GdNcCaT98VFhUnINOw/9mNVR0CozK/bvlPtZJhYZHYrZKeyl
         RmFxjpkJtS8mg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A8F12480122; Thu, 23 Jun 2022 18:14:04 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-serial@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/1] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3588
Date:   Thu, 23 Jun 2022 18:13:50 +0200
Message-Id: <20220623161350.242079-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Rockchip RK3588 compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Note: This used to be part of a bigger series. I'm now sending things
      per subsystem. Existing serial driver is compatible with RK3588,
      so this just adds a DT compatible value in case a SoC specific
      bug needing a quirk is uncovered at a later point.
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 12137fe80acf..b5c819c5fa2c 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -33,6 +33,7 @@ properties:
               - rockchip,rk3368-uart
               - rockchip,rk3399-uart
               - rockchip,rk3568-uart
+              - rockchip,rk3588-uart
               - rockchip,rv1108-uart
           - const: snps,dw-apb-uart
       - items:
-- 
2.35.1

