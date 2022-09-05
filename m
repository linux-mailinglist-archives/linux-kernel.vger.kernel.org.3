Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998ED5ADB7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIEWoS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiIEWoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:44:16 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE10E5927A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:44:14 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-iHkEWeOmOsWrWiMPGgr66Q-1; Tue, 06 Sep 2022 00:44:11 +0200
X-MC-Unique: iHkEWeOmOsWrWiMPGgr66Q-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0871.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Mon, 5 Sep 2022 22:44:10 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 22:44:10 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     linux-gpio@vger.kernel.org
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] pinctrl: imx8m: kconfig: Fix build error on test compile
Date:   Tue,  6 Sep 2022 00:44:08 +0200
Message-ID: <20220905224408.346425-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR1P264CA0008.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::13) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ef7be02-5a7f-4d9f-8329-08da8f902630
X-MS-TrafficTypeDiagnostic: ZR0P278MB0871:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: lNuTHtpMfwN41SAWD6dhi+z3hbv80pZ68AEGEFsZO0nnplVKXgIvVkL+EIRosrhgvCcixJx+/fkggyHmPt/gfFVufvdcSsXilrr6PeLTGzOAzdinq9p5jo653Zj7DlSMAeOvr1YRqkicSHJF0fx4oxfCm9dZpNya3Q9Rsj7GU7uUhPbiMHi0zxmQi0Pf4WmTlM4v8QF1LeGf13G0I7fikOf1/0zdXGEameFn6gG4TH5/i5a6JzWA4izTur3neaN7fClJ7s3MQZ2PBL6MGCfrKmJi3cY1Tv0LgA59PDuUe/aaODzabP1VhkqvSYUi9IlUUSGc/P0fI+xdpHlQoBBhi863JXoShvApm23q1pyJ0vu+p6EQyMn5qI0sbZ35emmiTxmw/ftZORWPSoLeDlUR49pdX9lyIV1QUDTGNbjAZjDRNxyvJOT9RjokoMyEQU93a/zRnofdNU5uqEucFwYgk+cBlB3a8ruozC+1zn5Qc6zfnPK9T66IGfyBAYqLJg1ywyeVzW8zC/Ao5o30YJ3iVPWuE+rBOSm1szmXj6b2cOP55/G+6fdBeF5P2tge6aRrP9jU2NrwTFN5muAD3HT42VONZjj+P3HdWNT5gSRgPeIGAezXn9pxLwNSwr5WFcyxMKKvVYEdBCA/Rve1NQnx+bvW1a5L1A21KEmZ67g8sm/YjsJr2njwxS3IY2Pof0xzfTaKPdp6DOtPFmsRAkJaXbBJX2n/XkEj94xJ209J5N8IknrT0rl2Z6Q4R+mV5y9K70m7budIqsrJ0YEkIIn8WnObeCGCdhPIgUhFbF3tBDlpjEhjO4rc39sOZ2SCvcjB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(52116002)(1076003)(38100700002)(186003)(6512007)(38350700002)(2616005)(26005)(5660300002)(8936002)(66946007)(7416002)(66476007)(36756003)(2906002)(4326008)(8676002)(66556008)(478600001)(966005)(86362001)(6486002)(41300700001)(6506007)(316002)(54906003)(6916009)(44832011)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9xOoS10rQ+vdsBY7EbFETw/tiaR43/1qs30Yk+ZXMetl1Xww2BQIiLnlTQZ?=
 =?us-ascii?Q?Q57gyM4hMsiypB4sDVZVD/Km84YLveRnN9U93Na/Uti5LGnwz6pt9iyA4Ii6?=
 =?us-ascii?Q?sR3bTEUwWCtnGdZMJzKuZa2RA0omuSOMwtyWghvgXd6GT2YEHb2B+4xDK6Ja?=
 =?us-ascii?Q?XpBfeUPvXsPS53lSXGYxORXXDlvwGYyO68epx9VwjkhHzBc1tjjeg+nP+w+0?=
 =?us-ascii?Q?7fCMYJsxLdiwhPQ3q5GVUGpcVjcgDrRs4zuZbCRHozqC5ONrmPdkq6uUPwwC?=
 =?us-ascii?Q?ZfpA4+8LJmrVqjgWg8i3EqVi5D7Yq1/cPtwpuHtDqf3fYy5iOjW151jZb1Q2?=
 =?us-ascii?Q?t4tlp3TFISNq08FrHYytDWTiTquT2AGeDCrIk8YONO6PtGPlBXh1c6hcUoQ/?=
 =?us-ascii?Q?UR/OyqTg7eakNIkmkSKZBLkH8zFu7p2AZAFCzBCujXvDlupKqd0GvCe5k7Ik?=
 =?us-ascii?Q?er5GCX0dGSjGsQTSRxZT58xPGIx9Pcvltuhb6O19nIn/boGV8R3pdf8Peild?=
 =?us-ascii?Q?axQ/iq/ZVo3BQSczE5mnUfxZmmfKuWv+A1ls2DCw0zUP2cbnM6yo87m8iwW9?=
 =?us-ascii?Q?0AJ7K7COWaZxRPIYdYE4VcTomlUEpJqzBSBQPb6jvItMYx61gBcCudjVpFcu?=
 =?us-ascii?Q?QZtrJPXpBcmeYTpVEjSV/9+IkgC84BRIpC+3HtF2Hs933Wwa6Xp2xhjI38eq?=
 =?us-ascii?Q?bBcraYG00cOshZrHzPnC0ckpBrniwxM1Bnmu0CkZBYpbCl62V5I555QsYm6A?=
 =?us-ascii?Q?alGWGwJmr2hKs1S3mybxH5moJgclYDvs+B+SHupMa2mzMmJd0V6WpU/N/LEK?=
 =?us-ascii?Q?cbD9BGzZFOjaD6E1aaHgpAw61rZgwvCKBTW3mIcqg4HzZCwFwdB0lqeMrS+s?=
 =?us-ascii?Q?Gh2uFwwYZSvjBn/wh4At+cuOjAABwyZ5iX2/dktV8JVnuVo7TliVmlPbDo5k?=
 =?us-ascii?Q?/5VJNFgKQHANl/Ge+7YbtKbOPdST0e20LCec731G5SNCB6A2Bj4V8Fls0nwp?=
 =?us-ascii?Q?GTPpsrJoigC8AC8PRcsj0VkB9D1ofc9hfyA7w9723BqrZ5rR0gVr0bNxTVrk?=
 =?us-ascii?Q?/PMIGAj+k7WN1R0byR4bj6R/TXBSWH7kUnnfjqiq3q70YIwNBmKOKWW+6soW?=
 =?us-ascii?Q?L34SVW9AzXIxsI94wvnVX1ihyVV9fxhWFw15YjpUyPsLrfOUH6oj091WRJbp?=
 =?us-ascii?Q?UI/PNW4H+HbPAyfg0DZJkl3BYZ7rRMyJZajLEFHTHHRyzJpzGDAejmY0NlZn?=
 =?us-ascii?Q?nyz3J/weXmja6ueIdX28M058K9Kv8ug7Pf7/+AE+dBTn+MjDQ/9PtrqS8MYN?=
 =?us-ascii?Q?6w10u2zPPXTHjv2SiJ7DKTg1nz2NJdZ0B7Gpwu2d7+82rYOT/rlbpXuiluuX?=
 =?us-ascii?Q?5nmYC1X68ApUy76IHGB7hfjHs9NQLUab167L6B6j6yTyULRPzNLGZckMZCP1?=
 =?us-ascii?Q?Y7Urn2MW6dxpOfvONnJyqXrYmHAPhftBbrZnZd1/YnbxfRWM1u/OgE+ch5/H?=
 =?us-ascii?Q?bhdLy0Cszc6IIuSF8qXORiKte20VIccz3Ne2ZUhF/juE9LxTR94cpsdR7qkl?=
 =?us-ascii?Q?1yJh1C/G9zxtD5LefZy2uvMK7ME6PqAC0e6Tt7P0ApnXDjpQDNMRRyTOdgve?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef7be02-5a7f-4d9f-8329-08da8f902630
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 22:44:10.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeG+5qFEpFzTO9xckiTANSzbL04U09r9HODXAtIrzeg2VKMgGCQcLTqDFKWDhP2JbsdvbHrndyhX4GR2OK1Z7/uHtD4JhDoFNwunI9a8eb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0871
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PINCTRL_IMX depends on OF, however the dependency is missed when selected
by PINCTRL_IMX8M* (it does not follow the indirect 'select' statements),
select it explicitly.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202209050605.fezJUgFH-lkp@intel.com/
Fixes: 87c2a29a6bf1 ("pinctrl: imx8m: kconfig: Depends on SOC_IMX8M")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
Linus: I did test on s390 and it's fine, but the topic is tricky for me ...
---
 drivers/pinctrl/freescale/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 365fcff8e470..7a32f77792d9 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -119,6 +119,7 @@ config PINCTRL_IMX7ULP
 
 config PINCTRL_IMX8MM
 	tristate "IMX8MM pinctrl driver"
+	depends on OF
 	depends on SOC_IMX8M
 	select PINCTRL_IMX
 	help
@@ -126,6 +127,7 @@ config PINCTRL_IMX8MM
 
 config PINCTRL_IMX8MN
 	tristate "IMX8MN pinctrl driver"
+	depends on OF
 	depends on SOC_IMX8M
 	select PINCTRL_IMX
 	help
@@ -133,6 +135,7 @@ config PINCTRL_IMX8MN
 
 config PINCTRL_IMX8MP
 	tristate "IMX8MP pinctrl driver"
+	depends on OF
 	depends on SOC_IMX8M
 	select PINCTRL_IMX
 	help
@@ -140,6 +143,7 @@ config PINCTRL_IMX8MP
 
 config PINCTRL_IMX8MQ
 	tristate "IMX8MQ pinctrl driver"
+	depends on OF
 	depends on SOC_IMX8M
 	select PINCTRL_IMX
 	help
-- 
2.25.1

