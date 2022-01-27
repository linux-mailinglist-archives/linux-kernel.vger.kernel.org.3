Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3749E4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiA0OeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:34:05 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1054 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234147AbiA0OeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:34:04 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCjF9R031894;
        Thu, 27 Jan 2022 06:33:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aU1iE/2mQQtZwRgL/RKcGcQQoYMFNVslhFPezXl9Cg8=;
 b=adhdeFFhyAQdYBVP5N2V6+vbw1wll2mYYq3UOfQm7cCjB3ZdZ/IGPqXuxk04j7gfcAhp
 HVqvYtdQXZE1Y8qLpJpbA8nluF65FgvEJSsvCYXVfPWo49ZnrkO0lhvlPQKv+pCtdJ2l
 N586gzRYWjXpwG65CVVc9i/BiKs8KT0Mk1eQC7EjjlgObmyeqY16BFFiZkyf+FJzMMeV
 5qNVGTEKORaaDaiZJgd2YzgusD3RNYNb+2/UfA1CaNwaCQNx/+BI0ALjDIFQdVWxAvgx
 j21QWBuJOjPxbOTKFJc2wL93atDXBD+JUMIjIHScIF2dhtUShnfpLuBIPUlPYBbwCwjz XA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3duunv0a6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:33:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QumE2E5084HhODM4Re6sFfxS1jW7+LDdX1WPPGK2VTEndemDiQql+tTyc5emsz1cTCp1GbPmTj7rXdAHWikdxjBBqLDoOOtOzHhUKgvkRS0gWRMhNNf2SoJU3Q7sGgz+WB0NwDD2n1ESZIFcPJpH4YINKhPSpDlGTw6eH9/KtgD3xQOwbz6ZOlcQbBxt0WiZn9CQZk0ZoFQCAfhGlSMInCi8mESQLFyT8SkQDMh5dePtU6Ihv/7+OCDy50jNqnH4oTCw4gbUX+PP3rPIefkKAn4fb+4QR80rByj1gXSVG+WDQCslobPaVdxgclxJD2L5NHo7Uk3hYmoOmMjD1NwYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU1iE/2mQQtZwRgL/RKcGcQQoYMFNVslhFPezXl9Cg8=;
 b=ZDiUw0ptjLgYMMUJfTpMMQrQ/Mlwtfa7XuIc082Su9Ij/MIiID2AIChFHClfHW0MxtQkOoP0gfFa4g6MbIb/ivYiVKAjnPM0oCMycMcyiMMMsNFvKDdmIEjxsepFObpNTSPQr9HMV7epd/mn4eJkIbUPMEg6h+J3Kg14lD8JiTGYzc+w2Wjpckb+Hi2YeasJWTwiRF3QbWS6pxnHNTYYDtx2ItiLAGPa20Qiejf5DoH0P7plPSxG87qUMJDCYcq1zMTM6enyEScexZdLL1lvnGdnDvX61wbtCQwzeZpzehqW0O1PHFM4rjuSyo3d2vX5TCKeqbvh0h2U3bmne/IkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU1iE/2mQQtZwRgL/RKcGcQQoYMFNVslhFPezXl9Cg8=;
 b=h4D683Zc+6MNPramdyoxU+viJ/8MKf9m1/1eDLINQO8pYUYOMsKO2YIcpe/04vK3NhStyrlQa8/NMQtKemdgqjH6ZxA8VphytYsKE4w+7qNubqQug7hgJkkfSjxOoowh2+71zdo3maFBjzqUO4Fe32YmHNX57weGeEWdzwyerdQ=
Received: from DM5PR12CA0067.namprd12.prod.outlook.com (2603:10b6:3:103::29)
 by CO1PR07MB9131.namprd07.prod.outlook.com (2603:10b6:303:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 27 Jan
 2022 14:33:48 +0000
Received: from DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::70) by DM5PR12CA0067.outlook.office365.com
 (2603:10b6:3:103::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 14:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT013.mail.protection.outlook.com (10.13.178.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.5 via Frontend Transport; Thu, 27 Jan 2022 14:33:48 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 20REXkDQ022274
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 06:33:47 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 Jan 2022 15:33:45 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 27 Jan 2022 15:33:45 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 20REWP3D024541;
        Thu, 27 Jan 2022 15:32:57 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 20REWPsO024540;
        Thu, 27 Jan 2022 15:32:25 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <a-govindraju@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH 2/4] phy: cadence-torrent: Prepare driver for multilink DP support
Date:   Thu, 27 Jan 2022 15:29:56 +0100
Message-ID: <20220127142958.23465-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127142958.23465-1-sjakhade@cadence.com>
References: <20220127142958.23465-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa0a9393-c764-4009-925f-08d9e1a207f4
X-MS-TrafficTypeDiagnostic: CO1PR07MB9131:EE_
X-Microsoft-Antispam-PRVS: <CO1PR07MB91318DFA6196DB8CF0D7AA97C5219@CO1PR07MB9131.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvGpEqTuRd/4vFLreOBCLJ4JOscSN8hno4rtjPG+hiZFsoMopXHmGFlxCKpJHqIUVcw8hPq7m6Piy/P1XToKkvqhm98dNWlE9X4wAmOHmGf7FOgdapz4HJrtPIUHE/OS5Dfk3I0uQMviV5TIa0ynzIvI3i6SDEvu2parfymbh6etTJYs8oEwPcM1WAob0TmFPrsfwDNL3dcNenm2B5uCrRhIKtrw5QYRY3urElS6sG0wZ6XeHAmNUAp2yTutPT8dLdUIXtFYadNLqWkmrKf2ir0uzyiIV+shWPxlhgzTOFJJlZK9HQwUIX1nGRT+znWg7uJuAiyaJe6qVcUbAiIhVECQpjPN5icqMYs7rGLZmnXAs3IZbSMjRLiuIpWBMhjKjiGI27rpcsumkGe94kownzdEdBCUO8Os0rpB+k0koveX4ue9LPTXM7CYCekFSVNO6avx+iqM26M1jii3gdAdPuphdX1flAFMKrAGmckFdK/5FBfqQAi/a2X+3Jx722rTjfnAJ52wygnF9Iz9Ra2zdyXlRb4U44j9KRQN4qUWuXjhZSWFZatBa0pJPxl59eaTH+2LBPGm5UgjXsyWqYN9dNe9A7OiP0w3K+cciWboydOpbBhZitM/obp4jchZhkw2ZxlSD/aSVN+ke8xKe00I6eIKQ7XsbHiO4fS0neQ2WwBvrl0xLwGizSeRrU1ivtWfB7ozqjojz0zPWLzNRpOmqigS6ilefKF6UQzPRWya0RmGubKW8o2XxByMG7UfOexYEPUUSHmU59OW7b7MeK1Jk7wmhfeV6mqwzKb8Zq589Jg=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(40470700004)(6666004)(36756003)(336012)(5660300002)(8676002)(7636003)(316002)(426003)(2616005)(508600001)(4326008)(26005)(54906003)(8936002)(356005)(83380400001)(1076003)(30864003)(86362001)(70206006)(186003)(110136005)(40460700003)(82310400004)(70586007)(2906002)(36860700001)(47076005)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:33:48.3274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0a9393-c764-4009-925f-08d9e1a207f4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB9131
X-Proofpoint-ORIG-GUID: Gh6AyiKx4vcvfZO6T_Vk2za08qyQyDKU
X-Proofpoint-GUID: Gh6AyiKx4vcvfZO6T_Vk2za08qyQyDKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=956
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares driver for multilink DP support as well as for
multiprotocol PHY configurations involving DP as one of the required
protocols. This needs changes in functions configuring default single
link DP with master lane 0 to support non-zero master lane values and
associated PLL configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 315 ++++++++++++----------
 1 file changed, 177 insertions(+), 138 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0e2839a6c65d..72adc3a27367 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -69,16 +69,11 @@
  */
 #define PHY_AUX_CTRL			0x04
 #define PHY_RESET			0x20
-#define PMA_TX_ELEC_IDLE_MASK		0xF0U
 #define PMA_TX_ELEC_IDLE_SHIFT		4
-#define PHY_L00_RESET_N_MASK		0x01U
 #define PHY_PMA_XCVR_PLLCLK_EN		0x24
 #define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
 #define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
-#define PHY_POWER_STATE_LN_0	0x0000
-#define PHY_POWER_STATE_LN_1	0x0008
-#define PHY_POWER_STATE_LN_2	0x0010
-#define PHY_POWER_STATE_LN_3	0x0018
+#define PHY_POWER_STATE_LN(ln)		((ln) * 8)
 #define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
 #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
 #define PHY_PMA_CMN_READY		0x34
@@ -1010,43 +1005,37 @@ static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
  * Enable or disable PLL for selected lanes.
  */
 static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
+				      struct cdns_torrent_inst *inst,
 				      struct phy_configure_opts_dp *dp,
 				      bool enable)
 {
-	u32 rd_val;
-	u32 ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 rd_val, i, pll_ack_val;
+	int ret;
 
 	/*
 	 * Used to determine, which bits to check for or enable in
 	 * PHY_PMA_XCVR_PLLCLK_EN register.
 	 */
-	u32 pll_bits;
+	u32 pll_bits = 0;
 	/* Used to enable or disable lanes. */
 	u32 pll_val;
+	u32 clane = 0;
 
-	/* Select values of registers and mask, depending on enabled lane
-	 * count.
-	 */
-	switch (dp->lanes) {
-	/* lane 0 */
-	case (1):
-		pll_bits = 0x00000001;
-		break;
-	/* lanes 0-1 */
-	case (2):
-		pll_bits = 0x00000003;
-		break;
-	/* lanes 0-3, all */
-	default:
-		pll_bits = 0x0000000F;
-		break;
-	}
+	/* Select values of registers and mask, depending on enabled lane count. */
+	pll_val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
 
-	if (enable)
-		pll_val = pll_bits;
-	else
-		pll_val = 0x00000000;
+	if (enable) {
+		for (i = 0; i < dp->lanes; i++)
+			pll_bits |= (0x01U << (clane + i));
+		pll_val |= pll_bits;
+		pll_ack_val = pll_bits;
+	} else {
+		for (i = 0; i < inst->num_lanes; i++)
+			pll_bits |= (0x01U << (clane + i));
+		pll_val &= (~pll_bits);
+		pll_ack_val = 0;
+	}
 
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
 
@@ -1054,23 +1043,26 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 	ret = regmap_read_poll_timeout(regmap,
 				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
 				       rd_val,
-				       (rd_val & pll_bits) == pll_val,
+				       (rd_val & pll_bits) == pll_ack_val,
 				       0, POLL_TIMEOUT_US);
 	ndelay(100);
 	return ret;
 }
 
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   struct cdns_torrent_inst *inst,
 					   u32 num_lanes,
 					   enum phy_powerstate powerstate)
 {
 	/* Register value for power state for a single byte. */
 	u32 value_part;
-	u32 value;
-	u32 mask;
+	u32 value = 0;
+	u32 mask = 0;
 	u32 read_val;
-	u32 ret;
+	int ret;
+	u32 i;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 clane = 0;
 
 	switch (powerstate) {
 	case (POWERSTATE_A0):
@@ -1085,29 +1077,11 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 		break;
 	}
 
-	/* Select values of registers and mask, depending on enabled
-	 * lane count.
-	 */
-	switch (num_lanes) {
-	/* lane 0 */
-	case (1):
-		value = value_part;
-		mask = 0x0000003FU;
-		break;
-	/* lanes 0-1 */
-	case (2):
-		value = (value_part
-			 | (value_part << 8));
-		mask = 0x00003F3FU;
-		break;
-	/* lanes 0-3, all */
-	default:
-		value = (value_part
-			 | (value_part << 8)
-			 | (value_part << 16)
-			 | (value_part << 24));
-		mask = 0x3F3F3F3FU;
-		break;
+	/* Select values of registers and mask, depending on enabled lane count. */
+
+	for (i = 0; i < num_lanes; i++) {
+		value |= (value_part << PHY_POWER_STATE_LN(clane + i));
+		mask |= (PMA_XCVR_POWER_STATE_REQ_LN_MASK << PHY_POWER_STATE_LN(clane + i));
 	}
 
 	/* Set power state A<n>. */
@@ -1122,18 +1096,20 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	return ret;
 }
 
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
+			       struct cdns_torrent_inst *inst, u32 num_lanes)
 {
 	unsigned int read_val;
 	int ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 clane = 0;
 
 	/*
 	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
 	 * master lane
 	 */
 	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
-				       read_val, read_val & 1,
+				       read_val, (read_val & (1 << clane)),
 				       0, POLL_TIMEOUT_US);
 	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
@@ -1143,12 +1119,12 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 
 	ndelay(100);
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
 					      POWERSTATE_A2);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
 					      POWERSTATE_A0);
 
 	return ret;
@@ -1172,6 +1148,7 @@ static int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
+					 struct cdns_torrent_inst *inst,
 					 u32 rate, u32 num_lanes)
 {
 	unsigned int clk_sel_val = 0;
@@ -1204,14 +1181,17 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 		break;
 	}
 
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
+	if (cdns_phy->dp_pll & DP_PLL0)
+		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+				       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
+
+	if (cdns_phy->dp_pll & DP_PLL1)
+		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+				       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < num_lanes; i++)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + i],
 				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
 }
 
@@ -1220,23 +1200,44 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
  * set and PLL disable request was processed.
  */
 static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
+					  struct cdns_torrent_inst *inst,
 					  struct phy_configure_opts_dp *dp)
 {
-	u32 read_val, ret;
+	u32 read_val, field_val;
+	int ret;
 
-	/* Disable the cmn_pll0_en before re-programming the new data rate. */
-	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
+	/*
+	 * Disable the associated PLL (cmn_pll0_en or cmn_pll1_en) before
+	 * re-programming the new data rate.
+	 */
+	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
+	if (ret)
+		return ret;
+	field_val &= ~(cdns_phy->dp_pll);
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
 
 	/*
 	 * Wait for PLL ready de-assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
+	 * For PLL1 - PHY_PMA_CMN_CTRL2[3] == 1
 	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
-					     read_val,
-					     ((read_val >> 2) & 0x01) != 0,
-					     0, POLL_TIMEOUT_US);
-	if (ret)
-		return ret;
+	if (cdns_phy->dp_pll & DP_PLL0) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     ((read_val >> 2) & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
+
+	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     ((read_val >> 3) & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
 	ndelay(200);
 
 	/* DP Rate Change - VCO Output settings. */
@@ -1250,19 +1251,35 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 		/* PMA common configuration 100MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
 
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, dp->link_rate, dp->lanes);
 
-	/* Enable the cmn_pll0_en. */
-	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
+	/* Enable the associated PLL (cmn_pll0_en or cmn_pll1_en) */
+	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
+	if (ret)
+		return ret;
+	field_val |= cdns_phy->dp_pll;
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
 
 	/*
 	 * Wait for PLL ready assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
+	 * For PLL1 - PHY_PMA_CMN_CTRL2[1] == 1
 	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
-					     read_val,
-					     (read_val & 0x01) != 0,
-					     0, POLL_TIMEOUT_US);
+	if (cdns_phy->dp_pll & DP_PLL0) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     (read_val & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
+
+	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1)
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     ((read_val >> 1) & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+
 	return ret;
 }
 
@@ -1330,6 +1347,7 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
 
 /* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
 static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
+				       struct cdns_torrent_inst *inst,
 				       u32 num_lanes)
 {
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
@@ -1337,27 +1355,13 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 					     PHY_PMA_XCVR_POWER_STATE_REQ);
 	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
 					      PHY_PMA_XCVR_PLLCLK_EN);
+	u32 i;
 
-	/* Lane 0 is always enabled. */
-	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-		       PHY_POWER_STATE_LN_0);
-	pll_clk_en &= ~0x01U;
+	for (i = 0; i < num_lanes; i++) {
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK
+			     << PHY_POWER_STATE_LN(inst->mlane + i));
 
-	if (num_lanes > 1) {
-		/* lane 1 */
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_1);
-		pll_clk_en &= ~(0x01U << 1);
-	}
-
-	if (num_lanes > 2) {
-		/* lanes 2 and 3 */
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_2);
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_3);
-		pll_clk_en &= ~(0x01U << 2);
-		pll_clk_en &= ~(0x01U << 3);
+		pll_clk_en &= ~(0x01U << (inst->mlane + i));
 	}
 
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
@@ -1366,36 +1370,57 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 
 /* Configure lane count as required. */
 static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
+				     struct cdns_torrent_inst *inst,
 				     struct phy_configure_opts_dp *dp)
 {
-	u32 value;
-	u32 ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 	u8 lane_mask = (1 << dp->lanes) - 1;
+	u8 pma_tx_elec_idle_mask = 0;
+	u32 value, i;
+	int ret;
+	u32 clane = inst->mlane;
+
+	lane_mask <<= clane;
 
 	value = cdns_torrent_dp_read(regmap, PHY_RESET);
 	/* clear pma_tx_elec_idle_ln_* bits. */
-	value &= ~PMA_TX_ELEC_IDLE_MASK;
+	pma_tx_elec_idle_mask = ((1 << inst->num_lanes) - 1) << clane;
+
+	pma_tx_elec_idle_mask <<= PMA_TX_ELEC_IDLE_SHIFT;
+
+	value &= ~pma_tx_elec_idle_mask;
+
 	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
 	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
-		 PMA_TX_ELEC_IDLE_MASK;
+		 pma_tx_elec_idle_mask;
+
 	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
-	/* reset the link by asserting phy_l00_reset_n low */
+	/* reset the link by asserting master lane phy_l0*_reset_n low */
 	cdns_torrent_dp_write(regmap, PHY_RESET,
-			      value & (~PHY_L00_RESET_N_MASK));
+			      value & (~(1 << clane)));
 
 	/*
-	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
+	 * Assert lane reset on unused lanes and master lane so they remain in reset
 	 * and powered down when re-enabling the link
 	 */
-	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
+	for (i = 0; i < inst->num_lanes; i++)
+		value &= (~(1 << (clane + i)));
+
+	for (i = 1; i < inst->num_lanes; i++)
+		value |= ((1 << (clane + i)) & lane_mask);
+
 	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
-	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
+	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, dp->lanes);
 
 	/* release phy_l0*_reset_n based on used laneCount */
-	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
+	for (i = 0; i < inst->num_lanes; i++)
+		value &= (~(1 << (clane + i)));
+
+	for (i = 0; i < inst->num_lanes; i++)
+		value |= ((1 << (clane + i)) & lane_mask);
+
 	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	/* Wait, until PHY gets ready after releasing PHY reset signal. */
@@ -1406,41 +1431,44 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 	ndelay(100);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	value = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
+	value |= (1 << clane);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, value);
 
-	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
+	ret = cdns_torrent_dp_run(cdns_phy, inst, dp->lanes);
 
 	return ret;
 }
 
 /* Configure link rate as required. */
 static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
+				    struct cdns_torrent_inst *inst,
 				    struct phy_configure_opts_dp *dp)
 {
-	u32 ret;
+	int ret;
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
 					      POWERSTATE_A3);
 	if (ret)
 		return ret;
-	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, false);
 	if (ret)
 		return ret;
 	ndelay(200);
 
-	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
+	ret = cdns_torrent_dp_configure_rate(cdns_phy, inst, dp);
 	if (ret)
 		return ret;
 	ndelay(200);
 
-	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, true);
 	if (ret)
 		return ret;
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
 					      POWERSTATE_A2);
 	if (ret)
 		return ret;
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
 					      POWERSTATE_A0);
 	if (ret)
 		return ret;
@@ -1451,44 +1479,45 @@ static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
 
 /* Configure voltage swing and pre-emphasis for all enabled lanes. */
 static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
+					 struct cdns_torrent_inst *inst,
 					 struct phy_configure_opts_dp *dp)
 {
 	u8 lane;
 	u16 val;
 
 	for (lane = 0; lane < dp->lanes; lane++) {
-		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 					    TX_DIAG_ACYA);
 		/*
 		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
 		 * current state of the analog TX driver.
 		 */
 		val |= TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_DIAG_ACYA, val);
 
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_TXCC_CTRL, 0x08A4);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       DRV_DIAG_TX_DRV, val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_TXCC_MGNFS_MULT_000,
 				       val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_TXCC_CPOST_MULT_00,
 				       val);
 
-		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 					    TX_DIAG_ACYA);
 		/*
 		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
 		 * analog TX driver to reflect the new programmed one.
 		 */
 		val &= ~TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_DIAG_ACYA, val);
 	}
 };
@@ -1507,7 +1536,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	}
 
 	if (opts->dp.set_lanes) {
-		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
+		ret = cdns_torrent_dp_set_lanes(cdns_phy, inst, &opts->dp);
 		if (ret) {
 			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
 			return ret;
@@ -1515,7 +1544,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	}
 
 	if (opts->dp.set_rate) {
-		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
+		ret = cdns_torrent_dp_set_rate(cdns_phy, inst, &opts->dp);
 		if (ret) {
 			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
 			return ret;
@@ -1523,7 +1552,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	}
 
 	if (opts->dp.set_voltages)
-		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
+		cdns_torrent_dp_set_voltages(cdns_phy, inst, &opts->dp);
 
 	return ret;
 }
@@ -1591,6 +1620,8 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
 {
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 	unsigned char lane_bits;
+	u32 val;
+	u32 clane = 0;
 
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
@@ -1598,18 +1629,24 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
 	 */
-	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
+	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, inst->num_lanes);
 
 	/*
 	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
 	 * used lanes
 	 */
 	lane_bits = (1 << inst->num_lanes) - 1;
-	cdns_torrent_dp_write(regmap, PHY_RESET,
-			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
+	lane_bits <<= clane;
+
+	val = cdns_torrent_dp_read(regmap, PHY_RESET);
+	val |= (0xF & lane_bits);
+	val &= ~(lane_bits << 4);
+	cdns_torrent_dp_write(regmap, PHY_RESET, val);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
+	val |= (1 << clane);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, val);
 
 	/*
 	 * PHY PMA registers configuration functions
@@ -1628,7 +1665,7 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
 						       cdns_phy->max_bit_rate,
 						       false);
 
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, cdns_phy->max_bit_rate,
 				     inst->num_lanes);
 
 	/* take out of reset */
@@ -1641,13 +1678,15 @@ static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
 {
 	int ret;
 
-	cdns_torrent_phy_on(phy);
+	ret = cdns_torrent_phy_on(phy);
+	if (ret)
+		return ret;
 
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
+	ret = cdns_torrent_dp_run(cdns_phy, inst, inst->num_lanes);
 
 	return ret;
 }
-- 
2.34.1

