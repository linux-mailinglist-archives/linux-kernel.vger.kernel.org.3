Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17EC53AAFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356116AbiFAQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356082AbiFAQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:21:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4AE12AF8;
        Wed,  1 Jun 2022 09:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipC6Nr9jFX9OOqX7FuH4Kr1aSvIP2qRXnq6STtEZ3pTNlWmITgMZ4/9wc10CteeniVX6rovAONIg0RiSIWSgTSB7j7doDPGeKFI0nMiAfA81Wp4Vc75KU5H+OrBnMfcw0mNZvddzQo8nzSpi9OyarIW4kMGFEMfIGYPnxxLuAk1ZZaYNJES668tZo7D7YFTkUvLkA64WsPA+T1asnKtHQlQwxC4wgWEPUXAvayz/2mdcGNo3zymWryYXx9v5ilgv72SjoK0Dgk5fTE6DUNiQip85v3neJ84hiZLmQurmdCbzJ23S3NtgZuCOGKP9AO2r+0I1quqf7EjyFHjrbqIAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEWM+cwZ2g8gPh7liR/FnKBbDiWSwh7PH3EPc+hJGpA=;
 b=UZkNP5Qb07gJlonKAjwk/8tIdVAcAQOu3Eu8GpUys4sI550XZjy/PPIFH3XRRWPRNjm6BmUhzyvH0rSeYenaOJJYgvU4o67C45Gk5XVPqsOyOdhcnJfei6FDbGmS6KHLwCokBn15A+OVIylh3dYTzOoGs9LQR1tXZNFtB9H1i/N14W/a24i3ZCAmi7cWjR94JcxSeFe6sMvcRO28H03ADT9P3zgjmZUPZz0MAcX05KAjCFFAmuC9H3gMvMbx9jMg33SkSpyF5giXjk8bF5daweRdZzsVJnFL+5vEaUL2g7HzToCKETuBZxAMKXimw39rzyyc3jG0d0INaVofgCg0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEWM+cwZ2g8gPh7liR/FnKBbDiWSwh7PH3EPc+hJGpA=;
 b=JF7v6HJPJRSrVEAhQOk+rmrze9TAFC0uC4KI3MDC9FRs9q+tE7ehmnCFqdx44drBLqOCcX9sMPb0g9Fg41DedCpuv+LafpD5bnqvs0iHBS0bInriX/ricJ4hLVVAr9h34ZqAhNq95Mold4OAUNusW6C0/oOL2hpBoF9FAIZfB84=
Received: from SN6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:805:66::29)
 by MWHPR02MB2879.namprd02.prod.outlook.com (2603:10b6:300:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 16:21:45 +0000
Received: from SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::9e) by SN6PR08CA0016.outlook.office365.com
 (2603:10b6:805:66::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 16:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0052.mail.protection.outlook.com (10.97.5.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 16:21:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
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
        id 1nwR6I-0003Rb-FB; Wed, 01 Jun 2022 09:21:38 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed, 1 Jun 2022 09:21:09 -0700
Message-ID: <20220601162111.3505458-4-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
References: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c572add-b5aa-4957-46e9-08da43ead1fc
X-MS-TrafficTypeDiagnostic: MWHPR02MB2879:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB287988A32385610C906700E0CADF9@MWHPR02MB2879.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XC5qsAiZ5hpnCVPqqk0dwtdlOrypY8v13pQG7Trf8YKFHSZ296B3w2JknJ7otxJ4DOXgsp9TPWEpObIWVx6oEScGLMNdR/2Z/CmM8RSqBQA0fnCqL/I/wKXS5ilXZlYSr+DXq6wKT4lvkWPe1o47Qb9y2YjY9EBOkopd0ODZIQ5AQwxysX1TNu0Nefr3jiVMxtJisX9+Eq1o321EMNKj9y5NHhO7Kdx8oPFTNpXeftOH3DopcJMAvm+fbcIHbKtpPtQwUWToTJbieLlHf3MoB0lFQ5vnJAYdqNaM9GNd3nbAwmm8yVxfhstb85wEvensWPOMa5MSo3Yyl14+2nwJBNfVEmuWdDd4i5vJa1vwJsMUMmYMomlhANk7dTsLNQM+1tZGWoxOFKlRki9RubSlDFYaXLeQfzUtjIOk3Lv7SI6kA3LqrdljPORc/vKFnEqJwBw7Rg55pyAGvT22/aXrBrkdxn+w/RS03UCh1h06FHJ96ZiGGzp3NcjLO8ejYDxO+EGOUVZiPJS+U0N9ym49Wt8dyCLIU1QcL5GRxYNGbQaa5iHOFaH+idr5AV+7rPaeUZvDmxkv/CLHUNrIZwUK9eCwO7Sfkn4UNUhDvGzA2k/VdmPqdZboorlLJJYH62V5IhExE4UruKL12rZCDa50512x/KhIvDMo5VKTWW88W4LVR0jaGhRIQd0iA8Y0+2b4y+wfEnhCiKcJcmjWuRJFXA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(2906002)(316002)(54906003)(26005)(7696005)(36756003)(356005)(47076005)(336012)(83380400001)(426003)(4326008)(8936002)(7636003)(2616005)(70206006)(82310400005)(5660300002)(70586007)(44832011)(8676002)(508600001)(40460700003)(1076003)(36860700001)(186003)(6666004)(9786002)(7049001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:21:44.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c572add-b5aa-4957-46e9-08da43ead1fc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2879
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@xilinx.com>

Add ZynqMP firmware ioctl enums for RPU configuration and TCM Nodes for
later use via request_node and release_node

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v7:
  - None

Changes in v6:
  - None

Changes in v5:
  - None

Changes in v4:
  - None

Changes in v3:
  - None

 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 14f00a7672d1..54331b726ab0 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -129,6 +129,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -166,6 +170,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE = 0,
 	PM_RESET_ACTION_ASSERT = 1,
-- 
2.25.1

