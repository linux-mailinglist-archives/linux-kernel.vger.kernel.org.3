Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3104C4E54C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiCWPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiCWPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:05:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn20825.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::825])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0075C1B;
        Wed, 23 Mar 2022 08:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btvg5O3+je89uBzAuoX3DRnNymNhxNE+j1Er/l1BxuxLYcc9wUE4cpOnrMg3ErmrxbgCQIRXAvrXU6LmZps8yWenRCIrpzRNWWkBTKLcokop5rMbX7zCicjBteEc7f5nVEfy94YATCZJeR+2AgE3f+XOyRGDSC87OG1LqZ75qqyPrRiMQykjRGHDQkfjeqvSr42WS8cvjvDqrUTXk8Xhz3R0S2aFmS9ASEBO1KtvwkkHQn8sDzX/r15AZCcon5oPi+e4uDpThxuUm6sFJTBXBoPiAMtJTvzG4Elx2phl2hjsCp2Am8GjjdRqeg3o5uYUOGp/LdatwZl6l98DCLCUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W6QkKh+dyh1iN9kLjJgVijQMiYvRTX4aLQdlxyikd4=;
 b=Mgw1gsWwZrpqTYPZmoZCuJ37eV8GyWnrboVb8Eer5OgqAKUHQoAjWge3SPsgAb3DMbxmA+knI28iHzrTqD0ZwBzkvwcPrti9m8ES/RwTU8vweUm7WQigiuNwsFHAsk1ggvF36AmDI3OzTYxulpHGJ43hTT6sYSDfbeW+ID9hwRy2URnxg5dLVc4ndJD5GHwcwyQbAHwp6fXhpGDfaKRiQ94h1e5ncfENwY/yayr4O0Aa6ua2Ux+UubQT7lSqyNvBq2uuoAZctC9n1CZEaCOWOwAlKiYm+Pzbv+I/2f+G57CQq4xc0v2kTzoTMOwblSuNWVxHHsn7rxnAX+wX0BTFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BYAPR04MB5638.namprd04.prod.outlook.com (2603:10b6:a03:101::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 15:03:37 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:03:37 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 4/7] ARM: dts: s5pv210: Remove spi-cs-high on panel in Aries
Date:   Wed, 23 Mar 2022 08:03:08 -0700
Message-ID: <CY4PR04MB0567F7814A3B72824E324702CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220323150311.26699-1-xc-racer2@live.ca>
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [4auSBIXIdn5ea5r1ZSiNIc0LujmToOjIwwEfq2N9yAzTEQrCWrq9mj6Gwxog26hN]
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220323150311.26699-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e96c8311-024d-4d5f-842c-08da0cde4e7a
X-MS-TrafficTypeDiagnostic: BYAPR04MB5638:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpi0H2GtcTZ6LujYVk+9gli9ONulIqmioecV7LNRJO5HbMmPkcCrxv8sgcpV41E/lU1vjBYkiTEX5qVis6aFhbMqHDGApqUBu26vM86McbOqwBqoaXj3JuFUn6cyl1V5cSyLyvApAsmcvsf9k6dx1fffGlOQKHhRGfK0htKCrWrm16C/h0HKRaaZSoYOEkVWJ2LnKpdOzoyraS2Thycdl5qzcoYlujXwArMuprJIL9qHWlf0eVoSMywwSEDla23hYiWvMIagR4LS1+SNvrxBo2maUKr9xPnzeruIjvqBWm9r7r0O8KFls3zrwFvfc95nIT7Qi8mpKLnyyzdoJMCgYiiidZfmO+2RJmFykh4As0aJJPu3ML3yL1ihNU9iRrt3Jsv8yxkM86ZXdFrMAHT2gVn0QFl15Re6dQ2uL4dCFuKY/DN9ApwrC0s9CHx3cAoBLVACBgy0ctQydCDIMiQWuO+F9o/56rL+HsHbqIeZ86n2HDb0IYL05PioyFCXQCyeryELkqpOLHvj8abcRCGcv7Hdanm25ZQWT+QbZxu7RPF/gVP7A52AXoTDmgZIUWzEWizjLWFpI8T5RXyWPoiuEw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jxU9zn0smX+ekE5DqbMJ2rjVKEbnWsuoOa3ML6/sJVtQdvSNt8Um3dVw3Yt?=
 =?us-ascii?Q?/ARig4QC1FOZwgK1FIqIJrPrUwlfTLv5rT4KwLo5YxiDh93Br59oyEWTrFvJ?=
 =?us-ascii?Q?uyzYrpApmCEtAaefPYrNc3Q5o3zizMqVZ+PGTe2RKqPTmqugSMT6TlLwtQ0k?=
 =?us-ascii?Q?w+P17E3Y1mTeBJiqkDAbhaT6sxUw5EaPXgMtZTSNqCC5l4AMF6yPrR6pCc9P?=
 =?us-ascii?Q?HggoR+ibJZJhN/Pb7RGjc21iGfShHLuizwoJhanSAGD6vvLuF641HsnA35xr?=
 =?us-ascii?Q?bXDkqBlNBQKs45lHBnk7rjOo1uMFPKmglYszUEsi8XRIs4yQqgtUopJO5zBV?=
 =?us-ascii?Q?qFDhinVScP15qJrMdZrFjxDUspIWzobQztcX6kyF3Vs9u0clRJyWFiY9GlV2?=
 =?us-ascii?Q?hucm6wwagu6FvEAoAAYq23tl850GWvWl1cEKw58xxhJlzdyd5Dwn/sLITYDc?=
 =?us-ascii?Q?XXrtzlDaJQ0HnMsW+My8WvtX9j/E0v4i3LqktpftlNqNzmXhhVBgludFDmwy?=
 =?us-ascii?Q?0LyNSvbv4x367A1omXkx/0Nv72V7AXW3CZxRI6Sk0BWIi1eJ+dGVR2xpfM4k?=
 =?us-ascii?Q?8RHE8BTEe7lJWuULWa6tsDtiHW6KtCOTKpqLYNYRIOf/TRicv6hnBqR0PZfn?=
 =?us-ascii?Q?ycXZyieLSTUQWBUR2msNiklaR2cAx71NFxI4JshMckpbAVdLxL006Tm90ers?=
 =?us-ascii?Q?rye48hNpui63y0y8544WS4RFEbYRfM8V78SEVAtwS5/17EQrznMrAMkKjoRd?=
 =?us-ascii?Q?zMAsgOTmZ5y9aIkC+VUPu1E+eDz1drvzH3EkRt7miS6TuP6mhGWXn1IxBcbA?=
 =?us-ascii?Q?E1IisdzpQrMD8spn3T5m1uMNfILSMhEuZcwpVlnCXeFDzdQ5te9cuPEnTVwc?=
 =?us-ascii?Q?C/uQpOSL07SamPvI4DbJG1ElhmKyMYyh3S7hxwoYTofpRZQy7FbJKw2xd6d/?=
 =?us-ascii?Q?kHqRBMLlGYvjarVo27PSTOigDRP5n9/c5IYnvWB1IPxeiXkHWOWee9Fn8Ey6?=
 =?us-ascii?Q?xRbH9U9LS/F7t9v8LDHbUiHYivCFtek1zqkH1Fg8F7M4dq/espjJkDmUWBe5?=
 =?us-ascii?Q?nWJO4PjGJm9auIlkJWQtD++U/c9XVCEipNZJaLEuw1XdnFfK4WtPZo5AAXqy?=
 =?us-ascii?Q?nYaQlSPcCj6gUWTiKFlYottGiR2FsbMWRJSJpSsSQ98pSycxKcXZZfWce3Pi?=
 =?us-ascii?Q?taDjeG1WQH65Adq1bVCuzISAQTWOkdMlZ1A4Gw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e96c8311-024d-4d5f-842c-08da0cde4e7a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:03:37.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5638
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 766c6b63aa04 ("spi: fix client driver breakages when using
GPIO descriptors"), the panel has been blank due to an inverted CS GPIO.
In order to correct this, drop the spi-cs-high from the panel SPI device.

Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 503b5a50ef1a..b5d625f12132 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -572,7 +572,6 @@
 			reset-gpios = <&mp05 5 GPIO_ACTIVE_LOW>;
 			vdd3-supply = <&ldo7_reg>;
 			vci-supply = <&ldo17_reg>;
-			spi-cs-high;
 			spi-max-frequency = <1200000>;
 
 			pinctrl-names = "default";
-- 
2.20.1

