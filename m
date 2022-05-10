Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8125E522764
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiEJXKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiEJXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:10:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B9293B7C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:10:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 281542C02DE;
        Tue, 10 May 2022 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652224210;
        bh=M/qdruHJlEw4eVXCC1MdUNQ3IqTaibvAe3rgnPTiJHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2+lNn1byUYE1CpiHaR0kf+hkDekvwINV3yp5b3uL+mxdpB0GOAUBTyd0m5WoR1H05
         KMhVQ5q4aWkH6flinE73bsxdLaeUBBQzH9l/5GQdvk35VzRwq1ZE1z4g1WfLbccIFt
         GYwbk5InSf79jaC1jEfHNA8z5Cm3ylkuFLhpAjOEGWdyyjHCPTC0Lj++QCrYmGuXZX
         3MHBdIXv6UL/ALF9M7rw76qN5QlWZcCDr8QOF3oMlB9TllqY6kb0Jf0IEV+6aJC4mH
         JGKca2uWoUY2pxDhsOIVx8m7kwyeEOnUWW37LB2HzS24MKKPifOP1rZqsYtBtC6b6X
         UeoCpbN5/s7Sw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627af0d10001>; Wed, 11 May 2022 11:10:09 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id C811313EE56;
        Wed, 11 May 2022 11:10:09 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C37C12A00A0; Wed, 11 May 2022 11:10:09 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X compatibles
Date:   Wed, 11 May 2022 11:10:00 +1200
Message-Id: <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=gEfo2CItAAAA:8 a=SCFnzoBICK1g0U61-m0A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
    Changes in v6:
    - New

 .../bindings/arm/marvell/armada-98dx2530.yaml | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-=
98dx2530.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-98dx253=
0.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.ya=
ml
new file mode 100644
index 000000000000..6d9185baf0c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-98dx2530.yaml#
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
+
+      - description: Alleycat5 (98DX25xx)
+        items:
+          - const: marvell,ac5
+
+      - description: Alleycat5X (98DX35xx)
+        items:
+          - const: marvell,ac5x
+          - const: marvell,ac5
+
+additionalProperties: true
--=20
2.36.0

