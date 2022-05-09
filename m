Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26CD51FED3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiEINuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiEINug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2090.outbound.protection.outlook.com [40.107.20.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54F616ABE1;
        Mon,  9 May 2022 06:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPisYVYOHuSOjkcEVDYGtFJI2N0LCfP+Ap8x6ylOCSdDeZglXKtVTNULKEhHyYdMYs9RsfghDCD3xrDcV++PwjrKjYNG6cl+mVxOc6wsgO+9wilkraD7DMU0olPPSPlrli6zZrtHW23L2Zd3aKcT8Sgj6o0/yny/f99fOYAPKkrOkF6rp7cPx/CuEkmDSO1ubt2RiK/PORbGBB8sROBjaf5iKuRC4JdN252xhnLYVvJPVOxN3H45WFAViaX+8f/JvUot5g7FwQkESZkhPn7n7dW1ryMqK/CGmzReRj6S1/fT363JwkwSn3K8TKrwZ13xVFtQm7uPUhBinIXjfhUvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlEkrwvPmPLUEGkqiOTJfvym2l2BHiouj60mFnWg1LU=;
 b=NceNn7Zs17eXUkkEe1OZupKLgFDon6c76R2zcW1j7g+EuonMPfuF1z0o89MGEeQY5V5kLWHWiy5sWjxC//Fz90hmu3jrAaDR84do7KOp/bsAFKD/mtuhdGMi+UEzH8kEMvhLB+oAFg5T/smarDRGp+BKhqN/qdSmxjRPtpmUDOvGZIVj2THyEW7dB8k1gazBv7oHfYXUNO4dP3LapI+3hgEycDwt8fe/IoJoEgAj4NqkpOBf9+Bd+g/viO7+T2X2EHjIc2uh9RCebBEZM4bhOAaU1PViMiaS13jeYIAUq/OuZh8ieeZ4ElEQnek7Oyt4f9bZkxZqhidUqwdz9Rr9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlEkrwvPmPLUEGkqiOTJfvym2l2BHiouj60mFnWg1LU=;
 b=Y8zHMbztS1AKB5eM34dxC7N43kiBLzSZYEajOM8LSPegeEIE0SKlOh/betF6OWqhmM+GTe8KI56P9ANvqIeoU8VO3QTxeQ+1rZCp39QH/hKfy9/A73t9qlKn5bRPqmFJDGzXhDQEpsPqXOFlqYfDLSi5ht2nz2ecbUuDtfZZX4o=
Received: from AS9PR04CA0061.eurprd04.prod.outlook.com (2603:10a6:20b:48b::15)
 by DB8PR06MB6137.eurprd06.prod.outlook.com (2603:10a6:10:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 13:46:39 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::63) by AS9PR04CA0061.outlook.office365.com
 (2603:10a6:20b:48b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 13:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT056.mail.protection.outlook.com (10.152.13.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:46:38 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Subject: [PATCH V1 3/5] iio: accel: bmi088: Add support for bmi090l accel
Date:   Mon,  9 May 2022 13:46:27 +0000
Message-Id: <20220509134629.440965-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40616598-fa07-428f-a4e7-08da31c25790
X-MS-TrafficTypeDiagnostic: DB8PR06MB6137:EE_
X-Microsoft-Antispam-PRVS: <DB8PR06MB61378C9BF7FB1B9B21B216ECD7C69@DB8PR06MB6137.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR7qZ2BY39oI51m6iumEvdcqpOUky0cGw5fX0ezyhrYarfooBX7m2K1Ak9eeyrG2pgyISvEcomGgJNl8YEgDOB0gGqh1aG6w51DFyOY9O0tY38yrc/6zTy7KzRNs/zLlM/dfbAmQDfFUGFn12XWI8YtBUgLmwdRyWdR0XwJFGEuMwTvLgTlHQBcN8ZIt8aGlXctJWOkyExC41anL1kMkLKw3J69wLeb23Qq4QyfPN3HXSXgqoIMTsVsU9sDOB3YsRHRnNh6k05HiH80d33w+VF21S9eIvECMmNnFDSGTTqTpL7+wrCR5t5KcPuYVlTk9PTwBM4f5UQSKdAlCSB+VPwl2hcQ2ydiDMetga3IFJp4kmjlRqr63F0+DJ436nSxmAdlExOQ7Abo0TCcbpDAZh2N7BqPoai7id5hXnlDEUnmDOgKLFsso6Oo5U31AGi0vLfEeYCaorB/d/jZfpmmiP/caWu3B5xzuHtikNL667En2r8Q8oSdWNdWlSswvGTr9/WaVCchj6y61jQb81GDdrCjO0iRk66oNoMlyxV1r1xSAnkFt3AyV1gEPJNL+b8ClVGePXQgag4111o1OEy6v36n3dJ5BtrdH6+X4Z21bnqVIzRcvagPTWJE6M5s7YVFLiJAXBXSgWe6sfX1qBTfEfuwxFFqKmzVI0/Se5oV5ZmJKYG0f5wSHWTvZLNkDtvEV
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(8936002)(36860700001)(356005)(8676002)(81166007)(40460700003)(508600001)(2906002)(70586007)(70206006)(6666004)(26005)(118246002)(6506007)(186003)(2616005)(6512007)(956004)(36736006)(1076003)(5660300002)(6486002)(82310400005)(316002)(47076005)(86362001)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:46:38.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40616598-fa07-428f-a4e7-08da31c25790
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports for BMI090L, it's a high-performance Inertial
Measurement Unit, with an accelerometer and gyroscope.
The commit adds the accelerometer driver for the SPI interface.
The gyroscope part is already supported by the BMG160 driver.
Same as BMI088, BMI090L have the range of +/-3, 6, 12, and 24g.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index ac8acf6e2ff0..44cbe098c093 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -442,6 +442,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
 		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
 	},
+	[2] = {
+		.name = "bmi090l-accel",
+		.chip_id = 0x1A,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
+	},
 };
 
 static const struct iio_info bmi088_accel_info = {
-- 
2.25.1

