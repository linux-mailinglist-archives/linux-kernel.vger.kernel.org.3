Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D447462C61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhK3F7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:59:31 -0500
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com ([40.107.96.42]:31678
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238403AbhK3F7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:59:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmQ1mXvP8zvpEpPZi9Aq4fMRV75K7+i8lBofbFw9hht4KWmTTi4oLV8CZOC8fgSdRE/xUaR+rtSQqCpI6+o58Fru4/lXKVp6k1N9ukL7uWC3gLOyTchGzEqJDNCT12DvR0vdykfYQC0kGadFazXjaofgrvFbl+aKmQtX/55Q9ErPFZW50v/IZ7LOKyGm33aBbWQ9BWI048bCNGUs8efODQpvVNNkORaPyR0/YAhYV1MdNJPYOHmrxtdksZ5WwHqDpG3nlf0WxOhJhucege08FGePik2d9fWY0CJ04dPtW28nbpFmaRNTjGlgfi2sbK27KVvsvEMXLrqSua4Pe3OEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw58orXmySlJH9h0UsHdhVMIzs9kGqLTrYkmivZQG9w=;
 b=LkQu3Xrz8rck+9uf00gilKlfFAdZ5z8inD9qC/q36IOj+TuhyDp4eXPL0YiUle8CF+0rjLysC3fWU09MqzvFtwEmmB1i2Rw+6AdKHdC9f6fzgC20dHmWV/NEtmSxAjQqnb7vdaRT9CUuQPtadTyj8pp8pJ+RcmXbrvi60clgrMRmstAp55sKnQsAg1KvJFk/zBlLgbzBuzqtjY/muJCgkkfaPnsXMVFwi1m1cVRrlJMoRBbCAg2lzDOr+m0jcLoawhYFYiXnIRs1FDBppnmUgXeW9xz3rOZBG+VgC+QQOKAEkDYvZuFtgYvbT2UofV2s96BL9KKf/om6ALSXFf9Keg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw58orXmySlJH9h0UsHdhVMIzs9kGqLTrYkmivZQG9w=;
 b=IL0PS564cnef+1D+1BBV94uLuTe7uFqmAQUudn/hMO0I14BUlIlKFV9WYiTcSMVbK6R4688mIH7/GEi2ZK5DEtEpF8S+hvNjAsuAbH3DrEjFZIVyx1VLVNNn5YhS0Ig53PyukQ8VanmNwE8NbwkfA3a4Jo4N/gYCE6UqX+QNIzs=
Received: from SN2PR01CA0045.prod.exchangelabs.com (2603:10b6:800::13) by
 DM6PR02MB6329.namprd02.prod.outlook.com (2603:10b6:5:1d4::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Tue, 30 Nov 2021 05:56:09 +0000
Received: from SN1NAM02FT0009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::43) by SN2PR01CA0045.outlook.office365.com
 (2603:10b6:800::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 05:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0009.mail.protection.outlook.com (10.97.4.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 05:56:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 29 Nov 2021 21:56:07 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 29 Nov 2021 21:56:07 -0800
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=57772 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1mrw7a-0005MM-IX; Mon, 29 Nov 2021 21:56:07 -0800
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>, <radheys@xilinx.com>
CC:     <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V3 1/2] dt-bindings: rtc: zynqmp: Add clock information
Date:   Tue, 30 Nov 2021 11:25:40 +0530
Message-ID: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1368b707-ef33-4339-a392-08d9b3c61ba3
X-MS-TrafficTypeDiagnostic: DM6PR02MB6329:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6329196258DAF9BC298D9C9AAF679@DM6PR02MB6329.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KHuuawqXq/5Jsdkj8w4lz7K6tkc42EOKazLnxpv0tCdR5MlV29xEMUjGhFFK6vtyEDq3m1jXBRpge+Z9HXidvYX3LmNKojOOIOLuFpJjMT26dQnx+52aV/hMH6xKL7Xb6NvyEFtHPg6SkkO2/LKvhE/pmEWY9ZVDU1uYBzJ6RCvqD/UvpR/XSczx1mex8PfdTwubJCnh5xC3Rj49rRHRY4xjYgX3WW1VJ6EishVjYohQ0DAVfLZWwMwA5IzVDoVt8DC5pdZuvpOhWktKGs2Lx64g+A6hlF40bO4t0zt2M9RyEiwkHDR8MlzOkU3XDoNLr8Ut8yeshqqcopGzxLGVs9LnVjSLWr1WkO8ya3RK4xZdXPH4cFY3bsyilDKem8buB0zGcFB6kGk7AhgSDPAdaywrArPH+YhxjaDnUhTY1s/ZG3ENf/4Zdxb0JJvDr9sgH4UAo3GrmAsqYGyX1AVyGPlcu4xkrR8bnWJhqrUMfHHoayitwk85tDrFzu1Ll4Y8HEQX8hfZ9u7xU67bB85UgqUbMjsMegRXJ54ePD1tI756qK25vHw8ywRxFTD+3RPNGLJbehOx+QD9ZCt0AxVdq4G3uzE60s8+c94UAbVYq1nt1viL5Ckm/444phLGKwVtitHzGWdWjRcbCYJkLafMlNsQ2CSKSHtiA/8geWZrFpM9Q7McLPEZeIIGXhKmkqz7AQDc+9cOd92jIVG1e1G2AISXVQk/oVo3ownuXzAILqd9xK8jD2/mU8dcQEWobug
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(110136005)(54906003)(356005)(70206006)(44832011)(36756003)(7696005)(2906002)(8676002)(6636002)(107886003)(8936002)(316002)(70586007)(9786002)(82310400004)(36860700001)(508600001)(5660300002)(186003)(2616005)(7636003)(83380400001)(336012)(47076005)(426003)(26005)(4326008)(6666004)(1076003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 05:56:09.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1368b707-ef33-4339-a392-08d9b3c61ba3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6329
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added clock information and deprecated calibration support.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
Changes in V3:
-New patch
---
 .../bindings/rtc/xlnx,zynqmp-rtc.yaml         | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
index bdb72d3ddf2a..7e87bc1ef9df 100644
--- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
@@ -26,20 +26,19 @@ properties:
   interrupts:
     minItems: 2
 
+  clocks:
+    items:
+      - description: rtc_clk is the operating frequency of crystal.
+
+  clock-names:
+    items:
+      - const: "rtc_clk"
+
   interrupt-names:
     items:
       - const: alarm
       - const: sec
 
-  calibration:
-    description: |
-      calibration value for 1 sec period which will
-      be programmed directly to calibration register.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x1
-    maximum: 0x1FFFFF
-    default: 0x198233
-
 required:
   - compatible
   - reg
@@ -60,6 +59,7 @@ examples:
         interrupt-parent = <&gic>;
         interrupts = <0 26 4>, <0 27 4>;
         interrupt-names = "alarm", "sec";
-        calibration = <0x198233>;
+        clock-names = "rtc_clk";
+        clocks = <&rtc_clk>;
       };
     };
-- 
2.17.1

