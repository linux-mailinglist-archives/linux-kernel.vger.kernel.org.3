Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9290A53AAED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356094AbiFAQVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356075AbiFAQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:21:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271CF71;
        Wed,  1 Jun 2022 09:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD62uRApJBWnyRW37rzh3+P2qRHqUfIyP9k6aZtdi8rtayVaniEdKJGsBBV36INVb5r4ZQqyXQN+Jm1jx7wUGjkZLfI61322Nct4aPZ5Vd+eKBhPNJKv20ND9dv3Fwf9ZZogmfTV/KMEybNrGeGGUczJmmiS+jOwL8OI+RMttX2caomgpISso1JdILIne4R9hT67/plxMPaBhwEUM1jLcj2T71ud0cGv6zZTzFAjCWKgdS7Bno0HrEuagVZHKb8G3SR10jEhGOJLxPE1p4D37tWim2LnUYgDt1s8h0Z3wj4d8v6DyAhAG8Pi1n45dTSqEPo0GdTkhv6nVFAt9WxvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8nYALWdi2VaD7LQsvqKvBKhSrzLHMBaxT2zxG9NCkA=;
 b=dFrGUGT2q0ntOiqxIQozA2lY3Ld4M8gWyYpzM0o1rpJ5S8LO3BVSfkfGblSQMsOzgQJV8zn6kMQP1b0LUU2zuA0ra7+lYdQv06tro/eG6OAIFT7js9Uku4XHdxPAcgt5dZHcfXikd7j4tQOm3iKeKnW/E/Id5h8gC7TO0Q64lGBPCnFqIgfb7wXlElqeNhFccNXlrlN2H2fudCpQmK3Jryhib/djg8gt0hZR8JzEo82dhvy0co1RLC5vo8SDVEb/dRoFCzLzZCTRq79RBQcj6sxl8tVa1jFswDPdfhTOGfEDu7GknSVUb4gZvb1y+sFA/x4AyGVXZ495o1jzerV5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8nYALWdi2VaD7LQsvqKvBKhSrzLHMBaxT2zxG9NCkA=;
 b=L7lulCbs++c3r7e023TNhj436NQJVx0UL8kIV8KkccRo8ZPrWVFQ/gyrSpW3NQHhBFCN4fppkxg2uEXjMp5TzoJ9UZgcsbbhL0mjYlnvqy/kBrRfkIPT2PY/WfP+vNxtFoohDNDfg3wAgjHy4SZNI+cB0jjcz6UNLz2zz31DZDc=
Received: from SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::13)
 by SA2PR02MB7530.namprd02.prod.outlook.com (2603:10b6:806:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 16:21:41 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:123:cafe::6a) by SN7P220CA0008.outlook.office365.com
 (2603:10b6:806:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 16:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 16:21:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Jun 2022 09:21:38 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Jun 2022 09:21:38 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=50642 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwR6I-0003Rb-Cx; Wed, 01 Jun 2022 09:21:38 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Wed, 1 Jun 2022 09:21:07 -0700
Message-ID: <20220601162111.3505458-2-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
References: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69ac61d5-1345-4619-8abd-08da43eacfbd
X-MS-TrafficTypeDiagnostic: SA2PR02MB7530:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB75302E967950BA73279AC719CADF9@SA2PR02MB7530.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN2TQCBlNcFB0F/J/iUq9WeOGpw5tL/M/Fp2FOmpPAXN9nSLK9PDL7aF/aoOgTo/uBwKSAm64/+R14bmIMoTXhcoDr0XLfujjE9DCIwxKe195o53JB3aDEzkcIrAN0kPl28TMzsIoPl5Dyp/V1lkXMnpp02sk4LRug3LljxmP/cuZAWGJ2gSGM7JXpmWGDvzy456ZNxajx1e5aYxvAN1eeTLsaaU6gglaV8dcIgLk9ynmOyM24au4UeDmYbZI8V2PyweFde0AVqh13oRN6tkGnhv5wemuYvVhBnMTpY1GTEYMKyYA+R8ta+M1e6Rjo+Mzrpt2fkgGLVyRCg1f1/zE99YDIMW0WTSOXNV6KWu2Xx0HPVGP7yWvAZQ8exhlT04l3/4IfB/H0aqDexrci5KznNcOvsed/Py4BDHyGWxsXhA3RzPiGcy3EDzWnr2PuucNBTdZfNdgXdELDiS7p6QR4g8W2MRWnnodG7pIdQ6x46oQ17a6e80Atv6qd/OtF0SdzDMzNEXtsTAs9fxQw8KKie6h4T71ggOsB7Rle5be0l45lsEYZTYJJ/zS6hu/rDaZBeBqBD16Y5iVD/wbPqh6J+7I/wmI40hZrCqlhMliC3aDuJEJyiD4kXi7ZvlLv5VGmnJElpGkN48K7uXGoXVy8EO5Uqji5wrl+NpR96g89DQAmml9UXAAtR0JfbgqknmVTdgmqAruavvEy+yJmv4cWJWUI6IDXmkCBB9J6VQ4dWRa2+ftSkHiC+6/HgU6ygHCyuDYMKC4s6hVZ682iNo1ed/iEEYYAY8Xan3r9Pju3d8kOZlUDfQlAFik48XV1GkE26JvjRGPUtgZr/ISTclSg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(336012)(2906002)(1076003)(8936002)(6666004)(966005)(9786002)(186003)(44832011)(508600001)(5660300002)(47076005)(426003)(7049001)(2616005)(7696005)(356005)(7636003)(26005)(70586007)(70206006)(8676002)(316002)(4326008)(82310400005)(36756003)(54906003)(110136005)(83380400001)(40460700003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:21:41.2279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ac61d5-1345-4619-8abd-08da43eacfbd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
(cluster).

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v7:
  - Add minItems in sram property

Changes in v6:
  - Add maxItems to sram and memory-region property

Changes in v5:
- Add constraints of the possible values of xlnx,cluster-mode property
- fix description of power-domains property for r5 core
- Remove reg, address-cells and size-cells properties as it is not required
- Fix description of mboxes property
- Add description of each memory-region and remove old .txt binding link
  reference in the description

Changes in v4:
  - Add memory-region, mboxes and mbox-names properties in example

Changes in v3:
  - None

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 130 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..89ce9ec10163
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx R5F processor subsystem
+
+maintainers:
+  - Ben Levinsky <ben.levinsky@xilinx.com>
+  - Tanmay Shah <tanmay.shah@xilinx.com>
+
+description: |
+  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
+  real-time processing based on the Cortex-R5F processor core from ARM.
+  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
+  floating-point unit that implements the Arm VFPv3 instruction set.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-r5fss
+
+  xlnx,cluster-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    description: |
+      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
+      lock-step mode(Both RPU cores execute the same code in lock-step,
+      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
+      core 1 runs normally). The processor does not support dynamic configuration.
+      Switching between modes is only permitted immediately after a processor reset.
+      If set to  1 then lockstep mode and if 0 then split mode.
+      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
+
+patternProperties:
+  "^r5f-[a-f0-9]+$":
+    type: object
+    description: |
+      The RPU is located in the Low Power Domain of the Processor Subsystem.
+      Each processor includes separate L1 instruction and data caches and
+      tightly coupled memories (TCM). System memory is cacheable, but the TCM
+      memory space is non-cacheable.
+
+      Each RPU contains one 64KB memory and two 32KB memories that
+      are accessed via the TCM A and B port interfaces, for a total of 128KB
+      per processor. In lock-step mode, the processor has access to 256KB of
+      TCM memory.
+
+    properties:
+      compatible:
+        const: xlnx,zynqmp-r5f
+
+      power-domains:
+        description: RPU core PM domain specifier
+        maxItems: 1
+
+      mboxes:
+        minItems: 1
+        items:
+          - description: mailbox channel to send data to RPU
+          - description: mailbox channel to receive data from RPU
+
+      mbox-names:
+        minItems: 1
+        items:
+          - const: tx
+          - const: rx
+
+      sram:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        minItems: 1
+        maxItems: 8
+        description: |
+          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
+          the RPU can execute instructions and access data from, the OCM memory,
+          the main DDR memory, and other system memories.
+
+          The regions should be defined as child nodes of the respective SRAM
+          node, and should be defined as per the generic bindings in,
+          Documentation/devicetree/bindings/sram/sram.yaml
+
+      memory-region:
+        description: |
+          List of phandles to the reserved memory regions associated with the
+          remoteproc device. This is variable and describes the memories shared with
+          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+          vrings, ...). This reserved memory region will be allocated on DDR memory.
+        minItems: 1
+        maxItems: 8
+        items:
+          - description: region used for RPU firmware image section
+          - description: vdev buffer
+          - description: vring0
+          - description: vring1
+        additionalItems: true
+
+    required:
+      - compatible
+      - power-domains
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    r5fss: r5fss {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <1>;
+
+        r5f-0 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x7>;
+            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+            mbox-names = "tx", "rx";
+        };
+
+        r5f-1 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x8>;
+            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+            mbox-names = "tx", "rx";
+        };
+    };
+...
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
index 0d9a412fd5e0..618024cbb20d 100644
--- a/include/dt-bindings/power/xlnx-zynqmp-power.h
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -6,6 +6,12 @@
 #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
 #define _DT_BINDINGS_ZYNQMP_POWER_H
 
+#define		PD_RPU_0	7
+#define		PD_RPU_1	8
+#define		PD_R5_0_ATCM	15
+#define		PD_R5_0_BTCM	16
+#define		PD_R5_1_ATCM	17
+#define		PD_R5_1_BTCM	18
 #define		PD_USB_0	22
 #define		PD_USB_1	23
 #define		PD_TTC_0	24
-- 
2.25.1

