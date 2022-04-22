Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9AA50BE44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349374AbiDVRNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244201AbiDVRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1991375;
        Fri, 22 Apr 2022 10:09:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 761211F468F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647378;
        bh=/EX7uRXZrG1QFAgVbH2hTSvKXYhKFV2tAu7po7GteZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfRiS+5Dyjj9SlMnErSK06CqZBRQX5Eiiv+HLUFIVG1gFGzCY6P92wBK0MhdV6DuR
         pMTpNBOyqWt35uX2snhg9QeUbYdU5hgOfjHo4eHT7cY+LNbAtY04/9PJ6sSN26/lEB
         ncRknsoDxJozJnlW/8+lfkK/OyLrI+sokRmiy96V6flg3IVJbmxKOu69IFyvyWWwdU
         zlRDl+KrzBV4A7Ap4ER8bfHwQ2jSKCipjBjE//zBPreCDPPqTQ4ll/0yv9MM3/0ctt
         o6YrHQTAnnLRyGVoJIUjPJYIWXOTEEiRgfxpfgTvjTOFojCFUWCZaknO8zz9lF0jUN
         lHGmr3dxWi1JA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id DB906480828; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
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
Subject: [PATCHv1 11/19] dt-bindings: pinctrl: rockchip: add rk3588
Date:   Fri, 22 Apr 2022 19:09:12 +0200
Message-Id: <20220422170920.401914-12-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for rk3588 pin controller. No other changes
are required, since the new controller can use the old binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index b0eae3a67ab1..e62fb5e9db76 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -44,6 +44,7 @@ properties:
       - rockchip,rk3368-pinctrl
       - rockchip,rk3399-pinctrl
       - rockchip,rk3568-pinctrl
+      - rockchip,rk3588-pinctrl
       - rockchip,rv1108-pinctrl
 
   rockchip,grf:
-- 
2.35.1

