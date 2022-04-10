Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC84FAE1F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiDJN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiDJN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:56:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7457B05;
        Sun, 10 Apr 2022 06:54:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B8B485C00F4;
        Sun, 10 Apr 2022 09:54:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Apr 2022 09:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=872TStTIZWE7QK
        oVNxz3eKsUGk00QbR/SRkqv3FSeiE=; b=UlOJgyl4n0XgXqaXpX/M9cwHgSB/Ly
        vZTUo76I6eAuPYrTmPVL1gIRn+YqgxY1l586rCSZJtsJ2Sfclo1656cLlGPKPiAp
        4htAv3DQmjjNawywxVOWMapQ2fEITZzka1Qc5U7ZrlMC/W9fhECSU40xM3nWcVs0
        q8fJGDjYVsZDut+WLRUnMQlVNKWnSk2B80PatUG1g9WBsYpIDU22A41NmEJHCeop
        2JEQ2aoGDkDvPbgIO73C7YQMpWgovyBCpgLfkmaODYffyzlz9GwaEuX/rob1xqBf
        +ixKndNzA3RqvwKBlAp2vRSbydySPw0KUg3IQSo15Y9eG+DWTQJVy2ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=872TSt
        TIZWE7QKoVNxz3eKsUGk00QbR/SRkqv3FSeiE=; b=C2sdfE02sbUaX7OHX6AG6k
        v2NbrqbhtQN9GHGSff8XJmPv2F4OYLh8WOrscpoM4scMOHSx914HL0vCjgP80KSx
        RyGBPYgApdq3a8XjXFXqG18RwSbfXZ2f2mvAy5Nbf6WJkyPVysAoxOiSyGUUtOlr
        vsNvN0k1Q2Pmv7D1gktwhluq2flm+14U2FG3E2a0Xe6ZLGh9JGP7KY11nYOIpvXt
        VIwxTJccreTWAVhaXmcx3afP7vuGfgk/wJ+wnMxeK/dMQxlv2SO93QmUs8sN9mE6
        H280IvSiS9cBeGQMCm7CXP4TlvVwAbp/efM6n3jNqnxYqF4lTZpp9lqGkFcbu0Tg
        ==
X-ME-Sender: <xms:kOFSYlviI01XMsMniii9E2vG0Wlobkg3kIBVQSMOUHO1Lt6ip-RwwA>
    <xme:kOFSYuc-f_O_GJXasya6oXr08njIURrxOjjUaiu0dgU0OTtwxzzJMVzcVodTcLcDB
    lRor-r5DlbqE4dkc9A>
X-ME-Received: <xmr:kOFSYoyqBUZo5GzSj2XT14zII4y061fp6PZ1Zei08fgv1ZrkxMabJ2EfQMDvqJqZKWb6k8nsfgk6tugAzDqbnG9D-LgEVEX-Oxpqn8LmVc68DFAxrCWjeRR7PSF-aYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:kOFSYsPRls12xQ2bConylta8Uqb_fOW5Zj57a6mfUDtXiKrZTSgP5Q>
    <xmx:kOFSYl9GtL_lZvPPg0SIaS9WzmIGGdeaP_bdaZQ62Ly7nmk8cDSNRA>
    <xmx:kOFSYsXsdVkO8-FXVLCG5wrrYHV5ETu6K8JoWhE77nUD1DbLX1YFPg>
    <xmx:kOFSYm0uxSjtPP3ApvLw1inrgZpaTlwuPdO5T3nXkG552IkZGimjow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Apr 2022 09:54:22 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Krzysztof Kozlowsk <krzysztof.kozlowski@canonical.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: nvmem: Add apple,efuses
Date:   Sun, 10 Apr 2022 15:54:13 +0200
Message-Id: <20220410135414.20606-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220410135414.20606-1-sven@svenpeter.dev>
References: <20220410135414.20606-1-sven@svenpeter.dev>
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

Apple SoCs come with eFuses used to store factory-programmed data
such as calibration settings for the PCIe and Type-C PHY.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v3 -> v4:
  - added rob's ack
  - rebased on 5.18-rc1 and split off MAINTAINER changes as requested
    by Srinivas Kandagatla
v2 -> v3:
  - added r-b tag
v1 -> v2:
  - fixed indentation issue pointed out by Krzysztof Kozlowski

 .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
new file mode 100644
index 000000000000..5ec8f2bdb3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/apple,efuses.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC eFuse-based NVMEM
+
+description: |
+  Apple SoCs such as the M1 contain factory-programmed eFuses used to e.g. store
+  calibration data for the PCIe and the Type-C PHY or unique chip identifiers
+  such as the ECID.
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-efuses
+          - apple,t6000-efuses
+      - const: apple,efuses
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@3d2bc000 {
+        compatible = "apple,t8103-efuses", "apple,efuses";
+        reg = <0x3d2bc000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ecid: efuse@500 {
+            reg = <0x500 0x8>;
+        };
+    };
+
+...
-- 
2.25.1

