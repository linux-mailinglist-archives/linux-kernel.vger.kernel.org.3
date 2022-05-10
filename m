Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A183521D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiEJO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345564AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70102.outbound.protection.outlook.com [40.107.7.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D961A24EA3A;
        Tue, 10 May 2022 07:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8wWBgK5xw87XbT1t5OC65XjQQFUCykfZUPKjsfWkaRm9C/XxwLccK5NJvKpspqY00YIF/KeGOIziNKp3evl0mNQXzntR4HvPM7+vQqHd059pTrnmyRb8485HoYFOMADGP6kfzqBF5KRcNtCHSph8hl4Nj7yc5uTkaU0eCbH9q0PzzOsTQ5rYztNIwnjeNM5Ef4u/AICWgpJT1EYB9rxHARvw6QP9vavjaV5G8DusqYkTDQmSAEQ8npUx4t0vVD/ZJCiZHV5/XQ7EGR7aHZhDmCH5Repqyo3CB54wsDNllH8RsYVmGkdARt99fGXM2iwIrKMiv+uqnbYmN1B9LNIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYTEKVbUjPMn5eH+c2JWdsjS0bjJuWIkyRiz/qC/Jic=;
 b=SA0UR+wQzzHetUPJLkEH7yXXQvt8f6ZYlpqHmVWGxePr1T/7ykSvyuTcSFlbCSyiHag26dadyqV414Kuo5bG4jDelt2ZBG0eyDj18RFcjhgvlQ0jAP/U+3mgNsyDIOZYLDAz3Zax6xIgjtBaukt2QERkSzi+HjhZvygSNvqqZ09nLIDoRsvTupji1sGQWmT2VaIcE/0i/XySaa6uUEYF/e+2Vbtmve+CPW6cDzytpOWm2tsPX1kNlPeZiW3x8FcxJFZQTalmvSCE1CHO1B5nEGI5oP9aTtQT/FzmccjmHFnOWZo3cbhJlT/UjndHkdhqxh+TWajMw3fpm1fz+TXZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYTEKVbUjPMn5eH+c2JWdsjS0bjJuWIkyRiz/qC/Jic=;
 b=xqT89u00HbsmCJ1rfskGoJpjqELPSQ7SgdESFdf/ZGHCCVqrO2DFzJGFgBOqVDuXRp8lMImaom7XKlGJE0pshuHtvUb7+NcBodQQWCYZpVkvBHmyjHlWgu72vEREUPjX6fd5/iJK/17k3K4MFA9/BnGR+L78E9gPc8Hn/y+VK64=
Received: from AS9PR06CA0344.eurprd06.prod.outlook.com (2603:10a6:20b:466::27)
 by PR1PR06MB5738.eurprd06.prod.outlook.com (2603:10a6:102:6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 14:17:58 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::87) by AS9PR06CA0344.outlook.office365.com
 (2603:10a6:20b:466::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18 via Frontend
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
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:17:57 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 2/6] iio: accel: bmi088: Make it possible to config scales
Date:   Tue, 10 May 2022 14:17:49 +0000
Message-Id: <20220510141753.3878390-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a48117f4-e70f-45c1-7c08-08da328fe1de
X-MS-TrafficTypeDiagnostic: PR1PR06MB5738:EE_
X-Microsoft-Antispam-PRVS: <PR1PR06MB5738870C5447D66CA666F0D1D7C99@PR1PR06MB5738.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ExpKYZlYfeG82XTYRI2scJXPYdYHQIus7VEY0VyIruTMhXp36XBcsVgyYRMm4lxa5rQuKgLB5DLSTMfxFK6TY/PCafD9ulNXnMgp/5HgskH2peYW08InXEL/1iqUMAE0RTjY/nCtNIalGLJug0/WJsKlgjqed2osuiHaGXTrF8VBGC3C7MbW/EFtjglg2hPyYJXSmC4eRxb1PmIYQsr+7pZY3vzVyLmd6jiDa/lUk8Fhp4NyJ4dzv8JNkNboPJfDMQCQmtb5XoP26d45qDmY/D5ajD98Dn1OZL4lHANW5GX1cpEA5xQGZGMN3n8TR/fPwbg1hse1DEq1lut+Qkw1Agc7GYZd9Ff4FjWjlME6fLqJxZ11E7lprIszUVpPk+Sb8mSM4OBq+E3veJVHupXItgFhWrgoJzlkzdq+4oJEsUYArIA+HPqJ4nFZJ+pFtFsRO9DXjsPfbY6x0wcWZ7qBCFJ7/h0JP1jR62zNbBVEVrAfbUVT5Yuj1Uk6esGVgAwnuFMb2eVK63FT7HKAU6c/Hcc2Ys0wl4q59BI0LRK4y0DDnNmunZoTvCJ8e4WiakodXA8YTTYM0Sf/S5FKwAVGZZ3FW94y0NjWVItK4T5y/ObJltyWp1XS6PbKoOpXkho97n4Aa/aUQbul5Tgeu10LTZxk7ln+8qRxORHnZx4AazzFA8Bfj/vRf9mskfpZagY
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(6512007)(26005)(186003)(356005)(921005)(1076003)(2616005)(956004)(70206006)(70586007)(8676002)(47076005)(5660300002)(36756003)(316002)(2906002)(36736006)(8936002)(6486002)(508600001)(6506007)(86362001)(36860700001)(81166007)(118246002)(83380400001)(40460700003)(336012)(6666004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:17:57.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48117f4-e70f-45c1-7c08-08da328fe1de
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB5738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sensor can set the scales by writing the range register 0x41,
The current driver has no interface to configure it.
The commit adds the interface for config the scales.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 32 ++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 9300313b63cb..8fee1d02e773 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -237,6 +237,21 @@ static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
 				  BMI088_ACCEL_MODE_ODR_MASK, regval);
 }
 
+static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
+{
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		if (val == data->chip_info->scale_table[i][0] &&
+		    val2 == data->chip_info->scale_table[i][1])
+			break;
+
+	if (i >= 4)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
+}
+
 static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
 {
 	int ret;
@@ -368,7 +383,13 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
+	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)data->chip_info->scale_table;
+		*length = 8;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*vals = bmi088_sample_freqs;
@@ -388,6 +409,14 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+		ret = bmi088_accel_set_scale(data, val, val2);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = pm_runtime_resume_and_get(dev);
 		if (ret)
@@ -409,7 +438,8 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
 				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = AXIS_##_axis, \
 }
 
-- 
2.25.1

