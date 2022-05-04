Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AFE51B0C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378628AbiEDVgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378606AbiEDVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:36:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356351E53;
        Wed,  4 May 2022 14:32:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 07CE61F44A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651699976;
        bh=l0V4udZjAuiOeK5vyxVOpBZjaG3ONdg+DU9YAvFIO7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJtXbKeArbJodxYDgd7WQSRp2+oaWVHi1plpFtoQSFVxXRZdeST2JEJ9VtxFJu4/H
         XTFptfhJsUCi+ZkUasVXK+dG/m4iLPSea5fAwjgRpgmcaxlawbD82yr5o925MYR5A1
         QKMCDaHt5ILJ1G7V5UNRALhlkkHKi5c/t/J2d1Iq51gFYP0uzbZqyqAdPDMuKo0Su9
         8qgACxjj+cXK6xdhcTaJXN1xIIuv/J9MUKOXXdrZL14qJZKPloIvHJFKI7lV9VbgTM
         cKdeDhUvg3uO7gXZ2ZXtnb4G+280nfd5AwmwOs36FBw4pZl2v45t+Ls1jg3NJeNj9n
         SJbOSw6xSceuw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 33FBB48146E; Wed,  4 May 2022 23:32:53 +0200 (CEST)
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
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 03/21] dt-binding: clock: Document rockchip,rk3588-cru bindings
Date:   Wed,  4 May 2022 23:32:33 +0200
Message-Id: <20220504213251.264819-4-sebastian.reichel@collabora.com>
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

From: Elaine Zhang <zhangqing@rock-chips.com>

Document the device tree bindings of the rockchip Rk3588 SoC
clock driver.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/clock/rockchip,rk3588-cru.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
new file mode 100644
index 000000000000..6e65ee7b0092
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3588-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip rk3588 Family Clock Control Module
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3588 clock controller generates the clock and also implements a
+  reset controller for SoC peripherals.
+  (examples: provide SCLK_UART2\PCLK_UART2 and SRST_P_UART2\SRST_S_UART2 for UART module)
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3588-cru.h headers and can be
+  used in device tree sources.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      phandle to the syscon managing the "general register files". It is used
+      for GRF muxes, if missing any muxes present in the GRF will not be
+      available.
+
+  clocks: true
+  assigned-clocks: true
+  assigned-clock-rates: true
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    cru: clock-controller@fd7c0000 {
+      compatible = "rockchip,rk3588-cru";
+      reg = <0xfd7c0000 0x5c000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.35.1

