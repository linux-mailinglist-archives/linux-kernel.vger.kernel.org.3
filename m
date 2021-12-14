Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234784748AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhLNQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:58:51 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62398 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236167AbhLNQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:56:44 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEAJOq1019150;
        Tue, 14 Dec 2021 08:56:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=hOKZUOF4C6PO4NjAEkho62kt5XkfzxJYZTEgYJFYSd0=;
 b=aKnfkzOP8R6b21ZeQGiXHuRj6ERPSn8njE81Gd+s7Di3p7FpRJUYYIsdaMWxdLahg8G9
 wOfPNXgVc4JdjQBF6jIvv5NCA5V2zfAdmYzYiTn/eiMKAuQNG/L4N87bZI+ores4tono
 WBJSePK0dqryDQpaFHOWPRCwVHP+qVbVm6lNlU0KYGmrFLQUXF9G4WyrOJbvjkky6usW
 PS7HWNoFQXSbMCjdYGv/i5V95J/q+BXrNtbw0BfX0su67CLbLxjhkS7sDiR81DI+Qzuk
 bTPNZEJnmIWsob/AMYYPFineD3+IGbHmzOGynCh/HUaAaOKM6YddvK1gJAuy3Wd4uDQC 6g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cxsds1mes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 08:56:28 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 08:56:26 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 08:56:24 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v7 1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
Date:   Tue, 14 Dec 2021 22:26:10 +0530
Message-ID: <20211214165613.26479-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214165613.26479-1-bbhushan2@marvell.com>
References: <20211214165613.26479-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: poXFa19hffEPeLHX3FjY0pRxoWFJOJ0r
X-Proofpoint-ORIG-GUID: poXFa19hffEPeLHX3FjY0pRxoWFJOJ0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell CN10k DDR
performance monitor unit.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4->v7:
 - No Change

v3->v4:
 - Added Rob Herring reviewed-by
 
v2->v3:
 - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000

v1->v2:
 - DT binding changed to new DT Schema

 .../bindings/perf/marvell-cn10k-ddr.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
new file mode 100644
index 000000000000..a18dd0a8c43a
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell-cn10k-ddr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell CN10K DDR performance monitor
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - marvell,cn10k-ddr-pmu
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@87e1c0000000 {
+            compatible = "marvell,cn10k-ddr-pmu";
+            reg = <0x87e1 0xc0000000 0x0 0x10000>;
+        };
+    };
-- 
2.17.1

