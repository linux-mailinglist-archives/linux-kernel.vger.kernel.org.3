Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E8502BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiDOOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354412AbiDOOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:23:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20D98F4D;
        Fri, 15 Apr 2022 07:21:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B06965C01E1;
        Fri, 15 Apr 2022 10:21:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Apr 2022 10:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1650032468; x=
        1650118868; bh=fdR2ry7vukdtAoO4+NBTW3UbyTPfG6G1rCwnW2fmsNY=; b=C
        2EwiKaV4twXsvd6Wra//CSIAiq4BnVIludyP1VeZheQIS4IsUk64B9vO0wv/rfPC
        YKWvX0Pz9cPcmsbAJZqphyqoH2Z3gClq7DZ8itlWkV3/SOh8tH04h3XNPrBrRvc6
        e0r/Qf8HBNnsOwWX57AFTpKxMr9B4R2s4zuWBrH5aN1dwCiQezuN3dI6Q4BmVeru
        c6+StGm6ZOInJTpPP8dRI7Xwn4u9jgK0lNNxOuJxOivZ0kI2jG9Jqm8xeC0feEpo
        0uC/4YMAoHnPtLCUG3evKwaMO3DYwgJywfTOPiPa74YRmBeNbJ+3ZXgryK3uU4PV
        STt6juwCxA0SSAMI52oMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650032468; x=1650118868; bh=fdR2ry7vukdtAoO4+NBTW3UbyTPfG6G1rCw
        nW2fmsNY=; b=dUiw/r0coe9zMDhtDLNXMsbm9jeQAGLtvIhb0iCGFMV6d4TFkSw
        xVNttl2LPKG2JyiPAIg0f8En3AWup+Xhbj9y9r+xQdv/t/zlsT8rnSTYeZEjYrSE
        PYKc8HeELn1feybYSQT94vZVaRGnjQIyT8WEUQF0OAhwitkBLCGJFrxwI8Pj3Arq
        DYZzKte0GL0dTuvsd+5QRPqklNoZ6XEpCnVh1NMdqZvHmC5R/5QkBWIBgkMVcYCr
        YekbF0fCG16G+PJj0niCoVXoPmLvrUswclhalF2cbP/857NKujDSDg2bO24CkuyU
        CGXEcMzO+nj/dm93DI8yDwsvsAm/kktepUw==
X-ME-Sender: <xms:VH9ZYl0ft8E41Kg0qniBwgISsUG3Abvc_wEObjTaP7EZ0Z_zaGtbHg>
    <xme:VH9ZYsEE2Nj2_l40o4c0Ojf3gbcC3dYvjKmgc47Mq4Zo2f62gQ7H_boBjmsdyDcOn
    10nnMWjOyzz3hBjtGA>
X-ME-Received: <xmr:VH9ZYl7Eix8BoLPa84sFYTTzcf7Qe7-sVnG2-mNDwvyQRUIQovulwRM_kA_UFajoEY93FGCYVB-IKWsjiQl2ef5rMKYa437jes6pz7Q7u7ip_fqizkpGyNv3KfgH9iE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:VH9ZYi18etAN8m7JHEFAjA2qIGrtkOUKCUd2dWHhPbnyGyWZPumS2g>
    <xmx:VH9ZYoERd4t9q71O7vX5_9LF1gS3XzFLrmxrzgmrePL8mXgbMjdhow>
    <xmx:VH9ZYj_2Pt15XZIcct6zY_o0pev2Ou_WEf0sOCrLzD6zx_qPhJwyEA>
    <xmx:VH9ZYsGqIKM_MfANmddHhJCJRVUjGHSF4wl45WPUnCfFBR4ghYOvKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 10:21:06 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/6] dt-bindings: nvme: Add Apple ANS NVMe
Date:   Fri, 15 Apr 2022 16:20:51 +0200
Message-Id: <20220415142055.30873-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220415142055.30873-1-sven@svenpeter.dev>
References: <20220415142055.30873-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
v1 -> v2:
  - Moved to bindings/nvme (Krzysztof Kozlowski)
  - Added power-domains and power-domain-names min/maxItems
    (Krzysztof Kozlowski)

 .../bindings/nvme/apple,nvme-ans.yaml         | 111 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
new file mode 100644
index 000000000000..ddff9233b159
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvme/apple,nvme-ans.yaml#
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
+  power-domains:
+    # two domains for t8103, three for t6000
+    minItems: 2
+    items:
+      - description: power domain for the NVMe controller.
+      - description: power domain for the first PCIe bus connecting the NVMe
+          controller to the storage modules.
+      - description: optional power domain for the second PCIe bus
+          connecting the NVMe controller to the storage modules.
+
+  power-domain-names:
+    minItems: 2
+    items:
+      - const: ans
+      - const: apcie0
+      - const: apcie1
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
+      The SART address filter is documented in iommu/apple,sart.yaml.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: apple,t8103-nvme-ans2
+then:
+  properties:
+    power-domains:
+      maxItems: 2
+    power-domain-names:
+      maxItems: 2
+else:
+  properties:
+    power-domains:
+      minItems: 3
+    power-domain-names:
+      minItems: 3
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - power-domains
+  - power-domain-names
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
+      power-domains = <&ps_ans2>, <&ps_apcie_st>;
+      power-domain-names = "ans", "apcie0";
+      resets = <&ps_ans2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4961da640e82..1bc8b732f129 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1838,6 +1838,7 @@ F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
-- 
2.25.1

