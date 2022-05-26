Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3EE53500B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiEZNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347552AbiEZNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:14 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150131.outbound.protection.outlook.com [40.107.15.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB50D80AC;
        Thu, 26 May 2022 06:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB8B2L3P5fmkkzey3BvQCrXpvKiIrBc73m45xwbL/lYtte5excDXTyOb3+kcCWf2RwoPPtD3JDRcsfEZYo0JkMOyEbuqYq9ys08s4zdc+7+xR1vfa7iaCI0fhq+n6ryvjG0bZv4d9wFqTn36jeC2Up8TQ53iXmbMzCl9clSNQaqrAuDFDzMYbBiJ+nbwxf8KFk6h60lT3Tz5g/XBor1y4knU+UOeBzlWKNSKHveyQzleiayxO5yyJgSzmbb3RoQGUTPK3c57dfsd5/Vqhin4z+Rn8UH8cPp+MV2oufHRuWjHvFLDFW1oiAq+fxAE1LA90mHNQVJFxF+eHSPnzD47Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgOWtc0h84OfR0/XgjFODhvBKtLJ+qAcjYntEln1lJc=;
 b=P2zVj9yvj/mcCnk7PUbkdyBmkbFBy/UBbpGBYckkLAh34ExrkC4XT9V+P+d+Hre/J15dmS6PvVcYoQjKvHef0rXo/Sw982TkOw8TX4DaY7Usba7psslVAX5cgtvdr6qUNiO9nkmHDmLawu6eNE76XAQAjzsdE7Oiu1pfgP6fBqyPefeyXsOR8EKopc3Y7UskOhcbukFUSNwIH5pQ8+2WA2PJXtaoGOpw5v5+mq/NUOBTAvKzIemFUsg2W3SJFXN3fAYwA0JDbPeskckvi9PHdcxeZh4yrIvunrY5eJnbtjh3G5ZdqSsSMjnLuLeVTXVZ9yHQyGtANonw29fkR9kDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgOWtc0h84OfR0/XgjFODhvBKtLJ+qAcjYntEln1lJc=;
 b=LkPwP9cPR8xmbPbmdhEIV9foJ9Xr1aDHGinMJHBGxjQ4dNz/i5fe5KPNzpMEXaIcDULjmfR6deM+Ps/Oec2JZWcRZ9fykF7I2ezLObn8eaOU5mokwj+MLVAUHMAs0hEovFOtlWs7qOHeUThxVxL2vBrJcgw8tg4mS8ggs+dUuBU=
Received: from AS9PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:20b:462::11)
 by VI1PR06MB4430.eurprd06.prod.outlook.com (2603:10a6:803:5a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 13:34:07 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::99) by AS9PR06CA0018.outlook.office365.com
 (2603:10a6:20b:462::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 26 May 2022 13:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:07 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
Date:   Thu, 26 May 2022 13:33:59 +0000
Message-Id: <20220526133359.2261928-7-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d171cc8c-10ad-4875-68c5-08da3f1c68ca
X-MS-TrafficTypeDiagnostic: VI1PR06MB4430:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB4430A1DD23E48842873E5616D7D99@VI1PR06MB4430.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZP2hpFKF7oZ43SZk825UTvw47rDxne4vPo2Impd44PNmcHIFZfAX21mU+6Tp4S3UfmuggnYc07/KIhoeg1Z8SM5ZzDt5uLFMp2F5R/vWF9GurswIyd9bXEj8Bs4U4oatWgiJu3Gf/sKM4GPkSQ9vLQMn7gIlw9pxNIgVHNBSAlGzbhmnny5KxZ4vwOwd7b8PmTSzY5EHm0iqs5DWO5jxx5kfvse90gHjyyFONTtsaz5yVy7gJLh/wTA1aVOzRKZerNllpiYnvrGBVwBM5Ul4RuDIaT+2dof1waFRbLNDhZzF0AFnsVu+LokcsYYqtEdjgHgco8IVnoFHE1W36o1lo0k41DTeMZjO4quZNPgW+9j/KkIseOI+Wh4zy3mvniXwOjuVj99wE2uDtTFidez6M8MVdnaOBpccsD5XU1yRQP36zx4Jfy8+QDAAklYZZWmGvQC0e1USyhJ4YyqZQZ4Y+dYqMAnquNb/6fAT7KAwwOgCIbnN4NFIY67w85K+vLZH+hR9LktX2UAaaVU8uiHn55Mxc1ijVEPM7R07a1zS0WGvLylgUlgaQIzIZeuC0yKHzQLkd1yCowxDhXapyZxdr2yPrlh5/n64/x188fahLN2PsQyP/xYtEJRyZtUjxUn3+tlIRFW/2vKcMYZnHYlnb9AnNu9ZjH3C7i4LcuRwhc1+Drdm5fr4QMEhVMe+S8BW85Tp/JlOydjUOf3PKHUj5V0WYnrsC6c+YQ3XpF/TTUsUo9TQQeaq4H/19nGd9Uo5zbAP57g8RpHcdCCJRKRlxMerawasN0UFxccJDirz7iM=
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(1076003)(107886003)(336012)(921005)(83380400001)(356005)(81166007)(36860700001)(47076005)(8936002)(118246002)(36756003)(5660300002)(2906002)(4744005)(82310400005)(70206006)(6512007)(70586007)(508600001)(8676002)(4326008)(36736006)(2616005)(956004)(26005)(6506007)(316002)(6666004)(40460700003)(966005)(6486002)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:07.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d171cc8c-10ad-4875-68c5-08da3f1c68ca
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the device-tree bindings for the Bosch
BMI085 and BMI090L IMU, the accelerometer part.

Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BST-BMI090L-DS000-00.pdf
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
index 911a1ae9c83f..272eb48eef5a 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -17,7 +17,9 @@ description: |
 properties:
   compatible:
     enum:
+      - bosch,bmi085-accel
       - bosch,bmi088-accel
+      - bosch,bmi090l-accel
 
   reg:
     maxItems: 1
-- 
2.25.1

