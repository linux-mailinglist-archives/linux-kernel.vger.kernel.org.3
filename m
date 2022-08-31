Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED95D5A7EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiHaNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHaNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:30:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAE1C0BF7;
        Wed, 31 Aug 2022 06:30:51 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VDJ3wq026327;
        Wed, 31 Aug 2022 09:30:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7d48kxj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 09:30:45 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27VDUh8L021326
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Aug 2022 09:30:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 31 Aug 2022 09:30:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 31 Aug 2022 09:30:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 31 Aug 2022 09:30:42 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.113])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27VDUTRG019685;
        Wed, 31 Aug 2022 09:30:35 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v2 2/2] iio: adc: add max11205 adc driver
Date:   Wed, 31 Aug 2022 16:30:21 +0300
Message-ID: <20220831133021.215625-2-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831133021.215625-1-ramona.bolboaca@analog.com>
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lHfDbKPFas_sp6UPeVGygs-LRvvlCtth
X-Proofpoint-ORIG-GUID: lHfDbKPFas_sp6UPeVGygs-LRvvlCtth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310068
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for max11205 16-bit single-channel ultra-low power
delta-sigma adc.
The MAX11205 is compatible with the 2-wire interface and uses
SCLK and RDY/DOUT for serial communications. In this mode, all
controls are implemented by timing the high or low phase of the SCLK.
The 2-wire serial interface only allows for data to be read out through
the RDY/DOUT output.

Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
changes in v2:
 - add chip_info null pointer check
 - add support for probing with ACPI table
 - remove function for module removal
 - remove irq flag from max11205_sigma_delta_info
 - add missing commas and missing spaces
 - remove redundant blank line
 - wrap text to 75-80 chars
 - removed typos in commit message
 drivers/iio/adc/Kconfig    |  14 +++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max11205.c | 183 +++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/iio/adc/max11205.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930891e0..0c8f376b65d8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -653,6 +653,20 @@ config MAX1118
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1118.
 
+config MAX11205
+	tristate "Maxim max11205 ADC driver"
+	depends on SPI
+	select AD_SIGMA_DELTA
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+
+	help
+	  Say yes here to build support for Maxim max11205 16-bit, single-channel
+	  ultra-low power delta-sigma ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max11205.
+
 config MAX1241
 	tristate "Maxim max1241 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1772a549a3c8..bb681844e497 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o ltc2497-core.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
+obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
new file mode 100644
index 000000000000..68e6082e70e5
--- /dev/null
+++ b/drivers/iio/adc/max11205.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * max11205 16-Bit Delta-Sigma ADC
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-max11205.pdf
+ * Copyright (C) 2022 Analog Devices, Inc.
+ * Author: Ramona Bolboaca <ramona.bolboaca@analog.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+
+#define MAX11205_BIT_SCALE	15
+#define MAX11205A_OUT_DATA_RATE	116
+#define MAX11205B_OUT_DATA_RATE	13
+
+enum chip_type {
+	TYPE_MAX11205A,
+	TYPE_MAX11205B,
+};
+
+struct chip_info {
+	unsigned int	out_data_rate;
+	const char	*name;
+};
+
+struct max11205_state {
+	const struct chip_info	*chip_info;
+	struct regulator	*vref;
+	struct ad_sigma_delta	sd;
+};
+
+static const struct ad_sigma_delta_info max11205_sigma_delta_info = {
+	.has_registers = false,
+};
+
+static int max11205_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max11205_state *st = iio_priv(indio_dev);
+	int reg_mv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		reg_mv = regulator_get_voltage(st->vref);
+		if (reg_mv < 0)
+			return reg_mv;
+		reg_mv /= 1000;
+		*val = reg_mv;
+		*val2 = MAX11205_BIT_SCALE;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->chip_info->out_data_rate;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max11205_iio_info = {
+	.read_raw = max11205_read_raw,
+	.validate_trigger = ad_sd_validate_trigger,
+};
+
+static const struct iio_chan_spec max11205_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct chip_info max11205_chip_info[] = {
+	[TYPE_MAX11205A] = {
+		.out_data_rate = MAX11205A_OUT_DATA_RATE,
+		.name = "max11205a",
+	},
+	[TYPE_MAX11205B] = {
+		.out_data_rate = MAX11205B_OUT_DATA_RATE,
+		.name = "max11205b",
+	},
+};
+
+static void max11205_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static int max11205_probe(struct spi_device *spi)
+{
+	struct max11205_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
+
+	st->chip_info = device_get_match_data(&spi->dev);
+
+	if (!st->chip_info)
+		st->chip_info = (const struct chip_info *)spi_get_device_id(spi)->driver_data;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max11205_channels;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &max11205_iio_info;
+
+	st->vref = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(st->vref))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
+				     "Failed to get vref regulator\n");
+
+	ret = regulator_enable(st->vref);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, max11205_reg_disable, st->vref);
+	if (ret)
+		return ret;
+
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max11205_spi_ids[] = {
+	{ "max11205a", (kernel_ulong_t)&max11205_chip_info[TYPE_MAX11205A] },
+	{ "max11205b", (kernel_ulong_t)&max11205_chip_info[TYPE_MAX11205B] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max11205_spi_ids);
+
+static const struct of_device_id max11205_dt_ids[] = {
+	{
+		.compatible = "maxim,max11205a",
+		.data = &max11205_chip_info[TYPE_MAX11205A],
+	},
+	{
+		.compatible = "maxim,max11205b",
+		.data = &max11205_chip_info[TYPE_MAX11205B],
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max11205_dt_ids);
+
+static struct spi_driver max11205_spi_driver = {
+	.driver = {
+		.name = "max11205",
+		.of_match_table = max11205_dt_ids,
+	},
+	.probe = max11205_probe,
+	.id_table = max11205_spi_ids,
+};
+module_spi_driver(max11205_spi_driver);
+
+MODULE_AUTHOR("Ramona Bolboaca <ramona.bolboaca@analog.com>");
+MODULE_DESCRIPTION("MAX11205 ADC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.25.1

