Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB2536FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiE2GTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiE2GTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:19:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150134.outbound.protection.outlook.com [40.107.15.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217776C0D7;
        Sat, 28 May 2022 23:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEkISXIZt2s8wEDMR5ZFRtWTQr838yLu0MhozpCZ1ywiOSEL/deceeF0eyTKVK7u4Fv67K1Kq8tBdg7a4KFtJY2/i8mn016PZEtypkb2nc1HjKT2PyV19pKfy1tZ9h60VIt3bQUDI56NWnvadMrDT0+k9y8nZNC/NUeDGBHpr8/cL0hBOOrXQZyR27+/BO5WsMgdmY+bdBki9FTiEUVMuMQD4Ue/1cjWkP3kbZVxgEQKcTwDplfRrH/8qca2HsdjhKL2uhrlWAVzkdJbUMca4RyzS8EZQWxn6n8+snXhbRhUx/v1rkv+i2NkvVs5UGxZtus+809ksQpEdm7qipdcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyXb7cs+oNVXUAxWalTF9Spdwe5PNZS19TD5GM9OUNo=;
 b=RqzY/6ZnztDONKwZ8o1iEGLRdOagD6EAhjDQCqAviUH1qAT138jIIcFqezCS6Jk+EOUhzK+FNKzjTU/rI5Kti9Y93Y50YPn5DIP4S/ByabMoKHiSSpGPbl+neMG6t5q0nSeUGlhxXNVWCsoswjm8X6nGayiAXFABZ17KLTsp+7hGz4rMb8llALyBdWsP14W8I5ALMQD9M1Hk9Ty1XNnp4m2y4XI6px9eNkogTZV7tZmk6T9m721JpuGNkYa09Iqbb10ZWWNRWd6/TGc3NePLcqjTzwRwI1sZSySNXJWUcbpOKHHgbyIGHAYnnf3jeiTbuBCT6gw8kpst/hvZ2+shhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyXb7cs+oNVXUAxWalTF9Spdwe5PNZS19TD5GM9OUNo=;
 b=OGeWovYT0LVgJsfC9qDUeDUSyRzRvg1ZBvatUjJIv7hNvDxR5YJDuKOz4Qgz3ERi/hyUtsvo8ksnczjGLv0yie6uMJZFWIHoveTvZ7h+Kb6pEYxHJzXbgMdnQrKWc8X/UCioAsYwjYDH4PEmwP+K6eeTKZ8Wbc7aPMxwBrFzE0s=
Received: from AS9P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::20)
 by HE1PR0601MB2668.eurprd06.prod.outlook.com (2603:10a6:3:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Sun, 29 May
 2022 06:18:57 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::d3) by AS9P250CA0015.outlook.office365.com
 (2603:10a6:20b:532::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Sun, 29 May 2022 06:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 06:18:56 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V9 0/5] iio: accel: sca3300: add compatible for scl3300
Date:   Sun, 29 May 2022 06:18:48 +0000
Message-Id: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b231170-ae27-40d6-d02c-08da413b1cad
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2668:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0601MB26681C0960A69D6A39EB556BD7DA9@HE1PR0601MB2668.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sx/z3iLe1UrfJ9uKyo1C8i+tlfpeSW2JhgQYhES0zlA+RATetU/XUQdbq9zusB8e6g0c5bIIE960QViJeyNnGOVA9K+1/2usRr9HHu0Olbw+XgYoLbeS3gicuBuE5SKTwVyx4S1782puT06EC+ODuChA8NMzMer2LG4QysqshSxYT0tQnFkZ/yVf92VuWoc05kFDK7vzkPRE2y2T+BbF+k3fZb429BriacX9KAI6BMCz3HZAHFyFfejdUI6a+AtveWFmYe2ioVRpsRlToWn7zMKX3O1+KG0WF2wG+ALHQPQr7eodWr/x6pp3DoiWytoPBgTqB2MVJjup2ZkL0uRMjQFcmrrMfE3CSN+NNRPwUSfBAeYkF6NsMgFHNExKgd14MotgPSqFYixo3DbwrwniOjlLwx1aQgOTFeOPpRKzWGupJeq1foIx6CUcimBJo2CXS5Q8BcHU1WTeNkH9L2MA3uyYsoGwVN9sfhRpLrnrjk0aWHDFOXYcQGm92SliUiUufUxllQNIC5XWFwLNWixuY8Voa4iuxXrmkLFBidncpgF8o5bYPgAK5JULAr1KQy9U4NTH32qZqJERxPHjOEnj8CzOiz9ziajXxtHv7uyHhap9jV0+DX0lsLT7pJuhgBhv0IOWz27m/V6bdscssrngbKJJUq4u8hobiiDsSWEwl2npu1WsMoI1jDFE4ZT8NOHU
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(8676002)(4326008)(86362001)(6506007)(36756003)(316002)(82310400005)(36736006)(70586007)(186003)(70206006)(6666004)(508600001)(356005)(6486002)(1076003)(81166007)(5660300002)(36860700001)(4744005)(26005)(2616005)(956004)(47076005)(336012)(118246002)(83380400001)(8936002)(6512007)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 06:18:56.4031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b231170-ae27-40d6-d02c-08da413b1cad
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only, modified to support SCL3300.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output, 
the change adds the support of scl3300 and inclination data output.


Changes in v9: 
 - Rename angle to angle_supported.
 - Delete reg_val &= GENMASK(1, 0), it's redundant.
 - Fix typo of comments.


LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 323 +++++++++++++++---
 2 files changed, 269 insertions(+), 55 deletions(-)

-- 
2.25.1

