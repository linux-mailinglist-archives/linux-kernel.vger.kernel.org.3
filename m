Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB174521D28
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiEJO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50131.outbound.protection.outlook.com [40.107.5.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AAD24EA1D;
        Tue, 10 May 2022 07:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJv7MgTsQPsDgjgZKF/ZLwpJ3P/mdDgP6E5FRXotI8ESDA8G1rT8WfJ9J3vvgiN8yL0SgC2hNHO2CD1un4SV24YbL9dNpHK0KrGziWlgQg8s9oG3NEHN6RSrzR4WJOfPncemJUo/8Mfoh1YJ5nxJKVA0Mdjjurt6eOVj0pSzEF0pI6a3cnHlJ9NRdvul/PvEhfsCDHY7+dQqv9hgANyARA5Uj66QmUPGhxW1/xAA+gpVz+Bex9IM7v5m8vN3taJyyFF21v8nRKz8s+XTiwqE7lxY3jpO9oMXWxzaPQ/ZkMrUxsE6LabRoJ+JsgUZlgcjxNaixPW1Dc6bjxNv5pw80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdlnJKotzwLcTK+w90fDGpieY/qimhwVO2XrhgD2/cA=;
 b=SBaakzde4JXhMNj4SGXnOLG++hUXPxy9JKiOXdVhnmQMEXK0ZT1ozbM9fW+PcumO1iOXcDtSjjBCrbNcIri3yaRRZHGOyPJHtmUGoF3CfJ+Km0QgFibZ3i2yI+/zFjQYOYsAwOHGcwCfzNCYzSIniL2KI6A51kVMoCqnC89bR5TD05MoNJAs97BRlP+E58MB0Vo3/vMkKstT0DvbvMpBQYKKviGByfO2BFqUKCnGYEm/xhZ2lgqPzS9SrF6M1h9sQy/Y8ae2MA6UeBUhEEuZEtY0iRtEl0NUrrBFSzDb74bPORpZRdfDErXrGOjBDspfF5UDtzK7XB90vnMs1ru7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdlnJKotzwLcTK+w90fDGpieY/qimhwVO2XrhgD2/cA=;
 b=hXhOtBT9UbhAq8lZGY41q9e11krBS+ItTKLW1x16zjOyv07QRAufWCDxno23lVBeNLbwAHkKJI8lTbPXG/d5xzfr1jZl+9yD4uR/UyHfvUzOfz3V7HNcPJBD0708raS1rMNTtWECNHmQuRtmEytYbBwYmO6utcf3mvpk3J/w7kM=
Received: from AS9PR06CA0341.eurprd06.prod.outlook.com (2603:10a6:20b:466::14)
 by AM0PR06MB6337.eurprd06.prod.outlook.com (2603:10a6:208:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 14:17:57 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::7) by AS9PR06CA0341.outlook.office365.com
 (2603:10a6:20b:466::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 14:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:17:56 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 1/6] iio: accel: bmi088: Modified the scale calculate
Date:   Tue, 10 May 2022 14:17:48 +0000
Message-Id: <20220510141753.3878390-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c10b9ae-9c40-45d0-e3dc-08da328fe183
X-MS-TrafficTypeDiagnostic: AM0PR06MB6337:EE_
X-Microsoft-Antispam-PRVS: <AM0PR06MB6337FACB102CEBD01D24CDE9D7C99@AM0PR06MB6337.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txXvBx4SlAMRMOnoQ5VEG1yAGBqfK5HGglmIl0axVAUaZpTSqbop6aEDDAgsgyCXFnk9gXdbTz1cjW6DlF77q88rW0HuVraL5Q+m+SX7rQHpmQDcNesdSNJjekMraNFRELBHilL//Rt4SrtweLRzA332SHFhEFBlv0eHu2oT1xtFV+6yKc82XrKke71VQ+tkfIBvNDLHievwTpMYUbwZ4/0bWa39dpCju+WxqWT/pEhPxwLqTSTh0XU+hSOM9qyWvdBELWtnE/9SwNTdToH99LjtDtxRNcXc9ko3TiBaC/1TEX+W1HjqmrVfnynJGhq73rJAVTPlZi8EOHIgKAtQfM7xMA3pUZYGjlK6I3u/ILW4xI2NAXkXuk+d0BrHvLu92H3vYQo6udIHzn0HDSNn17JCwwCvysM7u46TU7UQX/exfgCAVxNLJKm8otfqS+iUg0Qd7zcKWvZvyCs80GTnbC1B2s6TYop7ImkSTFJXXUaayCoRwlX0I66wlN7eItOonjrV7WQHigMzJy6uyt/vF59brWh4w15zsBXFmRy1DjVsSgPgJa8wHJgra+qujGuCOFI5HzK3dBf6XjbubkZPzrzbgTRSFDxpsyMNwhIhISZp9jOi7pIB61Zy4ygs5ftSqQCt52R0GnZhbOvyta/836JbYccQVekgq+kLXi2QL7fj6e0a48NZPpKdakaf4SGsbTBf7GJCs1iHR1RNX3fsWA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(81166007)(8676002)(86362001)(6512007)(36860700001)(956004)(2616005)(6506007)(118246002)(6666004)(2906002)(356005)(6486002)(921005)(83380400001)(316002)(1076003)(8936002)(508600001)(40460700003)(5660300002)(36736006)(186003)(36756003)(82310400005)(70206006)(70586007)(47076005)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:17:56.9232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c10b9ae-9c40-45d0-e3dc-08da328fe183
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The units after application of scale are 100*m/s^2,
The scale calculation is only for the device
with the range of 3, 6, 12, and 24g,
but some other chips have a range of 2, 4, 6, and 8g.

Modified the formula to a scale list.
The scales in the list are calculated by 1/sensitivity*9.8.
The new units after the application of scale are m/s^2.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index a06dae5c971d..9300313b63cb 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -119,6 +119,7 @@ struct bmi088_accel_chip_info {
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	const int scale_table[4][2];
 };
 
 struct bmi088_accel_data {
@@ -280,6 +281,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
+	int reg;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -330,13 +332,12 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 				return ret;
 
 			ret = regmap_read(data->regmap,
-					  BMI088_ACCEL_REG_ACC_RANGE, val);
+					  BMI088_ACCEL_REG_ACC_RANGE, &reg);
 			if (ret)
 				goto out_read_raw_pm_put;
-
-			*val2 = 15 - (*val & 0x3);
-			*val = 3 * 980;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
+			*val = data->chip_info->scale_table[reg&0x03][0];
+			*val2 = data->chip_info->scale_table[reg&0x03][1];
+			ret = IIO_VAL_INT_PLUS_MICRO;
 
 			goto out_read_raw_pm_put;
 		default:
@@ -432,6 +433,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
 	},
 };
 
-- 
2.25.1

