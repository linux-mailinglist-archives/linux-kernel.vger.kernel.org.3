Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DD4BEEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiBVA2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:28:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiBVA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:28:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42924F23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:27:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXspz0K4pmIkmjUVBlBbrDN6TBnj4PNX5pZAWkA9HL+WqdZ1QWRo+sPBkfUvVQAc7gLL0j8My6jypARWWjdlcVBFDicLrcEHLnmN0lU4gL04ZYRRSem9+VonPzYXnZJLbUqvoprxlu0e2v8mi+s1E0PHyAt9x7/1PVx9Ug+9nZOBO8RIrN4ynQTFogw5mjnBQnXxSbwDwfSYtUdNdpL09s2L9AzksDkvvc3PBoaqdlOm6dVCikgoKAjMegRVo2/ZXTUYRGfBySA+Tk4dOSz4+f8kny6KXLVh/AhZ/8Kobt6gJo86xOF8qFXaloHg6f/WUZLMTp/5b72I/Z9NbQFbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8JBmXEpvT42GipaoZZPRni61jzU1a81+OacjF622O0=;
 b=W7bg9WBzZmiYvRvQiHsYDYEExsmaKmubplXJsBj+CMKFj7+tkbsv28KJIFg8OLOsRwCN06Mt1gHDqDrQfVatFasJBUyYpEDglBMhYXZ+hbmAcfrRCOmhE96I4QUe/VML3v/gY9fM4vOO6YQiaAggS88OSW++YotEfE4jKoREHRHrPU2XQQNB2fiaoPuKtulNymaLFTChfUKb0sbBAnCZtXTAGL3VSGdT0Zf6FLmuStOtHmVVyB9p4yCteUaRv2b+RHcx9axAb4ivBFidc7FWVMuCoWzgfkJnITjrKUQ5Te/w6G1EM56FERl3jx6NJ0ca5N4D2sh9K1mcv0KhRuqiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8JBmXEpvT42GipaoZZPRni61jzU1a81+OacjF622O0=;
 b=w4cFr0cCaX2AciJedbNXO4N6/1lVlaG4+nELG4ivC2VR6UlSRdpPjGLhSU3F1aJPvZwU5v4iEcTphG9KT7dLZZ+RI41J15ZK2j/ZOx7trypl7bs8Laz9nrUPT7sRDE/qz5ShwS6IR2c0NijntnZQZM1HRvY+aDlBDAdbHBrraIQ=
Received: from OL1P279CA0010.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::15)
 by AM9PR10MB4434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:273::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 00:27:49 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::86) by OL1P279CA0010.outlook.office365.com
 (2603:10a6:e10:12::15) with Microsoft SMTP Server (version=TLS1_2,
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
 15.1.2176.2; Tue, 22 Feb 2022 01:27:42 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 22 Feb 2022 01:27:42 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 26B8080007F; Tue, 22 Feb 2022 00:27:42 +0000 (UTC)
Message-ID: <cd5732c5061ce49dcfbcebb306d12ba1664b4ea6.1645489455.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 22 Feb 2022 00:27:42 +0000
Subject: [PATCH 1/3] regulator: da9121: Fix DA914x current values
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 626901eb-a648-40e4-0bf8-08d9f59a27ce
X-MS-TrafficTypeDiagnostic: AM9PR10MB4434:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB44349038D8063BF15BC9D960CB3B9@AM9PR10MB4434.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4jiwWR64iYIO/7mvnvH3p+wuZmfCRvFZgtdbJyVqLkx/jRLi8a3WEPO6JgBa5rmjAP3V4l+Dtx9AdTW41DGEc0a7atWdaVjwSUeulwcqXbJYwthh8ZgvyTj9kDJD4KQt/UDt2kJ9oRM760m2M8hnTVBdVsGLSzanvXMMD9G31GTM39MDUAu64iznd6csir+A9MI3vrkPWwLCcrdQlVrqGifTSxYDZPxB9prm+qv9AOKNYiiAQ/YRHBQaSZgCF+29gWH7+bzJdT9zvqrL3suFxecSlvji6Rt3zcIfwXQ1EgWJYrqRVNk9t9spScSEai0QkvX1otQA2EXSz19bAgXuBzwzIP+MV8dFg+HTgqu+Mv+gsOQ6jHZwPJKdMawsUmbag2XhvVtoCa17ddIvMhMO7apIqLKqq8kJQIhwe2NA4mpxzOYRkQspNcJAtaQ+hBvF072LSp42uGqd6cc10Uf9MFQ5ESY59CsWBz7F3vVQdelWT8UmAMFqrJLQC0Fs4SfS/aNQdw2CDmiVvfxIgejb50MJR1OdoFBJrwV+58NlhXggwygVfW5o3hDl4oyCIdAQ6/ajgszXNrlXJtaoS1TaTAbQCYNe3agGegKPyW3MP8D60+bxqZi2FiOBOqVNBj0eCmN1QiB+xILjQ/AqmOYsBatdmk+M9xaFU9WuKpynet1BH23wui0YJDdlxOaUuqOjxaSkUtYRMCtWleGFLFXfQ==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(6916009)(2616005)(54906003)(107886003)(5660300002)(82310400004)(86362001)(508600001)(42186006)(4326008)(316002)(8676002)(70586007)(36756003)(36860700001)(70206006)(40460700003)(47076005)(336012)(2906002)(81166007)(4744005)(26005)(83380400001)(356005)(426003)(6266002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 00:27:49.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626901eb-a648-40e4-0bf8-08d9f59a27ce
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4434
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DA9141/2 ranges to correct errors

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 6f21223a488e..39d77726970c 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -87,16 +87,16 @@ static struct da9121_range da9121_3A_1phase_current = {
 };
 
 static struct da9121_range da914x_40A_4phase_current = {
-	.val_min = 14000000,
-	.val_max = 80000000,
-	.val_stp =  2000000,
+	.val_min = 26000000,
+	.val_max = 78000000,
+	.val_stp =  4000000,
 	.reg_min = 1,
 	.reg_max = 14,
 };
 
 static struct da9121_range da914x_20A_2phase_current = {
-	.val_min =  7000000,
-	.val_max = 40000000,
+	.val_min = 13000000,
+	.val_max = 39000000,
 	.val_stp =  2000000,
 	.reg_min = 1,
 	.reg_max = 14,
-- 
2.25.1

