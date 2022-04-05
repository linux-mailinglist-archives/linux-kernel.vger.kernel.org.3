Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E74F47B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiDEVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbiDELl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:41:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D6A1B788;
        Tue,  5 Apr 2022 04:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqCwQh0/FplUjABynj/PXpZdkbwr3gc9n9RYkuqGGnxk7XBd/W4XxItegsM+DTZYggYccKH+/noCsIkVbfYUlKFj4GXQc9nKnkYYECnR/haEyq9n/jPmAZvlznBzoaEqxSVi+bpcqX+nifodE3E2LlbzKmYJLUKNc0yGBVUlq/pA8fsldd3nHquBCv1yUGR0vgslPYLFJPbJ07ZR6K/bE4cLKPGAo3N5fofDLqjt/PvM6wuqf5SZW8Wp0JUTuCBwePl4awunalhxaUP7AWG5SAvC0j0n3B6Pwa9ViMUG/Ejb6DJax20ytTin3e8qtc5f2S3jRpzu6eBa19sBzXEUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS2nU0RhIeg1LduQ6MFdszX7otdZKsKhumsD//Aoqd8=;
 b=XjCDtdY8As3hyvSG2DYJkp9EFvVsLM+wEHRDQw7L7eTOhsCrsmBzzinBUkSbYPnQFkz3EZfvbC9I5OXiHImWNaIH0Yhca4kdTgJGvFZyHqrptEtsjWSxFpY9ocLOAbXki1GPyEUK1IeqmnmjbR6gCOET/JjM+HRLAsqhD10nibfCHebbTBG/JvTrAdXrLlHKwWjTjUhtnTIHOxFGIyXAL1UD8u1NiAASsVkRqxMaOG3GmW38QytI/yrwujr23EX/8joYZq2hRalPLSC6EFB6hig0u7g7fQxuDrafNGG4/7aDPbweGuxWzCyHJH1I1U2J6Gj+Di+UDxSDhe4xTRxS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS2nU0RhIeg1LduQ6MFdszX7otdZKsKhumsD//Aoqd8=;
 b=BK8ynb4Jc5iwEOnIrjMLxdTtKSWq7AZbXsKHJ9LUa4X2Nn2+9ZB6K73quq7By5eQDc5WIEbji7O88GAHHaE/1OVIhdvDRR673bOnkGhhuIcK2+jI1yKmt2nWsxhRXFoHVPoggrx7ExONPbHWKenUz74ZOvHLPXybLU+q1pfLodM=
Received: from SN4PR0501CA0013.namprd05.prod.outlook.com
 (2603:10b6:803:40::26) by BL3PR02MB7859.namprd02.prod.outlook.com
 (2603:10b6:208:33e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 11:01:11 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::10) by SN4PR0501CA0013.outlook.office365.com
 (2603:10b6:803:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19 via Frontend
 Transport; Tue, 5 Apr 2022 11:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 11:01:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Apr 2022 04:01:04 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Apr 2022 04:01:04 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.64.7] (port=48929 helo=xhdvnc107.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1nbgvn-000FiG-UO; Tue, 05 Apr 2022 04:01:04 -0700
Received: by xhdvnc107.xilinx.com (Postfix, from userid 14964)
        id 2DE416050D; Tue,  5 Apr 2022 16:31:03 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, <sgoud@xilinx.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 0/2] spi: cadence-quadspi: Add OSPI device reset support
Date:   Tue, 5 Apr 2022 16:30:35 +0530
Message-ID: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c68d1a7-5c09-4267-fe41-08da16f39868
X-MS-TrafficTypeDiagnostic: BL3PR02MB7859:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB7859AA95B0AF6ED090A27B25BDE49@BL3PR02MB7859.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyw4nmrsJfvEsdWlJZbQtA7zFL2ZxoM3Sjy/Yx4arWjTW5rDUffhjah1foxXd6Mjud4/zsZ1BXt5wfS9bD8FF0awNnF8TCL6acrF8Q8I5StRdWkNIqsFAl/QEI27V2VfSNfHl/A/U4D1u/ZOUl5SThBfS3uL/dI2qR7PVtXjMN4AM/edAK6GhLwuM28qTXrC4G3sDSG11a9F00F4EyRtLDIYOLRgXOmSaESfCCVE9lGeYNqQ2jWomqwpp7uBd1bCIMUxhX3O4qGjeO6N4KMs4mrPpG7milki6qcww8MLMNskxxjbVvmq1oAgaOFfyRQacW6Du4383n6ixfqiGoULUYvmdQkCX9zCvSrpSWEz7Jn01AkHNjVk+0BMbQXXbpfTLarbdT9c7vLJwV2odWIibNG/gm6Kq4S+WQykcon6qtMhpELP8anxfdTAIQ6ZnvobfORWCioAfCCzRfj+vrad+Akhf06b/5HqotzAMWYgTX7kOBKN2P6+sT2NqAdMckd8LjgIpRhqK543Hc7vXnwZzvJXeq5Z9F4cJ06TKJm8hqXvsADRhfklvujD9Z1N2cVd3hIqqv4rEumhrA6m9AXaezAqRmIFo8avDVjICNpRoJtpS6IG0x9hhN4zF+KsmVcVn5W+RLjmY8Njfh2gcQozQGyCgaUnblbm43B6dyJzh1BsZBAVxAUXNXrXu920EXy0rIfwywD0/M7i3dCdAh9CZQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(8676002)(5660300002)(6266002)(54906003)(7636003)(6666004)(110136005)(42186006)(316002)(4326008)(508600001)(83380400001)(70206006)(107886003)(47076005)(40460700003)(82310400005)(36756003)(336012)(26005)(426003)(186003)(36860700001)(70586007)(2616005)(4744005)(2906002)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:01:11.4040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c68d1a7-5c09-4267-fe41-08da16f39868
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7859
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series update dt-binding and OSPI driver to support OSPI flash
device reset on Xilinx Versal platform.

BRANCH: for-next

Sai Krishna Potthuri (2):
  dt-bindings: spi: cadence-quadspi: Add reset-gpios for Xilinx Versal
    OSPI
  spi: cadence-quadspi: Add support for OSPI device reset

 .../bindings/spi/cdns,qspi-nor.yaml           |  7 ++
 drivers/spi/spi-cadence-quadspi.c             | 72 +++++++++++++++++++
 2 files changed, 79 insertions(+)

-- 
2.17.1

