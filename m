Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC746DB9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhLHS6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbhLHS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:58:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676AC0617A1;
        Wed,  8 Dec 2021 10:55:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so11682031edd.3;
        Wed, 08 Dec 2021 10:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k87N5jZmnUdGHFqhTtJn+9rczDSFekNyBn4AmfAku7w=;
        b=fOb+9WGDxrX2K9K/D2COkmgfnILbCc3uvU1qW4UA5EgzNuDFSitSIdWWv5W5tpvUsR
         Mun8aPk75JSSGJzSy9AXHP14/Ejs3LWHuZ6QEPiy+Oli4U2W9g25EiG8Qf3nvyPM0i8D
         1THpAnsQ7r/V0ajttgmVk0meSEBHN/v/qaiNEzCsOdlI9B0BzkR1lkxCricpq2xnuwBo
         IOEIOhOo5xWbCLOzrYp13pWjv1itfUXa+8OYxDO3khIqm/wze5j6G73GndbsUs+Xryrg
         ju0bGHF1lxjVhgzmOHLi/Rp1XRZ15I/zk+wbDcdklmTva/ECgRZ2Qu9N3yFO5aNLE7/0
         AqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k87N5jZmnUdGHFqhTtJn+9rczDSFekNyBn4AmfAku7w=;
        b=HrCcVOISlO1cLZxhCZyOokduWgUSQ2zGsy8dCJaFohH/YriKbTRJaMbfUzpDAsDjYc
         I6inRWJOtpYP8DLf7xkTsGRhFMbjTToVVokuSGUXUZ9vtRSmM4H2yPww76f2ZTKDm7N1
         nbHBekHWT+A497L6xqT07/IuAmCSYrM8QJYyhidBp66s2ypuROAUXAWsM3Cu5CtUH/Xb
         BGw3O28kBQ8XhNLqEdk8foiafP6wkSCq/FicUiuATDgGD0Bb+zvdJ298C3Aa0U1Hd0w0
         iQpVYoolVpA5yYOze8f2w4VRlYjg/AX3Vry9wiRexXGpWOjsBoPtk/UVXTLrAX2McXbk
         NGAQ==
X-Gm-Message-State: AOAM5325+AvNef/U97g3FAj2o8YuW7bh71bK3cV2X/EoKkamdVS/QFxG
        djdXoXuLDCjoR3lb5bpd4/B+bzH5RtibrQ==
X-Google-Smtp-Source: ABdhPJywhDKnSGvpvkUtgBnA8V3Fjc0CiLG17JO3J+ADuwQTZBnGP6NqULAxiP70cSfJ+fQP7AeYpA==
X-Received: by 2002:a17:907:7b99:: with SMTP id ne25mr9626193ejc.15.1638989702598;
        Wed, 08 Dec 2021 10:55:02 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g18sm1862273ejt.36.2021.12.08.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:55:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Wed,  8 Dec 2021 19:54:47 +0100
Message-Id: <20211208185449.16763-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211208185449.16763-1-jbx6244@gmail.com>
References: <20211208185449.16763-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Zhao <yifeng.zhao@rock-chips.com>

Add the compatible strings for the Naneng combo PHY found on rockchip SoC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  restyle
  remove some minItems
  add more properties
  remove reset-names
  move #phy-cells
  add rockchip,rk3568-pipe-grf
  add rockchip,rk3568-pipe-phy-grf
---
 .../phy/phy-rockchip-naneng-combphy.yaml      | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
new file mode 100644
index 000000000..d309e2008
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-combphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC Naneng Combo Phy Device Tree Bindings
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-naneng-combphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: reference clock
+      - description: apb clock
+      - description: pipe clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: apb
+      - const: pipe
+
+  resets:
+    items:
+      - description: exclusive apb reset line
+      - description: exclusive PHY reset line
+
+  rockchip,dis-u3otg0-port:
+    type: boolean
+    description:
+      Disable the u3otg0 port.
+
+  rockchip,dis-u3otg1-port:
+    type: boolean
+    description:
+      Disable the u3otg1 port.
+
+  rockchip,enable-ssc:
+    type: boolean
+    description:
+      In U3 and SATA mode the SSC option is already disabled by default.
+      In PCIE mode the option SSC can be enabled.
+      If Spread Spectrum Clocking (SSC) is used it is
+      required that a common reference clock is used by the link partners.
+      Most commercially available platforms with PCIe backplanes use
+      SSC to reduce EMI.
+
+  rockchip,ext-refclk:
+    type: boolean
+    description:
+      Many PCIe connections, especially backplane connections,
+      require a synchronous reference clock between the two link partners.
+      To achieve this a common clock source, referred to as REFCLK in
+      the PCI Express Card Electromechanical Specification,
+      should be used by both ends of the PCIe link.
+      The PCIe PHY provides 100MHz differential clock output
+      (optional with SSC) in RC mode for system applications.
+
+  rockchip,pipe-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional phy settings are accessed through GRF regs.
+
+  rockchip,pipe-phy-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional pipe settings are accessed through GRF regs.
+
+  rockchip,sgmii-mac-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      Select gmac0 or gmac1 to be used as SGMII controller.
+
+  "#phy-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - rockchip,pipe-grf
+  - rockchip,pipe-phy-grf
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+
+    pipegrf: syscon@fdc50000 {
+      compatible = "rockchip,rk3568-pipe-grf", "syscon";
+      reg = <0xfdc50000 0x1000>;
+    };
+
+    pipe_phy_grf0: syscon@fdc70000 {
+      compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+      reg = <0xfdc70000 0x1000>;
+    };
+
+    combphy0: phy@fe820000 {
+      compatible = "rockchip,rk3568-naneng-combphy";
+      reg = <0xfe820000 0x100>;
+      clocks = <&pmucru CLK_PCIEPHY0_REF>,
+               <&cru PCLK_PIPEPHY0>,
+               <&cru PCLK_PIPE>;
+      clock-names = "ref", "apb", "pipe";
+      assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
+      assigned-clock-rates = <100000000>;
+      resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
+      rockchip,pipe-grf = <&pipegrf>;
+      rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
+      #phy-cells = <1>;
+    };
-- 
2.20.1

