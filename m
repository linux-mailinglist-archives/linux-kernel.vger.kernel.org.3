Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8604C50C6F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiDWDsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDWDsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:48:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08olkn2033.outbound.protection.outlook.com [40.92.45.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C717E18;
        Fri, 22 Apr 2022 20:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAB8nLSLDj5Gl97dp3zj+vPbWRkfOGDqFS9m1l0E0kH70Yf+Th5/BGOx0WtmivxqQQIAwNVIYwrYPKMtxRqQtbnpp3JSWrs2f4hVpf6hFMKaBN9KeyCFTS6g2UGbYX/HxOiRK9vCuJJ9xIvsyBg6yXH2fsHp79D9TLt4gIS4LchelKljzbtzJTAbz4fRYlOWEoBWDY0jDr/Km3htcrUCOVf7YLEYesnHYYnnH81jXvHdWAZXgmz460rIdXiUCobhK+KPRK1AmA1B2/84Cr7SdJb3GVX0P5uuWIR2RQHsWz0kF3UEj61DcxwOmFWQ3vl/L/9AzZBsWtDwzPRpS3yVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uecGUSqWJODMZllirGh+Anzc6QtH0q4hkKrsUA9O1dQ=;
 b=KuAKFdAdETyigoOKGHeu23r1WyyCQ06dK7ARY6sLzvRcJkRbmyGXAVXDuGfaVI9JUfwPOfueZvRnlhOZOxeeI3JpoHnmDkUsI6saiw+X5INCNy4EdrAgD8AGtwXuNHLcDZeXRpKr4k+gPMKY2gp7WyKuy342CwEh+0q8jzGmWqb8NBU2DAT22vox7+Ht24m/cOZfM9ifl3UWH7cVtZQD8I8OjPonzMiWUWWZ5XCw54EbfqPrE5wh7xhWUIwikUUA5tZX7wFMzaQia6Z+ZjDOdeXrQopyxSmz7v8kiTirNZPLIsuuza5U9b16qPeE3NZMWi/2Xg+mpWI8jrgS5lw79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4205.namprd04.prod.outlook.com (2603:10b6:805:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 23 Apr
 2022 03:45:42 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5%5]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 03:45:42 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/5] dt-bindings: mtd: samsung-onenand: Add new binding
Date:   Fri, 22 Apr 2022 20:45:24 -0700
Message-ID: <CY4PR04MB05678FDFC8BF8B15174ED639CBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423034316.366488-2-xc-racer2@live.ca>
References: <20220423034316.366488-2-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [bU/ZgHwhhA+sBXY6ZdurX4/f9ypBDq+Lk44A/j6V6oW64yvmdmaBl2L4iTipkUX7]
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220423034524.366612-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b98c29-3cc5-4893-61a1-08da24dbbd73
X-MS-TrafficTypeDiagnostic: SN6PR04MB4205:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXWmi+OYgPM8LHE8gawYJHpN74lEiBjR9BXzKPhv9UidSglWba7BxlgsiRLdaQCr4BxXndVC2xWiCOql0qST0mR/S8Oqve4z7MpGkZnuuwL9h+aLCbFdvW3AucUk0mG7bg2mRYSniVrtw7zkkQz3TP57FVzPlNHKh3vx/hXCSx7QvTRWxVN2i7SoW0m+EU1x7kH6JtILddKOfG/fPg+R9fyP31ZgDbBOJhjOw29YOIxmgkNNG86JoSpO9+oB+0PniTiNf0hOFJDPy7+G0HWwSWBvYnN3eDPnNHxZNQMPAaAM0Zwre6FbHHOEsNx5AMj2VGTqiqql81nfrUf3hPiQnj5AjS9VFRUT+kQU1KKwa6rZn3XJTA8iE26uAGNKfWFns3/khK8vGHsov4+pcVSWB0QfMhLvjAZnBir8VU5PcAkCbw3kP5a5WijuWAQj32o23WqzYMJmnNTdvz5h1pC1kWxRTHV+IlzQa9Zs6qpo5qT1C2AgIyTAvSHJ+nc8x2GJ+XbS2jLdj0mmQAsaDmd1Rbfj3z2T3yKcwEOndKHG8iEezpPlovTKrxKzQGR/MhAJRVIwBvCqwRfz7SDku+GHYmHvLB/LT9x3HQX32yjU3MzoZGRAXo4Z3pRh2xoXBqHU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpXkwTUw9XADYFLw37CpvR1XQLnYsw2Tu7cGz98DGb/i5vaFJjW+TLjqXkCR?=
 =?us-ascii?Q?HZBfWAuecKDjYKRopFtlGqZ1u8VKaycw/UDBXJnhUMjE0lNsoJ5v8E4fnYd3?=
 =?us-ascii?Q?7nXv6V4mvcK5+pfwHBbmJtBFatOpT/Bako+8e9bpnOY2oYD4zGtYnkZg2IOM?=
 =?us-ascii?Q?Yk7MHDNhPZVlddhvDcpWbAXDH6pXh4mEEEQWNteZJRZqJVIlrmLd0hcfpMiq?=
 =?us-ascii?Q?XAXB1J0ITGWGY1u5+r6zKrhFGGC5exuJHxu7U96tRCIZFdr9Ea2Gu41kVRPJ?=
 =?us-ascii?Q?u/bdTuFKLPL1g3Qz9BeP01Wya60UZlX/Ep3/UeSr6MvQBI35f5eyFmPOQWvG?=
 =?us-ascii?Q?djhf8yt7WboS2XSvR6VQijQuA9j4Ab2gQRiEEDRwiiZM4tIWMdj46RIOc8Io?=
 =?us-ascii?Q?vqrM2E+Qkg27yfHKuyI0Fl87440mBG64Vhyen0SUiT1twSeEgsUQEjf52dyV?=
 =?us-ascii?Q?Mm5A/UyTlO0uvBxdW/Oyk7eiOuvzSIKJnoI6zc4mkO3HE9jpYfyeWwT9f/Ja?=
 =?us-ascii?Q?UWXuOm2U96sd5p6e7Rj+6lsTejmpc7JKhVt0UxxOq3DfNMqrdiPzQpDSA/dN?=
 =?us-ascii?Q?lgvnPaR4h3/h+wvE1G3jlbPmcZX44Izu/PMDpGKSHUm3QMZCW242sashvp4q?=
 =?us-ascii?Q?kjnBRQLwDj7WDZTWZdd/unkJn1VkgxqH+8EJs/gocbalG5Viy5JhFqiqLGBJ?=
 =?us-ascii?Q?DhV0wdGVnxpP6zzrUUlAjKKz39dJs/X+jR7gaWFbFT2idAxqW3WIq6hnBMsa?=
 =?us-ascii?Q?Z0mdkHWXJe9sBGJAUuYY+apubnEjydh5Dq5K5Xe/f7iwtkXoogQWfvvPgeLY?=
 =?us-ascii?Q?tWCPWT59dU9Vj23mJ8u8k8JVNaLFt6+DzU+RRTwwklM89NjOrO5TZj16K5Au?=
 =?us-ascii?Q?iodXY7uMb9Dzmtn+kBVtlY0JrGEDi/mPKOh58jtoif5yRjcrOHJQRk6T1rRc?=
 =?us-ascii?Q?uEpIp5MjpCKidS4Ti6Hvy4Qd6PHNa6a0bLDrP/CUhlAcEQByxUTa3mbpskYd?=
 =?us-ascii?Q?sEyXpomWmno6XQDIOG5PwcCFbczCppTkt4ZvZG0SkH9/3jMA/uSmKaG68173?=
 =?us-ascii?Q?v9yiTCWHjtkk7PRSMchOinwd13nxqnTo/iPTUAD/b5ON1DnEspxgjRPLAy2f?=
 =?us-ascii?Q?sU9U8wsK7qo+Xx8+hFY0m+9DvOuDd4yageX2sTo52x8NucRA8/1g57Qit2iV?=
 =?us-ascii?Q?wiUgRrddcABRzGXlptLgzK8PqszzsPP5wD/+bANCezm0tV8yTUY4uh++Jal2?=
 =?us-ascii?Q?UuVHHehI/Nq4t3+ZQwvD7PAHKzEbI2nmYnMAp2EsfGyHBIhnz4sOchHuCWM4?=
 =?us-ascii?Q?HV1Df7XpyCcue8eaBV/kzmFAtZZcevKTOlhpyUbnMHdcvoOVKnBttSjE0aGz?=
 =?us-ascii?Q?Z5QQM05OJgA4T0YA5R55yCO23ONbX/HXBANPYPh6AV8Sm/rpG794NjJ/RvDK?=
 =?us-ascii?Q?rQEA6OtaTHQJH7n5TCAQbs4G/KYZzedxH2kvbr006pC7XTL0Gzu92g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b98c29-3cc5-4893-61a1-08da24dbbd73
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:45:42.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4205
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a yaml binding document for the Samsung OneNAND controller.
It is found in several older Samsung SoC, notably the S5PV210.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 .../bindings/mtd/samsung,onenand.yaml         | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung,onenand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/samsung,onenand.yaml b/Documentation/devicetree/bindings/mtd/samsung,onenand.yaml
new file mode 100644
index 000000000000..25012248add6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/samsung,onenand.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/samsung,onenand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung OneNAND controller
+
+maintainers:
+  - Jonathan Bakker <xc-racer2@live.ca>
+
+properties:
+  compatible:
+    enum:
+      - samsung,s3c6400-onenand
+      - samsung,s3c6410-onenand
+      - samsung,s5pv210-onenand
+
+  reg:
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: bus
+      - const: onenand
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+allOf:
+  - $ref: nand-controller.yaml
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s5pv210-onenand
+    then:
+      required:
+        - interrupts
+        - clock-names
+        - clocks
+
+patternProperties:
+  "^nand@[a-f0-9]+$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/s5pv210.h>
+    onenand: nand-controller@b0600000 {
+        compatible = "samsung,s5pv210-onenand";
+        reg = <0xb0600000 0x2000>,
+          <0xb0000000 0x20000>,
+          <0xb0040000 0x20000>;
+        interrupt-parent = <&vic1>;
+        interrupts = <31>;
+        clocks = <&clocks CLK_NANDXL>, <&clocks DOUT_FLASH>;
+        clock-names = "bus", "onenand";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nand@0 {
+          reg = <0>;
+        };
+    };
-- 
2.30.2

