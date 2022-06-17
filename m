Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7E54F5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382179AbiFQKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382168AbiFQKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:48:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97D33880;
        Fri, 17 Jun 2022 03:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGp7NNJruP+vxEd5nopeNuXMbNRFMTrxUPJ/VaOat0w05PlbZ/6a4yWxo8iSCfZArtquOH6FMKXEnJXAZD/OwjF2KMvUICyQUQKvikptai8wPnphbfGmV+2hFZKZOXd0xzp3eFw1k1SbRuZJFZx8e3M5coqAvQuM20WQbXk9nmKicq5D62WHPqGMe0Vb+Z5RdB9F3pP4sZoKSuiHgqbSixud3yfYzqRbZOT78TcXERVWyfsZ3cXHUKLpypX1ojEc2s1+VRV+QMaWQRML3hBpI1jHGnTxPogCoP7EYqa0rsc9c6/p07mtZaVbMc53l2RdrLdSLfZdfM1JpfkGyegxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3leZdyH2CWEiL6goxTy7JcaId0/DW7Ts5Og7sylZv4=;
 b=ld7bo3qppLZqWrTY1eUteTYQFrlmMivdVCzL1ecPRy51Y5SX+RahrHctLsdlbzLZJRYpfvKakl4tlBZx3ZHFG1oQ/hiHhNLI7j3b0GE9fuWmaqlcMOs5aIZhb4/Q/dbS7Ark/x4QASOsIPXItJYl5Q9yOcDMEIhB2GeOqgVj0tw3ezaQNbP26RAs4HBgL5YnD6wOmYaemcMVrkMfghsBENeYuUqDp+QlLAxScpW+WacQhFNZAfKJOEpK4XbxKjO3/eUFeT7oK2lSjregYv/5xmP2CSoLhtglNIvQiYUMZ3sNtD1/4feMsuAnbkdMqpfTI5xhUrZTup93jCMv32o8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3leZdyH2CWEiL6goxTy7JcaId0/DW7Ts5Og7sylZv4=;
 b=WNDmysrJuPlscAlIcwhBjsuka3Dnbo7hVRGPSedAuQ3NcDneWNgoVrT83++Zwgj77hfwEyZj5by4u0WZWJ6nWn1pH78DdzoEOsOMaqyWRu1nqqjuumPY0Jsn1OBawv1HjfCuPyAhrWSPcPuEP8q8Y4EJ+6nxw2lvT0XsMRkdM3s=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 BN0PR02MB8061.namprd02.prod.outlook.com (2603:10b6:408:16e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 10:48:07 +0000
Received: from DM3NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::6a) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19 via Frontend
 Transport; Fri, 17 Jun 2022 10:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT023.mail.protection.outlook.com (10.13.5.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 10:48:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 03:47:41 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 03:47:41 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.1] (port=60018 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1o29Vt-000Azk-1E; Fri, 17 Jun 2022 03:47:41 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 14964)
        id B371021632; Fri, 17 Jun 2022 16:17:08 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 2/4] dt-bindings: pinctrl-zynqmp: Add output-enable configuration
Date:   Fri, 17 Jun 2022 16:16:57 +0530
Message-ID: <1655462819-28801-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5cc2bcc-e5a3-45b0-1e57-08da504edcff
X-MS-TrafficTypeDiagnostic: BN0PR02MB8061:EE_
X-Microsoft-Antispam-PRVS: <BN0PR02MB806198D64581F652875AB948BDAF9@BN0PR02MB8061.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEO1Vsu7GnjgAkcBrHyWpag+ReUE3YJpxwH6igWQYczUwgZ8b+ldNwjGBhxDQKa/b80Ekj48doqwY4WbYMz7AXXkiCV1zgxnpuaKeg2n7YH8FFvsuceT6pe37xMPspsT7P3jBodCgvkQhmgPC0bVBljjXHUgX70UcXSu7iGRoxKWXOch5tK+hJlJae50DY7K2px1EpWtZIeg+erl36+WeBzbp0tc3FSuYHfPVwbosNTAsl9AjStiyWcsf3/l74KhaQFeMQb40fSGofpOh51BqrbDjQWFkjkrdi5t2Bmw9IiGByyVACHto8G7eWXl4R+SCPspaRwb1+PyJr44Kml+ObhwpjyjbCNHJxD26aTwLhSyORkNCMqo1t70Y23q9eV7hhotmGfED+7WWKzJKskAv6MI3Jv5UYwHVirJbeYACQHMxdKXAUyit7XVBqR1Vxr49ey8TxihZyjF5xfT4xvjwy8M7l2f5YSqX8C9LvJIHbaFmrV34RbAwoGjyFNRYJVQBsAiNecG1jbrj6y5+hDcQ4H1UDQeczxC94brdnnAspvJFYW1f4rmD9CrEpt0ZpL2vFUE8cVCGi5OIdzRKrZkFnst8xjYFPGugwGiLX3jSEduHyFbZYPkE39r3XEtQz4TyZwmimnyDkvqfCSTzS/MHqo1/5vn6KnO1loVUe+qxyJaejsV+s9eqBEmiPnrZlMbzQhcSdlK+dCZQtJaZVy8vA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(54906003)(336012)(107886003)(110136005)(82310400005)(6266002)(42186006)(26005)(47076005)(70206006)(2616005)(4744005)(426003)(186003)(5660300002)(316002)(498600001)(40460700003)(36756003)(4326008)(8676002)(356005)(6666004)(2906002)(7636003)(70586007)(8936002)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 10:48:07.0787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cc2bcc-e5a3-45b0-1e57-08da504edcff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8061
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'output-enable' configuration parameter to the properties list.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index 2722dc7bb03d..1e2b9b627b12 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -274,6 +274,10 @@ patternProperties:
           slew-rate:
             enum: [0, 1]
 
+          output-enable:
+            description:
+              This will internally disable the tri-state for MIO pins.
+
           drive-strength:
             description:
               Selects the drive strength for MIO pins, in mA.
-- 
2.17.1

