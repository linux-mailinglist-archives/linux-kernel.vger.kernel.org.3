Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72B6462F13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbhK3I6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:41 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:22753
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239938AbhK3I6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA0xc1Bl7GJCdT7vGJok5d/OI5TcWOhGhtqclUH1JkUTPFoXIwKnCBEh9zDC1m2MUfUmfJFQ63ca9c8dB+chUgKn3qyN/5YDYnQDNCJc1hCUF7vZ29TDUHqWo6YUcM6xjMOqZWngt7zdBZQyS1BiC1ZIJlBRghvuT2j4ToZbzcn5DfN66DDJtXzfddUL8fnRLox14AwQdtPxeB5MNs4ZrQ0dwwSwlns9Uu8SFSumCT9j7VrTfD0dqWz1Ym6TmKdvFR/hdLW9Ja9lafKAMTa9Zf980T1RNSJgSh5peZtJa03eswSIMvJP41ZqcOd3tmf8P78Es4AMfqU1CD3Yl5tnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zchr9qtFTVfWWBTMlnpMtU22iPnAg2wqGzsXMDM+23s=;
 b=FUscyfAYiSDTD0Uts1O+CyDTDTQStDivHsxFJpYq25Klf/I+pHUEbp05UM+lo3rBjq5sTfeIWgF2LRau2XfddNzdEUx9cJPiMH+l60gQOF0m7WuKfVGmjyR+yIDlndmeVxyE9so5qSSPzge0CL0Jig1Ski2ySjveipJay1E5NoLdbPA5tehg58uRNBBJqPP5IP4uNyOIvh0Oh5Irr9G6wirMRKyOHVo3oLPfkvQKvwnel37jSWMxXnt2sQdh67MDehasdvFvVNqGdBSURYU8VKx9VcbHDU6atpZHY1Xl4tTdHwhLzy/2/TT2DO/HfWjVyxholKw2KAJBM5Dkbq8TMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zchr9qtFTVfWWBTMlnpMtU22iPnAg2wqGzsXMDM+23s=;
 b=ICiPkDDKOHrhlFzon/4NKnIW86p6pDQaoBnGUbl7CEDsmjjt8WohRs/VWpHULZ1kX/U4Ild7cOGOR/w7+HDUGWRpQ1NZ3nDEvj8S4bipNCemDvrBh8V3y8deibFhs06ihEC/WKrAKHZERjJG+TdLfcosvN3OmohE26crigfuIng=
Received: from DM6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:5:60::47) by
 CH2PR02MB7064.namprd02.prod.outlook.com (2603:10b6:610:85::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Tue, 30 Nov 2021 08:54:52 +0000
Received: from DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::5a) by DM6PR10CA0034.outlook.office365.com
 (2603:10b6:5:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT064.mail.protection.outlook.com (10.13.4.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:51 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:51 -0800
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
        id 1mryuY-000GNC-Jw; Tue, 30 Nov 2021 00:54:51 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 6/6] MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver
Date:   Tue, 30 Nov 2021 14:24:25 +0530
Message-ID: <1638262465-10790-7-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac4a872-eace-4655-b278-08d9b3df125e
X-MS-TrafficTypeDiagnostic: CH2PR02MB7064:
X-Microsoft-Antispam-PRVS: <CH2PR02MB706406D10B1B8650A7BBEE81DE679@CH2PR02MB7064.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+mJE34W3AD5z7sjM1cOBtwQtfdB7XmN3OfHf3TzZ0nBRZ32fYMXXDzQ1jCmHxmzme7b7guQRZhV+iOsllsEBJDUY0OOjarZNRDWvZA8Vr46N6QIT/nu7EPX81Y4U2vREOOmVRrs9xKEzpr228IYbGIEqCIynm4+BlhtBi80VIL4KUwdWKX3CQD2b2h18MaVBORcN+va9zU7xjd+Z5jyCq+y2FBWPmKapq1OHuXXh406Czo0+L/gorDAUp2ZW06I/UcjjRoltlBLywoad8Cl2wkvlHJHWKC+QqZPk3opjaXaGP42164lop/oMpiDqcItThNIuEqsHMdcwywAb7fpsIze4iK0J6tRomfKEEqEjlXV2Wrs9VvPEbKs4eBRsn72lxFtHPe/x47wDU3J92dFd2//4fSkq21hZsYIAMHbVtJlENwycb28TUZnDPpPSM1TAwpfgUKYUJv8eNsAAKSUDnDj7TN1BgMzIV25kma2t02ePslC0ZU09VsNfOwFBbUPUhGBQDzRKFH4gmcqOHBonuaSKui7zTAFfSne6wAlssMTYInqxhoXG3xnR+qyFpgVMazMGKVDIJ60K/DxJ1aa4MiKyX8fv1Xl6fcNatvLet71S+r+Q1YsI4G250nN02RP3/4sQtWPsPbFEOBGCCx+eaGog+C3ypo4cCnZP+YESYRWWP6Ew7+2h1mcv5gwyOJ/+ZR62cBmoj+0/mdAld08lD3xFoEZ4nYAqHKoDEK+4h1dpSNfypw6d507N0SG3UVFsG9Vm/l6WmFNWY1Hq5FumgU4XYEA8vOiPMuI9UgECs4Mtg6mTpLfTH+8GudCAJau
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(426003)(2906002)(8936002)(82310400004)(70206006)(36756003)(4326008)(107886003)(316002)(110136005)(54906003)(70586007)(356005)(6666004)(47076005)(2616005)(7636003)(966005)(9786002)(186003)(508600001)(4744005)(26005)(7696005)(336012)(8676002)(36860700001)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:51.6001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac4a872-eace-4655-b278-08d9b3df125e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry for ZynqMP SHA3 driver in the list of
Maintainers.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0047564..73cc994 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20929,6 +20929,12 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
+XILINX ZYNQMP SHA3 DRIVER
+M:	Harsha <harsha.harsha@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
+F:	drivers/crypto/xilinx/zynqmp-sha.c
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
1.8.2.1

