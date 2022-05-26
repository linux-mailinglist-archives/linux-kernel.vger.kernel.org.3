Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88037535006
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbiEZNeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiEZNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234BD80A4;
        Thu, 26 May 2022 06:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbNPG0EpdVG1N+CoWPw1bBWPwQCn7ki7YmbYE1N6pdknrgkN+VC+5ZAaaBssT4YH0XqNGa2B2kPYhd/ol64ZsKGJuLFK9Vap4iOqxJox5N4xYAo1/xmhV8/IKjdzhBFz3baPJit5inZKpRVaGXbqsKRhVtVlz/XiwlWJSf8hlwLUpQx86uSIBsXnLgit/44N0sZAAoor+I3Zcyok6ZZTMp3Xb5Gvb0kbHvelvZlR+Pd5oaJZDiFnqM0bf0+IDTHF7wvOvJAq0as9v3aRRvKUtnebBRh//ajKLxvAsrE9uB9qYTMN3+ym7lCjftoUBg3Mh3X83UXN5gnmxlQBRI+GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zhS88L53GPj7stELd4m70lXJ4lFFMhXdrK7X9tS5dY=;
 b=e0i+BHDy1+rzU5stNjWSjDEjD4eneSsE2LcB8G0RpSZ1wcbv/UCX9ED0mhZzr1Biq8Rr6/mZmXQUiyIMgOOixz8Arr8nG1HT7tWX8rdOfsG9fqnhDoB0j2Yt1/nAB3k3zH4bsnMx4vUfACviMzz+FimAJfpatzBOuX5Lse0zVHl0jWZ5hRwkCYrP/60jRitCUGtABiSiM4n0vWQoS/K4E9UBKJsMCvctFMJMUcQQH4+IzOCFHvJVeRAY7VIw6CXVh48k3P+4zfnJRczklyZa0a/G8DOZIGAJWGLqcZsUUwyjh1TjTQZGTnQvFmj62fYpwdX4j/TLwy3bN1tlEVG9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zhS88L53GPj7stELd4m70lXJ4lFFMhXdrK7X9tS5dY=;
 b=JDTpR38FSPCjz1vALiNMF/FJ++NXzBUKgilj2sYVqQhdWgN3Qh73Zr8H6C+gSxbhsaDy0uW9oRiK/diyVGWNYa7w1pOGsWnS9KMmzVgEPC8tFHTNHI2ir5Mr1PRLw5p1R4qfaVjR3US/b9BoORfvEBZjSNhRMVM9a03AduSP0OU=
Received: from AS9PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:20b:462::27)
 by AM6PR06MB5928.eurprd06.prod.outlook.com (2603:10a6:20b:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 26 May
 2022 13:34:02 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::59) by AS9PR06CA0021.outlook.office365.com
 (2603:10a6:20b:462::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 26 May 2022 13:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:01 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 0/6] iio: accel: bmi088: support BMI085 BMI090L
Date:   Thu, 26 May 2022 13:33:53 +0000
Message-Id: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ea3a880-3e9b-4132-6c8b-08da3f1c657e
X-MS-TrafficTypeDiagnostic: AM6PR06MB5928:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5928243C94E1252F279E2628D7D99@AM6PR06MB5928.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xf6jIZNLoaUeRH8lYyfs60NkHDYPU5PQz0xQknCfut4EcZ4ij4z3V8q5/Y4VDgWClBXs2qNL7UCnfN58zdypsJS7l0Hjd59coNEfmoy2gCjDQBSy+g7ZG9xeOsiNMxA53aP/s1tEZ7UuIreWM8HrO/0S1xxPg/qZZGkhH5yFmrrdZd0AkXd1eK792VtCRLbeFlH6MVCzTmpH5ruGh6x6TZMpV20+gowNrqKs2KmeWekJOh/KwmYDN4/Cy32iAtM3D6xalTPJ6URmytGGO6zE2L/NrbGvnvuhr2n6Bx/wwC1H/cWj/WCGrSvsxg3eTe2uKXAYOjoY/BIuiCISrwA6v058lP6fwAhdkwgUuidn5ySHwQVJw7zApqq3Ogwxzg4o3TJWZMcp/fapU6WWHyTm3WuZ+bWJV5ic0nS2YKzk2YIrEgthuF2bBV38B44W/fgfQKNfJzwxZ1jgmYIUeFwAeEoy9QDIpeA1wwgi4buPg0Ot5o9bg4oNuoor7R+VMduCnNJs4xpoOn4OTGBGhT+IFGSWfbKeoHiXyUnwhfcW1+Nj5aYZBQKoyw11cqSfY7six6OpUib4q7FEhG+Ur0whLEgl+2Xko+A1DXQRkR256FDOsxMwlqCpnBPfk9L9JCc0B92OAQvzbI2yphbcVHjXMT66ImUnlTObA7Jva0YvIC98isWT+kl9rGPdpgezN0KfbTKsBiHKQ0nNzFuZm4LZ9Q==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(70206006)(2906002)(6666004)(6506007)(81166007)(6486002)(8936002)(5660300002)(36860700001)(4744005)(921005)(356005)(36756003)(956004)(83380400001)(36736006)(1076003)(336012)(47076005)(107886003)(70586007)(2616005)(82310400005)(186003)(40460700003)(6512007)(118246002)(4326008)(86362001)(508600001)(26005)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:01.8108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea3a880-3e9b-4132-6c8b-08da3f1c657e
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the units after application of scale from 100*m/s^2 to m/s^2,
since the units in the ABI documents are m/s^2.
Add supports for the BMI085 accelerometer.
Add supports for the BMI090L accelerometer.
Make it possible to config scales.

Change in v5: 
- Fix the issue of 'undeclared function FIELD_GET'
  Reported-by: kernel test robot <lkp@intel.com>


LI Qingwu (6):
  iio: accel: bmi088: Modified the scale calculate
  iio: accel: bmi088: Make it possible to config scales
  iio: accel: bmi088: modified the device name
  iio: accel: bmi088: Add support for bmi085 accel
  iio: accel: bmi088: Add support for bmi090l accel
  dt-bindings: iio: accel: Add bmi085 and bmi090l bindings

 .../bindings/iio/accel/bosch,bmi088.yaml      |  2 +
 drivers/iio/accel/bmi088-accel-core.c         | 97 +++++++++++++++----
 drivers/iio/accel/bmi088-accel-spi.c          | 17 +++-
 drivers/iio/accel/bmi088-accel.h              |  9 +-
 4 files changed, 101 insertions(+), 24 deletions(-)

-- 
2.25.1

