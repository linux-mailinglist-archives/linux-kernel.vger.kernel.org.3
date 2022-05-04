Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1C51A116
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbiEDNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350708AbiEDNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2123.outbound.protection.outlook.com [40.107.22.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EB3614F;
        Wed,  4 May 2022 06:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvNiPCAXt23f778ImrUffWqEwKxcwwKve70+BhtjJy9dV1H5ZuYI45ZEg/w6Kym/5WeGvGD3cUomHcMSonWbwNI6s/XcFeWjjB+XeYTBWl4gW4Vo2q5kTdxPI/ho8LtZD4AGyqL7QLy2CGVE6Byz8YjUah4o3N+VdmUYv0EiaHKViRsOMcMwn3aEAPO/mq5ljV1H5xTv+/aejRCS+FH3J+0CcCqDFKjAE7lXkwzGNPN1WItAo8h8J69wcYi6nwA/iWUd9i3HR8XcLS9SXr9++6J30Al7QtqBQrjgWHfOwsE940QcK5s2bstgZ6T5IrsNOYogKbvhYN0Z+k4VAyAKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv387veeJ6c1xKTg3sZrPRvXDxHr1F0viAZWDAMLkE8=;
 b=GlKOKgkIfoHwGT5bL40oAbqI43mCC92iv6iTWdEQuuXyNGEfZ7xKNNSUBG+PlNapHBNu+e4xKQgPqarrunq1f9VHWd0COwmzY53W6sOQyLAY0x4Ov2C36PDEBjrUOOaoQOtLJDsKdgSN0CINW4rEjH5gj3mfaYe7mF1zfwbiju7j3uvzKbHaFB18PuvPO0e4Q4wKrGsrw/boNmZJZIGpJjwz/Lqxk+fYGV+4rYqGIRdAd+o1eFSpdjeZaveYg3G5c8JrAICW8ECM9oCPie/Cbjx/1guLvLx7Ou1aRE5N3DIwULyBM1usbx9+MMeR0zs/mF6TO448MesXk8wQHoWuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv387veeJ6c1xKTg3sZrPRvXDxHr1F0viAZWDAMLkE8=;
 b=Tyf0I3xs+/MpZzKyJpgXqJFZDTmXqSlVD27h5mQLpAV9GhTwR63puvwVzcZMQpM7ZdHIvHIWOUV+tDCcoYciQoo2EMqTA9VrqahqaARIWqXo5Kgtuza7TGc6Pgdy6skO6dgLCfovk3GScQecQfQx4EAMo8DzV3Y5iPmjoHXPOb4=
Received: from AM6PR01CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::48) by VI1PR06MB6829.eurprd06.prod.outlook.com
 (2603:10a6:800:18d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 13:36:46 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::bb) by AM6PR01CA0071.outlook.office365.com
 (2603:10a6:20b:e0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 4 May 2022 13:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:36:45 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V3 5/5] iio: accel: sca3300: Add inclination channels
Date:   Wed,  4 May 2022 13:36:12 +0000
Message-Id: <20220504133612.604304-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db919c3-3e81-4f32-b202-08da2dd3220f
X-MS-TrafficTypeDiagnostic: VI1PR06MB6829:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB6829021994CD554358F7F2FAD7C39@VI1PR06MB6829.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M77/197IQVmsNfmvQ3tVR1h8/mY6zyGDeubKE5ucjhkc7KOt5fvgbdlA+9R/HEDNLMM/G8VKU+pzwePtVgD1PPazA0BnvQDdvFpxQmTVlMCB2Nw7AhaB1M/JXygonGYfBaxJg2/ygjZ0zqysWO3Cguf9/bzSmvyeJs8HnlDSqjhNfqMrvCEFgxR5VgXcTDjMSTUBLvrrjptQBXk4o3NbUzHW3QCHYveHWUtNaRy/+xLFQPP1wO8NCgKK3p7DZ2pJGtq9FzRmoxzvCJ2LGhqyRe5U+lZk6rjVpjYHC38zO+d/KeK/4NBMVi/I2NfSAf9XpqvVmVKjvac2vESwLvB8asGZ2jXxnsUXToRyRC37Ege1r+a4LUji6jgUjDbFQKyz9nqY0M6DoROXKMdoGcnfpj360BEq7FBTUkTfR6kDTOuYLi6CkjFigQFpNeXLhnyQYEvKTGJvZDcRPnsi7PmntpcNZxi5UPuqkR++Ad8pz15RmXOIfjyZnYAzMpMVNTgRa1HVk+KxF8duy2aUH5YWKc1f3duAxZS/GDHchpYrHSWxdtSTKPJyWchbN3pp4lCNJq+pIlWXPKlCQ7S4rqp8+nQOn9frBj3elvfjdHuBGbHQ+5tAbRqHCLDPrNje+RBdrhp88clPsVe1BwmY0J31dLLw1Q3lccbuCMAPnsZRrXaoT+hKltUlojssKi2Uisr2
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(81166007)(36860700001)(356005)(316002)(36736006)(70586007)(36756003)(8676002)(4326008)(70206006)(118246002)(83380400001)(40460700003)(6666004)(5660300002)(86362001)(2906002)(26005)(6512007)(2616005)(336012)(47076005)(956004)(6486002)(186003)(8936002)(508600001)(6506007)(1076003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:36:45.6806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db919c3-3e81-4f32-b202-08da2dd3220f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6829
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different from SCA3300, SCL3300 can output inclination angles.
Angles are formed from acceleration with following equations:
ANG_X = atan2(accx / √(accy^2 + accz^2)),
ANG_Y = atan2(accy / √(accx^2 + accz^2)),
ANG_Z = atan2(accz / √(accx^2 + accy^2)),

The commit adds the output of the raw value, scale
and scale_available of angles.

New interfaces:
  in_incli_scale
  in_incli_scale_available
  in_incli_x_raw
  in_incli_y_raw
  in_incli_z_raw
Data converted by application of scale to degrees.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 79 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 040f8e1a1327..cf588f014407 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -42,12 +42,18 @@
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
 
+#define SCA3300_REG_ANG_CTRL 0x0C
+#define SCA3300_ANG_ENABLE   0x1F
+
 enum sca3300_scan_indexes {
 	SCA3300_ACC_X = 0,
 	SCA3300_ACC_Y,
 	SCA3300_ACC_Z,
 	SCA3300_TEMP,
 	SCA3300_TIMESTAMP,
+	SCA3300_INCLI_X,
+	SCA3300_INCLI_Y,
+	SCA3300_INCLI_Z,
 };
 
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
@@ -71,6 +77,24 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
+	.type = IIO_INCLI,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type_available =				\
+	BIT(IIO_CHAN_INFO_SCALE),					\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
 #define SCA3300_TEMP_CHANNEL(index, reg) {				\
 		.type = IIO_TEMP,					\
 		.address = reg,						\
@@ -102,28 +126,54 @@ static const int scl3300_accel_scale_tbl[][2] = {{0, 167}, {0, 333}, {0, 83}};
 static const int sca3300_accel_scale_modes_map[] = {0, 1, 2, 2};
 static const int scl3300_accel_scale_modes_map[] = {0, 1, 2};
 
+static const int scl3300_incli_scale_tbl[][2] = {{0, 5495}};
+static const int scl3300_incli_scale_modes_map[] = {0, 0, 0};
+
 static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
 static const int scl3300_avail_modes_map[] = {0, 1, 3};
+
+static const struct iio_chan_spec scl3300_channels[] = {
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
+	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
+};
+
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0
 };
 
+static const unsigned long scl3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP) |
+	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
+	0
+};
+
 struct sca3300_chip_info {
 	const struct iio_chan_spec *channels;
 	const int (*accel_scale_table)[2];
+	const int (*incli_scale_table)[2];
 	const int *accel_scale_modes_map;
+	const int *incli_scale_modes_map;
 	const unsigned long *scan_masks;
 	const int *avail_modes_table;
 	const int *freq_modes_map;
 	const int *freq_table;
 	const u8 num_accel_scales;
+	const u8 num_incli_scales;
 	const u8 num_avail_modes;
 	const u8 num_channels;
 	const u8 num_freqs;
 	const u8 chip_id;
 	const char *name;
+	const bool angle;
 };
 
 /**
@@ -156,24 +206,32 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.freq_table = sca3300_freq_tbl,
 		.scan_masks = sca3300_scan_masks,
 		.channels = sca3300_channels,
+		.incli_scale_modes_map = NULL,
+		.incli_scale_table = NULL,
+		.num_incli_scales = 0,
 		.num_avail_modes = 4,
 		.name = "sca3300",
 		.chip_id = 0x51,
 		.num_freqs = 2,
+		.angle = false,
 	},
 	{	.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale_tbl)*2,
+		.num_incli_scales = ARRAY_SIZE(scl3300_incli_scale_tbl)*2,
 		.accel_scale_modes_map = scl3300_accel_scale_modes_map,
+		.incli_scale_modes_map = scl3300_incli_scale_modes_map,
 		.accel_scale_table = scl3300_accel_scale_tbl,
-		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.incli_scale_table = scl3300_incli_scale_tbl,
+		.num_channels = ARRAY_SIZE(scl3300_channels),
 		.avail_modes_table = scl3300_avail_modes_map,
 		.freq_modes_map = scl3300_freq_modes_map,
 		.scan_masks = sca3300_scan_masks,
 		.freq_table = scl3300_freq_tbl,
-		.channels = sca3300_channels,
+		.channels = scl3300_channels,
 		.num_avail_modes = 3,
 		.name = "scl3300",
 		.chip_id = 0xC1,
 		.num_freqs = 3,
+		.angle = true,
 	},
 };
 
@@ -382,6 +440,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		switch (chan->type) {
+		case IIO_INCLI:
+			index = data->chip->incli_scale_modes_map[reg_val];
+			*val = data->chip->incli_scale_table[index][0];
+			*val2 = data->chip->incli_scale_table[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			index = data->chip->accel_scale_modes_map[reg_val];
 			*val = data->chip->accel_scale_table[index][0];
@@ -473,6 +536,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
 	indio_dev->name = sca3300_chip_tbl[i].name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (sca_data->chip->angle) {
+		ret = sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL,
+					SCA3300_ANG_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -508,6 +578,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
+		case IIO_INCLI:
+			*vals = (const int *)data->chip->incli_scale_table;
+			*length = data->chip->num_incli_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
 		case IIO_ACCEL:
 			*vals = (const int *)data->chip->accel_scale_table;
 			*length = data->chip->num_accel_scales;
-- 
2.25.1

