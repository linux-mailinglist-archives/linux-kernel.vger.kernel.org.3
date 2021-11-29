Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDA46240E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhK2WPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:15:48 -0500
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:50243
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231708AbhK2WNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:13:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsbwlVtOq2xIy/N8wQibwZf3LVFYrXYq0HfSMA3TwaGDCKNcUmdiiUzjwGK16lSJPikMNfhISW3p8oqSlbu3oDht454P+GD2IGQQGKR7SWwhFD3Ni40B0Asf/KjgeHmo62K/R9e0jE2ag1oKQrtnOPMgfHvYcnWYP8CymJBKaZ5qzeqRH6L0dF1vHLj/TBzpeBPq/900GWctQBR5gB8u18iYrPPGp+kx91yKPG3DEtl/fKJGstNG8eOaT0SBiEh5YQNydQS37gqSieFmi3t3Gl/bbXaYRfRmRzEasaJ/rbUxLM2q8PIXvAqDSmjTMYx1utx6cazMnCAJrpl7KnuWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpiky+TC3tC9gbe3zHPJjehGJrvrjn9meAIyoLwzxLI=;
 b=dLEa9/jEbT3CDPAQeZeHFP9DwoCHEp3RELt8pIbPHTAV6ySg8BJsFt/0/cC5BqTzEyWYMJEsCHb/plBM+ow4RJR4sSKYYVJRuQaBA813/kjDsjczn4b2a9mdHqEfq3rPwZTSiMKB+8yRziELv7NT8umuGd65hYzrUDv1hPq8bZ4Tf5z956nwye5lBYklxV6XXSUPnqoyJ9UH/wp0qpQnT1oq7Wh7rKUtLGARTRvd3f6m+7b5bvcpx58TCH6OnQQChJhnPfUzsEU8zCq1O0xHpPw1KUPIa+TvcMQabU26KxU601KsBbcoKBKAnxzF+bO+OPXI0YbRbLnjHtsevF5u+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpiky+TC3tC9gbe3zHPJjehGJrvrjn9meAIyoLwzxLI=;
 b=mXWSq2LLZhPZmxm7J8KLJ6gT7ii0LXOup4i52G+49hfrEToBozufIgDI86S/FSRr0EVFWxqeo9jcnqelWHD4a6S3Nd+kK99FLhP3m+NWBN1+VlU8j4lys+E8UHglUDkvJuXjqo3wEM/CiVWVY219zrBhOvZwgYPE8qFoDR3vb7U=
Received: from SV0P279CA0062.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::13)
 by DB7PR10MB1932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 22:10:25 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::95) by SV0P279CA0062.outlook.office365.com
 (2603:10a6:f10:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 22:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 22:10:24 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Nov 2021 23:10:12 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Nov 2021 23:10:12 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 8923280007F; Mon, 29 Nov 2021 22:10:12 +0000 (UTC)
Message-ID: <52ee682476004a1736c1e0293358987319c1c415.1638223185.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 29 Nov 2021 22:10:12 +0000
Subject: [PATCH V4 3/4] regulator: da9121: Prevent current limit change when
 enabled
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8c584e6-1f13-473e-1d0d-08d9b3850b28
X-MS-TrafficTypeDiagnostic: DB7PR10MB1932:
X-Microsoft-Antispam-PRVS: <DB7PR10MB1932311653780CED54C0B2FBCB669@DB7PR10MB1932.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pztCrt1JLxVXQoh7HJX2u8o0rJY1B8tRUU+K5sMBqHfyDaHqXCjZJOr9Z+XqhMlo8IrmrialzoAy1VECBVZZOtukV25aRuOM0gYlIfEYEMZZ7ws3byKS+CeBjN9Uhj7yzW75few4KWFXjj3uf5SCAJV/aEcMyyGr163eK0ckOZ+SP1PuUdCFsZJr2ZrVaVIbBG3zXbn75kbYInxJIYwgLFV2c3dJoaQs8iGVBVe4jTCRWel7GQv95XEcxmE/F39SHXKALYlgNPysXTVSo4Et/3xopWo8idNbKzA3JiN4RsJS8dWJoAhrSlRI5+gYrhaUkmNZXgBwTcqCrk8X9Nzn8zH7Ig/YZxs0YcsLVyTY+NC1Jyz8w7ujQXOAMzqDlXyok4fmTkVCHcuiJxd3nYLKrI/2M4Ha6jqGCQxThWceleP55Z/FSVWlYGsb22KggrSaNl8sbs0kTh2l+RFZ0LY3if+nu/ox2epY2ZYijPe5S2VicfhQb+TDj688oRreWMwZOPgcklyKDHX2c4Q/JsMimidGyd9uAL4yNsGXPX50YLD9dX/8AoUQNJQJHljAdk6UtkGyL5YiJeYXoprlq7Mwt+/jADHx5IlCYKEMwvlz31J5sm7FriUHzo6TlNyEpWT09IMiqQch+44nRvaF/F4yZBIwoIxSgvtPlL6jWu+gigZSFBZZ2N1IL++PpzF2CDSy6O/pXGurPzeA7+Ng13TSnlKeeDEXAZpK1Vi/3qjDHlo=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(70586007)(508600001)(316002)(81166007)(83380400001)(2906002)(6266002)(70206006)(8936002)(47076005)(4326008)(336012)(42186006)(426003)(2616005)(107886003)(110136005)(5660300002)(356005)(86362001)(26005)(186003)(82310400004)(36860700001)(8676002)(4744005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 22:10:24.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c584e6-1f13-473e-1d0d-08d9b3850b28
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1932
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent changing current limit when enabled as a precaution against
possibile instability due to tight integration with switching cycle

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index a5a83b772a85..86149170bf6c 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -253,6 +253,11 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 		goto error;
 	}
 
+	if (rdev->desc->ops->is_enabled(rdev)) {
+		ret = -EBUSY;
+		goto error;
+	}
+
 	ret = da9121_ceiling_selector(rdev, min_ua, max_ua, &sel);
 	if (ret < 0)
 		goto error;
-- 
2.25.1

