Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC23530178
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiEVHFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiEVHEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:04:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567A2E696;
        Sun, 22 May 2022 00:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXgap1Igd2zT8nsD7O2CrkE4iNXUoPQ55nLKPzR/Vxfz4ddjLVh47dg0BwA1jtj1AQvX5UjuYgJH6U1SHuwcAoRkAeDKhOjClPzT93aBw5//L/S6fsvwg2jG+NE1ZtO2Y0FyyqNGI6PF3Fzd9Yw/HO9vZPDj9ATxN+zTQ6qkPbbRoj7Q/sTtiSc00qzkNU/ICqYNJJtXNRybUcaVBjnD2YqFeZVszirtWWxnBJYCSS8NmHGDf5lnnvdIkBMa56is+kf8XeowvNc40sbnV97CT+sy0DgKHnK+vXceZQ3NeEVyqGveA7Dm+Yjg3hHLG2vi3BbodPWPBCEAKI9k/CLy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXYt1oZ7BY+XxoA9T1qDsn8ukdJ2HyGc2rnldt1bQW8=;
 b=npt1NCfMpuWH2c0GPo/KRHpeY1Yg1arwzLpJ6467nEjyvoLUTjfDOGVPA8mDDRVSRJZLhPmH8HLNqr1ZlS+DE19drbUOXyMMyHScf6koFxkgKvrNNEQ6QGib3aEiGcmN3m3IRvJgypQePdR21MympUkkEtzZ81tYWki8a6jO7V+kwcFDWDpvynzrrXumE5r9UkoRVaU1/b14JPGEgCWXnW2XlyO6B9KeWLJtSzKYfZPowN+twS+m5eZ8qoCziUkA+EJMVp0aB0K1R+2Bye7YTfoiVEWflkzrS5tCnzA1tfpP7BgeSAcHI+BiKHZMopwOlyG6/dvI5il4t7vJRnybFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXYt1oZ7BY+XxoA9T1qDsn8ukdJ2HyGc2rnldt1bQW8=;
 b=wEHWcVvEgxo+GXiC7IcL1CcJTQdFqI3tHOKmRP+aUroIvUTyqypzIJ7bo2G1HErs6H7BHELQY20CTDzd8BeZ4VcSaAbuH5e6LblJW3Uj6mM1E5+Bi6FR4c2wTxoiDKV6FSupdH6mK4/27TC5x5vuhm3qDj4bzvmBfHVaSwOiKUo=
Received: from AM0PR10CA0126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::43)
 by DU2PR06MB8400.eurprd06.prod.outlook.com (2603:10a6:10:2f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Sun, 22 May
 2022 07:04:25 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::a1) by AM0PR10CA0126.outlook.office365.com
 (2603:10a6:208:e6::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Sun, 22 May 2022 07:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 07:04:24 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V7 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Sun, 22 May 2022 07:04:17 +0000
Message-Id: <20220522070419.409556-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95aef660-5951-4a7c-2d6d-08da3bc14e06
X-MS-TrafficTypeDiagnostic: DU2PR06MB8400:EE_
X-Microsoft-Antispam-PRVS: <DU2PR06MB840060478C4406946DC29914D7D59@DU2PR06MB8400.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyW9ApZgTxZO23xiB4FJ6Bs36KK8IvMzQnAZFcMzAguqoL3As9Xw1J0LdiWDzj+lrQ24/gTfO0LfnfvEi38+yVDoD8UKNHxHU4pCcNuAEmw4MJtp0cfHRZeejCnccUQI/cnv+mbwtdXFK0VB4s9ulV7bWFpl82e4oZfkWd+tgtnzdzl9g3LRSdM1oR/FMvVib4/Ho/Z8FwOFh59FOPHq9VXTF87Ict7UtDUqLRiTOoSPA5f7hBiV61jj7B2FNpSUHFFX4kAnhGkG6KxbDVtuJgvzaKXRjH5WtSTeGEYA7RQQadHJbeHMod6dFTOGhq8K+fz1WBa82kl8YXQsM7JOOAVznY5qOsgJDvpZT2uJ5x6jPbNswreyj/hLeEcXQFUJ/afD5T3XEqPUicZr10spkQnIyJ2mcnuU0uZlp18d2OytDSwgQupxj9JSE8hAWOWFHN/i876/8jF8JhB81YP5mFZhYIEptkMWQ1COz5dAJmYnB+JaQTT9Sw/kdTlZGy/F996oDiliEkHKAr+EZqJtujeV0vPRuaxVuTAbSI6L2wSKMmuRflGl6lq0BMriQtWQULaeie4L6CoJAAVNQ5HFQTOIGO25arhI3vkrFmQ1s9hbR7MfvK+SmHmjiFl1qVRzy/It+k9ZOu+qJJjM++j0xYoOHN2EUXH0R6GTyXbgMlg6rzpEr/tc1tLnXRZFGHFr
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(26005)(36736006)(6512007)(5660300002)(70206006)(70586007)(8676002)(316002)(40460700003)(86362001)(6486002)(508600001)(6666004)(186003)(82310400005)(118246002)(8936002)(336012)(47076005)(2906002)(1076003)(36860700001)(83380400001)(36756003)(6506007)(81166007)(4326008)(2616005)(956004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 07:04:24.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95aef660-5951-4a7c-2d6d-08da3bc14e06
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the way for multiple chips and additional channels:
- Modify the driver to read the device ID and load the corresponding
  sensor information from the table to support multiple chips
- Add prepares for the addition of extra channels
- Prepare for handling the operation modes for multiple chips

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 199 ++++++++++++++++++++++++++++--------
 1 file changed, 158 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..e57aba79c32b 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -93,19 +93,40 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-static const int sca3300_lp_freq[] = {70, 70, 70, 10};
-static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+static const int sca3300_lp_freq[] = {70, 10};
+static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
 
+static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
+static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
+
+static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0
 };
 
+struct sca3300_chip_info {
+	const char *name;
+	const unsigned long *scan_masks;
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+	u8 num_accel_scales;
+	const int (*accel_scale)[2];
+	const int *accel_scale_map;
+	u8 num_freqs;
+	const int *freq_table;
+	const int *freq_map;
+	const int *avail_modes_table;
+	u8 num_avail_modes;
+	u8 chip_id;
+};
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
  * @lock: Data buffer lock
+ * @chip: Sensor chip specific information
  * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
@@ -113,6 +134,7 @@ static const unsigned long sca3300_scan_masks[] = {
 struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
+	const struct sca3300_chip_info *chip;
 	struct {
 		s16 channels[4];
 		s64 ts __aligned(sizeof(s64));
@@ -121,6 +143,24 @@ struct sca3300_data {
 	u8 rxbuf[4];
 };
 
+static const struct sca3300_chip_info sca3300_chip_tbl[] = {
+	{
+		.name = "sca3300",
+		.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
+		.accel_scale = sca3300_accel_scale,
+		.accel_scale_map = sca3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
+		.freq_table = sca3300_lp_freq,
+		.freq_map = sca3300_lp_freq_map,
+		.avail_modes_table = sca3300_avail_modes_map,
+		.num_avail_modes = 4,
+		.chip_id = SCA3300_WHOAMI_ID,
+	},
+};
+
 DECLARE_CRC8_TABLE(sca3300_crc_table);
 
 static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
@@ -227,36 +267,92 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
 	return sca3300_error_handler(sca_data);
 }
 
+static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
+{
+	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
+		return -EINVAL;
+
+	return sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				 sca_data->chip->avail_modes_table[index]);
+}
+
+static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
+{
+	int reg_val;
+	int ret;
+	int i;
+
+	ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= GENMASK(1, 0);
+	for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
+		if (sca_data->chip->avail_modes_table[i] == reg_val)
+			break;
+	}
+	if (i == sca_data->chip->num_avail_modes)
+		return -EINVAL;
+
+	*index = i;
+	return 0;
+}
+
+static int sca3300_set_frequency(struct sca3300_data *data, int val)
+{
+	const struct sca3300_chip_info *chip = data->chip;
+	unsigned int index;
+	int *opmode_scale;
+	int *new_scale;
+	unsigned int i;
+
+	if (sca3300_get_op_mode(data, &index))
+		return -EINVAL;
+
+	/*
+	 * Find a mode in which the requested sampling frequency is available
+	 * and the scaling currently set is retained.
+	 */
+	opmode_scale = (int *)chip->accel_scale[chip->accel_scale_map[index]];
+	for (i = 0; i < chip->num_avail_modes; i++) {
+		new_scale = (int *)chip->accel_scale[chip->accel_scale_map[i]];
+		if ((val == chip->freq_table[chip->freq_map[i]]) &&
+		    (opmode_scale[1] == new_scale[1]) &&
+		    (opmode_scale[0] == new_scale[0]))
+			break;
+	}
+	if (i == chip->num_avail_modes)
+		return -EINVAL;
+
+	return sca3300_set_op_mode(data, i);
+}
+
 static int sca3300_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
-	int reg_val;
-	int ret;
+	int index;
 	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val)
+		if (chan->type != IIO_ACCEL)
 			return -EINVAL;
-
-		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
-			if (val2 == sca3300_accel_scale[i][1])
-				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
+		/*
+		 * Letting scale take priority over sampling frequency.
+		 * That makes sense given we can only ever end up increasing
+		 * the sampling frequency which is unlikely to be a problem.
+		 */
+		for (i = 0; i < data->chip->num_avail_modes; i++) {
+			index = data->chip->accel_scale_map[i];
+			if ((val  == data->chip->accel_scale[index][0]) &&
+			    (val2 == data->chip->accel_scale[index][1]))
+				return sca3300_set_op_mode(data, i);
 		}
 		return -EINVAL;
-
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
-		if (ret)
-			return ret;
-		/* freq. change is possible only for mode 3 and 4 */
-		if (reg_val == 2 && val == sca3300_lp_freq[3])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
-		if (reg_val == 3 && val == sca3300_lp_freq[2])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
-		return -EINVAL;
+		return sca3300_set_frequency(data, val);
 	default:
 		return -EINVAL;
 	}
@@ -267,8 +363,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
+	int index;
 	int ret;
-	int reg_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -277,17 +373,25 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		ret = sca3300_get_op_mode(data, &index);
 		if (ret)
 			return ret;
-		*val = 0;
-		*val2 = sca3300_accel_scale[reg_val][1];
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			index = data->chip->accel_scale_map[index];
+			*val  = data->chip->accel_scale[index][0];
+			*val2 = data->chip->accel_scale[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+
+		ret = sca3300_get_op_mode(data, &index);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		index = data->chip->freq_map[index];
+		*val = data->chip->freq_table[index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -331,6 +435,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -347,12 +452,17 @@ static int sca3300_init(struct sca3300_data *sca_data,
 	if (ret)
 		return ret;
 
-	if (value != SCA3300_WHOAMI_ID) {
-		dev_err(&sca_data->spi->dev,
-			"device id not expected value, %d != %u\n",
-			value, SCA3300_WHOAMI_ID);
+	for (i = 0; i < ARRAY_SIZE(sca3300_chip_tbl); i++) {
+		if (sca3300_chip_tbl[i].chip_id == value)
+			break;
+	}
+	if (i == ARRAY_SIZE(sca3300_chip_tbl)) {
+		dev_err(&sca_data->spi->dev, "unknown chip id %x\n", value);
 		return -ENODEV;
 	}
+
+	sca_data->chip = &sca3300_chip_tbl[i];
+
 	return 0;
 }
 
@@ -384,15 +494,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 			      const int **vals, int *type, int *length,
 			      long mask)
 {
+	struct sca3300_data *data = iio_priv(indio_dev);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (const int *)sca3300_accel_scale;
-		*length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*vals = (const int *)data->chip->accel_scale;
+			*length = data->chip->num_accel_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*vals = &sca3300_lp_freq[2];
-		*length = 2;
+		*vals = (const int *)data->chip->freq_table;
+		*length = data->chip->num_freqs;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
@@ -424,11 +540,6 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
@@ -436,6 +547,12 @@ static int sca3300_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	indio_dev->name = sca_data->chip->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sca_data->chip->channels;
+	indio_dev->num_channels = sca_data->chip->num_channels;
+	indio_dev->available_scan_masks = sca_data->chip->scan_masks;
+
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      sca3300_trigger_handler, NULL);
-- 
2.25.1

