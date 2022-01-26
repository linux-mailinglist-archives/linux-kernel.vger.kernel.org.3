Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6649C1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiAZDKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:10:19 -0500
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:30597
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236821AbiAZDKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:10:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TStb0UTJGPQYxUcDxkQz2wILgXZ5HYoXxSk5yU26+DFH/UOsIfFcuDzpT2uBMh2VM4AsU+bvpDKgcd3qXmy6YPbKaRPYrOcFRkIoSNq+MMc4+YlLeo3MiTRbMT+vtKhuRZ3bmRbhGA+AChI/ArtbGWGHnEiZEoVnHIVhBa6IzJP5RUwp1E1tpJsojTKCtY+nvbNNrzCnF+fUWOXj8agLi7d5cy+rATgE405jhd+DiUNbMs+kQbT9jPiiAHVOm0YfN2IAXZKkc1K/TeCG0Mdc7AmAh0TFUspc4Q/dqjNF9rSA6euAjHH++EaKFtAjmaqGSyLXSl9uXFRM0BEeG4UUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=WZb55wpWHk6lCKfjokHWH09Ogr/tE08LN2yRNJKld7FlcSm4euVyAx/WQL3CEia8MSnxMgUK0QTBealfm9m7JebItr29gwbpAVw/ePZYOen+BfzeiCPZLZyXPWS/GR98AEoPFLcRp8fwBHVaL93fZwgfaIH23TQlr8Eezm+adyXIu80e5DyYpqddoIovIq5g7QLmZOxST2llwwFlbddkg9qH8T5+VmkbDkY7+VcvcM9XB7YF1vT93j0mjLHCsA5/66XSfJIgmwR4aDx0NOUf0yGgTax/7BtH7msxNZgWdl4rs/wMEgsoOldXwL62Q1faSKROSZW/zsbI4j9pBfzvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=m9eIzqCcq3UeOlLcdXLI91dU/Y47gBhrgO/jym4zhmwuHkFzxVK+IT4MbRiHFkeltM78E/fkImxBlF9+l4+/zQPXhKPlmO6bkWcMlbACoXqDSbSrQvip25xO3bpgNigBoYZSDqdHy+YdXgx4Zzr+Sn1/7Vhhn1uJk9KXlGveExk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3319.eurprd04.prod.outlook.com (2603:10a6:209:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 03:10:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 03:10:10 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15.1 01/13] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Wed, 26 Jan 2022 11:09:20 +0800
Message-Id: <5dbf63cd1f73be49d45126393a88a1968de7d73e.1643165765.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643165764.git.ming.qian@nxp.com>
References: <cover.1643165764.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0091.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac321ab1-739e-4189-7cb0-08d9e0795ce7
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3319:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3319538F219E8B3163AD0DDAE7209@AM6PR0402MB3319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqzm6eFt4rrlY5cXwqKJ5xVe4uNF0mbZjG+yXsO55wMSxqIbePUOgurFGehOmpTc1rDZIlx1s6HQvV270HjcLoN6Vv+dK2p9aSum9dT6gjXnNSw3166e3unw5qGaXmndmTImWzz0Cexxe8J3EpSRP6L9DQN+SIEKkvI1o7829796QfUw/eskj7WHFFafhw6IH2KxWcR1qoOtdr/1BuAx1B1rIscQrJZyqdqfH1Z7HcPuGiiWzxvhwwBgruB8AKLxQM+mWx1hABUZAxkdLt4PRpjRB541TtIgb+oLhI4VGST6RcV6of18Ofsa+eaB5LbhCI0JNWnOoiLXag1CPmpJMXdnUPH2nGXJ6gXfZj4Unmr+/TPB6BlGZuFomqQ9emmfP5TSuwtwDltWjxHgdUnlrW/exwLsA52whe/QLTd+eVdXgz6aod2vvQCZXUBcYFn8cFiNQ4VCvCsNUf0Ds0n2a4O3P4nHn+dHgn4BOThyKC7GnbkF1I1WvuwnBxm8cdmLNd+vLgSzbEoTo1J7tisXuY9YhuX0xue9LGY/JrCONSNHefMZ6ta/7P0MU/LUvCrGHO692YLJk/iRrlENrRtKh/cIC1/0vC7nxMKVgbRXujJe00V9iSKQlaAFjv+nRcWaQHwIctkrQ/lrTjT6EmOp7r5Yv0aMqAwd6FT7bbcGHv0SmWZFXgNNDFLuu78H7YmOUm+90UJ57OtaUgnQV4CcMdKQBYbkI/KPDTouXWruDmOm67U//PbVbBA+XceSMNCaxN9/qHmlXx0ilHRT6rUDdwLSLiormqOxb1HRwUarjPZ/uLZJTV4G8iwi1pvXc4N9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(2616005)(36756003)(316002)(966005)(186003)(26005)(6486002)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(86362001)(52116002)(6666004)(6506007)(6512007)(44832011)(7416002)(8936002)(38100700002)(38350700002)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?80O2XJQznP0lio6CpK1tqZ+Ww28ZSuKj1Pj3Kb9JPorCLlCS/YQ5AZkQG8Zp?=
 =?us-ascii?Q?UzrofjO+Vrt9wd3Ia5i+x85GsYHpX6ZoasXI+IWcVoAnVeHtNLqZ0lYK+1Qy?=
 =?us-ascii?Q?yHV4+FqWg+xz3QkM2J0C8MNmX9EvOMe2QlDR51+BYRsgbgnN0SvY2GetQRIk?=
 =?us-ascii?Q?9OdyhCEehAxRBqV0tP5ARcnJBC5+x5BKnLgjOhxqOqap4uP6+Dr2i7yIHnt9?=
 =?us-ascii?Q?LdWShDhYgOYBXsSYq7C7oDTx6oia+5/5rvviDjyfhlYDCfyPVIiCdd/RlOuw?=
 =?us-ascii?Q?DJOTtIKUZCnzR8T+NDJuFvEZrYGWnEP3y0XehJu1GU+t5Ib0PLeoumsLOQR2?=
 =?us-ascii?Q?b3wIB2fOcg6Ybe9AMbDk5DPmdALu7C8Ai4YzHkET/DnIXQJiRB8Wn5uBX7jk?=
 =?us-ascii?Q?Q/Naq3Ynzaasu072GA9ZTl7+W4WYoho1Cyekg3nwnF855hjp2A7c3NP60Ws2?=
 =?us-ascii?Q?ar3luW2XxohIZbfOuKXeSQ+ZUvdTERSZin+SEtjTT2K9UgnC7525U6H/fZrC?=
 =?us-ascii?Q?kRfBIqMTmGmPzc4Mtj0hqoLqRcNkCXs9QLjr0nqSK3OjpjXuiKWW3d605SJ3?=
 =?us-ascii?Q?m0lpUF6sqfyHv5GWiobIUxK5laYvfomyTKswFUMhVlW7FZ+GJ3F/KUWrChwS?=
 =?us-ascii?Q?9nG9fTSoe0BsVH9E5GQFiibUj4wLJdgMpXZ1nIq9H7nHciL73m91dueZhcHH?=
 =?us-ascii?Q?05JlCIOBOZU2AJQSIJikzsj1iHGTxyuXlr+zEPXVnBaUqXgCyYsdr9LLSctX?=
 =?us-ascii?Q?ZbyNn0RY3+0/Lmwcq/+6nSBVv4JXBDHWJQzzIctuyeLUdlu/GaBsg2DOtbKz?=
 =?us-ascii?Q?svWTeUZEUr7vEJSM1q61y90NEpkXqml3AbYoEiygZ98OaPqb7UjAP1iiZtQ2?=
 =?us-ascii?Q?g8jwrzQZQ0HSLqWFqaUzkLGFNOMNmPYrO4/eVyaq5Ri1Y7G5ejVur1tm3avn?=
 =?us-ascii?Q?snMtrP6VVPGLviy9FZYbGLXydlRncjVeeDPjyOqdGrbpWslyw0KhR3sMfYwo?=
 =?us-ascii?Q?rN3waaQmhnThjag/p4c0kC2CckuAsL1mW5xT3xRhX9ZlCPciIoqQsSowGsZC?=
 =?us-ascii?Q?wwueuLNG5SdsGqZ1lXT97bRl1yUGVrMqC1qB0RlSk6OYFkByFU9hgUpJzZz/?=
 =?us-ascii?Q?4eZJIfzfatD0blwPfc+qdw6/0L3auBT5fB9eqavTL+tVpYDwktpZRYlERKAh?=
 =?us-ascii?Q?IRZQEHMWMNJmOHDDr8kU/2QQAJ5ilSTYt5g5sWHymtZk2UsXqMsRq5tyB4E8?=
 =?us-ascii?Q?Pztof/l+8S2icOUaNcHYgBawS1o4cgPqcQCWz5V3t3qByEbOdZ1N5U7wcF5E?=
 =?us-ascii?Q?Tg2gKfZoqBUZ4wL4EmKUPS1Bz5wsgIzEEIHTJO4iCdKX1XBILLspP423E8C2?=
 =?us-ascii?Q?yBcWDkCD7YYqOkM6fkI32Pou+Xw4C8jWRv9aRB4d/w6AkSJs7Uhrv36lhNrs?=
 =?us-ascii?Q?Ffpl6h0uTP430F6Xz87wrq8KXwXP2/ja/Oq9nG21afyt0Af/lQdwdk6PFSDI?=
 =?us-ascii?Q?zAuk3UtBcU3tsCyG6c4cwpBbsWfsgf6VG5LQjWW677LLD2t2MQTXHO3ZwJ3Q?=
 =?us-ascii?Q?3FLSQmIuxbsauHVax7vymv0hW8nwtfCb0wZXkEfcP7NpaBWzDz7GOW1SrRhG?=
 =?us-ascii?Q?piTjm/T8CPd2W9dcOiP7mYw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac321ab1-739e-4189-7cb0-08d9e0795ce7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 03:10:10.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGblWHMnTDRffWAN1EOAbrb3rTfpMPk26xedm4r9Adi7hrfIFEddL4GknnJcVtw9oz/aZ455KuGCr78bxEYmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for amphion
Video Processing Unit IP presents on NXP i.MX8Q

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/amphion,vpu.yaml           | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml

diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
new file mode 100644
index 000000000000..a9d80eaeeeb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/amphion,vpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amphion VPU codec IP
+
+maintainers:
+  - Ming Qian <ming.qian@nxp.com>
+  - Shijie Qin <shijie.qin@nxp.com>
+
+description: |-
+  The Amphion MXC video encoder(Windsor) and decoder(Malone) accelerators present
+  on NXP i.MX8Q SoCs.
+
+properties:
+  $nodename:
+    pattern: "^vpu@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - nxp,imx8qm-vpu
+          - nxp,imx8qxp-vpu
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^mailbox@[0-9a-f]+$":
+    description:
+      Each vpu encoder or decoder correspond a MU, which used for communication
+      between driver and firmware. Implement via mailbox on driver.
+    $ref: ../mailbox/fsl,mu.yaml#
+
+
+  "^vpu_core@[0-9a-f]+$":
+    description:
+      Each core correspond a decoder or encoder, need to configure them
+      separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
+      has one decoder and one encoder.
+    type: object
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - nxp,imx8q-vpu-decoder
+              - nxp,imx8q-vpu-encoder
+
+      reg:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+      mbox-names:
+        items:
+          - const: tx0
+          - const: tx1
+          - const: rx
+
+      mboxes:
+        description:
+          List of phandle of 2 MU channels for tx, 1 MU channel for rx.
+        maxItems: 3
+
+      memory-region:
+        description:
+          Phandle to the reserved memory nodes to be associated with the
+          remoteproc device. The reserved memory nodes should be carveout nodes,
+          and should be defined as per the bindings in
+          Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+        items:
+          - description: region reserved for firmware image sections.
+          - description: region used for RPC shared memory between firmware and
+                         driver.
+
+    required:
+      - compatible
+      - reg
+      - power-domains
+      - mbox-names
+      - mboxes
+      - memory-region
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  # Device node example for i.MX8QM platform:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    vpu: vpu@2c000000 {
+      compatible = "nxp,imx8qm-vpu";
+      ranges = <0x2c000000 0x2c000000 0x2000000>;
+      reg = <0x2c000000 0x1000000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      power-domains = <&pd IMX_SC_R_VPU>;
+
+      mu_m0: mailbox@2d000000 {
+        compatible = "fsl,imx6sx-mu";
+        reg = <0x2d000000 0x20000>;
+        interrupts = <0 472 4>;
+        #mbox-cells = <2>;
+        power-domains = <&pd IMX_SC_R_VPU_MU_0>;
+      };
+
+      mu1_m0: mailbox@2d020000 {
+        compatible = "fsl,imx6sx-mu";
+        reg = <0x2d020000 0x20000>;
+        interrupts = <0 473 4>;
+        #mbox-cells = <2>;
+        power-domains = <&pd IMX_SC_R_VPU_MU_1>;
+      };
+
+      mu2_m0: mailbox@2d040000 {
+        compatible = "fsl,imx6sx-mu";
+        reg = <0x2d040000 0x20000>;
+        interrupts = <0 474 4>;
+        #mbox-cells = <2>;
+        power-domains = <&pd IMX_SC_R_VPU_MU_2>;
+      };
+
+      vpu_core0: vpu_core@2d080000 {
+        compatible = "nxp,imx8q-vpu-decoder";
+        reg = <0x2d080000 0x10000>;
+        power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
+        mbox-names = "tx0", "tx1", "rx";
+        mboxes = <&mu_m0 0 0>,
+                 <&mu_m0 0 1>,
+                 <&mu_m0 1 0>;
+        memory-region = <&decoder_boot>, <&decoder_rpc>;
+      };
+
+      vpu_core1: vpu_core@2d090000 {
+        compatible = "nxp,imx8q-vpu-encoder";
+        reg = <0x2d090000 0x10000>;
+        power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
+        mbox-names = "tx0", "tx1", "rx";
+        mboxes = <&mu1_m0 0 0>,
+                 <&mu1_m0 0 1>,
+                 <&mu1_m0 1 0>;
+        memory-region = <&encoder1_boot>, <&encoder1_rpc>;
+      };
+
+      vpu_core2: vpu_core@2d0a0000 {
+        reg = <0x2d0a0000 0x10000>;
+        compatible = "nxp,imx8q-vpu-encoder";
+        power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
+        mbox-names = "tx0", "tx1", "rx";
+        mboxes = <&mu2_m0 0 0>,
+                 <&mu2_m0 0 1>,
+                 <&mu2_m0 1 0>;
+        memory-region = <&encoder2_boot>, <&encoder2_rpc>;
+      };
+    };
+
+...
-- 
2.33.0

