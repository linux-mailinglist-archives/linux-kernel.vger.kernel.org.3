Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705D6536FF0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiE2GTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiE2GTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:19:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140091.outbound.protection.outlook.com [40.107.14.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7256C0DA;
        Sat, 28 May 2022 23:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aoz/xH+zFB7XV0CVXk7TA/8y6CjvGkOi1ef7CSPGYL6P2ywlm8SZG5VRJhZPf9Wmyf1iYVBg59P/SxGObWMRDEK5ADbf7yLfMkhh6aq6ijjoEKS4VwFsG2xLVp6uVQYxQ8tbUPx53fqE1eGo/HhqEPOh0JuVB3ojkF72jRS4ODD0vNQXuSeBVZHouwzR7ZheKWHN/ck3FlRfbdLNQt0RMdpuqQNHW4NcceyoqqSVdBrVN6K+oZvE/gbLX1HovBjBpfiXYAJr/FiQgaxYoOLKoq1F2G1Z42Cm7QobxcGRnyYSEcAXWLGHGIZQq2RQmBi8bA57RbIAeVBrHbW1QwXUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=Ot45V3pisZd6NY/A8TzyMbQsIUgjXEbUQLCSS1PHQ5b5q1XWFjzRvoVFoIG9nx/gII1mDKKaLDs9wILbzbrD1bybypqcb5RPr+R9JSjc9c1Lu2GhsBiOmsSLun//w3ehT01+64LL9YYihgk4YsHMOvAGS4xVgEZF1AHm0XepEuJ0PIEWitbI1R9ZC8w+G/i/6Fq0TuDqw6cxc01oe81gtzChFcAyC/quptS3p/VFJRJ2CYw3ZFzsTYei8oN2XBUsRM2W/ql+E3ljujg0FegYbCVOCYphYgJEK7WorFz+NkegXHaob20JSHvceGVzTFm+pbuErpk7TfmYoZlqVQecEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=gX2+8ZyOpLlXpXWCIislwMjyYL4eQeS9N8gGGpzDL5OHNCha64UQUa+ObR1v/Qw5g3qDfxiKxZ3aNztkxkAxRce6B8uBcMyPKbFT4qx/OjYay6cARfWX6Z+THMKP7FeldUipwSzSX/hpB1+DgOJO4muCMK+14z8hpB8oV/7pEBY=
Received: from AS9P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::13)
 by AS8PR06MB7639.eurprd06.prod.outlook.com (2603:10a6:20b:337::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sun, 29 May
 2022 06:18:58 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::12) by AS9P250CA0010.outlook.office365.com
 (2603:10a6:20b:532::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Sun, 29 May 2022 06:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 06:18:58 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V9 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Sun, 29 May 2022 06:18:50 +0000
Message-Id: <20220529061853.3044893-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f3c37553-b79c-46f5-4a51-08da413b1dce
X-MS-TrafficTypeDiagnostic: AS8PR06MB7639:EE_
X-Microsoft-Antispam-PRVS: <AS8PR06MB7639B2948D140B91FCEFEC3ED7DA9@AS8PR06MB7639.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q90kmjkvTNwd1BfPhx9P2KkiCu9VJQcu1BnkX18AJo/mWHKu9tUKs/KjgzK01pqAw/kTu1Qry3EOyP2Z5dveV0uarj+5Po5d6PGXSWxfdmSAWGyP2qCcJtTNFnF+D/Xkv/T58Kc+u19V2/sjF2js1M6CoEN0teSDLjRd5EGSOUR3odA4Wnq8JPa/4V9eK4l+ANm7baUDxWZYqg14nLwwYSPzb+TSC74Z9db6qJo6UQeLOtg18TQFRLKwbf3nyB3VbMD4nRgJuYNr3BtD+/mqgiYZmEClkECGcaHK4CjJey2EXXX1caJtuV+gC/gn8bU615bt5OvXXsi8pD9fOsgkN3BY9zHa7cGIhuG598VHULWd+d25P/arCwZz3628zERUbvRE0t3csptAdEq/u5sn+VjvPWbuRbNCwcjJLjTg/JmcYVgEhFl1N4WixMyzcA65bipFgAMT2Fd+W2R5rfRwxyZ7vllS7I2BQEZmRfrBUzO+dLq8NBlt4CUCxSMxXn4XE6b1/nsr9oZJps136Nx9h4tWFzJBm8zdErEXWzKlxvuyXi6PAwLOwhhHhZLvIYO72po5yUbbYmUfXHjgQGvwh7merr5m3ZTo4W4Jky3CnWCpzzIvmXSiCNnosBnlR+tDsgqjiv4M/MCtwVGF6bgrHxKkqpa3vI0gjggeZWmvuVksRW9S+THfl3QorRCMdbjq
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(316002)(6486002)(508600001)(81166007)(8676002)(6666004)(356005)(5660300002)(36736006)(6506007)(82310400005)(36860700001)(8936002)(86362001)(6512007)(2616005)(956004)(26005)(186003)(70206006)(336012)(47076005)(118246002)(36756003)(83380400001)(70586007)(1076003)(4326008);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 06:18:58.2937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c37553-b79c-46f5-4a51-08da413b1dce
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define of SCA3300_TEMP_CHANNEL for reuse.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index f7ef8ecfd34a..ff16d2cc8c70 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -72,22 +72,24 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_TEMP_CHANNEL(index, reg) {				\
+		.type = IIO_TEMP,					\
+		.address = reg,						\
+		.scan_index = index,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_CPU,				\
+		},							\
+}
+
 static const struct iio_chan_spec sca3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
-	{
-		.type = IIO_TEMP,
-		.address = 0x5,
-		.scan_index = SCA3300_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-			.endianness = IIO_CPU,
-		},
-	},
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-- 
2.25.1

