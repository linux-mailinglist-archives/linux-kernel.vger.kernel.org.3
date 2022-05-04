Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC051B138
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378752AbiEDVm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242652AbiEDVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:42:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF382F00B;
        Wed,  4 May 2022 14:38:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 65DE81F44BD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651700325;
        bh=OdKlO5+vwaD7DgJFiCMIAHa9XgAnLHYYCe2QdHgE3yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH0LMQ9Xrpk+5N5JzxohQqlQuXcUwkIvYgLV26XFHU46Qvv7KOPORH8DGFqVtbiHG
         w/R1lXM0eBTDxctNAM3PnO1vrFB/V7+pSZld57tejyl50JIereMHZffwtQd3GGJuzI
         HaY/ALgj91Kx8dw6eXKzZT8Ips3M6JpvNxX+6rGGS/KAXjLDdz5A7FbEg2CZnzt2qj
         5Soi8jo7PMgc28b73lIfgZP4QDTWv9S9kNRovecW8B/X9e0nF4hlppez06ZUO0tfUE
         PdTw93e+vhWnul8ti26orJyoTVn7PnDCGH8y37ugriKtJ18Dvs6GIyMAU46LGeZeL/
         a6Nr/EIT8SQzQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 557C94819D5; Wed,  4 May 2022 23:32:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 16/21] dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
Date:   Wed,  4 May 2022 23:32:46 +0200
Message-Id: <20220504213251.264819-17-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504213251.264819-1-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IOC and PHP GRF syscon compatibles for RK3588.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index b2ba7bed89b2..2181c8031b0d 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,6 +16,8 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rk3568-usb2phy-grf
+              - rockchip,rk3588-ioc
+              - rockchip,rk3588-php-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.35.1

