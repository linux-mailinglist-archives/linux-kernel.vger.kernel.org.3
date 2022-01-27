Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579B949E4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbiA0Ocr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:32:47 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61056 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242326AbiA0Ocr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:32:47 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20R91nbX025490;
        Thu, 27 Jan 2022 06:32:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zumZIIPmkgnTEf6Qq0yZRdafCbBuwoTe3V0m2+yiwJs=;
 b=fUYUBRQT+r/Q1ND/TAjmsw6G5uoPsOUtmdBpWbqMsDlrnEYPkDFQuiIaus+64LhQIGTs
 7wboKeYNezceV0iE3VH4aVK3HXTxW6OBm1lIM8cnVsnclVhfPXkxbXtQKnYxQ7puN/P6
 tsyuIhMlpaZCHm6Tb2cgV8DVSasWIcyJy7l/OntiJFlJxAd7gNLmNlxXRVUuNp3b7t/1
 P31SsGlCeqFRCF1YghZlERHTLLo0mC2ksF9mbvkppWBN4xIIl8iropsSLrcTY35CEvOb
 9+R+r+G+RN+fWyvBh9O9TZw9C9xUo2kSuj0BgG75N+/A3lbiTrvk+aviF67Z5cdXYl/k OQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dujtnsqa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:32:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCIuy44ynLZplMP79r0EPl2x6y6ZSWfSnwURRl6OYPDgcbxA1LdWj7X966qMY0U/djeGdebSXtXTjUUTp5pcKJYHDrt2c5kuselMtyPX+YBZBWwtnmeNDb/wY244wfO+II/xa4B5XoftrDsRaQkpRghWwQhy5FBRbs0E943YF8rWvkqfiZVPOrM/DUMhO/jBSfijXavRxek1SkhmQMVaSJ1CWW5GSd+POUTKffZV26t8OY6oTJ0lPzVIJSSQWjNqLKzoR2P2F5FVmp7Lw4Ia0aiWm1LW3hIItr6xJbTxaqjozXaG8saGD/oApyky24ybFMrYuNvfi6xkUZJo38Us/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zumZIIPmkgnTEf6Qq0yZRdafCbBuwoTe3V0m2+yiwJs=;
 b=Cg38mqf8GWZtrdHckZ26sBuZ8reui1ezqGISQiCnZBgTW3PxFXIq9KJ9EWB5/S0UuAJ+7swlWvpIK6poDD6kmmZkATs66Te2Rh7UcXVtHwXi5e4CJy6VDVSGkrXdYWAMyuaL6KBwi2JSTyyspK8dkW1mGiuG7qdp+oAAYduNtBkG/OU4XXDIORDLdYef+a+nEj9FCt1JKmBT7jJvFTnT5el9Lp2S8HCqkY59jM65MkH6plGkwwG2jeX+OZUEA18zreC6NWh0+0mB++yb8suJLT/1FvlTp8WkGumHxOe85GhOFqDCrrUCZO1GhyZ1V0ptdME0DYutpn1oWWo7OJKyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zumZIIPmkgnTEf6Qq0yZRdafCbBuwoTe3V0m2+yiwJs=;
 b=nk20FFwxetJiNoHNFbWuB0tu1zLrom8ldmWe8cXNe4dSE3LIPc1g2JHf+rJuWRwPckBRKg3+g8/whifLfqs1JvR98BUrhn/G0s11iTDie4wcRjLNKWqe8BrL692PhtlQZaMOfzk3D6ooXAJl3z4e0qgcMzoBlvpK2w9Opr6PWIQ=
Received: from CO2PR04CA0161.namprd04.prod.outlook.com (2603:10b6:104:4::15)
 by PH7PR07MB9396.namprd07.prod.outlook.com (2603:10b6:510:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Thu, 27 Jan
 2022 14:32:38 +0000
Received: from MW2NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::a5) by CO2PR04CA0161.outlook.office365.com
 (2603:10b6:104:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 14:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 64.207.220.244) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT067.mail.protection.outlook.com (10.13.181.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.5 via Frontend Transport; Thu, 27 Jan 2022 14:32:36 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 20REWY3E179398
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 27 Jan 2022 06:32:35 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 Jan 2022 15:32:33 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 27 Jan 2022 15:32:33 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 20REVDka024067;
        Thu, 27 Jan 2022 15:31:45 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 20REVDYG024066;
        Thu, 27 Jan 2022 15:31:13 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <a-govindraju@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH 1/4] phy: cadence-torrent: Add function to get PLL to be configured for DP
Date:   Thu, 27 Jan 2022 15:29:55 +0100
Message-ID: <20220127142958.23465-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127142958.23465-1-sjakhade@cadence.com>
References: <20220127142958.23465-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f204e23-306d-46a3-4891-08d9e1a1dd1f
X-MS-TrafficTypeDiagnostic: PH7PR07MB9396:EE_
X-Microsoft-Antispam-PRVS: <PH7PR07MB939689B5BA6968BE998D6864C5219@PH7PR07MB9396.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nP8fNWsgEoJrPtPFVfqDQWVBc92ai94qDLqirlJZUSFWufrvJkd3jgQ9N92n68BKy5/A6wYL9xcP6YhmuseKpr5C3Pr4W9XJXiK8XYvuipDtLlASz+ClPm/I9rBBafW9g7YwActBk2PONaXfytYEEn8of41WR8NfYhygj3j+LxYFoqs8I+gPO+XJ0AAxNKC3/wWvAM5IJtUx06ZrRKep/2GxtgH1et2iK1RCxwsbxJRwvlNXJX6AwL5edeHuSsp0Of0gINJq8xYBB2VQK0qVutd+FFU+yu366HVWH9U0gcV97w57vvKoofOrvc5dYLnEQOJ7kqnAw+M7+i+IoUMYeYjFUxE6LCDv8A1CjaezBcP23UVet/XHJ46KiHazPLToSnXi+gdwmohtSnWN+yBQ55zZY1Ld7IiDLA6aGJpp+Bje5458Z53lRCgzQa/zZACNX+pr787JwRaClEYhbEk+ENFUnp25+Wpz5K0Q9+7LUPFOJ15iENuiJjtroG8Nq7Nv3/XOLLYFWzaiEKZRbV0QNLjZbLYRg0ROKJFr9P6wjxxFNyA5GQQHqmqqN41XxDFpP+2N9DqYisN81jKpzHnxJm/1DxxnBIc3eyuR5Ew+ziNANjmSkJqYs1hgrcvrcRhykMDhvQU5T71lX3nzNsMI2HaJdJ6PMgLf17K15zBxl5/KOM39k4GVLKWshJj2lBH5HTAWdoTVleWA1If0lJ6tPy2lo8fk7edMelD4MqGbv4Ho676iKbj6CUSwZuK09fJkIkX+hQ70STl3QAjHuluk/KxRvvtlFY/Zw/ff+oyYIssiWfWnc/pVs/8Xu/YG2T9jn49VYO0i1lXLMbxbL8yM8A==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(40470700004)(316002)(42186006)(63370400001)(110136005)(508600001)(54906003)(40460700003)(86362001)(2906002)(70206006)(47076005)(8676002)(336012)(2616005)(36860700001)(26005)(186003)(36756003)(8936002)(82310400004)(63350400001)(83380400001)(426003)(4326008)(356005)(81166007)(70586007)(6666004)(5660300002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:32:36.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f204e23-306d-46a3-4891-08d9e1a1dd1f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR07MB9396
X-Proofpoint-GUID: 13UgV7ibA2gPw1Ud3XenQ9-MMxm42WtL
X-Proofpoint-ORIG-GUID: 13UgV7ibA2gPw1Ud3XenQ9-MMxm42WtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=975 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY PLL0 or PLL1 is used for DP depending on the single link or
multilink protocol configuration for which PHY is configured. In multilink
configurations with other protocols, either PLL0 or PLL1 will be used
for DP. For single link DP, both PLLs need to be configured at POR.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7c4b8050485f..0e2839a6c65d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -38,6 +38,9 @@
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
 
+#define DP_PLL0			BIT(0)
+#define DP_PLL1			BIT(1)
+
 #define TORRENT_COMMON_CDB_OFFSET	0x0
 
 #define TORRENT_TX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
@@ -323,6 +326,7 @@ struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	u32 dp_pll;
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
 	struct device *dev;
@@ -978,6 +982,30 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
 	}
 }
 
+/* Set PLL used for DP configuration */
+static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
+				   enum cdns_torrent_phy_type phy_t2)
+{
+	switch (phy_t2) {
+	case TYPE_PCIE:
+	case TYPE_USB:
+		cdns_phy->dp_pll = DP_PLL1;
+		break;
+	case TYPE_SGMII:
+	case TYPE_QSGMII:
+		cdns_phy->dp_pll = DP_PLL0;
+		break;
+	case TYPE_NONE:
+		cdns_phy->dp_pll = DP_PLL0 | DP_PLL1;
+		break;
+	default:
+		dev_err(cdns_phy->dev, "Unsupported PHY configuration\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1640,6 +1668,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
 		return -EINVAL;
 	}
 
+	cdns_torrent_dp_get_pll(cdns_phy, TYPE_NONE);
+
 	cdns_torrent_dp_common_init(cdns_phy, inst);
 
 	return cdns_torrent_dp_start(cdns_phy, inst, phy);
-- 
2.34.1

