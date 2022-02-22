Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822E4BEE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiBVA2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:28:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiBVA2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:28:20 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E244F24F23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:27:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONS46JxU8IbAyjTMavZ17lGPKs0j0Zn0YdZBzWHVF4fNNqfFp7UJNTkakFoZbJQCJdtS2YSuhST69Qp5kH7U6c5u3aShf4vnq6HFp6+0Yn4jzpUg87xYwvuX7QTOj4O74YEiMwzZISTBS/kSJd3UgT1cLXoGGtlcyisGilWAczg/2Sa4CuSk6gVIfpWt6xCaZ/b3gVdlbqNlIrbEhs5Av/tiqiIqy7QB9llPozRMEZ7r3BkbNojQt2SSwzkulDiWlj3SGtOKEUwX+E8LMRpb0rFf5hdeOlw+nVr86wlOP9gUPpOW9bGVLpg2i1Z6hdDyRQC6XF4M3z3iSHtDzWFTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZzKrlZvv22gLSnXEnz4pVhOkOJ7CJIyRuVXTVbyr94=;
 b=Q5GuKkx40meGd41R/Uaan91X9hAHWDjAHpE5stIa/fo4+V4qEYtSsiViwwmTM7tX6l9dxYOzF8sFOUAj0G4eM2LGBOJrtVfuhaUQ+dp72UuSh5SdKm2Px+Sh/TN/tlzckaYmp7o8WyopwNzC8SAmivBY7SOO2cIkan0DQFNj5lu8mVG4gjTjLw8z+YN7tPXW5y1jZe1OQPN2o8k/4FkZxTNv5UhQFbPMAso6WrpqtGqyAVxWfv2rLL1HbMwzQp9L3Ohg5lok6LU3bF4R+zDxMBLr3lOXXBZk0agETOql0RWT7//Pxg/Vg6YHmuxWBHFY0vDGnzleI9acoasZR0VKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZzKrlZvv22gLSnXEnz4pVhOkOJ7CJIyRuVXTVbyr94=;
 b=j+zcajsTLKrfkW6Nm5EjH5YBubHUQQDxM40BnKQ6ag51Cx0aLF4g2a/qhSKH+IpAWJQzaW5npSfT9P1+QhEt11BGXIS/4KFBM4QG3ADuKUReTPyGlnKw9/yBgJWpupG4r15a3eyYjgaFNc6+ejhpS8XqYG/Dt46LVEqSuhw72TE=
Received: from OL1P279CA0009.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::14)
 by DB8PR10MB3660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 22 Feb
 2022 00:27:48 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::4b) by OL1P279CA0009.outlook.office365.com
 (2603:10a6:e10:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 00:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Tue, 22 Feb 2022 00:27:47 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Feb 2022 01:27:41 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 22 Feb 2022 01:27:41 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 2098980007F; Tue, 22 Feb 2022 00:27:41 +0000 (UTC)
Message-ID: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 22 Feb 2022 00:27:41 +0000
Subject: [PATCH 0/3] regulator: da9121: update DA914x support
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2ac211c-7678-484c-de66-08d9f59a2718
X-MS-TrafficTypeDiagnostic: DB8PR10MB3660:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB36609AC09518C9526E2501C0CB3B9@DB8PR10MB3660.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAps+GjMkOoF7/3HMwoEhmoInl85LAjvPavu2b+kgwSst8TBYtC9D3UdmOoqsEBBukotP1HJl9Y8SFsYNtunFSev0gFhIKxXb6NRfi+WvjFOWTqyopUTrx7cmXmR7yQD5R2SXQTec5lFwIH9c5/TZQEMJyHaKhfzYcNMRLG3uEe0ZZUtwJSm6L585iJsbvGylYUMS1TQLZdGYKYrwljcGChHbO2KjlnyfAgZl1giQk2irhjQeMTW+TiNMicqAj7W/Mtaiz4+ctlatLYEiHLq7iOJkZ5Kg71Q/VoDjPLBMIpV+AGHjD9WctyUSc/D8Cym0BBSFTJqsV0sgm2Z8IXqDOr33z8SuJop5pnA4+5RTMA0bDbE+ESunnwuXNXodjTSyiIV673hIvOMUi2Vb7WxXhaEqHvc3G2OAopZqSa4cZtQJOrPy+ZZ0jL+avLoeosOqIYWDu8D+NFDU+arngKLzIOd4lrvRG+MgfgfPJOm/+KagluiB15NoLWrhPabQOQazncT2C9CFtWovmKoCAvO1Tf3fsO5OZYXc57XSbmWWB8Mll9/VwHd5ddNgoSrxeNhOMgqVxh7YZzDRfk06hoMefSZchmDfJdekwB3I8ZUfGOQla3ZDQVU4blT4ZN6IJmskqkIFAbUWwAcnfz35gr8HOXwBt69IqWjb1O90yFf7Otkb1QceGXpfifLzRd+Wv8QU88xMewDn3IwCxHtEGN5EA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(426003)(2906002)(4326008)(107886003)(86362001)(26005)(186003)(8676002)(6266002)(70586007)(15650500001)(2616005)(4744005)(5660300002)(82310400004)(336012)(508600001)(70206006)(356005)(8936002)(81166007)(83380400001)(47076005)(6916009)(316002)(36860700001)(42186006)(40460700003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 00:27:47.8252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ac211c-7678-484c-de66-08d9f59a2718
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3660
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series applies corrections and updates to DA914x support in the DA9121 driver

  - correct errors in current range
  - update maximum voltage to spec update
  - remove unwanted settings


Adam Ward (3):
  regulator: da9121: Fix DA914x current values
  regulator: da9121: Fix DA914x voltage value
  regulator: da9121: Remove surplus DA9141 parameters

 drivers/regulator/da9121-regulator.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.25.1

