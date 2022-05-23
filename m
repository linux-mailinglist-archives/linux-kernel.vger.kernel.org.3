Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC4D5309CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiEWHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiEWHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:05:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86985C862;
        Sun, 22 May 2022 23:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5ZNSKnOOY/NnQa+2uA9JHyY7snzzjiBK3KoYnmLW0RutEuqaXJs6D9+EDUYULESxOAXP/nff/oYBkDU56LD7uC7Uz4SXuWzTi+d7iGExBZBmkLGo8UIXmDaDEWWjTAcpbZH8K79ebvH10l3jEsZuz7TNtb+nd1WAT549Th1nUlz0/3wcQQNfGSXzPJt2xGptuB92IvM3AYoOc0SZVLu3HXDjoflYkPtI8bHvkDK8jzVHOteQLpAVvgEz3z/mM8mcbtsfYeT8nXxnW2qOBQETfffzSZqY/Hw/WIFp11GzlX+9zI5Ojh/Cj/5IQo806esRZRPZKxAhuP9hEOfgd5Qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxre35NuWmmIXYP/rslmXb++Y+XLqThXUTlZtVQ4egk=;
 b=ZGNuZInAxk4sYyLofh8FAWUEKl+uzClJphIKC4PjUghkBAp5F1BBuAU6TKjNFm/pal3iull+Y5n7kR2A3Ush/ioqcn3Rh1x5kh+GzDcCoxhmqBQ0Dks3bd5T2GuQavjgELv6pP0mSPyQzCq7rIqFKNJztJrIVtQ+DqLBDSg03xCjTGT6RRmmJOI9vDq1OydkC8kMLFmNT4M5rm62I3JZkdzcxJZJaUDRiYz/LkbK41wjHm2dkm5pkycwuvIzy46SfUMM9tc5mkqk0Vg0Pnflq5UfYNmMOop5BAnD2etOA5/ODibfyG3izBbBeTiZ79lFge7rmNVSPz1pLTiIOcb2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxre35NuWmmIXYP/rslmXb++Y+XLqThXUTlZtVQ4egk=;
 b=ZMUqS6FydI/Z1O2MDeeonYqikWyFg0fxbM94Esvc8YwRV9OGn8cmR7NQSYw5oqPWxva+vGPF4eorYuSsuun/tkq2JwNyQ+Col9R3GRIwrNbkH/QSBHMFyiS/xSMllNeX687kcbT8rjYdaqqr0pKfjRbkVObITFLKByQfGbvWGag=
Received: from OL1P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::7) by
 AM6PR0602MB3509.eurprd06.prod.outlook.com (2603:10a6:209:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 06:23:20 +0000
Received: from HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::54) by OL1P279CA0056.outlook.office365.com
 (2603:10a6:e10:15::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Mon, 23 May 2022 06:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT087.mail.protection.outlook.com (10.152.11.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 06:23:19 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: [PATCH V8 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Mon, 23 May 2022 06:23:10 +0000
Message-Id: <20220523062312.1401944-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57fcee20-5ac2-47ff-d5be-08da3c84bb17
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3509:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0602MB35094F1FA026A68B8CDBA1A0D7D49@AM6PR0602MB3509.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8e6EhuwRwmvVVVsA8CvMb5HjWgJ3cgZWInSxU+1pgPDAAvmaJH7gmkQ0Av2BjyUNnkT/1psQjWjgFF6jCSNKB10Z5pnMqrXMEtv507lSOuaW75xnapqIzomYENWu/5TqU/hP3maV3DiDq4CfcaTfNDO+YzVSt9zmaepkeytohobQfCvlgIGZPuAgBCgOLSWBg/wjb+gE0MiPjEfDg9KPS5PW2FXn8FPwrMR8JRsEGYE9BBcFzfInqqtughSQkCXmQtAvRxmuvn713c859k3fdMlyUX9+KYcJXa9yIlXqlNtsxxZO6OTvkd7BNU072z4KrLHkEMTR9BnkFuoxqYCK2OOhzhcnXO4FhfXhYrUAp4LczVsUB8IOAMEmunjAobXbwxAojx2N02NPNOeLjkITuYNQaOwoOfqVt4c5GB74hx6uNDgD20dY4hHpH0pePWuMt1/vQMESj9S7YAGPNhlqCyEVg3lzqE9E4vbLl1zK3epd5pZ7Qdx/jFNvzbV+nSQFYCMAiRDQDMxHaHTPXiCkjpPPwsdXzk7QWhKAV+csS4S3iyK/uNde+Tyzf+niJlKBJ9Cgs3qy3hZeub6v4pqmbGnw3/0P8qTCpXomehdawcHpmiH4Exnt3NlB2VCm46szwkNz6BsB2AnFQKo0gFDuQxu8KCohRz7qFFsv+Nou3cZzr4n7+7WsCeYU8f29qL3Q
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(81166007)(6486002)(5660300002)(36756003)(508600001)(70586007)(70206006)(82310400005)(356005)(4326008)(40460700003)(36736006)(26005)(36860700001)(8676002)(316002)(86362001)(186003)(336012)(956004)(2616005)(1076003)(47076005)(118246002)(83380400001)(8936002)(6506007)(6666004)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:23:19.3920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fcee20-5ac2-47ff-d5be-08da3c84bb17
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iio/accel/sca3300.c | 198 ++++++++++++++++++++++++++++--------
 1 file changed, 157 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..6463d12a9ab9 100644
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
@@ -277,17 +373,24 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
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
+		ret = sca3300_get_op_mode(data, &index);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		index = data->chip->freq_map[index];
+		*val = data->chip->freq_table[index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -331,6 +434,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -347,12 +451,17 @@ static int sca3300_init(struct sca3300_data *sca_data,
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
 
@@ -384,15 +493,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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
@@ -424,11 +539,6 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
@@ -436,6 +546,12 @@ static int sca3300_probe(struct spi_device *spi)
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

