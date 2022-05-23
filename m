Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE375309BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiEWHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEWHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:01:54 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on0711.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F855EDE9;
        Mon, 23 May 2022 00:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPbot/If7/7Fp4zx9KvHip/rXN8FvVoA2H1ZpT/7pNW/ZkyLCyb1l5chX5/5Z9GsH7kaWHU0TmPwlHjUS1oCVVYxLWrZQJ2GL4huDnnhLxx8nKBEH0aRgGdHEBoDXWZmiKyXjXvXBNoHNJ3mJcoZYqnm2z+LUzx2a0sFhKsAO/n1tRL7jRxmpuruj4BwnUBDUCyntf5r6BYs8QzeBNe2IVOjVGD4xWwEfSK7oQhCYZPdQMUmpbiUN5/k9Gsyq8EwEs7DyuIA6QZyXx9hojRg1A/VX9bk7r4+cqHXK5T34/L2QkEGA4BijRjBJitmCrXc3kpIX+83AOg1M9xQENWPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64JeaX91Mv5fEqWgd+VSlu1URP574X3Hd0l6gfdOIFg=;
 b=IvkaaKp/jH9hLewtLj4TupEFHKpbmKo7X/42r6DEDFmDT88Yieqd1s5QNLisRiqdKQX1SftcuJHQRXRDsm6YM+JX5KMEKIYqeWqsTy072Mr3YaOdB69j10y5EZfsCviJBp4PGRxbWHerWjc3DUoWNVKASMZkqvGGA/L+KYAO7LexDM1wLZcz//yxsoWMcm0GWdiTWxDnHN4uhQJRcs4axsMNnKLfy0UI5O5xp8mntJzmEFJGHi3/hvDaPiW6OIY3UKyafsZDKKcEyaMZoutBroBmXh5/dD1EKPI2o37tkcDM1dmyM4mXBmy9vYCqeeyW49rZIK9i258GEGJgTL6XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64JeaX91Mv5fEqWgd+VSlu1URP574X3Hd0l6gfdOIFg=;
 b=LqBrymyyPT0W0trU1E5U9R1WDilhjXmSFAbfopLWuhCmvm7ISaCYFge8xVDDYfsPbQmLfecaleaWuDtr+kvv7gYwVM+jH6XQGzXB5lpVHyiUtbICi0iQxnvWnYeP1NF8CYX0xvzH66Tv/JyN+1MUSg/uWchhqR7t5bM/whshbSY=
Received: from OL1P279CA0065.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::16)
 by AM7PR06MB6360.eurprd06.prod.outlook.com (2603:10a6:20b:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 06:23:16 +0000
Received: from HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::d1) by OL1P279CA0065.outlook.office365.com
 (2603:10a6:e10:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Mon, 23 May 2022 06:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT087.mail.protection.outlook.com (10.152.11.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 06:23:14 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: [PATCH V8 0/5] iio: accel: sca3300: add compatible for scl3300
Date:   Mon, 23 May 2022 06:23:07 +0000
Message-Id: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 13614303-5e8f-46c6-90a4-08da3c84b868
X-MS-TrafficTypeDiagnostic: AM7PR06MB6360:EE_
X-Microsoft-Antispam-PRVS: <AM7PR06MB63604C3DF480EF72318E2731D7D49@AM7PR06MB6360.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0UfFhgVgfmU3aqk/K5/q9JtqJPnKHKrFfD0Xh0oI4pqyv4Oidcok8OOf04Sld75CYQEkv6K8c1IiewmdAvwKaCJc84Npnw8b5Y3kOO4xH6MDcmwxMXfJX/NWWUktN0r39KwjorcXIkvBWR0C5RHxjhVEL42RDZwzkbImyueLH32pHBoJ32bcRl2Gy/+dpsL2qVuNYMd2iAsCUIqkauJC1J3uqrBxmnElkfCkkoNj3cd8wAWzXrAZ8UvUsw4yzVWdxy59Vo/EefBNMpSFULQbwE+RelgjjR9EXlqDm1ESHPZD99I7lH0gF7ikubYyYBOjlN6YejlxaalmTaZ26k5hZE9lsOu4th9P+ifYFGn8OVkfEXM8QOaujBu1cKEXGiSHSwFCdyR/K77+JkUNa4KxWCGQKyYSURr0eIWZPDJjVfJytPpI1nQuhfVceQKLfSgWpIJ3OSw///osJ/MExJxcx9PUU4extSOzac2kN+IyY7P84xnWWtL5EbxLO9ngZAoSWs9bf3cqRr2+6aYlP0HZvWrmkGm9CPoQFyAQbOOd8b5m7EH3CRJb61+Ju/FO65kGQUe68Kmp693WrbV6IYPvOiybfnt85oN4DSyfGsuq55pB2Mdxrfg9RVtPHdIwZsKiZ8pfRM/YPbEDVDnTMAMMSDlLc3uQrSg8dOXlEAUsnnENE2d1Kt19W+LhilKhVE0
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(4326008)(47076005)(70586007)(70206006)(83380400001)(118246002)(81166007)(36756003)(36736006)(316002)(6666004)(6512007)(6506007)(2616005)(956004)(336012)(26005)(8676002)(186003)(1076003)(4744005)(508600001)(40460700003)(36860700001)(2906002)(6486002)(82310400005)(5660300002)(86362001)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:23:14.8854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13614303-5e8f-46c6-90a4-08da3c84b868
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only, modified to support SCL3300.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output, 
the change adds the support of scl3300 and inclination data output.


Changes in v8: 
 - Modified comments for the wait time of settling of signal paths.
 - Arrange the line wrap of CA3300_INCLI_CHANNEL.
 - Fix the whitespace issue.
 - Add "bool angle" in chip info for enable the angle output.


LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 325 +++++++++++++++---
 2 files changed, 271 insertions(+), 55 deletions(-)

-- 
2.25.1

