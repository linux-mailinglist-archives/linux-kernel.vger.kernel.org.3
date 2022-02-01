Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29544A5596
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiBADYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:24:47 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46751 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232986AbiBADYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:24:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A2635C01A4;
        Mon, 31 Jan 2022 22:24:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 31 Jan 2022 22:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=kSXvKx4i7lgqc5+wdJxkUbJCs8S5iK
        3fUBouJV8doiM=; b=TMArE/Fk9cekaDjPElDrUAcS9gpuUTKsadKE/1BGbxlmtA
        +lm+10kQt+++qgHmfXvs8pu326pHdqyhQImUgDSord4ttQbBTzWUfW+eaLU1zXVm
        xli9yIh97eX4Htyttu1OrR83HigeG2hX0BUDYqniN/S2cxl98gGxdFJC4D5RZUWL
        JaN5kFW2AM8reKkvcu7Yd0uBHgubw7fu6V/hVAvxsG4nZCNL8Cg3a98CbeQn8Zh7
        lgIApNRaI9qln0UgNpniuBQarjXnV47ngoz0tFTrqsX/OCXRYUHj3UwEivjW8G4c
        1Nnw61vRlaW7o9u4iOOMQ1127wonvgZknREQYxrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kSXvKx
        4i7lgqc5+wdJxkUbJCs8S5iK3fUBouJV8doiM=; b=JFCfqiA9ctKS1KYVEHi0zd
        bFfzGzdpuueDOnG7hc7bqWrB2oR3vWnvLeoomcYEB6TwPsjzBwILIOvbOoMYi8c7
        /9JRfOTmv+l0az25yZwXSwPXBWs38rOvyraVY6mti5d2apJPPnvYnfj83F+G8FN7
        liATwCCkxiF3IaEcJVKq/T2iT2f4D8In6DZP0S45oasFrZttmMAM92xM691QNdAz
        YqpdVmAFuO9pO9GTXRgcmD8XJwVQDGXgJ52TX3f7DDsBRPi5HLP0Oi+qmKz8I0eX
        NDWLffpP3nH7UGaAGrHNWgZDgGWu4lf09MpY2Vwt5dUqM11Vj2Zz/KCPB2Mta4ZA
        ==
X-ME-Sender: <xms:_Kf4YckiJ7Ww63mkrEDMcUKpy-bnsffoaO0BDYnCimfhCWrKCe6slw>
    <xme:_Kf4Yb2BLPLeJ9JeMVi3MsZkNaUxfeJChU4pMK5nwvI0FiTkH8nUT-qpCgCpyqPJH
    ccl_QuCcXB15QbIXw>
X-ME-Received: <xmr:_Kf4YapjH5EgEeYuOFuydJ1KGMRLkTmva4wzJRKmBvRYZhL0XZPVCwX3Zn1DPCXC4OamTsBgK9vld4tmpW00LpL-UufqnYKd19cE_0Ee9XRci0aTQNrwVVt2fXKHfrjBNvT2RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgedvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuleegtedtgffgueffveekhfdutdetiefgvefhtdfftdejgfetgeel
    geegvddunecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_Kf4YYmXg4_4dbKqTktgUDYAiwCqXbakj6KO_6Brh55Nxla_fJm_6A>
    <xmx:_Kf4Ya1fvBEV73GXbczhIcNI-f47jRVcJJt2qRcFmAw1MYFN3fvrmw>
    <xmx:_Kf4YfvGjIX_3lSx_c2k9VGMHBphvZDQIPMq7fTavo4vbtGNz-EfXw>
    <xmx:_Kf4YUrMthtQxE0CNwY6t6oUIwQRY2LEYZK0GSil4I4qpLQP_6gqHQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jan 2022 22:24:43 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/4] dt-bindings: usb: Add WUSB3801 Type-C Port Controller
Date:   Mon, 31 Jan 2022 21:24:38 -0600
Message-Id: <20220201032440.5196-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201032440.5196-1-samuel@sholland.org>
References: <20220201032440.5196-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for the Will Semiconductor WUSB3801. This is a
basic non-PD Type-C port controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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

