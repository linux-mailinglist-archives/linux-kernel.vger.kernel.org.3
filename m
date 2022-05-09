Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC6D51F50F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiEIHF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70130.outbound.protection.outlook.com [40.107.7.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05419CEDE;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue7i4MZoJcVVt5n2Y9a9/Y0iSXGHnufDRqYmNfQwI6enLnp4b98ObBMkoYSjj+Xz7tJp9lkT0D7ISxypWJ9cMiA8ZgakiEjEPaCVtVhIdQDdrlHKrLjl2yyurPWLHr7GQUbnboX1gljeNX9O56+BgUcgKm+Fo1k9bCHVW+l6HdPsC0ikt+1LOI4kA+LuxyhFHSk/EyYcqVOIkOS18csDN4oKVu8dn3dhYaXayQVmB5n6f1kZ32g9hHbuGWC7q+psbz1ywWtB9qLgc2EzQXyc6UErptW15O51XXF7R99SNrIpyXNTVLzsDXnR9UTKNCMQg4h2PBH0vEG8p2qtPAcuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw9D5i2ECUvqkwDV0yds+1OFUKxoXYC2JbqzZQOSf10=;
 b=n98HJ8RxYIgfKWQjjlY7pbsGlPTWAVlMOMDLXhp9Ky1KdiEjko4Ia//t6m/nojeMwB/D5Gw94EuR4Z5sWVIHN3hyKHkVV3VcqOD0AEcnR39nrUg5NJP4wSOCyD3fO8BPE/BZluoqJ5Q31bOf4pWuEDCvZnM45wOS6/GudQQcq00LAEskbqDkaHvv503OXrOCrOpOgdVFuDiSCMMOsx3DFTHr1sAGwjio/9mbEXKoc6yxREsxNxmbWtszVFgUZw4S3n9w2lBrk2Df55sJf11UweA782wS5m3nbiTxBE2mwnnAXMzhvsJvkwGf4ccJa3YRawBqgvqPjRpOHq+lIcEWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw9D5i2ECUvqkwDV0yds+1OFUKxoXYC2JbqzZQOSf10=;
 b=oopEahUoQI72N5qg1JtL0MGZbQU8fpblXE150wOZWogzWFWi6z9wKtrjobIHANnS8A4FtqW/9FW+lckzd9x9E3cUd6Josyl6hj5kdKpiRCcvjGokCLVCgTrkMtj6qhEeYQpBm6gzSa3xy/os9e3Bcnh5AoX6/u9L7r3G+1IBBqI=
Received: from BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::16) by
 VI1PR0602MB3248.eurprd06.prod.outlook.com (2603:10a6:802:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 06:49:38 +0000
Received: from HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:b10:a:cafe::3) by BE0P281CA0006.outlook.office365.com
 (2603:10a6:b10:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 06:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT040.mail.protection.outlook.com (10.152.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 06:49:37 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V4 5/5] iio: accel: sca3300: Add inclination channels
Date:   Mon,  9 May 2022 06:49:28 +0000
Message-Id: <20220509064928.2352796-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06ece379-75dd-408b-fdbe-08da318815fd
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3248:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0602MB3248900CED596F3EA531A3AFD7C69@VI1PR0602MB3248.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gURy6J9q831kS6e+EqArmLfC+dKuZlF4DO7YpHSKXDVdtTtb/jGC9GdDgItnwqaru5SAgh8Mso5ccdoqZPDA2GdLnUDtUdVEgmi/BgCoCA91K/z6jynwgSzD7DYLtLYCA3ISi7XtnQS58U/w69xzXS3TnP7yab8lZcub7iK6pvvQwwWH8hLyj2b2KKmc4Xr4pFkOrWdAnMrbqyZ/liZlVxkw9VAV/gseGCFu/sw0tgKI8tJevJcabW2Uw3spnQ9AGPscuq0QyCoendjd1pbHh3EPlqjPTEF7rdLrbST3p8eOWiL4q6WpqExszCLYDEiK9MaFxD2RI6vPMl0YXSH7+lzUDpB/Qe/2rViI4yqy8bLxChL5kxAXB2wSdBg/4TwWKWIsb//kHfKhhwA3LilKwIXHK3dJ2tHpagFUkZTsxZH2Geatps4SZYkyubUVyW68DibxTl+Tpt1DpOnyVSeHn0spIdJLgoYXWQwK4TkNHB+6OX9MUlXKcvc4x5Uxhki0BStlZ2Qf1DAHlawBPg/bsXLd91zxvn9yHqoOlC79H/VSFymyegcsql8WKw/4PzuV5f/5OXiUrByVbu0KVSEJUuiDuXu5887hnPGjAl+7YQ8qfTbm9Ce983OSuAfUTu3dDgwhxtA0hWZoA1449UYP6RtlR7XMhEI5F8XycoOdQO6ujXtiXh4yG096SwFWq2s5
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6506007)(82310400005)(508600001)(86362001)(118246002)(356005)(36736006)(316002)(6486002)(2906002)(6666004)(81166007)(186003)(70206006)(336012)(70586007)(36756003)(47076005)(2616005)(40460700003)(6512007)(5660300002)(26005)(83380400001)(1076003)(956004)(8676002)(4326008)(36860700001)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 06:49:37.4845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ece379-75dd-408b-fdbe-08da318815fd
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3248
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
ANG_X = atan2(accx , sqrt(pow(accy , 2) + pow(accz , 2)))
ANG_Y = atan2(accy , sqrt(pow(accx , 2) + pow(accz , 2)))
ANG_Z = atan2(accz , sqrt(pow(accx , 2) + pow(accy , 2)))

The commit adds the output of the raw value, scale
and scale_available of angles.

New interfaces:
  in_incli_scale
  in_incli_scale_available
  in_incli_x_raw
  in_incli_y_raw
  in_incli_z_raw
Data converted by application of scale to degrees.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 81 +++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 618991c8da92..af5292ebc99f 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -44,12 +44,18 @@
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
@@ -73,6 +79,24 @@ enum sca3300_scan_indexes {
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
@@ -106,15 +130,36 @@ static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
 static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
 static const int scl3300_accel_scale_map[] = {0, 1, 2};
 
+static const int scl3300_incli_scale[][2] = {{0, 5495}};
+static const int scl3300_incli_scale_map[] = {0, 0, 0};
+
 static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
 static const int scl3300_avail_modes_map[] = {0, 1, 3};
 
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
 	u8 num_channels;
@@ -122,6 +167,9 @@ struct sca3300_chip_info {
 	const int (*accel_scale)[2];
 	const int *accel_scale_map;
 	u8 num_accel_scales;
+	const int (*incli_scale)[2];
+	const int *incli_scale_map;
+	u8 num_incli_scales;
 	const int *freq_table;
 	const int *freq_map;
 	u8 num_freqs;
@@ -129,6 +177,7 @@ struct sca3300_chip_info {
 	u8 num_avail_modes;
 	const char *name;
 	u8 chip_id;
+	bool angle;
 };
 
 /**
@@ -158,6 +207,9 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.accel_scale = sca3300_accel_scale,
 		.accel_scale_map = sca3300_accel_scale_map,
 		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
+		.incli_scale = NULL,
+		.incli_scale_map = NULL,
+		.num_incli_scales = 0,
 		.freq_table = sca3300_lp_freq,
 		.freq_map = sca3300_lp_freq_map,
 		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
@@ -165,13 +217,18 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 4,
 		.name = "sca3300",
 		.chip_id = SCA3300_WHOAMI_ID,
+		.angle = false,
 	},
-	{	.channels = sca3300_channels,
-		.num_channels = ARRAY_SIZE(sca3300_channels),
-		.scan_masks = sca3300_scan_masks,
+	{
+		.channels = scl3300_channels,
+		.num_channels = ARRAY_SIZE(scl3300_channels),
+		.scan_masks = scl3300_scan_masks,
 		.accel_scale = scl3300_accel_scale,
 		.accel_scale_map = scl3300_accel_scale_map,
 		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
+		.incli_scale = scl3300_incli_scale,
+		.incli_scale_map = scl3300_incli_scale_map,
+		.num_incli_scales =  ARRAY_SIZE(scl3300_incli_scale)*2,
 		.freq_table = scl3300_lp_freq,
 		.freq_map = scl3300_lp_freq_map,
 		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
@@ -179,6 +236,7 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 3,
 		.name = "scl3300",
 		.chip_id = SCL3300_WHOAMI_ID,
+		.angle = true,
 	},
 };
 
@@ -383,6 +441,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		switch (chan->type) {
+		case IIO_INCLI:
+			index = data->chip->incli_scale_map[index];
+			*val = data->chip->incli_scale[index][0];
+			*val2 = data->chip->incli_scale[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			index = data->chip->accel_scale_map[index];
 			*val = data->chip->accel_scale[index][0];
@@ -469,6 +532,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	sca_data->chip = &sca3300_chip_tbl[i];
 
+	if (sca_data->chip->angle) {
+		ret = sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL,
+					SCA3300_ANG_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -504,6 +574,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
+		case IIO_INCLI:
+			*vals = (const int *)data->chip->incli_scale;
+			*length = data->chip->num_incli_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
 		case IIO_ACCEL:
 			*vals = (const int *)data->chip->accel_scale;
 			*length = data->chip->num_accel_scales;
-- 
2.25.1

