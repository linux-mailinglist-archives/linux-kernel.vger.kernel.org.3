Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374D56B9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiGHMoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jul 2022 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiGHMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:44:04 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E4D22DA8C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:44:02 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-VF_sHnICOP-Bni6T6PwiGQ-3; Fri, 08 Jul 2022 14:42:37 +0200
X-MC-Unique: VF_sHnICOP-Bni6T6PwiGQ-3
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::6) by
 GV0P278MB0353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 12:42:29 +0000
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::60ab:6866:72d4:904a]) by GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::60ab:6866:72d4:904a%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 12:42:29 +0000
From:   Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Date:   Fri,  8 Jul 2022 14:42:04 +0200
Message-ID: <20220708124205.59564-2-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
References: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca966cf5-4b02-46ae-fe1f-08da60df51ba
X-MS-TrafficTypeDiagnostic: GV0P278MB0353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: UN4TrC51Bc0E5+ko0olgY9dUevSQusbN6fcXcZjF8XQnv2zzN+2DRCTbl/JNR1opnv31cK5CHRU2mYAhO9XAQZykTy6g2Ushkq3hTXWd/SDismHkgH80mjG+iYreU+Bucaj9A1onisvVzGIDAu0frwF5dH3f2za1NfH/nCgEhlm0ygwfl3098DF9R6T0WAiCtjvI9jW97do8HN2jmv3z0XTsaQsJs6ii7o8iZHtYBAf24t6n1FUy6NWVYi2KXL3u6kZER4/+OQ2Kd7fApvWs7DgNmUZIMlSyk5edsaienOESS+HZMnkihgxwV6NuQEFgkS2PAc/xEM6Z6QLbe/JFxkKDfo+5sN2E6UkevhgbTnv34DIFKbRrNT1tT7c+wy6r0hc5SLSE78zfoQMN2H+UuksDCOMPaW+DuE3jv2t6gKXainW5YZbY6WjpLYYzMaRlSMooI0frrFua4ouF/oUdp/fTmgmb5qJQeol4gwsTjv8KL8qo1YjJRqMXMbpjQtIRoeCZ4mo5/7PhrD8WCYfqHymX1x2x4AfcXuDKhKtazM4AgxccNnCpJcrb/ynhuaKkR+ncGYwYFismF4gG+ZuSNfq8uK8eFC63XdpMtjykOjYXLwTTZxk2qygJRGuaWRlY8lqE2fs0E0klI2Dz5IZSqbfqfKE+sWoDiEYfruj6je7/NPbNSF4q03K+HaenQSbX/5Slqv9SFo+0mvtBv7BdqBeeQwJCaT252w+7fGWtlkjbIigDVb9AxmJuzza6LB/chhtMa6lgoMQshAAwiyl7xF7Po2xVWG9Rf5Q4Zd5subKdiV50pRAtVkBpmtmaGuL8gRoYCIglwEW3OWtZ4Jqq5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(186003)(83380400001)(38100700002)(316002)(110136005)(54906003)(6666004)(44832011)(478600001)(8936002)(86362001)(7416002)(66946007)(107886003)(8676002)(6512007)(2906002)(2616005)(5660300002)(66556008)(1076003)(66476007)(6486002)(26005)(15650500001)(4326008)(52116002)(6506007)(36756003)(41300700001)(38350700002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFDtSzS10tznYur+efY74WQYGecKvhRZmFW7iyn4S+ukWqC6jjfG5sBg5Dlk?=
 =?us-ascii?Q?XtThn6fjWHFz3XAms0/VwaRCjmxHrYpcuZiI/ZGIehP25dHmyVLKPNShPmJg?=
 =?us-ascii?Q?b+6xBlA+PbfxmIsJXJ74Wx9EzWQwOof98VRzujD5eXGo1epni+cuzjvuDB2v?=
 =?us-ascii?Q?0Pu/QrjK8BNganlV7Jq86+QzGSD3LlmV+wl3rWu2GxatEybvpPuJkpqkdP/n?=
 =?us-ascii?Q?t2O2uwZUu1hTEwWefWxjatTSXfuhj4yM9XkQcTYAO/A2SLOqKNeJW3ie0xp0?=
 =?us-ascii?Q?hykVY9M06pFcCR8Ney1TaxbMGs+SMEFgDjh/zsxJrvzOPfh3LrkctVHZF6ep?=
 =?us-ascii?Q?wFiO2y4arGzzuf3p7QKrAakOIDEoJ4OhQRW8XXOA56D4SXRKzQvpAEtc5Bee?=
 =?us-ascii?Q?gV4AfJHolkhhjb+ovT0G/8E56+j9eQVfzD67fX8LQYkYiAW001sJKLwi4bZd?=
 =?us-ascii?Q?GhHhYzScuDtIkl2CEQKDtMW/73T0MqqJ7EjbWIsCjpD2jQSJCdvGMTtCF+2M?=
 =?us-ascii?Q?nQtAD4T+x3kva8k4c0m8L2ZHcpFhA/1/77o5umBIo1tHH1jRVgSvieDo9UwJ?=
 =?us-ascii?Q?sKfK52ZFCm/NwpMeXxNRDuYWrHGGRkCyOXLVaF58lkeSdSB46UmgDK05FGRB?=
 =?us-ascii?Q?AayP2u7Rfqs5qUcVwO9S34rpUAuwtNSV/vyVvFabgcWceGeWE8pjEUg0FMRe?=
 =?us-ascii?Q?rsYaSLrkiIPaqr0tUblY3efs7ebuid0t/9OLC9BOggJivYrlQagk+61U3rHr?=
 =?us-ascii?Q?PfISvFd916HFkv0lAUVd4ZwbojhDxBtt+dHMPQaWXBr0IhEyB+HR/omUHJms?=
 =?us-ascii?Q?AR5SVPmQTNM5P07krdJ6lO1SF70g7thbpXIxirM31ETqwAr8dTd3lZSgyHRf?=
 =?us-ascii?Q?0WuOeWANAhVo9g/AvWCGKPW9wF737pz5AB1rR9GveGsHQXp4YcY5IOkwz++1?=
 =?us-ascii?Q?ZyPl9N7RgyeFOA7SoqqTrXu5iA5LdIiAwO7nFcv5ZhHxbHs3GuQXUSLqqOVK?=
 =?us-ascii?Q?WRrJg5mdIbAX/qSs3rBd8T2N0VsVm3A4UTj97/iYPluB8A21KJs+/uwFvsYf?=
 =?us-ascii?Q?EVuNC063dIebJi4BZGPH8bKr+EqWC2muCudWfjDdk4H4Imh/S4Vbg2fZ8IXc?=
 =?us-ascii?Q?yna2mxY1toTZ7fQ7XzymUe6qGdJ/YN18aEBcRc3d58sWlVYS7EWOqGh4S761?=
 =?us-ascii?Q?JMZruKaxUboDFZNZ21f12ScZSO70ELXUz1oT7olBvexMt67Z1r2l/NTsEgY/?=
 =?us-ascii?Q?4m7O/+ydso5rRhapyHYJ0AdhHB2cjzhrHPkbAqyEhLgeRwVob9QO50PlyJk7?=
 =?us-ascii?Q?oO5Gm8gnp2wxJ1EAmAW9uMdVqvSJZB0mQFdYDgXzqYZ/aNAlqPnQATxZgYAv?=
 =?us-ascii?Q?l1KAKjrAJKWGH9+qoPWOXwkEqAfgLsirHDQ0HIoXVovOm5WPuSDyG25PuSAr?=
 =?us-ascii?Q?oN/mUXDYXux5d1UU9383BGXnPRoI1m3L4EHkcHkkv6Pr9u7IUYTOrgQ/dSnn?=
 =?us-ascii?Q?3JTtGQrUaGfU8jwZhyELxFtCv4Pb4thxkpa5IAO5oRqjyAWOYCwO/lVIDqcZ?=
 =?us-ascii?Q?KqgkqL8vW3v+oDCNOTIjoXyOYWHoWiGP2iA3mJfMHpYee5Kba8lXCntmMdWO?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca966cf5-4b02-46ae-fe1f-08da60df51ba
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 12:42:29.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oJdbExc/+xg0cDGeYDANMv1uNNSUGObja8yVyiEvm4OflGo3cKtTaEtn+RixBZMN9LP4hN0ERIWIOQoufjdMeM2YrJUa/8NHrm+YQLsHh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0353
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=andrejs.cainikovs@toradex.com
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

Update SPI CAN controller clock to match current hardware design.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index eafa88d980b3..2841c6bfe3a9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -32,10 +32,10 @@ backlight: backlight {
 	};
 
 	/* Fixed clock dedicated to SPI CAN controller */
-	clk20m: oscillator {
+	clk40m: oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <20000000>;
+		clock-frequency = <40000000>;
 	};
 
 	gpio-keys {
@@ -194,7 +194,7 @@ &ecspi3 {
 
 	can1: can@0 {
 		compatible = "microchip,mcp251xfd";
-		clocks = <&clk20m>;
+		clocks = <&clk40m>;
 		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_can1_int>;
-- 
2.34.1

