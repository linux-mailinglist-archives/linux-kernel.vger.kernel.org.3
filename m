Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32F449E4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiA0OfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:35:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:42658 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234071AbiA0OfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:35:17 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCiouE030268;
        Thu, 27 Jan 2022 06:35:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ChTtrWurhMnx3QHnl0ws1O+Y8m0EgdmEm7HOJp53LP0=;
 b=dfwm66IFaXTjnifnKkZjFOJ3uYT2H2QM/fMko1XEQ8vBhiAsklgrZOGdJdjEzIZNhVps
 1+MIF8HEvxIocf9G8LVzRPlYfCxjM1MbCTjRmL4a7zpuOWnfP7shyHvGEgGb6acQ9MaR
 llU0a+c4jEMWtvoDTr+rX+KC5Gn/m7vkpw/g7B9kvznmpcHtKLKtxvGZ1cRPZgbzj0My
 2rTjP9S9T1lvjSnxJs38ULNygkdk439SA6noSRHCWMYOftcwK2R38Tdt/PiMeudXsxnl
 i1fKepMFl6sCyVdn13O4rO/r3niwD5DluXrC/s/RZwApQSdFpKHZPftZQxzL9/NCQgR4 Dg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3duunv0a97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:35:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loVurIpUHrhbsAAQ3HCwueRcEGq5ziROvQo2avJ9Q1AAKmq0IvkCdn3Nc3vlkD+ALUCoXTBxb9ZJ4/QbVQ5/BzFlYH66sTPurx8K6rHxM39rH8zGQ/sSV9TSZZUP13GR+IfQ2crQYpkM9JqIQJCY6+US77aetSWNsdeOlyMDMGKJ62I1CFv0unYR72ymwfdr3lhHc+axGYY2gupavyrqsH/QZxLo9KT0RjeRd9EIRDBSWz18X/QLxOFJrFGwzdp6SSLQISWDH5gUPFgFtXKOp5EHCFG8Bm5XsJbgdiaBs5cihhGoFjk7hg9UTrQId1ByO5dponJm39AhSZFY80EsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChTtrWurhMnx3QHnl0ws1O+Y8m0EgdmEm7HOJp53LP0=;
 b=WhKRBb8cjpqsJA4mcOS14uXZrRwWnXKTXE5fDk5/l5IE3xTTUxsjFA4AYe8/EgrgUSCgQtiak5DAWQjKYgql2r1YrSyM1eeSPPcM1cBnFIbJ76EH9Uxyuojnti01Imu3QRn45gTBpoE1PkG/usviQ+xMEdLxNDLTAEPx4TiG+2p6E8So5EMyy9+zSTKl/LtN+GDaroDeHhdiueyH/qaN6hRueDyVCIhjZNJmSY/6BTQW3IHfrTvcuRRgpPtdGdwGyghQWds5v7CCbW4V0G5JHT42ZBDfvrGjR2cRcT9U3jmryWJJynQnmq/OcDnCv8UaYmCv3/x7viouUAAb1jXd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChTtrWurhMnx3QHnl0ws1O+Y8m0EgdmEm7HOJp53LP0=;
 b=UCn2gj6+IJ60MYP0ApboEwmtRGlwKw5IQlijrl+9/z7kI67qS+BECEtaWRHIf9uxs3GRFm7mHXRtWNnMepuzluAcmW5v2i2Uo2okWLn5fCQzCUe1M5KTCTPLvyCH7Ilxn3L7TaesGAdYFkRBVCgAByZ+UBVpRISU6zthgtYVBOM=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by BN8PR07MB6356.namprd07.prod.outlook.com (2603:10b6:408:bd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 14:35:08 +0000
Received: from BN8NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::aa) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 14:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT044.mail.protection.outlook.com (10.13.183.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.5 via Frontend Transport; Thu, 27 Jan 2022 14:35:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 20REZ5ub022389
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 06:35:06 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 Jan 2022 15:34:58 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 27 Jan 2022 15:34:58 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 20REXbRA024948;
        Thu, 27 Jan 2022 15:34:09 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 20REXbW3024947;
        Thu, 27 Jan 2022 15:33:37 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <a-govindraju@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH 3/4] phy: cadence-torrent: Add PCIe + DP multilink configuration for 100MHz refclk
Date:   Thu, 27 Jan 2022 15:29:57 +0100
Message-ID: <20220127142958.23465-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127142958.23465-1-sjakhade@cadence.com>
References: <20220127142958.23465-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695488f2-e817-4f02-c4b8-08d9e1a2376c
X-MS-TrafficTypeDiagnostic: BN8PR07MB6356:EE_
X-Microsoft-Antispam-PRVS: <BN8PR07MB63563153C80EA50380238BD5C5219@BN8PR07MB6356.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmWWBKw/MjY13SwvY1hqdwb1RAwrcPf0ZX4Oah2HaHTY48eBdiZ+dZT/OOEdl423w/IyJ5/nxlFzhcLsmelZm5CCaMVB+cf/ihlwCFxBgFQ6A1JfLWo0uDMeDCoJnYbSlfWze0eUbZSSGInRO95n8uu9LHS0o/+sCJexnBAIBCU9kEh+7UE9aXN+86ovIN0IlYKulMsJmPKA1OkSKNI47wDSDUY7Omi48EqXcgGhTzrEVT89Zwo3WQsmk8cFuCvKyH1LCAZPfcdGhe8Jzsv6OfYPTisVF2Pb7ZuvZDWOHbuEZgzoOhOFnvTBwbOKdSvMv3Ryz670csEU9dO2ay8t4iD1gX6TK5KXysqvbCtCl3zxv0Dwwy69jDq41f86rcJPor1hIkwrQyWv1SFTu+4jo8S0dZDKR1uh8FsM01gI3s64zsMkFq0SQQxkvEJWuRVnxNEjvBKHWXSRf4zsKlECAwb+m09uveuDbR16nXrQaZvoNl6W9zVzdJ9B7WGK2gygCfV9mvBpLF5xzMwgQdoCo8X/lc/nuFvDxVFFyUoJpoPUE5hcK/YKBreY3fVPuDbiO0HrF2/32pEf6aqBCnRXjwAWTRTaJqJLgCCrG8H4eZeBiSX3v7KSIkHPSLI5mVqnOHmUEEhcuDMCoxsvvGTmAB0RssUz9c+Gqnh1g2ebWgtCPF28BEjzEcptftvgM+Fk
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230001)(4636009)(36092001)(46966006)(40470700004)(36840700001)(26005)(36860700001)(186003)(426003)(1076003)(2616005)(336012)(356005)(70586007)(36756003)(4326008)(2906002)(5660300002)(8676002)(70206006)(30864003)(8936002)(82310400004)(110136005)(86362001)(316002)(47076005)(54906003)(6666004)(40460700003)(42186006)(83380400001)(508600001)(7636003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:35:07.8587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695488f2-e817-4f02-c4b8-08d9e1a2376c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6356
X-Proofpoint-ORIG-GUID: lH5ALgvaZnyo4XkyImxwCmR-dPGn675E
X-Proofpoint-GUID: lH5ALgvaZnyo4XkyImxwCmR-dPGn675E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add multilink DP configuration support for 100MHz reference clock rate.
This is the only clock rate supported currently for multilink PHY
configurations. Also, add PCIe + DP multiprotocol multilink register
configuration sequences for 100MHz refclk with no SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 284 +++++++++++++++++-----
 1 file changed, 227 insertions(+), 57 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 72adc3a27367..8a14523bc8a1 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -905,74 +905,90 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
+		if (cdns_phy->dp_pll & DP_PLL0)
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
+
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
+		}
 		break;
 	/* Setting VCO for 9.72GHz */
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (cdns_phy->dp_pll & DP_PLL0) {
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		}
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		}
 		break;
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (cdns_phy->dp_pll & DP_PLL0) {
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		}
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		}
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (cdns_phy->dp_pll & DP_PLL0) {
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		}
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		}
 		break;
 	}
 }
@@ -1714,6 +1730,20 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return cdns_torrent_dp_start(cdns_phy, inst, phy);
 }
 
+static int cdns_torrent_dp_multilink_init(struct cdns_torrent_phy *cdns_phy,
+					  struct cdns_torrent_inst *inst,
+					  struct phy *phy)
+{
+	if (cdns_phy->ref_clk_rate != CLK_100_MHZ) {
+		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
+		return -EINVAL;
+	}
+
+	cdns_torrent_dp_common_init(cdns_phy, inst);
+
+	return cdns_torrent_dp_start(cdns_phy, inst, phy);
+}
+
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
@@ -2225,8 +2255,11 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	u32 num_regs;
 	int i, j;
 
-	if (cdns_phy->nsubnodes > 1)
+	if (cdns_phy->nsubnodes > 1) {
+		if (phy_type == TYPE_DP)
+			return cdns_torrent_dp_multilink_init(cdns_phy, inst, phy);
 		return 0;
+	}
 
 	/**
 	 * Spread spectrum generation is not required or supported
@@ -2468,6 +2501,12 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			}
 		}
 
+		if (phy_t1 == TYPE_DP) {
+			ret = cdns_torrent_dp_get_pll(cdns_phy, phy_t2);
+			if (ret)
+				return ret;
+		}
+
 		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
 	}
 
@@ -2865,6 +2904,77 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIe and DP link configuration */
+static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1}
+};
+
+static struct cdns_reg_pairs pcie_dp_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs dp_pcie_xcvr_diag_ln_regs[] = {
+	{0x0001, XCVR_DIAG_HSCLK_SEL},
+	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_dp_link_cmn_vals = {
+	.reg_pairs = pcie_dp_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_dp_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_dp_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_dp_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_dp_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = dp_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_pcie_xcvr_diag_ln_regs),
+};
+
+/* DP Multilink, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs dp_100_no_ssc_cmn_regs[] = {
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_reg_pairs dp_100_no_ssc_tx_ln_regs[] = {
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs dp_100_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_cmn_vals = {
+	.reg_pairs = dp_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = dp_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = dp_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_rx_ln_regs),
+};
+
 /* Single DisplayPort(DP) link configuration */
 static struct cdns_reg_pairs sl_dp_link_cmn_regs[] = {
 	{0x0000, PHY_PLL_CFG},
@@ -3807,6 +3917,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3829,6 +3942,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3888,6 +4004,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3910,6 +4029,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4008,6 +4130,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4030,6 +4155,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4105,6 +4233,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4127,6 +4258,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4202,6 +4336,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4224,6 +4361,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4289,6 +4429,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4311,6 +4454,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4370,6 +4516,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4392,6 +4541,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4490,6 +4642,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4512,6 +4667,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4587,6 +4745,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4609,6 +4770,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4684,6 +4848,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4706,6 +4873,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
-- 
2.34.1

