Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097F59BFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiHVMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiHVMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:52:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751712E9D2;
        Mon, 22 Aug 2022 05:52:48 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MCdnLA005837;
        Mon, 22 Aug 2022 08:52:43 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j2whtnes7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:52:43 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27MCqgcC035270
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 08:52:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 22 Aug
 2022 08:52:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 22 Aug 2022 08:52:41 -0400
Received: from debian.ad.analog.com ([10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27MCqBGX003358;
        Mon, 22 Aug 2022 08:52:33 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Date:   Mon, 22 Aug 2022 15:51:06 +0300
Message-ID: <20220822125106.1106798-4-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822125106.1106798-1-ciprian.regus@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TvxT1NsSQom5BmruSZAAlvJjMkMTW2J9
X-Proofpoint-GUID: TvxT1NsSQom5BmruSZAAlvJjMkMTW2J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=947 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the iio device's name based on the chip used.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 drivers/iio/adc/ltc2496.c      | 1 +
 drivers/iio/adc/ltc2497-core.c | 2 +-
 drivers/iio/adc/ltc2497.c      | 2 ++
 drivers/iio/adc/ltc2497.h      | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index 98338104c24a..86470f49e8ca 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
 
 static struct chip_info ltc2496_info = {
 	.resolution = 16,
+	.name = "ltc2496"
 };
 
 static const struct of_device_id ltc2496_of_match[] = {
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index b2752399402c..6dd9ab601904 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -169,7 +169,7 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
 	int ret;
 
-	indio_dev->name = dev_name(dev);
+	indio_dev->name = ddata->chip_info->name;
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ltc2497core_channel;
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index bb5e0d4301e2..a0aad71c8130 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -99,9 +99,11 @@ static int ltc2497_remove(struct i2c_client *client)
 static struct chip_info ltc2497_info[] = {
 	[TYPE_LTC2497] = {
 		.resolution = 16,
+		.name = "ltc2497"
 	},
 	[TYPE_LTC2499] = {
 		.resolution = 24,
+		.name = "ltc2499"
 	}
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index f4d939cfd48b..0e86e38248ee 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -12,6 +12,7 @@ enum chip_type {
 
 struct chip_info {
 	u32 resolution;
+	char *name;
 };
 
 struct ltc2497core_driverdata {
-- 
2.30.2

