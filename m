Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084E15928F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiHOFIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiHOFIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:08:32 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4E15724;
        Sun, 14 Aug 2022 22:08:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B248A320077A;
        Mon, 15 Aug 2022 01:08:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Aug 2022 01:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540109; x=1660626509; bh=VC
        iO+1/7gvQvfqsvEh3J7OZy4FYDY6eHNsrcKm6S1VI=; b=NVQX3Q3w3uHTAPcC7W
        NPtExPv1e1twycdJUHl7SiOQfBvifOvS8dSv9N9D2VYa3xyeikcPnFmzwHW0r6Ep
        ueZOmNkizyiRg7sXLb9hj7ENf50oX6MCq7GXErvM3s5n5CEv9HlJtylC9uCa8vL0
        +gZThwQM448diXT9HufTtvkzYmdzUf8GTR4ABxBEy4PNGZl0ky+ID4nljjKBNQzn
        w2H0k5GPcldUTLnBp5SkD90RCdLvxgRDYVgn0T4sOgvKEfx9T0ju5OLc3ensTtUT
        AIEUQI6k98LtsWJFa9JJ/lg9sZ9mB/9ng78+ux3q0qipJNRPDLWtbrBDxhI/rD2+
        oeCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540109; x=1660626509; bh=VCiO+1/7gvQvf
        qsvEh3J7OZy4FYDY6eHNsrcKm6S1VI=; b=OFR9ujqQn+kqfkjG9hhYbNG3hnjeI
        gfrEqTzTjDoBYPWAJsCmXY00l5DniVL/l7xOeQSNSqTz7J1lsP4s5nmjJg4uweVe
        u0hveejBPAC+NqLz37k8uO2LOPZKhGTsbfsG/120O4bPJg7iVQ+1ZyLVDO/bZ7Cs
        vm+UhEfnidPSLaq4WeKNHV1ngApWCGZgI8ZkIFcdCdhJDGgxao7HRtlNho8aDfmG
        NhDwnI7USFgh6vS9tPt6Ce77H9/uD0hWZtQ+4+3lsgj8vn42babyXn/Mb1cJTqds
        6hR7ro878HfrRp8Gh+RRLLpWJQY4FoCnn5SUM5enOues7lyl3vkVZ+6kA==
X-ME-Sender: <xms:zdT5YszwzViJoQOl-nlsxS1Xl_kQ2mj6sMxepWFiJyt9wcUP7gbVKg>
    <xme:zdT5YgTrDALU6sQN4n30-Bj8c8gXqHV1HfYFy1IDCjSp57zcRIwowhCE5gjeOeZiP
    rNgl1pvgyC7Q4AiHw>
X-ME-Received: <xmr:zdT5YuUAtpGjzu2kKsrZfBM_IHNP6tymsNPQ542fWgRIwD8SuwqQgoVRHbtUofuVktzAd9f7jt0HghFpE18ECLTq5bBs6aLXQz7BunEmCW1_WPREmkUhjz1mChAQvLBtP_8W-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgffhvefhgfehjeehgfekheeuffegheffjeegheeuudeufeffhffh
    ueeihfeufffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:zdT5YqiLSz0XwDT6fr-JMq5iahfd36iZv5wB0rJbcvZ3X7MjSPaulw>
    <xmx:zdT5YuAqx6PJG8cZVcshWoJ3rCI0nFU9TPgy29j8hCwERm1pjUtdhw>
    <xmx:zdT5YrIdufOLU0_vT0QD7VQE29-AxjxwjD6Cbmr-VP9O2MZgwiv8gQ>
    <xmx:zdT5Yi41ziFzlslbWUUpNcgfptO0cvvSuPk9oFBAkwylcffBo8Zmmw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:28 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 04/12] dt-bindings: riscv: Add Allwinner D1 board compatibles
Date:   Mon, 15 Aug 2022 00:08:07 -0500
Message-Id: <20220815050815.22340-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SoMs and boards are available that feature the Allwinner D1 SoC.
Document their compatible strings.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/riscv/sunxi.yaml      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
new file mode 100644
index 000000000000..564a89499894
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sunxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner RISC-V SoC-based boards
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  Allwinner RISC-V SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Dongshan Nezha STU SoM
+        items:
+          - const: 100ask,dongshan-nezha-stu
+          - const: allwinner,sun20i-d1
+
+      - description: D1 Nezha board
+        items:
+          - const: allwinner,d1-nezha
+          - const: allwinner,sun20i-d1
+
+      - description: ClockworkPi R-01 SoM and v3.14 board
+        items:
+          - const: clockwork,r-01-clockworkpi-v3.14
+          - const: allwinner,sun20i-d1
+
+      - description: ClockworkPi R-01 SoM, v3.14 board, and DevTerm expansion
+        items:
+          - const: clockwork,r-01-devterm-v3.14
+          - const: clockwork,r-01-clockworkpi-v3.14
+          - const: allwinner,sun20i-d1
+
+      - description: Lichee RV SoM
+        items:
+          - const: sipeed,lichee-rv
+          - const: allwinner,sun20i-d1
+
+      - description: Carrier boards for the Lichee RV SoM
+        items:
+          - enum:
+              - sipeed,lichee-rv-86-panel-480p
+              - sipeed,lichee-rv-86-panel-720p
+              - sipeed,lichee-rv-dock
+          - const: sipeed,lichee-rv
+          - const: allwinner,sun20i-d1
+
+      - description: MangoPi MQ Pro board
+        items:
+          - const: widora,mangopi-mq-pro
+          - const: allwinner,sun20i-d1
+
+additionalProperties: true
+
+...
-- 
2.35.1

