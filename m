Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED132462F01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbhK3I6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:18 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:5857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239881AbhK3I6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxjpKLKex9Da/qloYh4FHeNbMXduJUv1bPG2I28aN/XaxREWDBJ5Ml/3BeXxp/CERi4DtPgcIQ8U0zwrPfmA+Fr/RJmn0r36xWy4otoDt+oSowedjDRBbRmI/CPyuXz0PksYVNxMXFPTcGglljsVY2Hl6bvunTd1w6d5ulN1LkbdKJ19TT7m0q7MiCXC+tyPuYH/8Hhaxt5fxe088CkCCL0RsMEZNbWPch7r95A5qpCTgrZOnZmbVuhZ9sUcBALnYVn8PvZvB4ficjMat5qdOVpvESd7UIOLA6gtpym3pwVfJRdTkvVE9W6JUxrhtcEqhczQh9XTQmwgTCdat1Ly3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FOa2arI1sddG8B5qhb+GRykzE+KyeniB8TwZdMqB4c=;
 b=mSF6P1LrUNznRxv2YaSJwtIJvCb97DEFqxlLr+/QBTBrzsPt3bKX5Ynb6xs9BtGfRtjER+pmOdCWQ90ueieythiIgJENya1h/s6H7RxXjFGcWj09ua3eU4Z8ac5qt1MDnxBpTBHlMmJRv54lBeRXCEU49xjObZzd560b8jBW3NqH4pCeOMqHGHQpyF17N6uxqEHgKxN2ZMJp1vPPBQVbOw4gUq0/RxEDINotOyqt3AgAOd0rjqxZ6ti1sPK7Ey47JAj9ROBX/vDqxBSKn65IWHm3qs82qMi4ftrJ9Lg3FBS24esnvRO6c50xGaxSwImNMhVbePpm/soG5vVDMJeZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FOa2arI1sddG8B5qhb+GRykzE+KyeniB8TwZdMqB4c=;
 b=A1+tHjYudyVO4W5Y3gRSHWuYJJyPLjheagg9R7B9b6FshR2wKyU3x4yY0K1hdUXjtXIWwaoMANqNvZZ/98cYA1nZIeScO0yRndgDJj9mS6JD9t9+DejrXPW+13wrAM2NOShPzcJ2Y5Mc9PoEqlda7u2lDJOCeeKhjFBC5I9yKWc=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by BN0PR02MB7870.namprd02.prod.outlook.com (2603:10b6:408:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 08:54:40 +0000
Received: from DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::74) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT017.mail.protection.outlook.com (10.13.5.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:34 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:34 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.6] (port=56576 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1mryuI-000GNC-Fu; Tue, 30 Nov 2021 00:54:34 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 1/6] drivers: crypto: Updated Makefile for xilinx subdirectory
Date:   Tue, 30 Nov 2021 14:24:20 +0530
Message-ID: <1638262465-10790-2-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b1d3a8-af67-49e1-2759-08d9b3df0afa
X-MS-TrafficTypeDiagnostic: BN0PR02MB7870:
X-Microsoft-Antispam-PRVS: <BN0PR02MB78705A44C56E25F8E854AB80DE679@BN0PR02MB7870.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGsqXw5QI/pmS1hfdsCa/nco9DvXkEFneT43KgaENLM3kovB0PhErrga5GvXdYFcP3b9rVmKbeb7gaPWrfo9fbiLklq0uMxNFdcB6byLmQ7KTBZs6CRYuE8mMC3BRo7uoIAf5rEEdRXRWnA2yfzFXsQFEGecBTan8W/S1nv03BuANUgrtmiC5d2VZUfWzDueBC84CBNYXuKG8ewnrP4p3QyVmU5+5DptMlNQyChINaWfetthrk0tIdeeANsRC1D6hhQRlFYKLdh6IOfiebyqEk4okNfvO+1133SrpaqQAtPY+KSLWjBLa+qml8ODmMz96UVdDjWeYCIjSepGwgzB3ZAn1+4MR9gbQdWjZku4gSjoTrW1AMPDqsFwSPoP9dVSwzfg++gXpI6YizsfQLx7CWwApvebfPLNakeIiJcpreb75T/IBR1Q4aB5fCFcLNZqJYa8g7NhiV2VPbdQjn/FIRNYfF5sjs9zRGoWN5IYl4raFVfgJ3O97lwHiM0y+S/TCbMNRrzPpUIUYDdNGt6i0dYhuSqrb3z7J0eUbviAnn46Hdlx4f4KK/rTK2hu3xyxAtZiWBFVNRhOCl19HYNKKBrMScd8BqSNPRXD1pRyUEnW1FfSfvwkliP7SB/L0iO9JR8S17bKeWqBC389q1lH7Fp/C3G7F1Fkfutpk5EuwtHw5Y8m5aaVQiWjFEBjyLCgjpxFFmHSsv51ys3dwgVgyjvqT2sFo09SiqOCDcCqlyY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(9786002)(2906002)(70206006)(336012)(70586007)(356005)(316002)(426003)(47076005)(7636003)(83380400001)(15650500001)(2616005)(107886003)(110136005)(7696005)(508600001)(54906003)(8936002)(82310400004)(186003)(36860700001)(8676002)(6666004)(4744005)(36756003)(5660300002)(4326008)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:39.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b1d3a8-af67-49e1-2759-08d9b3df0afa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the Makefile for xilinx subdirectory.
Currently the xilinx subdirectory includes only zynqmp-aes-gcm.c.
Since this patch series adds zynqmp-sha.c in the xilinx subdirectory,
so the Makefile needs to be updated.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 drivers/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 1fe5120..0a4fff2 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
-obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += xilinx/
+obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += keembay/
-- 
1.8.2.1

