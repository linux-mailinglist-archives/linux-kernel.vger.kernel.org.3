Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D885138D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiD1Prd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349592AbiD1Pr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:47:27 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61982B82F2;
        Thu, 28 Apr 2022 08:44:11 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e5ca5c580fso5536159fac.3;
        Thu, 28 Apr 2022 08:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwCwYc4ckCxu8mDqmFguT+lhKluqb8PfJ2Uo9F5pino=;
        b=dvg55Ql2skqj1SSD2I6kGPu0Dzoj4NMhwUhnnRCiQl4U2C+qd/DRQPkIYY0mO22M7d
         xBTwIRMhsw5y4C9OYn55uQ52lQOYkw4X2rLDU8fWbAuoPSoYu5K69oKLNZNmTkrCtc5+
         pnEx2xKtHZ4jYncKB/DLOEW35u24d0vqt8Oi4sq7lBHp+nC1juR8+yo3A3zTE4QKujO2
         Mxh9FBMTXnE3pyO3Azm1y+ofLT6NXIjbbCsktA1uuFy2BsAeJyqcjwo0hUyTcBHIn/9a
         2bYl6fUDuuWjIX5MXYFpGFx7QP1ct4CvF7km+dnAiPK28qv9Lp8l8TTslROYezxhIKIG
         HXCA==
X-Gm-Message-State: AOAM533/4hsvizGQb83F5rk3+Yp+CJZdJ5jV5Nlf+8XK0ZpyRe1b5Mva
        lPwqW2f4bp34mC+ItRGnlg==
X-Google-Smtp-Source: ABdhPJwepommCnZTXxy0BvEVzrPiX7f3QmUxRQIOZ/bp0vfaVcNmO+ahgvQsmWp/QA0nF78K2iWQyA==
X-Received: by 2002:a05:6870:b6a3:b0:e9:1f2c:1582 with SMTP id cy35-20020a056870b6a300b000e91f2c1582mr10752632oab.87.1651160650508;
        Thu, 28 Apr 2022 08:44:10 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id h59-20020a9d2f41000000b005e6bbde77a8sm92298otb.76.2022.04.28.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:44:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Replace common binding with link to schema
Date:   Thu, 28 Apr 2022 10:41:54 -0500
Message-Id: <20220428154154.2284317-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The contents of the clock binding have been moved to the clock binding
schema in the dtschema repository. The desire is for common bindings to
be hosted in the dtschema repository.

Replace the contents with a link to the clock binding schema as there
are still many references to clock-bindings.txt in the tree. This will
prevent additions without a schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Most of the clock binding doc was already moved. 2 more sections are
pending:

https://lore.kernel.org/all/20220428152633.2261979-1-robh@kernel.org/
https://lore.kernel.org/all/20220428152719.2263164-1-robh@kernel.org/
---
 .../bindings/clock/clock-bindings.txt         | 188 +-----------------
 1 file changed, 2 insertions(+), 186 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index f2ea53832ac6..6fe541368889 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -1,186 +1,2 @@
-This binding is a work-in-progress, and are based on some experimental
-work by benh[1].
-
-Sources of clock signal can be represented by any node in the device
-tree.  Those nodes are designated as clock providers.  Clock consumer
-nodes use a phandle and clock specifier pair to connect clock provider
-outputs to clock inputs.  Similar to the gpio specifiers, a clock
-specifier is an array of zero, one or more cells identifying the clock
-output on a device.  The length of a clock specifier is defined by the
-value of a #clock-cells property in the clock provider node.
-
-[1] https://patchwork.ozlabs.org/patch/31551/
-
-==Clock providers==
-
-Required properties:
-#clock-cells:	   Number of cells in a clock specifier; Typically 0 for nodes
-		   with a single clock output and 1 for nodes with multiple
-		   clock outputs.
-
-Optional properties:
-clock-output-names: Recommended to be a list of strings of clock output signal
-		    names indexed by the first cell in the clock specifier.
-		    However, the meaning of clock-output-names is domain
-		    specific to the clock provider, and is only provided to
-		    encourage using the same meaning for the majority of clock
-		    providers.  This format may not work for clock providers
-		    using a complex clock specifier format.  In those cases it
-		    is recommended to omit this property and create a binding
-		    specific names property.
-
-		    Clock consumer nodes must never directly reference
-		    the provider's clock-output-names property.
-
-For example:
-
-    oscillator {
-        #clock-cells = <1>;
-        clock-output-names = "ckil", "ckih";
-    };
-
-- this node defines a device with two clock outputs, the first named
-  "ckil" and the second named "ckih".  Consumer nodes always reference
-  clocks by index. The names should reflect the clock output signal
-  names for the device.
-
-clock-indices:	   If the identifying number for the clocks in the node
-		   is not linear from zero, then this allows the mapping of
-		   identifiers into the clock-output-names array.
-
-For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:
-
-	oscillator {
-		compatible = "myclocktype";
-		#clock-cells = <1>;
-		clock-indices = <1>, <3>;
-		clock-output-names = "clka", "clkb";
-	}
-
-	This ensures we do not have any empty strings in clock-output-names
-
-
-==Clock consumers==
-
-Required properties:
-clocks:		List of phandle and clock specifier pairs, one pair
-		for each clock input to the device.  Note: if the
-		clock provider specifies '0' for #clock-cells, then
-		only the phandle portion of the pair will appear.
-
-Optional properties:
-clock-names:	List of clock input name strings sorted in the same
-		order as the clocks property.  Consumers drivers
-		will use clock-names to match clock input names
-		with clocks specifiers.
-clock-ranges:	Empty property indicating that child nodes can inherit named
-		clocks from this node. Useful for bus nodes to provide a
-		clock to their children.
-
-For example:
-
-    device {
-        clocks = <&osc 1>, <&ref 0>;
-        clock-names = "baud", "register";
-    };
-
-
-This represents a device with two clock inputs, named "baud" and "register".
-The baud clock is connected to output 1 of the &osc device, and the register
-clock is connected to output 0 of the &ref.
-
-==Example==
-
-    /* external oscillator */
-    osc: oscillator {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency  = <32678>;
-        clock-output-names = "osc";
-    };
-
-    /* phase-locked-loop device, generates a higher frequency clock
-     * from the external oscillator reference */
-    pll: pll@4c000 {
-        compatible = "vendor,some-pll-interface"
-        #clock-cells = <1>;
-        clocks = <&osc 0>;
-        clock-names = "ref";
-        reg = <0x4c000 0x1000>;
-        clock-output-names = "pll", "pll-switched";
-    };
-
-    /* UART, using the low frequency oscillator for the baud clock,
-     * and the high frequency switched PLL output for register
-     * clocking */
-    uart@a000 {
-        compatible = "fsl,imx-uart";
-        reg = <0xa000 0x1000>;
-        interrupts = <33>;
-        clocks = <&osc 0>, <&pll 1>;
-        clock-names = "baud", "register";
-    };
-
-This DT fragment defines three devices: an external oscillator to provide a
-low-frequency reference clock, a PLL device to generate a higher frequency
-clock signal, and a UART.
-
-* The oscillator is fixed-frequency, and provides one clock output, named "osc".
-* The PLL is both a clock provider and a clock consumer. It uses the clock
-  signal generated by the external oscillator, and provides two output signals
-  ("pll" and "pll-switched").
-* The UART has its baud clock connected the external oscillator and its
-  register clock connected to the PLL clock (the "pll-switched" signal)
-
-==Assigned clock parents and rates==
-
-Some platforms may require initial configuration of default parent clocks
-and clock frequencies. Such a configuration can be specified in a device tree
-node through assigned-clocks, assigned-clock-parents and assigned-clock-rates
-properties. The assigned-clock-parents property should contain a list of parent
-clocks in the form of a phandle and clock specifier pair and the
-assigned-clock-rates property should contain a list of frequencies in Hz. Both
-these properties should correspond to the clocks listed in the assigned-clocks
-property.
-
-To skip setting parent or rate of a clock its corresponding entry should be
-set to 0, or can be omitted if it is not followed by any non-zero entry.
-
-    uart@a000 {
-        compatible = "fsl,imx-uart";
-        reg = <0xa000 0x1000>;
-        ...
-        clocks = <&osc 0>, <&pll 1>;
-        clock-names = "baud", "register";
-
-        assigned-clocks = <&clkcon 0>, <&pll 2>;
-        assigned-clock-parents = <&pll 2>;
-        assigned-clock-rates = <0>, <460800>;
-    };
-
-In this example the <&pll 2> clock is set as parent of clock <&clkcon 0> and
-the <&pll 2> clock is assigned a frequency value of 460800 Hz.
-
-Configuring a clock's parent and rate through the device node that consumes
-the clock can be done only for clocks that have a single user. Specifying
-conflicting parent or rate configuration in multiple consumer nodes for
-a shared clock is forbidden.
-
-Configuration of common clocks, which affect multiple consumer devices can
-be similarly specified in the clock provider node.
-
-==Protected clocks==
-
-Some platforms or firmwares may not fully expose all the clocks to the OS, such
-as in situations where those clks are used by drivers running in ARM secure
-execution levels. Such a configuration can be specified in device tree with the
-protected-clocks property in the form of a clock specifier list. This property should
-only be specified in the node that is providing the clocks being protected:
-
-   clock-controller@a000f000 {
-        compatible = "vendor,clk95;
-        reg = <0xa000f000 0x1000>
-        #clocks-cells = <1>;
-        ...
-        protected-clocks = <UART3_CLK>, <SPI5_CLK>;
-   };
+This file has moved to the clock binding schema:
+https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/clock/clock.yaml
-- 
2.34.1

