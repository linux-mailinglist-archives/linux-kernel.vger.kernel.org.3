Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF18351A106
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350640AbiEDNkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiEDNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2116.outbound.protection.outlook.com [40.107.21.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E421E2A;
        Wed,  4 May 2022 06:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoPA10fJHKO7EomwyWCG1zdZLBXQnUPqfL+krqZbKP8Gn2+l84UkuMyaegHNfHL2UbduHGSscZEtgD3P6lHsSyQAjdGD+m95O3h2UWwwM2OoY7I3gECzS5rB9tYNJvyibZ2wHInmucrcRtzZKXlxDhRwmzuhNskCNocHdepTCEo4cH3UgscxdAt8iZ46bnYY5bcy1o8K3RRIvstVJulj46rB/6cFFEIvXC0yllrxq87UTGvbofaM22ZbVOAi5YNbK4pASDF9AyXPOZyu55qtSsuB5D0zVkZTlCa75GIhyeltbER6AmQE4p+R6+NtkhUMSBP4HiQSh/GUF3EXOiyIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0nnNoFM7wJRZnhOhVVW3E8M1ck9zuTZJEGd4584UM4=;
 b=BD9uno/TaBu6LYbhDQRN7n76CdN0OwySShXbnxsWuMIc+fH2dTG5a/at3kgmobbGh7/vp6okrI8HmBAuKKcHhfPsEcSuCDdQ7XyiQjLEb601iUYYbOKBAVlXeJziRdrIfl6tNvETS6E/n5RlVgZXv/2jTihBZbmOpe7UNcGF8O5Tj+iq4FG4gRD5uh2XSso4DOp6vu7+PGAsLpMJBaM52E22zMWTlwyqw51sTVrvorSWLm1vIEV21Mc6Y7UXWfoIzTXD+gPwMeRWVgqNnA9pOngFh9OEjTon9PfHRc7CtxAfYXvb3H0fhynLp6irCKQf4bpzGcyzA4f1K+b/qkIQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0nnNoFM7wJRZnhOhVVW3E8M1ck9zuTZJEGd4584UM4=;
 b=dFs72kFCF5Upq+2ADt4CX5w7g2YXXQ8ZHi1w72pNVL3b2tjiaPlhb4r3lftjrkd8AkNODv6FzhlDXovHxwiP3LvFMMyQzxyW/3rz68F57aYSMNHV5F+3wgCVWDZkfog32n5cL7Vh8c/79lROQu7jjKO0SgRntpctdD3Qy6v+bzY=
Received: from AM6PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::20) by VI1PR06MB4622.eurprd06.prod.outlook.com
 (2603:10a6:803:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 4 May
 2022 13:36:15 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::ef) by AM6PR01CA0043.outlook.office365.com
 (2603:10a6:20b:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 4 May 2022 13:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:36:15 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V3 0/5] iio: accel: sca3300: add compitible for scl3300
Date:   Wed,  4 May 2022 13:36:07 +0000
Message-Id: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f2f357-4a97-4526-7d21-08da2dd30fc5
X-MS-TrafficTypeDiagnostic: VI1PR06MB4622:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB46220DB38A4D4FA655D5C8B3D7C39@VI1PR06MB4622.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AB6zqcf/j+iaUjI224hwPSWn355yk3F3um/zWlqz6+KDoQjEMvXtLVJ18R462Lze5NM2Zl2b/YeTtl2coFdlwZbt8LAwovZytARXG2XxtYbpU5CkUkl1MMe55fJ7EE/M6q/UBB/J7AHe4rnXm2nCPKWfY7tyEs+xYM8Zfdz4y/3nMFgtpj6t10v3K+2BTk3gXoZqzj/Ir746e3AYxB5mlF/ZK3ob0Uf0yJ/hudy6j2T1D/r5dw+hgiLqBeOuNhxUz4bfrRjE4ugYe4pQ8+v9Xaivky9LSQ3mi+kdIl/NCqqAEHi1V1sHKY31++NKXGgd71iY/A8TF/43gRy7vgKJd3U+RCufT8SnWdycdibSYthZsgUZ4QXSF7OAbDVaS9mZt5l0vIblZbq6jvhHKCaFL6ySGt9eSyUor9bYafbUwlThaKKan7xGh9j/sJhgVsd99r3ueU+9JwMglqPsB8vC043bXlUx2DO0gr2pmfAfjPKhJ3F53ePH57hVk2zKzToLSoolEGTD/hnSm3070Oftu34cuQUFxl4krUNS2mYCXMunXYDxyUN8fa5EjFYYj2K7PyFweLU/Uu+MTlQUA4jSq5LPcPfDn5WTTCAiwHHyaf+BUbo68WUKnR7yqhKOBdxJuizBUDBOkEVdIfSKRlmdlaVuH/EOJbqcjZryBVVkwd4BCT0k1rAq9HB0LJQLVMH8
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(118246002)(36736006)(5660300002)(82310400005)(6512007)(26005)(508600001)(6486002)(6666004)(40460700003)(8936002)(6506007)(86362001)(36860700001)(2906002)(4744005)(356005)(70206006)(70586007)(186003)(83380400001)(4326008)(47076005)(36756003)(1076003)(336012)(81166007)(956004)(8676002)(2616005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:36:15.0265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f2f357-4a97-4526-7d21-08da2dd30fc5
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only.
Modifed for support SCL3300 as well.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output.
The change adds the support of scl3300 and inclination data output.

Change in V3:
Add the accelerometer scale, frequency, and inclination scale mode map.
Add modes available for each device.
Drop "chip_type" and add all the chip info in the chip_info structure.
Fixed other findings in V2.


LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 301 +++++++++++++++---
 2 files changed, 251 insertions(+), 51 deletions(-)

-- 
2.25.1

