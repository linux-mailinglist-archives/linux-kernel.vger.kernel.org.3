Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB74A7AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347888AbiBBWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:19:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57437 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347847AbiBBWTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:19:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B61F15C01B9;
        Wed,  2 Feb 2022 17:19:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 02 Feb 2022 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=3hRGNS3D1z63G2ajvlDFboK3XqiYEL
        gqUzQ/+Bh6bEY=; b=amwvW9SO2Lj9YFJ6pQOfOiOBrzM9yh5FhdxN6PEiAWw51E
        2pt0m7X4HgponL9fur2l74p2whWFdAuv/LLGB+97JWPtD7mIUs2fDXPvbWFTbMLw
        VDWhPzAhG0Uk6jwZs7p5NvOO/B2bkRoA0urLDwJRS7ZS0mAL2Ih6G7f1U+ysrIeC
        4yE5HXG9D96RKIC5+En41qvOu5SbkP++Aec0VCVHD+urAwisr+doG6oMzOB+BKxS
        slPRxRrLtchYMA/Kkw1RAS4KjaF0FuX9XV2MyphfbLNcMnlAwao7/69FLGrREJHT
        ymmZ6D36fn9S6q3biXDEt25W1lCTOhayHG1RJEcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3hRGNS
        3D1z63G2ajvlDFboK3XqiYELgqUzQ/+Bh6bEY=; b=TOTUiEbRPsIAwrjhmYbDVb
        /FSnQ8I7Dh/pK88pzq3in/MH1wk93oSXfSjoHrZfTE09/3WtkT4GqsrdBuOEUjq2
        /iq0+isY2Mx9BvNJOrMhpf6/WHxnTmQefFDG0QYQSAQMfDNbhBzGZZ5xxuxBR/f6
        OIK6Q8uMghtehkIdF4IqEBlzJYR0WUV8d5K3Dq8l267LNhRyYeEoSrz/l2UYhDo5
        9o5S19+2sn49jbyxQ8F8JHcbkvbLcPmLXtZ3Qfhl5quxPF/aKrvwkHS9fk/g60bt
        gWGlS2lxqtwZGcgGpa3y3fmYLS+Bo8MepZiK6VbBi+gvnE1fy2sKdA7LwD+DQIAA
        ==
X-ME-Sender: <xms:iAP7Yaf1L6iZUK4r_9fpJTf5uHiOm7WFFogY4eqrWXpgE8532IKXog>
    <xme:iAP7YUO-CUPoIQlmcikvmGr3a80BpDzOTzT-tDHQhydsPGzkJApYPIHbn0iOsgdG9
    CF8GO7hE1nbstjdcw>
X-ME-Received: <xmr:iAP7YbiMOsOodQXUXEkJIoYZMreAQxRzG8JhELAA1zqpdWDJU1aFEOpT4oCtlRxDv8HuhUJycG0BP0bBwd_VFYv4AcpUNYTr2WIi_CKOWJctaPb-MfEVLTRq7dtL9p3DCGdKhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeelueelgeettdfggfeuffevkefhuddtteeigfevhfdtffdtjefgteeg
    leeggedvudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:iAP7YX-m3kgLmSyUV2pWIon8k3IeeJaEAwxB3-BvCwE2vXIf7jzKeA>
    <xmx:iAP7YWvCuuv6D57_un5h2eX27kMw3htmAf61EwlFyj3NCQsQw5yCvQ>
    <xmx:iAP7YeGFu649WBIYAFp5E-6D_g5vKiRi6fzQsrCCka72Yjzdq46qow>
    <xmx:iAP7YagSMq-hb3jnHjjY1BfyvStptH4XU3wNdELTaOWjo6PZ02C2sw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 17:19:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/4] dt-bindings: usb: Add WUSB3801 Type-C Port Controller
Date:   Wed,  2 Feb 2022 16:19:45 -0600
Message-Id: <20220202221948.5690-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220202221948.5690-1-samuel@sholland.org>
References: <20220202221948.5690-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for the Will Semiconductor WUSB3801. This is a
basic non-PD Type-C port controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 .../bindings/usb/willsemi,wusb3801.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml

diff --git a/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml b/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
new file mode 100644
index 000000000000..c2b2243c7892
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/willsemi,wusb3801.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WUSB3801 Type-C port controller DT bindings
+
+description:
+  The Will Semiconductor WUSB3801 is a USB Type-C port controller which
+  supports role and plug orientation detection using the CC pins. It is
+  compatible with the USB Type-C Cable and Connector Specification v1.2.
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+properties:
+  compatible:
+    enum:
+      - willsemi,wusb3801
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      The managed USB Type-C connector. Since WUSB3801 does not support
+      Power Delivery, the node should have the "pd-disable" property.
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+    required:
+      - pd-disable
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      tcpc@60 {
+        compatible = "willsemi,wusb3801";
+        reg = <0x60>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+          vbus-supply = <&otg_switch>;
+          power-role = "dual";
+          try-power-role = "sink";
+          data-role = "dual";
+          typec-power-opmode = "default";
+          pd-disable;
+        };
+      };
+    };
-- 
2.33.1

