Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E14BEEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiBVA2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:28:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiBVA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:28:35 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0B255AB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQsTBYFwcmjWBGFK7TRAM60qYNiLiOSg9RsDDyoX4fibHJ09mpipBpzkat5JkQP7zUOjVaCQKsLaszxBndbwwiPwoBqvtQHcm+1JaUKxDG2RL7CKpFfApxMFAmV2lGFoqkGPIz23i4wSxE2NT1U5F0t/Hr14LHGy6H+U8DgN2gpjlvhS4dedeg+iQ/mxSUFvp9YxOFJwBctO0xEiWc4oVxmHvccKydAq5UM8yVSSjww1KNnCQ1dQE7dhjDNF7nP+s2XmtTRMSfVXfEtEQfhe7MQhy+g40qsLLKFL6bK3Z89Ci/71R9dmBlBf+ql4p1Oq3Bd8aLktrBamk5aSJxEV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2161rDSD6x+IeZD/Bh95DXy1AvwCiwowZSpkrBYX10=;
 b=biRIMPlki6BN8a4TqP7pO546D3SK8aDW+uytkOe+06JUkc6CHl0NTO6p1h0OVcR6NjDfevfDhVmTTxO1e6NVk/qWsoibstXu31kByVTaHZmOvUx1V0A0kj5FVtM6FnIDtkGiC30wJXessXTpX0ZOzdBihHzwLTqBeJikvbC4LCpbKY9K5coGkcMoOypNBHwWcrcMaIXIqPSeUtocvlARFD9Jr+Pl8kMq8Lty27O+7tMvYabU12yxgh8y+Qf/e9r0sNIsgfd+BQker4InZA/a58ULg61lg3t7NpzsNGDfmsSHAEn+fjz+m6I+orEUaz/uAYXfG3qKGKrcUb/uO1Yobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2161rDSD6x+IeZD/Bh95DXy1AvwCiwowZSpkrBYX10=;
 b=LS1ryKNU4XVSCG1PL7k8MagmmJzfzrORopN2ZtZfLBfyGBTCwpKJLjKPgTYJOLDwY0pC2rp/1OrZVuwv/leYDzJ+twXLdgJpGasVoVflZ2FVQiEUYrVg5sok/XHruWW+Q5irhyDBuBiGkhtQDs2L89R9XHZ11jod2EC/nQ28Bfo=
Received: from OL1P279CA0015.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::20)
 by AM9PR10MB4466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 00:28:08 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::52) by OL1P279CA0015.outlook.office365.com
 (2603:10a6:e10:12::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 22 Feb 2022 00:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Tue, 22 Feb 2022 00:27:49 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Feb 2022 01:27:43 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 22 Feb 2022 01:27:43 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 2E4BB80007F; Tue, 22 Feb 2022 00:27:43 +0000 (UTC)
Message-ID: <9d1ec5b6db70d27f56d05b8a0139fc0840f03e20.1645489455.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 22 Feb 2022 00:27:43 +0000
Subject: [PATCH 2/3] regulator: da9121: Fix DA914x voltage value
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb39d836-a900-438f-de33-08d9f59a2823
X-MS-TrafficTypeDiagnostic: AM9PR10MB4466:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB4466DE5BF5375C7AA0495A01CB3B9@AM9PR10MB4466.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2SD4ZtV4bn6slf8Pv9+xIF5qv+dFvnlYJtAMUecsgp3RHGSrmcPI50971Wqo26aAMNNX7GTyZOSv4Eze6oUVia7f9LKbQHE61uMstAaxby1DhwRRsktF5TAB4JltvbMPuT6t6de6VgiNQ9XulnzrZfWT9MmIah8Sm6j9Z1vVDI9+eQOm+SHywtTTvyPWo2/Guji+4FhWr7cgQPoHho3fW83/ZCJZdOH/Nez6n0Q64eS8K96k+1vTTeF8DMZWVAHnJ2QYTGlapOX3YkbcOJrbWOv5eXQpmgmpvbK4JZRZtYbBmBXd6gvtYv3oaXY/ke7ZI/O+gQK2KoqrgG+PL4s1/nJrutSO1cgZ9p+TRwH+KQux3kCQ5pQImm/EzCbzYhbVPvH9Bl/SRSpU/1N1I7R8LVq9nGgJplMvr01bA1CbqvSCWmQM7eW44lTUHfn9+hg6yxw0v5MeARSRUg7aWn5M/Sw7S9Ph7aySQ4kfqjgwKadF8P6WQfNQs5YnImxjFohLal+kdyTClc9cwstjhy46CZ8LwvQyyXR9zO6cK7BIqSxoYYqmkWwKKedAd/M5bxkK/u5thMN8WVEvvgDcMEUlR4N5e9m2NKuO+1uS4Fa+pVXsX/aplBtYlwy5JwYs7Uaj+n5TQUH+aXEmux0hxqm40c+gpAYXGD0fYp55zaWBbg53djTe2+ZiLdjpwCPUwSPjIFLnfjug0Xs3NxUsSkwiw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(107886003)(8936002)(4326008)(8676002)(26005)(70586007)(70206006)(40460700003)(4744005)(356005)(2906002)(36756003)(2616005)(81166007)(186003)(426003)(508600001)(6266002)(82310400004)(336012)(83380400001)(36860700001)(47076005)(316002)(42186006)(54906003)(6916009)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 00:27:49.5750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb39d836-a900-438f-de33-08d9f59a2823
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DA9141/2 max voltage to match spec change

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 39d77726970c..f16649dec17e 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -561,7 +561,7 @@ static const struct regulator_desc da9217_reg = {
 };
 
 #define DA914X_MIN_MV		500
-#define DA914X_MAX_MV		1000
+#define DA914X_MAX_MV		1300
 #define DA914X_STEP_MV		10
 #define DA914X_MIN_SEL		(DA914X_MIN_MV / DA914X_STEP_MV)
 #define DA914X_N_VOLTAGES	(((DA914X_MAX_MV - DA914X_MIN_MV) / DA914X_STEP_MV) \
-- 
2.25.1

