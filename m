Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2E4B4110
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiBNFBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:01:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiBNFBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:01:34 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83DB1928A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:01:26 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9A4313200D18;
        Mon, 14 Feb 2022 00:01:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 00:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=N7CnZt7oQOTzeliuU4eCrxvS5b8SqG
        uKh8IM26cZztc=; b=YitHkN7OqwKeYSq7kXWoiXePBTpUcxD2HQUUxThzlWn7p+
        iSVcrAaOFLpWMb7pILHGDqMmeErxw6Pfh1BzxnkS/u+3m9wQ7HGAVjU7Qi0KtM7s
        n+KwYCLo5vhbn9alsquxGtm6Q5R8Om9thPcweJr378ImIEEh9hWWBrvG84+nDlE0
        yhaUxyL8kRlC6eZl47PFJKkyPHpYM1/FvMzwBe95deMIxpyJwYOZ8yuAma90WNS6
        ZOMUZOjCBDNUye/PM6701m34atV/PgdYMXEIBnCckSDtOQyBzEeH1TDSKM1SF4Hk
        RVObUEHE5/9I65VhH+VuFEP/KilfRqAllBWtOnWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=N7CnZt
        7oQOTzeliuU4eCrxvS5b8SqGuKh8IM26cZztc=; b=BJj9PHmYngolB9Y0lEOvJ9
        AlAzw42r7gEt2ZwrQTAWN0l1pbF22kHWzC8tKNSI/sMVWgTHLa8jSGLOptPT+aWc
        jG4/4XdrhMUPTs/LZeMAgiF4bDhwsaoYEKyDbMMHZ2yWNetpR1iBZTld2mFqIBxl
        opoHGSQq/IzB6NZkGm51SdwxAdlS6HuW4E7tbocNLkveI+qt5aI6ETpUZ+z58rxx
        dU/40vMWJBKOuhF43W5dpDIcD9CQ8FauAKRUkzxD6Kfv1Gkl8T2TDjbgPDBDqma+
        AkxebVnPMsb5il87xz99SfMkGi+B/aVqMjvgezRMFK3eqwEK2TRuhOgDxfUgTgBw
        ==
X-ME-Sender: <xms:JeIJYpICnhVMMFxc_ZU8D2JeAaybDvIc2ifR_ZPzWi5FNBAqELZZdg>
    <xme:JeIJYlJgJG0fl_kgPElQfJYyfruMN9NQUArEVLefghkPWAoiyBgKR1h4Oc9DS3ysh
    QC5NS5WSZPakBhL_w>
X-ME-Received: <xmr:JeIJYhsH_wVb4V18RmhExWyLeRQvg1wnM6JNCuzsuqTUUtGAnU9ksY4BjKGsX1hVPcsXzEm5xHVEdyRPdOlJQR0MPp_6NeGTWMWBee1ylTKFu7fcLr4_Oe0cozJAP5qrrF4xzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuleegtedtgffgueffveekhfdutdetiefgvefhtdfftdejgfetgeel
    geegvddunecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:JeIJYqa0v-nRVLfuUCu9MpK-8QfEAbZZHzjqac_YhIqL2iroFgJgRg>
    <xmx:JeIJYgbTOHxzf_x0TvgHYwXQYviwk9dzotePxpFKsE9GPKUJcGn6nw>
    <xmx:JeIJYuDZNzCdHTDUI8-fdKOaQcwC5eDuYz4d8CVjtzyVhugZIE5TlA>
    <xmx:JeIJYvzkX04F4cg5RAxNqCHQmMNnI3wQSQkP9NjXAW9g2Y_bywEXow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 00:01:24 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: usb: Add WUSB3801 Type-C Port Controller
Date:   Sun, 13 Feb 2022 23:01:15 -0600
Message-Id: <20220214050118.61015-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220214050118.61015-1-samuel@sholland.org>
References: <20220214050118.61015-1-samuel@sholland.org>
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

Add devicetree support for the Will Semiconductor WUSB3801. This is a
basic non-PD Type-C port controller.

Reviewed-by: Rob Herring <robh@kernel.org>
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

