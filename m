Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1052443D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbiELEZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346866AbiELEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:25:13 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6F20F9E7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:25:09 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5F0802C01EA;
        Thu, 12 May 2022 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652329506;
        bh=edX0OBDaSPZbuETw51Ot3c4INOdYYG8ADBeYX7EyyXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0XoDymEiRwH56BIBTdt+rUgxrhM6AI5Qtji8grchRjfV6s97NqRnsD8DTQqULcvA
         yQuMrUK2l5QW1KzMTQFA18oynzNjz4N6N0ZgPL3H1mfg8qm9H17DoKNnRW4UbizfSv
         FL7rgMa7LfMLBg/z8XtEVGy41E6uGIg7Bzi/LuibctuXg7ElauAt+W1aSziLL7mriE
         GQPAwFPbU0j/36th3OXxlFUQQGS1CZYCkMPI3Ruzc9mbHy2zBgrhOsZ5cIVQfaoAgU
         OcvslKfYsjomikexYXSmx4K+Sc9ELcvbLoEX7g9C/dBpKj19SS4gfd+l3Ok5RpTPM8
         /cpgG1p9MDmTw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c8c220001>; Thu, 12 May 2022 16:25:06 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 1601313EE56;
        Thu, 12 May 2022 16:25:06 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0C9942A00A0; Thu, 12 May 2022 16:25:06 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 1/3] dt-bindings: marvell: Document the AC5/AC5X compatibles
Date:   Thu, 12 May 2022 16:24:59 +1200
Message-Id: <20220512042501.3339775-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
References: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=gEfo2CItAAAA:8 a=38J-PH5Oi3SEl5fjOmgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the compatible properties for the Marvell Alleycat5/5X switches
with integrated CPUs.

Alleycat5:
* 98DX2538: 24x1G + 2x10G + 2x10G Stack
* 98DX2535: 24x1G + 4x1G Stack
* 98DX2532: 8x1G + 2x10G + 2x1G Stack
* 98DX2531: 8x1G + 4x1G Stack
* 98DX2528: 24x1G + 2x10G + 2x10G Stack
* 98DX2525: 24x1G + 4x1G Stack
* 98DX2522: 8x1G + 2x10G + 2x1G Stack
* 98DX2521: 8x1G + 4x1G Stack
* 98DX2518: 24x1G + 2x10G + 2x10G Stack
* 98DX2515: 24x1G + 4x1G Stack
* 98DX2512: 8x1G + 2x10G + 2x1G Stack
* 98DX2511: 8x1G + 4x1G Stack

Alleycat5X:
* 98DX3500: 24x1G + 6x25G
* 98DX3501: 16x1G + 6x10G
* 98DX3510: 48x1G + 6x25G
* 98DX3520: 24x2.5G + 6x25G
* 98DX3530: 48x2.5G + 6x25G
* 98DX3540: 12x5G/6x10G + 6x25G
* 98DX3550: 24x5G/12x10G + 6x25G

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v7:
    - Add rd-ac5 and rd-ac5x boards to binding.
    - Rename to armada-98dx25xx.yaml
    Changes in v6:
    - New

 .../bindings/arm/marvell/armada-98dx25xx.yaml | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-=
98dx25xx.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-98dx25x=
x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-98dx25xx.ya=
ml
new file mode 100644
index 000000000000..b99cfb096277
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-98dx25xx.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-98dx25xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Alleycat5/5X Platforms
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Alleycat5 (98DX25xx) Reference Design
+        items:
+          - enum:
+              - marvell,rd-ac5
+          - const: marvell,ac5
+
+      - description: Alleycat5X (98DX35xx) Reference Design
+        items:
+          - enum:
+              - marvell,rd-ac5x
+          - const: marvell,ac5x
+          - const: marvell,ac5
+
+additionalProperties: true
+
+...
--=20
2.36.0

