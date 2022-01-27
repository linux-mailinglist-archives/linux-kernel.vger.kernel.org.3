Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1B49E4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbiA0Ogx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:36:53 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:6380 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242453AbiA0Ogt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:36:49 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCjEls031876;
        Thu, 27 Jan 2022 06:36:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VcqO0/Z5SnBJQKlin9YRUvWmoNGmNanF69Vy9eyDtsc=;
 b=biu+jzQLpQ0p4iYu3XSkeB0Ram9MB4IUXUJudCfSwFVIxyxOTUxo9K06KjCb/bKsuWIQ
 Hw9NeJzREXPUPEW3LOkIKUsAyDJ0ZW70YChGvHBzu5KhBTFxOklFkj40MhJATA3BgODU
 FkLiop/gEsqJXvIcNN+srJ4aLMtj3fQYw+mOFSRc9DEy784rrQ0BxstkGFZ2Bm1qkElZ
 IycDK8FFboeNXhrElU5wfjkKcQTDyDkGELysiZR3f2GeALafsqk8yBbDH/PXBz+eptki
 m64tirI8TrpzFF8Rp7GZTiBW24bRaeCFd2ckSFLGOescLmEI0zCQGUEufvYCzZzhpA0P Hw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3duunv0acm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:36:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxn5fmJM/BtVWd0q+/DEjChR8TlcHe+LGhnSLv+3CuIWsjCXqrxsM9C/rr/64RXLTVYvU4PbgCG4PPKJZXQ9BmifyrBZJDqAM/r2UV70ceg8pmyRHa24dXqMZlAopxlHAsuAVdjiyUediyyiubt37ZJb8+2xgKKnIDdSAs1pvlWm2DH/OUrp2di316sP+j7nQpHLxuuGBKaic+MFqWUWpSBMf/gFuIOgTAVnNHyiY97/B8r+L/1m3MjxbMLBxpoPkR9InFXBj5kuctqLz0T/24QgEe9hAtQw5DXf2aPdORooMsVVi/08hYO7hDGXlhDx6lVBdZ55G0ooJe7XwzXeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcqO0/Z5SnBJQKlin9YRUvWmoNGmNanF69Vy9eyDtsc=;
 b=e+H6sLY00Em5RO3BRqYO4NZtCwj1AoXoFR+c5jY+THrzQbg1BC0sI1pwJ20trW9jjF2zTkwL4yz2ov8hFuQcBqlgC9zzKBN5CsAjtNzpQeKl3DpBRHWfIvstLGdE+sr7+JUFNvH92S8qy5WSUq7Ic/X3HHWsIVeAFXYjfFyHPteIPLfV5/eJrtsjB2FR/UDaQNrAFNKEmpviP5EwXZGbt87zx+Hyq9kLZR8Kv3FN9fLGjDQcgbGQkja6F9YPD2C4nEWwbW2z+BEIDNQKgY0N3qCTOr1Ebvzl3GiG+Bzn2AIVsu6v4JB9rHUctQW3rBHfTqgZsybzK1eGUtrufXcfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcqO0/Z5SnBJQKlin9YRUvWmoNGmNanF69Vy9eyDtsc=;
 b=4gYdm+lL745D5WfSfxGENA6eolbxZwycfIZosZE8WKqe2msmgxFBvTDdOhPDspQDglgDS1sUJih5lgOzQXmjYXm2P4FN/ipN59tqm4yZD+ohELf1SLY5HD1bkedzDVYdZxlnTABm8lgUb++qxMsTL+w7kgDrGYyALe6+i9vu17A=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 14:36:31 +0000
Received: from MW2NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::ad) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14 via Frontend
 Transport; Thu, 27 Jan 2022 14:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.147) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT020.mail.protection.outlook.com (10.13.180.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.5 via Frontend Transport; Thu, 27 Jan 2022 14:36:29 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 20REaRsF024248
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 06:36:28 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 Jan 2022 15:36:26 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 27 Jan 2022 15:36:26 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 20REYotM025345;
        Thu, 27 Jan 2022 15:35:38 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 20REYoXK025344;
        Thu, 27 Jan 2022 15:34:50 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <a-govindraju@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH 4/4] phy: cadence-torrent: Add USB + DP multilink configuration
Date:   Thu, 27 Jan 2022 15:29:58 +0100
Message-ID: <20220127142958.23465-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127142958.23465-1-sjakhade@cadence.com>
References: <20220127142958.23465-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29339fa0-7e7d-4a4c-e608-08d9e1a26828
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:EE_
X-Microsoft-Antispam-PRVS: <SN6PR07MB4926255D79CD4D362A337FE6C5219@SN6PR07MB4926.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Q/6KHmtbL7lVJv0KtFXt3k4oFsnxgRuXS9+x5NDP13UyU6dZubiM4oX/RO3qAVpPHI0GtvPc/aa9UZtV5WJjoeeDrqw1Xfv6haP+wtuz0oNIyN3zvM2f3WAk2hviYCusdaSWzZr8TDTRuCu89FovNqDc2lKZ43dUgcW4L9uA9xDOFY2ldy8nFjKv8o/hWKQN1ExTiwnjB1r5eBse2yW8/e+WlzRioBpvmes4IEbRHxDn9GJs0yV8CyJYuyBNO9NL8muTNzakGDuZhPGuNciT7P/qeMtf2jBqT/JBowIPmRHaCWzi0PS5bhxoVkTp7YFfG8dPTnUZGDngdyKqHnH5YpuugVhdF9W70urPvHCnJ6dsQ/t8eL/sk3Zyk3uGqwR47AWbMylzD6QMbZtEEnXpbjuQRY3D0vmkFU1Qi9YsR3oBtsjRv7w17WufDGiTlcP0omSdenY2Y7g+4zKp4Vzp8odQDdBC0MFFm9cvcY960464AmiyuE6D4UvBFbn/OYFNSiz8qenRi1f22QqQsoMhzJmKutCZbkbmFPoq8KObChNK7gkdlX+sqwTnzcAh1JTk7NToGSfaTWBIO39dcBx51j0mbVSCM0qVjwnNou9tm4DKf8PPXFuxGqaQ62pIJTxmRJzDPy6Xo/Xxhwl6v41b/znxKfUuZy33FltrQ8MTvyRvosFejNJ3WSk5cBqge5i4Yq/RACFwfKDhxRBJmNm5x5914xnBWrTRLewRZHxgjsaNCa/0HHx+rFQn+GpcvnDZ24LQ7zHjHO/HWKmP4MKpJl5YI6f82QCDfr0OYT00oM=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(40470700004)(1076003)(356005)(336012)(47076005)(63370400001)(70586007)(86362001)(26005)(63350400001)(82310400004)(2616005)(70206006)(2906002)(186003)(5660300002)(316002)(426003)(54906003)(508600001)(110136005)(8676002)(4326008)(8936002)(36860700001)(40460700003)(7636003)(42186006)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:36:29.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29339fa0-7e7d-4a4c-e608-08d9e1a26828
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT020.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
X-Proofpoint-ORIG-GUID: q9MsjNEfvxTpMN3MlPliRIwzrN6eCNbU
X-Proofpoint-GUID: q9MsjNEfvxTpMN3MlPliRIwzrN6eCNbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=796
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB + DP no SSC multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 98 +++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 8a14523bc8a1..0050d452dbd3 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2904,6 +2904,38 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* USB and DP link configuration */
+static struct cdns_reg_pairs usb_dp_link_cmn_regs[] = {
+	{0x0002, PHY_PLL_CFG},
+	{0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs usb_dp_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs dp_usb_xcvr_diag_ln_regs[] = {
+	{0x0001, XCVR_DIAG_HSCLK_SEL},
+	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals usb_dp_link_cmn_vals = {
+	.reg_pairs = usb_dp_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_dp_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals usb_dp_xcvr_diag_ln_vals = {
+	.reg_pairs = usb_dp_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_dp_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = dp_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
+};
+
 /* PCIe and DP link configuration */
 static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -3920,6 +3952,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_dp_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3997,6 +4032,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -4007,6 +4045,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4084,6 +4125,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -4108,6 +4152,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -4133,6 +4180,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4210,6 +4260,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				},
 			},
 		},
 	},
@@ -4236,6 +4289,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4313,6 +4369,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4339,6 +4398,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4416,6 +4478,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4432,6 +4497,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_dp_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4509,6 +4577,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -4519,6 +4590,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4596,6 +4670,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -4620,6 +4697,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -4645,6 +4725,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4722,6 +4805,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				},
 			},
 		},
 	},
@@ -4748,6 +4834,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4825,6 +4914,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4851,6 +4943,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4928,6 +5023,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
-- 
2.34.1

