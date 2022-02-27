Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0AE4C5AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiB0L6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiB0L6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:58:36 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29541A827;
        Sun, 27 Feb 2022 03:57:57 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 230403200D78;
        Sun, 27 Feb 2022 06:57:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 27 Feb 2022 06:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=JMgt1OmqAlyRfHsJvlGYeUhTKzD1mdKFnFYq89
        SzjJ8=; b=lqR9SiAO7VglTKNL4jRvpYwRiE+3XtIiFrSeZiHWUgz76m4+Xqca60
        uC6MHJuNOGlLsntnU2cVhs8stxB6+ulwORd8ll4JP0yMHQYlzi8WyEKe+2iYTZ+M
        g3PlG4yGQaqIKV8PdcKzGtJezOxPkHDusGhowiow4jUpOCaTjhaB45AJrLDjpD0p
        uOlIaFBRQ8teBEcrKgvEcuMaufbs19K5ZnrhTPWTpDHQh59oMgpAo1461vcvBneJ
        QCognpvT7YvidFHjTexElNXQyQ5g9JxufN4wsOo+F4tUt6YO3coyYxt89qj0iL4U
        769Uo2xqmIdO0prx9HqYwBfk5W/dUInA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=JMgt1OmqAlyRfHsJvlGYeUhTKzD1m
        dKFnFYq89SzjJ8=; b=hVFuO1c4kDTHtaj8/Eu31VkidR03N7/0X5O+v4d744gPT
        hWz3vyinBLSgRHc7TjE48l4zhoimJtpgvh6BRGqbm2RmWP9fDb3sIO0xSnZ5VFK4
        YoMsnUQye0SetYrFsK10faDw5sySp4x9i5O2q0sAmwb160G3HaTdc7PE9Ep+MDVn
        4ZDtCAZ+9HxAInoKB4ne5DaXbKeCjP9eDUBgGlAZcpOujZhnSLXWw4T6pDPm4yjn
        ek5/ogslQkVLXxMxbA2YPFSp+7iK/Rd/P4FGC+FIMk3nAPmPGIobHX3uBFo/qvth
        Q31MAAts7ZSou5hl9d2gJtg59OfbtIoqyCNxBkoLw==
X-ME-Sender: <xms:QWcbYjXbtjRTkn6UEzesWTlyLdPAfRsHDTepL3_hhBRV1krRQQ58Zg>
    <xme:QWcbYrkPnw0MwbAdj40ihoKVvkoK_pW6ub3eTZgSqb9bzgLows8XZykBa7uIJeoWT
    mvk2AFG3Cl98nuVG7Q>
X-ME-Received: <xmr:QWcbYvY_xpj4co0JCNfH-eLZ8ChpgfSLoyBAh3a49MfedgeiOBC710I3zwO8UTHJbn3N19Wf_KisxTUeEv2Q5rirPGojUeBT0xMlF7X-kRqF7Ig6RtiQnYJEVEYPa3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    duffejkeevlefggfekkeevjeffgeekjedtjedtfeethfeludehkeehgfeuteekhfenucff
    ohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:QWcbYuWri7l9Nvt6nCkFOHYd1kgbqC91YFT9AD0EAXMuSOyFw8FLYA>
    <xmx:QWcbYtmyR8bHU_mDVJxa4USZQIUsIGBJaqjVmh5qZs3XbTHhTvKfYA>
    <xmx:QWcbYre4KGbdWtWKmilbHbHo7A29UjB-_i7n3Ut0dmeL7dVOnpE-wQ>
    <xmx:QWcbYjX6vyV_pmiFtbjAiBOpd4FtAiBJqUyRMBFfQ4hUeORkXYkskQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 06:57:51 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: Add apple,efuses
Date:   Sun, 27 Feb 2022 12:57:42 +0100
Message-Id: <20220227115743.69059-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

Apple SoCs come with eFuses used to store factory-programmed data
such as calibration settings for the PCIe and Type-C PHY.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
new file mode 100644
index 000000000000..a735d54856ae
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
+  calibration data for the PCIe and the Type-C PHY or unique chip identifiers such
+  as the ECID.
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
+              reg = <0x500 0x8>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2524b75763cd..1bc57af09c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1771,6 +1771,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
-- 
2.25.1

