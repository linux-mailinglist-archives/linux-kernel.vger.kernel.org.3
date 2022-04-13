Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464C05001C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiDMWWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiDMWVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:21:50 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DB1571D;
        Wed, 13 Apr 2022 15:19:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 928445C029A;
        Wed, 13 Apr 2022 18:19:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Apr 2022 18:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649888366; x=1649974766; bh=DL
        jgBEQ1+1vq/nXxADtpNaSm7RE9fz3MOj06zwzz+gk=; b=tGxVfhfS18dInH3xbp
        5sviT7voXBlvIfsRKOFqahGWxhmQ0I45KaxXfmZrHrvHAI05e1mxWLpAcwrTVpE9
        l3a2QvebuXT9NEDuEezPLQ0nB722xgb3y6501RJVOo69DNmP+9Dg1wGY1oDbnRBZ
        zMn6SHaJT4E5Pwvjqixxh2K80zMdS/3Z2etec2NBayR/DE/AEbZFBI1Ao+u5fP4w
        OBrC0QKxFuerB3CDqoNN6A4srQ9s3g4mCvmgDhm6/yXANvKt0ZRc4U2CrgWi1FQN
        u40mCxuovnafzAF0kapGjr/WOtXT775Rk3z7LsVDMCUAVkLAgkYLmKvoKATXJ2WN
        J3zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649888366; x=1649974766; bh=DLjgBEQ1+1vq/nXxADtpNaSm7RE9fz3MOj0
        6zwzz+gk=; b=eURCH2ejrVMvU8WXiCnab0H5zIEDr6JEIyVuXiSKv3CudCl48P6
        0LwWY57vou4hK7qbUaxAk4P31aGRd8p0CgKQg1QHgk/wHBFIasUqKwLNJVREf4uy
        0YYkediuIGp29mM79xkN6LbUMANoKLMeAvdeTI/S5IKxhDQjo3XXhnyMGpblWpwS
        Q8JRniJQn0OzYPhuxUX5zpT0dtnE+8aehBaypiJns0b+coPG2yPqEvXQlp8437W/
        vaAJAP2z49t4RFJg8Hvx2QaN9F9pBx5PdLQ5GY2dFr2wxwm1Gmf9peRg70tWviNo
        N0MkLfh9OLevW1TeGUAyQZhc9iq4W9HFgLA==
X-ME-Sender: <xms:bkxXYvc_gAHJKat4FMaoHz7qVPTSj6E3yXq1ABgighFcSYNoj8BgMQ>
    <xme:bkxXYlNCvU511UW8JQqhqpxJBqQ5t83JQqLpBtM96VCWhsrknRn7xaGKIoI7lDhmS
    uduXr9purq56CUYnA>
X-ME-Received: <xmr:bkxXYognEKYQAGXN942R7VtmUuRJWYHgoyDThqL0TzCYzdLh_weIDeMcb94wYRQTHpgYAnMxywao8ZCzHKii8F4tm37K7RYW8b2rteCNZkz-s3RI26KXSBMDXhbKbXfcdmJSoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeelueelgeettdfggfeuffevkefhuddtteeigfevhfdtffdtjefgteeg
    leeggedvudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:bkxXYg9xqN6_BuvO1Am-faxh7r-7UcMd9zJPebU-esVS0ZabuEj-nw>
    <xmx:bkxXYrthY5td_qXNpJ4L6ecrenxLGs1vCmE725IV6kLyT0dKGaAgTA>
    <xmx:bkxXYvE6aTYH850TctEpf2-ikCMTl__sp8a58JQIqjweKkBq-sXKOA>
    <xmx:bkxXYsvXKGDpmiCCd91N0aQRyvHkhWjD0T_vPAFHx5PjBgUDHnsRoQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 18:19:25 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <x@xff.cz>,
        Andreas Kemnade <andreas@kemnade.info>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/16] dt-bindings: display: rockchip: Add EBC binding
Date:   Wed, 13 Apr 2022 17:19:02 -0500
Message-Id: <20220413221916.50995-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413221916.50995-1-samuel@sholland.org>
References: <20220413221916.50995-1-samuel@sholland.org>
MIME-Version: 1.0
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

The Rockchip E-Book Controller (EBC) is a controller for Electrophoretic
Displays (EPDs). It is self-contained; it does not interact directly
with the VOP or the RGA.

While two of the regulator consumers here actually power the display
panel, not the EBC hardware, they are consumed here because they are
only needed during display refreshes. They do not match the normal
panel prepare/enable lifecycle.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../display/rockchip/rockchip,rk3568-ebc.yaml | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3568-ebc.yaml

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3568-ebc.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3568-ebc.yaml
new file mode 100644
index 000000000000..957ca874ab02
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3568-ebc.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3568-ebc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC E-Book Controller (EBC)
+
+description:
+  Rockchip EBC is a controller for Electrophoretic Displays (EPDs).
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-ebc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHB register clock
+      - description: Pixel clock
+
+  clock-names:
+    items:
+      - const: hclk
+      - const: dclk
+
+  resets:
+    items:
+      - description: hclk domain reset
+      - description: dclk domain reset
+
+  reset-names:
+    items:
+      - const: hclk
+      - const: dclk
+
+  io-channels:
+    maxItems: 1
+    description: I/O channel for panel temperature measurement
+
+  panel-supply:
+    description: Regulator supplying the panel's logic voltage
+
+  power-domains:
+    maxItems: 1
+
+  vcom-supply:
+    description: Regulator supplying the panel's compensation voltage
+
+  vdrive-supply:
+    description: Regulator supplying the panel's gate and source drivers
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: OF graph port for the attached display panel
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - panel-supply
+  - vcom-supply
+  - vdrive-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/rk3568-power.h>
+
+    ebc: ebc@fdec0000 {
+      compatible = "rockchip,rk3568-ebc";
+      reg = <0x0 0xfdec0000 0x0 0x5000>;
+      interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru HCLK_EBC>, <&cru DCLK_EBC>;
+      clock-names = "hclk", "dclk";
+      resets = <&cru SRST_H_EBC>, <&cru SRST_D_EBC>;
+      reset-names = "hclk", "dclk";
+      power-domains = <&power RK3568_PD_RGA>;
+
+      panel-supply = <&v3p3>;
+      vcom-supply = <&vcom>;
+      vdrive-supply = <&vdrive>;
+
+      port {
+        ebc_out_panel: endpoint {
+          remote-endpoint = <&panel_in_ebc>;
+        };
+      };
+    };
-- 
2.35.1

