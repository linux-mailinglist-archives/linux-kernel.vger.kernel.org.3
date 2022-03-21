Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D74E2E89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbiCUQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351441AbiCUQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:27 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63B174BA0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 22F833200EAD;
        Mon, 21 Mar 2022 12:52:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 21 Mar 2022 12:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=/pY3yz47Nuid96
        s8eNEwkYTyhd2x8Impr+YNOi7OK8g=; b=ESpAxG2myY5Dbc+afq6j+05WbyAt+0
        MrZ6+THFre7I2tBMBV3Nvgr6HhvrTaztmtsF8le7Gdv8Bp2AIqhXQroc/o0dKfp4
        6UCv20df6zaE9Obt9QQKgh/zubYJnmx4dA9UWgiK0n6VX/vjAy+ni2+ke7/wNhdT
        wlfIxkfkFh7+RstRdhJyluZTX/BPGuVGvwZA7vxAUGvye2B6Nu7SAHnSWSRZkb8c
        Jdtn7mJBJkdsYEWmRpgm4i6/y7gzSFTXE3YsmlvmkEkZ6vuFEf/VdpFkPEL+HcrA
        OrJV3krJmZkWpJI1Gtm6D0vswGMqWY37pH+reKWz3CaITZ9t8UaGI4lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/pY3yz
        47Nuid96s8eNEwkYTyhd2x8Impr+YNOi7OK8g=; b=D4JG78bsRw36sMeSUQHgoz
        VsjBjrGgwLeBSHk9onX1t6jc9poa8mnjFEW0PaOS/9V9nF91dPanB32WJwt/NuAJ
        2/QJ78Ggiyd4Ng/jWIeoMPWCyLNA+UaeUzqyLi09/ahrjXww+4L9WYgm5H0REVAP
        hKhjkSoWc4RZwkuae+g1WL0RTsPcDuubO7GH6LrLWPsqEp8LhGSNW5lkjn4VBi9V
        ckebce0ViNaTMboZb+mhrTPLUF+VDHW/oXPC4SkMOD+SDHu/rrpdKQhQI7y4Wv8K
        rsv/fqDIMoh6RPVYE5M8W5Xg1dcgMvzAdSdGtwdZOeFM+xVL/eLY9/6hzjrivHYA
        ==
X-ME-Sender: <xms:L604YkOnyHPID1yP1OHkMsH1tkiUBGxq7dHrj3sFe_MIKYELr22rdg>
    <xme:L604Yq-FbybcMYaO0959FICmZjqymXvZE7dX2QoucL-7cFbBoo6QwEEndrJtA5VD2
    5lDXlgueAmWj-M_7N8>
X-ME-Received: <xmr:L604YrR9S4aDq59z1cfxW0qEO8IcUwGNYikHzXLxLLUNnjr6ClKUp8SYLzlJTWO8BIb4HkEuP8mZXtXTQcwPrhq6Aj8SL1U6SURJAVLMdtIKbJr91FP5R8iGRONUMGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:L604Ysup5z-LM09s6itmwv1uJn3ixPnMMsQVZjvhJh-Ou2Vuv7Q3sA>
    <xmx:L604YsdxlyW__41-4VuTW-FC4OVpzef6PcHX99_rbdaTYncHGDgqCA>
    <xmx:L604Yg3YDgirCKlkC4XSzdO_FgKFpCyvVj3euXlDUNRdibAKkMOx8w>
    <xmx:L604Yi2fyOptG5HVc2jWlpAZKPkzyBn30ogXrlFmJ3YLL4wWXfgSNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:51:57 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/9] dt-bindings: soc: apple: Add ANS NVMe
Date:   Mon, 21 Mar 2022 17:50:42 +0100
Message-Id: <20220321165049.35985-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
ANS2.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/soc/apple/apple,nvme-ans.yaml    | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml

diff --git a/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
new file mode 100644
index 000000000000..e1f4c1c572aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/apple/apple,nvme-ans.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple ANS NVM Express host controller
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-nvme-ans2
+          - apple,t6000-nvme-ans2
+      - const: apple,nvme-ans2
+
+  reg:
+    items:
+      - description: NVMe and NVMMU registers
+      - description: ANS2 co-processor control registers
+
+  reg-names:
+    items:
+      - const: nvme
+      - const: ans
+
+  resets:
+    maxItems: 1
+
+  power-domains: true
+
+  mboxes:
+    maxItems: 1
+    description: Mailbox of the ANS2 co-processor
+
+  interrupts:
+    maxItems: 1
+
+  apple,sart:
+    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Reference to the SART address filter.
+
+      The SART address filter is documented in apple,sart.yaml.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - mboxes
+  - interrupts
+  - apple,sart
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    nvme@7bcc0000 {
+      compatible = "apple,t8103-nvme-ans2", "apple,nvme-ans2";
+      reg = <0x7bcc0000 0x40000>, <0x77400000 0x4000>;
+      reg-names = "nvme", "ans";
+      interrupts = <AIC_IRQ 590 IRQ_TYPE_LEVEL_HIGH>;
+      mboxes = <&ans>;
+      apple,sart = <&sart>;
+      power-domains = <&ps_ans2>;
+      resets = <&ps_ans2>;
+     };
-- 
2.25.1

